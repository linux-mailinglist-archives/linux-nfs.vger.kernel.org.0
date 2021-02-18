Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD6231F2DF
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBRXSS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 18:18:18 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:46347
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhBRXSM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 18:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613690245; bh=8xcFkU75+8e/kaJYFDLaHiw/KknA/AYQe2SdhUHGlAA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=cM22hpgwAF7MIc8g1FKXUfEOLgjiV7NJLvEk6UJB+ho58sMfK1vS7u5MkTgFU7qs8hp7DjlzvaYd8zFKWivkendy0gsaWB/zCQ8ti5m5PK62meWbRGbbIsGdDzAJLvWWWloVs6b630n3ynm6/eFH1RFslQ+VFjKKLuGqe4r5O5SIUuxl3lJb60C02hOVsmgDmX9xIme1peQnpVTnzRGJQPXPFA3/KaPlt8xfsm0beNgZmrDWHMfu8k/NRdD3oMHQi9IyrynmwLSb6ys+q0eHr54iUIXOyiFmZxwKpdbl2HwZK8xCfXPCAVQcjBF25UAKuOkI6hKlYxU0wqShrn3Guw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613690245; bh=28Gv0GZDlOdyOgfzKCpCMgKIHMRw9OkEb6uZf1UzBwh=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=LrXibUjBdZRLQ9rtwqFpTHxMYYrGxj1liGscxdKiCv2c2mLn8zWkJl0UAs6GgcROunxTzajv3f4F2CUJTCBxxkB+EjJCwAouEkI4P/IhZZCg3uLqCodKXXFVHO7nazcTLXCD4gyK7Bj5hxUOOkaxU6+XV8uUl7Qp3cnU/z7RXU+1sWhRj2+GYQbk/69LYLu7EVjcP2OMJyE20DjUd80sj+nrvEI8N655YOZ7B5mXhLqBNTPKZGj8YJ8N+WlA7/1DozS5dy511byxqRqsnHYrtaCidQnHg3OA4Uq/IB+wW25NiWrOgGveHCZHWqF/bc/L+9q5o2gRRKI8pOh4VdZ3LA==
X-YMail-OSG: 32BeLTgVM1lcpSrEKrctEFJCTxQ3QrB0jtzGW0X4F5Szgv.YBRfIeAMyqhgmCax
 Smxm7vcBQrKebMjcUgTtWOpwOBqtUO9SyL9Zt9CVmvdZ1dlFLpT3v5VfHww74lYpqFv88KSLdhbe
 ax4dBbIL7wrprJcVVBZfIFLEPbT0A7Sbfb4pfSDWYDLSvbIjYFXIUf5rc9gFx5X7glyj2IL3EbHz
 HP433UFvLZlzzq8FppaIzNnYMKnqkNWVH_vjM9.06df0P5rI.7teQNB18V2cAaFNKl7DBGcS2i4m
 K.PpKlK3avgINY0f.tBCSb6MT72DLZL4BElrld2obXKZF1naIuPCVN5l4vNNoGUvcD_O46ogLR8J
 2pl0PJUgOT2O8HyPT_vGI0Cq.n93yINCoXd5CBmKpiwx5pzEnFLBXhGWxTQLwX4w35HdyhV3ZJdd
 5R1WXD2L6AFnY9TalGyHpN.1qTNhtnKtCLxrCGBvsisWtGBLScnYq3zeYGrWr5tJThkNpkmlDdqY
 .eS05QBCQTeicVnSiO_KG3fPiEg22TyRnmC8TEd.ImHOaShMkKb_PAcLBtOSYSSQMV6_0zCfdzs5
 CKdTb.YYmmrXB1CUhsT73pIga4boHYc1wgxDp_sLL30JDaT23rIm3HgpF8tbmHHWTe1ELwBy8POE
 sK_S2PPQtGzOcF8njGut9I2lIP1j3hoSaJUdSamHGqPTxY4XobkW9JkxX4kacYYY6XqYHG3GAj1B
 CzsxeRMXLwextkb.bB30W7d7mWnEuMGXSAOd0m5RPT5Ze6ujmG7h6WsfwQYRlUv.t8IMAjcO.9mo
 NFxdzTLtJMax0J9wUcrk53dYJLpfEzGT2scr00.f9rIc9.F_GBTAXnuhMMV3WCvqKgeeIc.1gBBT
 Ng8JC8Ki8Xf8LGrVxIQa8fSR84gODH45djpVHB69V4oV8F2rxGv3NvWBGgksgzezMzTPs4N3raYP
 IoHj58N3L05yKkCfl22mLnQDrR_a6NGwfbe.ErrzfbdlVu_3.kizJCqECkB3LhByjJLL787xeKQ0
 8pv6xHWZzUj92HzsQVSVfIBj3oX9ZLZBp6sN2sDaY70phWHPsgCyGEj6CTxUB5eSa5u4UgKNU4W8
 ndKEBK1aSR4tCcN.z6PsM85nTxfIKEGikXtWi4cslxkmf40lrxi1XPz8grQr3MOhezy3_ee3TWtb
 C_1IUxW2Ytm4_GUMTkzZ5nmADu7Mjd3czauOCiQsHk1HyPyhyVtsxqVTw70mQHQTdfFx51y658DA
 p8Ku_yo17ahINK9FFsrDeIP1UV2MVdSkmm6tpv8OmuBKewS6hLB544DjtROViOeEf4RY1mfth_n4
 A7DdVyfSP5flQdsymwIwE4uKeERONhp.nZwfMIEkY5ap7mLTTwxYhXTQ6lQM3hZYvGJ479EBw9jN
 xepDMdhq4mR4TV0L2DAK_AEWuf39LOEf1AAJ6us6MGvPFifO34pSE7HMNeS.UUtzQzjq6MToSolW
 6J6jAV4acD_yxoj9Pzc4lqEW3trrJZegEj3WqlyluKq6uqkrGFZF3F0XeUz47OkUFm7J3.vDM1WK
 z.xqH2T2YesQKe6iA9Y.myjISGqMAhG2CJgz67VXsxwyPRccTP2bNF615iZP1tXJ8EMfLvJzFUqj
 dveubj6M9i9YPbsfMnjpuuU1_8lArqb2axJ2ob_2Waz6wmwJ9XdPdjyDg4ma7brSRfSwf.bNu7OF
 d8Xup.jpq.HrMi.fGPppeGxkYvTRizc1r6rEGgU4UfJvszCneCG8uMJA0nwFTCX9mdKPmZWiK.jZ
 WZK8ht86GXqPbkedQbtuXd45xEbx6hyjMbJEL5Zh1uPOPmXzWYu38exY9hIEAwDxWUaK_OAtkgtG
 fo129P1ZBFS9ZKhSrGBIWBrEp3m3VmbmYcF395UlChuA9_tbLGUaN4sOLl1c0o4Mcj92Gs2XxYzt
 2ZZgQf4lvdISdZXuktmMJbjNo_phYQd2QTTP2kYfnNS7TPvZl2IiC6FaPeQgPSpJX.V5wc8mI4UC
 .S7_i_ckrww_KzP82_AVj5ahTNMBCUSkqJrS5K.1KUqOLAHpEhLUhvLWOTZuL0QmkCHurnNyX_ZJ
 pQzd7ati4rBrvkUyyRI8n8vqUtkW8q.X2rfFYNzWL3lg3mna0ISU5KKMMwpVX8vCSNt9yxC3y8zf
 X1I2JOBCwKHtRx0JNyQJNjuQ0amx4P1xMxE6Sx1yNAZQi84OPEw3iNMyk04MXQRCK0ZeqPSqd_GC
 bGrk3UYKyrmL6AnYTh4mauuSC7MT_ZW675ni8gPsH2Du2q_Ntw7EAfuYDeK2Qi7xybYimM.x32OW
 MgryXaaaiamrQ9BvsoP1mkNPmmkcQj9XkpCsbWJTW6xeelh.nejsFmZQCkb1U7fM1C9Ld2kPxhBm
 qjmVce9bdD1fcEJ9JGmQ_zppz0kmcMw8A1IcNc0IZd6B9WnwYQPukQQuD7Bq2a_APiwjG67m8k49
 7peDXRcVq4Ne.8A_dO0Wfm3kggPDKClOCF2qEpNRFjR8LMFanhhlNKVnBaDwVOSIKkk39zmWy0N0
 rp9KsBgPchiiAFcx3WAFwbZFQv7CQMaCrDUhiJJxUGnnDcEI3.yIuK6hhiV_5QzjS_2U70YsYIs1
 p.KDafdTfzfh4ZfI5Pfcu6kWL5O6VSYfKuW0K1oIIkcSME9vZO38sNfVPbHbMIn3855cYytAKCx8
 StDWzAlFdZh4RxR0UGhP58jfV5_elzTJTbiD8wGmNtrb49vY8IvmVYtvs_ivxZnQUINBXSk9Jcil
 88hY4man_qzZUq0c_7XRPiXiT5yHn_tbkzD8lEONFHrSRHrdAsovwG72Vca4xnxqrHHZBGXwC1M5
 zRnkFcCnl8XhYnpQ_S4NnY0yktsZUWgzhPzpxZ2jIvYuyjl_IBq9dSbzCrvbu.O.FD.yKZaadJWN
 u2IVVpzm4IssChZe2R61Xwe8KpCXrK26bzlCv2E5M9BX_UIyslZCQfI4jaS5RAdqXdijgOJpnxA3
 nbzmA0csaIf2WvbHWVo2RELOd3ARTAwclBeF3vd0ol5tgDDN_pAVPUZoX4yFwInNvQjD2TRb_.Zj
 Vq8tjo4Fx.5AYgYsYN3s-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Feb 2021 23:17:25 +0000
