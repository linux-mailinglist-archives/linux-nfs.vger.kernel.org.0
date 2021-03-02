Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63032B743
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhCCKv5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:51:57 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:44097
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344558AbhCBSw4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 13:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614711101; bh=qgaMXq3MepzUdSISmshqlJxIDGrGpWmnZTDhOMv/VX8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=r5IX6vtp5VD24I2YRxRHgqTXNEruk90VbyCFfsU0JvZYsfX9ISkx/9D4GTqbPNhxRm9HTpryG+v7P27TvN7Opb4NJR3bPOJqvtBl9/wop/4vTNWbeA1WRLcx6CmD+HmPZWFuT/900M6Lzpu3BWo1Y0yQzpNT3oRLcGmgIJq4AGD4pa9q/U2gjygj9eD39GEGMDeekMm2e+ogfPdgPQ4SadrQoAoGdDDf7tMjfgLPKd31dA+P2aALYnLW8GR3G9/cL05WOqgEkbuK54U6clx/sBIftTf6H+COzcMxUWjiEiM7PUajfi3dsUVN6aO7m1aEbCh8b8tY3hFj8FAhqOK7tg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614711101; bh=TeiIFU3CWPQ2k+sR0sSo97hGhakvnm/9ZLQpeFJZjs0=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=b6oTYYm/0xEjjT/09K6xTFmONUvFkHdqCSqQKBNLzb9Gk64db5mhEf7xkuxWmX9jl3WTJhjHNjoSNSVIxvGZALwpCzUK4ROeLWwd7/+2tApyYots5j7cASnV/cZkDCrKcEt2GdRckjjYnnAYJL8YdgK40UDxYllT/1M60N2C5bcjtDBT6C4M1mePKH0suBG8rXs/nd/E7IDvicoIfGJ2+Ykgix88a3BInrevOcfeqqFcfxl3yX0+OSWZhmkXfCYIqSei9lpnCBWPrSn4odPbdAUQkhVIKavclP96pMTEKsoIFiIdir0Lhc6cY2ohIAUvhvGiCmjxykU8GEraCALF/g==
X-YMail-OSG: BzbRTpMVM1lK7LD1V29fiwhyWBrVxYjeRmN7PPSM9pAG_sV7bvWyDWM8_xu7zd6
 uuDoELKiBcTzVLLzOnjcFXfyeLaRVvepXgXrahLgxHE0YNV6OPwTJYsfB42UNSzslCaVaXj2rgmY
 qSwusdOjU.yZKnqGE4hEBUK5dAnUgo0fC1i8Hk5DsEFYPILoAfUiwpsSRc94PZOsZIqAvucB1VPP
 nFk.qAsI8fmab4CDdvGIXZaznnzNkiHNz96C3oQ9cEJ_zGwPiEMUoMq5.fqRAtJW.oBm7ROAtzlJ
 vUBmSVK6L4vZdXUKEsEHIia5D3Lk36oD1NRvF556z6zV1A99Ss1_rGirgulYqJd1pABCf9iZaqMj
 zjDsIdKu4KPwuLQCsOgErfgLuExwhyk.uyWHjy_dRPkv8Q5dP5fFj19HHj6Lrq_9m2Swr1jYFXkN
 lm4zG5POnp867z.tHy1x9uWK1SHWWEim5lU9i_f6_lXI1ACvMsXBM0Issx.smrnDf1IFNQ0GSLRU
 5p6mVzGBVmo5qOcyifNPCfPDkC7rRFy75D78IIr4w_BmCQ_lEca7JBKZj5R9tp9hkXkPwi4zbLYj
 oFS92.Ye2_9cRZ2zIHJvYfs7Lymutf8wY0L1z8PN26SB3ka21xjHcupoY_q7uSQEASMm1LLDZ.Az
 4JJ1YGNrkvgrKnu1b0fZfIy3evnI_vUXEGSvrggwVk5efeGOHCl6JwqEpGOCcIGZs_2rt.7eRH6G
 UuAYKSWn71PIOLhEdEG1y0Z86jBc34q.nO9Bec_Vy8oj4Z5XBKQOo_dh_45BikKmhCgGGeMXsLQr
 v9D.m.uwE.4MiSGbURJMi0zcaqwosayUxM0UlIHRVysRJ2MkuxEaCdNAvYBLSDYerhoCCsjrFSTn
 94EpaPwwkIwRR7RUB.fBZWIwjzRpJLAekQ3MCLrOyYXcW4yuXNF9p2OuU9uAA9lk9hDIjh5Lp.zD
 qT0V9GMVw6rUa3NYywTmiffVUTru0zxwmqL9rfdyOgHQwgI8Gchf9B9yuYnrbuMqW7fS4.r7CzBY
 DBkhgtf1UG0_1uqzth7U_D.Yaln5zjSLHSH2Jl3hWNTiF5qpvsszM.IXlpkM3la6NEYZPg1226wa
 AnqUxiSbq07G28WG4WLvo6XUGzeud8ObOguJjim1rhyMTfrwb8ZmXs7E3c9Fk6RKX2tgwxB852L_
 sl6Oibby6JwRVDfmsBZ769zR8z.Q_Zu5OUWoklatNOkCUQKY1TGbniUPXuVJFud0eiCMuEwtbzu_
 YlcgwZtc3dilhNgRgSxm6kN8ZC3TdMZx1ipWkofzx_DWjZDyzD3hb8vwZf6652g2TICAnJEhbNaJ
 SQcXP57zSQ97nhrKVbNSd.l0GC1f_4MB2IZd.Nx6br.UXav7eqtv2aa1zaXilI2x0Ljlspbfu7FS
 lGmc0BPLd0cEmnJ35CYLFr2RAGvbVdxmxA_m8Hp4l6u.CDsGwT8c__DxV6qF.sRRqgIMz047dnz7
 NgRLF7gV5xE9S.aShqWKHPAKrWUpbCHSgjqs4ikXVKE1sgsH_TOm6LqOTCX11gpdWu.M9kLFKWL.
 rkSGTGAOyhcFHcHfUWgK0HqEORTSP081abFTAim0efLhNk8._PDHv4GhWJa.MLUMlcOyEVjp23xm
 wWJ5ipuJ_X58HI_Pi53RDZmLMyL5KVfxk.xO.rxkPVpX2FcALdXe09_12VQIJ3P3Y6GjW_hKZsxE
 J7NRB88M9aW01ZJRmq8FAaV3h2x2S0qQT16Evt1S2v.9FyOXoO8M5DqtsEvWUrva4G1lRYG9Yr5y
 zEnxpwWkZ9WY28bLLHAhTgzzmDnxqVhC0j8kv7J.5rQ9QOi4DTpntt5FZtVtUEQx4flKXUzKdT8g
 FA8E_Cz_472rOG9_zfdCl9g9sbWsVCVF28RLtSjKwZLzZcQmOuw1NFtFx6c.PFxQho_5aEP8V8SH
 ad4Lh.j7lnQTYWK1gWRanjjlMjw4CZbLzKe1rUU_AGoo9LbQvpRCIw_WhGmMLGv6GSJr0bioBz7L
 Oyrv3STdVoeoNoajywqQBKWxcYxCjLr9PHHCA9BWG5aMALRVhcUHkneF21RBsbpLKDVA.v4xA0Y2
 gJqMNLZaKRDxsDhMXT0pvgnj_TGTEG7zy4bqY.WJy_cZ_cUtfkJHqilR9SSlsA6d0sWCne8diqiy
 z2wQXbA6HB2w59.NYpB6EQRxW0E4sWPAJ2AHzk6q0SRZLcTolSCfEQbfcWPW6vMbAa_p4TIcHfy8
 dvQPdthvyb20UHSJhU8BkAwEATjH8Qa5thQabKWm2_gS2RC4vK5QZxvOqi7Yhn6l0_px9Gb_Cpfx
 EkrMT1LBnMf9RzJpg2cqoLjoA0iX72sVSrGBP5sA.YD5KvIhrDGegvqVOkoVFF1z7FHh8u4k2QN2
 prZWM5FgHJbxFJMefu..jC0W2zXlc3vYrT3YfO2m.1ZfCpEOqVkf4H8sIHHQfj65AlVwQIJg2PGL
 AItDAhX22LzhFo.0TaF48cNMHrDnA9YWHDuaXnqGQSQvbUAhOvJcUDFJJkGzStffs1eoNg5sVAvh
 8T35ImP4uDUo1fHzAtjL9mqVaBeOgY08E1fjjkmCvxJuHGW6DxzQE_egyxXaJcn2yNQJJ3MMjnF1
 aHtbemlNgyXocdGB2paYEbT4vO45ZUOJgIohDf_gjkUz2vSE1gtJ2UWaggzMRnykhIywRLQZRjMu
 yytuCV3AP_wnFJyp5v3lW8hHU6INX1wnM8eO4QB4Eayc3SjnMBSMXcBmXzoA1gYCW_K133fgLqFR
 o2k6z9nYNoAozvD8xN0Tr5TAvDJZZAkxqN9U9XxocrfC_tKnvUJrf.M4_9BZet0gZygqO4hGT_Pk
 CF4ZYM71TAcdZjZ0E2c88H2YBGSTfBLbS8Ox52jDKSvQM58EGNu9z5FLNVasCUL2W7VJFiMNRone
 USd8688li63sAv74dJBjRzix7Kjq2TDFO3LfYDlAgfEVrZhz.O63lye_ez7dBAqpEAbbqqIuJAq5
 PB.3HCzPxLto-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 2 Mar 2021 18:51:41 +0000
