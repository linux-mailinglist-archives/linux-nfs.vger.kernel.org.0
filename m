Return-Path: <linux-nfs+bounces-21200-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOwhFoeJ72kPCgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21200-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 18:06:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F0475F8B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 18:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A95E306661E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F6345757;
	Mon, 27 Apr 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuiMFGhh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E321CC59;
	Mon, 27 Apr 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305397; cv=none; b=QNB0L4eL2xB9xYFy66yOXgQMuFQZIFC8QlVjQOMwoDnEs3I7E40KZIKsIvaylSu2Sjro7hEujLdSezpbTz9E1a+pLGI5trS5Z9xDdl1xGRW8vo5fc1d94G5Y2bUjjTuhxYn6E6T1OqGszFudNSyTfzNuO0VR4R89tG8t+2oINdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305397; c=relaxed/simple;
	bh=Zz8Qb+L+a6t6/LZ2gpOvq36I/oARw1YWvWvpPUd8Taw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOpdp36HoZdgMwlAgYgOCHxD4aTB7C+9ksTZ6mJ86TiNIPmcDpj/phOt76V2uJ07EanV5pZthIdN7lB1yKmLp7L8emLkJ3yQaUZSXB86o087ZAR3Zj73ewjt9+IC3Fok4gaPXVO0hH3/FpRBHskD08RexNDeTMcB7bgCP3S062E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuiMFGhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ADFC19425;
	Mon, 27 Apr 2026 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777305397;
	bh=Zz8Qb+L+a6t6/LZ2gpOvq36I/oARw1YWvWvpPUd8Taw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuiMFGhhZMhfF4cpbnvg34N+nWG4ckxtWlgEsSJSo8lrJn1WrrC21FCMUKvoWHc6a
	 VXNYvv+TI2vivTAogG5fVhZZm8Q6m/XaHPK2M0KNeItNGc2tDUwxnimhGxrQ55KmBk
	 QV1jyEdOnMUUXPAM3CdguB9xwM8gMnmibDlfd4POipt7r20r4s/VkjQg3sdKEqY3JB
	 iyQwLnIFPdI37sq0FnlfBjRf5o8IcNj9c1F7hl3FZJcF0uWsyGShf28J5+euuE7Ea+
	 +GQ3062oVXFnCblu3RlRACujnsY5albUCT4Pkla85PEJfP6zv/KSvZM4Ne/B6iDEpg
	 Rf9Usmw5ML5vw==
Date: Mon, 27 Apr 2026 08:56:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: Re: [PATCH v11 08/15] xfs: Report case sensitivity in fileattr_get
Message-ID: <20260427155636.GC7751@frogsfrogsfrogs>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <20260424-case-sensitivity-v11-8-de5619beddaf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424-case-sensitivity-v11-8-de5619beddaf@oracle.com>
X-Rspamd-Queue-Id: 074F0475F8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21200-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,nrubsig.org:email]

On Fri, Apr 24, 2026 at 09:53:10PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Upper layers such as NFSD need to query whether a filesystem
> is case-sensitive. Add FS_XFLAG_CASEFOLD to xfs_ip2xflags()
> when the filesystem is formatted with the ASCIICI feature
> flag. This serves both FS_IOC_FSGETXATTR (via xfs_fill_fsxattr() in
> xfs_fileattr_get()) and XFS_IOC_BULKSTAT (which populates bs_xflags
> directly from xfs_ip2xflags()), so bulkstat consumers and per-inode
> queries see a consistent view of the filesystem's case-folding
> behavior.
> 
> XFS always preserves case. XFS is case-sensitive by default, but
> supports ASCII case-insensitive lookups when formatted with the
> ASCIICI feature flag.
> 
> Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_inode_util.c | 2 ++
>  fs/xfs/xfs_ioctl.c             | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
> index 551fa51befb6..82be54b6f8d3 100644
> --- a/fs/xfs/libxfs/xfs_inode_util.c
> +++ b/fs/xfs/libxfs/xfs_inode_util.c
> @@ -130,6 +130,8 @@ xfs_ip2xflags(
>  
>  	if (xfs_inode_has_attr_fork(ip))
>  		flags |= FS_XFLAG_HASATTR;
> +	if (xfs_has_asciici(ip->i_mount))
> +		flags |= FS_XFLAG_CASEFOLD;
>  	return flags;
>  }
>  
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index ed9b4846c05f..5a58fb0bad2b 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -472,6 +472,13 @@ xfs_fill_fsxattr(
>  
>  	fileattr_fill_xflags(fa, xfs_ip2xflags(ip));
>  
> +	/*
> +	 * FS_XFLAG_CASEFOLD is read-only; hide it from the legacy
> +	 * flags view so chattr's RMW cycle does not pass it back to
> +	 * xfs_fileattr_set().
> +	 */
> +	fa->flags &= ~FS_CASEFOLD_FL;

I don't understand this at all.  Yes, FS_XFLAG_CASEFOLD is readonly, but
how does clearing FS_CASEFOLD_FL from the fileattr_get output (without
clearing XFLAG_CASEFOLD!) solve anything?  This makes the reported
output inconsistent between fsgetxattr and getflags -- one reports case
folding, the other reports no casefolding.

If you want to avoid fileattr_set returning EINVAL when setting
attributes due to the casefold flag, then don't you want to check the
flag state vs. xfs_has_asciici() in the *fileattr_set* path?

--D

> +
>  	if (ip->i_diflags & XFS_DIFLAG_EXTSIZE) {
>  		fa->fsx_extsize = XFS_FSB_TO_B(mp, ip->i_extsize);
>  	} else if (ip->i_diflags & XFS_DIFLAG_EXTSZINHERIT) {
> 
> -- 
> 2.53.0
> 
> 

