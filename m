Return-Path: <linux-nfs+bounces-7345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717409A9486
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 02:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A191C22AAD
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 00:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38AA55;
	Tue, 22 Oct 2024 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cU5zykCJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic306-9.consmr.mail.bf2.yahoo.com (sonic306-9.consmr.mail.bf2.yahoo.com [74.6.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EC360
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555844; cv=none; b=KZy8hw+OtWJXcS5428FcRjSCRXwnkSAdZ1UYqff2Wzj9DFEAKokxM4Tqd4XvHmV64wo5LfVAyQ4gpx4PcQMtj0fz4/bLLC18a4XvaTk2aw/+GcpjwfNvQr+HapH2EUWNPGF9HIjol0f2gHR+cMItxtTo2Tf+W+39j4EH5jeDgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555844; c=relaxed/simple;
	bh=g2hE1WEcvzFd3lrsuFbjFYGS4IfgneZqzB/K2Y1ufSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dh6TRxdJCMAWRYaoWKWZNXjYhXAPbW11uiLYBqRFKERj2yoUn9glQrL96Zu5/ee7m9QSG9VOfWbPVY9a3g4m2gQ/DyZSHtZEYXHbxtiQOqAG/BrutgV8aREYoanSWEQQo8EdiSY+8T9ldRwRa1akJF+mXeUzXhYH2n/3oia6ztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cU5zykCJ; arc=none smtp.client-ip=74.6.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729555841; bh=pUVserrOqjjheIVK2zlgb58YznUavZUYeG9J/bknkFE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cU5zykCJKqm3guFWQTr99EwnNnAA1fxa5CnxQkXe5rBVYlsUSRiqQ8ojc2tGSPlJhLpvBNJ2OxLHMX8eZHzdV2sOJMmSAFqhD1acBSQdWHZvib28d6/xX4IwUrAQhgWTzRnlvTgpMpB7rNzM9hEWrTCXMzK/QmNYYICAu2YlMjCU5fnXu4Hs0PL7I4IeXZxIHeCB35g4a55E7yMMwoMEy1ad9yhPKWqXLn+lt9pPsCbGsnkSPCv9kArBdqIrGqiKBZAolw25NvPXp1NuENMu2pak7Vpu0JSTNabtNDFjOmHUK1Ea7YTFoRaHiyF0hRFs+HIEgNCC17H/pZr9og+X/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729555841; bh=LRCfrdOpG8pzyppi7TpsJ9EPyfhWa16i2sMGeS7aNXR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Zcp51A9nvih8dL0EEJ1c5tJcGCeD2/IPlfu1XMs/2HcjHzxDgkO9/nnpM2H3DQllN8pREcQZWp9Qx3eyix5eq7PxqWyZGrMdEU6nS/ye4Eo2Sh03D8gFxrg5KaQJ9njlUeDmyWxX29MD9e8Sc+V4H6fxwlxDdaqYENHeOHErtTEAvw12K5HfceZMeU4Ka6Q35dT8K/yJj+Vu+iwwjH9QNhnQi6bjyprRUaG95qvfA0vib4YDlsHdu3Df2HVfsg+glm5qRIf+HItmsAqYhsETCo6kGARXIvEC55x3aNhh/ZcM5ZruJPOp4o96WqW0n/50XORm5xrs6zJcZNcr+7hMMQ==
X-YMail-OSG: blKsv6gVM1mbqlTp_znbpm2ldrh.uN1rtZiKvHerhd17GF1fCNVNJ7JgsJVudPH
 JuwnfRrdkJqZmHk_aBv.X6nTQYkbDWNH.EXUJk6de3QqnRa.1Z1XZpT41TVuaSMENhHZ3LohYuRX
 UOJxgF4HYa6gTIje0.z5wY9.x5HlHHI0l.suq39fYYaSfmsvXN2ZDu4fCq5zkAzuGy3cwrwcUNAV
 dziyYl4Z_LAtH32uQqoF1NAhsuqBZsn2PBvten3ehgqJGfRb4sj1X1G7Wk4RtZVk_ItNj4JCXabt
 H.VgTKo4SzuvRyG4x3qH8TqSFfXCbcEKQhL8xrlPtX8YRBn1Wp6vBuikq3vppAqzd7rV4Al9.zr7
 Y5iiDfZvHaE39JaKIn77Vg2Ho02oQjJwQA_qxu60dj6pFVi7AmTXF2_keweAbSdznfG74FBGvGU7
 2bxJsKaauzvh17.eKJdMiuJtIAY3lAfPEqqaqPhbNAEM2GgSkChwLuAGcy9U1saCneojLCBeQkXs
 Ljjz7oyvT3WubwTWrLN6Tr_eVsDq6fHS8RilSzra8Sh.7LUu1kkg_pZWdG5K16k4VpzCFKoDCarx
 9DDz8k.wxvM.50OjtMsZbUjXZ9iFX3O7WXWEMy23NbktgdrDpyN.1RavsdATiDy2jz7VCGJ4y1pj
 wPbE6X0vaviJKhWfSNs4I3M7O5AT0vDop55aeoTzuV.jd.PWKp9Vwap.DLYW5Uj1YlOvIi9h._6m
 GcrC.hSKCp94WS4gwR71srKe4GjmBBaM92a7ZUu3g7cN422H0xetwgk1kPYI.4q949bsGlO0HQrB
 ziqy5YPcnHN7tJHqL9WyRwxuss4qFzzXb5VA7RnTWBm2pkiaTidZFzyQANVKGSfo_QK3FE7p2dzu
 8mU88WQcYCYocjpEGP4uMEJF__zEN0d3ZjsH1DeX3lwSqnxnWvZcItEXJX.djYVm27nUwsuBd_sT
 .hRToazxy8xygL9VafdexW3vBIUQ0fzZybrhf1jZNnzUBKr2gR4f3kvlNPZvD2A27IbGFkwRiYI_
 7FMUAYc6cGNjcykzJ9siYh2Fsm.EBhSAw1x.QzndAD59hG_84lrnutyqGapy5Zt8OTNp1e1egt1x
 vId0u5usQC1es40AYq9g4IQcSaGUsoZORM0wFmPQT9BkBAvBOHu7yAUVN670SlT7LoGXEZm9x.VZ
 D.o99PkpVH25Ff9y7SDvgz7fhZsu7HKyIzH8wuz4rL9_iLp1y86BsAE4C5zhoyVszi6LPP0EvhV9
 .J5NF1cRCEQ1guO.jE3lWDj0WAbdDLbnIAECyx5xQqUk0IhKu3arHRuxKhMeEqJfCv4eRID1C0jB
 Z8i5TGnpAxhVH1nRKG5Zrf67X3GBYLxIc59Qj7Jj2JpcnZUWMaw.4NBTg79qx7v8gtG2FjgoJGmc
 ZFdN6UuEZz_M0fvmshKZfJXz7W1uLJPuiqPMISm1Bck5s02VsmU2qNnEraAarDgc5wn1tAyO7ktx
 IbtC4YgAxI6XnnGOSuOUi0cr_mzBicrz1hZ.lNpDrTVcFpohvb7UA57hwMoBthAxSewSRXbMbvBD
 eZTAd1RntmBLYjogKcxM7pTIIVy0Xsfh7n_BJzokKoRh7L3FcjfRIiGAdtHZRFHCfVqkO.jLJkhw
 75O6h9jdMMXG5qF3g37Bea25EVlPK1S_h6bmZ3jUVMsSbKbPLLKBtiNdrkrb_X5WjNuFymtAbCZl
 u4xxMgH64fjmaRVx8e8WKRlVpMoucJ75H3IzDnxexk1lFuikQ7TfX6GkA3..9qPOAXb4vN0Ba16s
 Qcp3qXz0NfM51.cm.HlJ.w4QhL3qpExgjON7k4PB3WnzDJ8H4qkRB4PXza5F1IViHKpwg2.VnuiL
 7GiJPA2diHlmONuo4DYYFuD6bCg6OuJvJAxyMXxlMUVOSZXbZm.NEBbgW_0PKmZpWWQE7.LvkQV3
 o.3tnnxGIAqVZcgyFSWEmGKvOXgso7MW1fEJ8L5ZhalOB8cAF4Gi2s5j6YCK3vwkHVdMbZ5Cdiy6
 c645Uq4Uk.8iYol0vHhlB1rUNpwl172JyqNOe..zK1dZaNmkqZESyH16VtHb1RDkTimnPDEsAIIt
 NZ_YZEtTdHCapQ50g3_zKnfyHjt7_3Jq76S1Y.nee1nzO2V5NrqOFpS8pN6_hulzrDymeqeH7Q1c
 qLhv57vUjqfw1z.gOyJGOsDUMWBJGGEVIzzt_KE.hegoRij30isWM3kjsoFs33.2TnuqWZy8LMwi
 0257iF5xbcaIJ3bKKqA3rRls9Ti3tZ2YiGurnkMFur6CXaPSlKAz5bL_PboaaA._XsrH1Y5CpA6o
 HYYlqxIVciw1QVpGoVLmwDpDQUYcKgA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4b11dd98-73fb-4a66-a5e4-68bdd261eb16
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 22 Oct 2024 00:10:41 +0000
Received: by hermes--production-gq1-5dd4b47f46-k4d2j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bbbab94bfacf20b28d9123c76cae1022;
          Tue, 22 Oct 2024 00:00:32 +0000 (UTC)
Message-ID: <d2d34843-e23c-40a7-92ae-5ebd7c678ad4@schaufler-ca.com>
Date: Mon, 21 Oct 2024 17:00:30 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] LSM: lsm_context in security_dentry_init_security
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20241014151450.73674-5-casey@schaufler-ca.com>
 <b94aa34a25a19ea729faa1c8240ebf5b@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b94aa34a25a19ea729faa1c8240ebf5b@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/21/2024 4:39 PM, Paul Moore wrote:
> On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Replace the (secctx,seclen) pointer pair with a single lsm_context
>> pointer to allow return of the LSM identifier along with the context
>> and context length. This allows security_release_secctx() to know how
>> to release the context. Callers have been modified to use or save the
>> returned data from the new structure.
>>
>> Special care is taken in the NFS code, which uses the same data structure
>> for its own copied labels as it does for the data which comes from
>> security_dentry_init_security().  In the case of copied labels the data
>> has to be freed, not released.
>>
>> The scaffolding funtion lsmcontext_init() is no longer needed and is
>> removed.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: ceph-devel@vger.kernel.org
>> Cc: linux-nfs@vger.kernel.org
>> ---
>>  fs/ceph/super.h               |  3 +--
>>  fs/ceph/xattr.c               | 16 ++++++----------
>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>>  fs/nfs/dir.c                  |  2 +-
>>  fs/nfs/inode.c                | 17 ++++++++++-------
>>  fs/nfs/internal.h             |  8 +++++---
>>  fs/nfs/nfs4proc.c             | 22 +++++++++-------------
>>  fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
>>  include/linux/lsm_hook_defs.h |  2 +-
>>  include/linux/nfs4.h          |  8 ++++----
>>  include/linux/nfs_fs.h        |  2 +-
>>  include/linux/security.h      | 26 +++-----------------------
>>  security/security.c           |  9 ++++-----
>>  security/selinux/hooks.c      |  9 +++++----
>>  14 files changed, 80 insertions(+), 101 deletions(-)
> ..
>
>> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
>> index 039898d70954..47652d217d05 100644
>> --- a/include/linux/nfs_fs.h
>> +++ b/include/linux/nfs_fs.h
>> @@ -457,7 +457,7 @@ static inline void nfs4_label_free(struct nfs4_label *label)
>>  {
>>  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
>>  	if (label) {
>> -		kfree(label->label);
>> +		kfree(label->lsmctx.context);
> Shouldn't this be a call to security_release_secctx() instead of a raw
> kfree()?

As mentioned in the description, the NFS data is a copy that NFS
manages, so it does need to be freed, not released.

>
>>  		kfree(label);
>>  	}
>>  #endif
> --
> paul-moore.com
>

