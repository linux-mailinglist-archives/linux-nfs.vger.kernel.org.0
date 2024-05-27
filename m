Return-Path: <linux-nfs+bounces-3423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE188D09C1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 20:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FDA1F21644
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19615F3EE;
	Mon, 27 May 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P4Yg7YO0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF21DDC9;
	Mon, 27 May 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833461; cv=none; b=df2WRCHMPQGzXC1Yg8Llzcvq7OvtBPfZylgqNS1lsB30i0zjXVg8pAuYH2aTG7z7QofLjkRJWKBuL94YPEqcjUV8W3rffmzsZZ7PB8G4eYo+WrjQzjXINSDY//kKxH4I1avILjBuoZcVDCYyTrLdryLMnky+UmM/sBGiUxy5S9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833461; c=relaxed/simple;
	bh=eK10ZMnKSMB5tS2KY137h2lm3DPOIZknF+dHeHfG/0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfn1SUPwXmARB9hA1ggJuDbaqweD7aFGa4w57rtJz6bY6fX19HP5ZGTo5g3bAE1xTqWL94sQi1uGAcwCWtwK9ey11lobybdJjH+n4gViZhCHHcVeFyTg3lSm9TxVm5+ug2TC7ammdYN+9ZFv6R6OBTOgUVSmXhLWxmi64rBSD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P4Yg7YO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43629C2BBFC;
	Mon, 27 May 2024 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716833460;
	bh=eK10ZMnKSMB5tS2KY137h2lm3DPOIZknF+dHeHfG/0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4Yg7YO0y+76XcOBnyWhGJ8zsbs3nPZApqwp80DSICRZ+sTVwUkzdY13ad6+OP3H1
	 HZK6RC51J6a8A1/4jIipezyQdUinCTvyciGere1cIS0M0Ml8oo0BFRNNipFsjOB5dl
	 JPIYKwT71qImvSEVaULHbEQcbRmmJv2O7aVLdcS0=
Date: Mon, 27 May 2024 20:11:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	regressions@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.8.y] sunrpc: use the struct net as the svc proc private
Message-ID: <2024052748-frolic-angular-c754@gregkh>
References: <20240527152728.1097505-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527152728.1097505-1-cel@kernel.org>

On Mon, May 27, 2024 at 11:27:28AM -0400, cel@kernel.org wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> [ Upstream commit 418b9687dece5bd763c09b5c27a801a7e3387be9 ]
> 
> nfsd is the only thing using this helper, and it doesn't use the private
> currently.  When we switch to per-network namespace stats we will need
> the struct net * in order to get to the nfsd_net.  Use the net as the
> proc private so we can utilize this when we make the switch over.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This pre-requisite is needed for upstream commit 4b14885411f7 ("nfsd:
> make all of the nfsd stats per-network namespace").

Now queued up, thanks.

greg k-h

