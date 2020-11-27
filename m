Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A422C6A64
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgK0RGj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Nov 2020 12:06:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40972 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgK0RGj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Nov 2020 12:06:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ARGwqdu115931;
        Fri, 27 Nov 2020 17:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=oC8WGDcdi5iiPwssDUYhSQh/JSHXX9nT2XjMg3lPB2s=;
 b=JuGX00K/L+9rnYskFzal49dFm3kJKSbFO4uRslDFJ7F8mKJ8XcgvIWNzzWIUseuxC0St
 qv9cY21d6mNeniqWuE5yZo3mCBrdMqznr4qJvcmW4R6D9DnloTQCrKFccYRdpEPbeQM1
 MWvGC7sik/GoyHmV1ObM9/TpB6kRr6/x1ie7HhMLY/OGd8Zf2E5VqLEQ8HUqVNA69LCy
 fgHAnRgBlVueS8IKyK+UfYb76UVlXN4ELGXIxZ0I7MQt5nGI9CxCvt3sdxGerwwnax3t
 aum6vkoqWCuTC9d8qaM3tBlywMCFqdA4ydg1uv5o7xJpjkh4EagD72ibYsXANkMLjR1B GQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 351kwhj2nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 17:06:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ARH0D3Z173542;
        Fri, 27 Nov 2020 17:06:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 351n2mgb6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 17:06:34 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ARH6VBU021614;
        Fri, 27 Nov 2020 17:06:33 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Nov 2020 09:06:31 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new
 LISTXATTRS operation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201126193248.GA6578@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Fri, 27 Nov 2020 12:06:29 -0500
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DB9CE94-9946-44F5-845E-15E6D837BEC4@oracle.com>
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
 <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B1CF6271-B168-4571-B8E4-0CAB0A0B40FB@netapp.com>
 <20201124211926.GB14140@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <5571DE63-1276-4AF6-BB8F-EE36878B06E5@netapp.com>
 <20201126002149.GA2339@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B791B088-49C4-42F3-8721-A022027625D3@oracle.com>
 <20201126193248.GA6578@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=2 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270099
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 26, 2020, at 2:32 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Thu, Nov 26, 2020 at 12:10:21PM -0500, Chuck Lever wrote:
>>=20
>>=20
>>> On Nov 25, 2020, at 7:21 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>>>=20
>>> On Tue, Nov 24, 2020 at 10:40:25PM +0000, Kornievskaia, Olga wrote:
>>>>=20
>>>>=20
>>>> =EF=BB=BFOn 11/24/20, 4:20 PM, "Frank van der Linden" =
<fllinden@amazon.com> wrote:
>>>>=20
>>>>   On Tue, Nov 24, 2020 at 08:50:36PM +0000, Kornievskaia, Olga =
wrote:
>>>>>=20
>>>>>=20
>>>>> On 11/24/20, 3:06 PM, "Frank van der Linden" <fllinden@amazon.com> =
wrote:
>>>>>=20
>>>>>   On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> By switching to an XFS-backed export, I am able to reproduce the
>>>>>> ibcomp worker crash on my client with xfstests generic/013.
>>>>>>=20
>>>>>> For the failing LISTXATTRS operation, xdr_inline_pages() is =
called
>>>>>> with page_len=3D12 and buflen=3D128. Then:
>>>>>>=20
>>>>>> - Because buflen is small, rpcrdma_marshal_req will not set up a
>>>>>> Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
>>>>>> get invoked at all.
>>>>>>=20
>>>>>> - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
>>>>>> copy received data into rq_rcv_buf->pages, but they're missing.
>>>>>>=20
>>>>>> The result is that the ibcomp worker faults and dies. Sometimes =
that
>>>>>> causes a visible crash, and sometimes it results in a transport
>>>>>> hang without other symptoms.
>>>>>>=20
>>>>>> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, =
and
>>>>>> should eventually be fixed or replaced. However, my preference is
>>>>>> that upper-layer operations should explicitly allocate their =
receive
>>>>>> buffers (using GFP_KERNEL) when possible, rather than relying on
>>>>>> XDRBUF_SPARSE_PAGES.
>>>>>>=20
>>>>>> Reported-by: Olga kornievskaia <kolga@netapp.com>
>>>>>> Suggested-by: Olga kornievskaia <kolga@netapp.com>
>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>> ---
>>>>>> fs/nfs/nfs42proc.c |   17 ++++++++++-------
>>>>>> fs/nfs/nfs42xdr.c  |    1 -
>>>>>> 2 files changed, 10 insertions(+), 8 deletions(-)
>>>>>>=20
>>>>>> Hi-
>>>>>>=20
>>>>>> I like Olga's proposed approach. What do you think of this patch?
>>>>>>=20
>>>>>>=20
>>>>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>>>>> index 2b2211d1234e..24810305ec1c 100644
>>>>>> --- a/fs/nfs/nfs42proc.c
>>>>>> +++ b/fs/nfs/nfs42proc.c
>>>>>> @@ -1241,7 +1241,7 @@ static ssize_t =
_nfs42_proc_listxattrs(struct inode *inode, void *buf,
>>>>>>               .rpc_resp       =3D &res,
>>>>>>       };
>>>>>>       u32 xdrlen;
>>>>>> -       int ret, np;
>>>>>> +       int ret, np, i;
>>>>>>=20
>>>>>>=20
>>>>>>       res.scratch =3D alloc_page(GFP_KERNEL);
>>>>>> @@ -1253,10 +1253,14 @@ static ssize_t =
_nfs42_proc_listxattrs(struct inode *inode, void *buf,
>>>>>>               xdrlen =3D server->lxasize;
>>>>>>       np =3D xdrlen / PAGE_SIZE + 1;
>>>>>>=20
>>>>>> +       ret =3D -ENOMEM;
>>>>>>       pages =3D kcalloc(np, sizeof(struct page *), GFP_KERNEL);
>>>>>> -       if (pages =3D=3D NULL) {
>>>>>> -               __free_page(res.scratch);
>>>>>> -               return -ENOMEM;
>>>>>> +       if (pages =3D=3D NULL)
>>>>>> +               goto out_free;
>>>>>> +       for (i =3D 0; i < np; i++) {
>>>>>> +               pages[i] =3D alloc_page(GFP_KERNEL);
>>>>>> +               if (!pages[i])
>>>>>> +                       goto out_free;
>>>>>>       }
>>>>>>=20
>>>>>>       arg.xattr_pages =3D pages;
>>>>>> @@ -1271,14 +1275,13 @@ static ssize_t =
_nfs42_proc_listxattrs(struct inode *inode, void *buf,
>>>>>>               *eofp =3D res.eof;
>>>>>>       }
>>>>>>=20
>>>>>> +out_free:
>>>>>>       while (--np >=3D 0) {
>>>>>>               if (pages[np])
>>>>>>                       __free_page(pages[np]);
>>>>>>       }
>>>>>> -
>>>>>> -       __free_page(res.scratch);
>>>>>>       kfree(pages);
>>>>>> -
>>>>>> +       __free_page(res.scratch);
>>>>>>       return ret;
>>>>>>=20
>>>>>> }
>>>>>> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
>>>>>> index 6e060a88f98c..8432bd6b95f0 100644
>>>>>> --- a/fs/nfs/nfs42xdr.c
>>>>>> +++ b/fs/nfs/nfs42xdr.c
>>>>>> @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct =
rpc_rqst *req,
>>>>>>=20
>>>>>>       rpc_prepare_reply_pages(req, args->xattr_pages, 0, =
args->count,
>>>>>>           hdr.replen);
>>>>>> -       req->rq_rcv_buf.flags |=3D XDRBUF_SPARSE_PAGES;
>>>>>>=20
>>>>>>       encode_nops(&hdr);
>>>>>> }
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>>   I can see why this is the simplest and most pragmatic solution, =
so it's
>>>>>   fine with me.
>>>>>=20
>>>>>   Why doesn't this happen with getxattr? Do we need to convert =
that too?
>>>>>=20
>>>>> [olga] I don't know if GETXATTR/SETXATTR works. I'm not sure what =
tests exercise those operations. I just ran into the fact that =
generic/013 wasn't passing. And I don't see that it's an xattr specific =
tests. I'm not sure how it ends up triggering is usage of xattr.
>>>>=20
>>>>   I'm attaching the test program I used, it should give things a =
better workout.
>>>>=20
>>>> [olga] I'm not sure if I'm doing something wrong but there are only =
2 GETXATTR call on the network trace from running this application and =
both calls are returning an error (ERR_NOXATTR). Which btw might explain =
why no problems are seen since no decoding of data is happening. There =
are lots of SETXATTRs and REMOVEXATTR and there is a LISTXATTR (which =
btw network trace is marking as malformed so there might something bad =
there). Anyway...
>>>>=20
>>>> This is my initial report: no real exercise of the GETXATTR code as =
far as I can tell.
>>>=20
>>> True, the test is heavier on the setxattr / listxattr side. And with =
caching,
>>> you're not going to see a lot of GETXATTR calls. I used the same =
test program
>>> with caching off, and it works fine, though.
>>=20
>> I unintentionally broke GETXATTR while developing the LISTXATTRS fix,
>> and generic/013 rather aggressively informed me that GETXATTR was no
>> longer working. There is some test coverage there, fwiw.
>=20
> Oh, the coverage was good - in my testing I also used a collection of
> small unit test programs, and I was the one who made the xattr tests
> in xfstests work on NFS.
>=20
>>=20
>>=20
>>> In any case, after converting GETXATTR to pre-allocate pages, I =
noticed that,
>>> when I disabled caching, I was getting EIO instead of ERANGE back =
from
>>> calls that test the case of calling getxattr() with a buffer length =
that
>>> is insufficient.
>>=20
>> Was TCP the underlying RPC transport?
>=20
> Yes, this was TCP. I have set up rdma over rxe, which I'll test too if =
I
> can get this figured out. It might be a long standing bug in =
xdr_inline_pages,
> as listxattr / getxattr seem to be simply the first ones to pass in a
> length that is not page aligned.

Or your maxsz macro could be missing a "+ 1" for the XDR pad needed for
the unaligned length cases.


> It does make some sense to round the length up to PAGE_SIZE, and just =
check if
> the received data fits when decoding, like other calls do. It improves =
your
> chances of getting a result that you can still cache, even if it's too =
big for
> the length that was asked for. E.g. if the result is > =
requested_length, but
> < ROUND_UP(requested_length, PAGE_SIZE), you can cache it, even though =
you
> have to return -ERANGE to the caller.
>=20
> - Frank

--
Chuck Lever



