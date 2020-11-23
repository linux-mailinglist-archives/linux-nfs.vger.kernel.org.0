Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4572C0E72
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 16:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgKWPHo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 10:07:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35256 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731120AbgKWPHn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 10:07:43 -0500
X-Greylist: delayed 879 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 10:07:42 EST
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANEnEx2026508;
        Mon, 23 Nov 2020 14:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ED63SLbk7ZvnzOYI9i0kkLwBopq9I25oyeu4sNkgzDE=;
 b=ZvP7AljTmrjyup2ze3owVbx0UuIoEt2tZ4sQ1K1GmWu0RNhMQQietTNd/R47lfCeGXV9
 8bwQ0irgZ54XP0wufux9/UeeJfeWl7t5L2qT8E9My39A2b6Yu6zoHPqoWXGO1cDBbupp
 ecDDtcuFFyqsD6gPQIK9ikvvebq5onDeptZeZKVLtFXndbJaX+32L3RgrBgHTw7MZ0zS
 GzlvDXGQqxFkvO3WQD10f2BbEWsK3Ew19IxgsG+w39G0EOnvI+NMkJzPw1sd7oIyriAa
 rZ005BGSkvuT8ewvfFVicH0y9ZRucmanmNjXvUr8UXflOIj99R5CjUGLtjTjwG6eMI+6 gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 34xtaqh1yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 14:52:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANEnoPj173918;
        Mon, 23 Nov 2020 14:52:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ycnr0e7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 14:52:58 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ANEqsIF008950;
        Mon, 23 Nov 2020 14:52:57 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 06:52:54 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 5/8] SUNRPC: Don't truncate tail in xdr_inline_pages()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <614498c69c40421f8581fd8b25633e8668959581.camel@hammerspace.com>
Date:   Mon, 23 Nov 2020 09:52:53 -0500
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C120984-5A7B-4245-9B04-8E44C4370BC1@oracle.com>
References: <20201122205229.3826-1-trondmy@kernel.org>
 <20201122205229.3826-2-trondmy@kernel.org>
 <20201122205229.3826-3-trondmy@kernel.org>
 <20201122205229.3826-4-trondmy@kernel.org>
 <20201122205229.3826-5-trondmy@kernel.org>
 <20201122205229.3826-6-trondmy@kernel.org>
 <0CB9471F-ACC6-42A1-8DCD-8A9E74BAF8F1@oracle.com>
 <614498c69c40421f8581fd8b25633e8668959581.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9813 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9813 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230102
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 22, 2020, at 11:29 PM, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>=20
> On Sun, 2020-11-22 at 20:24 -0500, Chuck Lever wrote:
>>=20
>>=20
>>> On Nov 22, 2020, at 3:52 PM, trondmy@kernel.org wrote:
>>>=20
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> True that if the length of the pages[] array is not 4-byte aligned,
>>> then
>>> we will need to store the padding in the tail, but there is no need
>>> to
>>> truncate the total buffer length here.
>>=20
>> This description confuses me. The existing code reduces the length of
>> the tail, not the "total buffer length." And what the removed logic
>> is
>> doing is taking out the length of the XDR pad for the pages array
>> when
>> it is not expected to be used.
>=20
> Why are we bothering to do that? There is nothing problematic with =
just
> ignoring this test and leaving the tail length as it is, nor is there
> anything to be gained by applying it.

You are correct that leaving the buffer a little long is not going
to harm normal operation. After all, we lived with a wildly over-
estimated slack length for years.

The purpose of this code path is to prepare the receive buffer with
the memory resources and expected length of the Reply. The series
of patches that introduced this particular change was all about
ensuring that the estimated length of the reply message was exact.

If the reply message size is overestimated, that moves the end-of-
message sentinel that is later set by xdr_init_decode(). We then
miss subtle problems like our fixed size estimates are incorrect
or a man-in-the-middle is extending the RPC message or the server
is malfunctioning.

<scratches chin>

After moving the ->pages pad into ->pages, I'm wondering if you
should revert 02ef04e432ba ("NFS: Account for XDR pad of buf->pages") --
the maxsz macros don't need to account for the XDR pad of ->pages
any more. Then the below hunk makes sense. The patch description
still doesn't, though ;-)

And then you should confirm that we are still getting the receive
buffer size estimate right for krb5i and krb5p.


>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> net/sunrpc/xdr.c | 3 ---
>>> 1 file changed, 3 deletions(-)
>>>=20
>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>> index 3ce0a5daa9eb..5a450055469f 100644
>>> --- a/net/sunrpc/xdr.c
>>> +++ b/net/sunrpc/xdr.c
>>> @@ -193,9 +193,6 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned
>>> int offset,
>>>=20
>>>         tail->iov_base =3D buf + offset;
>>>         tail->iov_len =3D buflen - offset;
>>> -       if ((xdr->page_len & 3) =3D=3D 0)
>>> -               tail->iov_len -=3D sizeof(__be32);
>>> -
>>>         xdr->buflen +=3D len;
>>> }
>>> EXPORT_SYMBOL_GPL(xdr_inline_pages);
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



