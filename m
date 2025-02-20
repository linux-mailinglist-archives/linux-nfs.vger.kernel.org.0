Return-Path: <linux-nfs+bounces-10222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656CA3E396
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4FC19C10AD
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66474214A76;
	Thu, 20 Feb 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="erw5AdiT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56450213E81
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075365; cv=none; b=T9glqPgqh1wALwVEp5L5tM03Tnk4jZ72hmsBbq2S5U0uPcWcCC9e6rErG+1lHvfwHvWjGu4hjUAH6qF4vp35DBeXaIxN7FZ3TnIW4kEqZUHU5ztKXFYi4yCF+m3PHnUOBFXAzpr1n0DfxuIRZUHMnrE2U8BEu7dSm2YRGc/5SBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075365; c=relaxed/simple;
	bh=7gF/xeF3KxVHJC7Cakip75fKZt4w4wigOSZbdG7eJtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFxUQsPXpX2Mws7U5lI5i0jcA77exTMy79HjZWWDFsiQLKqdmNsJJnWE9fTFBZmVfznYNFcUYVy6UqCVayOqLjv44FqpKma+ArmjybOEelxh2YR24yXr8IRpZwy5VpLVr7j9HqncIknML+s6s8gIwqtAMQh8lziMpSsLg0x3bmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=erw5AdiT; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740075356; bh=aS8gcsRBR/zrF1yitnJwwHI+bsaXMAh0KwyQVF1d3tA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=erw5AdiT58G6upSYTzofG+AbLC9JppX45M1TDQ/P1tprlPvxE/s5VIkZiUIGGpzv+eM02HuoehemwSvWE1AdT3PRg8DnJNxclyn5KmuMFitss1rTOv8JInOckMoVFTMqxLnHNtkkiIYaQ5sTTz7shNkXnUhddzrRoJxFFAzmb9Qej0PtDmyiZoKjKvGPokQdNmnk36RzKb4ZsP0aI3/q/JcvwyD7BsXqa7Df1k7aBaEoLUNBbEn2iQqxbAyz7xvAMeE+dvtHbECvhKAQcWMxR+2o1zKJxGvZw0M8Xp94BVuBUX5OufMo0pwNrQ1NngkFqXqzdxOwu55RlRvLqhWROg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740075356; bh=nJ5FaLkuZEtPWGMx3ZRkNV4kvKPwzVLeqnEeS8hUOMd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TWHr36ndESOiGD2Ayqyme5ug7wLJ52BPlLIRC+/Pk9RLXyLllqS7sVP/cWJoW5GgXavKG4k7qa2KmO4l0YJivfjL95vipgihu1QOdPlqm2z/9MNu16fKIX4mU0sVdHP1m9WxxtYjPUtcEHQ9A/k5reKInTK7sqg1UKQKrSPlI2t8BO3BTPSE5jq99uIjSAcaqrSPU57hO3AZfV0N+UkE/65+9FZccqYnqJt3sBworr3MXwWFeeGFM3u7TFUjNyO3LJXt9gL/pfg/g/1784eZhyO5wG5WPAnKh2Pzn8N1a7iY2Qt0csD/3CWnM97Q/KOL/+jHplQwUSGyH2IZQ5QfpA==
