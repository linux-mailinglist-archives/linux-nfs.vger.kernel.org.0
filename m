Return-Path: <linux-nfs+bounces-13941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA97B3A69A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 18:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26E21884474
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5FF322DC9;
	Thu, 28 Aug 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEg60fZ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD5221FBB
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398983; cv=none; b=hr6Di91Wj8P1dsEchu237J3RAnSgjrac5Jd8wlEGR/XxGT6Wsdzc4w/18poMOyyJKs8fJrumZpH8JqmAL2n0aC91G1jibJ06+XMDDg4/bEwJqzmZacJjawPgpyNHOXSKbrerYdbSW3S6Gj37SjcmN5dipCrkh9kAwsKeR+7xJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398983; c=relaxed/simple;
	bh=hQEp3NTqU4Sr6sX/JJj6YtJSXoTYyv01gQV8HMrpD48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PD22ezUqWODRS7MF3HkqrY2l8+Cwqe0MD8wbcEUfK0oRazSn+LOvIraz/Ez/iis+86aLcJG144LXdNluDCeAPHG6SxbdDHu8FyDw+5L4y2ilRAVSkwYVwTj0DgzQeLRT3+X/oXK4eG5YUyRXxww2lOrdT3ypNbZlW0qT0qDQa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEg60fZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDED4C4CEEB;
	Thu, 28 Aug 2025 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756398982;
	bh=hQEp3NTqU4Sr6sX/JJj6YtJSXoTYyv01gQV8HMrpD48=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CEg60fZ2YOErIuQkuSPaqldT+uBGK2opDkZMgXkp8Tw+8a4VrSaRzWw8sY/QjsWrI
	 eOmiuFirjbl9ajhkdehNJIdxDU9yb9QvxFAWlL5aaWJ9o+rLVj+0cGV7LeRKnplk4K
	 FMwPG76wrbq3L1//OCJIcr+uy+Bx/Tx/TyVs5Wu3efspkASlhN+13204bdvWH6UZky
	 lfXV3RAqFpkGFoXH24mek6vEHBxJi9oUXWbwqFQ3lQyeuv/uR7wfoAJ1uFUfByBNlK
	 pT5IAIFiXLXyHBEIVlwoN/wa0HmjDPCKNT8kUmd81GgQ9S0RlqT/TsmslIqhk5TB2C
	 aZYedK7ISjjJA==
Message-ID: <09fa0bb261508aa9da87d2e664bae064f2232eaf.camel@kernel.org>
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 28 Aug 2025 12:36:20 -0400
In-Reply-To: <aLAOsGUIvONZvfX7@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
	 <20250826185718.5593-6-snitzer@kernel.org>
	 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
	 <aK9fZR7pQxrosEfW@kernel.org>
	 <6f5516a5-1954-4f77-8a07-dacba1fb570c@oracle.com>
	 <aK-Reg6g8ccscwMu@kernel.org>
	 <09eca412-b6e3-4011-b7dd-3a452eae6489@oracle.com>
	 <aLAOsGUIvONZvfX7@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 04:09 -0400, Mike Snitzer wrote:
> On Wed, Aug 27, 2025 at 09:57:39PM -0400, Chuck Lever wrote:
> > On 8/27/25 7:15 PM, Mike Snitzer wrote:
> > > On Wed, Aug 27, 2025 at 04:56:08PM -0400, Chuck Lever wrote:
> > > > On 8/27/25 3:41 PM, Mike Snitzer wrote:
> > > > > Is your suggestion to, rather than allocate a disjoint single pag=
e,
> > > > > borrow the extra page from the end of rq_pages? Just map it into =
the
> > > > > bvec instead of my extra page?
> > > >=20
> > > > Yes, the extra page needs to come from rq_pages. But I don't see wh=
y it
> > > > should come from the /end/ of rq_pages.
> > > >=20
> > > > - Extend the start of the byte range back to make it align with the
> > > >   file's DIO alignment constraint
> > > >=20
> > > > - Extend the end of the byte range forward to make it align with th=
e
> > > >   file's DIO alignment constraint
> > >=20
> > > nfsd_analyze_read_dio() does that (start_extra and end_extra).
> > >=20
> > > > - Fill in the sink buffer's bvec using pages from rq_pages, as usua=
l
> > > >=20
> > > > - When the I/O is complete, adjust the offset in the first bvec ent=
ry
> > > >   forward by setting a non-zero page offset, and adjust the returne=
d
> > > >   count downward to match the requested byte count from the client
> > >=20
> > > Tried it long ago, such bvec manipulation only works when not using
> > > RDMA.  When the memory is remote, twiddling a local bvec isn't going
> > > to ensure the correct pages have the correct data upon return to the
> > > client.
> > >=20
> > > RDMA is why the pages must be used in-place, and RDMA is also why
> > > the extra page needed by this patch (for use as throwaway front-pad
> > > for expanded misaligned DIO READ) must either be allocated _or_
> > > hopefully it can be from rq_pages (after the end of the client
> > > requested READ payload).
> > >=20
> > > Or am I wrong and simply need to keep learning about NFSD's IO path?
> >=20
> > You're wrong, not to put a fine point on it.
>=20
> You didn't even understand me.. but firmly believe I'm wrong?
>=20
> > There's nothing I can think of in the RDMA or RPC/RDMA protocols that
> > mandates that the first page offset must always be zero. Moving data
> > at one address on the server to an entirely different address and
> > alignment on the client is exactly what RDMA is supposed to do.
> >=20
> > It sounds like an implementation omission because the server's upper
> > layers have never needed it before now. If TCP already handles it, I'm
> > guessing it's going to be straightforward to fix.
>=20
> I never said that first page offset must be zero.  I said that I
> already did what you suggested and it didn't work with RDMA.  This is
> recall of too many months ago now, but: the client will see the
> correct READ payload _except_ IIRC it is offset by whatever front-pad
> was added to expand the misaligned DIO; no matter whether
> rqstp->rq_bvec updated when IO completes.
>=20
> But I'll revisit it again.
>=20
> > > > > NFSD using DIO is optional. I thought the point was to get it as =
an
> > > > > available option so that _others_ could experiment and help categ=
orize
> > > > > the benefits/pitfalls further?
> > > >=20
> > > > Yes, that is the point. But such experiments lose value if there is=
 no
