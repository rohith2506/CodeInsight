# include <cstdio> 
#include <cstring> 
#include <algorithm> using namespace std; 
 
#define MAXN 500004
#define LMAX 250002
#define MAXLG 19
char A[MAXN]; 
struct entry { int nr[2], p; 
} L[MAXN]; 
int P[MAXLG][MAXN], N, i, stp, cnt; 
int cmp(struct entry a, struct entry b) 
{ 
 return a.nr[0] == b.nr[0] ? (a.nr[1] < b.nr[1] ? 1 : 0) : (a.nr[0] < b.nr[0] ? 1 : 0); 
} 
 
int main(void) 
{ 
 
  char s1[LMAX];
  char s2[LMAX];
  memset(A,'\0',MAXN);
  memset(s1,'\0',LMAX);
  memset(s2,'\0',LMAX);
  scanf("%s",s1);
  scanf("%s",s2);
  char A[MAXN];
  
  int len1=strlen(s1);
  int len2=strlen(s2);
  s1[len1++]='$';
  s2[len2++]='#';
  memcpy(A,s1,len1);
  memcpy(A+len1,s2,len2);

  for (N = strlen(A), i = 0; i < N; i ++) 
 P[0][i] = A[i] - 'a'; 
 for (stp = 1, cnt = 1; cnt >> 1 < N; stp ++, cnt <<= 1) { 
 for (i = 0; i < N; i ++) 
 { L[i].nr[0] = P[stp - 1][i]; 
 L[i].nr[1] = i + cnt < N ? P[stp - 1][i + cnt] : -1; 
 L[i].p = i; } 
 sort(L, L + N, cmp); 
 for (i = 0; i < N; i ++) P[stp][L[i].p] = i > 0 && L[i].nr[0] == L[i - 1].nr[0] && L[i].nr[1] == L[i - 1].nr[1] ? 
P[stp][L[i - 1].p] : i; 
 } 

 
 return 0; 
} 
