Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C78B384E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbfIPKiB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 06:38:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfIPKiB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Sep 2019 06:38:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 695D9307D8B9;
        Mon, 16 Sep 2019 10:38:00 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17336600F8;
        Mon, 16 Sep 2019 10:37:58 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>, chuck.lever@oracle.com
Cc:     tibbs@math.uh.edu, bfields@fieldses.org, linux-nfs@vger.kernel.org,
        anna.schumaker@netapp.com, km@cm4all.com
Subject: Re: [PATCH v2 1/2] SUNRPC: Fix buffer handling of GSS MIC without
 slack
Date:   Mon, 16 Sep 2019 06:37:59 -0400
Message-ID: <CFE7BD23-8F39-4D0D-98C2-76552D909D9A@redhat.com>
In-Reply-To: <444c663d56f9f8292d233ec903b39871df14826a.camel@hammerspace.com>
References: <9f9848f4cbb03b09c7f28f8a43fb27120703ae49.1568557832.git.bcodding@redhat.com>
 <8350AC46-9CFA-410D-AC0C-EF2ACE24FD74@oracle.com>
 <444c663d56f9f8292d233ec903b39871df14826a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 16 Sep 2019 10:38:01 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15 Sep 2019, at 13:30, Trond Myklebust wrote:
> On Sun, 2019-09-15 at 12:43 -0400, Chuck Lever wrote:
>> Hi Ben-
>>
>>
>>> On Sep 15, 2019, at 11:41 AM, Benjamin Coddington <
>>> bcodding@redhat.com> wrote:
>>>
>>> The GSS Message Integrity Check data for krb5i may lie partially in
>>> the XDR
>>> reply buffer's pages and tail.  If so, we try to copy the entire
>>> MIC into
>>> free space in the tail.  But as the estimations of the slack space
>>> required
>>> for authentication and verification have improved there may be less
>>> free
>>> space in the tail to complete this copy -- see commit 2c94b8eca1a2
>>> ("SUNRPC: Use au_rslack when computing reply buffer size").  In
>>> fact, there
>>> may only be room in the tail for a single copy of the MIC, and not
>>> part of
>>> the MIC and then another complete copy.
>>>
>>> The real world failure reported is that `ls` of a directory on NFS
>>> may
>>> sometimes return -EIO, which can be traced back to
>>> xdr_buf_read_netobj()
>>> failing to find available free space in the tail to copy the MIC.
>>>
>>> Fix this by checking for the case of the MIC crossing the
>>> boundaries of
>>> head, pages, and tail. If so, shift the buffer until the MIC is
>>> contained
>>> completely within the pages or tail.  This allows the remainder of
>>> the
>>> function to create a sub buffer that directly address the complete
>>> MIC.
>>>
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>> Cc: stable@vger.kernel.org # v5.1
>>> ---
>>> net/sunrpc/xdr.c | 32 +++++++++++++++++++-------------
>>> 1 file changed, 19 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>> index 48c93b9e525e..a29ce73c3029 100644
>>> --- a/net/sunrpc/xdr.c
>>> +++ b/net/sunrpc/xdr.c
>>> @@ -1237,16 +1237,29 @@ xdr_encode_word(struct xdr_buf *buf,
>>> unsigned int base, u32 obj)
>>> EXPORT_SYMBOL_GPL(xdr_encode_word);
>>>
>>> /* If the netobj starting offset bytes from the start of xdr_buf is
>>> contained
>>> - * entirely in the head or the tail, set object to point to it;
>>> otherwise
>>> - * try to find space for it at the end of the tail, copy it there,
>>> and
>>> - * set obj to point to it. */
>>> + * entirely in the head, pages, or tail, set object to point to
>>> it; otherwise
>>> + * shift the buffer until it is contained entirely within the
>>> pages or tail.
>>> + */
>>> int xdr_buf_read_netobj(struct xdr_buf *buf, struct xdr_netobj
>>> *obj, unsigned int offset)
>>> {
>>> 	struct xdr_buf subbuf;
>>> +	unsigned int boundary;
>>>
>>> 	if (xdr_decode_word(buf, offset, &obj->len))
>>> 		return -EFAULT;
>>> -	if (xdr_buf_subsegment(buf, &subbuf, offset + 4, obj->len))
>>> +	offset += 4;
>>> +
>>> +	/* Is the obj partially in the head? */
>>> +	boundary = buf->head[0].iov_len;
>>> +	if (offset < boundary && (offset + obj->len) > boundary)
>>> +		xdr_shift_buf(buf, boundary - offset);
>>> +
>>> +	/* Is the obj partially in the pages? */
>>> +	boundary += buf->page_len;
>>> +	if (offset < boundary && (offset + obj->len) > boundary)
>>> +		xdr_shrink_pagelen(buf, boundary - offset);
>>> +
>>> +	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
>>> 		return -EFAULT;
>>>
>>> 	/* Is the obj contained entirely in the head? */
>>> @@ -1258,17 +1271,10 @@ int xdr_buf_read_netobj(struct xdr_buf
>>> *buf, struct xdr_netobj *obj, unsigned in
>>> 	if (subbuf.tail[0].iov_len == obj->len)
>>> 		return 0;
>>>
>>> -	/* use end of tail as storage for obj:
>>> -	 * (We don't copy to the beginning because then we'd have
>>> -	 * to worry about doing a potentially overlapping copy.
>>> -	 * This assumes the object is at most half the length of the
>>> -	 * tail.) */
>>> +	/* obj is in the pages: move to end of the tail */
>>
>> How about "/* Find a contiguous area in @buf to hold all of @obj */"
>> ?
>>
>>> 	if (obj->len > buf->buflen - buf->len)
>>> 		return -ENOMEM;
>>> -	if (buf->tail[0].iov_len != 0)
>>> -		obj->data = buf->tail[0].iov_base + buf-
>>>> tail[0].iov_len;
>>> -	else
>>> -		obj->data = buf->head[0].iov_base + buf-
>>>> head[0].iov_len;
>>> +	obj->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
>>
>> Your new code assumes that when krb5i is in use, the upper layer will
>> always provide a non-NULL tail->iov_len. I wouldn't swear that will
>> always be true: The reason for the "if (buf->tail[0].iov_len)" check is
>> to see whether the upper layer indeed has set up a tail. iov_len will be
>> non-zero only when the upper layer has provided a tail buffer.

Alright.. I'll bring the test back on v3.

> For the case where we only have kvec data, then xdr_buf_init() assigns
> all the allocated buffer to the header, so the mic should be
> contiguously buffered there.
>
> If we have page data, then the fact that auth->au_rslack > auth-
>> au_ralign should ensure that we have allocated a sufficiently large
> tail buffer (see rpc_prepare_reply_pages()).
>
> BTW: this also means we should really only need to move the mic in the
> case where buf->page_len != 0.
> It also means that we should probably change xdr_inline_pages() to be a
> static function, since the assumption above fails if the user does not
> call rpc_prepare_reply_pages() in order to calculate the header
> alignment correctly.

Sounds like a third patch would make this series even better..  thanks for
the review and advice!  I'll send a v3 with Chuck's suggestions this morning
and put the optimizations Trond would like to see together in a third patch
when I have some slack time.

Ben

