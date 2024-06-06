import 'dart:math';

void afficherGrille(List<List<int>> grid, int size) {
  final stringBuffer = StringBuffer();
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      stringBuffer.write("${grid[i][j]} ");
    }
    print(stringBuffer);
    stringBuffer.clear();
  }
}


List<List<int>> genererGrilleVide(int size) {
  List<List<int>> grid = List.generate(size, (_) => List<int>.filled(size, 0));
  return grid;
}

bool verifCaseComptage(List<List<int>> grid, int size, int x, int y) {
  if (x + 1 < size) {
    if (grid[x + 1][y] == 3) {
      return true;
    }
  }
  if (y + 1 < size) {
    if (grid[x][y + 1] == 3) {
      return true;
    }
  }
  if (y - 1 >= 0) {
    if (grid[x][y - 1] == 3) {
      return true;
    }
  }
  if (x - 1 >= 0) {
    if (grid[x - 1][y] == 3) {
      return true;
    }
  }
  return false;
}

List<List<int>> genererGrilleSolution(List<List<int>> grid, int size, double diff) {
  int nbNoires = ((size * size) * diff).round();
  var rand = Random();
  int x, y;
  for (int i = 0; i < nbNoires; i++) {
    do {
      x = rand.nextInt(size);
      y = rand.nextInt(size);
    } while (grid[x][y] != 0);
    grid[x][y] = -1;
  }
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (grid[i][j] == 0) {
        grid[i][j] = 1;
        if (verifCaseComptage(grid, size, i, j) == false) {
          if (i + 1 < size && j + 1 < size) {
            int k = rand.nextInt(2);
            if (k == 0) {
              grid[i + 1][j] = 3;
            } else {
              grid[i][j + 1] = 3;
            }
          }
          if (i + 1 < size && j + 1 >= size) {
            grid[i + 1][j] = 3;
          }
          if (i + 1 >= size && j + 1 < size) {
            grid[i][j + 1] = 3;
          }
          if (i + 1 >= size && j + 1 >= size) {
            int k = rand.nextInt(2);
            if (k == 0) {
              grid[i - 1][j] = 3;
            } else {
              grid[i][j - 1] = 3;
            }
          }
        }
        int k;
        k = j + 1;
        while (k < size) {
          if (grid[i][k] != 3 && grid[i][k] != -1) {
            grid[i][k] = 2;
            k++;
          } else {
            break;
          }
        }
        k = i + 1;
        while (k < size) {
          if (grid[k][j] != 3 && grid[k][j] != -1) {
            grid[k][j] = 2;
            k++;
          } else {
            break;
          }
        }
      }
    }
  }
  return grid;
}

List<List<int>> genererGrilleProposition(List<List<int>> grid, int size) {
  List<List<int>> grille =
      List.generate(size, (_) => List<int>.filled(size, 0));
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (grid[i][j] == 3) {
        grille[i][j] = comptage(grid, size, i, j);
      }
      if (grid[i][j] == 1 || grid[i][j] == 2) {
        grille[i][j] = 0;
      }
      if (grid[i][j] == -1) {
        grille[i][j] = -1;
      }
    }
  }
  return grille;
}

int comptage(List<List<int>> grid, int size, x, y) {
  int k = 0;
  if (x + 1 < size) {
    if (grid[x + 1][y] == 1) {
      k++;
    }
  }
  if (y + 1 < size) {
    if (grid[x][y + 1] == 1) {
      k++;
    }
  }
  if (y - 1 >= 0) {
    if (grid[x][y - 1] == 1) {
      k++;
    }
  }
  if (x - 1 >= 0) {
    if (grid[x - 1][y] == 1) {
      k++;
    }
  }
  return k;
}

/// Checke si la case est une case comptage
bool estComptage(List<List<int>> grille, int size, x, y) {
  return switch(grille[x][y]){
    1 || 2 || 3 || 4 => true,
    _ => false,
  };
}

// /// Ajoute une lampe dans la grille a la position (x,y)
// int ajouterLampe(List<List<int>> grid, int size, int x, int y) {
//   if (grid[x][y] == 10 || grid[x][y] == -1 || estComptage(grid, size, x, y)) {
//     return -1;
//   }
//   int k;
//   grid[x][y] = 10;
//   k = y + 1;
//   while (k < size) {
//     if (grid[x][k] != -1 && !estComptage(grid, size, x, k)) {
//       grid[x][k] = 20;
//       k++;
//     } else {
//       break;
//     }
//   }
//   k = x + 1;
//   while (k < size) {
//     if (grid[k][y] != -1 && !estComptage(grid, size, k, y)) {
//       grid[k][y] = 20;
//       k++;
//     } else {
//       break;
//     }
//   }
//   k = y - 1;
//   while (k >= 0) {
//     if (grid[x][k] != -1 && !estComptage(grid, size, x, k)) {
//       grid[x][k] = 20;
//       k++;
//     } else {
//       break;
//     }
//   }
//   k = x - 1;
//   while (k >= 0) {
//     if (grid[k][y] != -1 && !estComptage(grid, size, k, y)) {
//       grid[k][y] = 20;
//       k++;
//     } else {
//       break;
//     }
//   }
//   return 0;
// }

