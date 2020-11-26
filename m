Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F372C5A41
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Nov 2020 18:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404000AbgKZRKb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Nov 2020 12:10:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48608 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403996AbgKZRKa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Nov 2020 12:10:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AQH4gv1169139;
        Thu, 26 Nov 2020 17:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=D7+ChZCUQeEe/WZq8ri+PGNUf7TYx3TKXbTBhgkxLlY=;
 b=ofTclE0uOItTq3i3tMHTkAPfCu4enzMClfoAFWaf5lqRjRkotz4/yUgnfcHiUwnBC6SR
 Xnx4XAAH+ad4Y15bZwO3b3qOCu9mW9AqYolCGcxOE6LOGsHklUfVdhO2Cdv6Vv4uUYtb
 TtZEiKNvuVfkb1CSiWUk67FsHUSpGLrUvDstDKDA+YBxmwbq9mwk2XI8LmO981/4tuGv
 jeq0ezDIjdvZCqIM/3Rtql5jN+C4Asbg5r2+3wMkaJEN5+Z4G2GrMzmbdurUi1cbKhv5
 1HYXgd53EIOKk0pBXl9PkEBOLm5odSG1NQbAk5WMdcDQw8/oA40mEFILB8fJpWYcD1wK Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 351kwhes8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Nov 2020 17:10:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AQH69KV082356;
        Thu, 26 Nov 2020 17:10:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 351n2kfm97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 17:10:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AQHANXH001169;
        Thu, 26 Nov 2020 17:10:25 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Nov 2020 09:10:22 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new
 LISTXATTRS operation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201126002149.GA2339@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Thu, 26 Nov 2020 12:10:21 -0500
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B791B088-49C4-42F3-8721-A022027625D3@oracle.com>
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
 <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B1CF6271-B168-4571-B8E4-0CAB0A0B40FB@netapp.com>
 <20201124211926.GB14140@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <5571DE63-1276-4AF6-BB8F-EE36878B06E5@netapp.com>
 <20201126002149.GA2339@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 impostorscore=0
 suspectscore=2 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011260104
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 25, 2020, at 7:21 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Tue, Nov 24, 2020 at 10:40:25PM +0000, Kornievskaia, Olga wrote:
>>=20
>>=20
>> =EF=BB=BFOn 11/24/20, 4:20 PM, "Frank van der Linden" =
<fllinden@amazon.com> wrote:
>>=20
>>    On Tue, Nov 24, 2020 at 08:50:36PM +0000, Kornievskaia, Olga =
wrote:
>>>=20
>>>=20
>>> On 11/24/20, 3:06 PM, "Frank van der Linden" <fllinden@amazon.com> =
wrote:
>>>=20
>>>    On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
>>>>=20
>>>>=20
>>>>=20
>>>> By switching to an XFS-backed export, I am able to reproduce the
>>>> ibcomp worker crash on my client with xfstests generic/013.
>>>>=20
>>>> For the failing LISTXATTRS operation, xdr_inline_pages() is called
>>>> with page_len=3D12 and buflen=3D128. Then:
>>>>=20
>>>> - Because buflen is small, rpcrdma_marshal_req will not set up a
>>>>  Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
>>>>  get invoked at all.
>>>>=20
>>>> - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
>>>>  copy received data into rq_rcv_buf->pages, but they're missing.
>>>>=20
>>>> The result is that the ibcomp worker faults and dies. Sometimes =
that
>>>> causes a visible crash, and sometimes it results in a transport
>>>> hang without other symptoms.
>>>>=20
>>>> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
>>>> should eventually be fixed or replaced. However, my preference is
>>>> that upper-layer operations should explicitly allocate their =
receive
>>>> buffers (using GFP_KERNEL) when possible, rather than relying on
>>>> XDRBUF_SPARSE_PAGES.
>>>>=20
>>>> Reported-by: Olga kornievskaia <kolga@netapp.com>
>>>> Suggested-by: Olga kornievskaia <kolga@netapp.com>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> fs/nfs/nfs42proc.c |   17 ++++++++++-------
>>>> fs/nfs/nfs42xdr.c  |    1 -
>>>> 2 files changed, 10 insertions(+), 8 deletions(-)
>>>>=20
>>>> Hi-
>>>>=20
>>>> I like Olga's proposed approach. What do you think of this patch?
>>>>=20
>>>>=20
>>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>>> index 2b2211d1234e..24810305ec1c 100644
>>>> --- a/fs/nfs/nfs42proc.c
>>>> +++ b/fs/nfs/nfs42proc.c
>>>> @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct =
inode *inode, void *buf,
>>>>                .rpc_resp       =3D &res,
>>>>        };
>>>>        u32 xdrlen;
>>>> -       int ret, np;
>>>> +       int ret, np, i;
>>>>=20
>>>>=20
>>>>        res.scratch =3D alloc_page(GFP_KERNEL);
>>>> @@ -1253,10 +1253,14 @@ static ssize_t =
_nfs42_proc_listxattrs(struct inode *inode, void *buf,
>>>>                xdrlen =3D server->lxasize;
>>>>        np =3D xdrlen / PAGE_SIZE + 1;
>>>>=20
>>>> +       ret =3D -ENOMEM;
>>>>        pages =3D kcalloc(np, sizeof(struct page *), GFP_KERNEL);
>>>> -       if (pages =3D=3D NULL) {
>>>> -               __free_page(res.scratch);
>>>> -               return -ENOMEM;
>>>> +       if (pages =3D=3D NULL)
>>>> +               goto out_free;
>>>> +       for (i =3D 0; i < np; i++) {
>>>> +               pages[i] =3D alloc_page(GFP_KERNEL);
>>>> +               if (!pages[i])
>>>> +                       goto out_free;
>>>>        }
>>>>=20
>>>>        arg.xattr_pages =3D pages;
>>>> @@ -1271,14 +1275,13 @@ static ssize_t =
_nfs42_proc_listxattrs(struct inode *inode, void *buf,
>>>>                *eofp =3D res.eof;
>>>>        }
>>>>=20
>>>> +out_free:
>>>>        while (--np >=3D 0) {
>>>>                if (pages[np])
>>>>                        __free_page(pages[np]);
>>>>        }
>>>> -
>>>> -       __free_page(res.scratch);
>>>>        kfree(pages);
>>>> -
>>>> +       __free_page(res.scratch);
>>>>        return ret;
>>>>=20
>>>> }
>>>> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
>>>> index 6e060a88f98c..8432bd6b95f0 100644
>>>> --- a/fs/nfs/nfs42xdr.c
>>>> +++ b/fs/nfs/nfs42xdr.c
>>>> @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct =
rpc_rqst *req,
>>>>=20
>>>>        rpc_prepare_reply_pages(req, args->xattr_pages, 0, =
args->count,
>>>>            hdr.replen);
>>>> -       req->rq_rcv_buf.flags |=3D XDRBUF_SPARSE_PAGES;
>>>>=20
>>>>        encode_nops(&hdr);
>>>> }
>>>>=20
>>>>=20
>>>=20
>>>    I can see why this is the simplest and most pragmatic solution, =
so it's
>>>    fine with me.
>>>=20
>>>    Why doesn't this happen with getxattr? Do we need to convert that =
too?
>>>=20
>>> [olga] I don't know if GETXATTR/SETXATTR works. I'm not sure what =
tests exercise those operations. I just ran into the fact that =
generic/013 wasn't passing. And I don't see that it's an xattr specific =
tests. I'm not sure how it ends up triggering is usage of xattr.
>>=20
>>    I'm attaching the test program I used, it should give things a =
better workout.
>>=20
>> [olga] I'm not sure if I'm doing something wrong but there are only 2 =
GETXATTR call on the network trace from running this application and =
both calls are returning an error (ERR_NOXATTR). Which btw might explain =
why no problems are seen since no decoding of data is happening. There =
are lots of SETXATTRs and REMOVEXATTR and there is a LISTXATTR (which =
btw network trace is marking as malformed so there might something bad =
there). Anyway...
>>=20
>> This is my initial report: no real exercise of the GETXATTR code as =
far as I can tell.
>=20
> True, the test is heavier on the setxattr / listxattr side. And with =
caching,
> you're not going to see a lot of GETXATTR calls. I used the same test =
program
> with caching off, and it works fine, though.

I unintentionally broke GETXATTR while developing the LISTXATTRS fix,
and generic/013 rather aggressively informed me that GETXATTR was no
longer working. There is some test coverage there, fwiw.


> In any case, after converting GETXATTR to pre-allocate pages, I =
noticed that,
> when I disabled caching, I was getting EIO instead of ERANGE back from
> calls that test the case of calling getxattr() with a buffer length =
that
> is insufficient.

Was TCP the underlying RPC transport?


> The behavior is somewhat strange - if you, say, set an xattr
> of length 59, then calls with lengths 56-59 get -ERANGE from =
decode_getxattr
> (correct), but calls with lengths 53-55 get EIO (should be -ERANGE).
>=20
> E.g. non-aligned values to rpc_prepare_reply_pages make the RPC call =
error
> out early, even before it gets to decode_getxattr.
>=20
> I noticed that all other code always seems to specify multiples of =
PAGE_SIZE
> as the length to rpc_prepare_reply_pages. But the code itself suggests =
that
> it certainly *intends* to be prepared to handle any length, aligned or =
not.
>=20
> However, apparently, it at least doesn't deal with non-aligned =
lengths,
> making things fail further along down the line.
>=20
> I need to look at this a bit more.
>=20
> - Frank

--
Chuck Lever