Received: by smtp409.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fc488d4cca1df577bdc4cecba6f33c0a;
          Thu, 18 Feb 2021 23:17:20 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] NFSv4 account for selinux security context when
 deciding to share superblock
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
 <20210218195046.19280-2-olga.kornievskaia@gmail.com>
 <7587df15-6f6f-3581-8bae-a648315cfae9@schaufler-ca.com>
 <CAN-5tyGff24KwP-sTezU=h39_zTVTgh10D-6eT220SO=HSk3+w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9da50d82-85d3-3a2f-df00-586b8e3e890f@schaufler-ca.com>
Date:   Thu, 18 Feb 2021 15:17:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyGff24KwP-sTezU=h39_zTVTgh10D-6eT220SO=HSk3+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/18/2021 2:39 PM, Olga Kornievskaia wrote:
> On Thu, Feb 18, 2021 at 5:07 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 2/18/2021 11:50 AM, Olga Kornievskaia wrote:
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Keep track of whether or not there was an selinux context mount
>>> options during the mount.
>> This may be the intention, but it's not what the change you're
>> introducing here does.
> Can you explain why, as I must be doing something wrong? I'm familiar
> with NFS but not with Selinux and I thought I was doing the correct
> changes to the Selinux. If that's not the case would you share what
> has been done incorrectly.