Received: by kubenode534.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 31fae7b590c07b63d8a1e296bc7c1804;
          Tue, 02 Mar 2021 18:51:35 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com>
 <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com>
Date:   Tue, 2 Mar 2021 10:51:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17828 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/2/2021 10:20 AM, Anna Schumaker wrote:
> Hi Casey,
>
> On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
>> From: Olga Kornievskaia <kolga@netapp.com>
>>
>> Add a new hook that takes an existing super block and a new mount
>> with new options and determines if new options confict with an
>> existing mount or not.
>>
>> A filesystem can use this new hook to determine if it can share
>> the an existing superblock with a new superblock for the new mount.
>>
>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> Do you have any other thoughts on this patch? I'm also wondering how
> you want to handle sending it upstream.=20

James Morris is the maintainer for the security sub-system,
so you'll want to send this through him. He will want you to
have an ACK from Paul Moore, who is the SELinux maintainer.

> I'm happy to take it through
> the NFS tree (with an acked-by) for a 5.12-rc with Olga's bugfix
> patches, but if you have other thoughts or plans then let me know!
>
> Thanks,
> Anna
>
>> ---
>>  include/linux/lsm_hook_defs.h |  1 +
>>  include/linux/lsm_hooks.h     |  6 ++++
>>  include/linux/security.h      |  8 +++++
>>  security/security.c           |  7 +++++
>>  security/selinux/hooks.c      | 56 ++++++++++++++++++++++++++++++++++=
+
>>  5 files changed, 78 insertions(+)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_de=
fs.h
>> index 7aaa753b8608..1b12a5266a51 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_blo=
ck *sb)
>>  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb=
)
>>  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
>>  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
>> +LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mn=
t_opts)
>>  LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
>>  LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
>>  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_bl=
ock *sb)
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index a19adef1f088..0de8eb2ea547 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -142,6 +142,12 @@
>>   *     @orig the original mount data copied from userspace.
>>   *     @copy copied data which will be passed to the security module.=

