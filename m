Return-Path: <linux-nfs+bounces-11538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17354AAD102
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 00:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E86D3AF7E9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B22185A0;
	Tue,  6 May 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gQ9gGkSi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB37219305
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570682; cv=none; b=O6hXeo8Spt33r6D1eDqW82wHSkyqdXTCqP3t63Tb/LY3I+8c0RANqVZV6IYY3UqdQY4sgJxc2dtIcvm6wSWPHk4B9PSDX8TrxcKdv3fmZ0GILUI8lZkpzC+gOGGLHBb3fRhfCE5MFKI5SjFHdugS+Gt3qIKCLe5DAvvgFYsopWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570682; c=relaxed/simple;
	bh=X87u2AFw0RBjpOF81knenxpiGMcsB+hy1wEw/AZFCgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKl+T0xu7+iHTTHaNDA7wITXMGXdENLdW0yP/yPWhXSYGkjdWfyc6p7S23kK8ozORzsFe35gm0FsYtfTU3APEbkReWRF4jl6+0iiyATyrNY9YalyPrSt9VaMvDcbh8SlVW3HUf5e1MWIdfk7SaJk/Z9YMb2jNMErGgaRPwFcE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gQ9gGkSi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736aaeed234so5505737b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746570680; x=1747175480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/UMMj2Em65CblfZXEVKRUG2M/JosI/quCwMUnTdV2A=;
        b=gQ9gGkSi0rhN0V5ts5D93hoC2pbE8UGmiCJCdONlQo1axqgco9tXgpkEK+8vZtK9WQ
         U0L5UdIm0KhEdhY5gGeaqF484xluqAIWED7rI/Ieneeh+kUgTMJe9Pd7v+fDAPzzRdPS
         GhiprMBZEtb4XDDHAvviJRmhxC4rxa1OytR6A15QXn3D8JWI1ZK8IZFwWkUzt59mfQwP
         eyuuUiDVOAB7Okskpqx6egG9/8kytWzqp5RBIrmGO6D2T6n4SZQLPQgRIorq/r6cJf7r
         3nDWi/Tumr/RdZ6+goNOEXZoveJ6yKRm7qc5BLOa3i911T7gKn6RpPpUz1iUb7B3ozLM
         9Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570680; x=1747175480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/UMMj2Em65CblfZXEVKRUG2M/JosI/quCwMUnTdV2A=;
        b=L/oXia9Fnm1Co4tDf1TSw9GoLOuGDIPGW5FSuP+09ET1dffvfM4sfW+U7lSUHNxsrM
         6t/K1F8br+fPYe/vcdgjmHPV5N6l3F2lsYHJDwxDFO3SzCEdADqwl/KQo8wEERWtd3Jp
         XMB8gqXT5g3+TbPm6XCw0emHWzB06ZjFFMZUY4elev6YxVEmQOM77X5gauue8ccbDrg4
         qZmkZuFd2sBkh2Fce2xsRLUTmElIQO487rwtEd/R74X9jykA6bDj+f+AIpTERV52CthY
         Ifay+bJzyZEBCGDObVw99HpvdsNl1eM9ahwqf2vKc1PNC33lKuzpb6Z3QFNXT0TENIU9
         dEpw==
X-Forwarded-Encrypted: i=1; AJvYcCVT6YRePiqG9Ssr57nAjprXOQi8/Cgf3GSLhv1EYUcsTgGvx0A6az0+kYfMEz897VxiALTS7ykOezY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbU0k0LE3G13f6F/sr5RrwkYGkAtR9L/lKdfpyoeSs4M3/v1SA
	WqPR+UPLEFho41dd0mjupHfnbY2DE83H+iUg0kDftOQ1jATu9ThaH/QNeHF6hhU=
