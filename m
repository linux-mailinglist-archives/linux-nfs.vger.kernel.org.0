Return-Path: <linux-nfs+bounces-692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8CC8177F0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 17:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8642842D1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F9A4FF62;
	Mon, 18 Dec 2023 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="B41IQG4f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C844989E
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702918508; bh=gT5DHNKdp0TvIR2mzuNPRnHxw5EPpseeUyI2vd5aGi0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=B41IQG4f2NzXaOZ+4cCSqCltb4mzQ+F5CJ04MZ1G+HKfj0zSdEjLKFuRQGzDNbZ9+b7rS46ZBxdJ9M+uNGT9BqTHTW/SEl4PC4+Nxi+m0AJ3lochk/Vt3BnO2D0uzcklf5LfZHZvQTN1qx7tsjrQg5rfmDtd3sYJP+jmuqF8N6YxgYZdQLn0KMpDZ7hmve/B10ayAUpBWoqo0o1y9OnlBqfaU3Wy9Rqw+lxPtNI2Wh8pH8LQ753WYxsdouIFuFGStucSXLPe7Ap8T/ylDVuoUyYfBoUdhZiPjbE1PxNVYGAcha4if5sekUMemkz2Orpu+ooPHanaLa5cyWeHADDqKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702918508; bh=9a4dgL7WLZo5vtnLiq9vYMkzT40/QNXKKhr+G2KMjOn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=snokwjWZCzMfF/VbIzSPvYnXLDzFzCjkvRuGKCfe0PCAw1gCdp4s1o7ncqpgo52ufcEOwyU5TXFLh8+w4txLcXjD2bikLNkrod5BUYArBp8s4bZxx2MWF9w17kFx4iw2nmjWK2hiGO7E2fsHzjpGZn2WRDw9jubzEPB3fZeJXe7iJd9QAeJbrjN7fbO2b6Rr5UHUNTTEL3lxlCLsdn0D+50t8iUDpQGl6nO9HaXlsnR4sTt8h31gT6x59aW6Ni0/HMwFUFoeeRmspgTRhfukNE51dky8u+fs7EfKhjag10jr4D1v5gIoxR6Pjgm12LhJLZmm+pE0vrwlevTHw0xQfg==
X-YMail-OSG: 3mEebDYVM1mMIlvG9WCEfgR.mEAuZGPuO3gGwVu4WVELZlraqzRGThB7YRz8TUl
 FT7P410r8t84_aXhAzDEcShgmJ_8uBO7QAylIYHfRcheG8EpiP4aRb3jlTLW5h9Gbb5yDbh0rHFt
 xS8pZ7Niv0WdjS_CqXBBcQABVZWn0eYnGdYfIXvFdWPPRPraoc2bBsy0Zukof1xo7FoSYi5Hhy0n
 d1VZMW_6Kw2SpxVMbs0.feqX_qiRaeVKv3bChG5aUCTIK9FlY8SsSadheeJ3CIMXsrWVDtNWPxXd
 g1OLUeIzYL1c8lkSa70WNoHsN0FoEvcwP8zphXvhIEzgQrxOzxe7yr.VRWY0Z1sxBDFdlH6QcfKg
 qeUhNEs1khO13q6PQcrMCv__OUQn_Z6CdvtmOU_69HvbIZRHbxTqdTb5aRH1QfbIpqbsaHZPDxBX
 a5tjrXgD9BscmkiD6j4VMGM.9x94PPMbcWRvi8Ishg.ZvQCBbNp6XUGEZUmREJLm8V5f3Zczcb8I
 XP0AD_jQTSFkTs7uBZlM8kcTmCBNB99eUTqKt5oLc27ch0qnUrAxKn7t21sM6yVuW907zds.NQXO
 FnDVI7wt7hFYkpJoalCO.v6adNJCtfrzrlkNEKnIv0aiBR.duNq5kTpa78zcswNuUzh0HGuTQnSu
 I0n7Rs98oiWsV8qM0cgoBQSThck644Gtl6RwSVB8uYUrfu72cFX5dtS7qPljagFV5EcKCZgZ8.oW
 Dfqq_DgB4bgS4IZh2EMcPo941UOCImvpylVuQ0QXP4vhyK2vop31xIN7RvvKP0w4MhouBaBy_iHD
 cVOtRHn7Kb9_taX7gLxj4fztQbfEowOpuc12bmeIJLmyqfQJHEFfF9dxS0v4yzM2l0MKa85IL2xg
 yU.FybJR5vzgg317yy4ZoZmIYoAaHfQe01XcXAJC22dj6Ui9h4QdY36PdxRHCpDFMKQZRmkdlVOe
 UZUUvanWwUu38yXRc2jQPG4Y.Yecw9Rv0q4V7eyq6IEvD8RGcvzWRRh.tYhGQMju7rfv4EsGGrw3
 7fnm71YtSpc0ubwq71kkCCujc52iEDHbCHORbRH4pXwpTRqHXytGMgEOPGbUvuHNr3wjufptSjsO
 G1Zyr254Q1kuEvMmW1CFZe38yKZZ59q9GaiGdDW2Mev3dHwoYmwDkOU5OYIqmT9_GLT9xF.mV.rZ
 C0DlmmT2UeE_qfXiTeUUz4v8qqKZaGyle1eL16kpyJjjjhfNaJ_JK3KY86yhx4cgx.dPKNdDT5P1
 l.y.QGrsojzwMXNaKj1rZJriZChM57dIs2wZNnhLZ4JfmV5RK6CdkNRig45TYfR1C2APRGduuWmh
 vLL8hKZ3MM8YzFJWcMj_A5C78tZXJ.plDvfOAeJA_H0BtLfGUBr_iUJTJIEcBa5eOtkFM9Glafej
 ywaJjDBMtR2lwWFGnC0ler.7.ahOTFAuI8T6vfD_XFhlAMettzh_k9DItb5g5zBhhQuzzzG20gXI
 _hM0u6iIJ66G86yT9SoD.47v75rxEhQs5_YvZHw3UjDp.Bb7nIGwbJ6NYYtp83l7q.CVh0lmrDxf
 LYra3kAPPRmCto0h4wsKX0w6MteDcl1lELBMli0bjIBXB_AW5jFxpd2mbuZitmc9XAnC31TIzkOF
 NGs0CBL61jO0Ber2bAGtLi3Z.XjilmO0FXUQ_NV4HaoWSSD5gxwKJUR3sdeQ2W_tsfGc7IMWUsCg
 1sz1gXZQsPka.r6iaEaWKsE5GF5v6cn8Dz7bD7ZpAdhYXGBFkUdMzU2upfMYPNFTbQs0shhmiNCE
 _IIcdOGPveORIYsZDmiGFLVuj1tYbyRyhRCh99w5.t2xb6.NS7uGT0zUaeg.q.G8EpkoGP9FiEh.
 Bk3mg3r8GS542WPP_avODKP0x6XxN6F9t4wxTqGPTwtQaBdBrRBzrXEhl2HOMT31JXd.RzdgtPZ5
 q5Tx1UBP7knDQoXG21QEcVQ8uOFxvTxjjYUBZ3WCejxQw9CxQF0UTXPMhOscIqhWR70uK.rl35Dg
 HBnuqW.JZ.U.V5tuObg9axYt6bT036QUkEvExyQ8FekUJJf3YbyMTB6us52jDzVnbFYvI6iVaXeu
 ORnBNYbnC0H2xfurmVLnYtfAzrVW8ymUJx24Gy9NZ1.8CKEmyatvmzI12qt1QjtvvRrk0NH4uZOU
 hKxp8izsqPh1CPZxp.xciIj2dUPsVIUyy1neaXg0FgrwoY1QvrbmnGt.w_qQjZy05MXVbgiqTXPx
 KZRHIB7O2A05umF.9TqXZwnl7NhPVZDKoygSgLlcvTZk8dIt8oCloOIbkFHphew5SkkCRnYmQpMy
 hgXkReDIrJoJqFWWOD.EC
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 68743d55-e301-4354-b5d8-f2d0aa210382
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Dec 2023 16:55:08 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5d966477f02f002d6276fa55fc76c316;
          Mon, 18 Dec 2023 16:55:05 +0000 (UTC)
