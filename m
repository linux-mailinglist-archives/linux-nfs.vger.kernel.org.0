Return-Path: <linux-nfs+bounces-5694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936A095DF57
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 20:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7BC281D48
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 18:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F8145003;
	Sat, 24 Aug 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwEKT7GY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4C20B0F;
	Sat, 24 Aug 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522605; cv=none; b=QRYdrmJjbdzxvg4RKRvLRgmDLKii2k01vdcSr7YY6VNd5/pFn9zTf7Tt7Wxi0jcUr06tbJg5mtW7mpc/hUJ6UN7726nvtbYxISnH9N55O/tD7qu0Pn7a7QMKppuopxwe8tSmpzRB1cAGf0GT53wUP5kAta7L/Y0L6h3Ui+57DpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522605; c=relaxed/simple;
	bh=RFmHCUIsqlb05LzxYhXpFiVUrQMsqddPLjxKmpoiTzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reUVzzlqkX9DZB++7E/7AsNrII3ZuM+RiaEI5OyGPnohGsMBvOvMoDw06bEnij/4IvLHavy/C1E24/fAFZCQAeVxj4g3YTZK0MNwQFZrzetI7ybzEBVHOxv6Ai3LUIMy8TqMKJ38iCEsXNq6rz3H3scGiTeI4X2hR+LSiUkzszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwEKT7GY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22C4C32781;
	Sat, 24 Aug 2024 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724522604;
	bh=RFmHCUIsqlb05LzxYhXpFiVUrQMsqddPLjxKmpoiTzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwEKT7GYEyM5O28duV16IGtZ/0bTQk5TOj8dlaU/LiSG1/7DTRY6OPgTwcJDOWw4F
	 2SvmW8D/f1Fg2SsQKobDZYa63ofNNu0FXe1/cf2Q5NaSG5CVJTH8L69GbJlZ36hd+g
	 bQBEQunlsXQm9Qi4Wdtvgy5dKYFyOGqvx/yZZZZoqYy0ks5GVK/IJNagGTE58UZLsZ
	 zADAFaq/3c48Iht3dG0Uj0a85Dp7JqVdQZghu7hbO+qQ0TDSSaWO73OOGBtS/Y0fXm
	 66YTevEkNgtY5A9AOC/DUakCBEcBTW/eamPdGSSlWsXAbMDkruYDSHexEUMLGg4v65
	 SBlMDpa4IzBGQ==
Date: Sat, 24 Aug 2024 19:03:16 +0100
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
Subject: Re: [PATCH net-next 7/8] tipc: use min() to simplify the code
Message-ID: <20240824180316.GP2164@kernel.org>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-8-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822133908.1042240-8-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:39:07PM +0800, Li Zetao wrote:
> When calculating size of own domain based on number of peers, the result
> should be less than MAX_MON_DOMAIN, so using min() here is very semantic.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  net/tipc/monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
> index 77a3d016cade..e2f19627e43d 100644
> --- a/net/tipc/monitor.c
> +++ b/net/tipc/monitor.c
> @@ -149,7 +149,7 @@ static int dom_size(int peers)
>  
>  	while ((i * i) < peers)
>  		i++;
> -	return i < MAX_MON_DOMAIN ? i : MAX_MON_DOMAIN;
> +	return min(i, MAX_MON_DOMAIN);
>  }

Perhaps this whole function is open coding something, but
if so I couldn't find it.

In any case this looks safe to me as i is an unsigned int
while MAX_MON_DOMAIN is 64 (also an unsigned int, I believe).

And the code being replaced appears to be a min() operation
in both form and function.

Reviewed-by: Simon Horman <horms@kernel.org>

>  
>  static void map_set(u64 *up_map, int i, unsigned int v)
> -- 
> 2.34.1
> 
> 

