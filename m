Return-Path: <linux-nfs+bounces-21616-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJE1NSILBmqfeQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21616-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 19:49:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F43854586A
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 19:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D54463021BFE
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249C38F248;
	Thu, 14 May 2026 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5wGPCbo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211933260D;
	Thu, 14 May 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780950; cv=none; b=FoXUAnXE9TtR9KqEPeNjc8sdEv0NTUFCUCWQaAoxbM3xel3r1VwkK+X/jUNERLb5dY3RME4qOIzTQXIueDYpGjemSjN86Qa+ZZtRJoK5Uteke64vDoFphUPSjaU9suWqgnIWLyLmEJwOtrRD9/AWamov10c8zciVW0Ve/YNL+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780950; c=relaxed/simple;
	bh=8qjoOIZxqWjQ5FZW3r7k8Y/FmK6vRJrubD1Zt6AQKZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA0Pw0+LrVlgyB2AugIMk1rlwdWAS7TyfLGcDLa/Rl1dAanO+s87MjCa8fWUPRgvZjyrtleQgTrcCiZqpYaYdkzW5kv56E2EndLEy8h2B4X5vAeykfGwBP4jmTc3MQv3mY3z/SdUDRp8YMvNQn0wvGk9RcagWGCuDZeoP7op2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5wGPCbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B984C2BCB3;
	Thu, 14 May 2026 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778780950;
	bh=8qjoOIZxqWjQ5FZW3r7k8Y/FmK6vRJrubD1Zt6AQKZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5wGPCboLosLANriDiBg3EYt3+ncj5uFNoX06nfBwZxon+2dWXo5wljZLUutT7aEn
	 Fu8+oyZVxiJENmNnqsADN1smzV9jlXzJf5hDjb6U71V847gM88AztrzmNTgPi+gPRc
	 RxVmmiNolEMFeSwkOw6KQY2poOGmTLBRv/UGy++puPFkDJymCYjYuCW122w7jr5ySm
	 Qe1w+Qdmd/yRBCJfeKvLkz0J2pQwNig6Ye+e+JR4lJyBxsPpWOSSGKiCOQjvbj5g4U
	 W43viQBExSgXzKJrkUBKJn+3lkjonqJ8lD9SDyEef3lFk4DK54jHv66qGkCWodtgYG
	 A+3IQzuMUFgXw==
Date: Thu, 14 May 2026 10:49:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <20260514174909.GZ9555@frogsfrogsfrogs>
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
X-Rspamd-Queue-Id: 8F43854586A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21616-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,urldefense.com:url]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:19:14AM -0700, Dai Ngo wrote:
> 
> On 5/13/26 5:25 PM, Darrick J. Wong wrote:
> > On Wed, May 13, 2026 at 10:28:31AM -0700, Dai Ngo wrote:
> > > Hi Christoph,
> > > 
> > > On 5/13/26 8:50 AM, Dai Ngo wrote:
> > > > On 5/13/26 12:01 AM, Christoph Hellwig wrote:
> > > > > On Tue, May 12, 2026 at 10:21:53AM -0700, Dai Ngo wrote:
> > > > > > A single LAYOUTGET request from the client can cause the server to
> > > > > > issue multiple calls to xfs_fs_map_blocks() for different offsets
> > > > > > within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
> > > > > > these calls can produce overlapping mappings.
> > > > > > 
> > > > > > As a result, the LAYOUTGET reply sent to the NFS client may contain
> > > > > > overlapping extents. This creates ambiguity in extent selection for a
> > > > > > given file range, which can lead to incorrect device selection,
> > > > > > inconsistent handling of datastate, and ultimately data corruption or
> > > > > > protocol violations on the client side.
> > > > > Please also add a check to the client that catches this and doesn't
> > > > > use the layout that has extents outside the requested range. And maybe
> > > > > warn about it as well.
> > > > The returned extents cover exactly the range requested in the LAYOUTGET
> > > > op. However these extents are overlapping. For example, here is the
> > > > on-the-wire capture of the LAYOUTGET operation and reply showing the
> > > > overlapping extents:
> > > > 
> > > >      Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
> > > >          [Program Version: 4]
> > > >          [V4 Procedure: COMPOUND (1)]
> > > >          Tag: <EMPTY>
> > > >          minorversion: 2
> > > >          Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
> > > >              Opcode: SEQUENCE (53)
> > > >              Opcode: PUTFH (22)
> > > >              Opcode: LAYOUTGET (50)
> > > >                  layout available?: No
> > > >                  layout type: LAYOUT4_SCSI (5)
> > > >                  IO mode: IOMODE_RW (2)
> > > >                  offset: 122880
> > > >                  length: 65536
> > > >                  min length: 4096
> > > >                  StateID
> > > >                  maxcount: 4096
> > > >          [Main Opcode: LAYOUTGET (50)]
> > > >          Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
> > > >          [Program Version: 4]
> > > >          [V4 Procedure: COMPOUND (1)]
> > > >          Status: NFS4_OK (0)
> > > >          Tag: <EMPTY>
> > > >          Operations (count: 3)
> > > >              Opcode: SEQUENCE (53)
> > > >              Opcode: PUTFH (22)
> > > >              Opcode: LAYOUTGET (50)
> > > >                  Status: NFS4_OK (0)
> > > >                  return on close?: Yes
> > > >                  StateID
> > > >                  Layout Segment (count: 1)
> > > >                      offset: 122880
> > > >                      length: 77824
> > > >                      IO mode: IOMODE_RW (2)
> > > >                      layout type: LAYOUT4_SCSI (5)
> > > >                      SCSI Extents (count: 2)
> > > >                          extent 0
> > > >                              device ID: 01000000000000000000000000000000
> > > >                              file offset: 122880
> > > >                              length: 53248
> > > >                              volume offset: 339460096
> > > >                              extent state: INVALID_DATA (2)
> > > >                          extent 1
> > > >                              device ID: 01000000000000000000000000000000
> > > >                              file offset: 122880
> > > >                              length: 77824
> > > >                              volume offset: 339460096
> > > >                              extent state: INVALID_DATA (2)
> > > >          [Main Opcode: LAYOUTGET (50)]
> > > After reviewing ext_tree_insert(), with assist from Codex, I think this
> > > function handles overlapping extents properly. The only issue I see in
> > > ext_tree_insert() is the accuracy of the return error code, EINVAL instead
> > > of ENOMEM, when kmemdup() fails.
> > > 
> > > Since ext_tree_insert seems to handle overlapping extents fine, do you
> > > think it's worth it to fix xfs_fs_map_blocks() to avoid returning overlap
> > > extents?
> > > 
> > > IMHO, I think we still should fix xfs_fs_map_blocks() to avoid any overhead
> > > and complication in ext_tree_insert having to handle overlapping extents.
> > I don't know enough about the nfs blocklayout code to say for sure, but
> > it seems like you want to upsert the mapping returned by
> > xfs_fs_map_blocks into the "ext_tree" right?
> 
> This is currently done on the NFS client side by ext_tree_insert(). The
> question I have is should we enhance the server side by passing '0' to
> xfs_fs_map_blocks() so the client does not have to do the work of
> handling the overlap extents.

