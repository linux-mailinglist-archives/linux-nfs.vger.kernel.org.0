Return-Path: <linux-nfs+bounces-10230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBFAA3E51A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 20:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31323189FF50
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310922641ED;
	Thu, 20 Feb 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DaJ+CbrX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913CB2116F6
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080033; cv=none; b=Iq3iyccK9NJ1IUY16gTtXbT7UbmhCAgLQw3LWoHDiuDObkoccKRcOembAwQ78c2G/KEuNFMUmb8M83lF9ay3Wh+LgLnS/GmPS8DR91rvD+RTpni87Z4tpA2XtVBKhoeDz/TMov9RsN1cX+J2DAjej42Iwtl9okObX+xgXJVjscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080033; c=relaxed/simple;
	bh=L2B8fhmR6cgVY+/YqSiqpdu72N0FP0w42P1X9nr7S14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pX9dO35abSS/MDcebdlYcOXZxZJreHFAQoAGziJHeBD3se8rNLt9Yrk75gRXyo3FjPf+ulGNe+545ZvuKJzotttxmbfG3lAB/EByV84zTC+Wy2PaiwdRk4C9d1xS/ok/ojGqmQ5Cv6Ev2zm1yWY1R8RZj5xO8vw+/xZDiJH5PDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DaJ+CbrX; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740080028; bh=QfT77oocgKujwcHeSw3GgbvLEZpT/2UpSnIYihgkFUo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DaJ+CbrXh9zFKm9lfQcHnaJ7rThGRd5XmVE6GrziF1D32cZRraFi+Qv7i0FtdNccgFBk/axx5pzjrq0c7x0mR6TwK/XvGPdoA+Xw2J9sN55zV4DznBYXU3Z3F6wFdkT0buxyYpcynA/5C9SOGq8ajcrWDi1vxicFRJOA/qtdFCW2PhOMqwKUzZPr6JXFQve9ESGDF/r6p4iNv/GppbaVzd4qUuUwQpy5+IChNXpzhuHOjKM/O3IsP+jamOoO0BYEHGdhRSp5W0jYVlG8anAUkhCRIFWUz+4w6J0JtolalrBBy0cwp7Ken6jf8KQRaVC+l941XAGn1bR2REwshtLoWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740080028; bh=obNDSqqCTHWpShmhA7G9LfPt7IazUUA9l6ZxmMgPFLs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=d4Fe9nfyA+prWK2GTn9pB/qUyvT1yxp9B+sQJUJoiDDZgNaEokIIegwnsNZzzffJwLSAiqNPSQOYvfKRzfcILQ6etdIcldCMLBNUmsrTAYrheb5yp7P9sFcY87PpAktgZKKZNpLlDBrUo/E7H7KCqyGQUsakKQ6f0kRMuB8Sz9fUT7D3YY1Cm/1ufR2i6EJ7wUvSXWsyBg8FXb/mwE9AFaaXGjfq6wWcG6SAuuWxZxIp37yMoken4+C6yxCjAv4oJhNF3m70GVlU0yKYaHZkgB6jMAKM5U/Nw71OsDUvcYlHMYCeRAPwElB6n0ha9aqvhqxH+FzkFcekIj2mCmYOsg==
