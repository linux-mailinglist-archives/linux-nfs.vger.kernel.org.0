Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B117931A7DD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 23:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhBLWjy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 17:39:54 -0500
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:43555
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232289AbhBLWhs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 17:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613169421; bh=apm8AzF0gYGbPuLC9+fTXsieL+2AvLMt8hTftv35XwQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=GaFZEe+IkdE6dkYDUiBzbDARNimrPdGV2f8Q23KOICEprZwt03Pgb9Qj82ecBzRpw5xF6Vmft/i3L9zTVclJvkLT2jo6fJbuN0hibqfCWHULDHKK0cWNeEplnwiKnn0qCv1Dy1FbzwOakDXCu+CBr1KbL1D3wUa3AfwRkKflNPnw0ImcwDP1WiKiNnnsnnzCAH+wAr8NhJPdWFdjYI8zOtDYukMw0xgqfQ19TX9Wudnas/wlfy4YUizbqoqA2VybFg6z5Rls5rKivakqibKxlckXC9f0BfLFTNEWp9+g4zpHCbtd7douHEVG58jZaqggZrGdZyBIJwMYscEsK8U70A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613169421; bh=yoCDmnA4LkD0rsQStX6aSPAYAm1QOENB+1qU80htytA=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=ZF/GSXq/bjYwzPbOmKF+vRAttkJWHK0KesRSVt6zw7CdxfLnFrG6BI/JHd3HS1RlWj1iVyzeZ7D+iukUUGKrbGEYm5XDlVixKDKgDAkeBRMb4+BVuDjJO6GryxKUPoFIyV6syckUmUJ4UqNUmjAH+xGrwltoBQmD78Dlx8ZHer6wUmG6t6kn7Dh3ghTymInPbhVhWqi7P3K6ZN6aHYLLAvNWXdsT7GJLrwHGlLkUTYU6kV422hCZYGWqmoUtS2bZ/94YnhthQWLcLQSv+Cr0RzSyFIELcyg/XxIrKvdktvfrIBahoaHQc0TjJC8pC1mNWpIIr6lWfa+FeJtyAQ8I9w==
X-YMail-OSG: j36hRc4VM1mrcnjEkT1qKwoticdoOpvGiR8K.OnSJk8AdAc90byQQHK51QsPCT1
 LurB4vAD5Nl9CDdZlrWXn9O.mERhcsYcFGSlH_vwnfgSnvcBn6ZgttO7Mn1HPi.bmL54VbA37yv5
 K7O9NMQ7k9PaZg9T.menODDwx8y3Kq7Ykm6UJZKqqFJuYUZ6.fX_0sLB9uhFddjwvdYeqWAaQWTI
 _3fTsAWq0zSmYmNcyKPD4rH1A_dtMZYQpzQ8GIfzc6VWLjP0tmzTdL_oXnJMSioHfVewJ5peUmby
 3wUnEA7La53G6f3iuC__hWXu4vxLwdo2RZGX5VDGGrlmmpB8qrvvrMpFXY_Jn2L4o5IQ2kr7RPhn
 Hjzt8T_W8sbRP641Y429NR6uno.N0wLnm95yOCddxu_nsqk6vpMJyAaGgarQK.AfuYOzW2QRGX93
 b67VlQA5BTHsVnOOX3g4e3UX2BNBUkvmSwN07RYyvIM2MPTQYmtTkYnQjBD3WvppVFwhiS8o4Lrb
 3AP5y1kpnE1lRi85agBLMdcVKPWWg5pF3tQyiyC8Gcv5y1CMcU3V98L3SK3SM9ZYknMxAfZsMsiA
 5CnO41Pcq1bhcOPVzb04Y8BVZclFkUUANqZchVqB6txn8B2VSmIZD2a_Ly2zjZz_PJg.wpZWOFxJ
 IXOMgHISbzFFj4WKe.Fo5f1vi0_3bosMnRGRQMZKGNtwiF84OEYbW2HH8oSBGlQZCZRBOKBRCBRK
 GjkvGNfP9RrcM4WTAfpXElNBbqJV8fvhDuqK61Y6vF64LBYvZaWNwu5Ad0Law5B7DFDhGBtH6eMH
 xsDWJDX2ahxiVUkYQdgIS18IAVU2PxcBaeae48eqcWSuR2mPNqEFDzguUsWyXl3_fKLUkGa6qurk
 K31Od7EYUjMPrxJHRDTaR7W2U0slF.sq2_jCT8VTFUsNQS0Li_8gFLABefOOhDeBrBiBFjJm5Zhh
 Ng7CzAmDND_w98l62EgKVY_jGuzGmi5SkQP51hJpl5TDOKqjU9b0UnqVSj_iwzvnyhP3dBVC4CJ6
 MS0dHG5T.h.Ua8DWRsFuwvSuMRUtHNbXdznYaeNj.SI.tHP5j5moBPZKHhb6jdE68qRxW.Lq1nBE
 eNHdkQwWbiF5sPLb3sW0jwMjdib.Kqstb0TCeJKBif1.9qvaDf4xTtvHg8fW2P90d4LwnTmLpePt
 Hz7yP.aO8vBIhYeZu4MSmuyXXcO.FupFt_wNFWxUqaBF8Yix2ilVrpSMZ1Tzi2O847GzKyMBYHCr
 CQSjee4BORn7QEPnWWar08MjviH6Q2sdApxjDZnZ1WEu2plzivbFWZGFpFb_GfOgZMexiFvm3xoA
 dkLa9VER_yu5IVugHsPdY1TuhQYA964dtUDC9somdPGTGR21ZK5oG0kV.rSub9M7n_oAV96tUR6l
 2gY6._5PT139H43dAAR0.jbRPlNCuJ501egswSNP2EzGVlkm2FhRe8dxBaLm0Cjz8N2mVxgiRO9s
 dSYCZhqzRDpyumF81AgBwi6mnnHDanl4qgakIJHLe8v9KxzXglKLgT0Xx84CxoZp2_TpTsptvJU9
 k3MbJEo_kaEMEj04RXSr9uK5E9yIp0ulexvTEYimGRhWrYQm0Si9HeZ5j9Mt4XUB1Mc2uPixOGnk
 2V8ZwJWteN4sjrI55BP9gtwJgjSdBu6WTNgfh9inmbEBfja98qDmlBnA6Mlf6vot7_5b4OIPDSpS
 bl0iU72aSes.dwX54imZoco9E2HwxZSM0GbLtwKPkxqxCwzlLG5ArL9im51MVvJmNDn58xkYgn_g
 sOyDQ8uYutKZLVJ7Fk6JAOpoM.DuRyjyAXBVopPRljCJQzS63QKm1ZEstpz1Tf_M220keiF445iR
 0p8LpbiC7aBwZRFXnsSDaViQxc_P18T7_hYnP8_nckS9zfsaXY0CvWDTJN_rRb.WZqIgH3J1CbUJ
 h63At4ygl7yxuW0bhwH5diMPk5mE_gs6akInf9q.faETR67OHIQ7empdHbAF.7H4GqzUx40nU5Rp
 N.3G7E6pYjr1Olme1KNwHUZ.WlbE8GGRiVByYM7uxbxRpRtvWohEue_JzN41gLsMYx6Wz9PxSctW
 2kZq2EAJS1Os1xG4KIlvIhXy4McpI8G42IOesnVch0uBgWiho3Kk8hM54_gsPWEF4Oz9.thUfrPY
 ssJL_B276fEzUWJxOXwAXjVijsZC.Hm2ZUfXA4324eifCpbSvhDnY1037TQGfaOKZ8Y5r.IkOgr_
 fOv_w8ma93O6uazn9nv4WZVnSDucVLjy0bgacOnNwxXBmlwqbl4Rx09teWaTrODAKeN_psvINVXh
 rbqw4gJBzVwX8N1Kv5t8dBkqf9K0oYuma_tPd9mlsU5oz3WR_sueSgUSSRMFDDdm2sdU8ZSZUULh
 kxn1rjnM23CHlznPR37UxBW0_gF_u9rMJ0Or3HZGxRv1YiADZwEqHkZSnXZZAswNZVb0fFW5dVzL
 _Z.z6P3jLmh9A7Ji6Gg9.KGKRRdtLE88frR_gkHoY9vOvXfMIjOaIqM8GwMjNHBu8XA0GyWnk5Cs
 .Ktazy8n4D1PXrXATlIsav.bF_4PIru_K2w4w3b.qEaU0OXuRLnQG_UtBXSzJcdUpgXUJPD5payK
 eu6oPxBCdQbffCX.4qP2QXLTfGOMFd3iM8SeenSS7cBxToeWuHeQgaqBsRNjRaMWFiAfefh7MCRX
 mm81_6hdQJN5gzbavCFgS3.5REHXQD2.WMphcQRytKnuh1.ZVQKeTKxeB8sF14xZY6tQI65Ldt9r
 xNG8_xJfjWKHXhqtTzdjgXkt9nWw9JSG4DAsFN5zU3_xUZ6uDbsCO5TJslZ_.hoD_K_i1d6yLOxJ
 k7f9B2y.l3.4ATRQTGHLEFEcfQQf6XLofRYIt
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Feb 2021 22:37:01 +0000
Received: by smtp412.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID aaf08c7c3722069a5e0c7edf0499cca1;
          Fri, 12 Feb 2021 22:36:56 +0000 (UTC)
