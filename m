Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED03231F1E6
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 22:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBRV6f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 16:58:35 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:34664
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhBRV62 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 16:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613685461; bh=+pUgo9gWSk18PsR4VwPXIyrhVPyl2Z9CdYNctcINHYI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=KYqrKbKEMF2MLJVuZHGHD0H4YD6kjdVPDPEFGCuv2B55uuhf8+krsEI51c5/gqypSuoaN/VRVwJmTm+YKscmp8YZVQgomD5BUr1Gnxj+S9qnK80O2nO4qGmkyc/yRJP8vh8nTlFcBmE0z9aOoZJvTzqFhrVs1kmRStT9sRfvR1cTabCFxd3JUJXNbkT88/FC3FPfWliLaBnCqWNKXUi6DNnmLcwGITKS/jDoFN90BQndmVzAVV1QIBgtbWCIjmtmOLfX4OJcmky9MkKBD+e5LFeex79em5qhdvX2QEiZYq98kCZoAYKCSWwGPfYW384cx0R9wc0y8iStzK6GtD7xDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613685461; bh=8q5c8W/+/q79L19PsHYt2ZoF20EKqWrytvJscVpWD1A=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=ooPvK2HiVeWd7noWBEAoDbmN3FGd6TFNOY1qHcJV7h3KVjhxZ7PJ951u5cntTY+1mRQB2JyNhAbNEpiO0Uz/ipUjgQ/ijLb3X6U291H4SV+cpOz4cYxEbEsb678eNGlOZndwZjEEap9JH6LKkYIxhm/BixXHYlU147ryjSALUvLpslu2YMQSyrMVG/VhKEwL6WXCwK83L0pIYQVgSKPKUFGd4pvzPAQjVhXIBY0OdEkwyQtAG82fLuQKTojnFA13VQSBe7x9c0kCBjO6gGdxrfuqSLZZHI6E+/qLFaLs8wGVizKZrbOb7BZr/Z+etpFr2LcG7RraSMlNVRfE3hrqhA==
X-YMail-OSG: OE39jX0VM1mL.ojDYxDM1tL9n1zo2tSErF1.yugWsEaUda8YaaAtAMCZMjWg.E3
 3aeb6Ga.R8n.i4ANTHpQwxwymEYSr6hVnRCA5v2l4wNFQidPC_YekOIufkM7wAuBHR9mW4Zo_wU0
 qEeO5yMJQiyxBHV4UQxFBa1acdzFKLosnFhPtNfulFuC8a6LkdxvKyze_Pp2NnG_T2M4ekul3RDV
 ia3C.RNKQixyXBwxsyrZsWnrSri4aSlPG.Wc08BVpnNikTkYGgSrKnLG0jDFotgRBp19Alt7Dkut
 G5IKR_F98mlTe8LlmZBMsUySxxx1A3_T74Mhlws1Ilh7Fw8Y5H7ZerH53pyEv9P5g9O18.TUS4OX
 GfuM7STUguUGmxnGZuP6LvulU8sn87VWBtRzC9vHQdfwum2JpBwkUQyXNKv3CLpnKoIoaDEYlq87
 mVrzA.eE5NRaLRtS5N3arjsC6Mxuw0IdbSn2rqDUa9cr33b7QRXfmFcbYXX1E4EONrz.zfYE2g7U
 ThAVgQyxTfdgVKkpCsmZxXIAdIUHIsMyTEEOHMT43Ch5E1km7rdp.wR6XVtQ_OYlC3ZGEjwyjqSW
 YrgA9lzYEUj7d8SAXAdQQ6kfgFZg4OmIaxb5Xr4gazwj.urqi7rcWqjVw.TfhKHVp_rzxehU2e4G
 LQwhxbCqaqnLmBm0wWFgE6kx012i7ReXBE9W3cdMg_kJSyjjACAFfea2Bx0zcvYwH5Ts9VZ6AS3j
 yeo4dVz2J2GztFfdr780GrhCpfNjI0tDhk8XndT5P5DXVq9ib0OEt1AmyXNkbzVoisQGIFEAjgTk
 iJGPcyKxaIuiDqMUGsJiuCy9ncRTgNJFJwcIMFPhMJGn6IW7jbYiDpwzDZXFbVvZxpIt4u58.0tf
 MxLMeSjQmSUKfQSdQ0kAWnABY2X4ZH1Ne2fVtAThW44EHoIRAFDmbFWA.wsDE19dIx.wk5ztd30R
 _aolaFEsnqdqFF.NQCzSXZFNBZHl3YmEePbPS2e6OYj3COje1XB1JoWiLdLu7PyYTdbLrMBMQMm6
 8ynC_kINM9Z.Xh14aTqbSIWxFnlENn19sH85DNiHf8G8v2dOqD5rL9JWOiQ350w1RmMKBwnTQ6Vg
 yU6WrMqFZ2eUcNHQCZS0iy0odQBDCO8ZK5buM0cAaWmrBdKv41K7DOjIQPrGId5gc5D.gkDAceIv
 wx6xPRLviVFjIOFyQWrbT4o.YYJNwjAkeNc0JyI7fnLMDrwHuTJo1G965PkwTwyBdTS4.Vze85IK
 j2a3iSFJhA5GDntlYzQvPLBwLZMCTZYIndXrHby9YpuLXQaVl3OkcNsylsxXXxP06zQKy92yaaVk
 qOdeVf8Bg3b2PJfDXp8VZPJKiVaaTIwp4FAP5k8H25Phc.UfwqsFrT78I1HsFUJVCKIaCSV.mBR0
 bGaqeiFkVU1x3oGPcGg6wB7YU_NhNNNLlLXI4N2pOHr.Vx2WppsVuPqHtT.oaaIdLKAaO7KSmYno
 nA0f_kngKUEte590Elj21xMIBH68UVddjc5TsKlqRb4Ullp09M9.nVVo5BT4hsgJCGjQ16ERhbcZ
 2NtkxiBJXfAF9FJJC94zJ1_h0cVj8Xr2WcYCEsqJtI964y5mRp0E59p23Z0rW5o.yxldUP_nPpWU
 LCoucv2BiIrQzkKumPw2dBt9ZwfDhrw2GnAf6q2cHiuBWNGkkut_Bz_mzUFsOiZ6Zf1ZTdfvJtWh
 Tymdvh.soAfbpNGOj8ljV4lb_Tw6wQ25HkFVnV3I7r81BU62VrjtBpM3JBgnZwP5OIK11a4iySm8
 Al2pko8ABMKNyYYlwu0yCvWWRvlhFa02tujzsJ.nOhmMPebfQvhL1GTa2iNVRl65LOk03yRX8NYh
 _zz.eJGVbD9y4VCED3SDXRWP5r.vX9JHJqPgmnjpQfsVtrMiWTeObsYCex3OC8ikTvE76BeRO3CT
 8FRUCsd7rACqfqZeXO4gB0KB9sqMxwUqW14Eof3I8v7c3zzfc4LXg6Bbw.ujBUsuuB09wYFSl6i1
 KpxhzLzyNNc1CLtxnQyreBEZK0_uUV5.lRGGispcWUWGsmcETuFPO0cc0t7yJ2kgAvV.TRGJGtcL
 fk2S2WxGbN6dH_eoIwVIwTyYfqFKd_Gy5QMgyjSUM8Kds7Hc3wjx_Bat5G79LFF0FWQONP9gRyoO
 Jkm83fd__zxMh8j7T3wby9r7AVuQfbGusDPDeeJMayrInaNgvFZyHoLktYysOp91H7oMSJRtZ9V_
 mDcNPrrOeGZTwwiurRkvu6a6lnBpIkUsjAmzVO6OuQBS4lSwh2pcKjEQNLu642SL4xMM7PSE8oI1
 ZGAwWvW6PK4hyoOCtH4V6qS6rN48YJb62BX2z4ySGxHybxjTmcpdjfNDe7_.URh4Kz9Li.9vzfli
 CgumaCaE9SKtT3DeeS_nqpj85I_PZpk3B14lDDa9kaaB1VgBCna8tT.NsDS6vJ0A2BNTQ0SxZdhf
 4OjDbb.1caVKDwHL6f5.8cxsugy4zg3ZWqJWczzF0SzskcG4lqh7SKZ8GpHiB8e6P4MGVBxUVYdP
 aXwiR83vlLLxyeUELc5OJAQcKmtIj6a3ohrHSTCrjGnq2Z0XEQ0RVg.GxyChiwTxFavz6jW0L75v
 ANJvPqYJ8FfH.ODCqlL7jGLopSNL6Ykm0Q9d8kOaVPFBBtdXDK4FuiDx.72Y1pchPAvkFPInQODp
 SMqQccmcZGij3CEVYBIWiYJezNc0i.orNPXaNMXBFmnirYbuhuMOFcq9P5hZzhXoIJwprnIWHKAu
 f_39hNbtdDAZkuRf6N8NZ3wmusXszb_6yxFgiHAPTskWOJ91hBX.w_.dq4qZt5AejiursN.DEp3V
 UynDK6dD7iu4Jn3dR5tbY1WODnry1T7F2_UPFFMuD0w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Feb 2021 21:57:41 +0000
