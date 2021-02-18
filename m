Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44D31F216
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 23:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBRWIO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 17:08:14 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:40060
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbhBRWH7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 17:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613686032; bh=UDt0yL5IIM5sD7BMK5vHVep3dYdjNgdwJDnUv1zVBwA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=jWK5CnSrOLmXJPADf5HVGYQB6IxAAjY9/1ZDDhKRJe5T3NfiHCaqGj5GL4xy0uDOhGbXn9liCzyFuws0FyrEEm5+r1kb546PBX8JhqvjPpODkg5S1/xm1CmnAyZdVQS5R6oCFMSfg3OuU7TQrD+rPBJfQd344HjTUvUxMy5XOPklZ5VX8gzmPlc6oKGrKGtGzI27vCfDU0cinXlxiAf37NanGR1KrRM4JePyTwYuKYHuUQmJZPFgz/GbT71GAxHC/gHlOdSPPpMt4/Xo0WczNf8d/vH45mmegny2WGG3bS0Hq2F+LbkyezmPYUtj/g44NS57UigRezpObaxoOTzUQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613686032; bh=vlihK3jzkFvpsFTesEazUFjeHlpjZwq7B8dWlImLaW7=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=tvGK/30KeavpZcqAwKJtybkePt5crf8a8Q2r6/RIACE0CBUpNwR3pDwP8Q/GtgOihzAz8DjFFB8/eKYSq+54CKcsy+J/hR+3NAHA92mo2g1ndcPfoMonfZ8wikiFFA8Y3QOn7HORUC687ZvS/hqSVjnw/rYCaLawe7XycGmwFBR+f6gxq9Ve3fEW0b+vDBZfHLlo7QUJrZQiP3e+AQBcSYguV8sMYKkQrwdex73p/kW3tVJZSHoZ4ZPLBS4UjBk20NOiVxs3F9e4jqo8JmM4fS2Loy8LiMcDKhXD9xTuPDPKt8HlnwtosKwhwdXT7QAcO91Spw6PCbEjWv6ecKThGQ==
X-YMail-OSG: GscAUIUVM1kx7G_uB9tbm8muG96RWNnwPCDZzAx2l0avIScGwmD2mwwQDhKo3nX
 2a1eNZRfcr0Vb3bKrU9cMirt8KaGtbaE6L8WywYyrZMrQtdto3Z_ZPnbqnXCMxjFmMtGtDcVEuSt
 uEoxP2oS7N1WkvASH0k32KjWQVgOyv02Q4lUY9.TCDvxWwLsTGb_HjhKSplPTTAOlUpxCYy25HQt
 N1bJxyXymxwBKGKXpdPbYX16Ez4tTdc9d7c_c7smGDDGCdwQiZeKJeX279hw.8d0ysVzaJqK1gQ9
 2E8G3pzvdnHZKbEwXExjsY2O3imxi_.m.ZWvsUUpRlffJ7bPkQfBKguoFo5keJqqnkfi4MJc8qDx
 ApS6AzhL3C72zPmbrH8svkO2tzDwWKar_zw_y5DdAfMiqKLCvMjcCq4.qzJAbzMxH2qhBfW_Mi4A
 LvA_Jn1a1UrU.mQWP05pXKWtR8nF4TnrZ72JkReZDLS7tkRhXM9tweaSSxtAIypyT3C5z5FSG4Uw
 7XHO06c0CKtR2HoMC_V0iM59GMxS1wkcpY.9yNmzbNfRFiP1kvWOnj21syQU4c6Uo1TgQ7Xxwn7Q
 Z5POwVBteUIjeODdGXtLKyU6znefoQDpISo921hrx.DmS95ls1iKllYLWDBqiEpg0J72fSQRZgRL
 3qt7mUwCbU4Tz67Ls0sli4oBDpEGRrjBHvoTOEjC8.5tyKTyHeTbfRwTFocOzEWuc6AhMUfGl8C8
 D7pBX0eOfOxR7jUjpxRzkNoniDNC1_3h2YEMaXDvc.1RaTZ6hHiPxNInvPBjNuWvTFn4gzy9B45q
 8DU7CZaV7GjQ9o.u.L2DTDzsfSPq2tIPMgSiZJBz.DQuHDnXvqCQUEkzvCXckC63B_xx8iHyYRac
 MZvwH81Zm7mzDW5AXh7mlPnKX7a0DOzL6xktwiF2Q_sQs1W67scpM7i4zFBwdjKKzqCHZ5dzOVpE
 PC_Zlx7s1tDZre3LWrfJCpVM3lIa1dpDOyx87DCfHpdvoM_MMaRPnAb.PL7gmqDuP4VpO.l.llMN
 K_ppCf.3ZLgYIsJ4p2zJT2qNKWhRaQmbEz2NbdrRgqxo_5GuYlPdah59YOerjp7kwNtZTpG7e.pa
 MlFsXXDvyRxy48aNfn3Lb6D3q9EnbVleOlUDfY89xKa5nS3jqWDxhtlZRtT8fuOyNndA3kvnMVM5
 1_ms_gsSnlKHrc7Jc16F7SnfVrLZoncLAVeQPjpcCOQnGBAH7tmlUk_vZraxwW9MpBxYw2U.R3W0
 Lzip4Fs.l4hydfz_6mQaHci.XTRdfzB.A.3OPsu5V5VAALuMThR8GcgCzqzDM.R4CprOQrMWFN1g
 lEvpHZfUaKDZbQcMwWQdyvXz9FI9hR4AugBpAyngLPzQ47RwDg4a_awFkvQRx7DpmIIncRRGXJud
 GLX2XIgnVhGIC98fmsZSN86OhtkmLd89mrWIPNQkMXM5WJNQiZ8VuOBhsP4vMHY4T9wn5bPmiGWY
 pvU.i2DDWcynLXc8gCVBGPhrJyZjdm8KABCx3bxOCC6IeDvxm.4kRAJhm0ZyDtb0MTh41YXYE2bM
 IDilPkv7AGIHpXwtR2VpY9QXRNVS7KT2n985ed3O1mHECd8V.nBv58R4FhrOIvWR9ThFZOHd2t8c
 m_Q7c5Yg4s8Y13rmCDEnQG5vSWMq1Xcp1nCFz8BE_XIO0mrZeuVZhBN5rZOLCCMRkwNwtR9PPMa0
 NIIRl9WtcAZQ7nf422upHlUvREdVBjetnjVYJ5JTReDXVr1PmpancvKFzcvTeDlxrFApX3UUPHg_
 kqpokMqFZnZUBZkH263qmgse0T212885fZk80HkUFwWPXDRwVxWNEMkjOczVzw2eZtlctij1Hd2w
 lV7S.Y3hNFlA3eK9_DFwzFV8AYM_gnqTRiN4FEGuI.WCAtbchY8DTPz.1QKYJ_QpYf8giUgD4jwC
 yWu4j3ox27iQvOwBnAZohYtIBsn59sf46hC9ITrthWKFluueljMjfNXy21Efi6Mq44HCUfLwPIXU
 fFhmQDTz5xJJ6wYCO4veeIqvaqiWYrlB1ns9NuENYCKeH6C0VvWybzfuJUbTx6uKSaOaDfX9cNg8
 xmjD.jR_PFvvzOysCZ0tLlAKyLxlEVIML9xIdnHMfJQS7qDKmhslJ8kTGWL2sORynYz_K30jPk_I
 A_fyya8yKqT.biUV2REHHvwzAKu4eQsVapOsxGruAFNYPKNX4vQZn.m.WSS6Uzw01.AywUvei2xo
 6FzsguWcUS9EN.ClMK.n5CETwGJAC1QxQq8ps7lDnK1J96Qf.4qf.rLBZzqCLHm5HhcSx4e8UI.E
 i6JipX8mKObkKsI9TCZ908wHV3aupeU7Ed5.11BskTyitjG2q5By.1Y_3GJ.4A2GcHPoFd.OHoB5
 Eoaa56nibP16IV_Vh6YPvR9O5QGpW7Dt_mHyscSeATXf7uyM_zyHXlRfyTzCKinmBvYXkva2KNd7
 q4aOKZvPrlIvrmEboWgzPCr.e1as79C3y85BqArdiyq3ZvYGQ6XpuGc3XFwdPtMp5vE5E7GcxQ14
 .oZPKB9wQGY8uiqoTRVswJEM4cTQuwxpQ0Zib0cAgFaayjlTJRTQ7TrDOFjBL7wXw2LTxdsCl7yt
 roFTl_jJohMKMhssyPbJHM56nY7kqAlIg5AqNeBu7AOb0FE9VXHH.yNwcl9TIkKP_bzsPQJ6Cr5g
 FEHunGSkFhkkETIIOuOiqDnkfHMSd.bb.A0hAc5NIIsZxo.rwFmN6amJMaaXpoq24vhmFDl.JPdW
 dEX4Nju5LfNu62CxvBa2JYOLE8HXqAubuMMgxVhHsFVELff2_mLt48hBciV4Gqx0U9Ro2rj8BFnz
 s8hoewt7sXR2Z6REvInZ7rnTCyCqppIc5lPT410cV7mHgldjd2m67OnB05yg-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Feb 2021 22:07:12 +0000
