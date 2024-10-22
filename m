Return-Path: <linux-nfs+bounces-7364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F49AB41F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 18:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E567C1C22D75
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C881B86EF;
	Tue, 22 Oct 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xm75Fo7u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6A1BC9E2
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614966; cv=none; b=qNkRtl7RRtFUyZ9gaMvAg/+NtE0Y81UggtGyeK+nQOki/z/gY2qnIQftksWyXewQ3G5I67U3pLu5VKltBTEddZXiGG5kpUa9+RkelMeXzy+1IH4HOHp+4fIc3FO7tPrv6y7DjSW639HBGS/zV1BYeAPmOqfGEnRw9B4yIhdcy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614966; c=relaxed/simple;
	bh=5yuWmOUKZ4Ih5Rq09LpxFOCTv3VM9FGQMb3BvP4KQRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS6xjRkMEQNnBoqlX5xiVr4fg6YIjuk0/bJLyPoM1V9UkFjhXcWBNNMU6AbzzkbBS9XGLsbUsL4jwiY1CIErPAIDZJNN5OwSskzOnJmp2n1RcJloq9/Sc0vxz412YLpKPudhTdVbyFJU2/s/VQoYe4mb8XHjfNldGDZwtEBy7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xm75Fo7u; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so5516336276.3
        for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729614964; x=1730219764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kHdKq4o6U8pickeExw5lIFKL9p1l4H9o3slgOCVYVE=;
        b=Xm75Fo7uAZtg2+ZRZo69HQZlH4/EbtA7+4dpHhLwEg9tk9t1FHILQd7Sirz7wfR2rE
         hlAcolaDdw4U5e+QuGbuS+TKSNilBo3M6PAAyMEJmpz5mb6e7qKbjwWrkWJggwIAT3Kl
         cUIZotkmg6P87U2sVESlejEJQps6AtTXvFCBsf9hoWQpoWKnF1jdoYCF3bO6QuBklAbS
         lcpjCmGoglQzxFp4QkNjni0FSFw1JSxA9SkOhG3XcfOc0OXHH9mNpHqRn9LXvWLrpbP1
         FCoDEoeVFFL1wbddv9x7yzGhnsUfwUQE5HzYjytI+CrlrXCBLU7PGBWbHOo3NaUZMaD1
         L/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614964; x=1730219764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kHdKq4o6U8pickeExw5lIFKL9p1l4H9o3slgOCVYVE=;
        b=XI2PsAAmt9lgq45PTg4Vk78epDtLQ36FlWo3NSn5LI0YxqmU7HdFxHf17UtJzvicVo
         sKJASR9+QSWiZmS3rUN0WGywiZSQIhA7Ql6ICKhf+5u26W0QhmeqmktMGRtf8GLO8YBx
         pb4exmTxJeiuU/S6Excb7UV9SIhdzVH2j7px4Ll4eVLHwVQi2e7PQszb4gpOmuvMQ/lH
         hv/+C0xWZXwaH+P3MAFvho0N+Vb5ejsOKNKUxH17E4tl9gUPBY5e3V5fIrV01qy9Hjur
         lHpt86dVAQoMRih0fLsb0s6ZUQs/FkFVs+a7DlljeYUWbacTKKxjC8LNfAdfHAI6s646
         PkBA==
X-Forwarded-Encrypted: i=1; AJvYcCUtG6xjahOiX0YeR5Vaqc6AJzspu/e/rZdIHp7roaEe9ic5QjURccDIRjOrpqH2/UU7/eUDM052ORI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL44mcRVsajdHluW0jVBDVdslSWAq20UZ9F8Nls0BVr4zWVWTl
	1Iw/sdLDsbrDZcuOGTElFIgx1KYJ05+0gwogGbDGDOWtnZ3QfFHYY0vNzHsndFwm5Y/gP5/Fe/Y
	DoEVlJDaWfyCPYX2AYuBYM8z/1zNV24H9xvQc
