Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9EB2B97B6
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Nov 2020 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKSQVT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 11:21:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56020 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbgKSQVS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Nov 2020 11:21:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJG3u1t024335;
        Thu, 19 Nov 2020 16:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=5fQw68JjIgh6po+X6f+bd3lx2nnVXucbgkv6R8gtKY8=;
 b=bZZ4I0HGWOikUa0B7RJsR745p07VlSMnq/yKhGHKoE9Muly4rTWEJY6ub7/JEnAME6rP
 lrfFpNF0pGmRlGpVH277rIJMDvg4/xmKk+SpkG298kJJBzsnuVgk3G6OzQBJ6wGDdb7k
 GbKBrBEtZMeEFTMa92KFQoRw0+KxjDzTf9J2Tn4cTvM1rPkELE+K97Vme3Ec6wIyJznX
 v9YPBb+si27IYIjriYnjqAGwKNi6fnOqZr+BoOHmhd+T5Qpoig/v58wfGaCsdSo+zXXd
 1nhqSJ43XD+VqzYSbkUKLc1KWoR+R9ALmUwYfd9U2GZtiIAbgm2GIIEOcKwO/ZHJ8Pyc 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vne91v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 16:21:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJG5hPc185522;
        Thu, 19 Nov 2020 16:19:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34uspwc931-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 16:19:11 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AJGJ62N021969;
        Thu, 19 Nov 2020 16:19:06 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 08:19:06 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
Date:   Thu, 19 Nov 2020 11:19:05 -0500
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 19, 2020, at 10:09 AM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> On Thu, Nov 19, 2020 at 9:37 AM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hi Olga-
>>=20
>>> On Nov 18, 2020, at 4:44 PM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> The first problem I found was from 5.10-rc3 testing was from the =
fact
>>> that tail's iov_len was set to -4 and reply_chunk was trying to call
>>> rpcrdma_convert_kvec() for a tail that didn't exist.
>>>=20
>>> Do you see issues with this fix?
>>>=20
>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>> index 71e03b930b70..2e6a228abb95 100644
>>> --- a/net/sunrpc/xdr.c
>>> +++ b/net/sunrpc/xdr.c
>>> @@ -193,7 +193,7 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned =
int offset,
>>>=20
>>>       tail->iov_base =3D buf + offset;
>>>       tail->iov_len =3D buflen - offset;
>>> -       if ((xdr->page_len & 3) =3D=3D 0)
>>> +       if ((xdr->page_len & 3) =3D=3D 0 && tail->iov_len)
>>>               tail->iov_len -=3D sizeof(__be32);
>>>=20
>>>       xdr->buflen +=3D len;
>>=20
>> It's not clear to me whether only the listxattrs encoder is
>> not providing a receive tail kvec, or whether all the encoders
>> fail to provide a tail in this case.
>=20
> There is nothing specific that listxattr does, it just calls
> rpc_prepare_pages(). Isn't tail[0] always there (xdr_buf structure has
> tail[1] defined)?

Flip the question on its head: Why does xdr_inline_pages() work
fine for all the other operations? That suggests the problem is
with listxattrs, not with generic code.


> But not all requests have data in the page. So as
> far as I understand, tail->iov_len can be 0 so not checking for it is
> wrong.

The full context of the tail logic is:

 194         tail->iov_base =3D buf + offset;
 195         tail->iov_len =3D buflen - offset;
 196         if ((xdr->page_len & 3) =3D=3D 0)
 197                 tail->iov_len -=3D sizeof(__be32);

tail->iov_len is set to buflen - offset right here. It should
/always/ be 4 or more. We can ensure that because the input
to this function is always provided by another kernel function
(in other words, we control all the callers).

Why is buflen =3D=3D offset for listxattrs? 6c2190b3fcbc ("NFS:
Fix listxattr receive buffer size") is trying to ensure
tail->iov_len is not zero -- that the math here gives us a
positive value every time.

In nfs4_xdr_enc_listxattrs() we have:

1529         rpc_prepare_reply_pages(req, args->xattr_pages, 0, =
args->count,
1530             hdr.replen);

hdr.replen is set to NFS4_dec_listxattrs_sz.

_nfs42_proc_listxattrs() sets args->count.

I suspect the problem is the way _nfs42_proc_listxattrs() is
computing the length of xattr_pages. It includes the trailing
EOF boolean, but so does the decode_listxattrs_maxsz macro,
for instance.

We need head->iov_len to always be one XDR_UNIT larger than
the position where the xattr_pages array starts. Then the
math in xdr_inline_pages() will work correctly. (sidebar:
perhaps the documenting comment for xdr_inline_pages() should
explain that assumption).

So, now I agree with the assessment that 6c2190b3fcbc ("NFS:
Fix listxattr receive buffer size") is probably not adequate.
There is another subtlety to address in the way that
_nfs42_proc_listxattrs() computes args->count.


--
Chuck Lever



