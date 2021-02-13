Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57E031A8D1
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 01:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBMAdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 19:33:39 -0500
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:45437
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhBMAdj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 19:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613176372; bh=ImHiBhLDwdAq30uHYIGZ6Hpi7QJTMVUjKze2h132/m8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=h1U+d1M2JeADaHWq4R6flt2UOfGK/iKUtQo+bjo4OqorMZ+8k79GqRc3tOxvFo+jsSpsRlRdLjjJiquo6W8xelQug0XBoKdPXg+oJwZhPiPEmLDAZMptBEJidNfg7hmqLf7CAgSUDGA9qCeDftPjDuNa2cKe+DEH0rl8VSPmj2sOqdhRvhxs39E//cNWb6ne659cb8ifMbZdYYnioQpVO/UWrz8cgNNqA1ED1itI3byby5ylfhG6BrtqAYddaApPZs12sp2skmVkb/M8Yq4jeZPpPfqWldP3dw5AKrjLHsPBZYoOEiHJQiNwGSNvjXqpq7kRky+DMadq1cP9perQ8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613176372; bh=rfe7qBDERoZ9fWswZqEotSQiITTGsGHVJl3ikZES4w5=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=IXon9rizEW8t02II6zQB1UbBbAxOyEyFhJFp1kxdPN19v8AF4mjqNPtJ7h/v5v6cB2QVjG7Uf4f8XMGreVYet/XMw76n1j4sxS+63n4ksRzrJn47i3ymWoKkF3IJMJ0uRqRiO1IDBLVGsDpYxpcCZSZDzamywGh4F0RtvaIm2khn10jZ23zBBPxcUywM8I5Un4I0ROd4isFLV9R+28EVRxMkw4hR+PbmSCsp2PxYwAo6lq41QPy2MxQuDU8wstpW2XyRdB8TuWzAdhrDhn/yUUf853Fmd9nM7DNxYHuSb91nEuawoApwlvAjGCVxXjnz4BxdjPCvOA2TJLbr4KFEOA==
X-YMail-OSG: YQy2Bm4VM1lFXr7SN4.XxVJrmsIH5G0reQcPUvua6aoqwXWroJejN0aj.Pfo09O
 NpU3YIesyeqDO9mThyzHh5NFTPdYcJSJCa0Q_PkB6UgAKKcf41V5CzPQlYLgCFxBabN.Fup_cjtt
 GUM60KkX3gNZgrsTXDuqR2kT0UZMczYcU2911KI7pxypTfOQeDkD6Ul7jytABTQUTE3nsRrSZ6Ja
 wReB9dpJ3KIX2fhfWV0XXTXH60_1XN6MnAUKVc4UJnceFHsKEJyJ6YJJKdKWT5my95Uk8kH_z2tJ
 pKZdU3JTncycKlSeGDFDWxiJGtklwIDqJPmhe1krmT2pFnyQD.TsmNnFjybho6fNyrcXD5r2namS
 U7GCltwhmoLZrfVJ.RDD9g3D_FgFSs13B2cs2tz5A8JYCYAq61YJmluVUbRwIAUoYvPdcvot82GZ
 OQKao4ytHX56MJ8k3jHVOtVYlDFTPPLluUDr770W1KsHNDjfgzLTn8_ZkbQzc9Dl53V3dCM3tH9m
 .kfRsttu26qHQzEFoMIbLk0im0SeoM2lV4m_rrZPfoDICgUX6Hfu3kmXjBg4HcZTVjkTL2FRCM6_
 jbMdzpTTfvHrS86Z7qtRz8v8aEph_2rcITB6E.efPIh5NE0ugyYPP5c4VnBbXmT4prX2l_S25Rv1
 XZM7y4gxkzOaj2fNIFvpT0L_xRM3v44vqwutA0INmXz8LnM2mhK_4PpaX8b3Kj2cmVmSyiWohM_S
 wLKb6NgMRIx7z.fNi0QAAZuufq7aEl9N7niqkTqwf9Qe06a5Vmde8pQia8rUUAQhCwpwE3vIcH.0
 00iTtTTUEY26XYIwy69XKqPu6J1gdB8YxgqQ2.Zrc01iK1kYJztKqRip2mQl5nAB0qzF4EeY5eN_
 TW.6SWvRdxyayBHAirBEhI7wksuLu0jn31YsWcUROh54eljcpOVdAMOJkG.UUxvSfyoN_ulaUDkC
 Qx5rs7dVre8n8mbiiwUepQjdqukhqmvqNy6CK6n4LLAKmy_omdJjpfWoU_rSp0z2Yaq6_q1SMAcP
 t96HY7llNIYFalaKleDYIepviwfWwiJMsuTREVwOpBJpOHCp5uw_e__QWov5haD5dALS42jIqj9b
 qxM3nnn5UeySDJom7VyJaIEz6yS0vwhhOm89tmhmsAgPqH1r_jh5bvoF78cydOsJ7EkWA4PhWF9b
 2XLiNRlNnZ15m8DjzVFkI9yRXLYDFMObH_lmt8IEQcDlBI1o4pFsY.3oLcnaUMOs9muvs5sYrppl
 PB4WEgCv3E7EZ0FThIdHUxK4qctuWRn41wNpFcYbFVmmmYY7ECTgexSOw_Y97jHRoamcBm7QvesN
 2OjgXI.xA0SaVRkATFax08ijTsm_O7numbkB3w4xAIULRwJne8uk0pNAmPUB74Jh2BGFB0usVudt
 TtPVW0acDGJ0D.YUMnwgsewuV1B99BgNMPncXUfk1.grOnLh4fpoX.FO5fbPGV6cm7XtCPxdSgtw
 F6E76KM1AXvkPZNI8ytxk.IiazLwZ9lSQWE_tmf3gSTX8DRyhbj6DuE6fk1aRPI0PV94lD_gBMqk
 GiuOR2hszYF7C8B3MiLvA0x8U8PqqyNrbB1G.O1OsZicT1RrHrZk8zWsqqhWyeHaWhL1_PLofvyR
 DXEHzJaXlUo9TuKQFANpjz3KH00dz4ZOkeLWiuuk.VHOC8REYX4WXf2DgYAe7TMVVvEuyJtf3nNz
 zkZN4MDTTDRGlvdYDKC6K84FD6_FHG7no564QN17PYf_1OBg9qjlWk21Kjvu2evDs68qMpY2kWfi
 FNj2EriHbh7ZKzPHMclXkmsVtW5Km7cpExthTF9A.vLg03_jV9tbK1uPuyDPHx4iMP31cssa6hf7
 30cxgZbVYVtBm8zGUfCFuiGHfGZM7_RF7d1ca1fo6Etz9x_1GMuTr5ThxDyNG2DyfxnQcILswPt8
 NdcN4wW0jCG4tI8z5Zxi4tPkzv_SuxdieGgiuQuYRdMVykfWaw1df9Yp5WyknZdZNRJX698DHnqE
 BzfgrZ.44pQSLlUtQn.YCIxZFN6pKceg7A1m6D2cilJMyYRtOXnOW57KkjDwlOE0NFH9HOmNlkHp
 R53jmVTxgj7G72eje0Wmd0Y7XiwYEZBJ.g50LOrGhPtpCN7V1qKmRYPKQBqi2lStlEQl.yEP.Q5i
 i1wVsWNNHq1lp1nTJhVjBzVOcNtYMhRY2OVD6Pw.5qTJygbuQ1JwU.4FkmQhm5Mn3k.xUTRiqXFU
 HpNJ9fMvEOhlhB1Oe2JKntJtD2mrHxkqIFHwsGyd.feghVvGduP8_.nC62hET7VFj3iBdZPNPaHe
 Q_R41X0CWUrUy5OhTyGxcD0GAB6COa4NWfNe1oG83d9_xOAdJ58xHoTgKzlsQqIvx3bIFA6KUkAQ
 M0kUuuBitfHDN0fxQPR8vD0hvG0IWgIyyqZkHlKIwZG.rcVohkOjONyiOexta2rcbuobay4n3z6t
 KReekNbvhEXjySAvkuxbWI9cZqx3Mi8m.e9IE38NyCS9A76.zeIg.gn0U_3JhyUCh.eIOM1TKFGx
 ZPiVdQA.jvHK.YWF7Ig2WsxMcY4ntxcODpBhheoBehG2TM2mS_rFAMikpYxMuf63MriWxgeFgDR3
 j4akt3JW7Zi8iw.DqmML.3ca.ifgO_2ln9irk38f8uHgMNWpw7p0_Sv3u8vEWBaVFzaMd14q8Nvv
 h8KIvlaew6DGJABFYqFPLDnA4j5W3rv88AfGBmL2HYXDmXSG7xHpMmTpONYKvCOM8B9eHpujfJQy
 xoEKNgPnxswBfayZuOifED.1lYk6cNgbdXy8XEU8M8ab14WsSkxoouXH9iM6D_2XT8hAdGOoprk8
 BRtgXO6RIYH5mpY4gw9JAaEmwnU_d3S8C9b3tAk3jErLTLNmIbAagX40kPgb8u8a1kHmKuYNpNNi
 EYOZ_ADbWKzcHnOLlIQN3FG7PWKBypCjJQV.oZx8Vqbd7Y.oLnMAjcSGKHzVYjG.BkvGSoWP79Ck
 BDqC3YTdpfI0FcjBQpmaG40yP7wYQPyvxRnZBU1rqdxD25t37gVg2RHmEE5Rz_ywGSFFLnd8LmL3
 _
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sat, 13 Feb 2021 00:32:52 +0000
Received: by smtp410.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 258b8b0fa6ebbacfa7453ef7885911be;
          Sat, 13 Feb 2021 00:32:47 +0000 (UTC)
