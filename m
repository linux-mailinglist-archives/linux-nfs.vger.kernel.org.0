Return-Path: <linux-nfs+bounces-5692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B93E95DF4B
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 19:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4AC0B21A71
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7B6F2E2;
	Sat, 24 Aug 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBEB53IM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED623987D;
	Sat, 24 Aug 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522268; cv=none; b=sLOARKFArHt3VC7N07hEgEZN3HJWSXLogXAzbvuG+saE6gQ8hl45P8jiYEtudPfyGzwcAjloiVzkAI2VoEEAXRWKlqGsoPiUvnNxieIHgeW+sA5I312JhbJSdjO/ntntGo+OCTd7rUI0ELseM4p2bdL0i02E/M6p0YZKmjuqSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522268; c=relaxed/simple;
	bh=oEC/+m38S2q+OT1r6TMT+9zd4AY0AHroz+LufgpqoRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIZCAyLbuVlEj9w/ODbo5Ths8Ee1Qy99OqMO8pHjUhyYIx6gHhe2FQTuEN+NlwdsieaddqYM3MUMiwXc6ZeuAiX31A/I+RijDb0R1Nlh7jkewfjkaDtiIY7Cz8/NUuUmwqojIntPCDLRu64/XUmLObsHXnxO2lz1QiqWRt1F4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBEB53IM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B60C32781;
	Sat, 24 Aug 2024 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724522266;
	bh=oEC/+m38S2q+OT1r6TMT+9zd4AY0AHroz+LufgpqoRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBEB53IMMPhu5BFX2LFOtSS/4/xz74sUdoNKC123AzEvkHVKNBfmVgWOVrdxYPCB9
	 Gq0AL9akqos52Azw6lMxapx1S02zSYYi4jelYFq6bQehr+on3WDhAKMaoEmbwKBPcW
	 OzqqMe1XGgamgJql/Txf2Q/jlbQNgFCfjpbFEn4zAcm/VFD2FnDI0k1Ul2a7gM5UCO
	 990Nzqy5E29jDPdesnuoH/XlOcmMdnqTLnyQfPvTiA/Lpx0JC69yepnpYhs/5p+oGd
	 +8VM6AKg8pb/MYCyvCIWCP0w/0NSHL4LBM/bV3m0JnF2BFt1AXPbE6RVyUC8q233Hh
	 o2C/OTMNVPCXw==
Date: Sat, 24 Aug 2024 18:57:38 +0100
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
Subject: Re: [PATCH net-next 6/8] ipv6: mcast: use min() to simplify the code
Message-ID: <20240824175738.GO2164@kernel.org>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-7-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822133908.1042240-7-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:39:06PM +0800, Li Zetao wrote:
> When coping sockaddr in ip6_mc_msfget(), the time of copies
> depends on the minimum value between sl_count and gf_numsrc.
> Using min() here is very semantic.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  net/ipv6/mcast.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 7ba01d8cfbae..b244dbf61d5f 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -586,7 +586,8 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
>  	const struct in6_addr *group;
>  	struct ipv6_mc_socklist *pmc;
>  	struct ip6_sf_socklist *psl;
> -	int i, count, copycount;
> +	unsigned int count;
> +	int i, copycount;
>  
>  	group = &((struct sockaddr_in6 *)&gsf->gf_group)->sin6_addr;
>  
> @@ -610,7 +611,7 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
>  	psl = sock_dereference(pmc->sflist, sk);
>  	count = psl ? psl->sl_count : 0;

Both count and psl->sl_count are unsigned int,
so this looks safe (and more correct than what it replaces, IMHO).

>  
> -	copycount = count < gsf->gf_numsrc ? count : gsf->gf_numsrc;
> +	copycount = min(count, gsf->gf_numsrc);

And gsf->gf_numsrc is a __u32, so min operating on it and
count looks safe to me.

Further, the code it replaces seems to be a max() operation in
both intent and function.

Reviewed-by: Simon Horman <horms@kernel.org>

>  	gsf->gf_numsrc = count;
>  	for (i = 0; i < copycount; i++) {
>  		struct sockaddr_in6 *psin6;
> -- 
> 2.34.1
> 
> 

