Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA0FE05A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 15:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKOOoa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 09:44:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41852 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfKOOoa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 09:44:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFEfaDn040539;
        Fri, 15 Nov 2019 14:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=9XgTBhi6VXi+b8BJbHoKDiaXCYQhL/ejKJUGKAaJ6TY=;
 b=l3kfPXzuSILlU1O21fVewinDn4kLcNbCrLXqSomruttdXtvDuqCler31aZnC81LYO3dI
 nBMMJhRnoZ06K1ti45EjLNCIGFJ6c4+PQY7hfDJpsvxdUoL7mXFv4l+BaCpUoIpXGxaV
 hbOp0cFeNpjzXqUMcop8CYk2SwuMpwuyKPildN9cgwPaZLgBFuoPprSc65K+BKn7GS1v
 BqZWim1h4xT6fjqW/Rz7YOURhrilF6oqYrmgpJqsSHre8YxpfdOECZb3F9K8Jb0pfDGw
 y0QGFoDo4KS+grHLarBJeMtsFBzmVy5dXIoveQ5kBzajRc3neJQQlJuP+AhrmyAPONoE Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w9gxpkns1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 14:44:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFEcu7J092952;
        Fri, 15 Nov 2019 14:44:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2w9h14tqd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 14:44:18 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFEiHD6022327;
        Fri, 15 Nov 2019 14:44:17 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 06:44:17 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] SUNRPC: Fix another issue with MIC buffer space
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <F23BF77A-5CB4-455F-8F23-C92EE2AB5212@oracle.com>
Date:   Fri, 15 Nov 2019 09:44:15 -0500
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <29A5981F-5109-489E-913E-B80B6252B115@oracle.com>
References: <20191115133907.15900.51854.stgit@manet.1015granger.net>
 <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
 <F23BF77A-5CB4-455F-8F23-C92EE2AB5212@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150134
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 15, 2019, at 9:41 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>=20
>> On Nov 15, 2019, at 9:35 AM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>=20
>> On 15 Nov 2019, at 8:39, Chuck Lever wrote:
>>=20
>>> xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
>>> This can happen when xdr_buf_read_mic() is given an xdr_buf with
>>> a small page array (like, only a few bytes).
>>=20
>> Hi Chuck,
>>=20
>> Seems like a bug in xdr_buf_read_mic to me, but I'm not seeing how =
this can
>> happen.. unless perhaps xdr->page_len is 0?  Or maybe xdr_shift_buf =
has bug?
>=20
> rpc_prepare_reply_pages() sets buf->page_len to the args->count of the
> NFS READ request. For really small READs, this can be 2, or 12, or
> anything smaller than the MIC length.
>=20
>=20
>> I'd prefer to keep the BUG_ON.
>=20
> Linus would prefer not to. :-)
>=20
>=20
>> How can I reproduce it?
>=20
> I've been using the git regression suite with NFSv4.1 and krb5i.
> I run it with 12 threads.

And I enable disconnect injection. Yer basic torture test.


>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 14ba9e72a204..71d754fc780e 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -1262,6 +1262,8 @@ int xdr_buf_read_mic(struct xdr_buf *buf, =
struct xdr_netobj *mic, unsigned int o
>>       if (offset < boundary && (offset + mic->len) > boundary)
>>               xdr_shift_buf(buf, boundary - offset);
>>=20
>> +       trace_printk("boundary %d, offset %d, page_len %d\n", =
boundary, offset, buf->page_len);
>> +
>>       /* Is the mic partially in the pages? */
>>       boundary +=3D buf->page_len;
>>       if (offset < boundary && (offset + mic->len) > boundary)
>>=20
>> ^^ that should be enough for me to try to figure out what's doing =
wrong.
>>=20
>> Ben
>>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



