Return-Path: <linux-nfs+bounces-20470-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLt7E9u4xmnoNwUAu9opvQ
	(envelope-from <linux-nfs+bounces-20470-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 18:05:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B6E348087
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 18:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F4031009DC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17823624C6;
	Fri, 27 Mar 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCAnPo3q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4B35F5E4;
	Fri, 27 Mar 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630660; cv=none; b=DYi+6HIZb3CNv20ELh1bkR0s2Pxxh4X3PFQB7MhnK5LH1xq69GCMYwz+4K+q6nWmU9vEe0ZkqqFOuqhWMkEr14OHqWwh0IwRHVtniX25oy8k0ZweIKT26lf1/F/mrVQabUoCIY4YMKFJAPm9yImScTCQP8pX8GssQ8b9Kdirj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630660; c=relaxed/simple;
	bh=/2qgyc/J6vbHzNXCgM+0N71x7LuvuOBT8ngipuSzcUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxYdyjlLvIELCUc7C5/GXFULyAnBEXh5BUORc56b0+04ovr76AU1DQRbWdT2vOTxfP2CrN7ydpdp9/djJv/UQ+Wf0/zzY+rIVLyJM82rMTkIzbNc8bZTMfvXqONAsvk4fP2YdMuY+00tUJ7FNsknnEuTlTHUzhTcEMbQHNX3y2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCAnPo3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F8EC19424;
	Fri, 27 Mar 2026 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774630660;
	bh=/2qgyc/J6vbHzNXCgM+0N71x7LuvuOBT8ngipuSzcUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCAnPo3qsTS0bmwkHedM7k0tywz5q/cqGsL4bXNJ48KOg+Cql74HJn4i00Jm3by99
	 WioHwQRuNyNXr1ywEFN+vT7IWyBETWJtzH+qsXKuh0BIL7u381sSWjWg9aK639zBFe
	 S8ovXi3CDklC9iKtBSABiD2Fu3vTP456Q8PU7eZ7Y74MXjyx8iPxFjyY5nY6Gb3Tz8
	 evGSM3DWDyRGXicHZw8sJEHYjpVy1B679b48VKbPUK0cpRGLfpBQegoIFf309tEswf
	 RVFboxeYSjk1fCBNgt9hYwcwXpphkz4TGI8mCIB9ad4W65nDysKg70QmZZiMB36pCE
	 NKo1ozgPIxzAQ==
Date: Fri, 27 Mar 2026 12:57:38 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, jonathan.flynn@hammerspace.com
Subject: Re: A comparison of the new nfsd iomodes (and an experimental one)
Message-ID: <aca3ApIPUGAovh_7@kernel.org>
References: <4ebbd194ccfb3bcea6225d926b4c9f339e21c813.camel@kernel.org>
 <d453add6-ed23-4d61-af95-d80133b0e456@oracle.com>
 <33582a86daf135336f6bc0d5260d8de0501abadd.camel@kernel.org>
 <acWbrlvt_dUB9X3R@kernel.org>
 <70e9c23a97d94a3dad5aa7f03f5a22c0950b00bf.camel@kernel.org>
 <43921656-e0c3-4b55-ad1f-4965ff40f1f4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43921656-e0c3-4b55-ad1f-4965ff40f1f4@oracle.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20470-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3B6E348087
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 09:19:07AM -0400, Chuck Lever wrote:
> On 3/27/26 7:32 AM, Jeff Layton wrote:
> > On Thu, 2026-03-26 at 16:48 -0400, Mike Snitzer wrote:
> >
> >> Your bandwidth for 1MB sequential IO of 793 MB/s for O_DIRECT and
> >> 4,952 MB/s for buffered and dontcache is considerably less than the 72
> >> GB/s offered in Jon's testbed.  Your testing isn't exposing the
> >> bottlenecks (contention) of the MM subsystem for buffered IO... not
> >> yet put my finger on _why_ that is.
> > 
> > That may very well be, but not everyone has a box as large as the one
> > you and Jon were working with.
>
> Right, and this is kind of a blocker for us. Practically speaking, Jon's
> results are not reproducible.
> 
> It would be immensely helpful if the MM-tipover behavior could be
> reproduced on smaller systems. Reduced physical memory size, lower
> network and storage speed, and so on, so that Jeff and I can study the
> issue on our own systems.

Hammerspace still has the same performance lab setup, so we can
certainly reproduce if needed (and try to scale it down, etc) but
unfortunately its currently tied up with other important work. Jon
Flynn's testing was "only" with 2 systems (the NFS server has 16 fast
NVMe, client system connecting over 400 GbE with RDMA). But I'll see
about shaking a couple systems loose...

Might be useful for us to document the setup of the NFS server side
and give pointers for how to mount from the client system and then run
fio commandline.

I think Jens has a couple beefy servers with lots of fast NVMe. Maybe
he'd be open to testing NFS server scalability when he isn't touring
around the country watching his kid win motorsports events.. JENS!? ;)

Mike

