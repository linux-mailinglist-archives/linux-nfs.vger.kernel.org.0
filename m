Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920F0FE40E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 18:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKORer (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 12:34:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56502 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKORer (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 12:34:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFHYhSi022345;
        Fri, 15 Nov 2019 17:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=9uIM+eQHxFnyAwyR51ACRuzsv+FlMD/oeWNASbqJAd4=;
 b=oVkf5uvcFhVtB6GL/rQpQOHDlnN/y/oDFBgdt5A5/crIzppp3IpV+lBAn9qspkpX7LI4
 QpxRgjs5kb6eDkRMFdpOoxMSlQjXmKLZ98X/zMy9OekPTjO+nFx0DCGN6+DBiuGRHPGQ
 DoqwLkjOW4sPOM2AftZp50F2PEnGm1Z16q8HO9cSybqcfqOZXMC0JUkpDEeLoHentx9l
 kpPot+E5baFl0fFSy3Ksbl7s4RF1V3oxRYbRWC6gnN2D5O1AQZeHsncl1mEBjDOtTGRQ
 6rkyNVa1521kJRxaAqqQzu7StUUqXhdamcjcapBvZ5B5pksGaccRmTzwK7IkD0JzaBJc Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w9gxpmn4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 17:34:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFHX3R8029060;
        Fri, 15 Nov 2019 17:34:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w9h0n78ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 17:34:42 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFHYfqM001679;
        Fri, 15 Nov 2019 17:34:41 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 09:34:41 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] SUNRPC: Fix another issue with MIC buffer space
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <99C786EA-C025-4A2D-A007-572786C8BC67@redhat.com>
Date:   Fri, 15 Nov 2019 12:34:40 -0500
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <69CB4030-2D3C-4AE6-BDA7-053EBA5D21A8@oracle.com>
References: <20191115133907.15900.51854.stgit@manet.1015granger.net>
 <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
 <D8E4C6F0-FBEC-46D8-9202-96F9530D445E@oracle.com>
 <99C786EA-C025-4A2D-A007-572786C8BC67@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9442 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9442 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150156
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 15, 2019, at 12:31 PM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>=20
> On 15 Nov 2019, at 10:51, Chuck Lever wrote:
>=20
>>> On Nov 15, 2019, at 9:35 AM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>=20
>>> On 15 Nov 2019, at 8:39, Chuck Lever wrote:
>>>=20
>>>> xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
>>>> This can happen when xdr_buf_read_mic() is given an xdr_buf with
>>>> a small page array (like, only a few bytes).
>>>=20
>>> Hi Chuck,
>>>=20
>>> Seems like a bug in xdr_buf_read_mic to me, but I'm not seeing how =
this can
>>> happen.. unless perhaps xdr->page_len is 0?  Or maybe xdr_shift_buf =
has bug?
>>>=20
>>> I'd prefer to keep the BUG_ON.  How can I reproduce it?
>>>=20
>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>> index 14ba9e72a204..71d754fc780e 100644
>>> --- a/net/sunrpc/xdr.c
>>> +++ b/net/sunrpc/xdr.c
>>> @@ -1262,6 +1262,8 @@ int xdr_buf_read_mic(struct xdr_buf *buf, =
struct xdr_netobj *mic, unsigned int o
>>>       if (offset < boundary && (offset + mic->len) > boundary)
>>>               xdr_shift_buf(buf, boundary - offset);
>>>=20
>>> +       trace_printk("boundary %d, offset %d, page_len %d\n", =
boundary, offset, buf->page_len);
>>> +
>>=20
>> Btw, I did some troubleshooting with a printk in here a couple days =
ago:
>>=20
>> xdr_buf_read_mic: offset=3D136 boundary=3D142 buf->page_len=3D2
>=20
> Ok, I see..  Your fix makes sense to me now, not much that =
xdr_buf_read_mic
> can do about it, and we get rid of another BUG_ON site.
>=20
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Thanks!


> BTW that git regression test with disconnect injection is .. mean.  I
> haven't hit the BUG_ON yet, but lots of:
>=20
> [  171.770148] BUG: unable to handle page fault for address: =
ffff8880af767986
> [  171.771752] #PF: supervisor read access in kernel mode
> [  171.772552] #PF: error_code(0x0000) - not-present page
> [  171.780214] RIP: 0010:kmem_cache_alloc+0x66/0x2d0

!!! haven't seen that one. (I'm on NFS/RDMA. Should I try TCP, or
just let you chase this one down?)


--
Chuck Lever



