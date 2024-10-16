Return-Path: <linux-nfs+bounces-7203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1776B9A0D0E
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297161C2385A
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF90920C030;
	Wed, 16 Oct 2024 14:43:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A710187555;
	Wed, 16 Oct 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089801; cv=none; b=M8Sa+H4NH3TQfc/k8omK93zd6SlknIjWXeMJQv19KsAAnVNrDQSqQZcDCLICYbese0qMCTsi0Oe047bm54pKK9vjzcs62oJIx1/aLDRUlQSUGhOToDqbXUVITcijvoAJgd/v5ADXLXnqv+KkofmgP4xgrH4Wv30XfrjCzOOlNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089801; c=relaxed/simple;
	bh=uHu2wnCxq7+KdVcby4uiVib+3jF6AfIrBZZsSVLrzlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WevecUkHeR9jwwsNi7x2raX74ijpuC2xsQ2WQdH54ufDlZy+6J62/ivv3F4D23gtF3Q7G+1zXF6pyKGOrPpCtjL2RtvUvh+0OYLcL25rCLFqkkvJRMYzpxcSqj5dTPeZSVH7eMy0MJGkuuYxZGi8Bco4u9y0uiCkwlw6n4rihOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41A961007;
	Wed, 16 Oct 2024 07:43:48 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13D063F71E;
	Wed, 16 Oct 2024 07:43:13 -0700 (PDT)
Message-ID: <ed44eb37-b901-4a01-87a3-3670f8f57338@arm.com>
Date: Wed, 16 Oct 2024 15:43:11 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 23/57] net: Remove PAGE_SIZE compile-time constant
 assumption
Content-Language: en-GB
To: "David S. Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>, Anna Schumaker <anna@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalesh Singh <kaleshsingh@google.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 Paolo Abeni <pabeni@redhat.com>, Trond Myklebust <trondmy@kernel.org>,
 Will Deacon <will@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-23-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-23-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Chuck Lever, Jeff Layton

This was a rather tricky series to get the recipients correct for and my script
did not realize that "supporter" was a pseudonym for "maintainer" so you were
missed off the original post. Appologies!

More context in cover letter:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/


