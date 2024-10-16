Return-Path: <linux-nfs+bounces-7209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F89A0DAA
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 17:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6861C22802
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E06820E022;
	Wed, 16 Oct 2024 15:09:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098C20B1EE;
	Wed, 16 Oct 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091367; cv=none; b=kkqDR5cKdQrKvo9Ar3e7+tkOZHk/pkFfo9+okXJHCDlRIl9e9Ij0eupqMmHokmPkqaWaQWPJxNlMPHTw937Zc1MMKR5quVEqcCvH1t8HO7ymx0FyBwgF6isJwrDyJYhhCxqvEZxlcgk8dW/WZZmYX016MjosU+Y8EJUjrU4Pvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091367; c=relaxed/simple;
	bh=gRPb5P1k9UfY8ZGiYWYsNqS7y22Jny7V3mVzeUcEEe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5GhRh/SN59ycN8pRuR1Djwk6Jp59TrZMuMZweCuBIhXRwFd/dNWg48tjWJxfyHPrpElopY+gYzAOtBzSnOz2GwwksUuyj1eYwAEAJoW9R6jB2Jy6HuOovJlFjpt6u4SXQ1A7G9unsaxt96ZCQ4MHEOhWym7aU5LiCf6gKORL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1651FEC;
	Wed, 16 Oct 2024 08:09:53 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C8003F528;
	Wed, 16 Oct 2024 08:09:20 -0700 (PDT)
Message-ID: <d3643b60-0c67-462b-b8c4-95854d2983b0@arm.com>
Date: Wed, 16 Oct 2024 16:09:19 +0100
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
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anna Schumaker <anna@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Trond Myklebust <trondmy@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-21-ryan.roberts@arm.com>
 <bee3f66f-cc22-4b3e-be07-23ce4c90df20@arm.com>
 <Zw/SE9+AMYmzBprS@tissot.1015granger.net>
 <33a6cc271475b0fc520b8fc20ed0b4f7742a2560.camel@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <33a6cc271475b0fc520b8fc20ed0b4f7742a2560.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 15:54, Jeff Layton wrote:
> On Wed, 2024-10-16 at 10:47 -0400, Chuck Lever wrote:
>> On Wed, Oct 16, 2024 at 03:42:12PM +0100, Ryan Roberts wrote:
>>> + Chuck Lever, Jeff Layton
>>>
>>> This was a rather tricky series to get the recipients correct for and my script
>>> did not realize that "supporter" was a pseudonym for "maintainer" so you were
>>> missed off the original post. Appologies!
>>>
>>> More context in cover letter:
>>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>>
>>>
>>> On 14/10/2024 11:58, Ryan Roberts wrote:
>>>> To prepare for supporting boot-time page size selection, refactor code
>>>> to remove assumptions about PAGE_SIZE being compile-time constant. Code
>>>> intended to be equivalent when compile-time page size is active.
>>>>
>>>> Updated array sizes in various structs to contain enough entries for the
>>>> smallest supported page size.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>
>>>> ***NOTE***
>>>> Any confused maintainers may want to read the cover note here for context:
>>>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>>>
>>>>  include/linux/sunrpc/svc.h      | 8 +++++---
>>>>  include/linux/sunrpc/svc_rdma.h | 4 ++--
>>>>  include/linux/sunrpc/svcsock.h  | 2 +-
>>>>  3 files changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>>>> index a7d0406b9ef59..dda44018b8f36 100644
>>>> --- a/include/linux/sunrpc/svc.h
>>>> +++ b/include/linux/sunrpc/svc.h
>>>> @@ -160,6 +160,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>>>>   */
>>>>  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
>>>>  				+ 2 + 1)
>>>> +#define RPCSVC_MAXPAGES_MAX	((RPCSVC_MAXPAYLOAD+PAGE_SIZE_MIN-1)/PAGE_SIZE_MIN \
>>>> +				+ 2 + 1)
>>
>> There is already a "MAX" in the name, so adding this new macro seems
>> superfluous to me. Can we get away with simply updating the
>> "RPCSVC_MAXPAGES" macro, instead of adding this new one?
>>
> 
> +1 that was my thinking too. This is mostly just used to size arrays,
> so we might as well just change the existing macro.

