Return-Path: <linux-nfs+bounces-14050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A7B447EA
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 23:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED3A3AED59
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD8B28BABA;
	Thu,  4 Sep 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1k3eOd1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC52727F2
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019618; cv=none; b=e6IEYUyemx1JZIk6gcs76NhXutCMqj6+SeUopsQngLOnxKecawnijeQPwpL2k/echnrLIg3dysHK50OXCj10yChpTGGespdk8PDhhQUIS7sujgZ5pByAa0o7f2nrq8pk0aroX08P5nnkq6peu/1OLVqpt/dfKEvEpxR67EYBdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019618; c=relaxed/simple;
	bh=VJZ1gc61uUFFcwL8vXao9gtEcC6hKd7qvpcTsIfQ7iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY/p5i5XGvxwkkOj1P1Gqzq2a7Kyi54BoMklCFsGHc3BG/9S1nWKHjIbq1EuW3YwRiHW9Fc2xPPMPKVR6PdJAXqLldJXV/M5GSpOnQhhXXXkyjaxS3hxgXa8XH6ijMHaJRooDD5wi/rCOm+aeNiwB9R3igvuFqp9v64TcF6Mnfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1k3eOd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5598DC4CEF4;
	Thu,  4 Sep 2025 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757019616;
	bh=VJZ1gc61uUFFcwL8vXao9gtEcC6hKd7qvpcTsIfQ7iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1k3eOd1Q7spmIbxH+x84gB2GdOcUTB51M1Slf/vCHywPyGoj/UpJXB3w8zRrdT8y
	 02DUDYQCpZx44J3ATc5JiEXD2EI8Y6nNM7NZu+31zsdVys2VyJUX6YhPx5+RDQjsJ3
	 eSKqSNSCuDWq2BWyQKeKVZ1T/tIA9356J3+ZbNKb77AmfigM8K+3YsmgV+9HhlpA9M
	 XiEWfcFkVGBNIeWGqA2W5OEVYHzwz6NzaHgPqb+BTltY0Kw5pypShWx0l+IzLkRsIk
	 HqBRCEW73TJqAyQ0WW1pkWULuwSzyHZMQtb9/PjyQAhlI1Jlrx5roqtsOGOf2G33L1
	 2+T5nWmGcFGbA==
Date: Thu, 4 Sep 2025 17:00:15 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
Message-ID: <aLn93-BKnlIgADXq@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
 <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
 <aLdhL7xFxR-r7H_m@kernel.org>
 <aLdtHaqIw9jaaVM2@kernel.org>
 <12b7f4cf-5781-4c98-92d0-3fdd03df39da@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b7f4cf-5781-4c98-92d0-3fdd03df39da@oracle.com>