The code in this patch is generic for any LSM that wants to provide
a security_sb_mnt_opts_compat() hook. Your 1/2 patch deals with how
the hook provided by SELinux behaves.  All the behavior that is specific
to SELinux should be in the SELinux hook. If you can state the behavior
generically you should do that here.


>>>  While deciding if the superblock can be
>>> shared for the new mount, check for if we had selinux context on
>>> the existing mount and call into selinux to tell if new passed
>>> in selinux context is compatible with the existing mount's options.
>> You're describing how you expect the change to be used, not
>> what it does. If I am the author of a security module other
>> than SELinux (which, it turns out, I am) what would I use this
>> for? How might this change interact with my security module?
>> Is this something I might exploit? If I am the author of a
>> filesystem other than NFS (which I am not) should I be doing
>> the same thing?
> I'm not sure I'm understanding your questions. I'm solving a bug that
> exists when NFS interacts with selinux.

Right, but you're introducing an LSM interface to do so. LSM interfaces
are expected to be usable by any security module. Smack ought to be able
to provide NFS support, so might be expected to provide a hook for
security_sb_mnt_opts_compat().

>  This is really not a feature
> that I'm introducing. I thought it was somewhat descriptive with an
> example that if you want to mount with different security contexts but
> whatever you are mounting has a possibility of sharing the same
> superblock, we need to be careful and take security contexts that are
> being used by those mount into account to decide whether or not to
> share the superblock. Again I thought that's exactly what the commit
> states. A different security module, if it acts on security context,
> would have to have the same ability to compare if one context options
> are compatible with anothers.

