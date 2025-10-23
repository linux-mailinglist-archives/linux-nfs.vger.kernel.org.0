Return-Path: <linux-nfs+bounces-15569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E3C017AD
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 15:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D73504CFE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA3A3148C7;
	Thu, 23 Oct 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w6T2f4/7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF359311589
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226502; cv=none; b=fXZ/U7Q0N9/2vx7+op6gcT+kUVsfdmRY917YpvDATdO5zqXybjvoKiwq8QXQXnU/aep7EKdjz29UW4MM/hiyvE36UCRAaLRYDpFe+uOfynuBp5F4pW1us2aKClt+t9VxtKIvESIr2S+VPvClkIwuWEeBhQ0N8wGJ7X6S+SxhD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226502; c=relaxed/simple;
	bh=pAnueVCjiO4Y9GHU3sNdgMQ0OLDyHwdAWBH/jfVJ/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFmyNO3LdnREBlPSKWjdSCBtsl+xQYQNUc7ghtSpX0rSj8GCgB+drExi0zyXZsbne+11OzB3YgvPmdwFZr4QoJl8Hjhuo18mIU8z0ge8Bvtd0O72om2U/EghZLllzaorqoi/wvbVmsVm50prKillXi0C18/37J7l2bk7Q7+6JgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w6T2f4/7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R7IE+0m5lsc4g0/t/oRLSiOosVubqABIyFsmSsulDP8=; b=w6T2f4/7zmOwdPW4+bxMF6Os6n
	jij0LNd2+mn/6HitTtAFZyqMfsdo1Feuw+c4Nry67XeHPt28TfZNPH2ky/VGBYyC51bkOsZvkIReh
	M7TJFc/vWc9+z3/Rd80Qnv4QYP8xNvUjjTJAbC+bULfP+PjleoP4R4kA4YHkhh7S7gqBGt0PVOVdK
	82dOB2vsvfAwmsDd4NRJPIfhQooe4syRCo1wZZ7JMga2HJIWD0vL22+yQVg6vd/jRut931lz5ounG
	JnUXV/whMvF8NGEOEZJPOMWfU/89ivfdDLLxwsU/SG2F0n54pgB5EeXBeqp86LiLJJaADtCdElrmm
	pK9zmuAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBvSv-00000006Qsy-1kgH;
	Thu, 23 Oct 2025 13:34:53 +0000
Date: Thu, 23 Oct 2025 06:34:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
Message-ID: <aPou_ewrAmf4rA6O@infradead.org>
References: <20251022162237.26727-1-cel@kernel.org>
 <aPnNdLg-tSIH0r5E@infradead.org>
 <4a5f32c7-7369-414e-b93f-70804aecc157@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a5f32c7-7369-414e-b93f-70804aecc157@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 23, 2025 at 08:46:02AM -0400, Chuck Lever wrote:
> On 10/23/25 2:38 AM, Christoph Hellwig wrote:
> > On Wed, Oct 22, 2025 at 12:22:37PM -0400, Chuck Lever wrote:
> >> -		kiocb.ki_flags |= IOCB_DSYNC;
> >> +		kiocb.ki_flags |=
> >> +			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
> > 
> > IOCB_SYNC without IOCB_DSYNC is always wrong, see my reply to the
> > previous thread.
> > 
> 
> I see only one API consumer that sets both: NFS LOCALIO. There are not
> enough examples for me to draw any kind of conclusion, and I haven't
> found documentation for these flags, fwiw.

The primary way to set IOCB_DSYNC and IOCB_SYNC is iocb_flags() in
include/linux/fs.h, which sets IOCB_DSYNC for O_DSYNC, and IOCB_SYNC for
__O_SYNC.  O_SYNC is defined as O_DSYNC | __O_SYNC for the historic
reasons explained in the other thread.

The main consumer of IOCB_DSYNC and IOCB_SYNC is generic_write_sync in
include/linux/fs.h, which calls into vfs_fsync_range if IOCB_DSYNC is set
(or IS_SYNC() is true on the inode, but that's irrelevant here), and
only uses IOCB_SYNC to clear the datasync flag to vfs_fsync_range if
it is set, i.e. no syncing is done without IOCB_DSYNC.

As for other uses of these flags:

fuse_write_flags should be assigning __O_SYNC instead of O_SYNC for
clarify, but the code is not incorrect.
__iomap_dio_rw does the right thing in checking IOCB_SYNC for
controlling the REQ_FUA use.
netfs_perform_write should just be checking IOCB_DYSNC, but that whole
area looks bogus.  I'll follow up with Dave.
nfs_do_local_write does the right thing assuming nfs stable writes
want O_SYNC.
I don't understand what ovl_write_iter tries to do from just reading the
code.


