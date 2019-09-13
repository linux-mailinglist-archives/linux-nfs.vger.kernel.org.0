Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3758B24AB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfIMRjc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 13:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfIMRjc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Sep 2019 13:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3045C08C33F;
        Fri, 13 Sep 2019 17:39:31 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 475075D9C3;
        Fri, 13 Sep 2019 17:39:30 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     trond.myklebust@hammerspace.com,
        "Anna Schumaker" <anna.schumaker@netapp.com>, tibbs@math.uh.edu,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Bruce Fields" <bfields@fieldses.org>, km@cm4all.com
Subject: Re: [PATCH 1/2] SUNRPC: Fix buffer handling of GSS MIC with less
 slack
Date:   Fri, 13 Sep 2019 13:39:29 -0400
Message-ID: <B8F99914-8343-4D37-9EDC-554B855B810A@redhat.com>
In-Reply-To: <2122CC7A-A7FA-4CA0-A31F-E4852DFE0680@oracle.com>
References: <043d2ca649c3d81cdf0b43b149cd43069ad1c1e2.1568307763.git.bcodding@redhat.com>
 <2122CC7A-A7FA-4CA0-A31F-E4852DFE0680@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 13 Sep 2019 17:39:31 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Sep 2019, at 12:05, Chuck Lever wrote:

> Hi Ben-
>
> A few review comments below.
>
>
>> On Sep 12, 2019, at 1:07 PM, Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>
>> The GSS Message Integrity Check data for krb5i may lie partially in 
>> the XDR
>> reply buffer's pages and tail.  If so, we try to copy the entire MIC 
>> into
>> free space in the tail.  But as the estimations of the slack space 
>> required
>> for authentication and verification have improved there may be less 
>> free
>> space in the tail to complete this copy -- see commit 2c94b8eca1a2
>> ("SUNRPC: Use au_rslack when computing reply buffer size").  In fact, 
>> there
>> may only be room in the tail for a single copy of the MIC, and not 
>> part of
>> the MIC and then another complete copy.
>>
>> The real world failure reported is that `ls` of a directory on NFS 
>> may
>> sometimes return -EIO, which can be traced back to 
>> xdr_buf_read_netobj()
>> failing to find available free space in the tail to copy the MIC.
>>
>> Fix this by checking for the case of the MIC crossing the boundaries 
>> of
>> head, pages, and tail. If so, shift the buffer until the MIC is 
>> contained
>> completely within the pages or tail.  This allows the remainder of 
>> the
>> function to create a sub buffer that directly address the complete 
>> MIC.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> Cc: stable@vger.kernel.org
>> ---
>> net/sunrpc/xdr.c | 45 +++++++++++++++++++++++++++------------------
>> 1 file changed, 27 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 48c93b9e525e..6e05a9693568 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -1237,39 +1237,48 @@ xdr_encode_word(struct xdr_buf *buf, unsigned 
>> int base, u32 obj)
>> EXPORT_SYMBOL_GPL(xdr_encode_word);
>>
>> /* If the netobj starting offset bytes from the start of xdr_buf is 
>> contained
>> - * entirely in the head or the tail, set object to point to it; 
>> otherwise
>> - * try to find space for it at the end of the tail, copy it there, 
>> and
>> - * set obj to point to it. */
>> + * entirely in the head, pages, or tail, set object to point to it; 
>> otherwise
>> + * shift the buffer until it is contained entirely within the pages 
>> or tail.
>> + */
>
> Nit: I would explicitly note in this comment that there is no need
> for the caller to free @obj, and perhaps it should be noted that
> the organization of @buf can be changed by this function.
>
> Maybe more appropriate for 2/2.

Ok.. yes.. though I don't feel strongly about noting that *obj doesn't
need to be freed.


>> int xdr_buf_read_netobj(struct xdr_buf *buf, struct xdr_netobj *obj, 
>> unsigned int offset)
>> {
>> 	struct xdr_buf subbuf;
>> +	unsigned int len_to_boundary;
>>
>> 	if (xdr_decode_word(buf, offset, &obj->len))
>> 		return -EFAULT;
>> -	if (xdr_buf_subsegment(buf, &subbuf, offset + 4, obj->len))
>> +
>> +	offset += 4;
>
> Nit: No blank line before "offset += 4;" would help me understand
> how the offset bump is related to xdr_decode_word(). It took me
> a few blinks to see.
>
>
>> +
>> +	/* Is the obj partially in the head? */
>> +	len_to_boundary = buf->head->iov_len - offset;
>> +	if (len_to_boundary > 0 && len_to_boundary < obj->len)
>
> I'm not especially excited about the integer underflow when offset
> is larger than buf->head->iov_len. This might be more explicit:
>
>         if (offset < buf->head[0].iov_len &&
>             offset + obj->len > buf->head[0].iov_len)

Yep, makes sense - and I prefer the clarity.

>> +		xdr_shift_buf(buf, len_to_boundary);
>> +
>> +	/* Is the obj partially in the pages? */
>> +	len_to_boundary = buf->head->iov_len + buf->page_len - offset;
>> +	if (len_to_boundary > 0 && len_to_boundary < obj->len)
>
> Ditto.
>
>
>> +		xdr_shrink_pagelen(buf, len_to_boundary);
>> +
>> +	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
>> 		return -EFAULT;
>>
>> -	/* Is the obj contained entirely in the head? */
>> -	obj->data = subbuf.head[0].iov_base;
>> -	if (subbuf.head[0].iov_len == obj->len)
>> -		return 0;
>> -	/* ..or is the obj contained entirely in the tail? */
>> +	/* Most likely: is the obj contained entirely in the tail? */
>> 	obj->data = subbuf.tail[0].iov_base;
>> 	if (subbuf.tail[0].iov_len == obj->len)
>> 		return 0;
>>
>> -	/* use end of tail as storage for obj:
>> -	 * (We don't copy to the beginning because then we'd have
>> -	 * to worry about doing a potentially overlapping copy.
>> -	 * This assumes the object is at most half the length of the
>> -	 * tail.) */
>> +	/* ..or is the obj contained entirely in the head? */
>> +	obj->data = subbuf.head[0].iov_base;
>> +	if (subbuf.head[0].iov_len == obj->len)
>> +		return 0;
>
> It looks like you're reversing these two tests as a 
> micro-optimization?
> Maybe that should be left for another patch, since this is supposed to
> be a narrow fix.

Yes, if not done here - is it even worth another patch?

> Also, I found the new comments confusing: here they refer to the head
> and tail of @subbuf; above they refer to head and tail of @buf. Note 
> for
> 2/2, I guess.

I can clarify in 2/2.

>> +
>> +	/* obj is in the pages: move to tail */
>> 	if (obj->len > buf->buflen - buf->len)
>> 		return -ENOMEM;
>> -	if (buf->tail[0].iov_len != 0)
>> -		obj->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
>> -	else
>> -		obj->data = buf->head[0].iov_base + buf->head[0].iov_len;
>> +	obj->data = buf->head[0].iov_base + buf->head[0].iov_len;
>
> Not sure this is a safe change. It's possible that the head buffer
> and tail buffer are not contiguous, which is what the 
> buf->tail.iov_len
> check is looking for, IMO. Can this hunk be left out?

That's something I missed somehow, thanks for pointing it out.  I see 
now
that the transport can allocate them any way it likes.

Thanks for the review, I'll send a v2.

Ben