Received: by smtp404.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 99ad47f80beab95263c5c047547ac38f;
          Thu, 18 Feb 2021 22:07:07 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] NFSv4 account for selinux security context when
 deciding to share superblock
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
 <20210218195046.19280-2-olga.kornievskaia@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7587df15-6f6f-3581-8bae-a648315cfae9@schaufler-ca.com>
Date:   Thu, 18 Feb 2021 14:07:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218195046.19280-2-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/18/2021 11:50 AM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Keep track of whether or not there was an selinux context mount
> options during the mount.

This may be the intention, but it's not what the change you're
introducing here does.


>  While deciding if the superblock can be
> shared for the new mount, check for if we had selinux context on
> the existing mount and call into selinux to tell if new passed
> in selinux context is compatible with the existing mount's options.

You're describing how you expect the change to be used, not
what it does. If I am the author of a security module other
than SELinux (which, it turns out, I am) what would I use this
for? How might this change interact with my security module?
Is this something I might exploit? If I am the author of a
filesystem other than NFS (which I am not) should I be doing
the same thing?

>
> Previously, NFS wasn't able to do the following 2mounts:
> mount -o vers=3D4.2,sec=3Dsys,context=3Dsystem_u:object_r:root_t:s0
> <serverip>:/ /mnt
> mount -o vers=3D4.2,sec=3Dsys,context=3Dsystem_u:object_r:swapfile_t:s0=

