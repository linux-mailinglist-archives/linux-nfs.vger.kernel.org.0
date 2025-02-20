Return-Path: <linux-nfs+bounces-10233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC80A3E5DB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 21:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2609917FDD5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B6126389E;
	Thu, 20 Feb 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jtvDgRad"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16F1E9B29
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083492; cv=none; b=F0RbeSZEOCZcLDUuEefV5gozZZIhpWxZ+26jvhO2+QprSwj6A4d1LmuOQ/IgSX/64/0AvFRIE9iRviNgeN/6oDA2ZOHykb1O5j9s7qdbqiWVXs4RFiZflnTro9ziZWL7F0Q69fJanAO6XqSypLH8V4biXGj7P8jed/liL7DOrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083492; c=relaxed/simple;
	bh=d/3FqiLdzWOdjz0PG6ytncZssG9QXCKrrKuPpYZ6bq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFu+5IrBDRgnXSRlbfRhG5Ihjmhs6gJ5qCRx119S6UGRfxI2MV04kE0xQ1YtqTOGhD11RtPW7z4va3fRfoB7SAoRYJMA9ZU0lt5vmzAkgh1AQJMQ4RAojNSv/wUpYXQgk6muKTYJZiUKqhm5mthcAQd1olqClklFtZxCGMOCVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jtvDgRad; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740083488; bh=fgTo2d6NtjHPueDo2KAAJhEa90dOTzWdqu55/iRf3EI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jtvDgRadKUDfRgcs4pNz+dt1ihp/Ew3RKG3obHes4a83qccafT/QD4F+P5kOYMeT1o/vyyKrrOC1/RXgpHZFRSbxXL4lDlpNcwSTTv+GMuIAu4ld4WATAvUCyxmKc8kCLX/jr7hxIZTvgeYGQTB0pbZcqaUJPhJuMQw114M7UYuD90I8+JFcN1y6BCbYQbaytnB60sujnmkwUw0MyuubUTB4bDr/rG5LccbLUp6eMxYk8X08/nAAyCtOSjUD/MiicnhrDkbgiL2I7aoeEMr2JZ9MqZByYbkSxZZ7x3H3EtCkRCffu4iOTa7XBtHruwJrllScryfPZ8XIvaWjU9Q17g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740083488; bh=ajikE1QVDupOcUWzirPptAv9RUFux8SGaezz9PwiwU+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UZmuUwONGYAvshX1F/n4DiRXUlwFjiBQJcJSsBOVN2o29wnG4ucWvipOqx9iqt4sJFgqJtF76CyvJhLp+YTZ11zcyYaq388HlulOgp3V1/wet+po87tOz/ui/ai+oM8350ex9wklhrYQRWl/v97iXVYn6cZPSeXE/gW9k0yQ482jJ9d7pOCP93K50YYRnIDvlmJsz/SPpJUFMStdCfzP/uhFd/GQm1Uf/IghbWExy9qXwzLulhXeaEQgbxPrn+7WnrUIGIInrRv4BKDXQveIhTCRjUdyeUTK80JiFAwL4U9nTkIdqT12fpXI9Qux5MIN1bw7f7Sb4iutSpx/I9rOTw==
