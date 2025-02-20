Return-Path: <linux-nfs+bounces-10235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE8A3E65A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 22:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D6B70063C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAFE2641E3;
	Thu, 20 Feb 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pPvYk5yp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4381DF735
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085715; cv=none; b=eZvGsqSpbNkEujyJ68tWpPhlRb6LrUJeynBuJhCVKVFX2L05MTmpgYq0fJAQ0APV4fU5PFDQYj+8IyWnrpy7LF4I17ib/UXuKUXR8F6UCb2P6ovf1DnkJfZn3lTt/2/2D4ukinNVfoKxBpeIM3ckRrT8tK07Qp14mdH5Fm+ighc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085715; c=relaxed/simple;
	bh=fHGJ9ma0uaPWRxbhXmuiwJ3p7H7R6z3UD6fTox006tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdK06jtA3OnkZ+iCntlwJ2UkvbcibvcUe8U2/KULmZXIn5ze4Mnl0RLLJpAT7EPNZ5Ct/J4z5exLmC4fw3nl7QBT+eazDhU2zx4Op+4smZfeQQDCxDvG+30HUlhCrfKkLpP7q/Iil13rYJqQa9gIM4HNw61zmTtjqU++GXm5C4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pPvYk5yp; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740085712; bh=Ls601Pnnpzai5fbmWn3A/wbMHrwBgOZ4RlzYkYE8c4U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pPvYk5yp1AivRNHyR6e4vygZ6v6YQ5xrYjA6W9hJzluZrqVkVqJn6fQW2bNhq7SaVyaquYpb0TlzM56CVyYIcBr1dQ4LPU3KupaJ8aIVq0KwjLOIw2Vz/tO96EeGMN+aglRu75O96G0rHmrWPz/kaOhKSqUFtZ+4DPjHsWGMkWCa4mBjRrfp5dOq3yhZF8bX9DIkcWpMaU+XPRD55+53n3ZBoWYBR+nKvogRTjLiUBpH63PU5AcSbuTlRr3q65jeT5OJj3a6ioaw1NBzuoWwA87D26VvLMwjb/AiMRuzlqSQa21BzItBMN2/2LoRyS6Uu+95b6bJPKso/vGY7JoCtw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740085712; bh=o9HmKBfQQwe4C6Jh2g2sjzGimM67Xu19yHUj4y/HDRP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UQAOtrVCAtMNQCu70S6ffoRz9ep7PzkYkEMoA2QS6vS51rlaLCOb1YXSPSh/HWHS8iMs9Uls6HMke0J2/xPOMNNkBkmyRgERuLeDmK1B9LAsQH0k+YeR6SFgX0e6o3laL7dHkxo/PVdxhFtdnGcWb17vFkfCmVF1d6NilQEunEOTBCLe6aKrDjCoqcVoSvHD3/yDZ05xJNhirVFPdFXg+DJLMl39Ahiy88DY/55gyGBm+LkJQP+84iJVHKrLxVIunDAtyS7Zby8nIQzTkcIXfqaRPmcF9M3PfacPekTdxXGcjr4BfaarbSZHhAdXTIK8ih+/baiaJMIW9q8IQ4qOFQ==