Subject: Re: [PATCH 1/2] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210212211955.11239-1-olga.kornievskaia@gmail.com>
 <6214d043-3250-43bc-d668-bc9ffa8c9af2@schaufler-ca.com>
 <CAN-5tyFU7JCKEr6wPQ3_LTGJHQLFmrb=-xWQt6mGhv7JzE_xXQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7f2c84d8-6bef-b895-2e08-c0579d6faad9@schaufler-ca.com>
Date:   Fri, 12 Feb 2021 16:32:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyFU7JCKEr6wPQ3_LTGJHQLFmrb=-xWQt6mGhv7JzE_xXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/12/2021 2:50 PM, Olga Kornievskaia wrote:
> Thank you for comment Casey. Comments are in line.
>
> On Fri, Feb 12, 2021 at 5:37 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 2/12/2021 1:19 PM, Olga Kornievskaia wrote:
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Add a new hook that takes an existing super block and a new mount
>>> with new options and determines if new options confict with an
>>> existing mount or not.
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>  include/linux/lsm_hook_defs.h |  1 +
>>>  include/linux/lsm_hooks.h     |  6 ++++
>>>  include/linux/security.h      |  1 +
>>>  security/security.c           |  7 +++++
>>>  security/selinux/hooks.c      | 54 +++++++++++++++++++++++++++++++++=
++
>>>  5 files changed, 69 insertions(+)
>>>
>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_d=
efs.h
>>> index 7aaa753b8608..fbfc07d0b3d5 100644
>>> --- a/include/linux/lsm_hook_defs.h
>>> +++ b/include/linux/lsm_hook_defs.h
>>> @@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_bl=
ock *sb)
>>>  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *s=
b)
>>>  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
>>>  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
>>> +LSM_HOOK(int, 0, sb_do_mnt_opts_match, struct super_block *sb, void =
*mnt_opts)
>> Don't you want this to be sb_mnt_opts_compatible ?
>> They may not have to match. They just need to be acceptable
>> to the security module. SELinux doesn't appear to require
>> that they "match" in all respects.
> You are right, it was a poor naming choice. Compatible is better. I
> can change it.
>>
>>>  LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)=