X-YMail-OSG: 46Kge8YVM1kThUNpdteb61.GaKQ_NaLoa6Okg.s_b9HXzRO2gFDdvfiF7pQe9oD
 XWgQBMgTsfyHcONgsaRSU7lfgsvcF631JYgbCRw3GASxSN5yc4CyvnG.orhi8Cnr0i_JBAthd8eD
 lBNV3frO.xLjGOWD7jhH5cEvo1MMclRyQ0gyGM7qkpi9K3tAjrbxqhlhTg9VfWZ2eAh1wKmSOQMK
 TAZKpFtIeoougtBMXgwdBMUx0UCPaXXR66SFNt4WNQuUz9I9OSaeiddKmCqbdQR2swwExg42.Lea
 pryXwTPtwC4N1Q63Wilr3LAVbUtB6G74Tc07uy9nHBEGDUcQwmK3DAoRAB4VRuzpvtKiwkdWCe5Z
 TAmHtxJA7d4R1ABXI676rR74Nt.D97NQDp.FG5fMqAxPVU8TS5S4xQ_8dCg9rq9fGuBkJ9GTryRb
 VT294JnIWy0UmWSpl6VySgy2O.q21wsPwM2hVBKZgV3wpMC_kEfiwgn98YsKHdHnKLrss.Kzzj.2
 haF.SGbcZil96EQZiinDBuMhKF2oBkyYIpC9zkgkAuVuDn38vh7jxfFXa3PwIy0wJY5Q_0JGgLjo
 Wr_KE5fsj0PUjI7GQYXku6GBnusupnhmqaKX6IkBQ5wg.KsT0Jm_pdCe_gbdtPZTHzskasWdYcms
 eWNk1IrcpyK8lyecdQhRdMHRgxgnfpMW7lKDYlgZ7Yy3WleOIYWofOGGVXneB3e6TiKnZ33SBhgs
 4VruxUuVyFaKdWC_LMEBxcvGq4alaDdS5H1n1IJT.PTz8vLDLjRrSJNRHTbxYKQLOC94aVB0iEMF
 hgaI6FnZrLIfaTbhCEr_q1tpVmhK0eJ7GtCF9wqc6p2UsZbomYHO0oA_7KQQBai1aCR_lqJzjIY4
 sDDNUlGuR3pUF5gFm8kQzkNUqYC0NsWbjXnpKp.TR6JSyTBm46XQ2KonW4APDbtDx1tZ0KqE0ln2
 vXefJs32XXaEiWuaFwYBuHVJpF1v2gutEbOT6ZIM0EhFCwj_Yg92Rf__b4db3K5RimDgblrhgyGf
 zrhGSVQntXlvS7pKrKoJurK.gmNFKyduhwJo9PbNia8W9Dw2xoqUi67xTL1zRgUM2UTJbRDJJMTM
 97o6ba3aBtuXWcSro5_3TuCr4dUF2qvSFHCKAMQNGJ7WWECrkv92Qh7Cl.9XuMgcnuoJVksBreLf
 ixEytA3PExhd9WHq9PPfm7f9IjZlKcEZrfIQX9hroD7ArkVkLg4ImxLGRug3jkpFl8gZeD4LQxsR
 CagCHNoa7ORthtmurVUO3a6xafKxHBxpvwlnuwmozh_eJnbG1osfbK3sNe_PMNHTmGoO2bEPIXDf
 zLiYuipsPMy3UZnMTSszkLDpf4qCPHiuqsHCmSChzctAS3VD1iM0JT8K3aiRr5e72OPlftQ.tDgy
 4JeGzxO6BaYy_AcrDqcfmdwkUQpJAGLYZZMVMZVSewlCzmmanNNOZ3N7CzFZm5oRJgCzH8XTXIzR
 AET.xEPAy2PwAvZT4VEikX0qGmP9ZICN83XN2Cb2cWHfFkjOOeV0YN8rwPEKvrVoylu3P7loQ4tq
 llvxV8XRJbIUPz08fz84FjLm8wshfpP1nGOznImANsSQ0LmbjuzoTUhumLoKfFPm_vyQ0u_Y4Yee
 fwYZ18FvBvasBreDpcTG9_kcuJlqC1eA2CKYKmxh.kAOIJgePGA19rwomw2TnZhkK97TLE8M8NMd
 SFHcCzkK80CrhlTNUR2ye57bGq21WNfiJlE1b0HG.9KtGNnSgUlfVSt0_Qwt8JMtvQXpOidi5FH1
 faWMcU2ryaCi10wCg0wWI2.QE29WYDMEVto3oiz2x.95a86jdo.E6gkhjGLr67nZBhGAgrYdbqcX
 fhl7H_HANi_VOkveD1SBXDVI1cmKxY1oyVIxA1lsAjYvpZ2RnllHcW0pUvR5ko8zjrr8RTC.93sk
 TehnJlsZ0DWetg5ICSNBPJieJseUB6UyHwIHTzOZWXGrRr8ntcSFn2rHg8KJBgu7ANBEXhFt5Gsf
 goXuXtGRlH9BfdWgNzdJfhSEcvI1zePk3TJAKfzHPgUfFFLkylzmRIQNGs2wDLcmlBHEeCODMJ8a
 h0KTrbj.mgSOzRFUSagkMiHtqYdjOfXEYlGHLPB_.S.ZKx_KvxLZpo8._NPANb8nLXPzztA.RXHg
 Ca0AHkmrWUkHIvd6_SoSJiNJv3Z9hVw_.KtC46swvmCYJjfMmMw1d5b2II1bWW4E6Mi8Na63UfZV
 y.d2qadnp6gatxyMXBLrXxpWYGU.bvDmfS_edL7CK4oTz0NbJd9Zp.1QGJ6JP_wjOTAodQTQENKA
 NWwGwSqNH53zB4SbLsAX9XVyhf6boLegB
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 01dc54d4-af76-40fa-b519-814531b2ce31
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2025 19:33:48 +0000
Received: by hermes--production-gq1-5dd4b47f46-5qmz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 881de3a23faaf0c3c14e579533687f9b;
          Thu, 20 Feb 2025 19:33:41 +0000 (UTC)