Subject: Re: [PATCH 1/2] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20210212211955.11239-1-olga.kornievskaia@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6214d043-3250-43bc-d668-bc9ffa8c9af2@schaufler-ca.com>
Date:   Fri, 12 Feb 2021 14:36:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210212211955.11239-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/12/2021 1:19 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a new hook that takes an existing super block and a new mount
> with new options and determines if new options confict with an
> existing mount or not.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     |  6 ++++
>  include/linux/security.h      |  1 +
>  security/security.c           |  7 +++++
>  security/selinux/hooks.c      | 54 +++++++++++++++++++++++++++++++++++=

>  5 files changed, 69 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> index 7aaa753b8608..fbfc07d0b3d5 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_bloc=
k *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)=

>  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
> +LSM_HOOK(int, 0, sb_do_mnt_opts_match, struct super_block *sb, void *m=
nt_opts)

Don't you want this to be sb_mnt_opts_compatible ?
They may not have to match. They just need to be acceptable
to the security module. SELinux doesn't appear to require
that they "match" in all respects.


>  LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
>  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_blo=
ck *sb)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a19adef1f088..a11b062c1847 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -142,6 +142,12 @@
>   *	@orig the original mount data copied from userspace.
>   *	@copy copied data which will be passed to the security module.
>   *	Returns 0 if the copy was successful.
> + * @sb_do_mnt_opts_match:
> + *	Determine if the existing mount options are compatible with the new=

