Return-Path: <linux-nfs+bounces-7202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED519A0D09
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5351F24CC2
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F3B20C032;
	Wed, 16 Oct 2024 14:42:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A10B20E005;
	Wed, 16 Oct 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089740; cv=none; b=oMB6U1W+GpW/r8q1FDjFzd9Hpx7SIdsJvWEBOHp8ZAA22GrRbHhAtx95o6mM7d1ZIrf5IRIH5xhIWJLPzwHxwB1SAotY9BN+JVQRVbncM5o2wWxTWpTRVEr7ZN7C3B58afWWsho36vJLarqirnIWJwa7DygQWTMngU9pWpSgAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089740; c=relaxed/simple;
	bh=SWTaoC0L1qQu11TduACpr1Kb1+hqD35dRCgOFWwVj10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qrj2S0GmMgxEkgn9m+i/aXdSm90fFxXJ+Z81Y5Pg3cvqj/f0O/HPOpj1joEOq5iaxGuAkfRZUVXbHJ8xuqQqyH451QSKL/BL9c1Iu6YrP16108Yej+CevYrs5rOv5VahsUuWr14gNhQv6uZEIJ3UTizl1w/dBGSEoNIA0NrIuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB231007;
	Wed, 16 Oct 2024 07:42:46 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047503F71E;
	Wed, 16 Oct 2024 07:42:13 -0700 (PDT)
Message-ID: <bee3f66f-cc22-4b3e-be07-23ce4c90df20@arm.com>
Date: Wed, 16 Oct 2024 15:42:12 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 21/57] sunrpc: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Anna Schumaker <anna@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Trond Myklebust <trondmy@kernel.org>,
 Will Deacon <will@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-21-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-21-ryan.roberts@arm.com>
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
> Updated array sizes in various structs to contain enough entries for the
> smallest supported page size.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  include/linux/sunrpc/svc.h      | 8 +++++---
>  include/linux/sunrpc/svc_rdma.h | 4 ++--
>  include/linux/sunrpc/svcsock.h  | 2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index a7d0406b9ef59..dda44018b8f36 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -160,6 +160,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>   */
>  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
>  				+ 2 + 1)
> +#define RPCSVC_MAXPAGES_MAX	((RPCSVC_MAXPAYLOAD+PAGE_SIZE_MIN-1)/PAGE_SIZE_MIN \
> +				+ 2 + 1)
>  
>  /*
>   * The context of a single thread, including the request currently being
> @@ -190,14 +192,14 @@ struct svc_rqst {
>  	struct xdr_stream	rq_res_stream;
>  	struct page		*rq_scratch_page;
>  	struct xdr_buf		rq_res;
> -	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
> +	struct page		*rq_pages[RPCSVC_MAXPAGES_MAX + 1];
>  	struct page *		*rq_respages;	/* points into rq_pages */
>  	struct page *		*rq_next_page; /* next reply page to use */
>  	struct page *		*rq_page_end;  /* one past the last page */
>  
>  	struct folio_batch	rq_fbatch;
> -	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
> -	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
> +	struct kvec		rq_vec[RPCSVC_MAXPAGES_MAX]; /* generally useful.. */
> +	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES_MAX];
>  
>  	__be32			rq_xid;		/* transmission id */
>  	u32			rq_prog;	/* program number */
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> index d33bab33099ab..7c6441e8d6f7a 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -200,7 +200,7 @@ struct svc_rdma_recv_ctxt {
>  	struct svc_rdma_pcl	rc_reply_pcl;
>  
>  	unsigned int		rc_page_count;
> -	struct page		*rc_pages[RPCSVC_MAXPAGES];
> +	struct page		*rc_pages[RPCSVC_MAXPAGES_MAX];
>  };
>  
>  /*
> @@ -242,7 +242,7 @@ struct svc_rdma_send_ctxt {
>  	void			*sc_xprt_buf;
>  	int			sc_page_count;
>  	int			sc_cur_sge_no;
> -	struct page		*sc_pages[RPCSVC_MAXPAGES];
> +	struct page		*sc_pages[RPCSVC_MAXPAGES_MAX];
>  	struct ib_sge		sc_sges[];
>  };
>  
> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
> index 7c78ec6356b92..6c6bcc82685a3 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -40,7 +40,7 @@ struct svc_sock {
>  
>  	struct completion	sk_handshake_done;
>  
> -	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
> +	struct page *		sk_pages[RPCSVC_MAXPAGES_MAX];	/* received data */
>  };
>  
>  static inline u32 svc_sock_reclen(struct svc_sock *svsk)