X-YMail-OSG: DmbLLHIVM1lpGOjMqhXIB3KOoeq5QQiGAfNJcyTuxXUYxI0BQ45zOqbyfqvTJCE
 cFdRYpkUeOH90X232dxIDw13eO0iYkZ0gKuuajHjsT9Xj_WFAstVpOFnmkFLdiJC1k_.IYT7.OUO
 npGGuq7vxsoyy7hMdQ0Z2Sfg2XZYgeTcpluuA9NGYXNeQA9GtEelwEpcCaP.w7zGlR5nF_OpmQkR
 HVNktHxan5c7pRvDpCtNuSURSTbsC9EXWFVjfOG3g97_zFe1wWrHVOArwgzFCFkhuFMGLgXh8Gr0
 hRVsIh4ipdE71vJqQP2t8To78j4O2ddiPD6RH1YuE79c6.DSHCOEzhaVDqzFZ_GT2a.AHL3O_j5I
 fMmQheKrIpJ8twsrhNquKKgM4I4HZLNuhRmZUuAa9K6a_XSrMxpK.thz3mwS_LigJtFoftKlXnC4
 lRlAxMSypAfFaSWHiyTqNWAhFoOmXVHcxg60p0jeDsbRtRdDH4vTwwT4lHspivfeGo37hlcypchh
 Ow8NUDPkxn7g6IXzhnwp0HpZ4kQOckTSaqP_l3zeEIQv9h77CzkEPZKPIzgTPnIp.XjPlAF006cj
 yeGG9gFw9z_4V5EQgHmaCTLvH4lgSCH4Y5LCZAPmYlDfYwEVN816go3K0n7X6vIGfnn5hGNR1Nzn
 EW5h61TviwFDXUrxP48r3J3agKM60IjhPRfg1xHov4bqZP3HJmhA1MM1t53RDoJDZS.usOX8wNhJ
 Yr47XvpvdJVphlKrsV8PFW4Rb27orSQqGME9wO5pZ2VvljPKjX1nS5PZ3gLNsmhuhSNAv3kScuCC
 lDCy.LOP6CTe3Lghl0U7qKsBoYiw0F.AA3sKm2dtrCUX7uWXciGKfTGF83fqoYU5PeWyIt2cOSdN
 xDuIR0kJPZ7ez_ZFPZfYXc5GHVdyfZVn4FwT2hH8ZmCvBO_g5d8OuRMDwLXW1Fjpb.I.m1n7kWcU
 ZK4Z9l47bE7EW9hWK4C5leW7Iz8YHgAsv6sfi1.gNPUrXIZFVMLXq59w2w1y0bkbXrPqAyRak8iU
 peB2lOOvh7.11fXK3tQj2HwwfmJjZpVvvL40fnC2ZcbwKackLNHWzCcs5JCcQ7GrTK9MlQ6wAQvD
 mwh4oM.37K61nku0s2lsSeJeBTlPNKDftwECkZZzHKKkG21YjJjOLdDaiv.LpoYmhiClvOZQHKFz
 ZTvknLTnQZTjadsG7QcBHRb6sE5Whu5bCuT2DKyCDGb2NLg3y7z1DoAWuWXDieAYhHQ.6TykaKav
 jtHYgex22P2nCy0PrYJ9xAWGLBhTxr2UwAxW7xEZkzqliaF7UXdkiDxzfsE6aHNx9a.yN4OQwgEu
 SYuBHxRNWrIJX6yZ5AuqWorQEGIVEJyY44RAkorKuMyrs8_NUoPO.JF68XHCvDJ1.o8O8g4vFmzS
 hZV6ViV6AxlW8SUwAmV1PyXIIoWYhzPEsDoSSLZUsh4_p.ORC6foxrk.1QScbMGtGml2bBZgEDYc
 GckYvTZAbHypE1OuSWZUDQhkJwEOzxqNZkCygEwlAUNd2DOF2i139sWDdkHOHf0oV4oOhtV_mVrX
 PFxl.ga8Hh1T_2t06PYBUqJW8BNKUv6nRz4NECLeZKAIINGOfSTgdLmkA4pD8MqwwJ4OiQMr8qzv
 chyW2yqjdUXwxhYgP3C0Lsc3l7BNsC2ajzo6g12PF_81oFrHK5Wnnjd0ZBvbDd0uojYgR5bW78aF
 JOzc5bsgbMtVSHBEzNpLDjridx_hCWKwDF3m7uMU62Fi__Q8qw6itY4hRSf6229Ume0fARVNzLHA
 fCuZqwKn9VF8zMRJ8m6WdkgHGuEvnfdV_OGHi_rcOytekkjOzSfL3eFi5rdr964mzNA14iuScr_s
 TJgIeOqKAlRBBYGWqJ8e2UVNN0yXJ2FsSAKUsv_vNQYAFLzMCXPrsXiIHnHv7klwCOpvXjU0iVU.
 GMJeEfQFl04OMzSFmOh91UgUd_CDymNxqFXHE641QemPCWyi7tGWvn4ISfH6hM1.xSYmzzhIZSzK
 HX5zlaQRBUFr2ZmsmeinjTCZ0AW_Mw1HzbitMorCA6Jum90XEzzu1QhYVpqmhTaeqkMAOuLsNf4x
 rsOzAl2QtzFaxa4hvfX_IWieJ0VWrcRrXDWx8t1yCqsRTsTTDRl4e..7CaEJ3tzh_Fr9opWqS3OV
 w9ad3wVda6BoTFtx.qD79lqHsiB7jYPdNSxArN3MYst5BT7lhKmp.W_dET8bgYVLOQWOlgHsH.5W
 H3jEV0fLrsigsfeGsguYq4oaVI5Slg6ELcVb9nOhPMw79Yc6uOZdamrObwXZVE4zJRnya0Kp3r0T
 lipRzil5z8AMjbOvc_4hk3uOCuTGW4g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e7cd0778-89ac-46c3-88da-25cbc8142cda
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2025 18:15:56 +0000
Received: by hermes--production-gq1-5dd4b47f46-fhdpd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c80e681d23183d55c645547b66bbf385;
          Thu, 20 Feb 2025 18:15:53 +0000 (UTC)
