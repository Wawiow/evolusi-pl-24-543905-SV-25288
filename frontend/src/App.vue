<template>
  <nav>
    <RouterLink to="/">
      Home
    </RouterLink>
    |
    <RouterLink to="/experiences">
      Pengalaman
    </RouterLink>
  </nav>

  <main>
    <RouterView />
  </main>
</template>