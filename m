Return-Path: <linux-nfs+bounces-1059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16082C0EE
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 14:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A9B23B79
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790D22078;
	Fri, 12 Jan 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ifq/DAJM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84E58ADE
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705066593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvYIYJeLeB06paZmW4hgjS6ozliWuLUPfb3Gvt5MgYU=;
	b=Ifq/DAJM+LSJfSRPoqTG2O9Kr19rjXxk+/5S6Z3xLZVWt96AaRY1HtZ+zIOo5HuBB3YDAd
	yGprR0ygU+aN44gJe7exbj6xQrdSvjaAmAE2lxuYM5VAIiNwS5zrHEcH4dvyI6QrlZph5o
	dkGnIe3vR0tjvlgDkuEexKxcx3HpwwI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-7wb34f9ZMfiOm0Wm1IvQuA-1; Fri, 12 Jan 2024 08:36:31 -0500
X-MC-Unique: 7wb34f9ZMfiOm0Wm1IvQuA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d4a87da75dso43315885ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 05:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705066591; x=1705671391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvYIYJeLeB06paZmW4hgjS6ozliWuLUPfb3Gvt5MgYU=;
        b=qOyFR474OQBrx8wRVsKUvtTNeFb05y48Ofx2kYxP9Xbs5A8NQmEbSV0AhedfLZB9wT
         rG05LTpWN61zCcZX9bIjYfrri/lfgVgY3JJM+wEhm9WkBe8bwgK2oBaLRwXafpw3AKk3
         FR46j+GqFLP7p1GcO9edx/mgZqbtRfAwJ1G9uj6RRFymO0h1i9rRw6cGUbsz+s4jZmCq
         kRBX/QHQGgh1XtG0ck+O5zzDYd5AMC3WYuLYoqfwy+Ry1ZbWQSIz84beBB0ICjYDfGcS
         n3Ap+TB1qMr/ut2hX+jdOXgXTmnE/Wf/5UovkSL6lF5BN289gcmoioxmedjHhzNMe2Ay
         uzig==
X-Gm-Message-State: AOJu0Yw40AHKfXcxVF7RieIYg7ik8Rk0F9JyYILjy5NWLXG+aHkJvCyU
	xnEFjvSFtc1/vDfI/cylnb06pIPg8+SRQhfxxNuzQ/XWFx2LPaBHkjfuPftaaNm6a4pbyIHdNHS
	L07DqxM4jkEdmoKc8sjHrpD/jLoXl
X-Received: by 2002:a17:903:4296:b0:1d4:e36f:7498 with SMTP id ju22-20020a170903429600b001d4e36f7498mr713088plb.21.1705066590805;
        Fri, 12 Jan 2024 05:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlzjj1+nEKKUvBtCuI6OTkb/XBiisQQHeypKqoICjN2Lzpa376TydU/On1iRorLUSiijabKg==
X-Received: by 2002:a17:903:4296:b0:1d4:e36f:7498 with SMTP id ju22-20020a170903429600b001d4e36f7498mr713077plb.21.1705066590537;
        Fri, 12 Jan 2024 05:36:30 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001d54c61690csm3131070plr.287.2024.01.12.05.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 05:36:30 -0800 (PST)
Date: Fri, 12 Jan 2024 21:36:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH fstests 2/2] generic/732: don't run it on NFS
Message-ID: <20240112133626.k6iaqkmnn5ngmzx7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
 <20240110-fixes-v1-2-69f5ddd95656@kernel.org>
 <20240111204931.oqbub6crymt2misb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <1a2ad4e0142c6a80a0930c9d4841facb75a8f93b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2ad4e0142c6a80a0930c9d4841facb75a8f93b.camel@kernel.org>

On Thu, Jan 11, 2024 at 04:13:11PM -0500, Jeff Layton wrote:
> On Fri, 2024-01-12 at 04:49 +0800, Zorro Lang wrote:
> > On Wed, Jan 10, 2024 at 01:27:28PM -0500, Jeff Layton wrote:
> > > This test sets up two independent superblocks with the same backend
> > > server, and then does RENAMES of the same files in the two servers. This
> > > is basically trying to simulate the case where two clients are competing
> > > to rename files in the same directory on the same server.
> > > 
> > > This test would usually pass vs. an NFSv4 server that doesn't have
> > > dfdd2630a7398 ("nfsd: fix change_info in NFSv4 RENAME replies"), because
> > > the client would end up improperly invalidating the dcache for the whole
> > > dir after most RENAMEs.
> > > 
> > > However, this test doesn't (and shouldn't) pass on NFS, because the
> > > client has no idea that a rename has happened on the second mount. The
> > > expected behavior for the NFS client is for it to use the cache timeouts
> > > in this case, which is what it now does with the above server bug fixed.
> > > 
> > > Exempt NFS from running this test, since we don't expect it to pass.
> > > 
> > > Cc: Yongcheng Yang <yoyang@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > 
> > This case is written for a nfs fix at first. If nfs would like to skip this
> > test, I don't know if it makes sense to keep it in fstests?
> > 
> > 
> 
> It might make sense to keep this test in place for stuff like cephfs,
> but if dropping it altogether is best, then that's fine with me.

Oh, I forgot this:

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> > 
> > >  tests/generic/732 | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/tests/generic/732 b/tests/generic/732
> > > index 785aac58f361..5b5087d5accd 100755
> > > --- a/tests/generic/732
> > > +++ b/tests/generic/732
> > > @@ -22,9 +22,7 @@ _cleanup()
> > >  }
> > >  
> > >  # real QA test starts here
> > > -_supported_fs generic
> > > -[ "$FSTYP" = "nfs" ] && _fixed_by_kernel_commit fdd2630a739819 \
> > > -	"nfsd: fix change_info in NFSv4 RENAME replies"
> > > +_supported_fs ^nfs
> > >  
> > >  _require_test
> > >  _require_scratch
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


