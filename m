Return-Path: <linux-nfs+bounces-10289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EDEA40572
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Feb 2025 05:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81696707275
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Feb 2025 04:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07FC1E7C19;
	Sat, 22 Feb 2025 04:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N7KmNtyN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57EB42056;
	Sat, 22 Feb 2025 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740198250; cv=none; b=VR/218BQP7GBMDjpckxBwblt+mfQabXkr9+PC8Pa1iF+GQlONg+7E38a8nBk2buxi8abqW3NxwxZgwXOlWhNw9frOTrXw7odcl6KfyM7pZuXKC40mipC7Em4925mOPvAzporpDmtPWMCgqWqGXUzOGooyKgUapgTZCvBeQtYpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740198250; c=relaxed/simple;
	bh=qSf4yyl47KhjxidUIcDyNPa2hI647nGEmj87vJT4+u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMIFGsJAAV7Kx7PHDfA0kkB6iA8iTO4awrLSRWr2xrkiK2txkxulMs/9ldC6tkCQPqVOrxcHqMrpbn2W46xoossf8e2SIkKzVwBjc0lY+VALXZle2IDvQku0eiNSzzqehlXY3JlzmT+fPZRYPiPFMl5BB0Y4HpGJ5HtJEUaDQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N7KmNtyN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kBorF+lu9MOKjw9Zu9aJHBKvFxgx/GsLywDagfgLFsk=; b=N7KmNtyNyy18k2f5aXEQzFXbBc
	Sk9hBBz+sLj6HF6d6GP7Kw7D0jUrI0Xbk6up5O5pRCfCOaSKOitMRHUx4G5diKUe/WLV4uCgelBse
	N4/i/r1S2T+H7WReVvhM4ZD+nVE/GVndldfzR5o4o7P9Y6KvNwc7lW7twaWiDw1creTAe+PNfRGal
	ORODDU07dnHmbj9B15OH5pMN4bwZlFu7oHKdZFBTpRNMftCyUG9pGPr9aQAkZeUKpZ8/jl1CGFoHR
	Q9J+xAKKo8yxXb7clIWokRa2Tqf4lzQaAQ+sqF4j70goOWLX0kKKpubH+VriThS2oVagP7I3TSc4+
	mEtLQQXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlh3a-00000004e23-30tr;
	Sat, 22 Feb 2025 04:24:02 +0000
Date: Sat, 22 Feb 2025 04:24:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
Message-ID: <20250222042402.GN1977892@ZenIV>
References: <20250220234630.983190-1-neilb@suse.de>
 <20250220234630.983190-5-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220234630.983190-5-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 21, 2025 at 10:36:33AM +1100, NeilBrown wrote:

> @@ -871,7 +870,12 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	args.in_args[0].value = &inarg;
>  	args.in_args[1].size = entry->d_name.len + 1;
>  	args.in_args[1].value = entry->d_name.name;
> -	return create_new_entry(idmap, fm, &args, dir, entry, mode);
> +	de = create_new_entry(idmap, fm, &args, dir, entry, mode);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de)
> +		dput(de);
> +	return 0;

Can that really happen?

> @@ -934,7 +939,12 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	args.in_args[1].value = entry->d_name.name;
>  	args.in_args[2].size = len;
>  	args.in_args[2].value = link;
> -	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> +	de = create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de)
> +		dput(de);
> +	return 0;

Same question.

> +	de = create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
> +	if (!IS_ERR(de)) {
> +		if (de)
> +			dput(de);
> +		de = NULL;

Whoa...  Details, please.  What's going on here?