X-YMail-OSG: S8mhbE0VM1n_FRSpy7KljNE.5oxIXr0jfOonF7giTFVs8SiEwpukC9TZrrBBuav
 4duS_MrRLXeywiDDUNjYAH1BMrZmmGL9oQejetpbSkMHOfQe_mHuyInXfCuB8YrTIi5gi8B6lTHF
 iRXn7G_IJgwFMg_MysrW2JOs5YINkeRTp09OzwXCiZPkwMoSh6tvDnV__FrZ5jIsQ43nGuBaQtzA
 M54_.K_mwbPHX7tYzf_oxQDB1pkoP1naOQDJ7YNcLf7jkk2sgekRA2AVQMoFePPQcKzd3J14LbzA
 RRP9UjGIq5_BLrMEU.TIAUeXp994mnWig0RGZCSBHW3dx8U8EIInyeT8.JCcK7xzmaYchutNybDH
 vFtHMZDyyRxt71eqeWctTKEBdqp5k7jy0OQEOnDQEsKluqcO67gDRCck0jndwQb8UYWcm609x1Lr
 sq7MPrqQjtnSOspTl7A8O3jdo07A0k2RaKtg2A3sWPmUk86bqC6GKrvAf62Dui5YT3RSTyRLqc84
 uhIcqkGJDJ8QScaahjKoMAzwrpZ.oIx3fr0kpGNF4xV9R0zxh7jxHvc6.BUCFyDwXggX5rhDcEo3
 DkZl4ZdFyJ_coFipbpsesyXiqyc8pEZ0aywNcPgSP1w1Hif.UyokZc28yYvgm8VgSLX8CYG.w0B2
 .1s7qnJg..1zV6iGFOcYTt7XSv9GM_Z_gdX5xQyX8TxbStBVMwfEXLk6avpXzJgv6IctM60Lkh8D
 FHya1CnFH0I_3bdUtijgp4fOr1ApO9_iYCtFgsNghyiEbsTnoMSc0YYj1GYW3EIP7iSoCjOpSTmF
 IzhB.9HZF7KWsO8h4ni1vUOdGTtVNmVAS9qg9dTVTDz7oECle6wRSN7Zm6aaB8P.sP3BnoEK3EFs
 JwXiwAW3apaLLLnyqlWw6MXGZvCQaYXA6hOH_LVSzy3x6T8Wh9IwCGT70QdEs18UgRAU_pBOoBIR
 qKUqhwmbv.TGTO_qJ4eLB2nvVjg6s9ZSZgZmIAGM9Z0y81HEzl.rdxVmLeX9qC0xcTRBt1eBij.0
 esM6IMcfwIQbByndq1HZH8mo0bfxDXBjbgn8JH06tpalk8gc7j7mYkm.38yBwGdRt_7Ri8GjzaiJ
 KOKIQmUv9Ow0lxhfzSXFsHlLDRRwSiGjDZ3_8qxHNONm2sKesqJGRXYCseDsqSHLeHVowfFyFn6M
 .Zh1FD0T7RrorxUV5h8D.s3B0gUCWbcTGK3QIw4ETgsJqlv9KFDyL5tXfS4TYT0VYe7churDoPpg
 PJrSClq9sIo8DfSZ7.cwL7MQh0pZkI00ljr1yrs4wxP2OzeJCFSmjxG4z02QxczF8FgjyhYMSv1h
 xFh2SFg6WSbfUmzUHjMZWESJ9.H_LtKHNlBslNCaJ3zaZWMMM.7LKGevZqWWGuGOCgko7RvoRWru
 tYRCYocIaNxsxykK7iJkb3htypRSqKxi3hPBIluxxmHR0mKUdId11YyrrLuMVGMXtq_uAHaoZOub
 jGE66yWHBxq1Eekrg9xYTYV0oGJ8drdaIDRyfDowyM._7RfITemk5tyPCZ3oKk61whSu_c66p8rH
 QsULDG5Zf3bktGOwOBNIsOXAnWbmsQ_q_EO3XBOdAhk.8OPqr2559Vo1EQjOceXARYagp5OGLBjK
 ej7RI.onIAJSDbyhxysYAUGihDVzIuoiTCcpONlNtJAxmlIFpl0_1FcmbXn_h.K5Ujr0vtAHkc.h
 Bm.97_0xf.QKgRHmhjQAK6DzdwAKPNCt5C1Py6D0W6SU668HSsLdNllDW71onBOG0vJcPeSe8Abv
 Kymsbm_qzJB5O18QWHBPRbRF7PpfZY2AxXBIbZEAGw4DB9tMRpsiYtrqzSydoT2iiKbCPMa7M_nT
 Sl9rl9tXwNqVLBUaPvCnA1D4ahkpzpCdTb.ca4eBtnKy6P8TBwAYyrBG4muOeiilFd8NlT4gj.pL
 BAxP2YD1hMiRX0OMkO4YfMwKHrh5Ee7.Y6bvyFzkH7o1CddsuglxmvzFsGWDQ6rxxoOK9CbdvwET
 JL.iR_lv_rhn3NXXl0Gbpa83GbAYnTvNorVIvEINOmTKocYWmaxxJ5HOqTpPhuIn.v15kGTgvv7F
 VzzKyfaRPgVm5tIJRcpRzGagaYDasboJ4NbFl6Mgz8g_SKYsQ9xpkoF50G9_SA0LFyHASeC.4pzJ
 1ymdMr1u6vW0rInYiJBiUXr4zjznOz77BnxY.S30sdrGYOlXlIXpZoK9kZurd.W3uloPS_M2xX8E
 HIYIM50tk8v42QI.S7vdGvjF.9wD5WArjLEbEN82_3d1DiBU3ExAraL6AgbPI1gtaTQxRuC_Rtyz
 exAWM5Bst8K_LymAAgkf0vAOVeL0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0afeb5a0-6019-4eae-9389-51f560899813
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2025 21:08:32 +0000
Received: by hermes--production-gq1-5dd4b47f46-mb2l9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4748797154ba520462eaa80991b069db;
          Thu, 20 Feb 2025 21:08:29 +0000 (UTC)
