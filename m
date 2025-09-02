Return-Path: <linux-nfs+bounces-13992-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23273B40F5B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 23:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08C3178203
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2BB3451CA;
	Tue,  2 Sep 2025 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+Y6ZMvR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E3310652
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848432; cv=none; b=nXFRpAuP1w+/Xmb31LmqCcif6wLwqkzJyWGEh8KelLG5GZ8wM/v9dMuH3VNHCvR1zv4EZ3xTiZIXugt+v8HkX9vapVPoA8HJ51oPaDJAcIzRUGhIZXSUNfHtrROePpS2SC5ViliBdtXHPb8zMnzbMxjCh04XpWRZEKdQSwJQ8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848432; c=relaxed/simple;
	bh=Tv/oidRHhGN7tGb7O2zFP88JS+2XjlXyUCmjPgAVWl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUsLslsX8Z21Ai4hX8aq40hPjrapYAqpb0O21I7zl+BvbwVOzIwVxUhsLLxbwRszGtuslcAMCmntMFSxdsfJGjmYRruZb3xbNUwoO5XQu7DA2t62do2NP8YbFF3j5YTbSsvv4A5oUmS5+vfPQCFHSaNjKSH+YykcoB9j7C08GI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+Y6ZMvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245BFC4CEED;
	Tue,  2 Sep 2025 21:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756848432;
	bh=Tv/oidRHhGN7tGb7O2zFP88JS+2XjlXyUCmjPgAVWl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+Y6ZMvRis0xKeO30g0x77FNueEeSpRjctsee608a1l9QXF0S9+37u6VmR3MW/y9/
	 lS6zLkXLZzsk541QIWnU3cyY8MQlWdOeLUoWk8BMnnSATA5ceIYFLRyXWUbMUb7gAQ
	 5THsQtDvA9sqRCZdDamo3gCVfHGudFRY5bF1tWlU3BqqCJWA0Pavin8iO1OQ30i63s
	 lM2ztfrQNLB/fGAXVpL3mXY0LRrRDW7vPBqQ2X5N8HPCNW9dBCO+EDG/hwcH6lTHKy
	 NwV0ndcBUKOSKrGC3eeRpKhQuceG3ftrh0qv1ELgiS+Rq6Bbf1Yd+BfFukUW/YUcL0
	 oPhhsDEBG0zDw==
Date: Tue, 2 Sep 2025 17:27:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
Message-ID: <aLdhL7xFxR-r7H_m@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
 <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>