On Thu, Sep 04, 2025 at 03:07:30PM -0400, Chuck Lever wrote:
> On 9/2/25 6:18 PM, Mike Snitzer wrote:
> > On Tue, Sep 02, 2025 at 05:27:11PM -0400, Mike Snitzer wrote:
> >> On Tue, Sep 02, 2025 at 05:16:10PM -0400, Chuck Lever wrote:
> >>> On 9/2/25 5:06 PM, Mike Snitzer wrote:
> >>>> On Tue, Sep 02, 2025 at 01:59:12PM -0400, Chuck Lever wrote:
> >>>>> On 9/2/25 11:56 AM, Chuck Lever wrote:
> >>>>>> On 8/30/25 1:38 PM, Mike Snitzer wrote:
> >>>>>
> >>>>>>> dt (j:1 t:1): File System Information:
> >>>>>>> dt (j:1 t:1):            Mounted from device: 192.168.0.105:/hs_test
> >>>>>>> dt (j:1 t:1):           Mounted on directory: /mnt/hs_test
> >>>>>>> dt (j:1 t:1):                Filesystem type: nfs4
> >>>>>>> dt (j:1 t:1):             Filesystem options: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,nconnect=16,port=20491,timeo=600,retrans=2,sec=sys,clientaddr=192.168.0.106,local_lock=none,addr=192.168.0.105
> >>>>>>
> >>>>>> I haven't been able to reproduce a similar failure in my lab with
> >>>>>> NFSv4.2 over RDMA with FDR InfiniBand. I've run dt 6-7 times, all
> >>>>>> successful. Also, for shit giggles, I tried the fsx-based subtests in
> >>>>>> fstests, no new failures there either. The export is xfs on an NVMe
> >>>>>> add-on card; server uses direct I/O for READ and page cache for WRITE.
> >>>>>>
> >>>>>> Notice the mount options for your test run: "proto=tcp" and
> >>>>>> "nconnect=16". Even if your network fabric is RoCE, "proto=tcp" will
> >>>>>> not use RDMA at all; it will use bog standard TCP/IP on your ultra
> >>>>>> fast Ethernet network.
> >>>>>>
> >>>>>> What should I try next? I can apply 2/2 or add "nconnect" or move the
> >>>>>> testing to my RoCE fabric after lunch and keep poking at it.
> >>>>
> >>>> Hmm, I'll have to check with the Hammerspace performance team to
> >>>> understand how RDMA used if the client mount has proto=tcp.
> >>>>
> >>>> Certainly surprising, thanks for noticing/reporting this aspect.
> >>>>
> >>>> I also cannot reproduce on a normal tcp mount and testbed.  This
> >>>> frankenbeast of a fast "RDMA" network that is misconfigured to use
> >>>> proto=tcp is the only testbed where I've seen this dt data mismatch.
> >>>>
> >>>>>> Or, I could switch to TCP. Suggestions welcome.
> >>>>>
> >>>>> The client is not sending any READ procedures/operations to the server.
> >>>>> The following is NFSv3 for clarity, but NFSv4.x results are similar:
> >>>>>
> >>>>>             nfsd-1669  [003]  1466.634816: svc_process:
> >>>>> addr=192.168.2.67 xid=0x7b2a6274 service=nfsd vers=3 proc=NULL
> >>>>>             nfsd-1669  [003]  1466.635389: svc_process:
> >>>>> addr=192.168.2.67 xid=0x7d2a6274 service=nfsd vers=3 proc=FSINFO
> >>>>>             nfsd-1669  [003]  1466.635420: svc_process:
> >>>>> addr=192.168.2.67 xid=0x7e2a6274 service=nfsd vers=3 proc=PATHCONF
> >>>>>             nfsd-1669  [003]  1466.635451: svc_process:
> >>>>> addr=192.168.2.67 xid=0x7f2a6274 service=nfsd vers=3 proc=GETATTR
> >>>>>             nfsd-1669  [003]  1466.635486: svc_process:
> >>>>> addr=192.168.2.67 xid=0x802a6274 service=nfsacl vers=3 proc=NULL
> >>>>>             nfsd-1669  [003]  1466.635558: svc_process:
> >>>>> addr=192.168.2.67 xid=0x812a6274 service=nfsd vers=3 proc=FSINFO
> >>>>>             nfsd-1669  [003]  1466.635585: svc_process:
> >>>>> addr=192.168.2.67 xid=0x822a6274 service=nfsd vers=3 proc=GETATTR
> >>>>>             nfsd-1669  [003]  1470.029208: svc_process:
> >>>>> addr=192.168.2.67 xid=0x832a6274 service=nfsd vers=3 proc=ACCESS
> >>>>>             nfsd-1669  [003]  1470.029255: svc_process:
> >>>>> addr=192.168.2.67 xid=0x842a6274 service=nfsd vers=3 proc=LOOKUP
> >>>>>             nfsd-1669  [003]  1470.029296: svc_process:
> >>>>> addr=192.168.2.67 xid=0x852a6274 service=nfsd vers=3 proc=FSSTAT
> >>>>>             nfsd-1669  [003]  1470.039715: svc_process:
> >>>>> addr=192.168.2.67 xid=0x862a6274 service=nfsacl vers=3 proc=GETACL
> >>>>>             nfsd-1669  [003]  1470.039758: svc_process:
> >>>>> addr=192.168.2.67 xid=0x872a6274 service=nfsd vers=3 proc=CREATE
> >>>>>             nfsd-1669  [003]  1470.040091: svc_process:
> >>>>> addr=192.168.2.67 xid=0x882a6274 service=nfsd vers=3 proc=WRITE
> >>>>>             nfsd-1669  [003]  1470.040469: svc_process:
> >>>>> addr=192.168.2.67 xid=0x892a6274 service=nfsd vers=3 proc=GETATTR
> >>>>>             nfsd-1669  [003]  1470.040503: svc_process:
> >>>>> addr=192.168.2.67 xid=0x8a2a6274 service=nfsd vers=3 proc=ACCESS
> >>>>>             nfsd-1669  [003]  1470.041867: svc_process:
> >>>>> addr=192.168.2.67 xid=0x8b2a6274 service=nfsd vers=3 proc=FSSTAT
> >>>>>             nfsd-1669  [003]  1470.042109: svc_process:
> >>>>> addr=192.168.2.67 xid=0x8c2a6274 service=nfsd vers=3 proc=REMOVE
> >>>>>
> >>>>> So I'm probably missing some setting on the reproducer/client.
> >>>>>
> >>>>> /mnt from klimt.ib.1015granger.net:/export/fast
> >>>>>  Flags:	rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
> >>>>>   fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
> >>>>>   sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
> >>>>>   local_lock=none,addr=192.168.2.55
> >>>>>
> >>>>> Linux morisot.1015granger.net 6.15.10-100.fc41.x86_64 #1 SMP
> >>>>>  PREEMPT_DYNAMIC Fri Aug 15 14:55:12 UTC 2025 x86_64 GNU/Linux
> >>>>
> >>>> If you're using LOCALIO (client on server) that'd explain your not
> >>>> seeing any READs coming over the wire to NFSD.
> >>>>
> >>>> I've made sure to disable LOCALIO on my client, with:
> >>>> echo N > /sys/module/nfs/parameters/localio_enabled
> >>>
> >>> I am testing with a physically separate client and server, so I believe
> >>> that LOCALIO is not in play. I do see WRITEs. And other workloads (in
> >>> particular "fsx -Z <fname>") show READ traffic and I'm getting the
> >>> new trace point to fire quite a bit, and it is showing misaligned
> >>> READ requests. So it has something to do with dt.
> >>
> >> OK, yeah I figured you weren't doing loopback mount, only thing that
> >> came to mind for you not seeing READ like expected.  I haven't had any
> >> problems with dt not driving READs to NFSD...
> >>
> >> You'll certainly need to see READs in order for NFSD's new misaligned
> >> DIO READ handling to get tested.
> >>
> >>> If I understand your two patches correctly, they are still pulling a
> >>> page from the end of rq_pages to do the initial pad page. That, I
> >>> think, is a working implementation, not the failing one.
> >>
> >> Patch 1 removes the use of a separate page, instead using the very
> >> first page of rq_pages for the "start_extra" (or "front_pad) page for
> >> the misaligned DIO READ.  And with that my dt testing fails with data
> >> mismatch like I shared. So patch 1 is failing implementation (for me
> >> on the "RDMA" system I'm testing on).
> >>
> >> Patch 2 then switches to using a rq_pages page _after_ the memory that
> >> would normally get used as the READ payload memory to service the
> >> READ. So patch 2 is a working implementation.
> >>
> >>> EOD -- will continue tomorrow.
> >>
> >> Ack.
> >>
> > 
> > The reason for proto=tcp is that I was mounting the Hammerspace
> > Anvil (metadata server) via 4.2 using tcp. And it is the layout that
> > the metadata server hands out that directs my 4.2 flexfiles client to
> > then access the DS over v3 using RDMA. My particular DS server in the
> > broader testbed has the following in /etc/nfs.conf:
> > 
> > [general]
> > 
> > [nfsrahead]
> > 
> > [exports]
> > 
> > [exportfs]
> > 
> > [gssd]
> > use-gss-proxy = 1
> > 
> > [lockd]
> > 
> > [exportd]
> > 
> > [mountd]
> > 
> > [nfsdcld]
> > 
> > [nfsdcltrack]
> > 
> > [nfsd]
> > rdma = y
> > rdma-port = 20049
> > threads = 576
> > vers4.0 = n
> > vers4.1 = n
> > 
> > [statd]
> > 
> > [sm-notify]
> > 
> > And if I instead mount with:
> > 
> >   mount -o vers=3,proto=rdma,port=20049 192.168.0.106:/mnt/hs_nvme13 /test
> > 
> > And then re-run dt, I don't see any data mismatch:
> 
> I'm beginning to suspect that NFSv3 isn't the interesting case. For
> NFSv3 READs, nfsd_iter_read() is always called with @base == 0.
> 
> NFSv4 READs, on the other hand, set @base to whatever is the current
> end of the send buffer's .pages array. The checks in
> nfsd_analyze_read_dio() might reject the use of direct I/O, or it
> might be that the code is setting up the alignment of the read buffer
> incorrectly.

That's great point.  I think it is the latter.

nfsd_analyze_read_dio() doesn't concern itself with @base.  And after
nfsd_iter_read() calls nfsd_analyze_read_dio() the 'start_extra' page
is prepared assuming its base is 0:

                        if (read_dio.start_extra) {
                                len = read_dio.start_extra;
                                bvec_set_page(&rqstp->rq_bvec[v],
                                              NULL, /* set below */
                                              len, PAGE_SIZE - len);

It is loop in nfsd_iter_read() is what is accounting for @base:

        while (total) {
                len = min_t(size_t, total, PAGE_SIZE - base);
                bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
                              len, base);
                total -= len;
                ++v;
                base = 0;
        }

Which explains why using one past the end "just works" with:

        if ((kiocb.ki_flags & IOCB_DIRECT) && read_dio.start_extra)
                rqstp->rq_bvec[0].bv_page = *(rqstp->rq_next_page++);

I purposely avoided having the start_extra page need to account for
@base because:
1) I thought it best to not have 2 places dealing with @base;
   unwittingly requiring start_extra page stand on its own.
2) otherwise it could cause start_extra's length to bleed into the
   next page... which would cascade through all pages, and complicate
   the accounting needed in nfsd_complete_misaligned_read_dio() to
   unwind having expanded the misaligned DIO READ to be DIO aligned.

