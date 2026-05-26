Return-Path: <linux-nfs+bounces-21945-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJHCFtVxFWpbVAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21945-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 12:11:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E55D3F8C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 12:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92C423044DE0
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6B33D3332;
	Tue, 26 May 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYDZ9C7f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED833DA5CA;
	Tue, 26 May 2026 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789923; cv=none; b=c7ZpRErc1gn8M0tcTCr4E2/CbJaZHLJ1aMHcYvH8Ocs9uV6zoTWxnLG2TuIol+MrXM9uampIWo2qXf46dbDkT7lRTZjK/yDpWmrsJlMVoO2Jss7fZxhOGXljqzTnAksO9YxKNHioB+c1Fm2Hl5muwaeZwSC2RWZaeDJ0dbepUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789923; c=relaxed/simple;
	bh=R5Yd74jFNa3X4f9RfFtRYOMKlD2/iXQeY6MF+/Tl4Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOyk/geZ/cvBM3S9Ia3liCrg7tyXGYkH6k0AGIgeVisWQnKpocg4yxBH9an0XqKdiA1SggMciOYAGLbAu82bjLangxjoc2CWYbj+AYSju2miUUtQ49FwXQZ8g716L6Y+bGM7BsAtdbm4uwjo3W9qksuC4sqjEunVitePGHp2wSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYDZ9C7f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3BD1F000E9;
	Tue, 26 May 2026 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789922;
	bh=BdoyciPB6L3EAsK4xSK1fSXo9WAY77k2yc8aUP9RDAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OYDZ9C7foebqb9YBoWDbW0zPE0qJJ5vCMgJt0nUeOzs/KQrVBe856OjKKnvjZwckP
	 Hke7NItSdUxevS/rWcr8cei0xjshSS2X+FQUL+OpRBUYzMfYQxVNAo2KgdqPK5iPxE
	 /G8IAxghd09OFnk9RvWZMvzHDd0pZO6GuCXjqDaqj9t/H52Ie2My9Z3K00TKNBLVsi
	 gosb1jT0LQrTvGBKotQwBAZvusZ9DNK92oLIHORb6wj7tVNoW+Z+VsQaosx+N3I8do
	 0zljgTXJwGo06x2zowWmTaRSqp41o8im5+zao9fvCcQPxN0EEgJUbV5RTFxHAMkyyN
	 leS3Nu5SaFjfw==
Date: Tue, 26 May 2026 12:05:18 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <ahVwM9kpBscMOfRw@nidhogg.toxiclabs.cc>
References: <20260520003503.2399326-1-dai.ngo@oracle.com>
 <20260520003503.2399326-3-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520003503.2399326-3-dai.ngo@oracle.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21945-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email,nidhogg.toxiclabs.cc:mid]
X-Rspamd-Queue-Id: 681E55D3F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 05:32:59PM -0700, Dai Ngo wrote:
> xfs_fs_map_blocks() currently passes XFS_BMAPI_ENTIRE to xfs_bmapi_read(),
> which causes the bmap code to expand the mapping to cover the entire
> extent rather than the requested range.
> 
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
> 
> Fix this by replacing the XFS_BMAPI_ENTIRE flag with '0' so that
> xfs_bmapi_read() returns only the mapping for the requested range.
> 
> Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple extents per LAYOUTGET").
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

I'm not an expert on NFS, but the explanation and the patch looks good
and make sense, so:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> ---
>  fs/xfs/xfs_pnfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index b792e066b403..d92993367ab6 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -118,7 +118,6 @@ xfs_fs_map_blocks(
>  	struct xfs_bmbt_irec	imap;
>  	xfs_fileoff_t		offset_fsb, end_fsb;
>  	loff_t			limit;
> -	int			bmapi_flags = XFS_BMAPI_ENTIRE;
>  	int			nimaps = 1;
>  	uint			lock_flags;
>  	int			error = 0;
> @@ -172,8 +171,9 @@ xfs_fs_map_blocks(
>  	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  
>  	lock_flags = xfs_ilock_data_map_shared(ip);
> +	/* request mappings for the specified range only */
>  	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
> -				&imap, &nimaps, bmapi_flags);
> +				&imap, &nimaps, 0);
>  	if (error) {
>  		xfs_iunlock(ip, lock_flags);
>  		goto out_unlock;
> -- 
> 2.47.3
> 

