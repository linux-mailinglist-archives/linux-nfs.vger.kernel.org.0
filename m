Return-Path: <linux-nfs+bounces-7365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE8A9AB44F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 18:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937B11C228F0
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5341BC9E9;
	Tue, 22 Oct 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FqnCFpoq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic310-22.consmr.mail.bf2.yahoo.com (sonic310-22.consmr.mail.bf2.yahoo.com [74.6.135.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA142AB3
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615636; cv=none; b=Tv3/Jwur4fVA7ios4Qt1esJvEyVLdF3Ji0IdGFZPVV6pRPowt/Lsirl2GoVzc6N9ezB3R8rOVAjB2hURcOg4QT1m24a+L/EYnTfrUwCKo0MinJxs787jJipGZEx5PZdV0FGtvnWqp3QzpfmlZZnu/K4ep4JaFf8Aiux8E6PJoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615636; c=relaxed/simple;
	bh=LGvZfBG932kQ1YrUvUr/IcYClA07C6OSPqb3K/idqnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpZeevqGSRaRIraYDjh4lvzP0W+EPyU1LUUqcp1oKpdf+0t2/Y1pcFdYTdRvs778CSLKZuAdliFAALYEX0f7ihHKkWnKFwWY3usU75F07eBtzuD/8E5NfJYrIodPtrbXwacsrGtYv9UxNyRSBmDto2zYEUhPIYHVGRtGra6XHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FqnCFpoq; arc=none smtp.client-ip=74.6.135.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729615626; bh=W+YjoM+UFsc+LXmblPgB436l9oughyTIbgOOXvBruAo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FqnCFpoq4jCFPithiMRhzrH6/bQ5DnkHF1qBy13oYrO4qV+tunzbgWpMQSbouxzN0DzGC9tVspro4/le3iFQO4VmLPPsJCAQ4zvywr2eOySFmQ0AUrSvPw5t0S4Wj0Z861cIHEc9vPng33XHQc5J6B4aKk9OBaLxCB7Ulck9ScoR4ddzfz7L551RBREZuIS2egH9hYTJPCNnxp+AKz1b2iZEvc1Xl8/vufKGziBM5EiTJ/ezWmFFnHramlaLI39n9AncgaCzHHwe450EKCDRo1bHQGOQPYQ8feeK/QM6+np54MtOmNYUjj8jGALU0HNjpbnzWR0Lr0i+0zhYTRe9Hg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729615626; bh=8ljbTKG1CBu5VxP3Wr9j7681FZtFjfm8i3yCvVR/QlJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=P0XBXDGHiWkYf8fBqsO1jjiuFU2PJy8pAI66/ED2pyc+3AzyGHxPZqUuS8R1L/o0qIiIZm8gNsNvtsXOWH/jwyFvsrelrz7x/L0OQL8yMt/kJZc0gs2Sg8TMjU1eJRFgitHIuDr535RNLHVAk0axb1R5iPuzKbjrnvpL/MJlVB34xZsCuSUlnABgMLOuTZdc8qLpML1ks90lLT6POrTeopYsQ158dBTaR5YzuQ1Kb2vpksVe/bgdHywr4Xy4M60CaPedcq+ZtvgKVqTg7ancNTk2Ev0IxjacndRzAoIYK2GCafcyW87r1Pvr1Ie9M8Qv++RX3PJvTahGVhe3k/8AGQ==
X-YMail-OSG: S.gcgSEVM1mhBlYSMpGksHU3UnFXpOxOFfQ11kpgsEQ44mS6gPshQRhu44cC_TZ
 bLrtowY2iy1ZoKBaGB2XJf8vQDAtgxdylNVpLzxYzKdfgqeObMLWP4NodJoiOyh3UolCCyGnG0Op
 BVYEfXs3Oj2VOnki5cNJ.0Xy5H0X.qjThRv1eQSoe6Ykm6xyyi6w0_z.CSIqkgZUo6aeDeLKMa3A
 g64PLIvdQmbqscPkDrS.5lq1GNgJ3VYU.M6sE6HCSkIUomRUVlqP5_MzHE_UE9ckeuKPep3rwwTd
 ET2.wQWFZSNK84SRqHoER0vww.8jxfVVef.YLwC2_ald4dCtDA_UAI9_9gffQYZWLPbTJVHIAOOi
 fNTSTDf4EbaP8wDgqY_wvYjgSnc7c0jnzizqebZ47_xi4ZpIoCc2srV_.wH4yU4I_1PSMcAKIntg
 b8NBv0B8OkrBlz_QPZXRPzmFoAIxxqXVasnw5hKv5djFHIRjFE0uCeB6NFQuF9DceiDkAQ7IQInm
 qJpTDhwsNKdnhN7A521cyxy13Ix9zRPQWja7hheeLJ8MWHXmxetb5dqOoF_u5PLiShJW9pvY9vc9
 _wgt_SLecosY.Z9BEtaF8V_b4L9dMqWvfevM3_OOZ6s9zWjUcWqKzPQMwoOXExfyErPRIrNb99Ow
 JvWTRUtXIFvcTq.llSknRayxy9DFOPzzxNkkkCWme.UkQyt6loXVmafhvvV3SYEQtrDayKrswAQi
 hUcAwFet.msF1poOLI0IF54sYZhe3RGX0zAt5pzFJWmbaSE_dOQcEiqxDHPYMS5pVq37wSDTfcv5
 sTscDBC6LGo6imhe5y0OO0E1IdOsFYy7h_RyEHfS6PaC8TfTjmqmkWMWZp7LJI..NtXHX7R6pX6p
 bUQhxCPiJsMFQPwrB2jXFe_7IW8mGxXTGHCaUU3jM6dWrc4cyMpKrLU0PO9aFX1GaJbdOnD4DIbF
 uRLtFP2BzS0bdXk0fb4sXjnqtsh7X9Ao26PZfbgET02BUcsL0c7hcXGi50XkPVTYMkpr.wysgjMr
 fyB6C.2FFT.qt5RcsEUv3Uu3EqsSVZlSXHgp202dEqgXv.btqKQr3SqMpdGZz2pWvrJPvypIYy2s
 1eyj83RK8oZCit9c3QuneekVol_KF68h7gthX_FP1XJJbcSCgjZAReVrg7FMSca.ZY_L3ZUUvI5m
 vN0fd.gYWoqOSXykbZl_iZr3gYlPor_ujRpi21MYWqeQvUaxL13j7tKxaoChbyJh_sROwMMc.gC6
 jl_LIMosVWAO9z8SO_ohfYEp5W6GHSDRTjuU_QwEP8JQAymkEcYTXxwUJCh4cqUDe.hvLJX0sjl1
 N31MLFBJZO9hqh_7jWqErDEsAmoEi_dyngqWrZgBXdux2GV8tL5WtG9PBW1zXYswNQNoBMFZRIPh
 s5fNcKkX3YMMzDz9TWNM1Wr6rojNVBkxMAT2WPav0RRTsdlS7yj_mPEngouIJXXDZ73SpavN3yS4
 .Cw96yAep9OtN0WQYkBRVA0IItTu7VzJXdWDqy28Rv4OhAqAS1gFK5e2AeSDMn_bnCrIyiruiMq3
 CgPFG1hblTSsgKYhdq4PtmhjD5YL81QElvtBhh7Ok5hIjJZE5LCD8OQSAyOorU2hGQpxU.iRtK3R
 hZWzOl9SVSxfxdZIhThhqtk03F242vn3C2YDHVNco.MIP3iwItYbuziIEan3abEV3SLtFqSYvLZM
 MOcDigr32.nTQVwb3Wc8rqOJcZnFBp4rF9RMbFUlGnEu4UCzZiTpYwyWAW8MZC4mDHgx9C26_nxt
 5dR7HdNeDqxUpbdVSkI6wPOC7PscMKbcIak52A0BIqFSOY.B9dASRtTdqfqJyDu4P8q.tIWK_XFK
 z8yKzY8BLxBkUrIhHL3DDdC2oy5z2_OR4yZOyozaCmPxCN0CajPxJcLkBJI3fGr0PbZBWxpwb73Z
 rJk6WjlnmzCCJV.n.EUqBTqlilPm4z51BUgkXXXzhEXombZyEk0DyhJxt0DfjReKr9INKyiomtgX
 Bvo.aUICSmhoMx2U1x7ZBhvB.ec9egcK.s3MJeDR12DsQy1yfiEUyOiTWF2nyMHPWhZiGeWtpwq4
 FCldIVTUqnW71Xu5xnRybxAgm6O3mGytqZH92EgH0pKuWlwt9pXJqYGCtnFhykpo84nbHFYX3IfJ
 kzWoRd_xBb45psnPLUYPKZsXegO4AyuAI7H_LIckk60FkHLuDHKZ_oXF5q1C8E1Ii2XQdWt4lpHn
 kekTNVwjcBwhKUFgV.KqOoP6mGDyH8PJxv9jGcinNZxw2mtExFZBVo7h9fsaDWjHgUiIB88ISKr.
 C85D5HyLLGGypjUww
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cb6630a2-79bc-4591-ab0b-03f7386e3ee5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 22 Oct 2024 16:47:06 +0000
Received: by hermes--production-gq1-5dd4b47f46-dvwsq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6a5b3f8172a524a4157cdb05ea625898;
          Tue, 22 Oct 2024 16:46:59 +0000 (UTC)
Message-ID: <6dc1c686-108e-41a2-bda3-8744e5f7626f@schaufler-ca.com>
Date: Tue, 22 Oct 2024 09:46:57 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] LSM: lsm_context in security_dentry_init_security
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241014151450.73674-5-casey@schaufler-ca.com>
 <b94aa34a25a19ea729faa1c8240ebf5b@paul-moore.com>
 <d2d34843-e23c-40a7-92ae-5ebd7c678ad4@schaufler-ca.com>
 <CAHC9VhS0zagjyqQmN6x=_ftHeeeeF50NW91yY5eEW4RF4sE98g@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhS0zagjyqQmN6x=_ftHeeeeF50NW91yY5eEW4RF4sE98g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/22/2024 9:35 AM, Paul Moore wrote:
> On Mon, Oct 21, 2024 at 8:00 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/21/2024 4:39 PM, Paul Moore wrote:
>>> On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Replace the (secctx,seclen) pointer pair with a single lsm_context
>>>> pointer to allow return of the LSM identifier along with the context
>>>> and context length. This allows security_release_secctx() to know how
>>>> to release the context. Callers have been modified to use or save the
>>>> returned data from the new structure.
>>>>
>>>> Special care is taken in the NFS code, which uses the same data structure
>>>> for its own copied labels as it does for the data which comes from
>>>> security_dentry_init_security().  In the case of copied labels the data
>>>> has to be freed, not released.
>>>>
>>>> The scaffolding funtion lsmcontext_init() is no longer needed and is
>>>> removed.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> Cc: ceph-devel@vger.kernel.org
>>>> Cc: linux-nfs@vger.kernel.org
>>>> ---
>>>>  fs/ceph/super.h               |  3 +--
>>>>  fs/ceph/xattr.c               | 16 ++++++----------
>>>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>>>>  fs/nfs/dir.c                  |  2 +-
>>>>  fs/nfs/inode.c                | 17 ++++++++++-------
>>>>  fs/nfs/internal.h             |  8 +++++---
>>>>  fs/nfs/nfs4proc.c             | 22 +++++++++-------------
>>>>  fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
>>>>  include/linux/lsm_hook_defs.h |  2 +-
>>>>  include/linux/nfs4.h          |  8 ++++----
>>>>  include/linux/nfs_fs.h        |  2 +-
>>>>  include/linux/security.h      | 26 +++-----------------------
>>>>  security/security.c           |  9 ++++-----
>>>>  security/selinux/hooks.c      |  9 +++++----
>>>>  14 files changed, 80 insertions(+), 101 deletions(-)
> ..
>
>>>> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
>>>> index 039898d70954..47652d217d05 100644
>>>> --- a/include/linux/nfs_fs.h
>>>> +++ b/include/linux/nfs_fs.h
>>>> @@ -457,7 +457,7 @@ static inline void nfs4_label_free(struct nfs4_label *label)
>>>>  {
>>>>  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
>>>>      if (label) {
>>>> -            kfree(label->label);
>>>> +            kfree(label->lsmctx.context);
>>> Shouldn't this be a call to security_release_secctx() instead of a raw
>>> kfree()?
>> As mentioned in the description, the NFS data is a copy that NFS
>> manages, so it does need to be freed, not released.
> It does, my apologies.
>
> However, this makes me wonder if using the lsm_context struct for the
> private NFS copy is the right decision.  The NFS code assumes and
> requires a single string, ala secctx, but I think we want the ability
> to potentially do other/additional things with lsm_context, even if
> this patchset doesn't do that.

This came down to a choice about where the ugly code would be.
I'll restore the old behavior.

>
> I would suggest keeping the NFS private copy as sec_ctx/sec_ctxlen and
> keep the concept of a translation between the data structures in
> place, even though it is just a simple string duplication right now.
>