Oh, ok.

Not passing XFS_BMAPI_ENTIRE into bmapi_read sounds fine to me.

> > 
> > And by "upsert" I mean "clear out any mappings for the (offset, length)
> > range, then insert the new mapping", sort of like what the fuse iomap
> > cache does:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree/fs/fuse/fuse_iomap_cache.c?h=fuse-iomap-cache_2026-05-07*n1682__;Iw!!ACWV5N9M2RV99hQ!LP7Lgbj10myml6rtWPCyBcfoKlvvpS39fLQ4Dy8puJ9c8ZQbxV6ToyYupyVa8TrICy--mS-sUwGxrA$
> > 
> > or I guess the xfs scrub bitmap support code does when you set a range:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree/fs/xfs/scrub/bitmap.c?h=fuse-iomap-cache_2026-05-07*n395__;Iw!!ACWV5N9M2RV99hQ!LP7Lgbj10myml6rtWPCyBcfoKlvvpS39fLQ4Dy8puJ9c8ZQbxV6ToyYupyVa8TrICy--mS9n7W3nLw$
> > 
> > But as I said before, I don't know if "two mappings retrieved in rapid
> > succession that overlap" is actually an NFS error.
> 
> As far as I can tell,|nfsd4_block_proc_layoutget()| correctly advances the
> offset and decrements the length after each call to|nfsd4_block_map_extent()|,
> which passes the arguments through verbatim to|xfs_fs_map_blocks()|.

<nod>

--D

> -Dai
> 
> > 
> > --D
> > 
> > > -Dai
> > > 
> > > > -Dai
> > > > 
> > > > > > Also drop the check for (!error) since it was checked after call to
> > > > > > xfs_bmapi_read().
> > > > > > 
> > > > > > Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple
> > > > > > extents per LAYOUTGET").
> > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > ---
> > > > > >    fs/xfs/xfs_pnfs.c | 6 +++---
> > > > > >    1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > - This patch is based on top of the patch:
> > > > > >     xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
> > > > > The error changes should go into that patch, so please resend it with
> > > > > that fixes.  Maybe as a series together with this patch to keep them
> > > > > together.
> > > > > 
> > > > > > @@ -172,6 +172,7 @@ xfs_fs_map_blocks(
> > > > > >        offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > > > > >          lock_flags = xfs_ilock_data_map_shared(ip);
> > > > > > +    bmapi_flags = 0;    /* return map for requested range only */
> > > > > Just remove the variable and hard code the 0 in the xfs_bmapi_read call.
> > > > > 
> 

