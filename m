Return-Path: <linux-nfs+bounces-9915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A66A2B9E5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 04:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3793A672D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 03:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BA4187872;
	Fri,  7 Feb 2025 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rpj/TUcx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9D175AB
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900041; cv=none; b=WDknHn/TPIpb40VE8c+FBoFjWowLmuQvYqoBl+QkTEd7axaTOHkotDeDBuflLDRf4S6BzgoD5tkaeQlS3LnLSGEmGiqkf0V4w1PaM6LPPCaMOa/rZXq6o2FXeIq94a79LgXMHVld3pe0zo97mA0aeG2IVVFism5wGEqhQyOmZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900041; c=relaxed/simple;
	bh=T0B6STr28LKhOYxW8r70Z8GbyT60ThtVfuRDEACY8vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAZaNspQTvuc7ikwIqkl/6PkQwrxN4vkiXyi0GeJS7jS5EJgCdmuhOUPbiIQJE/B5a90qGG6jxaSjEMncovGd4acXMs2uwV7rTZrAA973BVtUWobTFOK1wHJ7cWInyhTYgAOeI6SXYJ7cSv3HQGts+U8KLBEb2rp6/2/7fT23ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rpj/TUcx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Feb 2025 22:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738900021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1tXM282Vmzf3GPMuzwo3BHxMLzJGBvWyZEHSJgmRjI=;
	b=Rpj/TUcxPBHwLYigN0b74g15ssNqfgr20kb9ysG5CVTGsIt2CtkKqZ6ROOidc4rLLzWaz7
	CyTY1M34KzrK0PPCWdZrafYwqc2pSnh87AefDjtkv/RHcbArnrTs/VV2cDut4KF2mJ8SEf
	iKpxWfIKZtY3ywPzSlEm30O95i3E7Vc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
Message-ID: <6p2m4jqtl62cabb2xolxt76ycule5prukjzx4nxklvhk23g6qh@luj2tzicloph>
References: <20250207034040.3402438-1-neilb@suse.de>
 <20250207034040.3402438-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207034040.3402438-2-neilb@suse.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 07, 2025 at 02:36:47PM +1100, NeilBrown wrote:
> No callers of kern_path_locked() or user_path_locked_at() want a
> negative dentry.  So change them to return -ENOENT instead.  This
> simplifies callers.
> 
> This results in a subtle change to bcachefs in that an ioctl will now
> return -ENOENT in preference to -EXDEV.  I believe this restores the
> behaviour to what it was prior to

I'm not following how the code change matches the commit message?

>  Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> index 15725b4ce393..595b57fabc9a 100644
> --- a/fs/bcachefs/fs-ioctl.c
> +++ b/fs/bcachefs/fs-ioctl.c
> @@ -511,10 +511,6 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
>  		ret = -EXDEV;
>  		goto err;
>  	}
> -	if (!d_is_positive(victim)) {
> -		ret = -ENOENT;
> -		goto err;
> -	}
>  	ret = __bch2_unlink(dir, victim, true);
>  	if (!ret) {
>  		fsnotify_rmdir(dir, victim);

