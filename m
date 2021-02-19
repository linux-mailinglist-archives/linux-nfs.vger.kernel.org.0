Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417CC31FD5A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 17:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBSQp6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 11:45:58 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:46176
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhBSQp5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 11:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613753110; bh=mFfst5URaInPuYeLpLh0a1I+MKedi+TThpev+uhrDVE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=gXQ8r2YK1aglR4TixTI7G5WlF3qE3f1mILbHXUDO3DWuMBwvaCmvTOxEvEgQog6XJTFYIHoUheC/SP0X32jxNSZVXX9r9LdlRcNol9MEqq+72MpsLoYUb9RQQOFV9t3yJjgY/FJcnYbgl3OPGbJiqJriHGFt16nA4ukioCbVN6pRLHtuNZOnmXl3hDshRdw2MAUO/aL+xgX0RDDSWF/DD/s3Nx786ir1/NL5UFvmW4UTE9rsbzaw2r9Fb1gpfR6ToJpGswiJfxin6DpuGhHuqtkVQpk7zmtKmi2bFfzaFRteoDSBBVUbknPTUBUK9+CLEEJyMmyx9GGVbFMUjhYMXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613753110; bh=xNSLCBKeduf5HLt9R7xVEM7VcjtA7Ev34URZuKxPCH2=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=ZN3eRIEsOuT5+Qjb4vPSuWckfOZMFk2UhD4hKYVriM5Tr0FYo1m/B7luLLlSJKN4SQcU6RyI3EwFdqVuoO1KOZMdUkwLYTGj3pJmJtfqMD9FYv3tTmYgNQif6se2EOYuZ/HVRrxm2TOsuX4S7kynxKPBf/e0bBXWcdgLnDrOXc4bncp0F0HOrku6dXGRvbSP/JatyffI+cbzU1GQ1DoZ6bbk0TA8V5Qm2qtoXn7V/WuCEl+nzFIfesOSeYGOouEEyQFNVSpInh1wgG2BYhRWps/p4XpZhgeVs4QPvXWd7IwfBZN3ox2gHR9wYtAOF8mGRaAtNhyZplQrZZPbtHy4QQ==
X-YMail-OSG: eRg0GegVM1nq5foKGbU1kRWnwkJHfSxPCvGlhtH33.iuN9cRa7f6XcZEL2H0DgB
 v.B4SHXp.WFBZ1mU4uzrnwh3ZTyvYJ9DwUPPoLLsKYLtBBkC1f_uGDCGL3I_yXUTTnXs9q_uhhoR
 WRbJBsQEX8oQnFy_TQZ_uaUd8KNzF_6VUJipksKgOBREjWypks19nHyWmc78jk1ExV8M1v.WFcdr
 0FCLgWlVE53.XqJXmHkNJQgk2nGUNKmNOpPefOVkXZkdbjBIdUUMK5eP2TYoYdH9pNceN.qmZjiB
 owic2gAQCWPgO_QVYh8BMziYMBY9.XG6iqY6ciCtrXdyUpYj4J93VRL7CPbQOs.7eEnIswWRLmfQ
 Ga5S8grTvzZPuT1Xkulbi2_A24QbgARpwcPN5Cg_TwgG2YrZ2W8KxM7_D5GppNd1BOvOR54bLITs
 f_WHLLC7l.XOYxuq582hl88rulrqRvJrCTSIBuwxkpUP91CqYPZDrVkB9ZPbOadn4ZY1tMnbmFoV
 1Q8StS4agD2sdjBKEmMRKtjNlS69SG7.r79PSnbjisj4iUEKM8ZBt4GQeikq1srSHiQgMqt1LJDU
 NvnBjdQy8AZ1wGpKdrG06LxMSrEOgW7qLXTIeUuI1lBGOk5YrJ59nzJNloScS4B1fjBlSmu1LI5N
 IFmoCrRm35bn1kMjBe10kA4XMu.w61bIN7svmo6ubOLEu.skP6MTuaUnS6K7kD1tRoOnLzGqeTpO
 LAyg5FvxW6iHdTLofdgKFAonF1FrJSLqpoV_.UW9pwRkdd.AypsFZV1xCsHm9OicNwXXN_m.mU05
 3P9XaHYGaVgblqSgohV15Yu.V4IGJfKXDcqJxOEq1l7V_F2aXQW21gVqgqAMIY5frH7fWJx78o7y
 5fbsww0JdoRid.MAgTuy15BcZ_rb_ym0f_MPWAoAfwgSoy4qx5f_s.QsUcxiSa9gKEhPMk_jbtGk
 9Ek__2wcFIcWR1pPHf3Niq9QA6vvKgjWQo.DVsXNYAuuTRocpooUuhGUnyiMmhvcVn54xq2kThwc
 o7mGLaRHpgC.m3EXfZjvuCsA6ZYxNfsrWzJvAmGHHPeGK7PxpWNFEqfqblUnNrN6o8euNVc2tftM
 TlnHZAj_ESRIax4KNe7rYjbS8UEdkkiwD_sxUtAsWTPEcuYpn950fgHtu7WZ1Qz5jVn9lHw_PVT9
 2BuGoGi7DM26ZoJvLpCAAlr1ROv0Q6LYmFGzbHcVqXQeIybqH.IP_snhJS5KaCiGC7Yl9TKpAhTa
 .O4DQoQzgcwV9qcbNPG6m_bTrK67Rmtq8aERlSUCZAufOfpeDV.Zz5LO0KTV0x3PY41FhKIu5zlz
 rs3zaaeVjAktvOH7WhGwHRBuYglw.___fpXi5.Ue0UJIeIdMji_6TvGYVGJ72mSEhbUKUFwZRzfM
 rpvB8cJ6fQJFuIu3Pa8yFUexYXvUIoSgaP9Vh1yGr8OJtMib1QUdfqqfdewQraAkeiTv44FJZZkT
 NXZtjeD_nxtA45diDpBy6qwd.q8_NHE56F53zoivK7_aJqBRa_W0NPuFuAXYph0my87syj._p8wq
 hqfYJHoT_A4TaVUTDRTW7oNqJHVV6fAa67tHjvaA4rVi9XOPe2NZpVJl3BN11r.VlOlFf8hbRq0j
 6Q_R8Ut.bCJGmPe5AkKmXHokUqbIoGflx8jo3jQNsNQkWyS.ZCYdX_j.A2wxZdf5_AKoq59v2SIz
 l4MNzXqEEeQCNxki5An47LeOwyMQ6SGxJNzfabNTcMRGqtNjLMYYRx55XneRWtRItg7TxF4Dhz1x
 6salmc.bG96fEFXmBrT4nnQh0HjtetzV26xDhOmVLW_sRK_fdsHGzfOmYiQdCguhsehTiUiwp8fg
 1Mo2vSQ8JeKtrXBsXxTMGjUE0XugIoFS9Q0dtfpvTuRpqu4SZfTK_4qatgoGzhr4sJwtg3zAKOEx
 QVQVi8283lmcRarEM1Ajx8PqnWtO3Pd4FohLFiibKywzdHssqQ4ISLdqdDz9DA5sdbMEiVRGkgOp
 5M1oekmnBby0oJ8ZjW61y_Dn4m2S9Jzad9C5rrLKq_os6C80_qnwTylTQhktoh0bJ5iAmpFmzBZb
 xlO3ufmfoUe1dGU6l6NFY.jX.rNwwkG6Y_4chUlUXOerVuPg_DG3_L8b3_NbEVDV54ix3xzY93w7
 tl__r.Yz9RrII1ihItyIsZbosVcgnXfuK_zdELG3EGsTBuPlLw6MuIrySb5pvD_epGjPsfEnCJXH
 sl_ft7gQ9S0BmKow244S4WH.Hdwui5.OMg7e0VRvhYZ2gEmNlS0vWF6_MsxWQHVzwybdofFNgUGb
 YyRrDicJbvMKgg3RrhbR49VV.IUfwgTByby7x9KRbu6UhGdFSdMsih7j6hRhiQZQW8R_a9D81HbE
 jvA7yKZxQXUS9IiJXlowCrLDamf.7bQuoJcvuwpCbUBh1peJuZwlhQMRy_2RGHjT9ALBt6IBGVSg
 vBXSH_CFvIPauGTa41wWLsKa040FkWZm70tWi8.7EuzZ1R_v1uXEZ3Vc2LK0DJVre.pI0nv_z2.O
 KJn4C.sQerExH.5mpeg2PBWEqdRZ776wWGpIu7C9fny8EkF7zIwLdXr.zFN.WviyRVkbMcSLL8wn
 2o1ltmt1sH2kUEmExJzxM7qAPL9IlhGDeRcthZrM4kQLgXDCaT5cDxH3ImEnUzo68o2RcoF_B2_A
 5HNpGfsk1dDzGZ_zjrkhu3JqamD8QTjdzGSd1KmK.0tBXZ2WVRUcT8_SyEYUEWx5T0zyPEYdkmaV
 AhUQLOVThBMYFESWdkaDCIHLA8mGuesne4LSbJGgvTDNLO7tejjjxCGsjz_c2yT0UFNCi7ibZZVW
 X84W7PilwuYDXKcaPx4X7MkVo2TsOIA_j0SXWZekc1cFxKxB.TTmHeHs4SQJKB3ONlX3sFNPmZSf
 a4IOWtS1Ucm9DfKIJRQ.BFDECezBxPMX.zWrOrnb_0zChh0pUhHXhiuuOfUnSn075nf6ThA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Feb 2021 16:45:10 +0000