X-YMail-OSG: OtlB4bMVM1mMCjAqCweJUyTMrLIOKU54Qs4qj.Z7CBYqcIqJ9nDohZESaFUm5.w
 JkqZRrs9Ekm8Of0cZ8nvI4NYQKflwsNYQC8hQb5BdckY70Efmifp4yEp1j61MqffaPEi85BpW9qS
 k1mV5D3U2AARZ.wIFbtwIu1kWI7U0jDpRSevfruyCyy.A8VeTeoXtCYpayujJ_4WKkhKYypqi.y0
 Niejb6YVKae2EVuOeIJIOLfsHU1KmZh1bNybKu6vIm5GgALZ9YevCgfOtCwdXRU5dqAcP2qrpmEG
 iYNQ0tkheZIVCmFdQdrsSSuTo8.bZ_bFyJ6KTf6KfhXFLkowf0UlYleYOgfSIwF7yDu7XxzJEPx.
 q6PCvU2NlGAeTapZP3gS3biFxd.V5JD283JKDKwbv1kJa9Cca2BhH06NBN97kZxDzri1tu6.1LN3
 xljwpE0Bgy7SIKlx4ppVtSAG2owNVVNwyZnvDyLk.8tqM1_FG8fyNTGCIJYXhtpS778c7B0zryyd
 O_9zjk5j7fh__lFaFZRZH.feTJipOQXiVksAIMbjRJEbyWxVsnOHxV0XsUx2_vjWx8K709Nbnuyy
 iBHXgx.aC36TfyLDR8MnQQUDQ2UbpDQ8ryIRy.3WXbcTaRYIXcHiBDOJDdWBpi1gVzaz4zA62zIG
 oMaWqsi7tt91pC8ue6cvnJqhOktgYRSVMr3s7mur94JwYmLMEvcPyma_9DIiTf8jS0yZhR1fy3rJ
 X_vJp5xGc64fcEqzr0PjBlHOpi8gLQAZtpFGEVW2NTQeSu1Ojr7ogTDgbbB.Y0scq9ALHg4jIzk.
 KhKzYJaaEYXgRVpEWlDbf5h5ucXeWt5yPY9SgwAO73HmRS6rqLr.R3RcAVZTogARhPEjzVm7zE6A
 dCsj4Zq43fiH9EX.sUxksN4jG49t60vazOurAoGIWaszL5KlOXjDggtWS_JItc7OXROcFps2_xhC
 vqNuADWx8ScYfy.cEE3mpxsRZMT_ya3Oag1eU_JbpBi9aTVE.fYBy1OfOG_SNkamgQKfsYHZpJzS
 zwaCraZa8QXwG6ZzbdWLdaz.8DnIUPxqr1xCPiDeUnnEOM3osNPX2FPuOUpMeahdJmYf_SNMnwpv
 ubimBsutCFOQ06iCVt5irK_uKjvMm2cw0HgpQlrlnsbcAfU7vXMXse955aRiVLkj0mEqTYc0MoV4
 L.UMRP3gnanCSMwBBLSiEskFLvs9PXdAL1gg13c9D9pShEU4SjeE5ncE.gsg1hIpS.AQp8p.GHCO
 Lt8mmuZzaxmP7ocgCoFEeUBa50gSwKHaI8H3OYYGE2bhrlzAFfzybhFpQ0jfzd_G1iT5z.iMtyKl
 N3DQaNEmg_J5nDUHcE45LsYdr9Et1HpowvjulL1h.PcyENsg_ewiHzhSHw37O6qFYRXYwaCcdfMQ
 q5GFOvrVr5zX4Ixgsr9nmZwecUIb6xvTGpreH9A3q9aGdkB5u5YCyZmHLU3YFKvNn5yb8GPGs.Eq
 sbnR7auhBYtjOHhs_NoqlW9FikVsFuwhoZkhqyChHJaoLIah8Gaah1f_VvNwutnln1Ihh.1WS0Ld
 oVF5uQ.fHBf_cUfDkY4QrSBwMGb3P.xxzNv2e2l1ociIYOxoaTp4A60zHKkRsMqMiWsU5bMZ2wd0
 0ZdntLjKaf2ltcl96EiShiitdvUClTe60S3KNNPRrd5m83gJzIAx4W7_UZBdoAZ.XLYEVzIrTo0V
 LZzgme8Yt2zT7fvYvqecVKAxPqHqXDqjPn4c7OhmM.rYZs7tH06I0Z3XudIrtHcK8v6X_REz3llc
 KetNKNZUHSOd.HlWFAWMeldnLJE6RjTDzW_E9lZDbBju8fp0Nu3uUGfG3SFOzfYcby_7NmX.poEQ
 thBsJ4OruOzMdY9r1ZPtxXYmGQAZyvv1Llif9rpaFb9a5d2_pR.QjpTaldjn1Vv5NigVkcArzAaA
 VQNLjNVjTQIeMXIV.GMwTHML1vQqZNll25O2I2HQtyX0JhTQ4QO74Xiab1rQBel_KfI5JJqW2hWg
 9OZOmsrYlQESHk4uE9iI9PLjlhbRGKPNtimOuZtJph3D5PRo2XJ5iD8El6QXr5HqD_LBJnVK6BQd
 J0d2AUgVeEH6wxfFVRJ0LTLLPIgoMMRx5oxGqtGD5_kl0yizX2pR_KrrRIaU60jPZP2.x5GWTzka
 f1PCOko9IAZtSBWjLcSX.vOlwr.7nDa5DPxsrsXpPiGillW7dHwU4TMYARKDJrUkSxIqjpmjrvPa
 iVDPIhb2d.Nk7Jlime88iNP_chVzXJ09blebu1wLL3cfvcW6iRyW4.y4I3OhsfBWjqc6FbSykYhX
 vfTVeJy6qBEV.ONdYohveZfejYQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1e0edb76-3636-4367-9793-a6623c898840
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2025 20:31:28 +0000
Received: by hermes--production-gq1-5dd4b47f46-dvwsq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d98218f19ea55084dbc7a9596a27abdb;
          Thu, 20 Feb 2025 20:31:21 +0000 (UTC)
