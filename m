Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C34B2283
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbfIMOuD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 10:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388704AbfIMOuD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Sep 2019 10:50:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED1CA308218D;
        Fri, 13 Sep 2019 14:50:01 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 384FF19C78;
        Fri, 13 Sep 2019 14:50:00 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     trond.myklebust@hammerspace.com,
        "Anna Schumaker" <anna.schumaker@netapp.com>, tibbs@math.uh.edu,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Bruce Fields" <bfields@fieldses.org>, km@cm4all.com
Subject: Re: [PATCH 1/2] SUNRPC: Fix buffer handling of GSS MIC with less
 slack
Date:   Fri, 13 Sep 2019 10:49:59 -0400
Message-ID: <A29902D2-EC2B-45BF-AA11-34FC5D64A646@redhat.com>
In-Reply-To: <181DFFE9-F11A-421A-97FA-E3478B7A8C51@oracle.com>
References: <043d2ca649c3d81cdf0b43b149cd43069ad1c1e2.1568307763.git.bcodding@redhat.com>
 <181DFFE9-F11A-421A-97FA-E3478B7A8C51@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 13 Sep 2019 14:50:02 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Sep 2019, at 10:41, Chuck Lever wrote:

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
>
> # v5.1 ?

That makes sense to match the changes to rslack.

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
>> +
>> +	/* Is the obj partially in the head? */
>> +	len_to_boundary = buf->head->iov_len - offset;
>> +	if (len_to_boundary > 0 && len_to_boundary < obj->len)
>> +		xdr_shift_buf(buf, len_to_boundary);
>> +
>> +	/* Is the obj partially in the pages? */
>> +	len_to_boundary = buf->head->iov_len + buf->page_len - offset;
>> +	if (len_to_boundary > 0 && len_to_boundary < obj->len)
>> +		xdr_shrink_pagelen(buf, len_to_boundary);
>
> Do you need to check if the obj is entirely in ->pages but crosses a 
> page boundary?

We're going to copy it out into the tail in that case.  I'm assuming
read_bytes_from_xdr_buf() can handle reading across page boundaries.

So unless I'm missing something, I don't think we need to check.

Ben