> > > > data collection plan to go with them.
> > >=20
> > > Each user runs something they care about performing well and they
> > > measure the result.
> >=20
> > That assumes the user will continue to use the debug interfaces, and
> > the particular implementation you've proposed, for the rest of time.
> > And that's not my plan at all.
> >=20
> > If we, in the community, cannot reproduce that result, or cannot
> > understand what has been measured, or the measurement misses part or
> > most of the picture, of what value is that for us to decide whether and
> > how to proceed with promoting the mechanism from debug feature to
> > something with a long-term support lifetime and a documented ABI-stable
> > user interface?
>=20
> I'll work to put a finer point on how to reproduce and enumerate the
> things to look for (representative flamegraphs showing the issue,
> which I already did at last Bakeathon).
>=20
> But I have repeatedly offered that the pathological worst case is
> client doing sequential write IO of a file that is 3-4x larger than
> the NFS server's system memory.
>=20
> Large memory systems with 8 or more NVMe devices, fast networks that
> allow for huge data ingest capabilities.  These are the platforms that
> showcase MM's dirty writeback limitions when large sequential IO is
> initiated from the NFS client and its able to overrun the NFS server.
>=20
> In addition, in general DIO requires significantly less memory and
> CPU; so platforms that have more limited resources (and may have
> historically struggled) could have a new lease on life if they switch
> NFSD from buffered to DIO mode.
>=20
> > > Literally the same thing as has been done for anything in Linux since
> > > it all started.  Nothing unicorn or bespoke here.
> >=20
> > So let me ask this another way: What do we need users to measure to giv=
e
> > us good quality information about the page cache behavior and system
> > thrashing behavior you reported?
>=20
> IO throughput, CPU and memory usage should be monitored over time.
>=20
> > For example: I can enable direct I/O on NFSD, but my workload is mostly
> > one or two clients doing kernel builds. The latency of NFS READs goes
> > up, but since a kernel build is not I/O bound and the client page cache=
s
> > hide most of the increase, there is very little to show a measured
> > change.
> >=20
> > So how should I assess and report the impact of NFSD doing direct I/O?
>=20
> Your underwhelming usage isn't what this patchset is meant to help.
>=20
> > See -- users are not the only ones who are involved in this experiment;
> > and they will need guidance because we're not providing any
> > documentation for this feature.
>=20
> Users are not created equal.  Major companies like Oracle and Meta
> _should_ be aware of NFSD's problems with buffered IO.  They have
> internal and external stakeholders that are power users.
>=20
> Jeff, does Meta ever see NFSD struggle to consistently use NVMe
> devices?  Lumpy performance?  Full-blown IO stalls?  Lots of NFSD
> threads hung in D state?
>=20

Yes. We're particularly interested in this work for that reason. A lot
of the workload is large, streaming writes at the application layer
that are only rarely ever read, and quite a bit later when it does
happen.

This means that the pagecache is pretty useless. My _guess_ is that DIO
will help that significantly, though I do still have some concerns
about using buffered I/O for the edges of unaligned WRITEs.

> > > > If you would rather make this drive-by, then you'll have to realize
> > > > that you are requesting more than simple review from us. You'll hav=
e
> > > > to be content with the pace at which us overloaded maintainers can =
get
> > > > to the work.
> > >=20
> > > I think I just experienced the mailing-list equivalent of the Detroit
> > > definition of "drive-by".  Good/bad news: you're a terrible shot.
> >=20
> > The term "drive-by contribution" has a well-understood meaning in the
> > kernel community. If you are unfamiliar with it, I invite you to review
> > the mailing list archives. As always, no-one is shooting at you. If
> > anything, the drive-by contribution is aimed at me.
>=20
> It is a blatant miscategorization here. That you just doubled down
> on it having relevance in this instance is flagrantly wrong.
>=20
> Whatever compells you to belittle me and my contributions, just know
> it is extremely hard to take. Highly unproductive and unprofessional.
>=20
> Boom, done.

--=20
Jeff Layton <jlayton@kernel.org>

