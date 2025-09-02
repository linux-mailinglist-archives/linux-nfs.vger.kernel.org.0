Return-Path: <linux-nfs+bounces-13987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB23B40F04
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 23:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002CE7B2F2D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7143AC39;
	Tue,  2 Sep 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI46/C8I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497152253EB
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847216; cv=none; b=uM1hq6JCD5Dijdn0aLE7W0z3Sh6hP2K2/8PVOqiXcBiSr80CTUrAleKoLL2wwp9q+aSVqJLXKH8Gyz01Jui+QWEYlVwyj9mv+1bNsXa3wLNRv9viusePgqLLmOK12HJOruSr3hQNuTdiQYdRJ5xdUnKhs85d19VEknpCJUKRVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847216; c=relaxed/simple;
	bh=nsIzL4IkJQNGKAlzxoktTu61Wt2Ql2JHnAwSy7Ypblc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH9N/08MC44gfUKHUXc3Bv4w/TB/SvYGGkBMfabdGvkiH5nThZcvCZ6JjHHTEtZw5fYTZ2gb1nIXFBBCFR0KSbwVA4zWTWMBkON3xaxosbrOY+T6lVxuSacb+mpBV3D7nne2iPQungqR84q+OeC+ygY3vgTMhJZLDOoji6olSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI46/C8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C90CC4CEED;
	Tue,  2 Sep 2025 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756847215;
	bh=nsIzL4IkJQNGKAlzxoktTu61Wt2Ql2JHnAwSy7Ypblc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uI46/C8IdTlOCMVTFCHmabOU+HjSISqH8GGpxhDDWsPB4WB4d3p2c24bA1o2270Wj
	 xkbCZsEpItipLZiaM/SqFGGTtQNTRXCnlbRN1eTAuCYOa13PjdD2Xp2Er5FufX1Kw6
	 d1/QMgHR53ImMbmXZ0bVYNNi/dP26l6OvQoAucztAjt5q0douh64gsJveGgccGZyL0
	 EXlHSbcDXh2pOflt8S3LbD/k0FjBPsxa7iKAaIbFvAhAuelk4mZTLgZR159FgfpS0G
	 7112xg4ISTqvKnsLFlA25KK/X7iFyDkq4smeFTfUonwLz0B+A9YqJOj+VE5Sf1JXZl
	 MtHxnLg1t67rQ==
Date: Tue, 2 Sep 2025 17:06:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
Message-ID: <aLdcbnELMGHB-B_E@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>

On Tue, Sep 02, 2025 at 01:59:12PM -0400, Chuck Lever wrote:
> On 9/2/25 11:56 AM, Chuck Lever wrote:
> > On 8/30/25 1:38 PM, Mike Snitzer wrote:
> 
> >> dt (j:1 t:1): File System Information:
> >> dt (j:1 t:1):            Mounted from device: 192.168.0.105:/hs_test
> >> dt (j:1 t:1):           Mounted on directory: /mnt/hs_test
> >> dt (j:1 t:1):                Filesystem type: nfs4
> >> dt (j:1 t:1):             Filesystem options: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,nconnect=16,port=20491,timeo=600,retrans=2,sec=sys,clientaddr=192.168.0.106,local_lock=none,addr=192.168.0.105
> > 
> > I haven't been able to reproduce a similar failure in my lab with
> > NFSv4.2 over RDMA with FDR InfiniBand. I've run dt 6-7 times, all
> > successful. Also, for shit giggles, I tried the fsx-based subtests in
> > fstests, no new failures there either. The export is xfs on an NVMe
> > add-on card; server uses direct I/O for READ and page cache for WRITE.
> > 
> > Notice the mount options for your test run: "proto=tcp" and
> > "nconnect=16". Even if your network fabric is RoCE, "proto=tcp" will
> > not use RDMA at all; it will use bog standard TCP/IP on your ultra
> > fast Ethernet network.
> > 
> > What should I try next? I can apply 2/2 or add "nconnect" or move the
> > testing to my RoCE fabric after lunch and keep poking at it.

Hmm, I'll have to check with the Hammerspace performance team to
understand how RDMA used if the client mount has proto=tcp.

