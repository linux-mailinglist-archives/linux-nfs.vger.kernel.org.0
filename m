Return-Path: <linux-nfs+bounces-10219-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F1A3E326
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D043A5961
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ADA213E78;
	Thu, 20 Feb 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Hbt9plLz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50D2B9AA
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073956; cv=none; b=Ff5PsrITw5vrmk+cSLulPFezsjtRTNdZxds022LmEurfarbVffHTlbYK9R4HVHT3sdKgDfqZyzlaHHE+BA+WrPGHJcvwSZD25qWNo9foMX+ki/MdgBUjJFRr/GDLekIYf9NIxS74Mbuh+2fMFnfin+1Ps6ytiHk2UTLXSUvKmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073956; c=relaxed/simple;
	bh=w2Ts1OwyV680DxS5L7wdfyIIAP8j0SLFYv3E/ymypQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fayq4+apvZGlU30Giyg4dWxt8I60mEjhOGQxiYlQDA5DSx43ZP7HBQ6G8PnWHO4VYmHbbHebKEDqdssOyK0lWnQHtCX1A8vv/YMw7MDqM7yc6cMmhw1z1SBik3xr5th4DDVNxDmfw1blseEaQVTwmuR6uq8lx11QeE0/tthLbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Hbt9plLz; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740073953; bh=QlUkEG5/SWnjnCF4jnqsLn47+yb7vzpIpJX/JRaGfNk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Hbt9plLz8PL4Z3dKL491dPDI3qhcJ4JVoK6aYQYpAec4ddJBwxvTdpfsvGdYhPe05EWbzfSR0lR8X1QDIUHqKsQpFiFYDl/Ybb+WvYRlDbz2Y6wlSMGY6dF67u/BpnbrXAUR2LRi7haFI8sHSCUJTOPpFho43aGqxWdeq594YvWgWgCnjG0xH9N/fVp8pTogjb6adA9M4IjfekuN9QLXCMVhv7ntQx3PUym7rY71FCobY+Wid4CIMlZY/n/WxCidjhr8ZrsKNMj4i8h4M16cgHS3xkACifR3BJTv6g81ZVvzc1ZMPB3sgNUoKNUVXG6Nz1e9gBPNTif9TtwFzNFGhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740073953; bh=hI/6zdwFhBpHSP39Tq63fGk7JPa7BHcOnIbJH95L66E=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MfsO8BxtD76+MBF0sSfwXXWr2wmBdurVafIVSg5f2s0b7oud4CZZalA1zUcL+FnBcp4K0OffiSVHlb7U3vMpuqzqxVQ++E+ETnkcekAq6t1wpft2XQiUMAyoDQzMZMZd7yEVCtWSsdQ9hkfxHcTPtuUA4h8AR+xSy7/+HuV0zuLNztadsg5vFg6rSVUL5s7Y4AmA4/BoLoFS2qqOTGFX9XCivXNizfmvi6XUuwxH9wXYgXispjGcvlRsDBagaKQvbmSygVggfXa0vN65xZ1KPUMXkJVaJWDlp8dqNirUPOmVTZ1Fka4aVTxhDQe6HsApovVFlH7pGebdlgE2ngIWKw==
