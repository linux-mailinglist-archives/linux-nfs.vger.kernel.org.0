Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4597418D5E3
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2020 18:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgCTRfB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Mar 2020 13:35:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTRfB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Mar 2020 13:35:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KHSPK8064634;
        Fri, 20 Mar 2020 17:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ncVwSE20Owf/ZD9hAMrWvNjFLfi7m57/SRYbAzXkz2g=;
 b=F/I9q55Il/K5SQlEBbH4ZRVYP7dJMqGOcdgeWxJs/tkwKiDY+By3tzhTrDTtLrNcEUF4
 jnot1VrEgueY3OcCd2x4NFU4ADOSk7LvHMtjR5iZZ5v2AC3zT1saVNSUCFNmVXTi2+za
 wyYf645c6yMXo44fOAk8dmyfccagdXPI5np1pfoQL+iX7V0F5tcYCzuR6wzxXmWy0Js3
 o6l07jF3avCZLWJW0a/aUELurTswYKjBBKFrZ6WIkWO2mRWXfi6jCThpgMX3K3o1mf+V
 jMM7VFAbmurldUVT/FxZdvVcqFiKiUHzGxmm063B2Yp+2NUa69+B9AU2jkfJ5F9t00vb SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yub27etg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 17:34:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KHRlpO113625;
        Fri, 20 Mar 2020 17:34:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ys92r4edd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 17:34:56 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02KHYtBI022213;
        Fri, 20 Mar 2020 17:34:55 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 10:34:54 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding
 logic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200320164737.GA19415@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Fri, 20 Mar 2020 13:34:53 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <65ACAC76-DBBE-42D3-ACED-AB2290D0FC31@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-12-fllinden@amazon.com>
 <6955728A-CFCC-40FC-9E02-671255EDD45F@oracle.com>
 <20200320164737.GA19415@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>,
        Bruce Fields <bfields@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200071
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 20, 2020, at 12:47 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> Hi Chuck,
>=20
> On Thu, Mar 12, 2020 at 03:16:37PM -0400, Chuck Lever wrote:
>>> +static __be32
>>> +nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
>>> +                   struct nfsd4_setxattr *setxattr)
>>> +{
>>> +     DECODE_HEAD;
>>> +     u32 flags, maxcount, size;
>>> +     struct kvec head;
>>> +     struct page **pagelist;
>>> +
>>> +     READ_BUF(4);
>>> +     flags =3D be32_to_cpup(p++);
>>> +
>>> +     if (flags > SETXATTR4_REPLACE)
>>> +             return nfserr_inval;
>>> +     setxattr->setxa_flags =3D flags;
>>> +
>>> +     status =3D nfsd4_decode_xattr_name(argp, =
&setxattr->setxa_name);
>>> +     if (status)
>>> +             return status;
>>> +
>>> +     maxcount =3D svc_max_payload(argp->rqstp);
>>> +     maxcount =3D min_t(u32, XATTR_SIZE_MAX, maxcount);
>>> +
>>> +     READ_BUF(4);
>>> +     size =3D be32_to_cpup(p++);
>>> +     if (size > maxcount)
>>> +             return nfserr_xattr2big;
>>> +
>>> +     setxattr->setxa_len =3D size;
>>> +     if (size > 0) {
>>> +             status =3D svcxdr_construct_vector(argp, &head, =
&pagelist, size);
>>> +             if (status)
>>> +                     return status;
>>> +
>>> +             status =3D nfsd4_vbuf_from_stream(argp, &head, =
pagelist,
>>> +                 &setxattr->setxa_buf, size);
>>> +     }
>>=20
>> Now I'm wondering if read_bytes_from_xdr_buf() might be adequate
>> for this purpose, so you can avoid open-coding all of this logic.
>=20
> This took a little longer, I had to check my notes,

Thanks for checking!

> but basically the reasons for doing it this way are:
>=20
> * The nfsd decode path uses nfsd4_compoundargs, which doesn't have an
>  xdr_stream (it has a page array). So read_bytes_from_xdr_buf isn't
>  a natural fit.
> * READ_BUF/read_buf don't deal with > PAGE_SIZE chunks, but xattrs may
>  be larger than that.
>=20
> The other code that deals with > PAGE_SIZE chunks is the write code. =
So,
> I factored out some code from the write code, used that, and added a =
function
> to process the resulting kvec / pagelist (nfs4_vbuf_from_stream).

Yes, I only recently discovered that the xdr_stream helpers do not
work for decoding data items that are page size or larger.

For the record, my IMA prototype takes this approach for decode_fattr:

+       if (bmval[2] & FATTR4_WORD2_IMA) {
+               READ_BUF(4);
+               len +=3D 4;
+               dummy32 =3D be32_to_cpup(p++);
+               READ_BUF(dummy32);
+               if (dummy32 > NFS4_MAXIMALEN)
+                       return nfserr_badlabel;
+               *ima =3D svcxdr_tmpalloc(argp, sizeof(**ima));
+               if (*ima =3D=3D NULL)
+                       return nfserr_jukebox;
+
+               len +=3D (XDR_QUADLEN(dummy32) << 2);
+               READMEM(buf, dummy32);
+               (*ima)->len =3D dummy32;
+               (*ima)->data =3D svcxdr_dupstr(argp, buf, dummy32);
+               if ((*ima)->data =3D=3D NULL)
+                       return nfserr_jukebox;
+       } else
+               ima =3D NULL;

Although, an IMA blob is never larger than a page, IIRC.

> There definitely seem to be several copy functions in both the client
> and server code that basically do the same, but in slightly different =
ways,
> depending on whether they use an XDR buf or not, whether the pages are
> mapped or not, etc. Seems like a good candidate for a cleanup, but I
> considered it to be out of scope for these patches.

"out of scope" - probably so. Depending on Bruce's thinking, we can
add this to the list of janitorial tasks.

For my peace of mind, "from_stream" implies there _is_ an xdr_stream
in use, even though the function does not have a struct xdr_stream
parameter. Perhaps a different naming scheme would be wise.


--
Chuck Lever



