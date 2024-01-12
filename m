Return-Path: <linux-nfs+bounces-1058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793F82C0EC
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 14:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9017C1F24829
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F456BB49;
	Fri, 12 Jan 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8aDm6d2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0615D91A
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705066552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpJzkrmj08C5Xizjya0CoNsCINxaksJrnJLamVSYINQ=;
	b=L8aDm6d2bQtPwoG5Kry977fhd+/vqZhg7Fx0w+wov4wCxDfolpR7r4LxMntamxgCqQ+/0A
	VwQwg2ULc0iKOlZkRXhgyH5wJh0eU1+V5nEtXjxYSmpeAEYBbo7uFEHFW/vhyJ5aEEklPS
	PjUyO9b68nSQ7z2KIe/9MhDLIL0BJ2w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-28OZXe_2OUW6MkjLKV0HSw-1; Fri, 12 Jan 2024 08:35:50 -0500
X-MC-Unique: 28OZXe_2OUW6MkjLKV0HSw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ce63e72bc3so2698034a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 05:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705066549; x=1705671349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpJzkrmj08C5Xizjya0CoNsCINxaksJrnJLamVSYINQ=;
        b=rSwMhQQ1XNn5tm6uU5avR980YVBtREdl5h6jS8AvtaTI/uPcPEjif2/HnYss6i4CHM
         2UKzdt9QP80sXkkUPPi4L1IXLENh26EbI2J08BvRum++QCqEZK48bl6HIZ5BtT761DLs
         XRUWflbuxp3GtGvCKO3LFf2Je/XYlZOwSCfyPPe3E7VlPB/X7wrwhjQzhRKxvyXhiFjP
         eMYv21Ob+b/MNvTZrneUeiQoy4A4qC8Uw9OVDeXJuphAGTmJdim4nHXoV0oRZalEG3b7
         RMNscSKVxWxvHhJaP9j721TVrfvl5Bsxobr4TuGmPhk3NspL76T0Tnh+YiXwVMMC+Dgz
         25JQ==
X-Gm-Message-State: AOJu0YwhWX34j3Guav7T1SHnIrAVjonlRHxDLfPsF+adDhQCaqOZsoco
	VZD7FFQwwuEfCbenmFgprcE+Lb0m3AT89yyojWcONnkZ7rx4XM3+35vLJdi2wxCxtR4oz6FVAe/
	fuCeDoYAn/1n7OBdB8ThCB8qSMfHp
X-Received: by 2002:a17:902:6847:b0:1d4:e31b:11a7 with SMTP id f7-20020a170902684700b001d4e31b11a7mr887469pln.24.1705066549736;
        Fri, 12 Jan 2024 05:35:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgWzRPRKwiTz4goDaZ0z0X4/uAZD3P4hSq8BnCtR5U+7+r0jvtluQxbe0gX7qcWDSpPNZSuA==
X-Received: by 2002:a17:902:6847:b0:1d4:e31b:11a7 with SMTP id f7-20020a170902684700b001d4e31b11a7mr887462pln.24.1705066549432;
        Fri, 12 Jan 2024 05:35:49 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id db11-20020a17090ad64b00b00286da7407f2sm6375046pjb.7.2024.01.12.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 05:35:49 -0800 (PST)
Date: Fri, 12 Jan 2024 21:35:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH fstests 2/2] generic/732: don't run it on NFS
Message-ID: <20240112133545.r7obtpchaetmodxv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

OK, thanks for this feedback, if it still makes sense for any one fs,
we can keep it.

Thanks,
Zorro

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