Received: by smtp406.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5abe3179029ab6e2caf8fdfe84753a20;
          Fri, 19 Feb 2021 16:45:04 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
 <5742cb0f-cd47-4406-928a-0b5b4063c480@schaufler-ca.com>
 <CAN-5tyHDmbJkNV-f-CaONV5PKbhFk0qxC+XSJ21mZJkO9A-87g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c914d2a5-c690-320f-6a8a-49f518eab37e@schaufler-ca.com>
Date:   Fri, 19 Feb 2021 08:45:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyHDmbJkNV-f-CaONV5PKbhFk0qxC+XSJ21mZJkO9A-87g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/19/2021 8:25 AM, Olga Kornievskaia wrote:
> On Thu, Feb 18, 2021 at 4:57 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 2/18/2021 11:50 AM, Olga Kornievskaia wrote:
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Add a new hook that takes an existing super block and a new mount
>>> with new options and determines if new options confict with an
>>> existing mount or not.
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> `
>>> ---
>>>  include/linux/lsm_hook_defs.h |  1 +
>>>  include/linux/lsm_hooks.h     |  6 ++++
>>>  include/linux/security.h      |  8 ++++++
>>>  security/security.c           |  7 +++++
>>>  security/selinux/hooks.c      | 54 +++++++++++++++++++++++++++++++++=
++
>>>  5 files changed, 76 insertions(+)
>>>
>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_d=
efs.h
>>> index 7aaa753b8608..1b12a5266a51 100644
>>> --- a/include/linux/lsm_hook_defs.h
>>> +++ b/include/linux/lsm_hook_defs.h
>>> @@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_bl=
ock *sb)
>>>  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *s=
b)
>>>  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
>>>  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
>>> +LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *m=
nt_opts)
>>>  LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)=

>>>  LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
>>>  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_b=
lock *sb)
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index a19adef1f088..77c1e9cdeaca 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -142,6 +142,12 @@
>>>   *   @orig the original mount data copied from userspace.
>>>   *   @copy copied data which will be passed to the security module.
>>>   *   Returns 0 if the copy was successful.
>>> + * @sb_mnt_opts_compat:
>>> + *   Determine if the existing mount options are compatible with the=
 new
>>> + *   mount options being used.
>>> + *   @sb superblock being compared
>>> + *   @mnt_opts new mount options
>>> + *   Return 0 if options are the same.
>> s/the same/compatible/
>>
>>>   * @sb_remount:
>>>   *   Extracts security system specific mount options and verifies no=
 changes
>>>   *   are being made to those options.
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index c35ea0ffccd9..50db3d5d1608 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
>>>  void security_sb_free(struct super_block *sb);
>>>  void security_free_mnt_opts(void **mnt_opts);
>>>  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
>>> +int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_op=
ts);
>>>  int security_sb_remount(struct super_block *sb, void *mnt_opts);
>>>  int security_sb_kern_mount(struct super_block *sb);
>>>  int security_sb_show_options(struct seq_file *m, struct super_block =
*sb);
>>> @@ -635,6 +636,13 @@ static inline int security_sb_remount(struct sup=
er_block *sb,
>>>       return 0;
>>>  }
>>>
>>> +static inline int security_sb_mnt_opts_compat(struct super_block *sb=
,
>>> +                                           void *mnt_opts)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>> +
>>>  static inline int security_sb_kern_mount(struct super_block *sb)
>>>  {
>>>       return 0;
>>> diff --git a/security/security.c b/security/security.c
>>> index 7b09cfbae94f..56cf5563efde 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void=
 **mnt_opts)
>>>  }
>>>  EXPORT_SYMBOL(security_sb_eat_lsm_opts);
>>>
>>> +int security_sb_mnt_opts_compat(struct super_block *sb,
>>> +                             void *mnt_opts)
>>> +{
>>> +     return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
>>> +}
>>> +EXPORT_SYMBOL(security_sb_mnt_opts_compat);
>>> +
>>>  int security_sb_remount(struct super_block *sb,
>>>                       void *mnt_opts)
>>>  {
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 644b17ec9e63..f0b8ebc1e2c2 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -2656,6 +2656,59 @@ static int selinux_sb_eat_lsm_opts(char *optio=
ns, void **mnt_opts)
>>>       return rc;
>>>  }
>>>
>>> +static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *=
mnt_opts)
>>> +{
>>> +     struct selinux_mnt_opts *opts =3D mnt_opts;
>>> +     struct superblock_security_struct *sbsec =3D sb->s_security;
>>> +     u32 sid;
>>> +     int rc;
>>> +
>>> +     /* superblock not initialized (i.e. no options) - reject if any=

>> Please maintain the existing comment style used in this file.
> I'm again not sure what exactly is the style used in this file and how
> is this inconsistent?

While not 100% consistent, the style used here has the "/*" alone on the =
first line
with the text starting on the second line.

	/*
	 * Like this
	 * is done
	 */

not

	/* Like this
	 * is done
	 */

>
> Here's one example from this file:
>         /* Wake up the parent if it is waiting so that it can recheck
>          * wait permission to the new task SID. */
> this is another example from this file:
>         /* Check whether the new SID can inherit signal state from the =
old SID.
>          * If not, clear itimers to avoid subsequent signal generation =
and
>          * flush and unblock signals.
>          *
>          * This must occur _after_ the task SID has been updated so tha=
t any
>          * kill done after the flush will be checked against the new SI=
D.
>          */
> Here's another:
>                        /* strip quotes */
>
> What exactly is not correct about the new comment?
>         /* superblock not initialized (i.e. no options) - reject if any=

>          * options specified, otherwise accept
>          */
> It uses "/*" and has a space after. It starts each new line with "*"
> and a space. And ends with a new line. This is consistent with the
> general kernel style. Actually example 1 is not following kernel style
> by not ending on the new line.
>
> Is the objection that it's perhaps not a sentence that starts with a
> capital letter and ends with a period? Not all comments are sentences.
> If so please specify. Otherwise, I'm just guessing what you are
> expecting.
>
>
>>         /*
>>          * superblock not initialized (i.e. no options) - reject if an=
y
>>
>>> +      * options specified, otherwise accept
>>> +      */
>>> +     if (!(sbsec->flags & SE_SBINITIALIZED))
>>> +             return opts ? 1 : 0;
>>> +
>>> +     /* superblock initialized and no options specified - reject if
>>> +      * superblock has any options set, otherwise accept
>>> +      */
>>> +     if (!opts)
>>> +             return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
>>> +
>>> +     if (opts->fscontext) {
>>> +             rc =3D parse_sid(sb, opts->fscontext, &sid);
>>> +             if (rc)
>>> +                     return 1;
>>> +             if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
>>> +                     return 1;
>>> +     }
>>> +     if (opts->context) {
>>> +             rc =3D parse_sid(sb, opts->context, &sid);
>>> +             if (rc)
>>> +                     return 1;
>>> +             if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,=
 sid))
>>> +                     return 1;
>>> +     }
>>> +     if (opts->rootcontext) {
>>> +             struct inode_security_struct *root_isec;
>>> +
>>> +             root_isec =3D backing_inode_security(sb->s_root);
>>> +             rc =3D parse_sid(sb, opts->rootcontext, &sid);
>>> +             if (rc)
>>> +                     return 1;
>>> +             if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, =
sid))
>>> +                     return 1;
>>> +     }
>>> +     if (opts->defcontext) {
>>> +             rc =3D parse_sid(sb, opts->defcontext, &sid);
>>> +             if (rc)
>>> +                     return 1;
>>> +             if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, s=
id))
>>> +                     return 1;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts=
)
>>>  {
>>>       struct selinux_mnt_opts *opts =3D mnt_opts;
>>> @@ -6984,6 +7037,7 @@ static struct security_hook_list selinux_hooks[=
] __lsm_ro_after_init =3D {
>>>
>>>       LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>>>       LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
>>> +     LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),
>>>       LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>>>       LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>>>       LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),