Message-ID: <eba48af3-a8ef-4220-87a1-c86b96bcdad8@schaufler-ca.com>
Date: Thu, 20 Feb 2025 12:31:19 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com>
 <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
 <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
 <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
 <CAEjxPJ5KTJ1DDaAJ89sSdxUetbP_5nHB5OZ0qL18m4b_5N10-w@mail.gmail.com>
 <1b6af217-a84e-4445-a856-3c69222bf0ed@schaufler-ca.com>
 <CAEjxPJ44NNZU7u7vLN_Oj4jeptZ=Mb9RkKvJtL=xGciXOWDmKA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ44NNZU7u7vLN_Oj4jeptZ=Mb9RkKvJtL=xGciXOWDmKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/20/2025 11:37 AM, Stephen Smalley wrote:
> On Thu, Feb 20, 2025 at 2:33 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/20/2025 10:16 AM, Stephen Smalley wrote:
>>> On Thu, Feb 20, 2025 at 1:02 PM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
>>>> On Thu, Feb 20, 2025 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>> On Thu, Feb 20, 2025 at 12:40 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Thu, Feb 20, 2025 at 11:43 AM Stephen Smalley
>>>>>> <stephen.smalley.work@gmail.com> wrote:
>>>>>>> On Wed, Oct 23, 2024 at 5:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>> Replace the (secctx,seclen) pointer pair with a single lsm_context
>>>>>>>> pointer to allow return of the LSM identifier along with the context
>>>>>>>> and context length. This allows security_release_secctx() to know how
>>>>>>>> to release the context. Callers have been modified to use or save the
>>>>>>>> returned data from the new structure.
>>>>>>>>
>>>>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>>> Cc: linux-nfs@vger.kernel.org
>>>>>>>> ---
>>>>>>>>  fs/ceph/super.h               |  3 +--
>>>>>>>>  fs/ceph/xattr.c               | 16 ++++++----------
>>>>>>>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>>>>>>>>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
>>>>>>>>  include/linux/lsm_hook_defs.h |  2 +-
>>>>>>>>  include/linux/security.h      | 26 +++-----------------------
>>>>>>>>  security/security.c           |  9 ++++-----
>>>>>>>>  security/selinux/hooks.c      |  9 +++++----
>>>>>>>>  8 files changed, 50 insertions(+), 70 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>>>> index 76776d716744..0b116ef3a752 100644
>>>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>>>> @@ -114,6 +114,7 @@ static inline struct nfs4_label *
>>>>>>>>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>>>>>>         struct iattr *sattr, struct nfs4_label *label)
>>>>>>>>  {
>>>>>>>> +       struct lsm_context shim;
>>>>>>>>         int err;
>>>>>>>>
>>>>>>>>         if (label == NULL)
>>>>>>>> @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>>>>>>         label->label = NULL;
>>>>>>>>
>>>>>>>>         err = security_dentry_init_security(dentry, sattr->ia_mode,
>>>>>>>> -                               &dentry->d_name, NULL,
>>>>>>>> -                               (void **)&label->label, &label->len);
>>>>>>>> -       if (err == 0)
>>>>>>>> -               return label;
>>>>>>>> +                               &dentry->d_name, NULL, &shim);
>>>>>>>> +       if (err)
>>>>>>>> +               return NULL;
>>>>>>>>
>>>>>>>> -       return NULL;
>>>>>>>> +       label->label = shim.context;
>>>>>>>> +       label->len = shim.len;
>>>>>>>> +       return label;
>>>>>>>>  }
>>>>>>>>  static inline void
>>>>>>>>  nfs4_label_release_security(struct nfs4_label *label)
>>>>>>>>  {
>>>>>>>> -       struct lsm_context scaff; /* scaffolding */
>>>>>>>> +       struct lsm_context shim;
>>>>>>>>
>>>>>>>>         if (label) {
>>>>>>>> -               lsmcontext_init(&scaff, label->label, label->len, 0);
>>>>>>>> -               security_release_secctx(&scaff);
>>>>>>>> +               shim.context = label->label;
>>>>>>>> +               shim.len = label->len;
>>>>>>>> +               shim.id = LSM_ID_UNDEF;
>>>>>>> Is there a patch that follows this one to fix this? Otherwise, setting
>>>>>>> this to UNDEF causes SELinux to NOT free the context, which produces a
>>>>>>> memory leak for every NFS inode security context. Reported by kmemleak
>>>>>>> when running the selinux-testsuite NFS tests.
>>>>>> I don't recall seeing anything related to this, but patches are
>>>>>> definitely welcome.
>>>>> Looking at this quickly, this is an interesting problem as I don't
>>>>> believe we have enough context in nfs4_label_release_security() to
>>>>> correctly set the shim.id value.  If there is a positive, it is that
>>>>> lsm_context is really still just a string wrapped up with some
>>>>> metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
>>>>> be okay-ish, at least for the foreseeable future.
>>>>>
>>>>> I can think of two ways to fix this, but I'd love to hear other ideas too.
>>>>>
>>>>> 1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
>>>>> and skip any individual LSM processing.
>>>>>
>>>>> 2. Define a new LSM_ID_ANY value and update all of the LSMs to also
>>>>> process the ANY case as well as their own.
>>>>>
>>>>> I'm not finding either option very exciting, but option #2 looks
>>>>> particularly ugly, so I think I'd prefer to see someone draft a patch
>>>>> for option #1 assuming nothing better is presented.
>>>> We could perhaps add a u32 lsmid to struct nfs4_label, save it from
>>>> the shim.id obtained in nfs4_label_init_security(), and use it in
>>>> nfs4_label_release_security(). Not sure why that wasn't done in the
>>>> first place.
>>> Something like this (not tested yet). If this looks sane, will submit
>>> separately.
>>>
>>> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>>> did not preserve the lsm id for subsequent release calls, which results
>>> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
>>> providing it on the subsequent release call.
>>>
>>> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> I'm not a fan of adding secids into other subsystems, especially in cases
>> where they've tried to avoid them in the past.
>>
>> The better solution, which I'm tracking down the patch for now, is for
>> the individual LSMs to always do their release, and for security_release_secctx()
>> to check the lsm_id and call the appropriate LSM specific hook. Until there
>> are multiple LSMs with contexts, LSM_ID_UNDEF is as good as a match.
>>
>> Please don't use this patch.
> It doesn't add a secid; it just saves the LSM id obtained from
> lsm_context populated by the security_dentry_init_security() hook call
> and passes it back in the lsm_context to the security_release_secctx()
> call.

Right. Sorry. If you're going to do that, the nfs_label struct should
just include a lsm_context instead. But that hit opposition when proposed
initially.

The practical solution has to acknowledge that at this stage there can only
be one LSM providing contexts, and each LSM can release the context if the
LSM is matches the LSM or is LSM_ID_UNDEF. That will change before SELinux,
AppArmor and Smack can co-exist, but that's not yet available. For now the
check

	if (cp->id == LSM_ID_SELINUX)

can either be removed or changed to

	if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)

In a system that respects LSM_FLAG_LEGACY_MAJOR the id isn't relevant
with the context using LSMs all being thus identified.

>
>>> ---
>>>  fs/nfs/nfs4proc.c    | 7 ++++---
>>>  include/linux/nfs4.h | 1 +
>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index df9669d4ded7..c0caaec7bd20 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct
>>> dentry *dentry,
>>>   if (err)
>>>   return NULL;
>>>
>>> + label->lsmid = shim.id;
>>>   label->label = shim.context;
>>>   label->len = shim.len;
>>>   return label;
>>> @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
>>>   if (label) {
>>>   shim.context = label->label;
>>>   shim.len = label->len;
>>> - shim.id = LSM_ID_UNDEF;
>>> + shim.id = label->lsmid;
>>>   security_release_secctx(&shim);
>>>   }
>>>  }
>>> @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode
>>> *inode, void *buf,
>>>   size_t buflen)
>>>  {
>>>   struct nfs_server *server = NFS_SERVER(inode);
>>> - struct nfs4_label label = {0, 0, buflen, buf};
>>> + struct nfs4_label label = {0, 0, 0, buflen, buf};
>>>
>>>   u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
>>>   struct nfs_fattr fattr = {
>>> @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode *inode,
>>>  static int
>>>  nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
>>>  {
>>> - struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
>>> + struct nfs4_label ilabel = {0, 0, 0, buflen, (char *)buf };
>>>   struct nfs_fattr *fattr;
>>>   int status;
>>>
>>> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
>>> index 71fbebfa43c7..9ac83ca88326 100644
>>> --- a/include/linux/nfs4.h
>>> +++ b/include/linux/nfs4.h
>>> @@ -47,6 +47,7 @@ struct nfs4_acl {
>>>  struct nfs4_label {
>>>   uint32_t lfs;
>>>   uint32_t pi;
>>> + u32 lsmid;
>>>   u32 len;
>>>   char *label;
>>>  };

