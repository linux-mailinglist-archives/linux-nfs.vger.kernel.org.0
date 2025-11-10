Return-Path: <linux-nfs+bounces-16230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD900C47BDB
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 17:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE653BA80E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3886223D2B2;
	Mon, 10 Nov 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7HTQn97"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1391A224AE8
	for <linux-nfs@vger.kernel.org>; Mon, 10 Nov 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789432; cv=none; b=V1mUXUg25nRUeYxNiJWItItBR6wIbx2D3qdveGKBBHsaeFjxhXDAqPAAj5cx67zeaXFfbc/TIBL5i8E+E6y4f3hN27CoBNJmXM2DLIfx5VMB/er619z7jkX0b6rG/G+a9zRMvGcu6DVaPJMfJpOQgXr/vq2axvo0taj/Gw+8otE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789432; c=relaxed/simple;
	bh=7WwPg66El1ZnhtqbfrqIQQiCS44qLBQcvwa/v2PkfeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5723+IFFq6esPZ9KokZPw7ym8K/2oQIU4qPnI8tLSOx4o1nOpDIIzoxOPRcWm5ajJxYqrwOBZ5MLPBzuscWsWmKaa6SClFcUwyIqlkwgVBVhfDtxA3mSWrq0wNCt8HSmeT1epglDrdGIRm3Sjd86sDVLONoBEu14QY3A38yD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7HTQn97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849E8C113D0;
	Mon, 10 Nov 2025 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789431;
	bh=7WwPg66El1ZnhtqbfrqIQQiCS44qLBQcvwa/v2PkfeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7HTQn97sol1cB/I1rc8+pgx4jS5g1KbYCHKZNurC5o0gOXxIzAOdPLrrLBc8qyU3
	 ySbfbav3HhFUCcU+HzkGdvGjpgbjZ+piwRyh7DRn6tvLj2CUryCiER+ayXs0aHLIYa
	 OuK8BRWsWGZr2QM5qVwLjwxNSMPAAsjxlsl8N6HXNCabDDE1Ng7mVaxnKQmcuMF5o5
	 6swgZg8wsZsGEEsNyvyrrnVgygg+m/CiR7ACJjijVfgSCV9SdApMUPSnbK5cFQhfPn
	 yATEJe91RRCzc61NODKa8ON1YGV2vqticQH75PkC2BFsDz8xo7qphJneRsvhhxM+ae
	 JVgkVFv5xWXbg==
Date: Mon, 10 Nov 2025 10:43:50 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRIINpMezN9qw73w@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>
 <aRGtn90M8ktOCOnv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGtn90M8ktOCOnv@infradead.org>

On Mon, Nov 10, 2025 at 01:17:19AM -0800, Christoph Hellwig wrote:
> On Fri, Nov 07, 2025 at 03:28:06PM -0500, Chuck Lever wrote:
> > +1 for an explanatory comment, but I'm not getting what is "counter-
> > intuitive" about leaving the content of the end segments in the page
> > cache. The end segments are small and simply cannot be handled by direct
> > I/O.
> 
> The downside if of course extra page cache usage / pollution.  If these
> segments are aligned to the file system minimum I/O size, but not to
> the memory requirements there is not going to be any RMW cycle that
> leaving them in the page cache for would be useful.

Straw man: the entire IO would be issued using DONTCACHE (due to it
being "case 2"). You too keep conflating "case 1" and "case 2":
https://lore.kernel.org/linux-nfs/20251107153422.4373-1-cel@kernel.org/T/#mca19127d102dd7d24b2e44df4d9417b2cc61b340

Your broader point of "extra page cache usage / pollution".  DONTCACHE
is already using page cache, it just will hopefully drop-behind its
pages.

But for "case 1", yes if we use cached buffered IO for the subpage
ends _BUT_ the workload isn't ever going to actually need to RMW
(e.g. because it isn't part of a continuous stream of unaligned
WRITEs) then: Yes, those individual pages associated with the
unaligned ends will polute. BUT they are individual pages that MM is
quite good about handling.

> Similarly if the single segment is not aligned in the file logic space,
> chances of having another RMW come in are the same as for a large
> one with unaligned head and/or tail.

Not following you, please reword and be clearer.

