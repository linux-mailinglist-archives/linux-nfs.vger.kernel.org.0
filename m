Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8860FE082
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKOOvz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 09:51:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46682 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727380AbfKOOvz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 09:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573829514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZ6Fit2VBApyaOOfD/FEUIcUW84RaijRoYQ6KmvWIg0=;
        b=JoqnOzk7vAFoTzrfgEfQCpEkjQ8Of48s/YNstVq7vXxrFWeLnkA8ZoY4TwmI2pkTSAsOXK
        +d/+teC++wc8koe72rUUp/vy6f3j1tNOj2dSqJco1/oHwkQ07bHmjzlYpIMxWU3gc27/ul
        EdDBgp1eMf6LpHHPFk6fm4HFBIY5XfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-VNPjn0vmO7KjHDMnstj-Pw-1; Fri, 15 Nov 2019 09:51:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 605B0911F9;
        Fri, 15 Nov 2019 14:51:50 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAFAF6049E;
        Fri, 15 Nov 2019 14:51:49 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix another issue with MIC buffer space
Date:   Fri, 15 Nov 2019 09:51:47 -0500
Message-ID: <123CB75B-F40C-45C4-9754-1C825782E4A3@redhat.com>
In-Reply-To: <29A5981F-5109-489E-913E-B80B6252B115@oracle.com>
References: <20191115133907.15900.51854.stgit@manet.1015granger.net>
 <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
 <F23BF77A-5CB4-455F-8F23-C92EE2AB5212@oracle.com>
 <29A5981F-5109-489E-913E-B80B6252B115@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: VNPjn0vmO7KjHDMnstj-Pw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; format=flowed; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15 Nov 2019, at 9:44, Chuck Lever wrote:

>> On Nov 15, 2019, at 9:41 AM, Chuck Lever <chuck.lever@oracle.com>=20
>> wrote:
>>
>>
>>
>>> On Nov 15, 2019, at 9:35 AM, Benjamin Coddington=20
>>> <bcodding@redhat.com> wrote:
>>>
>>> On 15 Nov 2019, at 8:39, Chuck Lever wrote:
>>>
>>>> xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
>>>> This can happen when xdr_buf_read_mic() is given an xdr_buf with
>>>> a small page array (like, only a few bytes).
>>>
>>> Hi Chuck,
>>>
>>> Seems like a bug in xdr_buf_read_mic to me, but I'm not seeing how=20
>>> this can
>>> happen.. unless perhaps xdr->page_len is 0?  Or maybe xdr_shift_buf=20
>>> has bug?
>>
>> rpc_prepare_reply_pages() sets buf->page_len to the args->count of=20
>> the
>> NFS READ request. For really small READs, this can be 2, or 12, or
>> anything smaller than the MIC length.
>>
>>
>>> I'd prefer to keep the BUG_ON.
>>
>> Linus would prefer not to. :-)

Ahh..

>>
>>
>>> How can I reproduce it?
>>
>> I've been using the git regression suite with NFSv4.1 and krb5i.
>> I run it with 12 threads.
>
> And I enable disconnect injection. Yer basic torture test.

Thanks.. I'll try.

Ben

