<template>
    <section id="about" class="profile">
        <div class="profile-container">

            <div class="profile-image">
                <div class="image-placeholder">
                    Foto
                </div>
            </div>

            <div class="profile-content">
                <p class="subtitle">TENTANG SAYA</p>

                <h2>Profil Saya</h2>

                <p>
                    Saya adalah seorang profesional yang memiliki pengalaman
                    dalam bidang pekerjaan yang saya tekuni.
                </p>

                <p>
                    Selama perjalanan karier, saya telah mengembangkan
                    berbagai pengalaman dan keahlian yang mendukung pekerjaan
                    saya hingga saat ini.
                </p>

                <div class="profile-info">
                    <div>
                        <strong>Nama</strong>
                        <span>Nama Ayah</span>
                    </div>

                    <div>
                        <strong>Profesi</strong>
                        <span>Profesi Ayah</span>
                    </div>

                    <div>
                        <strong>Pengalaman</strong>
                        <span>10+ Tahun</span>
                    </div>
                </div>
            </div>

        </div>
    </section>
</template>

<style scoped>
.profile {
    padding: 100px 10%;
    background: #ffffff;
}

.profile-container {
    max-width: 1100px;
    margin: auto;

    display: grid;
    grid-template-columns: 350px 1fr;
    gap: 70px;
    align-items: center;
}

.profile-image {
    display: flex;
    justify-content: center;
}

.image-placeholder {
    width: 300px;
    height: 380px;

    background: #eeeeee;

    display: flex;
    align-items: center;
    justify-content: center;

    color: #777;
    font-size: 18px;
}

.subtitle {
    font-size: 14px;
    font-weight: bold;
    letter-spacing: 2px;
    color: #777;
}

h2 {
    font-size: 40px;
    margin: 15px 0 25px;
}

.profile-content p {
    color: #666;
    line-height: 1.8;
}

.profile-info {
    margin-top: 30px;

    display: flex;
    gap: 40px;
}

.profile-info div {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.profile-info strong {
    font-size: 14px;
}

.profile-info span {
    color: #666;
}

@media (max-width: 800px) {
    .profile-container {
        grid-template-columns: 1fr;
        text-align: center;
    }

    .profile-info {
        justify-content: center;
        flex-wrap: wrap;
    }
}
</style>