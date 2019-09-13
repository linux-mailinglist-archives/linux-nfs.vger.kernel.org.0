Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599A9B2496
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfIMR0K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 13:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfIMR0K (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Sep 2019 13:26:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63A46308402E;
        Fri, 13 Sep 2019 17:26:09 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A49260CC0;
        Fri, 13 Sep 2019 17:26:07 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     trond.myklebust@hammerspace.com,
        "Anna Schumaker" <anna.schumaker@netapp.com>, tibbs@math.uh.edu,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Bruce Fields" <bfields@fieldses.org>, km@cm4all.com
Subject: Re: [PATCH 2/2] SUNRPC: Rename xdr_buf_read_netobj to
 xdr_buf_read_mic
Date:   Fri, 13 Sep 2019 13:26:07 -0400
Message-ID: <F0DD032B-D7C0-438F-9334-AA7427BA2215@redhat.com>
In-Reply-To: <71B1AFAE-2081-4FB4-A5AF-440CB2919C64@oracle.com>
References: <043d2ca649c3d81cdf0b43b149cd43069ad1c1e2.1568307763.git.bcodding@redhat.com>
 <85127ce63248b1f34182dfef21ed30b808bf88fb.1568307763.git.bcodding@redhat.com>
 <71B1AFAE-2081-4FB4-A5AF-440CB2919C64@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 13 Sep 2019 17:26:09 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Sep 2019, at 11:16, Chuck Lever wrote:

>> On Sep 12, 2019, at 1:07 PM, Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>
>> Let the name reflect the single user and purpose.
>
> And perhaps the assumption that the MIC is always the last item in the 
> xdr_buf?
> I'm still reviewing 1/2, but this function might make that assumption.

It does.. is that a bad assumption, or maybe you'd like a different 
name?


>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>> include/linux/sunrpc/xdr.h     |  2 +-
>> net/sunrpc/auth_gss/auth_gss.c |  2 +-
>> net/sunrpc/xdr.c               | 42 
>> +++++++++++++++++-----------------
>> 3 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
>> index 9ee3970ba59c..a6b63e47a79b 100644
>> --- a/include/linux/sunrpc/xdr.h
>> +++ b/include/linux/sunrpc/xdr.h
>> @@ -179,7 +179,7 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
>> extern void xdr_shift_buf(struct xdr_buf *, size_t);
>> extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
>> extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, 
>> unsigned int, unsigned int);
>> -extern int xdr_buf_read_netobj(struct xdr_buf *, struct xdr_netobj 
>> *, unsigned int);
>> +extern int xdr_buf_read_mic(struct xdr_buf *, struct xdr_netobj *, 
>> unsigned int);
>> extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, 
>> void *, unsigned int);
>> extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, 
>> void *, unsigned int);
>>
>> diff --git a/net/sunrpc/auth_gss/auth_gss.c 
>> b/net/sunrpc/auth_gss/auth_gss.c
>> index 4ce42c62458e..d75fddca44c9 100644
>> --- a/net/sunrpc/auth_gss/auth_gss.c
>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>> @@ -1960,7 +1960,7 @@ gss_unwrap_resp_integ(struct rpc_task *task, 
>> struct rpc_cred *cred,
>>
>> 	if (xdr_buf_subsegment(rcv_buf, &integ_buf, data_offset, integ_len))
>> 		goto unwrap_failed;
>> -	if (xdr_buf_read_netobj(rcv_buf, &mic, mic_offset))
>> +	if (xdr_buf_read_mic(rcv_buf, &mic, mic_offset))
>> 		goto unwrap_failed;
>> 	maj_stat = gss_verify_mic(ctx->gc_gss_ctx, &integ_buf, &mic);
>> 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 6e05a9693568..90dfde50f0ef 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -1236,52 +1236,52 @@ xdr_encode_word(struct xdr_buf *buf, unsigned 
>> int base, u32 obj)
>> }
>> EXPORT_SYMBOL_GPL(xdr_encode_word);
>>
>> -/* If the netobj starting offset bytes from the start of xdr_buf is 
>> contained
>> - * entirely in the head, pages, or tail, set object to point to it; 
>> otherwise
>> - * shift the buffer until it is contained entirely within the pages 
>> or tail.
>> +/* If the mic starting offset bytes from the start of xdr_buf is 
>> contained
>> + * entirely in the head, pages, or tail, set mic to point to it; 
>> otherwise
>> + * shift the buf until it is contained entirely within the pages or 
>> tail.
>>  */
>
> Nit: Could the patch convert this into a kernel Doxygen style comment?

