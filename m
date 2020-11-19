Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107FA2B94AB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Nov 2020 15:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgKSOcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 09:32:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55232 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgKSOcE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Nov 2020 09:32:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJEOaBA119297;
        Thu, 19 Nov 2020 14:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=oMpiwxKVNfLdH1qxpf9A/rN0fFqqRP0yDDb/OgBMWVU=;
 b=irBBfunHKRqqsY76mmOQdXzVCwb3ci9jOmmiu+CkK09wL7moJ4T5KvB9meaKe2S+a3Oz
 KHxWZMYLSZq9rHYZXxRJH7YytEWbcBdQoIfe1BZYwic2wIEAv8YXFz+H34AEr9f3p0pH
 uGvo9dBpskPtrTdqoIfQy3FYi9RFk6pK2yWOwAnIrFduqCx7Yccpf9pC+HSZ7LhEihNT
 huxot2B4pyKp0TVzXhboYqMvr+XkcvZ9icjzlp0WrhjyUef/JOmrngnQP/OeCF4OPxdU
 NcS+Q1jgrfZOd9XJZNb4+8vYwrRkFITJFe383jkqDTTCAsLUDaMtV7yhxgxTIZrvevLt 2w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34t76m5nnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 14:32:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJEPh66039436;
        Thu, 19 Nov 2020 14:32:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34uspw8c60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 14:31:59 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AJEVvpY030999;
        Thu, 19 Nov 2020 14:31:58 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 06:31:57 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <57b085d32f624986412770d10cc4daa8211ee0f4.camel@hammerspace.com>
Date:   Thu, 19 Nov 2020 09:31:56 -0500
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D322F599-E680-4715-AD9A-CC6017AFF8E0@oracle.com>
References: <20201118221939.20715-1-trondmy@kernel.org>
 <20201118221939.20715-2-trondmy@kernel.org>
 <20201118221939.20715-3-trondmy@kernel.org>
 <42FFB4EC-5E31-4002-92FC-7CA329479D78@oracle.com>
 <57b085d32f624986412770d10cc4daa8211ee0f4.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190109
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 19, 2020, at 9:30 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Thu, 2020-11-19 at 09:17 -0500, Chuck Lever wrote:
>>=20
>>=20
>>> On Nov 18, 2020, at 5:19 PM, trondmy@kernel.org wrote:
>>>=20
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> When doing a read() into a page, we also don't care if the nul
>>> padding
>>> stays in that last page when the data length is not 32-bit aligned.
>>=20
>> What if the READ payload lands in the middle of a file? The
>> pad on the end will overwrite file content just past where
>> the READ payload lands.
>=20
> If the size > buf->page_len, then it gets truncated in
> xdr_align_pages() afaik.

I will need to check how RPC/RDMA behaves. It might build a
chunk that includes the pad in this case, which would break
things.



>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> fs/nfs/nfs2xdr.c | 2 +-
>>> fs/nfs/nfs3xdr.c | 2 +-
>>> fs/nfs/nfs4xdr.c | 2 +-
>>> 3 files changed, 3 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
>>> index db9c265ad9e1..468bfbfe44d7 100644
>>> --- a/fs/nfs/nfs2xdr.c
>>> +++ b/fs/nfs/nfs2xdr.c
>>> @@ -102,7 +102,7 @@ static int decode_nfsdata(struct xdr_stream
>>> *xdr, struct nfs_pgio_res *result)
>>>         if (unlikely(!p))
>>>                 return -EIO;
>>>         count =3D be32_to_cpup(p);
>>> -       recvd =3D xdr_read_pages(xdr, count);
>>> +       recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
>>>         if (unlikely(count > recvd))
>>>                 goto out_cheating;
>>> out:
>>> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
>>> index d3e1726d538b..8ef7c961d3e2 100644
>>> --- a/fs/nfs/nfs3xdr.c
>>> +++ b/fs/nfs/nfs3xdr.c
>>> @@ -1611,7 +1611,7 @@ static int decode_read3resok(struct
>>> xdr_stream *xdr,
>>>         ocount =3D be32_to_cpup(p++);
>>>         if (unlikely(ocount !=3D count))
>>>                 goto out_mismatch;
>>> -       recvd =3D xdr_read_pages(xdr, count);
>>> +       recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
>>>         if (unlikely(count > recvd))
>>>                 goto out_cheating;
>>> out:
>>> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
>>> index 755b556e85c3..5baa767106dc 100644
>>> --- a/fs/nfs/nfs4xdr.c
>>> +++ b/fs/nfs/nfs4xdr.c
>>> @@ -5202,7 +5202,7 @@ static int decode_read(struct xdr_stream
>>> *xdr, struct rpc_rqst *req,
>>>                 return -EIO;
>>>         eof =3D be32_to_cpup(p++);
>>>         count =3D be32_to_cpup(p);
>>> -       recvd =3D xdr_read_pages(xdr, count);
>>> +       recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
>>>         if (count > recvd) {
>>>                 dprintk("NFS: server cheating in read reply: "
>>>                                 "count %u > recvd %u\n", count,
>>> recvd);
>>> --=20
>>> 2.28.0
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