Message-ID: <8d6889bb-e874-4388-a36c-22df720a00aa@schaufler-ca.com>
Date: Mon, 18 Dec 2023 08:55:03 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 20/42] LSM: Use lsmcontext in
 security_dentry_init_security
To: Xiubo Li <xiubli@redhat.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-21-casey@schaufler-ca.com>
 <ab373a38-7800-4056-9ac4-31fef643c6b1@redhat.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ab373a38-7800-4056-9ac4-31fef643c6b1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/17/2023 6:50 PM, Xiubo Li wrote:
>
> On 12/16/23 06:16, Casey Schaufler wrote:
>> Replace the (secctx,seclen) pointer pair with a single
>> lsmcontext pointer to allow return of the LSM identifier
>> along with the context and context length. This allows
>> security_release_secctx() to know how to release the
>> context. Callers have been modified to use or save the
>> returned data from the new structure.
>>
>> Special care is taken in the NFS code, which uses the
>> same data structure for its own copied labels as it does
>> for the data which comes from security_dentry_init_security().
>> In the case of copied labels the data has to be freed, not
>> released.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: ceph-devel@vger.kernel.org
>> Cc: linux-nfs@vger.kernel.org
>> ---
>>   fs/ceph/super.h               |  3 +--
>>   fs/ceph/xattr.c               | 19 ++++++-------------
>>   fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>>   fs/nfs/dir.c                  |  2 +-
>>   fs/nfs/inode.c                | 17 ++++++++++-------
>>   fs/nfs/internal.h             |  8 +++++---
>>   fs/nfs/nfs4proc.c             | 22 +++++++++-------------
>>   fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
>>   include/linux/lsm_hook_defs.h |  2 +-
>>   include/linux/nfs4.h          |  8 ++++----
>>   include/linux/nfs_fs.h        |  2 +-
>>   include/linux/security.h      |  7 +++----
>>   security/security.c           |  9 ++++-----
>>   security/selinux/hooks.c      |  9 +++++----
>>   14 files changed, 80 insertions(+), 85 deletions(-)
>>
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index fe0f64a0acb2..d503cc7478b7 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -1133,8 +1133,7 @@ struct ceph_acl_sec_ctx {
>>       void *acl;
>>   #endif
>>   #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
>> -    void *sec_ctx;
>> -    u32 sec_ctxlen;
>> +    struct lsmcontext lsmctx;
>>   #endif
>>   #ifdef CONFIG_FS_ENCRYPTION
>>       struct ceph_fscrypt_auth *fscrypt_auth;
>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>> index 113956d386c0..4c767a20ac4c 100644
>> --- a/fs/ceph/xattr.c
>> +++ b/fs/ceph/xattr.c
>> @@ -1383,8 +1383,7 @@ int ceph_security_init_secctx(struct dentry
>> *dentry, umode_t mode,
>>       int err;
>>         err = security_dentry_init_security(dentry, mode,
>> &dentry->d_name,
>> -                        &name, &as_ctx->sec_ctx,
>> -                        &as_ctx->sec_ctxlen);
>> +                        &name, &as_ctx->lsmctx);
>>       if (err < 0) {
>>           WARN_ON_ONCE(err != -EOPNOTSUPP);
>>           err = 0; /* do nothing */
>> @@ -1409,7 +1408,7 @@ int ceph_security_init_secctx(struct dentry
>> *dentry, umode_t mode,
>>        */
>>       name_len = strlen(name);
>>       err = ceph_pagelist_reserve(pagelist,
>> -                    4 * 2 + name_len + as_ctx->sec_ctxlen);
>> +                    4 * 2 + name_len + as_ctx->lsmctx.len);
>>       if (err)
>>           goto out;
>>   @@ -1429,11 +1428,9 @@ int ceph_security_init_secctx(struct dentry
>> *dentry, umode_t mode,
>>           as_ctx->pagelist = pagelist;
>>       }
>>   -    ceph_pagelist_encode_32(pagelist, name_len);
>> -    ceph_pagelist_append(pagelist, name, name_len);
>> -
>
> Why remove these ?

Looks like I have a merge error. Thank you for reviewing.
I will repair this.

>
>> -    ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
>> -    ceph_pagelist_append(pagelist, as_ctx->sec_ctx,
>> as_ctx->sec_ctxlen);
>> +    ceph_pagelist_encode_32(pagelist, as_ctx->lsmctx.len);
>> +    ceph_pagelist_append(pagelist, as_ctx->lsmctx.context,
>> +                 as_ctx->lsmctx.len);
>>     
> [...]
>
> Thanks,
>
> - Xiubo
>