X-YMail-OSG: 01ODzgMVM1lKFwTGpOIgoljfZ.NGhAiG9bsfXj321PFHw4R4gBLaep7S7bt8kwn
 brBfPU6iABYcOLB1ZnJVlfPlw33OV7SPvC_dQuLt0znqmonvOVYeYk6RA2dzx2fqZ2dT4ObrakGs
 G112wObywl2v340wgO5yDFgjHETJ.PKN0i1FKyyf0fPFtNA38gc2mbuD19rDBxx92etM18Xr1EDo
 QgBMFN8Dmw96voXM7Khq9ThbmmW_.UKNfJw0_8qV.dCHEEwIHg9RuJlZWArZvIjQ.2yxU_j7fhyh
 _XlR9hOJ_xcAo71HdlmSXs21F_R4s5mfqKr50IZXD.VKXLLf2xSKgIkhFxBec0SDrqLBdNDY62s1
 1Fq.5HR5JYssYlse8oYyl1jSu2qFOkuSWc2YVuSJ76RYRi8LQednrTNIm75o4qWudBI_gDs5DAly
 O0pcs_WIh4_fzXdpUQMV3A1FobihIHqBLy5OoL7gUdhnVtlvwBpqTTD4v3FZ45.I5_oQZicPXYoj
 v6xRaJxmSQhqS0icZagZNLNKEm0pXu0ViJ9cPwROpcRB1GzzS6BMP5R17oLjAhGMjiLVUXsg5p8c
 c.a9SZZ4qwP0SfYwCQRST.6U3eGG6SDENbpJPKgXzNo6bhEn9pZJu2x3K1sJm_3.VdLoQmFk9Efk
 S8qT5_JdPbFtygEX8FEhUPz1aLc5HkBwLsr7MJIMt1KMTQ_MNiN0TpXfKZzgFVNErWIB_OycyJpI
 C5M_GWl4pN50ekE_7IaHLCmy4Dc4Yxti8telPMbmzyPLraaauesG7AAgFXM5VI2RHPQnmpWtRebl
 tdc21rj9MXTLvlX3XDwPYB7RQAym85LtY9k9iTT7SAgJ16DhW9TBrQlOmNsJwmvwGApljuOmXyoG
 6cE8nGwh5wm.4bp7F8pWbGoujL6bW3j_XeQLzFQlhw894Tkld.mpIdnKQXUQbiIae.bI8XLu2kbY
 ZHo99hlGGXPcOcNb0zOFDve5CVrwVsGwi0VZKEVwJKqc72otKWs5dc2zjEqlRGh4.5CyrPc7s_Qc
 IENjt4R_GW7b2bHCGJqR_PzWEQ90LW4sk_JZhsV10eq6dSciaYDyMyydfwG4ijQqiRfxh.I238Ix
 69mFc9lXnd.1juMN_jcxXgvqWv9ofOzYxKQc5z6pgtsqoVv7ZY_S2wCmcN6G.wwOEFKJSDeOPH15
 zS46hOFQI8XwAtag1k.b.qu1nklSzhOLUvZcEQzOnsPw0u9JQ7.yhd8mizPni3WgQWdboca.xjgQ
 zkqensFHWeJT0exXYZUw2koer9ny_WwIY6.DOrX4QEljfcZWmeXjawza16768ojxz.XJE80Xu0Bm
 oIJTQSD7R5OBIxOW05WXSaWkOWH5Agv_LoI_971Wqql9FkCBZ0xJ7IBLJgjPTIHENtlqiWMJxzUc
 kv96Fu.kfB9VXqrvktPLXoJyNvRqhwSrmvDwhjuZ3MPVMhBiFiH_tax25G8opwjcyNCMPkAPyTcc
 UoUCjwhm0TY6TGFSglNBIq01KI3_OpweD2fukJrh1IEfWCWOTc9K8qZ55Bcef1GWXd0Up25knfvH
 5Wt92AoLg7sj2N_sfFmY3.PhIwhS0vd7L5Xpbg1QqZc3PZqh1SLSZsll0TLmQfnwaDf2rbKqTgRT
 fu4B4WTlB1kOfG6MDLpRDqAmJjn0E1KZmpLWkJw.eUp6Wmtgsk.EgP1MwVNO11mwGful4qA6Qn6A
 adswhK_NO6bWJqlrkJ2aNUkvyXM65D.O.HiyAejRa4pg.XUulB0egU93glVTYTd1mvSvp9JAxaoz
 03I93NnlxgyRzERT_O0V2_njtwXSMnilbuZLwvKJ74bKaeWgO2V2je34GOkAFhV8iOBdjV5MF4Zb
 eVKGnRBaLCDt5eiBzt4mFmQysEHdZkcnrgevA8aqrwoHmulb1xJU.KBSO5rCUJedynDxwYKfTOgA
 iDjeqlmghNN_YHxEBZIY_D8yqNQwhINfaNZAdBZRg58VEJpl6C4lE6VaOn0ky9LNYpEAXgQKUXTn
 0Ov44eupdA8Hizl7FhnwZUJsxe7YslVdZMuBIIIkBcLWxH9SlWMs8cb88.aYQKv6fxoBl4dlptpT
 DqKtNUOrv2FGRN7AS36AMcg3aXpBg8D5SjwfJOoL8.rcr.tCPrnFOK17o2Gc.q4Ri4ntw4KJAA.7
 rPS6jW1I2I.4xvQoqXs2RxCvNmzzDc4dvYCbCH2QBGE1qiwqBUXcgK2_i9ZxgwxjDUVytLHOvo8v
 p0vAGANtqLLmGnIoQvhY4PIWSABSAOCPswwyqw2xIJSP9WEhOwmlmAe6eB.J8MS3jeBFozzpaXay
 D7yuvvpjLn8yCnyzFP.E9YZLOIWi7Zw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e047003a-4bc4-4236-8526-45f78c0e0f4a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2025 17:52:33 +0000