On Tue, Sep 02, 2025 at 05:16:10PM -0400, Chuck Lever wrote:
> On 9/2/25 5:06 PM, Mike Snitzer wrote:
> > On Tue, Sep 02, 2025 at 01:59:12PM -0400, Chuck Lever wrote:
> >> On 9/2/25 11:56 AM, Chuck Lever wrote:
> >>> On 8/30/25 1:38 PM, Mike Snitzer wrote:
> >>
> >>>> dt (j:1 t:1): File System Information:
> >>>> dt (j:1 t:1):            Mounted from device: 192.168.0.105:/hs_test
> >>>> dt (j:1 t:1):           Mounted on directory: /mnt/hs_test
> >>>> dt (j:1 t:1):                Filesystem type: nfs4
> >>>> dt (j:1 t:1):             Filesystem options: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,nconnect=16,port=20491,timeo=600,retrans=2,sec=sys,clientaddr=192.168.0.106,local_lock=none,addr=192.168.0.105
> >>>
> >>> I haven't been able to reproduce a similar failure in my lab with
> >>> NFSv4.2 over RDMA with FDR InfiniBand. I've run dt 6-7 times, all
> >>> successful. Also, for shit giggles, I tried the fsx-based subtests in
> >>> fstests, no new failures there either. The export is xfs on an NVMe
> >>> add-on card; server uses direct I/O for READ and page cache for WRITE.
> >>>
> >>> Notice the mount options for your test run: "proto=tcp" and
> >>> "nconnect=16". Even if your network fabric is RoCE, "proto=tcp" will
> >>> not use RDMA at all; it will use bog standard TCP/IP on your ultra
> >>> fast Ethernet network.
> >>>
> >>> What should I try next? I can apply 2/2 or add "nconnect" or move the
> >>> testing to my RoCE fabric after lunch and keep poking at it.
> > 
> > Hmm, I'll have to check with the Hammerspace performance team to
> > understand how RDMA used if the client mount has proto=tcp.
> > 
> > Certainly surprising, thanks for noticing/reporting this aspect.
> > 
> > I also cannot reproduce on a normal tcp mount and testbed.  This
> > frankenbeast of a fast "RDMA" network that is misconfigured to use
> > proto=tcp is the only testbed where I've seen this dt data mismatch.
> > 
> >>> Or, I could switch to TCP. Suggestions welcome.
> >>
> >> The client is not sending any READ procedures/operations to the server.
> >> The following is NFSv3 for clarity, but NFSv4.x results are similar:
> >>
> >>             nfsd-1669  [003]  1466.634816: svc_process:
> >> addr=192.168.2.67 xid=0x7b2a6274 service=nfsd vers=3 proc=NULL
> >>             nfsd-1669  [003]  1466.635389: svc_process:
> >> addr=192.168.2.67 xid=0x7d2a6274 service=nfsd vers=3 proc=FSINFO
> >>             nfsd-1669  [003]  1466.635420: svc_process:
> >> addr=192.168.2.67 xid=0x7e2a6274 service=nfsd vers=3 proc=PATHCONF
> >>             nfsd-1669  [003]  1466.635451: svc_process:
> >> addr=192.168.2.67 xid=0x7f2a6274 service=nfsd vers=3 proc=GETATTR
> >>             nfsd-1669  [003]  1466.635486: svc_process:
> >> addr=192.168.2.67 xid=0x802a6274 service=nfsacl vers=3 proc=NULL
> >>             nfsd-1669  [003]  1466.635558: svc_process:
> >> addr=192.168.2.67 xid=0x812a6274 service=nfsd vers=3 proc=FSINFO
> >>             nfsd-1669  [003]  1466.635585: svc_process:
> >> addr=192.168.2.67 xid=0x822a6274 service=nfsd vers=3 proc=GETATTR
> >>             nfsd-1669  [003]  1470.029208: svc_process:
> >> addr=192.168.2.67 xid=0x832a6274 service=nfsd vers=3 proc=ACCESS
> >>             nfsd-1669  [003]  1470.029255: svc_process:
> >> addr=192.168.2.67 xid=0x842a6274 service=nfsd vers=3 proc=LOOKUP
> >>             nfsd-1669  [003]  1470.029296: svc_process:
> >> addr=192.168.2.67 xid=0x852a6274 service=nfsd vers=3 proc=FSSTAT
> >>             nfsd-1669  [003]  1470.039715: svc_process:
> >> addr=192.168.2.67 xid=0x862a6274 service=nfsacl vers=3 proc=GETACL
> >>             nfsd-1669  [003]  1470.039758: svc_process:
> >> addr=192.168.2.67 xid=0x872a6274 service=nfsd vers=3 proc=CREATE
> >>             nfsd-1669  [003]  1470.040091: svc_process:
> >> addr=192.168.2.67 xid=0x882a6274 service=nfsd vers=3 proc=WRITE
> >>             nfsd-1669  [003]  1470.040469: svc_process:
> >> addr=192.168.2.67 xid=0x892a6274 service=nfsd vers=3 proc=GETATTR
> >>             nfsd-1669  [003]  1470.040503: svc_process:
> >> addr=192.168.2.67 xid=0x8a2a6274 service=nfsd vers=3 proc=ACCESS
> >>             nfsd-1669  [003]  1470.041867: svc_process:
> >> addr=192.168.2.67 xid=0x8b2a6274 service=nfsd vers=3 proc=FSSTAT
> >>             nfsd-1669  [003]  1470.042109: svc_process:
> >> addr=192.168.2.67 xid=0x8c2a6274 service=nfsd vers=3 proc=REMOVE
> >>
> >> So I'm probably missing some setting on the reproducer/client.
> >>
> >> /mnt from klimt.ib.1015granger.net:/export/fast
> >>  Flags:	rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
> >>   fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
> >>   sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
> >>   local_lock=none,addr=192.168.2.55
> >>
> >> Linux morisot.1015granger.net 6.15.10-100.fc41.x86_64 #1 SMP
> >>  PREEMPT_DYNAMIC Fri Aug 15 14:55:12 UTC 2025 x86_64 GNU/Linux
> > 
> > If you're using LOCALIO (client on server) that'd explain your not
> > seeing any READs coming over the wire to NFSD.
> > 
> > I've made sure to disable LOCALIO on my client, with:
> > echo N > /sys/module/nfs/parameters/localio_enabled
> 
> I am testing with a physically separate client and server, so I believe
> that LOCALIO is not in play. I do see WRITEs. And other workloads (in
> particular "fsx -Z <fname>") show READ traffic and I'm getting the
> new trace point to fire quite a bit, and it is showing misaligned
> READ requests. So it has something to do with dt.

OK, yeah I figured you weren't doing loopback mount, only thing that
came to mind for you not seeing READ like expected.  I haven't had any
problems with dt not driving READs to NFSD...

You'll certainly need to see READs in order for NFSD's new misaligned
DIO READ handling to get tested.

> If I understand your two patches correctly, they are still pulling a
> page from the end of rq_pages to do the initial pad page. That, I
> think, is a working implementation, not the failing one.

Patch 1 removes the use of a separate page, instead using the very
first page of rq_pages for the "start_extra" (or "front_pad) page for
the misaligned DIO READ.  And with that my dt testing fails with data
mismatch like I shared. So patch 1 is failing implementation (for me
on the "RDMA" system I'm testing on).

Patch 2 then switches to using a rq_pages page _after_ the memory that
would normally get used as the READ payload memory to service the
READ. So patch 2 is a working implementation.

> EOD -- will continue tomorrow.

Ack.