Not everyone is going to extrapolate the general behavior from
the SELinux behavior. Your description of the SELinux behavior in 1/2
is fine. I'm looking for how a module other than SELinux would use
this.

>  Another filesystem can decide if it
> wants to share superblocks based on compatibility of existing security
> context and new one. Is that what you are asking?

What I'm asking is whether this should be a concern for filesystems
in general, in which case this isn't the right place to make this change.=


>
>
>>> Previously, NFS wasn't able to do the following 2mounts:
>>> mount -o vers=3D4.2,sec=3Dsys,context=3Dsystem_u:object_r:root_t:s0
>>> <serverip>:/ /mnt
>>> mount -o vers=3D4.2,sec=3Dsys,context=3Dsystem_u:object_r:swapfile_t:=
s0
>>> <serverip>:/scratch /scratch
>>>
>>> 2nd mount would fail with "mount.nfs: an incorrect mount option was
>>> specified" and var log messages would have:
>>> "SElinux: mount invalid. Same superblock, different security
>>> settings for.."
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>  fs/nfs/fs_context.c       | 3 +++
>>>  fs/nfs/internal.h         | 1 +
>>>  fs/nfs/super.c            | 4 ++++
>>>  include/linux/nfs_fs_sb.h | 1 +
>>>  4 files changed, 9 insertions(+)
>>>
>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>> index 06894bcdea2d..8067f055d842 100644
>>> --- a/fs/nfs/fs_context.c
>>> +++ b/fs/nfs/fs_context.c
>>> @@ -448,6 +448,9 @@ static int nfs_fs_context_parse_param(struct fs_c=
ontext *fc,
>>>       if (opt < 0)
>>>               return ctx->sloppy ? 1 : opt;
>>>
>>> +     if (fc->security)
>>> +             ctx->has_sec_mnt_opts =3D 1;
>>> +
>>>       switch (opt) {
>>>       case Opt_source:
>>>               if (fc->source)
>>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
>>> index 62d3189745cd..08f4f34e8cf5 100644
>>> --- a/fs/nfs/internal.h
>>> +++ b/fs/nfs/internal.h
>>> @@ -96,6 +96,7 @@ struct nfs_fs_context {
>>>       char                    *fscache_uniq;
>>>       unsigned short          protofamily;
>>>       unsigned short          mountfamily;
>>> +     bool                    has_sec_mnt_opts;
>>>
>>>       struct {
>>>               union {
>>> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
>>> index 4034102010f0..0a2d252cf90f 100644
>>> --- a/fs/nfs/super.c
>>> +++ b/fs/nfs/super.c
>>> @@ -1058,6 +1058,7 @@ static void nfs_fill_super(struct super_block *=
sb, struct nfs_fs_context *ctx)
>>>                                                &sb->s_blocksize_bits)=
;
>>>
>>>       nfs_super_set_maxbytes(sb, server->maxfilesize);
>>> +     server->has_sec_mnt_opts =3D ctx->has_sec_mnt_opts;
>>>  }
>>>
>>>  static int nfs_compare_mount_options(const struct super_block *s, co=
nst struct nfs_server *b,
>>> @@ -1174,6 +1175,9 @@ static int nfs_compare_super(struct super_block=
 *sb, struct fs_context *fc)
>>>               return 0;
>>>       if (!nfs_compare_userns(old, server))
>>>               return 0;
>>> +     if ((old->has_sec_mnt_opts || fc->security) &&
>>> +                     security_sb_mnt_opts_compat(sb, fc->security))
>>> +             return 0;
>>>       return nfs_compare_mount_options(sb, server, fc);
>>>  }
>>>
>>> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
>>> index 38e60ec742df..3f0acada5794 100644
>>> --- a/include/linux/nfs_fs_sb.h
>>> +++ b/include/linux/nfs_fs_sb.h
>>> @@ -254,6 +254,7 @@ struct nfs_server {
>>>
>>>       /* User namespace info */
>>>       const struct cred       *cred;
>>> +     bool                    has_sec_mnt_opts;
>>>  };
>>>
>>>  /* Server capabilities */

