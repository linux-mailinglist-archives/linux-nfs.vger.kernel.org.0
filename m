Return-Path: <linux-nfs+bounces-15560-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A75BFF448
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 07:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34342356CFB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 05:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B016E1F5EA;
	Thu, 23 Oct 2025 05:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4mc6TEtX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477642065
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198372; cv=none; b=PBjtDoIp+0USJ8ogq5r/syfsw9rycsmsl4gvOgSlErxfdw1oTSCMP1bGzlKL6VXbJ4HksyNPKkzMbQZvh7ktJoP7ArYKDhZEJkKTKFoE8qniW5IWYGkW768esX7Jfs3iF46iCmNuD9do6sQ1MvDkH9KCGw3FBjVFd5JYyn22g7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198372; c=relaxed/simple;
	bh=CK9zkQ7EcleWmOXT/hXf4O8UzIpUsqrLbh7kpQNGi68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA9ScNqCmOvAXvb+sTY29usOq/53qiI3drWiTsk1nVGCQpXjU4/4FWLvSR+gW+zcpkVVtIEE6enMmkaAwJ6s3nzMYvet8B7K2gTKUrah2HaYXNHEO4Mk6+36NiQRpAK3usVSOGYsfypeOqkM5qrDA2NWgREw0IVSbNXwfjmg7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4mc6TEtX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HKAbQfmOs38+Wf969dUmy+RzaAsKh8dO3iEOoUqEOwM=; b=4mc6TEtXT1vCc30B+swiPD7l/j
	qCYYdUeRrc6qY2BX51CzR+5OBki//AMGy1oJXjv3bNS1hUFZCW0led946UmCeXZ2FAOOsj4Fk0MXa
	VMxr3yyaP3/V/8CIAvMde9L3FpW8fqRd72cX8TcWlJLoucbohyWruuXMicdVst21xM+xL6ZoXbk46
	xNMqdYCXIsP2PmbVhb+/cBgV+sj9wX0LshaUKsTvK7fKultB2yNJdGUeK/guuE24Big9UWde9g5OV
	Aoy76vnpeuKGWEQujKtBNJcxF7lrzQdDPO8QaCYAAr9oNcSlQ43nBGHzoue9VDtYx+reCuZ/3Dca2
	V18bypZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBo9I-000000059nU-1RL0;
	Thu, 23 Oct 2025 05:46:08 +0000
Date: Wed, 22 Oct 2025 22:46:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPnBIGeFjrZLbxBG@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
 <aPXihwGTiA7bqTsN@infradead.org>
 <aPZi2DXtdELwjTu2@kernel.org>
 <aPhoQtHH8iscmmKJ@infradead.org>
 <ee1eba86-a5ce-4cb8-9124-78a53eae6fc8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee1eba86-a5ce-4cb8-9124-78a53eae6fc8@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 10:37:35AM -0400, Chuck Lever wrote:
> What I'm hearing is that nfsd_vfs_write() should never see -ENOTBLK, so
> this check is essentially dead code.

That's how iomap_dio_rw is designed to work.  If it ever leaks out,
that is a file system bug because no other caller of ->write_iter
handles -ENOTBLK.

> >>>> These changes served as the original starting point for the NFS
> >>>> client's misaligned O_DIRECT support that landed with
> >>>> commit c817248fc831 ("nfs/localio: add proper O_DIRECT support for
> >>>> READ and WRITE"). But NFSD's support is simpler because it currently
> >>>> doesn't use AIO completion.
> >>>
> >>> I don't understand this paragraph.  What does starting point mean
> >>> here?  How does it matter for the patch description?
> >>
> >> This patch's NFSD changes were starting point for NFS commit
> >> c817248fc831
> > 
> > But that commit is already in?  This sentence really confuses me.
> 
> I'm not convinced this paragraph in the patch description is needed.
> Can it be removed?

I guess Mike wants to say the two are based on the concept.  But given
that c817248fc831 is already in I'd expect to word it as "these changes
are similar to the direct I/O writes implemented for the NFS client
local I/O feature in commit c817248fc831 <insert subject line here>.
But I'm not really sure there is much of a point in that.

> (Perhaps to get us started, Christoph, do you know of specific code that
> shows how this code could be reorganized?)
> 

This is what I had in mind:

https://lore.kernel.org/linux-block/20251014150456.2219261-1-kbusch@meta.com/T/#m3588b5824b7fa76f001d57e54664889b73471422

It records the alignment while building (or iterating for another
reason), and then just checking a mask later.  For nfsd this would be a
bit different as you'd also record the boundaries of the aligned
segments, but the idea is the same.

> If NFSD responds with NFS_FILE_SYNC here, then timestamps need to be
> persisted as well as data. As discussed in other threads, currently
> nfsd_vfs_write() seems to miss that mark.
> 
> So either: return NFS_DATA_SYNC (which means we've persisted only the
> data) or make this path persist the timestamps too.
> 
> I haven't seen any existing code that convinces me that setting both
> IOCB_SYNC and IOCB_DSYNC is necessary.

iocb_flags is the canonical place.  IOCB_DSYNC is the main path driving
the syncing, and IOCB_SYNC drivers the additional syncing of the
timestamps.

This is all a bit odd, because Linux historically only supposed the
O_SYNC flag, but used it for O_DSYNC semantics.  When I fixed that,
I had to do a few non-standard things so that we could keep existing
binaries work as expected despite renaming the flags.  See commit
6b2f3d1f769b ("vfs: Implement proper O_SYNC semantics") for details.