>>   *     Returns 0 if the copy was successful.
>> + * @sb_mnt_opts_compat:
>> + *     Determine if the new mount options in @mnt_opts are allowed gi=
ven
>> + *     the existing mounted filesystem at @sb.
>> + *     @sb superblock being compared
>> + *     @mnt_opts new mount options
>> + *     Return 0 if options are compatible.
>>   * @sb_remount:
>>   *     Extracts security system specific mount options and verifies n=
o changes
>>   *     are being made to those options.
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index c35ea0ffccd9..50db3d5d1608 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
>>  void security_sb_free(struct super_block *sb);
>>  void security_free_mnt_opts(void **mnt_opts);
>>  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
>> +int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opt=
s);
>>  int security_sb_remount(struct super_block *sb, void *mnt_opts);
>>  int security_sb_kern_mount(struct super_block *sb);
>>  int security_sb_show_options(struct seq_file *m, struct super_block *=
sb);
>> @@ -635,6 +636,13 @@ static inline int security_sb_remount(struct supe=
r_block *sb,
>>         return 0;
>>  }
>>
>> +static inline int security_sb_mnt_opts_compat(struct super_block *sb,=

>> +                                             void *mnt_opts)
>> +{
>> +       return 0;
>> +}
>> +
>> +
>>  static inline int security_sb_kern_mount(struct super_block *sb)
>>  {
>>         return 0;
>> diff --git a/security/security.c b/security/security.c
>> index 7b09cfbae94f..56cf5563efde 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void =
**mnt_opts)
>>  }
>>  EXPORT_SYMBOL(security_sb_eat_lsm_opts);
>>
>> +int security_sb_mnt_opts_compat(struct super_block *sb,
>> +                               void *mnt_opts)
>> +{
>> +       return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
>> +}
>> +EXPORT_SYMBOL(security_sb_mnt_opts_compat);
>> +
>>  int security_sb_remount(struct super_block *sb,
>>                         void *mnt_opts)
>>  {
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 644b17ec9e63..afee3a222a0e 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2656,6 +2656,61 @@ static int selinux_sb_eat_lsm_opts(char *option=
s, void **mnt_opts)
>>         return rc;
>>  }
>>
>> +static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *m=
nt_opts)
>> +{
>> +       struct selinux_mnt_opts *opts =3D mnt_opts;
>> +       struct superblock_security_struct *sbsec =3D sb->s_security;
>> +       u32 sid;
>> +       int rc;
>> +
>> +       /*
>> +        * Superblock not initialized (i.e. no options) - reject if an=
y
>> +        * options specified, otherwise accept.
>> +        */
>> +       if (!(sbsec->flags & SE_SBINITIALIZED))
>> +               return opts ? 1 : 0;
>> +
>> +       /*
>> +        * Superblock initialized and no options specified - reject if=

>> +        * superblock has any options set, otherwise accept.
>> +        */
>> +       if (!opts)
>> +               return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
>> +
>> +       if (opts->fscontext) {
>> +               rc =3D parse_sid(sb, opts->fscontext, &sid);
>> +               if (rc)
>> +                       return 1;
>> +               if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))=