Yes, can do that.

Ben

>> -int xdr_buf_read_netobj(struct xdr_buf *buf, struct xdr_netobj *obj, 
>> unsigned int offset)
>> +int xdr_buf_read_mic(struct xdr_buf *buf, struct xdr_netobj *mic, 
>> unsigned int offset)
>> {
>> 	struct xdr_buf subbuf;
>> 	unsigned int len_to_boundary;
>>
>> -	if (xdr_decode_word(buf, offset, &obj->len))
>> +	if (xdr_decode_word(buf, offset, &mic->len))
>> 		return -EFAULT;
>>
>> 	offset += 4;
>>
>> -	/* Is the obj partially in the head? */
>> +	/* Is the mic partially in the head? */
>> 	len_to_boundary = buf->head->iov_len - offset;
>> -	if (len_to_boundary > 0 && len_to_boundary < obj->len)
>> +	if (len_to_boundary > 0 && len_to_boundary < mic->len)
>> 		xdr_shift_buf(buf, len_to_boundary);
>>
>> -	/* Is the obj partially in the pages? */
>> +	/* Is the mic partially in the pages? */
>> 	len_to_boundary = buf->head->iov_len + buf->page_len - offset;
>> -	if (len_to_boundary > 0 && len_to_boundary < obj->len)
>> +	if (len_to_boundary > 0 && len_to_boundary < mic->len)
>> 		xdr_shrink_pagelen(buf, len_to_boundary);
>>
>> -	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
>> +	if (xdr_buf_subsegment(buf, &subbuf, offset, mic->len))
>> 		return -EFAULT;
>>
>> -	/* Most likely: is the obj contained entirely in the tail? */
>> -	obj->data = subbuf.tail[0].iov_base;
>> -	if (subbuf.tail[0].iov_len == obj->len)
>> +	/* Most likely: is the mic contained entirely in the tail? */
>> +	mic->data = subbuf.tail[0].iov_base;
>> +	if (subbuf.tail[0].iov_len == mic->len)
>> 		return 0;
>>
>> -	/* ..or is the obj contained entirely in the head? */
>> -	obj->data = subbuf.head[0].iov_base;
>> -	if (subbuf.head[0].iov_len == obj->len)
>> +	/* ..or is the mic contained entirely in the head? */
>> +	mic->data = subbuf.head[0].iov_base;
>> +	if (subbuf.head[0].iov_len == mic->len)
>> 		return 0;
>>
>> -	/* obj is in the pages: move to tail */
>> -	if (obj->len > buf->buflen - buf->len)
>> +	/* mic is in the pages: move to tail */
>> +	if (mic->len > buf->buflen - buf->len)
>> 		return -ENOMEM;
>> -	obj->data = buf->head[0].iov_base + buf->head[0].iov_len;
>> -	__read_bytes_from_xdr_buf(&subbuf, obj->data, obj->len);
>> +	mic->data = buf->head[0].iov_base + buf->head[0].iov_len;
>> +	__read_bytes_from_xdr_buf(&subbuf, mic->data, mic->len);
>>
>> 	return 0;
>> }
>> -EXPORT_SYMBOL_GPL(xdr_buf_read_netobj);
>> +EXPORT_SYMBOL_GPL(xdr_buf_read_mic);
>>
>> /* Returns 0 on success, or else a negative error code. */
>> static int
>> -- 
>> 2.20.1
>>
>
> --
> Chuck Lever