int ajouterLampe(List<List<int>> grid, int size, int x, int y) {
  if (grid[x][y] == 10 || grid[x][y] == -1 || estComptage(grid, size, x, y)) {
    return -1;
  }
  int k;
  grid[x][y] = 10;
  k = y + 1;
  while (k < size) {
    if (grid[x][k] != -1 && !estComptage(grid, size, x, k)) {
      grid[x][k] = 20;
      k++;
    } else {
      break;
    }
  }
  k = x + 1;
  while (k < size) {
    if (grid[k][y] != -1 && !estComptage(grid, size, k, y)) {
      grid[k][y] = 20;
      k++;
    } else {
      break;
    }
  }
  k = y - 1;
  while (k >= 0) {
    if (grid[x][k] != -1 && !estComptage(grid, size, x, k)) {
      grid[x][k] = 20;
      k--;  // <-- ici, décrémentez k au lieu de l'incrémenter
    } else {
      break;
    }
  }
  k = x - 1;
  while (k >= 0) {
    if (grid[k][y] != -1 && !estComptage(grid, size, k, y)) {
      grid[k][y] = 20;
      k--;  // <-- ici, décrémentez k au lieu de l'incrémenter
    } else {
      break;
    }
  }
  return 0;
}


bool croisement(List<List<int>> grille,int size,x,y){
  int k=x+1;
  while(k<size && !estComptage(grille, size, k, y) && grille[k][y]!=-1){
    if (grille[k][y]==10){
      return true;
    }
    k++;
  }
  k=y+1;
  while(k<size && !estComptage(grille, size, x, k) && grille[k][y]!=-1){
    if (grille[x][k]==10){
      return true;
    }
    k++;
  }
  k=x-1;
  while(k>=0 && !estComptage(grille, size, k, y) && grille[k][y]!=-1){
    if (grille[k][y]==10){
      return true;
    }
    k--;
  }
  k=y-1;
  while(k>=0 && !estComptage(grille, size, x, k) && grille[k][y]!=-1){
    if (grille[x][k]==10){
      return true;
    }
    k--;
  }
  return false;
}

bool croisementColonne(List<List<int>> grille,int size,x,y){
  int k=y+1;
  while(k<size && !estComptage(grille, size, x, k) && grille[k][y]!=-1){
    if (grille[x][k]==10){
      return true;
    }
    k++;
  }
  k=y-1;
  while(k>=0 && !estComptage(grille, size, x, k) && grille[k][y]!=-1){
    if (grille[x][k]==10){
      return true;
    }
    k--;
  }
  return false;
}

bool croisementLigne(List<List<int>> grille,int size,x,y){
  int k=x+1;
  while(k<size && !estComptage(grille, size, k, y) && grille[k][y]!=-1){
    if (grille[k][y]==10){
      return true;
    }
    k++;
  }
  k=x-1;
  while(k>=0 && !estComptage(grille, size, k, y) && grille[k][y]!=-1){
    if (grille[k][y]==10){
      return true;
    }
    k--;
  }
  return false;
}