>>>  LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
>>>  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_b=
lock *sb)
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index a19adef1f088..a11b062c1847 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -142,6 +142,12 @@
>>>   *   @orig the original mount data copied from userspace.
>>>   *   @copy copied data which will be passed to the security module.
>>>   *   Returns 0 if the copy was successful.
>>> + * @sb_do_mnt_opts_match:
>>> + *   Determine if the existing mount options are compatible with the=
 new
>>> + *   mount options being used.
>>> + *   @sb superblock being compared
>>> + *   @mnt_opts new mount options
>>> + *   Return 1 if options are the same.
>> This is inconsistent with the convention for returns from LSM interfac=
es.
>> Return 0 on success and -ESOMETHINGOROTHER if the operation would be
>> denied. Your implementation of security_sb_do_mnt_opts_match() will
>> always return 0 if there's no module supplying the hook. I seriously
>> doubt that you want the mounts to fail 100% of the time if there isn't=

>> an LSM.
> The mounts are not failing. This allows a file system to decide
> whether or not to share the superblocks or not.=20

OK. I hadn't gotten that far.

> Ok a good point, I
> haven't tested building a kernel where there is LSM but SElinux is not
> compiled into the kernel (ie, the only user of that hook).

That's a pretty important configuration.

>  I'm not
> sure that's a possible or an interesting option.

Yeah, it's both possible and interesting. Every Ubuntu, Tizen
and most Yocto Project based systems will be affected. There
are many use cases for which SELinux is not the best choice,
at least in this reviewer's experience.

