import 'dart:math';

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

List<List<int>> genererGrilleVideSolution(List<List<int>> grid, int size, double diff) {
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