On 14/10/2024 11:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Define NLMSG_GOODSIZE using min() instead of ifdeffery. This will now
> evaluate to a compile-time constant for compile-time page size, but
> evaluate at run-time when using boot-time page size.
> 
> Rework NAPI small page frag infrastructure so that for boot-time page
> size it is compiled in if 4K page size is in the possible range, but
> defer deciding to use it to run time when the page size is known. No
> change for compile-time page size case.
> 
> Resize cache_defer_hash[] array for PAGE_SIZE_MAX.
> 
> Convert a complex BUILD_BUG_ON() to runtime BUG_ON().
> 
> Wrap global variables that are initialized with PAGE_SIZE derived values
> using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
> deferred for boot-time page size builds.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  include/linux/netlink.h    | 6 +-----
>  net/core/hotdata.c         | 4 ++--
>  net/core/skbuff.c          | 4 ++--
>  net/core/sysctl_net_core.c | 2 +-
>  net/sunrpc/cache.c         | 3 ++-
>  net/unix/af_unix.c         | 2 +-
>  6 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index b332c2048c755..ffa1e94111f89 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -267,11 +267,7 @@ netlink_skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
>   *	use enormous buffer sizes on recvmsg() calls just to avoid
>   *	MSG_TRUNC when PAGE_SIZE is very large.
>   */
> -#if PAGE_SIZE < 8192UL
> -#define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(PAGE_SIZE)
> -#else
> -#define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(8192UL)
> -#endif
> +#define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(min(PAGE_SIZE, 8192UL))
>  
>  #define NLMSG_DEFAULT_SIZE (NLMSG_GOODSIZE - NLMSG_HDRLEN)
>  
> diff --git a/net/core/hotdata.c b/net/core/hotdata.c
> index d0aaaaa556f22..e1f30e87ba6e9 100644
> --- a/net/core/hotdata.c
> +++ b/net/core/hotdata.c
> @@ -5,7 +5,7 @@
>  #include <net/hotdata.h>
>  #include <net/proto_memory.h>
>  
> -struct net_hotdata net_hotdata __cacheline_aligned = {
> +__DEFINE_GLOBAL_PAGE_SIZE_VAR(struct net_hotdata, net_hotdata, __cacheline_aligned, {
>  	.offload_base = LIST_HEAD_INIT(net_hotdata.offload_base),
>  	.ptype_all = LIST_HEAD_INIT(net_hotdata.ptype_all),
>  	.gro_normal_batch = 8,
> @@ -21,5 +21,5 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
>  	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
>  	.sysctl_skb_defer_max = 64,
>  	.sysctl_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE
> -};
> +});
>  EXPORT_SYMBOL(net_hotdata);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 83f8cd8aa2d16..b6c8eee0cc74b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -219,9 +219,9 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
>  #define NAPI_SKB_CACHE_BULK	16
>  #define NAPI_SKB_CACHE_HALF	(NAPI_SKB_CACHE_SIZE / 2)
>  
> -#if PAGE_SIZE == SZ_4K
> +#if PAGE_SIZE_MIN <= SZ_4K && SZ_4K <= PAGE_SIZE_MAX
>  
> -#define NAPI_HAS_SMALL_PAGE_FRAG	1
> +#define NAPI_HAS_SMALL_PAGE_FRAG	(PAGE_SIZE == SZ_4K)
>  #define NAPI_SMALL_PAGE_PFMEMALLOC(nc)	((nc).pfmemalloc)
>  
>  /* specialized page frag allocator using a single order 0 page
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 86a2476678c48..a7a2eb7581bd1 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -33,7 +33,7 @@ static int int_3600 = 3600;
>  static int min_sndbuf = SOCK_MIN_SNDBUF;
>  static int min_rcvbuf = SOCK_MIN_RCVBUF;
>  static int max_skb_frags = MAX_SKB_FRAGS;
> -static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
> +static DEFINE_GLOBAL_PAGE_SIZE_VAR(int, min_mem_pcpu_rsv, SK_MEMORY_PCPU_RESERVE);
>  
>  static int net_msg_warn;	/* Unused, but still a sysctl */
>  
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 95ff747061046..4e682c0cd7586 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -573,13 +573,14 @@ EXPORT_SYMBOL_GPL(cache_purge);
>   */
>  
>  #define	DFR_HASHSIZE	(PAGE_SIZE/sizeof(struct list_head))
> +#define	DFR_HASHSIZE_MAX (PAGE_SIZE_MAX/sizeof(struct list_head))
>  #define	DFR_HASH(item)	((((long)item)>>4 ^ (((long)item)>>13)) % DFR_HASHSIZE)
>  
>  #define	DFR_MAX	300	/* ??? */
>  
>  static DEFINE_SPINLOCK(cache_defer_lock);
>  static LIST_HEAD(cache_defer_list);
> -static struct hlist_head cache_defer_hash[DFR_HASHSIZE];
> +static struct hlist_head cache_defer_hash[DFR_HASHSIZE_MAX];
>  static int cache_defer_cnt;
>  
>  static void __unhash_deferred_req(struct cache_deferred_req *dreq)
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 0be0dcb07f7b6..1cf9f583358af 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2024,7 +2024,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  				 MAX_SKB_FRAGS * PAGE_SIZE);
>  		data_len = PAGE_ALIGN(data_len);
>  
> -		BUILD_BUG_ON(SKB_MAX_ALLOC < PAGE_SIZE);
> +		BUG_ON(SKB_MAX_ALLOC < PAGE_SIZE);
>  	}
>  
>  	skb = sock_alloc_send_pskb(sk, len - data_len, data_len,


