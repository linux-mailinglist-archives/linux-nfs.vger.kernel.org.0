Return-Path: <linux-nfs+bounces-13053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F44B04218
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 16:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B8A1A6521C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FF15B0EC;
	Mon, 14 Jul 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnLqBq3X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B5EAD7
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504361; cv=none; b=jQzn2vu8hqtPZKUZJQioS6yy/MTLBaQHf8FFCyv71ny93Cv5Y9ZwoKtMrSYuI/TcvkUNgSTIr0kqGfwktZvSe6ysSa9PG2QFUbnHVpTdX8IeqCQNknrsfRCHkHyOheb5CkNJ2bsQZ2GQO6UUYsu/aLq5tNmgg0jHOKSAYTsEVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504361; c=relaxed/simple;
	bh=5zoD15Mq8XRvfAcNbRzA21xPsXeYGXOsG552dSLqfsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3uGJeAD52ZKj+S3ND5sl4D3ap0KR8dy9HgWkwhlWkiUiQVJZ9GKSuS+i5l5Uca/yQiyHU1BUjKJ608XbSFLpQ9h8lhmvtC5LwXGr/kY9YcPC31x2WSs3//xJgnCqY1yEfyIvIX/NH4iuiIJI9UkO2NRB9c7S6LpZ4UvGSnaR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnLqBq3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF389C4CEED;
	Mon, 14 Jul 2025 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752504360;
	bh=5zoD15Mq8XRvfAcNbRzA21xPsXeYGXOsG552dSLqfsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnLqBq3XghTrH7gOeT79QbAzBhOrrRBK7IZyMb2qQbcahqjKst/MMIOuY2aM+XgOf
	 Sx4sk6C9cqflNnn3UUeFxDzOPxvfyyS5WOtLaX0MpWDWvb9mzV3xtep1oxFvlNDLO/
	 3itylUPIlurKHzNz9d7//1hYNecA+ePO+DRYRjZDivfIob25TnyxcMh0fToZL3moMX
	 584SBkt0WMcjDQhhlGjJhZRatKLilDblBhvrOSg7fWSYPj19CA/RmnYJw4Euszrzp8
	 g2SrF2fc3fd/WbJz4hQs6nnslVChmYjDv427Xlk+LDlWTDSjL063Pe4Sy9LkVLx5H1
	 MRoQlkq80jM2A==
Date: Mon, 14 Jul 2025 10:45:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH for 6.16-rcX] Revert "nfs_localio: change
 nfsd_file_put_local() to take a pointer to __rcu pointer"
Message-ID: <aHUYJ-C0-d64xQon@kernel.org>
References: <>
 <aG0pJXVtApZ9C5vy@kernel.org>
 <175246504876.2234665.13723785598314130070@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175246504876.2234665.13723785598314130070@noble.neil.brown.name>

On Mon, Jul 14, 2025 at 01:50:48PM +1000, NeilBrown wrote:
> On Wed, 09 Jul 2025, Mike Snitzer wrote:
> > [Preface: this revert makes it much less likely to "lose the race",
> > whereby causing nfsd_shutdown_net() to hang, so we'd do well to take
> > the time/care to properly fix whatever is lacking in Neil's commit
> > c25a89770d1f]
> 
> Was this the first time you posted on this issue?  If so it seem strange
> to start a discussion with a revert with out a clear undertstanding of
> the problem...

Might seem strange, but it seems strange for code to have gotten
upstream without having been properly tested to reveal such basic
issues.  And when I embarked on what should've been a quick revert,
only to find that the series of changes weren't even bisect safe, that
only gave me more justification to rip all the code out in the hopes
of restoring known solid LOCALIO functionality (from v6.14).

> 
> Maybe
> 
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -177,7 +177,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
>  			/* nfs_close_local_fh() is doing the
>  			 * close and we must wait. until it unlinks
>  			 */
> -			wait_var_event_spinlock(nfl,
> +			wait_var_event_spinlock(nfl->nfs_uuid,
>  						list_first_entry_or_null(
>  							&nfs_uuid->files,
>  							struct nfs_file_localio,
> 
> 
> will fix the problem - I'm waiting on the wrong address, which could
> cause various things to hang.

Yes, as I just replied to your official patch posting for this, I will
test.  But the "maybe" nature lacks confidence and that needs to
improve. ;)  Are you able to test LOCALIO?

I'll work to get better at making time to treat your LOCALIO changes
as if they are my own and to fully embrace associated review/test
work.  But that work never quite reaches the same level of investment
for me to do so as when I develop the change.. maybe "normal" but I
need to get past that.  We're in this together!

Thanks for your time on this Neil!

Mike