Message-ID: <61c6e6ec-77a4-4fcb-b761-c3599079e71f@schaufler-ca.com>
Date: Thu, 20 Feb 2025 10:15:50 -0800
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
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/20/2025 10:02 AM, Stephen Smalley wrote:
> On Thu, Feb 20, 2025 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Feb 20, 2025 at 12:40 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Thu, Feb 20, 2025 at 11:43 AM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
>>>> On Wed, Oct 23, 2024 at 5:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> Replace the (secctx,seclen) pointer pair with a single lsm_context
>>>>> pointer to allow return of the LSM identifier along with the context
>>>>> and context length. This allows security_release_secctx() to know how
>>>>> to release the context. Callers have been modified to use or save the
>>>>> returned data from the new structure.
>>>>>
>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>> Cc: ceph-devel@vger.kernel.org
>>>>> Cc: linux-nfs@vger.kernel.org
>>>>> ---
>>>>>  fs/ceph/super.h               |  3 +--
>>>>>  fs/ceph/xattr.c               | 16 ++++++----------
>>>>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>>>>>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
>>>>>  include/linux/lsm_hook_defs.h |  2 +-
>>>>>  include/linux/security.h      | 26 +++-----------------------
>>>>>  security/security.c           |  9 ++++-----
>>>>>  security/selinux/hooks.c      |  9 +++++----
>>>>>  8 files changed, 50 insertions(+), 70 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>> index 76776d716744..0b116ef3a752 100644
>>>>> --- a/fs/nfs/nfs4proc.c
>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>> @@ -114,6 +114,7 @@ static inline struct nfs4_label *
>>>>>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>>>         struct iattr *sattr, struct nfs4_label *label)
>>>>>  {
>>>>> +       struct lsm_context shim;
>>>>>         int err;
>>>>>
>>>>>         if (label == NULL)
>>>>> @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>>>         label->label = NULL;
>>>>>
>>>>>         err = security_dentry_init_security(dentry, sattr->ia_mode,
>>>>> -                               &dentry->d_name, NULL,
>>>>> -                               (void **)&label->label, &label->len);
>>>>> -       if (err == 0)
>>>>> -               return label;
>>>>> +                               &dentry->d_name, NULL, &shim);
>>>>> +       if (err)
>>>>> +               return NULL;
>>>>>
>>>>> -       return NULL;
>>>>> +       label->label = shim.context;
>>>>> +       label->len = shim.len;
>>>>> +       return label;
>>>>>  }
>>>>>  static inline void
>>>>>  nfs4_label_release_security(struct nfs4_label *label)
>>>>>  {
>>>>> -       struct lsm_context scaff; /* scaffolding */
>>>>> +       struct lsm_context shim;
>>>>>
>>>>>         if (label) {
>>>>> -               lsmcontext_init(&scaff, label->label, label->len, 0);
>>>>> -               security_release_secctx(&scaff);
>>>>> +               shim.context = label->label;
>>>>> +               shim.len = label->len;
>>>>> +               shim.id = LSM_ID_UNDEF;
>>>> Is there a patch that follows this one to fix this? Otherwise, setting
>>>> this to UNDEF causes SELinux to NOT free the context, which produces a
>>>> memory leak for every NFS inode security context. Reported by kmemleak
>>>> when running the selinux-testsuite NFS tests.
>>> I don't recall seeing anything related to this, but patches are
>>> definitely welcome.
>> Looking at this quickly, this is an interesting problem as I don't
>> believe we have enough context in nfs4_label_release_security() to
>> correctly set the shim.id value.  If there is a positive, it is that
>> lsm_context is really still just a string wrapped up with some
>> metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
>> be okay-ish, at least for the foreseeable future.
>>
>> I can think of two ways to fix this, but I'd love to hear other ideas too.
>>
>> 1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
>> and skip any individual LSM processing.
>>
>> 2. Define a new LSM_ID_ANY value and update all of the LSMs to also
>> process the ANY case as well as their own.
>>
>> I'm not finding either option very exciting, but option #2 looks
>> particularly ugly, so I think I'd prefer to see someone draft a patch
>> for option #1 assuming nothing better is presented.
> We could perhaps add a u32 lsmid to struct nfs4_label, save it from
> the shim.id obtained in nfs4_label_init_security(), and use it in
> nfs4_label_release_security(). Not sure why that wasn't done in the
> first place.

This is all an artifact of breaking up and rearranging the full
stacking patches. My bad. I have to find where the logic for releasing
this got lost.


