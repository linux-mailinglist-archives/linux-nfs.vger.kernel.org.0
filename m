Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B246F30E25F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 19:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhBCSUL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 13:20:11 -0500
Received: from p3plsmtpa11-09.prod.phx3.secureserver.net ([68.178.252.110]:40779
        "EHLO p3plsmtpa11-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232272AbhBCSUK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 13:20:10 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 7MkMlnlLo4A0U7MkNlwepL; Wed, 03 Feb 2021 11:19:23 -0700
X-CMAE-Analysis: v=2.4 cv=OKDiYQWB c=1 sm=1 tr=0 ts=601ae92b
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yPCof4ZbAAAA:8 a=IArbqY7NgdM3mMEZ060A:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2 3/6] xprtrdma: Refactor invocations of offset_in_page()
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
 <161236944700.1030487.6859398915626711523.stgit@manet.1015granger.net>
 <d0bbab3e-851c-3388-3d1c-cbc6249a6803@talpey.com>
 <A8FD067A-DD97-4A5D-BCB1-83DF3FAB3842@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <fa50ef0d-246b-b5aa-49a7-25a3f8934773@talpey.com>
Date:   Wed, 3 Feb 2021 13:19:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <A8FD067A-DD97-4A5D-BCB1-83DF3FAB3842@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNQsyu8WTZOp87VcP589lDaZ2hYiU2RSRqu9S0Wgb8ft/qosZdIOiETVTYB22YgiqbhGt/e+CWystIldsbJBtOvB/zcQCzFiVerKBZTs2BwKM+VSRjaH
 Re1b5ff6d3jXosbyPhdqNffnSPk+kxmaiRYSm1+hSagMS8nO3OJZ9PzmkcKrZmVALHVJYgfWKaKDFm+ZHXOEvbQAo7Okf7C67cQL9Fs1LKuTO4GAdgoqdNs0
 AkHi3UHN8+NG7MLKaT1VOJDos5SHEet4Afg1Dpxybt4=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/3/2021 1:11 PM, Chuck Lever wrote:
> 
> 
>> On Feb 3, 2021, at 1:09 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> This looks good, but the earlier 1/6 patch depends on the offset_in_page
>> conversion in rpcrdma_convert_kvec.
> 
> I don't think it does... sg_set_buf() handles the offset_in_page() calculation
> in that case.

Ah, ok. And offset_in_page can be applied repeatedly, as well.

Tom.

>> Won't that complicate any bisection?
>>
>> Reviewed-By: Tom Talpey <tom@talpey.com>
>>
>> On 2/3/2021 11:24 AM, Chuck Lever wrote:
>>> Clean up so that offset_in_page() is invoked less often in the
>>> most common case, which is mapping xdr->pages.
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   net/sunrpc/xprtrdma/frwr_ops.c  |    8 +++-----
>>>   net/sunrpc/xprtrdma/rpc_rdma.c  |    4 ++--
>>>   net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
>>>   3 files changed, 6 insertions(+), 8 deletions(-)
>>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
>>> index 13a50f77dddb..766a1048a48a 100644
>>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>>> @@ -306,16 +306,14 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
>>>   	if (nsegs > ep->re_max_fr_depth)
>>>   		nsegs = ep->re_max_fr_depth;
>>>   	for (i = 0; i < nsegs;) {
>>> -		sg_set_page(&mr->mr_sg[i],
>>> -			    seg->mr_page,
>>> -			    seg->mr_len,
>>> -			    offset_in_page(seg->mr_offset));
>>> +		sg_set_page(&mr->mr_sg[i], seg->mr_page,
>>> +			    seg->mr_len, seg->mr_offset);
>>>     		++seg;
>>>   		++i;
>>>   		if (ep->re_mrtype == IB_MR_TYPE_SG_GAPS)
>>>   			continue;
>>> -		if ((i < nsegs && offset_in_page(seg->mr_offset)) ||
>>> +		if ((i < nsegs && seg->mr_offset) ||
>>>   		    offset_in_page((seg-1)->mr_offset + (seg-1)->mr_len))
>>>   			break;
>>>   	}
>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
>>> index 529adb6ad4db..b3e66b8f65ab 100644
>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>> @@ -215,7 +215,7 @@ rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
>>>   {
>>>   	if (vec->iov_len) {
>>>   		seg->mr_page = virt_to_page(vec->iov_base);
>>> -		seg->mr_offset = vec->iov_base;
>>> +		seg->mr_offset = offset_in_page(vec->iov_base);
>>>   		seg->mr_len = vec->iov_len;
>>>   		++seg;
>>>   		++(*n);
>>> @@ -248,7 +248,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
>>>   	page_base = offset_in_page(xdrbuf->page_base);
>>>   	while (len) {
>>>   		seg->mr_page = *ppages;
>>> -		seg->mr_offset = (char *)page_base;
>>> +		seg->mr_offset = page_base;
>>>   		seg->mr_len = min_t(u32, PAGE_SIZE - page_base, len);
>>>   		len -= seg->mr_len;
>>>   		++ppages;
>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>>> index 02971e183989..ed1c5444fb9d 100644
>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>> @@ -287,7 +287,7 @@ enum {
>>>   struct rpcrdma_mr_seg {
>>>   	u32		mr_len;		/* length of segment */
>>>   	struct page	*mr_page;	/* underlying struct page */
>>> -	char		*mr_offset;	/* IN: page offset, OUT: iova */
>>> +	u64		mr_offset;	/* IN: page offset, OUT: iova */
>>>   };
>>>     /* The Send SGE array is provisioned to send a maximum size
> 
> --
> Chuck Lever
> 
> 
> 
> 