>> +                       return 1;
>> +       }
>> +       if (opts->context) {
>> +               rc =3D parse_sid(sb, opts->context, &sid);
>> +               if (rc)
>> +                       return 1;
>> +               if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid=
, sid))
>> +                       return 1;
>> +       }
>> +       if (opts->rootcontext) {
>> +               struct inode_security_struct *root_isec;
>> +
>> +               root_isec =3D backing_inode_security(sb->s_root);
>> +               rc =3D parse_sid(sb, opts->rootcontext, &sid);
>> +               if (rc)
>> +                       return 1;
>> +               if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,=
 sid))
>> +                       return 1;
>> +       }
>> +       if (opts->defcontext) {
>> +               rc =3D parse_sid(sb, opts->defcontext, &sid);
>> +               if (rc)
>> +                       return 1;
>> +               if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, =
sid))
>> +                       return 1;
>> +       }
>> +       return 0;
>> +}
>> +
>>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)=

>>  {
>>         struct selinux_mnt_opts *opts =3D mnt_opts;
>> @@ -6984,6 +7039,7 @@ static struct security_hook_list selinux_hooks[]=
 __lsm_ro_after_init =3D {
>>
>>         LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>>         LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
>> +       LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),=

>>         LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>>         LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>>         LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
>> --
>> 2.27.0
>>

