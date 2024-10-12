#!/bin/bash

# Definir variables
REPO_HUGO="/home/alex/github/hugo"  # Ruta al repositorio completo del proyecto Hugo
REPO_PUBLIC="/home/alex/github/hugo-toha.github.io"  # Ruta al repositorio donde va el contenido de 'public'
PUBLIC_DIR="$REPO_HUGO/public"
BRANCH_HUGO="main"  # Rama del repositorio Hugo
BRANCH_PUBLIC="main"  # Rama del repositorio para Netlify
COMMIT_MSG="Actualización automática del sitio"

# 1. Navegar al repositorio de Hugo
echo "Navegando al repositorio de Hugo..."
cd "$REPO_HUGO" || { echo "No se pudo navegar al repositorio de Hugo"; exit 1; }

# 2. Generar el sitio con Hugo
echo "Generando el sitio..."
hugo

# 3. Realizar commit y push del repositorio de Hugo (desarrollo)
echo "Agregando cambios al repositorio de Hugo..."
git add .

echo "Realizando commit en el repositorio de Hugo..."
git commit -m "$COMMIT_MSG"

echo "Subiendo cambios del repositorio de Hugo a GitHub..."
git push origin "$BRANCH_HUGO"

# 4. Navegar al directorio del repositorio de Netlify (solo 'public')
echo "Navegando al repositorio de Netlify..."
cd "$REPO_PUBLIC" || { echo "No se pudo navegar al repositorio de Netlify"; exit 1; }

# 5. Copiar y reemplazar el contenido de 'public' del repositorio de Hugo al repositorio de Netlify
echo "Reemplazando el contenido del repositorio de Netlify con el de 'public'..."
rm -rf *  # Eliminar todo el contenido existente en el repositorio de Netlify
cp -r "$PUBLIC_DIR/"* .  # Copiar el contenido de 'public' al repositorio de Netlify

# 6. Agregar los cambios al repositorio de Netlify
echo "Agregando cambios al repositorio de Netlify..."
git add .

# 7. Hacer commit de los cambios en el repositorio de Netlify
echo "Realizando commit en el repositorio de Netlify..."
git commit -m "$COMMIT_MSG"

# 8. Subir los cambios a GitHub en el repositorio de Netlify
echo "Subiendo cambios al repositorio de Netlify..."
git push origin "$BRANCH_PUBLIC"

# Confirmación final
echo "Despliegue completado: cambios subidos a ambos repositorios y Netlify ha sido notificado."