Message-ID: <784b9c6d-22e1-44d0-86f8-d2b13c4b0e11@schaufler-ca.com>
Date: Thu, 20 Feb 2025 13:08:26 -0800
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
 <eba48af3-a8ef-4220-87a1-c86b96bcdad8@schaufler-ca.com>
 <CAEjxPJ7aXgOCP4+1Lbfe2b5fjB9Mu1n2h2juDY1RjPgP10PUxQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ7aXgOCP4+1Lbfe2b5fjB9Mu1n2h2juDY1RjPgP10PUxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/20/2025 12:33 PM, Stephen Smalley wrote:
> On Thu, Feb 20, 2025 at 3:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/20/2025 11:37 AM, Stephen Smalley wrote:
>>> On Thu, Feb 20, 2025 at 2:33 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 2/20/2025 10:16 AM, Stephen Smalley wrote:
>>>>> On Thu, Feb 20, 2025 at 1:02 PM Stephen Smalley
>>>>> <stephen.smalley.work@gmail.com> wrote:
>>>>>> On Thu, Feb 20, 2025 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>>> On Thu, Feb 20, 2025 at 12:40 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>>>> On Thu, Feb 20, 2025 at 11:43 AM Stephen Smalley
>>>>>>>> <stephen.smalley.work@gmail.com> wrote:
>>>>>>>>> On Wed, Oct 23, 2024 at 5:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>>>> Replace the (secctx,seclen) pointer pair with a single lsm_context
>>>>>>>>>> pointer to allow return of the LSM identifier along with the context
>>>>>>>>>> and context length. This allows security_release_secctx() to know how
>>>>>>>>>> to release the context. Callers have been modified to use or save the
>>>>>>>>>> returned data from the new structure.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>>>>> Cc: linux-nfs@vger.kernel.org
>>>>>>>>>> ---
>>>>>>>>>>  fs/ceph/super.h               |  3 +--
>>>>>>>>>>  fs/ceph/xattr.c               | 16 ++++++----------
>>>>>>>>>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>>>>>>>>>>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
>>>>>>>>>>  include/linux/lsm_hook_defs.h |  2 +-
>>>>>>>>>>  include/linux/security.h      | 26 +++-----------------------
>>>>>>>>>>  security/security.c           |  9 ++++-----
>>>>>>>>>>  security/selinux/hooks.c      |  9 +++++----
>>>>>>>>>>  8 files changed, 50 insertions(+), 70 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>>>>>> index 76776d716744..0b116ef3a752 100644
>>>>>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>>>>>> @@ -114,6 +114,7 @@ static inline struct nfs4_label *
>>>>>>>>>>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>>>>>>>>         struct iattr *sattr, struct nfs4_label *label)
>>>>>>>>>>  {
>>>>>>>>>> +       struct lsm_context shim;
>>>>>>>>>>         int err;
>>>>>>>>>>
>>>>>>>>>>         if (label == NULL)
>>>>>>>>>> @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>>>>>>>>         label->label = NULL;
>>>>>>>>>>
>>>>>>>>>>         err = security_dentry_init_security(dentry, sattr->ia_mode,
>>>>>>>>>> -                               &dentry->d_name, NULL,
>>>>>>>>>> -                               (void **)&label->label, &label->len);
>>>>>>>>>> -       if (err == 0)
>>>>>>>>>> -               return label;
>>>>>>>>>> +                               &dentry->d_name, NULL, &shim);
>>>>>>>>>> +       if (err)
>>>>>>>>>> +               return NULL;
>>>>>>>>>>
>>>>>>>>>> -       return NULL;
>>>>>>>>>> +       label->label = shim.context;
>>>>>>>>>> +       label->len = shim.len;
>>>>>>>>>> +       return label;
>>>>>>>>>>  }
>>>>>>>>>>  static inline void
>>>>>>>>>>  nfs4_label_release_security(struct nfs4_label *label)
>>>>>>>>>>  {
>>>>>>>>>> -       struct lsm_context scaff; /* scaffolding */
>>>>>>>>>> +       struct lsm_context shim;
>>>>>>>>>>
>>>>>>>>>>         if (label) {
>>>>>>>>>> -               lsmcontext_init(&scaff, label->label, label->len, 0);
>>>>>>>>>> -               security_release_secctx(&scaff);
>>>>>>>>>> +               shim.context = label->label;
>>>>>>>>>> +               shim.len = label->len;
>>>>>>>>>> +               shim.id = LSM_ID_UNDEF;
>>>>>>>>> Is there a patch that follows this one to fix this? Otherwise, setting
>>>>>>>>> this to UNDEF causes SELinux to NOT free the context, which produces a
>>>>>>>>> memory leak for every NFS inode security context. Reported by kmemleak
>>>>>>>>> when running the selinux-testsuite NFS tests.
>>>>>>>> I don't recall seeing anything related to this, but patches are
>>>>>>>> definitely welcome.
>>>>>>> Looking at this quickly, this is an interesting problem as I don't
>>>>>>> believe we have enough context in nfs4_label_release_security() to
>>>>>>> correctly set the shim.id value.  If there is a positive, it is that
>>>>>>> lsm_context is really still just a string wrapped up with some
>>>>>>> metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
>>>>>>> be okay-ish, at least for the foreseeable future.
>>>>>>>
>>>>>>> I can think of two ways to fix this, but I'd love to hear other ideas too.
>>>>>>>
>>>>>>> 1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
>>>>>>> and skip any individual LSM processing.
>>>>>>>
>>>>>>> 2. Define a new LSM_ID_ANY value and update all of the LSMs to also
>>>>>>> process the ANY case as well as their own.
>>>>>>>
>>>>>>> I'm not finding either option very exciting, but option #2 looks
>>>>>>> particularly ugly, so I think I'd prefer to see someone draft a patch
>>>>>>> for option #1 assuming nothing better is presented.
>>>>>> We could perhaps add a u32 lsmid to struct nfs4_label, save it from
>>>>>> the shim.id obtained in nfs4_label_init_security(), and use it in
>>>>>> nfs4_label_release_security(). Not sure why that wasn't done in the
>>>>>> first place.
>>>>> Something like this (not tested yet). If this looks sane, will submit
>>>>> separately.
>>>>>
>>>>> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>>>>> did not preserve the lsm id for subsequent release calls, which results
>>>>> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
>>>>> providing it on the subsequent release call.
>>>>>
>>>>> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>>>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>>> I'm not a fan of adding secids into other subsystems, especially in cases
>>>> where they've tried to avoid them in the past.
>>>>
>>>> The better solution, which I'm tracking down the patch for now, is for
>>>> the individual LSMs to always do their release, and for security_release_secctx()
>>>> to check the lsm_id and call the appropriate LSM specific hook. Until there
>>>> are multiple LSMs with contexts, LSM_ID_UNDEF is as good as a match.
>>>>
>>>> Please don't use this patch.
>>> It doesn't add a secid; it just saves the LSM id obtained from
>>> lsm_context populated by the security_dentry_init_security() hook call
>>> and passes it back in the lsm_context to the security_release_secctx()
>>> call.
>> Right. Sorry. If you're going to do that, the nfs_label struct should
>> just include a lsm_context instead. But that hit opposition when proposed
>> initially.
>>
>> The practical solution has to acknowledge that at this stage there can only
>> be one LSM providing contexts, and each LSM can release the context if the
>> LSM is matches the LSM or is LSM_ID_UNDEF. That will change before SELinux,
>> AppArmor and Smack can co-exist, but that's not yet available. For now the
>> check
>>
>>         if (cp->id == LSM_ID_SELINUX)
>>
>> can either be removed or changed to
>>
>>         if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)
>>
>> In a system that respects LSM_FLAG_LEGACY_MAJOR the id isn't relevant
>> with the context using LSMs all being thus identified.
> Shrug. My patch seemed cleaner,

Adding the lsm_context was cleaner. Not worth yet another roadblock.
I will have a patch asap. I'm dealing with a facilities issue at
Smack Labs (whole site being painted, everything in disarray) that
is slowing things down.

>  but I don't really care as long as it
> is fixed, preferably before 6.14 goes final.
>

