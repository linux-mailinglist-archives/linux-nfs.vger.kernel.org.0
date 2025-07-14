Return-Path: <linux-nfs+bounces-13051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E5B041B3
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CFC17BABF
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309411CBA;
	Mon, 14 Jul 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoIotn99"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72BEAD7
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503503; cv=none; b=Q6lAVpo+Bl/53i49BAev8ROP6WBP/G8l+/KQgnPQ7zdQTN1s3uZBDxyjrkY9Z0QNIgN+d5pB2pOK91lZXTkpwY8vrZ2j06a2LmnxjlAi7ZW5BDmtDbzBo8CCe5J/nU/ls4RRMr04/LLKWgyJsDmEbJ7+cU8lUzbhaolDmB8jyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503503; c=relaxed/simple;
	bh=08CsFNowo7PzzxsBJTpSyhaNd/z4RK/M0PbeuPzWVFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikfSzC5WNogen6m7lAABfCVQj5GlcX15yMQJg5Yw93YRudvkwNplaZSgF/NtMDsxTFji8IV7KWG4IAtSz1p6SfTwiBZqNFL1Zvmltx4G6EEEeTfqKn3iU96fWKIiLZ9tFMEqkGTcxIuNlVqRYODUgxW8Ol/+fZwMqW1XNI+Z3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoIotn99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AEEC4CEED;
	Mon, 14 Jul 2025 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752503503;
	bh=08CsFNowo7PzzxsBJTpSyhaNd/z4RK/M0PbeuPzWVFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoIotn99rXW9VcZwgdnJpRkJmfXvgX/bBKwe4pFYG6gG2b1QumjfTg57z8LlydlYL
	 hey2H7nGZllZCUa1cgGctYJkmNtb3jfJWORQRjX4RVWDy60U9M4hNhSQdi+eqQ4H1R
	 NRqHIZuaQSBCN0d33967gz1Xzrsk3G0Nf/FyYbWKOi8yV8b9+xIaEJoe0vt6Mnzey0
	 5M9cQW7zCv1/F35soq3IeoRgPhX4JKONWahsuHqpa2qHjPXtT5ZuEOu2yqhWKMhcLo
	 52XdaXGN0vuZVNnFrrrq+Fbcym6cByMY2LZv/EiPgj4d3Wh60L7m3AX0AEWV0dL2+z
	 ySQ40gHnGWo8Q==
Date: Mon, 14 Jul 2025 10:31:41 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfslocalio: use correct wait address in nfs_uuid_put()
Message-ID: <aHUUzYFfNa2ecJGU@kernel.org>
References: <175246537302.2234665.6977010546892567896@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175246537302.2234665.6977010546892567896@noble.neil.brown.name>

On Mon, Jul 14, 2025 at 01:56:13PM +1000, NeilBrown wrote:
> 
> This wait_var_event_spinlock() in nfs_uuid_put() is waiting for the
> wakeup signalled at the end of nfs_close_local_fh().  That
> wake_up_var_locked() uses &nfl->nfs_uuid, so the waiter must use the
> same address, else nfs_uuid_put() could wait indefinitely causing
> various problems.
> 
> Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
> Reported-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfs_common/nfslocalio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 05c7c16e37ab..bc8dcfb256a3 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -177,7 +177,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
>  			/* nfs_close_local_fh() is doing the
>  			 * close and we must wait. until it unlinks
>  			 */
> -			wait_var_event_spinlock(nfl,
> +			wait_var_event_spinlock(&nfl->nfs_uuid,
>  						list_first_entry_or_null(
>  							&nfs_uuid->files,
>  							struct nfs_file_localio,
> -- 
> 2.49.0
> 
> 

Makes sense:

Acked-by: Mike Snitzer <snitzer@kernel.org>

And I _will_ try to get this tested at the scale I was able to test
late last week.  Will let you and others know (hopefully within the
next 24h).

Mike

