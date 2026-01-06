Return-Path: <linux-nfs+bounces-17519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED7BCFB3A3
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 23:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3302B3063F6F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7065C2F25F8;
	Tue,  6 Jan 2026 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XQPsTu7C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D921420B
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737599; cv=none; b=LGosdhNoOqdH+xDfn2bb49we5AQDGz9eyVgjUWDxldHvDSoKkJ0DchzInafa11GdYGWTm+grmdJOqDDwy39oHhia+H0kZKZopP3Xvjpt8jqU651XD6I46aN/4cpBseLAbRvqyfCQfapddrjAnz7hQ3qfYpKToQVYP/X+sCAFh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737599; c=relaxed/simple;
	bh=GluBh8m2y3PcEGE3+V9nl0D2yS7kGa0EPK26bG84vaA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=iRhCNop0ytjEK1KrCyJiygzju/Kfn66cEFrUtd3GozwsIIQITPlL7l01nos9C6iH3MS6DSXTYLhclcvvjTdeoyA21FK70LquqsZc/WtKT1WIbs2LsBsT6mKzL8Wt81xRRiLGUoahXz2lRqm8IFjC0nMxP3w4A6xfb95UnSDRNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XQPsTu7C; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a379ca088so15808806d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 Jan 2026 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767737595; x=1768342395; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ndqp7w6INqSmDj45WR661sezFnhIaCas/O5ymSiHjQ=;
        b=XQPsTu7CGWrwhmDA1fIvenjHRnkIhsaeMXmGkj1NClTQtpGehA3W1yPzyQt/uQEqHq
         1NuPjhVh5s7OKK6+UmgUS45uqoKs1pJowLtUqO+yPsYDMjF2EaAQAEMOnNubOrpgEUlp
         AYAndsEGX4GCshBEHaDqRh0TIn7V3owdjZszR9sriC1xGb1Cseh7Vh9+OtwCVXQYDqy8
         B4cQ/hhAR4YowWtqMx+hzuHrDOLGvjBhMQh1l4zsGYOSv5Cski6EGr8OkhjAHMwN1b6B
         pPbAiHAYCAcBNjkklqbF1kYr38By80Zk9HNwHlIC/h5/nCKtyyrfXbS6O+Y49ilddWbx
         pYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767737595; x=1768342395;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ndqp7w6INqSmDj45WR661sezFnhIaCas/O5ymSiHjQ=;
        b=rD88xArG1wNt3GmzJj/H6kT6eIia5u67AZuHkn3c1IPz8/zuO8BA0oaxu7CnsRVrV+
         DSF5RwK+KxTJaaxwp79G0FKjYpc8Mig0nJ7gZqaAyNxuNN++YfoVHzoCqzDJI7mTWbV6
         1iqrqfXe/fKLLgr61WfNaL/OMzQPZQTFnYIDDrX573GHUs6Aq+omlslUdFlbhJPZTDrv
         HJeAmEwAd1SlDcaNh8ih3bPBrbshpxv9aLqvTjnc/VMXB/aSs5cLdW+bePMODNJJCJQh
         JfBVCg4Xr5RLtxMzAjpcVbHsw+6XoSly3uGetKgMVb7hV/KxAK3onLrJqJ7FL91ajpf7
         LEXw==
X-Forwarded-Encrypted: i=1; AJvYcCWdXwPnci40yHJK/i9HgH+LyHI1iE+aG+pE/CAOXJDPLv05MozqVpeNLwmQb/vV4hsg95Oy1JvaOOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOi34c+lHRqpuOJz1ITcm6BLqjSM9hLFxIHFE+XOPRarl4bGSx
	KrTXdcsl2B3a1BiQUuAttnfJq0AVqTWz1+2Q3LPWwWGwX5wC+6HS4lOiqv/EmLKe8Q==
X-Gm-Gg: AY/fxX6DvnwJmMeXIb1AGyJzsTlOoXiyKC4URSFTqPmsISdg5Vx7aQSLDE61zXE4BmB
	JANl5B8eds3q3WBPPtcYjzpMPOahjyt3ba+baVjpNZAGmI4+8bUU1IotbahLO9EnqOT3r+5ifUg
	7zaK+/pBgIP7cjKI1wZjCCNfhBed52IA+Xd7UHX5831wfAAqmiPd7cTjgtjnR76H5ajk00uV89a
	ido7aM0jmIBqmFVVKKqRBs8an2r/DhmWFeY3m8T2cQHplhwC20M7yZO4+tEhQBw0iH0tNxgzFYp
	7as9/2yN5x7JLa4j0V/6piKkm88vNF10dn08jbeRFHUVZxV2dfWCtuzWbaEDg6j/5cY+Iv1rGvS
	FiAXTddYAYGzPkEen17puwKgHhuwPCBiCy0yjLRppdRJ8V6O333li6Z+jvsFJ6UBAzE4wZBETS+
	DSVrasOAdGXMhwTsbYCB2H7x+Hx3GztSbhh4EPGPa1OFyxv6NSLI/qEv+V
X-Google-Smtp-Source: AGHT+IHcmlCgI7WlFr18qOoSGtSo4kPbBkhNEeig2CIGNrNBUesdSzmx2NVuMD6+7V/OhPmQRFjH0A==
X-Received: by 2002:a05:6214:5509:b0:88a:525a:8db8 with SMTP id 6a1803df08f44-8908424fc75mr7312106d6.35.1767737595588;
        Tue, 06 Jan 2026 14:13:15 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm21004626d6.18.2026.01.06.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 14:13:14 -0800 (PST)
Date: Tue, 06 Jan 2026 17:13:13 -0500
Message-ID: <95dbf9af0e01953e2e6dca14eead406c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260106_1639/pstg-lib:20260106_1639/pstg-pwork:20260106_1639
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, trondmy@kernel.org, anna@kernel.org
Cc: okorniev@redhat.com, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] nfs: unify security_inode_listsecurity() calls
References: <20251203195728.8592-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20251203195728.8592-1-stephen.smalley.work@gmail.com>

On Dec  3, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> security label") introduced a direct call to
> security_inode_listsecurity() in nfs4_listxattr(). However,
> nfs4_listxattr() already indirectly called
> security_inode_listsecurity() via nfs4_listxattr_nfs4_label() if
> CONFIG_NFS_V4_SECURITY_LABEL is enabled and the server has the
> NFS_CAP_SECURITY_LABEL capability enabled. This duplication was fixed
> by commit 9acb237deff7 ("NFSv4.2: another fix for listxattr") by
> making the second call conditional on NFS_CAP_SECURITY_LABEL not being
> set by the server. However, the combination of the two changes
> effectively makes one call to security_inode_listsecurity() in every
> case - which is the desired behavior since getxattr() always returns a
> security xattr even if it has to synthesize one. Further, the two
> different calls produce different xattr name ordering between
> security.* and user.* xattr names. Unify the two separate calls into a
> single call and get rid of nfs4_listxattr_nfs4_label() altogether.
> 
> Link: https://lore.kernel.org/selinux/CAEjxPJ6e8z__=MP5NfdUxkOMQ=EnUFSjWFofP4YPwHqK=Ki5nw@mail.gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/nfs/nfs4proc.c | 38 +++-----------------------------------
>  1 file changed, 3 insertions(+), 35 deletions(-)

It's been over a month without any comments, positive or negative, so
I'm going to go ahead and merge this into lsm/dev; if anyone has any
objections, ACKS, etc. please speak up soon.

Thanks Stephen.

--
paul-moore.com

