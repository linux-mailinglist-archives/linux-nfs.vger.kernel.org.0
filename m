Return-Path: <linux-nfs+bounces-5695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC80895DF71
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781C41F21E8F
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 18:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A16D54F8C;
	Sat, 24 Aug 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oast/GqF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2844D9FE;
	Sat, 24 Aug 2024 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522879; cv=none; b=Iw5mgv/8+19M81EEkiTeoQ9giotJF5zRt3Z8lQAY0U79uhU4vWHgOHNL04VKvG0cp3Zp7AlK4JTumFp1w6qyN/TT5KO2BkoeF27JsEiOnhF8W26C+IDaZDvELpW3YjqhlV2dVoEXnu3Tmp3yzs7uNfa3OrUYoyEYivs+D+NP8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522879; c=relaxed/simple;
	bh=xobUbeL4MWwNrhjODlqIltVMwrBAX/LlpFsseDVrB0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRvGadr2YqTA/QhXEg89aNFB3Pn28qtp57Qy1soKwuMgaALBl3m+irIWuQl7X2OJk5i8zXOZTQxv9aSugN3kPGnBLLmhbHX22tB1oPHQyCvnTa3zAxcOMo2Ss4AvXpMs4aDiJ6cFv/ZHKgLWrDFsSAMoNfb84foMh9ikhyIIkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oast/GqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8724C4AF0B;
	Sat, 24 Aug 2024 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724522878;
	bh=xobUbeL4MWwNrhjODlqIltVMwrBAX/LlpFsseDVrB0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oast/GqFYj9l9ObgKISNoBQRbm1cDdGtoRzxDtUShP+LG0e1yhrUD+P04oFU7iLbH
	 DXpZA3PCbWspACl3IJiO1zIFUatWKS/j9NliF4k+VsG2IYlSHEQDt06Z1zxOPHyjS8
	 /AY8dUOHVvdJ6ACnx6KjF/gkMKYJfmtbpWD/fzlx0XMgrtQmgDj7DsWwgJx4hxMAdD
	 sPyTDBzCx5XE1rOi+cmNEj16GfuFk+h9+yxQp19ivybwe24AlSj593YrXa24j846nE
	 Y6rhchP5/QsaJfryVi1TdFnt8Qf/IN9RdOQb3WsJKYxHEbNZytfV4eHd+OB+jyAl5B
	 ltru5LvqS1GiA==
Date: Sat, 24 Aug 2024 19:07:50 +0100
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
Subject: Re: [PATCH net-next 8/8] SUNRPC: use min() to simplify the code
Message-ID: <20240824180750.GQ2164@kernel.org>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-9-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822133908.1042240-9-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:39:08PM +0800, Li Zetao wrote:
> When reading pages in xdr_read_pages, the number of XDR encoded bytes
> should be less than the len of aligned pages, so using min() here is
> very semantic.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  net/sunrpc/xdr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 62e07c330a66..6746e920dbbb 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1602,7 +1602,7 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
>  	end = xdr_stream_remaining(xdr) - pglen;
>  
>  	xdr_set_tail_base(xdr, base, end);
> -	return len <= pglen ? len : pglen;
> +	return min(len, pglen);

Both len and pglen are unsigned int, so this seems correct to me.

And the code being replaced does appear to be a min() operation in
both form and function.

Reviewed-by: Simon Horman <horms@kernel.org>

However, I don't believe SUNRPC changes usually don't go through next-next.
So I think this either needs to be reposted or get some acks from
Chuck Lever (already CCed).

Chuck, perhaps you can offer some guidance here?

>  }
>  EXPORT_SYMBOL_GPL(xdr_read_pages);
>  
> -- 
> 2.34.1
> 
> 