Certainly surprising, thanks for noticing/reporting this aspect.

I also cannot reproduce on a normal tcp mount and testbed.  This
frankenbeast of a fast "RDMA" network that is misconfigured to use
proto=tcp is the only testbed where I've seen this dt data mismatch.

> > Or, I could switch to TCP. Suggestions welcome.
> 
> The client is not sending any READ procedures/operations to the server.
> The following is NFSv3 for clarity, but NFSv4.x results are similar:
> 
>             nfsd-1669  [003]  1466.634816: svc_process:
> addr=192.168.2.67 xid=0x7b2a6274 service=nfsd vers=3 proc=NULL
>             nfsd-1669  [003]  1466.635389: svc_process:
> addr=192.168.2.67 xid=0x7d2a6274 service=nfsd vers=3 proc=FSINFO
>             nfsd-1669  [003]  1466.635420: svc_process:
> addr=192.168.2.67 xid=0x7e2a6274 service=nfsd vers=3 proc=PATHCONF
>             nfsd-1669  [003]  1466.635451: svc_process:
> addr=192.168.2.67 xid=0x7f2a6274 service=nfsd vers=3 proc=GETATTR
>             nfsd-1669  [003]  1466.635486: svc_process:
> addr=192.168.2.67 xid=0x802a6274 service=nfsacl vers=3 proc=NULL
>             nfsd-1669  [003]  1466.635558: svc_process:
> addr=192.168.2.67 xid=0x812a6274 service=nfsd vers=3 proc=FSINFO
>             nfsd-1669  [003]  1466.635585: svc_process:
> addr=192.168.2.67 xid=0x822a6274 service=nfsd vers=3 proc=GETATTR
>             nfsd-1669  [003]  1470.029208: svc_process:
> addr=192.168.2.67 xid=0x832a6274 service=nfsd vers=3 proc=ACCESS
>             nfsd-1669  [003]  1470.029255: svc_process:
> addr=192.168.2.67 xid=0x842a6274 service=nfsd vers=3 proc=LOOKUP
>             nfsd-1669  [003]  1470.029296: svc_process:
> addr=192.168.2.67 xid=0x852a6274 service=nfsd vers=3 proc=FSSTAT
>             nfsd-1669  [003]  1470.039715: svc_process:
> addr=192.168.2.67 xid=0x862a6274 service=nfsacl vers=3 proc=GETACL
>             nfsd-1669  [003]  1470.039758: svc_process:
> addr=192.168.2.67 xid=0x872a6274 service=nfsd vers=3 proc=CREATE
>             nfsd-1669  [003]  1470.040091: svc_process:
> addr=192.168.2.67 xid=0x882a6274 service=nfsd vers=3 proc=WRITE
>             nfsd-1669  [003]  1470.040469: svc_process:
> addr=192.168.2.67 xid=0x892a6274 service=nfsd vers=3 proc=GETATTR
>             nfsd-1669  [003]  1470.040503: svc_process:
> addr=192.168.2.67 xid=0x8a2a6274 service=nfsd vers=3 proc=ACCESS
>             nfsd-1669  [003]  1470.041867: svc_process:
> addr=192.168.2.67 xid=0x8b2a6274 service=nfsd vers=3 proc=FSSTAT
>             nfsd-1669  [003]  1470.042109: svc_process:
> addr=192.168.2.67 xid=0x8c2a6274 service=nfsd vers=3 proc=REMOVE
> 
> So I'm probably missing some setting on the reproducer/client.
> 
> /mnt from klimt.ib.1015granger.net:/export/fast
>  Flags:	rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
>   fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
>   sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
>   local_lock=none,addr=192.168.2.55
> 
> Linux morisot.1015granger.net 6.15.10-100.fc41.x86_64 #1 SMP
>  PREEMPT_DYNAMIC Fri Aug 15 14:55:12 UTC 2025 x86_64 GNU/Linux

If you're using LOCALIO (client on server) that'd explain your not
seeing any READs coming over the wire to NFSD.

I've made sure to disable LOCALIO on my client, with:
echo N > /sys/module/nfs/parameters/localio_enabled

