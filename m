Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61F2FE406
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 18:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKORcE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 12:32:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727543AbfKORcE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 12:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573839123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQAt2lGnekr8ZA6obzci3jo0mhliDAB2yi6OsaOXEIo=;
        b=NEIFtiOUk/ReTqfAzyWjr5TZ2bzIcZ4MRdMfq+ybcL1k/w40QTkb6Nh0JUDAtHPzJV5uyQ
        FzxNt59744cX9Oy+fAwNAYxraVE+x/CcmqNDDmv7I5LUE5TU8DhoNV+MjNuhFx3oyl+JWb
        jIdrppCAshtn9TE1XispyYvR9SmYlJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-51CchbhbNQS4FKFi3tN9Ew-1; Fri, 15 Nov 2019 12:32:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24EE8800EBE;
        Fri, 15 Nov 2019 17:31:59 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA17966835;
        Fri, 15 Nov 2019 17:31:58 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix another issue with MIC buffer space
Date:   Fri, 15 Nov 2019 12:31:57 -0500
Message-ID: <99C786EA-C025-4A2D-A007-572786C8BC67@redhat.com>
In-Reply-To: <D8E4C6F0-FBEC-46D8-9202-96F9530D445E@oracle.com>
References: <20191115133907.15900.51854.stgit@manet.1015granger.net>
 <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
 <D8E4C6F0-FBEC-46D8-9202-96F9530D445E@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 51CchbhbNQS4FKFi3tN9Ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; format=flowed; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15 Nov 2019, at 10:51, Chuck Lever wrote:

>> On Nov 15, 2019, at 9:35 AM, Benjamin Coddington=20
>> <bcodding@redhat.com> wrote:
>>
>> On 15 Nov 2019, at 8:39, Chuck Lever wrote:
>>
>>> xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
>>> This can happen when xdr_buf_read_mic() is given an xdr_buf with
>>> a small page array (like, only a few bytes).
>>
>> Hi Chuck,
>>
>> Seems like a bug in xdr_buf_read_mic to me, but I'm not seeing how=20
>> this can
>> happen.. unless perhaps xdr->page_len is 0?  Or maybe xdr_shift_buf=20
>> has bug?
>>
>> I'd prefer to keep the BUG_ON.  How can I reproduce it?
>>
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 14ba9e72a204..71d754fc780e 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -1262,6 +1262,8 @@ int xdr_buf_read_mic(struct xdr_buf *buf,=20
>> struct xdr_netobj *mic, unsigned int o
>>        if (offset < boundary && (offset + mic->len) > boundary)
>>                xdr_shift_buf(buf, boundary - offset);
>>
>> +       trace_printk("boundary %d, offset %d, page_len %d\n",=20
>> boundary, offset, buf->page_len);
>> +
>
> Btw, I did some troubleshooting with a printk in here a couple days=20
> ago:
>
> xdr_buf_read_mic: offset=3D136 boundary=3D142 buf->page_len=3D2

Ok, I see..  Your fix makes sense to me now, not much that=20
xdr_buf_read_mic
can do about it, and we get rid of another BUG_ON site.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

BTW that git regression test with disconnect injection is .. mean.  I
haven't hit the BUG_ON yet, but lots of:

[  171.770148] BUG: unable to handle page fault for address:=20
ffff8880af767986
[  171.771752] #PF: supervisor read access in kernel mode
[  171.772552] #PF: error_code(0x0000) - not-present page
[  171.780214] RIP: 0010:kmem_cache_alloc+0x66/0x2d0

Ben