X-Google-Smtp-Source: AGHT+IEibkCXXaIjJ9u3v16H+Mr2NsLiwq+BFSdV6/LvrT71yWId1tZt2dUederqlS/v2vbOxbL74ObTLEGqOowez9c=
X-Received: by 2002:a05:6902:1009:b0:e29:33d1:a3ac with SMTP id
 3f1490d57ef6-e2bb11e5b40mr14407735276.11.1729614963943; Tue, 22 Oct 2024
 09:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014151450.73674-5-casey@schaufler-ca.com>
 <b94aa34a25a19ea729faa1c8240ebf5b@paul-moore.com> <d2d34843-e23c-40a7-92ae-5ebd7c678ad4@schaufler-ca.com>
In-Reply-To: <d2d34843-e23c-40a7-92ae-5ebd7c678ad4@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 12:35:53 -0400
Message-ID: <CAHC9VhS0zagjyqQmN6x=_ftHeeeeF50NW91yY5eEW4RF4sE98g@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] LSM: lsm_context in security_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:00=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/21/2024 4:39 PM, Paul Moore wrote:
> > On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Replace the (secctx,seclen) pointer pair with a single lsm_context
> >> pointer to allow return of the LSM identifier along with the context
> >> and context length. This allows security_release_secctx() to know how
> >> to release the context. Callers have been modified to use or save the
> >> returned data from the new structure.
> >>
> >> Special care is taken in the NFS code, which uses the same data struct=
ure
> >> for its own copied labels as it does for the data which comes from
> >> security_dentry_init_security().  In the case of copied labels the dat=
a
> >> has to be freed, not released.
> >>
> >> The scaffolding funtion lsmcontext_init() is no longer needed and is
> >> removed.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Cc: ceph-devel@vger.kernel.org
> >> Cc: linux-nfs@vger.kernel.org
> >> ---
> >>  fs/ceph/super.h               |  3 +--
> >>  fs/ceph/xattr.c               | 16 ++++++----------
> >>  fs/fuse/dir.c                 | 35 ++++++++++++++++++----------------=
-
> >>  fs/nfs/dir.c                  |  2 +-
> >>  fs/nfs/inode.c                | 17 ++++++++++-------
> >>  fs/nfs/internal.h             |  8 +++++---
> >>  fs/nfs/nfs4proc.c             | 22 +++++++++-------------
> >>  fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
> >>  include/linux/lsm_hook_defs.h |  2 +-
> >>  include/linux/nfs4.h          |  8 ++++----
> >>  include/linux/nfs_fs.h        |  2 +-
> >>  include/linux/security.h      | 26 +++-----------------------
> >>  security/security.c           |  9 ++++-----
> >>  security/selinux/hooks.c      |  9 +++++----
> >>  14 files changed, 80 insertions(+), 101 deletions(-)

...

> >> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> >> index 039898d70954..47652d217d05 100644
> >> --- a/include/linux/nfs_fs.h
> >> +++ b/include/linux/nfs_fs.h
> >> @@ -457,7 +457,7 @@ static inline void nfs4_label_free(struct nfs4_lab=
el *label)
> >>  {
> >>  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
> >>      if (label) {
> >> -            kfree(label->label);
> >> +            kfree(label->lsmctx.context);
> > Shouldn't this be a call to security_release_secctx() instead of a raw
> > kfree()?
>
> As mentioned in the description, the NFS data is a copy that NFS
> manages, so it does need to be freed, not released.

It does, my apologies.

However, this makes me wonder if using the lsm_context struct for the
private NFS copy is the right decision.  The NFS code assumes and
requires a single string, ala secctx, but I think we want the ability
to potentially do other/additional things with lsm_context, even if
this patchset doesn't do that.

I would suggest keeping the NFS private copy as sec_ctx/sec_ctxlen and
keep the concept of a translation between the data structures in
place, even though it is just a simple string duplication right now.

--=20
paul-moore.com