> Ok, I can flip the returns, I wasn't aware that SElinux is so
> restrictive in its return function meaning.

You need to be aware that the LSM infrastructure, while
heavily influenced by SELinux, is not defined by SELinux.

>  Returning 0 on a success
> when you are looking for a match/capability seems backwards.

It is an artifact of the system internal convention of
returning 0 on success and an error code if something goes
wrong. There is one way to succeed, but many ways to fail.

>> Also, "options are the same" isn't the right description, even for
>> SELinux.
> Again compatible is better, I can change it.
>
>>>   * @sb_remount:
>>>   *   Extracts security system specific mount options and verifies no=
 changes
>>>   *   are being made to those options.
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index c35ea0ffccd9..07026db7304d 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
>>>  void security_sb_free(struct super_block *sb);
>>>  void security_free_mnt_opts(void **mnt_opts);
>>>  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
>>> +int security_sb_do_mnt_opts_match(struct super_block *sb, void *mnt_=
opts);
>>>  int security_sb_remount(struct super_block *sb, void *mnt_opts);
>>>  int security_sb_kern_mount(struct super_block *sb);
>>>  int security_sb_show_options(struct seq_file *m, struct super_block =
*sb);
>>> diff --git a/security/security.c b/security/security.c
>>> index 7b09cfbae94f..dae380916c6a 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void=
 **mnt_opts)
>>>  }
>>>  EXPORT_SYMBOL(security_sb_eat_lsm_opts);
>>>
>>> +int security_sb_do_mnt_opts_match(struct super_block *sb,
>>> +                              void *mnt_opts)
>>> +{
>>> +     return call_int_hook(sb_do_mnt_opts_match, 0, sb, mnt_opts);
>>> +}
>>> +EXPORT_SYMBOL(security_sb_do_mnt_opts_match);
>>> +
>>>  int security_sb_remount(struct super_block *sb,
>>>                       void *mnt_opts)
>>>  {
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 644b17ec9e63..aaa3a725da94 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -2656,6 +2656,59 @@ static int selinux_sb_eat_lsm_opts(char *optio=
ns, void **mnt_opts)
>>>       return rc;
>>>  }
>>>
>>> +static int selinux_sb_do_mnt_opts_match(struct super_block *sb, void=
 *mnt_opts)
>>> +{
>>> +     struct selinux_mnt_opts *opts =3D mnt_opts;
>>> +     struct superblock_security_struct *sbsec =3D sb->s_security;
>>> +     u32 sid;
>>> +     int rc;
>>> +
>>> +     /* superblock not initialized (i.e. no options) - reject if any=

>>> +      * options specified, otherwise accept
>>> +      */
>>> +     if (!(sbsec->flags & SE_SBINITIALIZED))
>>> +             return opts ? 0 : 1;
>>> +
>>> +     /* superblock initialized and no options specified - reject if
>>> +      * superblock has any options set, otherwise accept
>>> +      */
>>> +     if (!opts)
>>> +             return (sbsec->flags & SE_MNTMASK) ? 0 : 1;
>>> +
>>> +     if (opts->fscontext) {
>>> +             rc =3D parse_sid(sb, opts->fscontext, &sid);
>>> +             if (rc)
>>> +                     return 0;
>>> +             if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
>>> +                     return 0;
>>> +     }
>>> +     if (opts->context) {
>>> +             rc =3D parse_sid(sb, opts->context, &sid);
>>> +             if (rc)
>>> +                     return 0;
>>> +             if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,=
 sid))
>>> +                     return 0;
>>> +     }
>>> +     if (opts->rootcontext) {
>>> +             struct inode_security_struct *root_isec;
>>> +
>>> +             root_isec =3D backing_inode_security(sb->s_root);
>>> +             rc =3D parse_sid(sb, opts->rootcontext, &sid);
>>> +             if (rc)
>>> +                     return 0;
>>> +             if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, =
sid))
>>> +                     return 0;
>>> +     }
>>> +     if (opts->defcontext) {
>>> +             rc =3D parse_sid(sb, opts->defcontext, &sid);
>>> +             if (rc)
>>> +                     return 0;
>>> +             if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, s=
id))
>>> +                     return 0;
>>> +     }
>>> +     return 1;
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
>>> +     LSM_HOOK_INIT(sb_do_mnt_opts_match, selinux_sb_do_mnt_opts_matc=
h),
>>>       LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>>>       LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>>>       LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),