// /// cette fonction retire une lampe qui est a la case (x,y)
// int retirerLampe(List<List<int>> grid,int size,int x,int y){
//   if (grid[x][y]==10 || grid[x][y]==-1 || estComptage(grid, size, x, y)){
//     return -1;
//   }
//   if(!croisement(grid, size, x, y)){//Si y'a aucune autre lampe sur la ligne et la colonne on remet toutes
//     //les cases colorées de l'allée à 0
//     grid[x][y]=0;
//     int k;
//     k=y+1;
//     while(k<size){ 
//       if(grid[x][k]!=-1 && !estComptage(grid, size, x, k)){
//         grid[x][k]=0;
//         k++;
//       }
//       else{
//         break;
//       }  
//     }
//     k=x+1;
//     while(k<size){ 
//       if(grid[k][y]!=-1 && !estComptage(grid, size, k, y)){
//         grid[k][y]=0;
//         k++;
//       }
//       else{
//         break;
//       }
//     }
//     k=y-1;
//     while(k>=0){ 
//       if(grid[x][k]!=-1 && !estComptage(grid, size, x, k)){
//         grid[x][k]=0;
//         k++;
//       }
//       else{
//         break;
//       }  
//     }
//     k=x-1;
//     while(k>=0){ 
//       if(grid[k][y]!=-1 && !estComptage(grid, size, k, y)){
//         grid[k][y]=0;
//         k++;
//       }
//       else{
//         break;
//       }  
//     }
//   }
//   else{//Sinon il y'a au moins un croisement soit sur la ligne ou la colonne
//     if(croisementLigne(grid, size, x, y) && croisementColonne(grid, size, x, y)){
//       //Si le croisement est et sur la ligne et sur la colonne On met juste la case actuelle à 20 car elle
//       //est éclairée par les lampes du croisement
//       grid[x][y]=20;
//     }
//     else{//Sinon le croisement est soit sur la ligne soit sur la colonne
//       if (croisementColonne(grid, size, x, y)){//Si c'est sur la colonnee on décolore juste les cases
//         //de la ligne qui étaient éclairées par cette lampe
//         grid[x][y]=20;
//         int k=x+1;
//         while(k<size){ 
//           if(grid[k][y]!=-1 && !estComptage(grid, size, k, y)){
//             grid[k][y]=0;
//             k++;
//           }
//           else{
//             break;
//           }
//         }
//         k=x-1;
//         while(k>=0){ 
//           if(grid[k][y]!=-1 && !estComptage(grid, size, k, y)){
//             grid[k][y]=0;
//             k++;
//           }
//           else{
//             break;
//           }  
//         }
//       }
//       if (croisementColonne(grid, size, x, y)){//Si c'est sur la colonnee on décolore juste les cases
//         //de la ligne qui étaient éclairées par cette lampe
//         int k=y+1;
//         while(k<size){ 
//           if(grid[x][k]!=-1 && !estComptage(grid, size, x, k)){
//             grid[x][k]=0;
//             k++;
//           }
//           else{
//             break;
//           }  
//         }
//         k=y-1;
//         while(k>=0){ 
//           if(grid[x][k]!=-1 && !estComptage(grid, size, x, k)){
//             grid[x][k]=0;
//             k++;
//           }
//           else{
//             break;
//           }  
//         }
//       }
//     }
//   }
//   return 0;
// }


int retirerLampe(List<List<int>> grid, int size, int x, int y) {
  if (grid[x][y] != 10) {
    return -1;
  }

  grid[x][y] = 0; // Éteindre la lampe en position (x, y)

  // Réinitialiser les cases à droite éclairées par la lampe en (x, y)
  int k = y + 1;
  while (k < size && grid[x][k] != -1 && grid[x][k] == 20) {
    grid[x][k] = 0;
    k++;
  }

  // Réinitialiser les cases en bas éclairées par la lampe en (x, y)
  k = x + 1;
  while (k < size && grid[k][y] != -1 && grid[k][y] == 20) {
    grid[k][y] = 0;
    k++;
  }

  // Réinitialiser les cases à gauche éclairées par la lampe en (x, y)
  k = y - 1;
  while (k >= 0 && grid[x][k] != -1 && grid[x][k] == 20) {
    grid[x][k] = 0;
    k--;
  }

  // Réinitialiser les cases en haut éclairées par la lampe en (x, y)
  k = x - 1;
  while (k >= 0 && grid[k][y] != -1 && grid[k][y] == 20) {
    grid[k][y] = 0;
    k--;
  }

  // Éclairer toute la grille en utilisant les lampes restantes
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (grid[i][j] == 10) {
        // Éclairer toute la ligne de la lampe en (i, j)
        k = j + 1;
        while (k < size && !(grid[i][k] == -1 || (grid[i][k] >= 1 && grid[i][k] <= 4))) {
          grid[i][k] = 20;
          k++;
        }

        k = j - 1;
        while (k >= 0 && !(grid[i][k] == -1 || (grid[i][k] >= 1 && grid[i][k] <= 4))) {
          grid[i][k] = 20;
          k--;
        }

        // Éclairer toute la colonne de la lampe en (i, j)
        k = i + 1;
        while (k < size && !(grid[k][j] == -1 || (grid[k][j] >= 1 && grid[k][j] <= 4))) {
          grid[k][j] = 20;
          k++;
        }

        k = i - 1;
        while (k >= 0 && !(grid[k][j] == -1 || (grid[k][j] >= 1 && grid[k][j] <= 4))) {
          grid[k][j] = 20;
          k--;
        }
      }
    }
  }

  return 0;
}

bool isGridCorrect(List<List<int>> grid) {
  int size = grid.length;

  // Check condition [1]: no white cells
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (grid[i][j] == 0) {
        return false;
      }
    }
  }

  // Check condition [2]: correct number of lamps around black cells
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (grid[i][j] >= 1 && grid[i][j] <= 4) {
        int count = 0;

        // Check cells to the right
        if (j + 1 < size && grid[i][j + 1] == 10) {
          count++;
        }

        // Check cells below
        if (i + 1 < size && grid[i + 1][j] == 10) {
          count++;
        }

        // Check cells to the left
        if (j - 1 >= 0 && grid[i][j - 1] == 10) {
          count++;
        }

        // Check cells above
        if (i - 1 >= 0 && grid[i - 1][j] == 10) {
          count++;
        }

        if (count != grid[i][j]) {
          return false;
        }
      }
    }
  }

  return true;
}