This all makes sense to me now... does it for you?
(nice catch on @base being the key... was sitting there in plain sight
the whole time)

Not loving the need for multiple checks for read_dio.start_extra
nfsd_iter_read() (with both of v9's 8/9 and 9/9 applied). But it
feels better than getting more fiddly elsewhere.

So replacing v9's 9/9 by folding this incremental into 5/9 would be
preferrable for me (but I know you want to reassess/rework 5/9 anyway,
so I'll defer to you at this point? no matter what: THANKS!):

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5b3c6072b6f5c..43bbd8f3e39bd 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1263,7 +1263,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			if (read_dio.start_extra) {
 				len = read_dio.start_extra;
 				bvec_set_page(&rqstp->rq_bvec[v],
-					      *(rqstp->rq_next_page++),
+					      NULL, /* set below */
 					      len, PAGE_SIZE - len);
 				total -= len;
 				++v;
@@ -1288,6 +1288,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		base = 0;
 	}
 	WARN_ON_ONCE(v > rqstp->rq_maxpages);
+	/* The start_extra page must come from the end of rq_pages[]
+	 * so that it can stand on its own and be easily dropped
+	 * by nfsd_complete_misaligned_read_dio().
+	 */
+	if ((kiocb.ki_flags & IOCB_DIRECT) && read_dio.start_extra)
+		rqstp->rq_bvec[0].bv_page = *(rqstp->rq_next_page++);
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);

