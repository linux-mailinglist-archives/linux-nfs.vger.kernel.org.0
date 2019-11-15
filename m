Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A01FE484
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 19:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOSFH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 13:05:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726822AbfKOSFE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 13:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573841103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4NSu9fcSk+4i34MM/JLdONHiXuE7K6JoO/b0V7Ke78=;
        b=A3Qy07u7oLaJn6/wuDr421rcAQE2rDi1c0ppVWUKt2MyPONYDlb3MXhphN/w2p7XRykAAO
        Kc5m8dfQD1QVAi/EMVi75YcBEJQeGogZ4/6jr2nNQpRgKqxpmbUXsxAln+RZh6xPUQcUyE
        u+Q5XZ+sQzgafzWzXcVp10NkUApv16Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-4w3nXvyFPQSp-q-350xaHw-1; Fri, 15 Nov 2019 13:05:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51AF1107ACC4;
        Fri, 15 Nov 2019 18:05:00 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5F1766835;
        Fri, 15 Nov 2019 18:04:59 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix another issue with MIC buffer space
Date:   Fri, 15 Nov 2019 13:04:57 -0500
Message-ID: <B4C70AB1-EE4D-4617-848B-95FAB6E1BC01@redhat.com>
In-Reply-To: <69CB4030-2D3C-4AE6-BDA7-053EBA5D21A8@oracle.com>
References: <20191115133907.15900.51854.stgit@manet.1015granger.net>
 <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
 <D8E4C6F0-FBEC-46D8-9202-96F9530D445E@oracle.com>
 <99C786EA-C025-4A2D-A007-572786C8BC67@redhat.com>
 <69CB4030-2D3C-4AE6-BDA7-053EBA5D21A8@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4w3nXvyFPQSp-q-350xaHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; format=flowed; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15 Nov 2019, at 12:34, Chuck Lever wrote:

>> On Nov 15, 2019, at 12:31 PM, Benjamin Coddington=20
>> <bcodding@redhat.com> wrote:
>>
>> On 15 Nov 2019, at 10:51, Chuck Lever wrote:
>>
>>>> On Nov 15, 2019, at 9:35 AM, Benjamin Coddington=20
>>>> <bcodding@redhat.com> wrote:
>>>>
>>>> On 15 Nov 2019, at 8:39, Chuck Lever wrote:
>>>>
>>>>> xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
>>>>> This can happen when xdr_buf_read_mic() is given an xdr_buf with
>>>>> a small page array (like, only a few bytes).
>>>>
>>>> Hi Chuck,
>>>>
>>>> Seems like a bug in xdr_buf_read_mic to me, but I'm not seeing how=20
>>>> this can
>>>> happen.. unless perhaps xdr->page_len is 0?  Or maybe xdr_shift_buf=20
>>>> has bug?
>>>>
>>>> I'd prefer to keep the BUG_ON.  How can I reproduce it?
>>>>
>>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>>> index 14ba9e72a204..71d754fc780e 100644
>>>> --- a/net/sunrpc/xdr.c
>>>> +++ b/net/sunrpc/xdr.c
>>>> @@ -1262,6 +1262,8 @@ int xdr_buf_read_mic(struct xdr_buf *buf,=20
>>>> struct xdr_netobj *mic, unsigned int o
>>>>       if (offset < boundary && (offset + mic->len) > boundary)
>>>>               xdr_shift_buf(buf, boundary - offset);
>>>>
>>>> +       trace_printk("boundary %d, offset %d, page_len %d\n",=20
>>>> boundary, offset, buf->page_len);
>>>> +
>>>
>>> Btw, I did some troubleshooting with a printk in here a couple days=20
>>> ago:
>>>
>>> xdr_buf_read_mic: offset=3D136 boundary=3D142 buf->page_len=3D2
>>
>> Ok, I see..  Your fix makes sense to me now, not much that=20
>> xdr_buf_read_mic
>> can do about it, and we get rid of another BUG_ON site.
>>
>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
> Thanks!
>
>
>> BTW that git regression test with disconnect injection is .. mean.  I
>> haven't hit the BUG_ON yet, but lots of:
>>
>> [  171.770148] BUG: unable to handle page fault for address:=20
>> ffff8880af767986
>> [  171.771752] #PF: supervisor read access in kernel mode
>> [  171.772552] #PF: error_code(0x0000) - not-present page
>> [  171.780214] RIP: 0010:kmem_cache_alloc+0x66/0x2d0
>
> !!! haven't seen that one. (I'm on NFS/RDMA. Should I try TCP, or
> just let you chase this one down?)

It is TCP.  Looks like I just grabbed Trond's master branch, and it is=20
at a
bit of a random place in between lost of merges.. somewhere after=20
5.4-rc6.
Let me retry with something tagged.

Ben

