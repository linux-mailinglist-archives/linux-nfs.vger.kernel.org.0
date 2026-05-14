Return-Path: <linux-nfs+bounces-21610-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOzhMooWBWoUSQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21610-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 02:25:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2EC53C557
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 02:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439203017039
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 00:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7527B34E;
	Thu, 14 May 2026 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j76Nykre"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA7274FD1;
	Thu, 14 May 2026 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718315; cv=none; b=pdOm3mMFYShP6VtmfOhIqMY2YUYh+Mfbr6QjRnQXjGs8B0gudXoFTGi3efpvgpGfw9hsQLxo3s4CkXY1qQ3xzuDvyPocqHj89Q/sXjWuoLiPOrcdgmbp3atNP9u/G/aRtQRXf+0EdztAD7EkDxxbY9hlxrtxZp+7mpjVURPONVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718315; c=relaxed/simple;
	bh=FbMTjnorNQFOtNMPI75AZb8bZeDg7/Ourokg1M5OV28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+BFL1btnuGzim1cRO78MZX9DNLA3eVR0L45gkOSmCl5DYVSM2KauCoEJBlLKmoihWN2w1Or57XYqupLx/uJutLh8bL9iBkcVE1ve8ASjxenBh6EupGyKmK3alFN1sFnuPKLgGkcHZgzBWf+AzDpm+9hsmMR3G3NpKw3kfvpNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j76Nykre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DDDC19425;
	Thu, 14 May 2026 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778718314;
	bh=FbMTjnorNQFOtNMPI75AZb8bZeDg7/Ourokg1M5OV28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j76NykrePn8FVHusgBIzzCIWvOkkNl7gnjaXqR9ZbH/Yi2TCS5xdkExqOINiFCS4A
	 PaGwHz9mXMHd9vRO2rBCP/RgdhpYcZUATTnue+XcOm2301P3E8cxS6fVorDeB6UpSW
	 4nb2qJ9tpOzJ3JEvTpRqZdDthBbLszXzDrR0LXGjCRvi99h4qyroDy3NhY7DuKhNvD
	 lh7FHhs4CjS22etStX/+OZ5uOlFk/s4F0sHOkYB+3hncLYnRNYpITg5vNyAvEgepnp
	 p9Gn02+7C/g2vYQjor1ZeIi2WSLMlD5JIVDpBUh7WRa+ifsC+Y8wZXEtbHvW/kmw/O
	 7DbFo6aoNjggg==