Received: by smtp406.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b2c7cbad77f22cc8f50474ab7ffdf0f6;
          Thu, 18 Feb 2021 21:57:40 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5742cb0f-cd47-4406-928a-0b5b4063c480@schaufler-ca.com>
Date:   Thu, 18 Feb 2021 13:57:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/18/2021 11:50 AM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a new hook that takes an existing super block and a new mount
> with new options and determines if new options confict with an
> existing mount or not.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> `
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     |  6 ++++
>  include/linux/security.h      |  8 ++++++
>  security/security.c           |  7 +++++
>  security/selinux/hooks.c      | 54 +++++++++++++++++++++++++++++++++++
>  5 files changed, 76 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 7aaa753b8608..1b12a5266a51 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
> +LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
>  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a19adef1f088..77c1e9cdeaca 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -142,6 +142,12 @@
>   *	@orig the original mount data copied from userspace.
>   *	@copy copied data which will be passed to the security module.
>   *	Returns 0 if the copy was successful.
> + * @sb_mnt_opts_compat:
> + *	Determine if the existing mount options are compatible with the new
> + *	mount options being used.
> + *	@sb superblock being compared
> + *	@mnt_opts new mount options
> + *	Return 0 if options are the same.

s/the same/compatible/

>   * @sb_remount:
>   *	Extracts security system specific mount options and verifies no changes
>   *	are being made to those options.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c35ea0ffccd9..50db3d5d1608 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
>  void security_sb_free(struct super_block *sb);
>  void security_free_mnt_opts(void **mnt_opts);
>  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
> +int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts);
>  int security_sb_remount(struct super_block *sb, void *mnt_opts);
>  int security_sb_kern_mount(struct super_block *sb);
>  int security_sb_show_options(struct seq_file *m, struct super_block *sb);
> @@ -635,6 +636,13 @@ static inline int security_sb_remount(struct super_block *sb,
>  	return 0;
>  }
>  
> +static inline int security_sb_mnt_opts_compat(struct super_block *sb,
> +					      void *mnt_opts)
> +{
> +	return 0;
> +}
> +
> +
>  static inline int security_sb_kern_mount(struct super_block *sb)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 7b09cfbae94f..56cf5563efde 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
>  }
>  EXPORT_SYMBOL(security_sb_eat_lsm_opts);
>  
> +int security_sb_mnt_opts_compat(struct super_block *sb,
> +				void *mnt_opts)
> +{
> +	return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
> +}
> +EXPORT_SYMBOL(security_sb_mnt_opts_compat);
> +
>  int security_sb_remount(struct super_block *sb,
>  			void *mnt_opts)
>  {
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 644b17ec9e63..f0b8ebc1e2c2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2656,6 +2656,59 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>  	return rc;
>  }
>  
> +static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
> +{
> +	struct selinux_mnt_opts *opts = mnt_opts;
> +	struct superblock_security_struct *sbsec = sb->s_security;
> +	u32 sid;
> +	int rc;
> +
> +	/* superblock not initialized (i.e. no options) - reject if any

Please maintain the existing comment style used in this file.

	/*
	 * superblock not initialized (i.e. no options) - reject if any

> +	 * options specified, otherwise accept
> +	 */
> +	if (!(sbsec->flags & SE_SBINITIALIZED))
> +		return opts ? 1 : 0;
> +
> +	/* superblock initialized and no options specified - reject if
> +	 * superblock has any options set, otherwise accept
> +	 */
> +	if (!opts)
> +		return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
> +
> +	if (opts->fscontext) {
> +		rc = parse_sid(sb, opts->fscontext, &sid);
> +		if (rc)
> +			return 1;
> +		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
> +			return 1;
> +	}
> +	if (opts->context) {
> +		rc = parse_sid(sb, opts->context, &sid);
> +		if (rc)
> +			return 1;
> +		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
> +			return 1;
> +	}
> +	if (opts->rootcontext) {
> +		struct inode_security_struct *root_isec;
> +
> +		root_isec = backing_inode_security(sb->s_root);
> +		rc = parse_sid(sb, opts->rootcontext, &sid);
> +		if (rc)
> +			return 1;
> +		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
> +			return 1;
> +	}
> +	if (opts->defcontext) {
> +		rc = parse_sid(sb, opts->defcontext, &sid);
> +		if (rc)
> +			return 1;
> +		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
>  {
>  	struct selinux_mnt_opts *opts = mnt_opts;
> @@ -6984,6 +7037,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  
>  	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>  	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
> +	LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),
>  	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>  	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>  	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
