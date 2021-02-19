Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED65C31FFCD
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 21:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBSU07 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 15:26:59 -0500
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:43374
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhBSU06 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 15:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613766371; bh=IKuo6OOdcvCBqIRNFVpCh2aYhI2cAAckb5YXBk5ByP4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=WnSnhU0p+Nqxw60pGyjYDg97PdBSLaW503MQ6hhgdlwEUWxgeaPHEaUULIWvDpznSZARu95j705+ijyyb49tDWjNRi9tH5VCrOY8Bh7UrYyUEpbM4wyHl0/RphlbFAjSVUDxNe3pQMjx8ZOp5G/CD+kpkVTgCJmwxgbuz9zFnAHR3TGVyBZx2py4sL/oCpLxiCX+u66OuGJlCQlysESIDQxfr0FrA+GP1ohS4Tm7U3JbAw7ZfWKolq1AEJ0EF+CoBW2xpxYkHAUT/Gx8RHcRzKfa5qxsLD5xYvK+1R0dxWPiMXUKTa/n8RkvNoIBWebyFw9iUB9o1GpoPFghiLYhqg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613766371; bh=EhlzZ2mabVIucQIUaWkqNtaBlg4yTUx0j1jToKtlXbp=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=NYB8y9C9w93NAmtMVAdxo/ygHIuASfSrp5b5Mk6BSU9cjEpS/yiM9Ktb6elkp6q3+4rbuZ5xAfWA4HvRkAwnswk+Zmt82LpSqCaBwXipkoJFusq2U7A9/8nQ07/zK+BPUU3F253eFm9rT642xkJ2diGsGhdp2Kb96ypgZDTKigxIg61iv9w722SWtJ7DCtZRbMDNgd+KfZuB7aF651+iZq5pHHI99Bhj4d3ucVI3UnarjS/C1x/D2w2dMRnYY00oj1+WGcg/xK9E3xL/eo2DSmLV6njzu3nxCvPk3I7P1NkZeXfTof9mdo+XVv0IcjV7NMWKpnjARfyvEEDLI/3+hg==
X-YMail-OSG: 0TKq0g4VM1nLfAIDEPFHpOSrVU3F4rLWeWjzU6tQQ19iUC0YNGTzxdnh_5hfSiR
 oCEHTaXbt3bokIDrI3OKq58wcEpGpTcFhzudKIKcxSuZWwJAqa0kNY8UmC0mWevWWDABAR5sQW4M
 FskvdyrhpYNXUOvdXZl4Ne_BqIEr4tlNJoh_lw8E8Y5ZdEwwCZvmzs2dH234uVehW_Pp7HBiYXEk
 ueVdZhxSlumTZcmpLnrlq4z_j4VTodtzL94H8WVbvE2T5GzFp12ykn4HRzPeqV_ZkQiXZzDHkGPN
 baLDPKKkjdbhS4EMtn9E9Jd2Xm8WL7VDp2Yu9oHzEaGTDcUtAcgdFH6QT0yz0XayUeifAs98yV18
 u6lyRYRBl.2nw0IWJarwX0ao.SpH4sOCmaYsq2yTDw6KG_gQbRTylodOmY92GWhrYRGo3.Xc4wfI
 RC6diQKBQgQCCJEDk5HroLGb0Po6u8dm5Q.NMP_eLfv1JI6yK2KAFpJTs6q2IVv8glIwDhtMoKWi
 6SRAhE33wRMP2RYhyR3y.kVwll4h8Icm_wf.KhzI2_ehMjRFN7fIYokH8B3mW6a6FcQokJf9hIoD
 fh0.8IrqB30OoZLbIbNT7TLL6Ym7GytKU.uB01S0_nOa3EK8kl6qusP5.wo6XXt.yJ.Mbr46VeYh
 Ivabdg7w0hqCIjZ.Vcy3GX0C4mn1O8nmTu1e04nYtEDLn2zkUqf66llW4VFBUWYFGFef0WZmc1y4
 zkHMkTakAoD5z3f8sMODEl5QvTg_i2BwGW7bMHvCGw3EQdDAPjPaIeUxoF3IM3n5n7irOqcORlmS
 64oSEormRqAaDhzNiSTaYmZ5uhZV39Msv8bs4TpKjD2U_DRuCFKX9HZCAv4btXITmKEvxIrUTkP9
 0ycqw4P0s8ecn4gDowFPvhSC3425N9XFSlsEb2lEbsD3H5fIjA73LbRircwFkXtdEAdm3dsX5KdR
 hfNLBhpgw17lehFk5OPiWHW30Q9eFK5kdYtOfFAbm_mvp3bzAYCspajVAo6UwNsfw2lE.xFCvp_p
 Lo5i1ZZpNKTPaA26KMHqnEmZzx7vjzpPlpWAL6n.YPN8Bzox0.vJ..gRUuBBp5l7UNad3O5EhjiI
 aC6p1qSNBduAnDzpoe7c6TrlciBC39lFevSLA_gUEv3VDdgc_voCjIAVb1rY9EKpNI3sXrrYcfPi
 KLzQdEwvvQQ0_xDx79zP8eGYLfusAXH_47_JIWj7_UNcaU41L0mNZuH5vGlO_EqiFw0xT.ysOpVk
 RkyQ.khQRVniy03ejmnmViFSQhqkQxAlKCcvHrRxs01kRpEm38E90WEPQd2N8bQJvgO26T0f5qy1
 4dnpvzPnJQJrsDThUrhehGeVTzjNDzm1viMjCgizUbPdrJnjPfFNlBVc_6yeMTSiUgEOzIEg6ggn
 NQ20RIa39P8Po9gAsq1hlyygwMVx4h9_8q5dwv8ngYGX6eeNeKtgKWsF3WaLaVCjQIGAjuv167MW
 mzXETHgbzzNpoOVJ5B7J75lwN89pIZeo8vA5xKNWUnZGt3nqpvnggiTXtEmIknrxiAXz4NOouK.V
 ix0uSIpkxqpznMm4hJVUE9hHNsNDHm83cX3FKaOBlnRmcNnzgkvmL7m0_MdyCl8BttEl2PUx4Lzy
 RlBrtEo6Tnv.2lUD2ou.aWOstYq.LWnRhnw_0r5i15Q98HDJApOeVjRnXil1BEYPMdG53rYr4rDJ
 48qLT4HdJQ1QLIiU9_hDkdMUeN1v7FeGylFNWakrnnlHtDajJBhaW.ZMbzTVqIzkCtOnrKJGsCyt
 KCsjZ9uPhGt8tDj._GPUVpY0oDHqC4ERWgll_pseM94aSFAREWS5c5UQjziWZMdYnh4GO7YexO7G
 lsxSFkQrdUR91UMSFmZvKFPJ79xBlKY3HQdKddrHezMapfmM1xKg_bCXE_crRYTiAW.5oNSKkv1D
 MrSk.smEIBgaUan6R2rnawYMwkZoA0v.DEwI8t1xHCCVuhVNIKTDm1iAOx.k3vL.sUKF1TzBUFpi
 OKYjyR0NxFoUONzi2u_v2EO6wnI8KfbI1L.3YpL0CBb6FhNvzlJCF4F7wqCpJ.cuz.3og8_Ssn34
 v86Bm4iIP258YlNWJh5jxzlyaqMXWuOLnDcxhAUSy4oFgGTzFMzncB9PvGZrmj_QXTq9JiaE_UBi
 4fsra3Fwc43fdX2vNdb0BnJj1UfJ.iCtpp4AhqBvyb7GZ7K47wde7FIaoROoSacSGKsYG.2Zz6iA
 3bPgCEAeq9XOLN0RBLg.4tvk0LY3So7K7bXdz6v5O9pLj9mhRB3EMHPPOyZMXZw9oRPMFTuFrSAJ
 7UzKxyEfSvKOVxCpbO1UOYsEWFb8xbJ9MwAOV3UwlvAef3MIg2mm9YU4iVGcsq55OA.L7XtCGDgP
 Rr6IiSR1tUkk_spqr1S1K4NUqGIW1eEK_kIj1UVIUvh.VK51qwZdPn2SwPStCv5MLDROKL5IMU23
 bIrS1ZnyFQTVamfmiRAKv2MKQYwz2icjkGlCwNth1Ioud83A0ssVEtaOOkY0TwSEM.rJe_pZ_LaI
 P2ZldfV.34lDEIECFswrwyMX7fKzyqMymKLR9A6p.0U7eJPQhxWMVmtid3.qTge7cbNcyPr3WRx6
 l4NUV_WfE_prRjKPfYCVJ6KgAfr3ugkBBm_LBEdLbUNXLk.gNjtr.tlQXlsZPUEyKzuG4.szhw18
 uqQyMVnbziDtUegClKaKuDvZ_ceAkygfXPpdBoRQk0PwHBu2jjGFX_foHjl7.goNtevgDiZ7clru
 HL61X4OyqSAddN91t77L.nZRUC5Bh90njwwjTduFC8ONEZKUIuSWJDicXvVouRyUFl6GTOSdzAO0
 WOwUQHjd7LTBtamA__N2S0qolojNAQjzEjwURFXEhms1h
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Feb 2021 20:26:11 +0000
Received: by smtp418.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e32411f50db2e330209c3093d2d00d84;
          Fri, 19 Feb 2021 20:26:09 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20210219165715.20324-1-olga.kornievskaia@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <86bcc61a-fdd6-1a6a-d478-c8ce2bc01aa7@schaufler-ca.com>
Date:   Fri, 19 Feb 2021 12:26:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210219165715.20324-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/19/2021 8:57 AM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a new hook that takes an existing super block and a new mount
> with new options and determines if new options confict with an
> existing mount or not.
>
> A filesystem can use this new hook to determine if it can share
> the an existing superblock with a new superblock for the new mount.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     |  6 ++++
>  include/linux/security.h      |  8 +++++
>  security/security.c           |  7 +++++
>  security/selinux/hooks.c      | 56 +++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+)
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
> index a19adef1f088..e2519adccb74 100644
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
> + *	Return 0 if options are the compatible.

s/the //

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
> index 644b17ec9e63..afee3a222a0e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2656,6 +2656,61 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
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
> +	/*
> +	 * Superblock not initialized (i.e. no options) - reject if any
> +	 * options specified, otherwise accept.
> +	 */
> +	if (!(sbsec->flags & SE_SBINITIALIZED))
> +		return opts ? 1 : 0;
> +
> +	/*
> +	 * Superblock initialized and no options specified - reject if
> +	 * superblock has any options set, otherwise accept.
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
> @@ -6984,6 +7039,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  
>  	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>  	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
> +	LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),
>  	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>  	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>  	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