> <serverip>:/scratch /scratch
>
> 2nd mount would fail with "mount.nfs: an incorrect mount option was
> specified" and var log messages would have:
> "SElinux: mount invalid. Same superblock, different security
> settings for.."
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/fs_context.c       | 3 +++
>  fs/nfs/internal.h         | 1 +
>  fs/nfs/super.c            | 4 ++++
>  include/linux/nfs_fs_sb.h | 1 +
>  4 files changed, 9 insertions(+)
>
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 06894bcdea2d..8067f055d842 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -448,6 +448,9 @@ static int nfs_fs_context_parse_param(struct fs_con=
text *fc,
>  	if (opt < 0)
>  		return ctx->sloppy ? 1 : opt;
> =20
> +	if (fc->security)
> +		ctx->has_sec_mnt_opts =3D 1;
> +
>  	switch (opt) {
>  	case Opt_source:
>  		if (fc->source)
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 62d3189745cd..08f4f34e8cf5 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -96,6 +96,7 @@ struct nfs_fs_context {
>  	char			*fscache_uniq;
>  	unsigned short		protofamily;
>  	unsigned short		mountfamily;
> +	bool			has_sec_mnt_opts;
> =20
>  	struct {
>  		union {
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 4034102010f0..0a2d252cf90f 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1058,6 +1058,7 @@ static void nfs_fill_super(struct super_block *sb=
, struct nfs_fs_context *ctx)
>  						 &sb->s_blocksize_bits);
> =20
>  	nfs_super_set_maxbytes(sb, server->maxfilesize);
> +	server->has_sec_mnt_opts =3D ctx->has_sec_mnt_opts;
>  }
> =20
>  static int nfs_compare_mount_options(const struct super_block *s, cons=
t struct nfs_server *b,
> @@ -1174,6 +1175,9 @@ static int nfs_compare_super(struct super_block *=
sb, struct fs_context *fc)
>  		return 0;
>  	if (!nfs_compare_userns(old, server))
>  		return 0;
> +	if ((old->has_sec_mnt_opts || fc->security) &&
> +			security_sb_mnt_opts_compat(sb, fc->security))
> +		return 0;
>  	return nfs_compare_mount_options(sb, server, fc);
>  }
> =20
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 38e60ec742df..3f0acada5794 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -254,6 +254,7 @@ struct nfs_server {
> =20
>  	/* User namespace info */
>  	const struct cred	*cred;
> +	bool			has_sec_mnt_opts;
>  };
> =20
>  /* Server capabilities */

