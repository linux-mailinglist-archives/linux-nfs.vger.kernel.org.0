Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1C30CEBA
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 23:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhBBWWw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 17:22:52 -0500
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:60371
        "EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235325AbhBBWWV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 17:22:21 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 743BldwjJyy0q743BlMOsL; Tue, 02 Feb 2021 15:21:34 -0700
X-CMAE-Analysis: v=2.4 cv=AskrYMxP c=1 sm=1 tr=0 ts=6019d06e
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yPCof4ZbAAAA:8 a=YQJfPKivPy9WdbG4OTUA:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <161227696787.3689758.305854118266206775.stgit@manet.1015granger.net>
 <e53cc3c2-2209-5f35-c487-9e59b9b9e526@talpey.com>
 <B0EED542-086B-4E76-9348-FAB8EBA612AB@oracle.com>
 <23f6893c-de31-0382-78a4-c09b1ceb2787@talpey.com>
 <4A44C2FF-BFD6-423A-9FE5-F08CD2D75AA4@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <78cd75d4-6fee-3b93-fa13-b5360fe0d45c@talpey.com>
Date:   Tue, 2 Feb 2021 17:21:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <4A44C2FF-BFD6-423A-9FE5-F08CD2D75AA4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfN9+PzjR6CL+Drphjp8J7QdTU70V8HVdCFkpEXOKa7ltbDLn4SDtdUuZhJ6tXB5JXJFKmRTL9GHTxqA3ogVvG69IVIDZYt/qxLZuuO7WVDHj8OvA2sFq
 zyfGTJgD/JiVXVHXh6qUHHuhw4gPT9UrbfxtZ22jzEjiqPZnrsitZndhWkg9aKK/ehqSi0nLHaFJ/k1mrZLzI1/S587MHFyNc4uuLY0j1GRTqVphkuMSOU9H
 +yM49Wyu93Yjeqy16J6r2pi90K0G+OomOPEp6dSvR+YXf2CjGVU6cEIs7UpsbsBvG5sG9oD34heqWOX7ORTr9Q==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/2/2021 4:55 PM, Chuck Lever wrote:
> 
> 
>> On Feb 2, 2021, at 4:50 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 2/2/2021 2:20 PM, Chuck Lever wrote:
>>>> On Feb 2, 2021, at 2:18 PM, Tom Talpey <tom@talpey.com> wrote:
>>>>
>>>> What's not to like about a log that uses the words "with aplomb"? :)
>>>>
>>>> Minor related comment/question below.
>>>>
>>>> On 2/2/2021 9:42 AM, Chuck Lever wrote:
>>>>> Clean up.
>>>>> Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
>>>>> Remove support for FMR memory registration") [Dec 2018]. That means
>>>>> the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
>>>>> commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
>>>>> on page boundaries") [Mar 2016], is no longer necessary. FRWR
>>>>> memory registration handles this case with aplomb.
>>>>> A related simplification removes an extra conditional branch from
>>>>> the SGL set-up loop in frwr_map(): Instead of using either
>>>>> sg_set_page() or sg_set_buf(), initialize the mr_page field properly
>>>>> when rpcrdma_convert_kvec() converts the kvec to an SGL entry.
>>>>> frwr_map() can then invoke sg_set_page() unconditionally.
>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>> ---
>>>>>   net/sunrpc/xprtrdma/frwr_ops.c  |   10 ++--------
>>>>>   net/sunrpc/xprtrdma/rpc_rdma.c  |   21 +++++----------------
>>>>>   net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
>>>>>   3 files changed, 8 insertions(+), 25 deletions(-)
>>>>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
>>>>> index baca49fe83af..5eb044a5f0be 100644
>>>>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>>>>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>>>>> @@ -306,14 +306,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
>>>>>   	if (nsegs > ep->re_max_fr_depth)
>>>>>   		nsegs = ep->re_max_fr_depth;
>>>>>   	for (i = 0; i < nsegs;) {
>>>>> -		if (seg->mr_page)
>>>>> -			sg_set_page(&mr->mr_sg[i],
>>>>> -				    seg->mr_page,
>>>>> -				    seg->mr_len,
>>>>> -				    offset_in_page(seg->mr_offset));
>>>>> -		else
>>>>> -			sg_set_buf(&mr->mr_sg[i], seg->mr_offset,
>>>>> -				   seg->mr_len);
>>>>> +		sg_set_page(&mr->mr_sg[i], seg->mr_page,
>>>>> +			    seg->mr_len, offset_in_page(seg->mr_offset));
>>>>>     		++seg;
>>>>>   		++i;
>>>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>>> index 8f5d0cb68360..529adb6ad4db 100644
>>>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>>> @@ -204,9 +204,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
>>>>>   	return 0;
>>>>>   }
>>>>>   -/* Split @vec on page boundaries into SGEs. FMR registers pages, not
>>>>> - * a byte range. Other modes coalesce these SGEs into a single MR
>>>>> - * when they can.
>>>>> +/* Convert @vec to a single SGL element.
>>>>>    *
>>>>>    * Returns pointer to next available SGE, and bumps the total number
>>>>>    * of SGEs consumed.
>>>>> @@ -215,21 +213,12 @@ static struct rpcrdma_mr_seg *
>>>>>   rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
>>>>>   		     unsigned int *n)
>>>>>   {
>>>>> -	u32 remaining, page_offset;
>>>>> -	char *base;
>>>>> -
>>>>> -	base = vec->iov_base;
>>>>> -	page_offset = offset_in_page(base);
>>>>> -	remaining = vec->iov_len;
>>>>> -	while (remaining) {
>>>>> -		seg->mr_page = NULL;
>>>>> -		seg->mr_offset = base;
>>>>> -		seg->mr_len = min_t(u32, PAGE_SIZE - page_offset, remaining);
>>>>> -		remaining -= seg->mr_len;
>>>>> -		base += seg->mr_len;
>>>>> +	if (vec->iov_len) {
>>>>> +		seg->mr_page = virt_to_page(vec->iov_base);
>>>>> +		seg->mr_offset = vec->iov_base;
>>>>> +		seg->mr_len = vec->iov_len;
>>>>>   		++seg;
>>>>>   		++(*n);
>>>>> -		page_offset = 0;
>>>>>   	}
>>>>>   	return seg;
>>>>>   }
>>>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>> index 94b28657aeeb..4a9fe6592795 100644
>>>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>> @@ -285,7 +285,7 @@ enum {
>>>>>     struct rpcrdma_mr_seg {		/* chunk descriptors */
>>>>>   	u32		mr_len;		/* length of chunk or segment */
>>>>> -	struct page	*mr_page;	/* owning page, if any */
>>>>> +	struct page	*mr_page;	/* underlying struct page */
>>>>>   	char		*mr_offset;	/* kva if no page, else offset */
>>>>
>>>> Is this comment ("kva if no page") actually correct? The hunk just
>>>> above is an example of a case where mr_page is set, yet mr_offset
>>>> is an iov_base. Is iov_base not a kva?
>>> Ah, well the "if no page" part is now obsolete.
>>> I suppose it should be set to "offset_in_page(vec->iov_base)" ?
>>
>> Seems like it, yes. Assuming that only the first element in the sgl
>> has a possibly non-zero offset ("FBO"). All others must be zero for
>> the FRMR.
>>
>> Is it guaranteed that each kvec is at most one physical page? If not,
>> then the length may span into a random physical page, that was not
>> necessarily contiguous in the original KVA-addressed buffer.
> 
> IIUC kmalloc'd buffers are backed by physically contiguous pages.

Indeed yes, kmalloc is heroic. If the kvec's are based on kmalloc'd
buffers it's good for any iov_len.

Tom.
