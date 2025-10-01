Return-Path: <linux-nfs+bounces-14846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC3CBB19FB
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 21:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22A93C4730
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 19:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59970277CBF;
	Wed,  1 Oct 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dem9ZFYM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71617A305;
	Wed,  1 Oct 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347361; cv=none; b=eVcqbl0ptcIpF9azzgfWmLjjNRPsZI8wFBJGbfaGztd3lZjX4f95boVpSaOlmx2J4m6nRkiU4MsY+eJNPzeNqOq7Hr+0wVF3+PHoUOx+TP7gtdadO9dNAgUpNfQ6ApoNQbE4cu6PxLiPWjrt3uSCZygwTXXIDtQsKPVbdiOxB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347361; c=relaxed/simple;
	bh=Fvw/b7sD4rZMWG+T3/OorGDiP5Isib8QWl+eF7N8iEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOHWQ9AtG5tQSivz79bKfHkERpvqZSLgW/dWhocLgzIR1NXC3ruOJUThleyD7ATDYy4ZlRvNmPunIjUXCqMEBX/wAyzFOKlzLtirAvzrdFSQ4yvFM3ktqnO7K6+oUWpEncHFhxjcu3x2atlLz+6gjfqrToUygztgKX41t/2gpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dem9ZFYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B41C4CEF1;
	Wed,  1 Oct 2025 19:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759347360;
	bh=Fvw/b7sD4rZMWG+T3/OorGDiP5Isib8QWl+eF7N8iEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dem9ZFYMQ+8h6Gm87821SllJSUbl+sYAfm5AjtBzWgvEw3nyvVoEhiTTR8vko3QVo
	 qocIIv3iIYGmlglKvdWXcQ+zkoHFzlxMpO4rREZCdp24O6f/LoIss12r01RQHD4VXB
	 JRmCvSE0fQGyJEmm0WKkbbJG4K5sgpB8s/h6vpmXDBEhLbjEJd026Hk5IR/nMmdFdi
	 ls2UTxfZY4iqy1KLIgVJLnNYZj8kmW6SN7z1bxCMtNEsgZYuC2GQrWPZlDOtXqlAYY
	 COAFzBFer0NhLr4jxAYgaDyBT6g7UvG/VKxtcAigxj49t6S+vC4H0cJgrcvwMhOe7C
	 YPq2FRNX/FiBw==
Date: Wed, 1 Oct 2025 15:35:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] svcrdma: Increase the server's default RPC/RDMA
 credit grant
Message-ID: <aN2Cnz1TrdOO74vb@kernel.org>
References: <20250926155235.60924-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926155235.60924-1-cel@kernel.org>

On Fri, Sep 26, 2025 at 11:52:35AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Now that the nfsd thread count can scale to more threads, permit

Just trying to appreciate which change(s) paved the way for this
RPCRDMA_MAX_REQUESTS change.

Are you referring to the netlink interface changes Jeff did earlier
this year or something else? (thinking "something else" but...)

Might be useful to update the header to convey which specific
commit(s) made this change possible.

Mike

> individual clients to make more use of those threads. Increase the
> RPC/RDMA per-connection credit grant from 64 to 128 -- same as the
> Linux NFS client.
> 
> Simple single client fio-based benchmarking so far shows only
> improvement, no regression.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc_rdma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> index 22704c2e5b9b..57f4fd94166a 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -131,7 +131,7 @@ static inline struct svcxprt_rdma *svc_rdma_rqst_rdma(struct svc_rqst *rqstp)
>   */
>  enum {
>  	RPCRDMA_LISTEN_BACKLOG	= 10,
> -	RPCRDMA_MAX_REQUESTS	= 64,
> +	RPCRDMA_MAX_REQUESTS	= 128,
>  	RPCRDMA_MAX_BC_REQUESTS	= 2,
>  };
>  
> -- 
> 2.51.0
> 
> 