X-Gm-Gg: ASbGncsiJw8s9qACoBhVeyVuxipICTSyqdYL1HW+zr+V4KD1+OGmUa7YwRIrHH/+dJP
	rVpdyZPDrS4Fn9tLzsamVCDzweSBZ+YimwPrZfK6D03k/52N32vrTNKfyBd8DgZ0XUKzDg/6Z2L
	EAEnqkz0TcmWCtbj8mdLi3Glk56hM3lquiPqX5wtRMMxeNLIHZ2AS2Gs/ItfsjIxwQZ29fZ+8/U
	Tkh9M8znBeICAH5LtVXj/YsLjr2aOLd2/60l86AboMNMus2tsnotSNQ+4d2qmtyHV7IQo42xwes
	XwfWRMLzA2qYiSQQfbVuvGrFtPOkwIoxwv2x96qP98CyVe6+FVHa5LeJs6hNy2X6Qo27YxcqFZz
	q9Uz7Nnt8UV3vQA==
X-Google-Smtp-Source: AGHT+IFKV1zVvycjJmPL2bxLVcFHfxLB+9k14rK3DqApNa5bCEuer0R2fvn+6NVRCbA+EZAO53O5sg==
X-Received: by 2002:a05:6a00:f99:b0:740:9c06:1cff with SMTP id d2e1a72fcca58-7409cfdc557mr1028579b3a.23.1746570680440;
        Tue, 06 May 2025 15:31:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020dd4sm9571729b3a.117.2025.05.06.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 15:31:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCQon-00000000HNy-0TjW;
	Wed, 07 May 2025 08:31:17 +1000
Date: Wed, 7 May 2025 08:31:17 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
Message-ID: <aBqNtfPwFBvQCgeT@dread.disaster.area>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>

On Tue, May 06, 2025 at 01:40:35PM -0400, Jeff Layton wrote:
> FYI I decided to try and get some numbers with Mike's RWF_DONTCACHE
> patches for nfsd [1]. Those add a module param that make all reads and
> writes use RWF_DONTCACHE.
> 
> I had one host that was running knfsd with an XFS export, and a second
> that was acting as NFS client. Both machines have tons of memory, so
> pagecache utilization is irrelevant for this test.

Does RWF_DONTCACHE result in server side STABLE write requests from
the NFS client, or are they still unstable and require a post-write
completion COMMIT operation from the client to trigger server side
writeback before the client can discard the page cache?

> I tested sequential writes using the fio-seq_write.fio test, both with
> and without the module param enabled.
> 
> These numbers are from one run each, but they were pretty stable over
> several runs:
> 
> # fio /usr/share/doc/fio/examples/fio-seq-write.fio

$ cat /usr/share/doc/fio/examples/fio-seq-write.fio
cat: /usr/share/doc/fio/examples/fio-seq-write.fio: No such file or directory
$

What are the fio control parameters of the IO you are doing? (e.g.
is this single threaded IO, does it use the psync, libaio or iouring
engine, etc)

> wsize=1M:
> 
> Normal:      WRITE: bw=1034MiB/s (1084MB/s), 1034MiB/s-1034MiB/s (1084MB/s-1084MB/s), io=910GiB (977GB), run=901326-901326msec
> DONTCACHE:   WRITE: bw=649MiB/s (681MB/s), 649MiB/s-649MiB/s (681MB/s-681MB/s), io=571GiB (613GB), run=900001-900001msec
> 
> DONTCACHE with a 1M wsize vs. recent (v6.14-ish) knfsd was about 30%
> slower. Memory consumption was down, but these boxes have oodles of
> memory, so I didn't notice much change there.

So what is the IO pattern that the NFSD is sending to the underlying
XFS filesystem?

Is it sending 1M RWF_DONTCACHE buffered IOs to XFS as well (i.e. one
buffered write IO per NFS client write request), or is DONTCACHE
only being used on the NFS client side?

> I wonder if we need some heuristic that makes generic_write_sync() only
> kick off writeback immediately if the whole folio is dirty so we have
> more time to gather writes before kicking off writeback?

You're doing aligned 1MB IOs - there should be no partially dirty
large folios in either the client or the server page caches.

That said, this is part of the reason I asked about both whether the
client side write is STABLE and  whether RWF_DONTCACHE on
the server side. i.e. using either of those will trigger writeback
on the serer side immediately; in the case of the former it will
also complete before returning to the client and not require a
subsequent COMMIT RPC to wait for server side IO completion...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

