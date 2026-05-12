Return-Path: <linux-nfs+bounces-21539-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEmKNJNkA2oq5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21539-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:34:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D27F525E0F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9173E3061DC7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81D3DC842;
	Tue, 12 May 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW0wx3cC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B13DB981;
	Tue, 12 May 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607243; cv=none; b=AU+l+KVkvfdwpumGL6KitNSzhTWNmstOkBIFciMF2eSC63+iKeIPy2hrT5uciFFK1mow/72tEFC/O1kltO8th4HrKvJ45MVJb1DxNm4ZZBtBH0OQpXRSeH828RZwCgoEo1Ap3bmw5mHiyvGPGfb8+M98vwr5w9tsCevjMwUNKO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607243; c=relaxed/simple;
	bh=HnTuowV/zAfKrL882doM8WrRpjMTPGixHMDj03Q6Fuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv9sSz05WFsSgpz8YC/1xBs714vvhfZgKQgshmCqFmGcY/1w18NqL5Bz7abMh9S+2VP0SIAkrT6QZcsGvcLaHIRdV9FgXfP+8O2FGomRdrBJRMQjDKM9+izvdQWVGA7QIkKhP8X2THeisA6bOd97XUSz8vZ+UCABPawPhv0Pm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sW0wx3cC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420DEC2BCB0;
	Tue, 12 May 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778607243;
	bh=HnTuowV/zAfKrL882doM8WrRpjMTPGixHMDj03Q6Fuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sW0wx3cCH98l+L/p3TWCR2eU4OcLwONpG0OR5Nkl/U57p8j8jJl2jUZ0bu+7Kaech
	 1n5IB0Jg6msWSty5v0YaqyBDV2+SqoJ5b7l95JNkJypygoDkM1pY4O7Th+Qn0bJJuq
	 OzWoNWz6NX37Z9/SmcixgRLFuu88CGTCpFGpWzhDe/PEcG33zhxjNWv0Wh4DRMGZMC
	 ZLs6bm2Oedqbeoawy8748AxxY93JNi4EwbR34hEQPfQTGDSLBn3esj9MPmQqYifamR
	 gTWGrwZx1mlXjWSnhOg/28pK7meBwgVtFQAlP1YQ/CRlWnTLta6nvc/0cJ/M1Fq+OJ
	 Cjd2xp3axcyTA==
Date: Tue, 12 May 2026 10:34:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <20260512173402.GO9555@frogsfrogsfrogs>
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512172238.2495085-1-dai.ngo@oracle.com>
X-Rspamd-Queue-Id: 4D27F525E0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21539-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:21:53AM -0700, Dai Ngo wrote:
> xfs_fs_map_blocks() currently passes XFS_BMAPI_ENTIRE to xfs_bmapi_read(),
> which causes the bmap code to expand the mapping to cover the entire
> extent rather than the requested range.

Nitpicking: _ENTIRE causes bmapi_read to return the whole extent instead
of trimming it down to the requested range.

> A single LAYOUTGET request from the client can cause the server to
> issue multiple calls to xfs_fs_map_blocks() for different offsets
> within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
> these calls can produce overlapping mappings.
> 
> As a result, the LAYOUTGET reply sent to the NFS client may contain
> overlapping extents. This creates ambiguity in extent selection for a
> given file range, which can lead to incorrect device selection,
> inconsistent handling of datastate, and ultimately data corruption or
> protocol violations on the client side.
> 
> Problem discovered with xfstest generic/075 test using NFSv4.2 mount
> with SCSI layout.

Might be helpful to provide an example of the request vs. the
overlapping layouts.  IIRC the client asks for a layout for the first
32 fsblocks of the file.  On the first call to xfs_fs_map_blocks, block
0 is a single unwritten mapping, so that gets returned.

Meanwhile, another thread fallocates block 2 and gets lucky in that an
adjacent block is free, so the first mapping in the file is now 2
unwritten fsblocks starting at 0.  This can happen because we don't hold
i_rwsem (or the ILOCK) between calls to ->map_blocks.

Returning to the first thread, it calls xfs_fs_map_blocks again to map
block 1.  However, the mapping's been changed, so we now return the
entire 2-fsblock  mapping.  What gets sent to the client is

{.offset = 0, .length = 4096, .addr = X, .dev = Y},
{.offset = 0, .length = 8192, .addr = X, .dev = Y},

and the client rejects that as overlapping.  Right?

> Fix this by replacing the XFS_BMAPI_ENTIRE flag with '0' so that
> xfs_bmapi_read() returns only the mapping for the requested range.
> 
> Also drop the check for (!error) since it was checked after call to
> xfs_bmapi_read().

Cc: <stable@vger.kernel.org> # v6.19

> Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple extents per LAYOUTGET").
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/xfs/xfs_pnfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> - This patch is based on top of the patch:
>   xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
> 
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index f7c6dba3d21e..697bf3e4ad7e 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -118,7 +118,7 @@ xfs_fs_map_blocks(
>  	struct xfs_bmbt_irec	imap;
>  	xfs_fileoff_t		offset_fsb, end_fsb;
>  	loff_t			limit;
> -	int			bmapi_flags = XFS_BMAPI_ENTIRE;
> +	int			bmapi_flags;

Why not just replace the argument to xfs_bmapi_read with a constant
zero?

--D

>  	int			nimaps = 1;
>  	uint			lock_flags;
>  	int			error = 0;
> @@ -172,6 +172,7 @@ xfs_fs_map_blocks(
>  	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  
>  	lock_flags = xfs_ilock_data_map_shared(ip);
> +	bmapi_flags = 0;	/* return map for requested range only */
>  	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
>  				&imap, &nimaps, bmapi_flags);
>  	if (error) {
> @@ -182,8 +183,7 @@ xfs_fs_map_blocks(
>  
>  	ASSERT(!nimaps || imap.br_startblock != DELAYSTARTBLOCK);
>  
> -	if (!error && write &&
> -	    (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
> +	if (write && (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
>  		if (offset + length > XFS_ISIZE(ip))
>  			end_fsb = xfs_iomap_eof_align_last_fsb(ip, end_fsb);
>  		else if (nimaps && imap.br_startblock == HOLESTARTBLOCK)
> -- 
> 2.47.3
> 
> 