Message-ID: <1b6af217-a84e-4445-a856-3c69222bf0ed@schaufler-ca.com>
Date: Thu, 20 Feb 2025 11:33:38 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com>
 <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
 <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
 <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
 <CAEjxPJ5KTJ1DDaAJ89sSdxUetbP_5nHB5OZ0qL18m4b_5N10-w@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ5KTJ1DDaAJ89sSdxUetbP_5nHB5OZ0qL18m4b_5N10-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/20/2025 10:16 AM, Stephen Smalley wrote:
> On Thu, Feb 20, 2025 at 1:02 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Thu, Feb 20, 2025 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Thu, Feb 20, 2025 at 12:40 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Thu, Feb 20, 2025 at 11:43 AM Stephen Smalley
>>>> <stephen.smalley.work@gmail.com> wrote:
>>>>> On Wed, Oct 23, 2024 at 5:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>> Replace the (secctx,seclen) pointer pair with a single lsm_context
>>>>>> pointer to allow return of the LSM identifier along with the context
>>>>>> and context length. This allows security_release_secctx() to know how
>>>>>> to release the context. Callers have been modified to use or save the
>>>>>> returned data from the new structure.
>>>>>>
>>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>> Cc: linux-nfs@vger.kernel.org
>>>>>> ---
>>>>>>  fs/ceph/super.h               |  3 +--
>>>>>>  fs/ceph/xattr.c               | 16 ++++++----------
>>>>>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>>>>>>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
>>>>>>  include/linux/lsm_hook_defs.h |  2 +-
>>>>>>  include/linux/security.h      | 26 +++-----------------------
>>>>>>  security/security.c           |  9 ++++-----
>>>>>>  security/selinux/hooks.c      |  9 +++++----
>>>>>>  8 files changed, 50 insertions(+), 70 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>> index 76776d716744..0b116ef3a752 100644
>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>> @@ -114,6 +114,7 @@ static inline struct nfs4_label *
>>>>>>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>>>>         struct iattr *sattr, struct nfs4_label *label)
>>>>>>  {
>>>>>> +       struct lsm_context shim;
>>>>>>         int err;
>>>>>>
>>>>>>         if (label == NULL)
>>>>>> @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>>>>         label->label = NULL;
>>>>>>
>>>>>>         err = security_dentry_init_security(dentry, sattr->ia_mode,
>>>>>> -                               &dentry->d_name, NULL,
>>>>>> -                               (void **)&label->label, &label->len);
>>>>>> -       if (err == 0)
>>>>>> -               return label;
>>>>>> +                               &dentry->d_name, NULL, &shim);
>>>>>> +       if (err)
>>>>>> +               return NULL;
>>>>>>
>>>>>> -       return NULL;
>>>>>> +       label->label = shim.context;
>>>>>> +       label->len = shim.len;
>>>>>> +       return label;
>>>>>>  }
>>>>>>  static inline void
>>>>>>  nfs4_label_release_security(struct nfs4_label *label)
>>>>>>  {
>>>>>> -       struct lsm_context scaff; /* scaffolding */
>>>>>> +       struct lsm_context shim;
>>>>>>
>>>>>>         if (label) {
>>>>>> -               lsmcontext_init(&scaff, label->label, label->len, 0);
>>>>>> -               security_release_secctx(&scaff);
>>>>>> +               shim.context = label->label;
>>>>>> +               shim.len = label->len;
>>>>>> +               shim.id = LSM_ID_UNDEF;
>>>>> Is there a patch that follows this one to fix this? Otherwise, setting
>>>>> this to UNDEF causes SELinux to NOT free the context, which produces a
>>>>> memory leak for every NFS inode security context. Reported by kmemleak
>>>>> when running the selinux-testsuite NFS tests.
>>>> I don't recall seeing anything related to this, but patches are
>>>> definitely welcome.
>>> Looking at this quickly, this is an interesting problem as I don't
>>> believe we have enough context in nfs4_label_release_security() to
>>> correctly set the shim.id value.  If there is a positive, it is that
>>> lsm_context is really still just a string wrapped up with some
>>> metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
>>> be okay-ish, at least for the foreseeable future.
>>>
>>> I can think of two ways to fix this, but I'd love to hear other ideas too.
>>>
>>> 1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
>>> and skip any individual LSM processing.
>>>
>>> 2. Define a new LSM_ID_ANY value and update all of the LSMs to also
>>> process the ANY case as well as their own.
>>>
>>> I'm not finding either option very exciting, but option #2 looks
>>> particularly ugly, so I think I'd prefer to see someone draft a patch
>>> for option #1 assuming nothing better is presented.
>> We could perhaps add a u32 lsmid to struct nfs4_label, save it from
>> the shim.id obtained in nfs4_label_init_security(), and use it in
>> nfs4_label_release_security(). Not sure why that wasn't done in the
>> first place.
> Something like this (not tested yet). If this looks sane, will submit
> separately.
>
> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> did not preserve the lsm id for subsequent release calls, which results
> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> providing it on the subsequent release call.
>
> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I'm not a fan of adding secids into other subsystems, especially in cases
where they've tried to avoid them in the past.

The better solution, which I'm tracking down the patch for now, is for
the individual LSMs to always do their release, and for security_release_secctx()
to check the lsm_id and call the appropriate LSM specific hook. Until there
are multiple LSMs with contexts, LSM_ID_UNDEF is as good as a match.

Please don't use this patch.

> ---
>  fs/nfs/nfs4proc.c    | 7 ++++---
>  include/linux/nfs4.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index df9669d4ded7..c0caaec7bd20 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct
> dentry *dentry,
>   if (err)
>   return NULL;
>
> + label->lsmid = shim.id;
>   label->label = shim.context;
>   label->len = shim.len;
>   return label;
> @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
>   if (label) {
>   shim.context = label->label;
>   shim.len = label->len;
> - shim.id = LSM_ID_UNDEF;
> + shim.id = label->lsmid;
>   security_release_secctx(&shim);
>   }
>  }
> @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode
> *inode, void *buf,
>   size_t buflen)
>  {
>   struct nfs_server *server = NFS_SERVER(inode);
> - struct nfs4_label label = {0, 0, buflen, buf};
> + struct nfs4_label label = {0, 0, 0, buflen, buf};
>
>   u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
>   struct nfs_fattr fattr = {
> @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode *inode,
>  static int
>  nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
>  {
> - struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
> + struct nfs4_label ilabel = {0, 0, 0, buflen, (char *)buf };
>   struct nfs_fattr *fattr;
>   int status;
>
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 71fbebfa43c7..9ac83ca88326 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -47,6 +47,7 @@ struct nfs4_acl {
>  struct nfs4_label {
>   uint32_t lfs;
>   uint32_t pi;
> + u32 lsmid;
>   u32 len;
>   char *label;
>  };