Date: Wed, 13 May 2026 17:25:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <20260514002513.GQ9555@frogsfrogsfrogs>
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
X-Rspamd-Queue-Id: 6B2EC53C557
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21610-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:28:31AM -0700, Dai Ngo wrote:
> Hi Christoph,
> 
> On 5/13/26 8:50 AM, Dai Ngo wrote:
> > 
> > On 5/13/26 12:01 AM, Christoph Hellwig wrote:
> > > On Tue, May 12, 2026 at 10:21:53AM -0700, Dai Ngo wrote:
> > > > A single LAYOUTGET request from the client can cause the server to
> > > > issue multiple calls to xfs_fs_map_blocks() for different offsets
> > > > within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
> > > > these calls can produce overlapping mappings.
> > > > 
> > > > As a result, the LAYOUTGET reply sent to the NFS client may contain
> > > > overlapping extents. This creates ambiguity in extent selection for a
> > > > given file range, which can lead to incorrect device selection,
> > > > inconsistent handling of datastate, and ultimately data corruption or
> > > > protocol violations on the client side.
> > > Please also add a check to the client that catches this and doesn't
> > > use the layout that has extents outside the requested range. And maybe
> > > warn about it as well.
> > 
> > The returned extents cover exactly the range requested in the LAYOUTGET
> > op. However these extents are overlapping. For example, here is the
> > on-the-wire capture of the LAYOUTGET operation and reply showing the
> > overlapping extents:
> > 
> >     Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
> >         [Program Version: 4]
> >         [V4 Procedure: COMPOUND (1)]
> >         Tag: <EMPTY>
> >         minorversion: 2
> >         Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
> >             Opcode: SEQUENCE (53)
> >             Opcode: PUTFH (22)
> >             Opcode: LAYOUTGET (50)
> >                 layout available?: No
> >                 layout type: LAYOUT4_SCSI (5)
> >                 IO mode: IOMODE_RW (2)
> >                 offset: 122880
> >                 length: 65536
> >                 min length: 4096
> >                 StateID
> >                 maxcount: 4096
> >         [Main Opcode: LAYOUTGET (50)]
> >         Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
> >         [Program Version: 4]
> >         [V4 Procedure: COMPOUND (1)]
> >         Status: NFS4_OK (0)
> >         Tag: <EMPTY>
> >         Operations (count: 3)
> >             Opcode: SEQUENCE (53)
> >             Opcode: PUTFH (22)
> >             Opcode: LAYOUTGET (50)
> >                 Status: NFS4_OK (0)
> >                 return on close?: Yes
> >                 StateID
> >                 Layout Segment (count: 1)
> >                     offset: 122880
> >                     length: 77824
> >                     IO mode: IOMODE_RW (2)
> >                     layout type: LAYOUT4_SCSI (5)
> >                     SCSI Extents (count: 2)
> >                         extent 0
> >                             device ID: 01000000000000000000000000000000
> >                             file offset: 122880
> >                             length: 53248
> >                             volume offset: 339460096
> >                             extent state: INVALID_DATA (2)
> >                         extent 1
> >                             device ID: 01000000000000000000000000000000
> >                             file offset: 122880
> >                             length: 77824
> >                             volume offset: 339460096
> >                             extent state: INVALID_DATA (2)
> >         [Main Opcode: LAYOUTGET (50)]
> 
> After reviewing ext_tree_insert(), with assist from Codex, I think this
> function handles overlapping extents properly. The only issue I see in
> ext_tree_insert() is the accuracy of the return error code, EINVAL instead
> of ENOMEM, when kmemdup() fails.
> 
> Since ext_tree_insert seems to handle overlapping extents fine, do you
> think it's worth it to fix xfs_fs_map_blocks() to avoid returning overlap
> extents?
> 
> IMHO, I think we still should fix xfs_fs_map_blocks() to avoid any overhead
> and complication in ext_tree_insert having to handle overlapping extents.

I don't know enough about the nfs blocklayout code to say for sure, but
it seems like you want to upsert the mapping returned by
xfs_fs_map_blocks into the "ext_tree" right?

And by "upsert" I mean "clear out any mappings for the (offset, length)
range, then insert the new mapping", sort of like what the fuse iomap
cache does:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree/fs/fuse/fuse_iomap_cache.c?h=fuse-iomap-cache_2026-05-07#n1682

or I guess the xfs scrub bitmap support code does when you set a range:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree/fs/xfs/scrub/bitmap.c?h=fuse-iomap-cache_2026-05-07#n395

But as I said before, I don't know if "two mappings retrieved in rapid
succession that overlap" is actually an NFS error.

--D

> -Dai
> 
> > 
> > -Dai
> > 
> > > 
> > > > Also drop the check for (!error) since it was checked after call to
> > > > xfs_bmapi_read().
> > > > 
> > > > Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple
> > > > extents per LAYOUTGET").
> > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > ---
> > > >   fs/xfs/xfs_pnfs.c | 6 +++---
> > > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > - This patch is based on top of the patch:
> > > >    xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
> > > The error changes should go into that patch, so please resend it with
> > > that fixes.  Maybe as a series together with this patch to keep them
> > > together.
> > > 
> > > > @@ -172,6 +172,7 @@ xfs_fs_map_blocks(
> > > >       offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > > >         lock_flags = xfs_ilock_data_map_shared(ip);
> > > > +    bmapi_flags = 0;    /* return map for requested range only */
> > > Just remove the variable and hard code the 0 in the xfs_bmapi_read call.
> > > 
> > 
> 