I agree, its not the prettiest. I was (incorrectly) assuming you would want to
continue to limit the number of actual pages at runtime based on the in-use page
size. That said, looking again at the code, RPCSVC_MAXPAGES never actually gets
used to dynamically allocate any memory. So I propose to just do the following:

#define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE_MIN-1)/
						PAGE_SIZE_MIN + 2 + 1)

That will be 259 in practice (assuming PAGE_SIZE_MIN=4K).

> 
> With 64k pages we probably wouldn't need arrays as long as these will
> be. Fixing those array sizes to be settable at runtime though is not a
> trivial project though.

Indeed. Hopefully the above is sufficient.

Thanks for the review!
Ryan

> 
>>
>>>>  /*
>>>>   * The context of a single thread, including the request currently being
>>>> @@ -190,14 +192,14 @@ struct svc_rqst {
>>>>  	struct xdr_stream	rq_res_stream;
>>>>  	struct page		*rq_scratch_page;
>>>>  	struct xdr_buf		rq_res;
>>>> -	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
>>>> +	struct page		*rq_pages[RPCSVC_MAXPAGES_MAX + 1];
>>>>  	struct page *		*rq_respages;	/* points into rq_pages */
>>>>  	struct page *		*rq_next_page; /* next reply page to use */
>>>>  	struct page *		*rq_page_end;  /* one past the last page */
>>>>  
>>>>  	struct folio_batch	rq_fbatch;
>>>> -	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
>>>> -	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
>>>> +	struct kvec		rq_vec[RPCSVC_MAXPAGES_MAX]; /* generally useful.. */
>>>> +	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES_MAX];
>>>>  
>>>>  	__be32			rq_xid;		/* transmission id */
>>>>  	u32			rq_prog;	/* program number */
>>>> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
>>>> index d33bab33099ab..7c6441e8d6f7a 100644
>>>> --- a/include/linux/sunrpc/svc_rdma.h
>>>> +++ b/include/linux/sunrpc/svc_rdma.h
>>>> @@ -200,7 +200,7 @@ struct svc_rdma_recv_ctxt {
>>>>  	struct svc_rdma_pcl	rc_reply_pcl;
>>>>  
>>>>  	unsigned int		rc_page_count;
>>>> -	struct page		*rc_pages[RPCSVC_MAXPAGES];
>>>> +	struct page		*rc_pages[RPCSVC_MAXPAGES_MAX];
>>>>  };
>>>>  
>>>>  /*
>>>> @@ -242,7 +242,7 @@ struct svc_rdma_send_ctxt {
>>>>  	void			*sc_xprt_buf;
>>>>  	int			sc_page_count;
>>>>  	int			sc_cur_sge_no;
>>>> -	struct page		*sc_pages[RPCSVC_MAXPAGES];
>>>> +	struct page		*sc_pages[RPCSVC_MAXPAGES_MAX];
>>>>  	struct ib_sge		sc_sges[];
>>>>  };
>>>>  
>>>> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
>>>> index 7c78ec6356b92..6c6bcc82685a3 100644
>>>> --- a/include/linux/sunrpc/svcsock.h
>>>> +++ b/include/linux/sunrpc/svcsock.h
>>>> @@ -40,7 +40,7 @@ struct svc_sock {
>>>>  
>>>>  	struct completion	sk_handshake_done;
>>>>  
>>>> -	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
>>>> +	struct page *		sk_pages[RPCSVC_MAXPAGES_MAX];	/* received data */
>>>>  };
>>>>  
>>>>  static inline u32 svc_sock_reclen(struct svc_sock *svsk)
>>>
>>
> 


