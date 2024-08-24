Return-Path: <linux-nfs+bounces-5690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63B95DF37
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 19:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1564CB2170D
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C60481C4;
	Sat, 24 Aug 2024 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcQOtRSS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554539AEB;
	Sat, 24 Aug 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724521076; cv=none; b=d1G0aBX366BTW9lfrZU9kdTftEME1Wkw8kpUiDTn4oJaNewyepQ13sUSOzUMKe2ibGqt5dHCp/X1ZewcQn37iENTDPnSB15pSUdR93BYjeeZIWWabBfXzfIyu6NwHhzmqcllU/kKyvJxkzXYOgQopsB7AqGGcUKRcCl1deE3yQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724521076; c=relaxed/simple;
	bh=kvFHrsJZkycSTtQ8Bk9AGl8Z5ArrHeL5DmVbuvmclFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI8SqpNgFRFsuZ7qLyqtHDlGCml+ZP0Ig4XDfAILHaXdDhzBnLAMxYV1Yedh3+deAXjSESPoR3ZMaEqxJWDL60MJVUW3O1WKqyCtIM0klD82+8LOivlXYUOQmSL5VbmpZZGX4vbUHQCHBEdLyuu6grENJjzTywyg/Uz/7/Yj/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcQOtRSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20A0C32781;
	Sat, 24 Aug 2024 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724521075;
	bh=kvFHrsJZkycSTtQ8Bk9AGl8Z5ArrHeL5DmVbuvmclFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcQOtRSSjWW7zN/YQVx94pfQM7OEZjl8Ds54OGdQiAOAW5oL3HOyRJ0Kq3JHAZCWE
	 fGDWlGWjIFWupfgOc9PMidFqC/cycQ7l7bZo0RsmMSuQzJIZqCRdwX/vDbaBJu3NAI
	 QV9DapgZmd2U330XSXZ7Hir30DvBzRjwaRpwxUCmv3jfmAWmLgK4cHYY2kEJ6//5ik
	 +OHW8ifYBJ2TORxAAL2N7qMOe+8o7GTHA0dksMuO8GeLXr/7WmoIjKcHTWY/Qsyr8k
	 O97PydhxV4jUDBBDQab1BfawVDXKPE6bZ+OCNa+H6tshQwV+0w/A/sKTGM6Ar9yp8o
	 t7xBgjeHkolDg==
Date: Sat, 24 Aug 2024 18:37:47 +0100
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, marcel@holtmann.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com, idryomov@gmail.com, xiubli@redhat.com,
	dsahern@kernel.org, trondmy@kernel.org, anna@kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	jmaloy@redhat.com, ying.xue@windriver.com, linux@treblig.org,
	jacob.e.keller@intel.com, willemb@google.com, kuniyu@amazon.com,
	wuyun.abel@bytedance.com, quic_abchauha@quicinc.com,
	gouhao@uniontech.com, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 3/8] net: caif: use max() to simplify the code
Message-ID: <20240824173747.GN2164@kernel.org>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-4-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822133908.1042240-4-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:39:03PM +0800, Li Zetao wrote:
> When processing the tail append of sk buffer, the final length needs
> to be determined based on expectlen and addlen. Using max() here can
> increase the readability of the code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  net/caif/cfpkt_skbuff.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/caif/cfpkt_skbuff.c b/net/caif/cfpkt_skbuff.c
> index 2ae8cfa3df88..96236d21b18e 100644
> --- a/net/caif/cfpkt_skbuff.c
> +++ b/net/caif/cfpkt_skbuff.c
> @@ -298,10 +298,8 @@ struct cfpkt *cfpkt_append(struct cfpkt *dstpkt,
>  	if (unlikely(is_erronous(dstpkt) || is_erronous(addpkt))) {
>  		return dstpkt;
>  	}
> -	if (expectlen > addlen)
> -		neededtailspace = expectlen;
> -	else
> -		neededtailspace = addlen;
> +
> +	neededtailspace = max(expectlen, addlen);

The types of all three variables involved here are u16,
so this looks correct to me. And the code replaced
seems to be an open coding of max() both in intent and function.

Reviewed-by: Simon Horman <horms@kernel.org>

>  
>  	if (dst->tail + neededtailspace > dst->end) {
>  		/* Create a dumplicate of 'dst' with more tail space */