Received: by hermes--production-gq1-5dd4b47f46-qfm2r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b4b37c7af87a4ff57ee5b5b238cc7771;
          Thu, 20 Feb 2025 17:52:27 +0000 (UTC)
Message-ID: <5e52fc02-e71e-4256-a4d1-42bf901800ca@schaufler-ca.com>
Date: Thu, 20 Feb 2025 09:52:25 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com>
 <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/20/2025 9:40 AM, Paul Moore wrote:
> On Thu, Feb 20, 2025 at 11:43 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Wed, Oct 23, 2024 at 5:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Replace the (secctx,seclen) pointer pair with a single lsm_context
>>> pointer to allow return of the LSM identifier along with the context
>>> and context length. This allows security_release_secctx() to know how
>>> to release the context. Callers have been modified to use or save the
>>> returned data from the new structure.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> Cc: ceph-devel@vger.kernel.org
>>> Cc: linux-nfs@vger.kernel.org
>>> ---
>>>  fs/ceph/super.h               |  3 +--
>>>  fs/ceph/xattr.c               | 16 ++++++----------
>>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>>>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
>>>  include/linux/lsm_hook_defs.h |  2 +-
>>>  include/linux/security.h      | 26 +++-----------------------
>>>  security/security.c           |  9 ++++-----
>>>  security/selinux/hooks.c      |  9 +++++----
>>>  8 files changed, 50 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 76776d716744..0b116ef3a752 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -114,6 +114,7 @@ static inline struct nfs4_label *
>>>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>         struct iattr *sattr, struct nfs4_label *label)
>>>  {
>>> +       struct lsm_context shim;
>>>         int err;
>>>
>>>         if (label == NULL)
>>> @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>>         label->label = NULL;
>>>
>>>         err = security_dentry_init_security(dentry, sattr->ia_mode,
>>> -                               &dentry->d_name, NULL,
>>> -                               (void **)&label->label, &label->len);
>>> -       if (err == 0)
>>> -               return label;
>>> +                               &dentry->d_name, NULL, &shim);
>>> +       if (err)
>>> +               return NULL;
>>>
>>> -       return NULL;
>>> +       label->label = shim.context;
>>> +       label->len = shim.len;
>>> +       return label;
>>>  }
>>>  static inline void
>>>  nfs4_label_release_security(struct nfs4_label *label)
>>>  {
>>> -       struct lsm_context scaff; /* scaffolding */
>>> +       struct lsm_context shim;
>>>
>>>         if (label) {
>>> -               lsmcontext_init(&scaff, label->label, label->len, 0);
>>> -               security_release_secctx(&scaff);
>>> +               shim.context = label->label;
>>> +               shim.len = label->len;
>>> +               shim.id = LSM_ID_UNDEF;
>> Is there a patch that follows this one to fix this? Otherwise, setting
>> this to UNDEF causes SELinux to NOT free the context, which produces a
>> memory leak for every NFS inode security context. Reported by kmemleak
>> when running the selinux-testsuite NFS tests.
> I don't recall seeing anything related to this, but patches are
> definitely welcome.

I'm looking into this but as you well know the NFS tests aren't
always especially cooperative.