> + *	mount options being used.
> + *	@sb superblock being compared
> + *	@mnt_opts new mount options
> + *	Return 1 if options are the same.

This is inconsistent with the convention for returns from LSM interfaces.=

Return 0 on success and -ESOMETHINGOROTHER if the operation would be
denied. Your implementation of security_sb_do_mnt_opts_match() will
always return 0 if there's no module supplying the hook. I seriously
doubt that you want the mounts to fail 100% of the time if there isn't
an LSM.

Also, "options are the same" isn't the right description, even for
SELinux.

>   * @sb_remount:
>   *	Extracts security system specific mount options and verifies no cha=
nges
>   *	are being made to those options.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c35ea0ffccd9..07026db7304d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
>  void security_sb_free(struct super_block *sb);
>  void security_free_mnt_opts(void **mnt_opts);
>  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
> +int security_sb_do_mnt_opts_match(struct super_block *sb, void *mnt_op=
ts);
>  int security_sb_remount(struct super_block *sb, void *mnt_opts);
>  int security_sb_kern_mount(struct super_block *sb);
>  int security_sb_show_options(struct seq_file *m, struct super_block *s=
b);
> diff --git a/security/security.c b/security/security.c
> index 7b09cfbae94f..dae380916c6a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void *=
*mnt_opts)
>  }
>  EXPORT_SYMBOL(security_sb_eat_lsm_opts);
> =20
> +int security_sb_do_mnt_opts_match(struct super_block *sb,
> +				 void *mnt_opts)
> +{
> +	return call_int_hook(sb_do_mnt_opts_match, 0, sb, mnt_opts);
> +}
> +EXPORT_SYMBOL(security_sb_do_mnt_opts_match);
> +
>  int security_sb_remount(struct super_block *sb,
>  			void *mnt_opts)
>  {
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 644b17ec9e63..aaa3a725da94 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2656,6 +2656,59 @@ static int selinux_sb_eat_lsm_opts(char *options=
, void **mnt_opts)
>  	return rc;
>  }
> =20
> +static int selinux_sb_do_mnt_opts_match(struct super_block *sb, void *=
mnt_opts)
> +{
> +	struct selinux_mnt_opts *opts =3D mnt_opts;
> +	struct superblock_security_struct *sbsec =3D sb->s_security;
> +	u32 sid;
> +	int rc;
> +
> +	/* superblock not initialized (i.e. no options) - reject if any
> +	 * options specified, otherwise accept
> +	 */
> +	if (!(sbsec->flags & SE_SBINITIALIZED))
> +		return opts ? 0 : 1;
> +
> +	/* superblock initialized and no options specified - reject if
> +	 * superblock has any options set, otherwise accept
> +	 */
> +	if (!opts)
> +		return (sbsec->flags & SE_MNTMASK) ? 0 : 1;
> +
> +	if (opts->fscontext) {
> +		rc =3D parse_sid(sb, opts->fscontext, &sid);
> +		if (rc)
> +			return 0;
> +		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
> +			return 0;
> +	}
> +	if (opts->context) {
> +		rc =3D parse_sid(sb, opts->context, &sid);
> +		if (rc)
> +			return 0;
> +		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
> +			return 0;
> +	}
> +	if (opts->rootcontext) {
> +		struct inode_security_struct *root_isec;
> +
> +		root_isec =3D backing_inode_security(sb->s_root);
> +		rc =3D parse_sid(sb, opts->rootcontext, &sid);
> +		if (rc)
> +			return 0;
> +		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
> +			return 0;
> +	}
> +	if (opts->defcontext) {
> +		rc =3D parse_sid(sb, opts->defcontext, &sid);
> +		if (rc)
> +			return 0;
> +		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
> +			return 0;
> +	}
> +	return 1;
> +}
> +
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
>  {
>  	struct selinux_mnt_opts *opts =3D mnt_opts;
> @@ -6984,6 +7037,7 @@ static struct security_hook_list selinux_hooks[] =
__lsm_ro_after_init =3D {
> =20
>  	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>  	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
> +	LSM_HOOK_INIT(sb_do_mnt_opts_match, selinux_sb_do_mnt_opts_match),
>  	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>  	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>  	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),

