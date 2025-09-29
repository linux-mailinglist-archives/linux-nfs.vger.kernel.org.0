Return-Path: <linux-nfs+bounces-14784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A770DBAA320
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B951894039
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39D2144CF;
	Mon, 29 Sep 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvPIc/bS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F9205ABA
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167563; cv=none; b=Bl3osMRTqi+rZAeTtpTLOWVDjxXLQG4q+pT0RMJ47RiCQRaopvVP6Yns+XOeprjW7rJR+9lkLbokPfhHnrI2E7kCofsXOI9vCG5KmeeQLeWEshvnYjd3FhLJD/uUH3DCe2IhBpr2zE2wdIdymyoYi0XjRItFV8fnBmf4SPM/lAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167563; c=relaxed/simple;
	bh=/IZvAAZ+Vojcj/uxScKX3xbsyX09gmQvRpCR1HtcppM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmxKR7TQs5hB7Olgkx+h7QGf+YOnvHbDVquIwTRGlnuuvo9hwTJ4QfSkbc3or0eL95n/dXxGUKfV8VWtUTYRKQCSh09WZwJr+5/3cVOkrRRJ/TV6YJaz+gQmCT5/fa49hL5b4OmDyKZEbR/ql3FIcMh2glgRz3B8Qyqgf5chkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvPIc/bS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7F3C4CEF4;
	Mon, 29 Sep 2025 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759167560;
	bh=/IZvAAZ+Vojcj/uxScKX3xbsyX09gmQvRpCR1HtcppM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvPIc/bSvXQ5dJEHgXu8lNZCWmkkWMrKWmGXhnY5f5WYGvk5SWsMZJ3CW4ufRPWT6
	 kn9wO2FZZv9Es6VruZZfoqMHg766dOR/7ooraXbLHi1AYh3J8JWGklIWPUrZgjrJon
	 X7fViafp5JgNl8VvARwOmqTcZwD/5yMORYkWi23DYmEKDObtrgN3n6Ko8oMYZ9t5N0
	 Oy9DUCZ37eAx9DIghsuGbCF78NqbHR4whjbnDAJFURlBqz0Yr95jcmU+h0/lhxpHmJ
	 vRAit2/9+K8vCKtM3sZ0GM8cax587NUddx6egqc8t/n/JJrpW64J+kPgnh0CGFaHs5
	 MpACX5pakk+rQ==
Date: Mon, 29 Sep 2025 13:39:19 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 5/6] NFSD: Prevent a NULL pointer dereference in
 fh_getattr()
Message-ID: <aNrERzXvdy2Sx19l@kernel.org>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929155646.4818-6-cel@kernel.org>

On Mon, Sep 29, 2025 at 11:56:45AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In general, fh_getattr() can be called after the target dentry has
> gone negative. For a negative dentry, d_inode(p.dentry) will return
> NULL. S_ISREG() will dereference that pointer.
> 
> Avoid this potential regression by using the d_is_reg() helper
> instead.
> 
> Suggested-by: NeilBrown <neil@brown.name>
> Fixes: bc70aaeba7df ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsfh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..16182936828f 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -696,10 +696,9 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
>  		.mnt		= fhp->fh_export->ex_path.mnt,
>  		.dentry		= fhp->fh_dentry,
>  	};
> -	struct inode *inode = d_inode(p.dentry);
>  	u32 request_mask = STATX_BASIC_STATS;
>  
> -	if (S_ISREG(inode->i_mode))
> +	if (d_is_reg(p.dentry))
>  		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
>  
>  	if (fhp->fh_maxsize == NFS4_FHSIZE)
> -- 
> 2.51.0
> 
> 

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

