Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB62C31D8
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 21:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgKXUTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 15:19:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55090 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKXUTB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 15:19:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOKITGb186650;
        Tue, 24 Nov 2020 20:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=OBXikVgJKKSnR0MDzorg3rOIvLKWIuDLvBBauYjrGxU=;
 b=dLwjRgt44oSql5S3CnhsBWqfIpeBENp3gSp2FNazRZMyJFlv7KRG10S57P0HtYt1AvFK
 jWvq9H7+Ytp9Q9SdYQtZKyGQ/QcXLdfbJLI7k7O2DCnqQ4qTzNb4ayclQ8fQbcJjECdP
 9liL4SJkFKIdz3gdLoc1kTvbobIemU6vKewZPlX1zsnuqGXsvX5enh7V3OcMfxlIAJGm
 5ucf1RnSOmkw91as6C8ROeWHm1f679OX3F2uf6Tx2dMmWTJBdb2Jz3k0ZLiESMaQCkSC
 YXyQfQLdO8I2RI8zhIS3d9dpGah3yShAi/zr71JFd3awhcMbSO/tcGHj1TTAG0nmpYTw NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3514q8hex0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 20:18:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOK9rwk134578;
        Tue, 24 Nov 2020 20:18:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ycnt0cyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 20:18:57 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AOKIuWq001855;
        Tue, 24 Nov 2020 20:18:56 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 12:18:56 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new
 LISTXATTRS operation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Tue, 24 Nov 2020 15:18:55 -0500
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10EFE633-374C-4BB1-8877-424579564C55@oracle.com>
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
 <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=2
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 mlxscore=0 suspectscore=2 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 24, 2020, at 3:06 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
>> CAUTION: This email originated from outside of the organization. Do =
not click links or open attachments unless you can confirm the sender =
and know the content is safe.
>>=20
>>=20
>>=20
>> By switching to an XFS-backed export, I am able to reproduce the
>> ibcomp worker crash on my client with xfstests generic/013.
>>=20
>> For the failing LISTXATTRS operation, xdr_inline_pages() is called
>> with page_len=3D12 and buflen=3D128. Then:
>>=20
>> - Because buflen is small, rpcrdma_marshal_req will not set up a
>>  Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
>>  get invoked at all.
>>=20
>> - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
>>  copy received data into rq_rcv_buf->pages, but they're missing.
>>=20
>> The result is that the ibcomp worker faults and dies. Sometimes that
>> causes a visible crash, and sometimes it results in a transport
>> hang without other symptoms.
>>=20
>> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
>> should eventually be fixed or replaced. However, my preference is
>> that upper-layer operations should explicitly allocate their receive
>> buffers (using GFP_KERNEL) when possible, rather than relying on
>> XDRBUF_SPARSE_PAGES.
>>=20
>> Reported-by: Olga kornievskaia <kolga@netapp.com>
>> Suggested-by: Olga kornievskaia <kolga@netapp.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfs/nfs42proc.c |   17 ++++++++++-------
>> fs/nfs/nfs42xdr.c  |    1 -
>> 2 files changed, 10 insertions(+), 8 deletions(-)
>>=20
>> Hi-
>>=20
>> I like Olga's proposed approach. What do you think of this patch?
>>=20
>>=20
>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>> index 2b2211d1234e..24810305ec1c 100644
>> --- a/fs/nfs/nfs42proc.c
>> +++ b/fs/nfs/nfs42proc.c
>> @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct =
inode *inode, void *buf,
>>                .rpc_resp       =3D &res,
>>        };
>>        u32 xdrlen;
>> -       int ret, np;
>> +       int ret, np, i;
>>=20
>>=20
>>        res.scratch =3D alloc_page(GFP_KERNEL);
>> @@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(struct =
inode *inode, void *buf,
>>                xdrlen =3D server->lxasize;
>>        np =3D xdrlen / PAGE_SIZE + 1;
>>=20
>> +       ret =3D -ENOMEM;
>>        pages =3D kcalloc(np, sizeof(struct page *), GFP_KERNEL);
>> -       if (pages =3D=3D NULL) {
>> -               __free_page(res.scratch);
>> -               return -ENOMEM;
>> +       if (pages =3D=3D NULL)
>> +               goto out_free;
>> +       for (i =3D 0; i < np; i++) {
>> +               pages[i] =3D alloc_page(GFP_KERNEL);
>> +               if (!pages[i])
>> +                       goto out_free;
>>        }
>>=20
>>        arg.xattr_pages =3D pages;
>> @@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(struct =
inode *inode, void *buf,
>>                *eofp =3D res.eof;
>>        }
>>=20
>> +out_free:
>>        while (--np >=3D 0) {
>>                if (pages[np])
>>                        __free_page(pages[np]);
>>        }
>> -
>> -       __free_page(res.scratch);
>>        kfree(pages);
>> -
>> +       __free_page(res.scratch);
>>        return ret;
>>=20
>> }
>> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
>> index 6e060a88f98c..8432bd6b95f0 100644
>> --- a/fs/nfs/nfs42xdr.c
>> +++ b/fs/nfs/nfs42xdr.c
>> @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct =
rpc_rqst *req,
>>=20
>>        rpc_prepare_reply_pages(req, args->xattr_pages, 0, =
args->count,
>>            hdr.replen);
>> -       req->rq_rcv_buf.flags |=3D XDRBUF_SPARSE_PAGES;
>>=20
>>        encode_nops(&hdr);
>> }
>>=20
>>=20
>=20
> I can see why this is the simplest and most pragmatic solution, so =
it's
> fine with me.

Thanks. I've added Olga's Reviewed/Tested-by to my local copy.
May I add a Reviewed-by from you?


> Why doesn't this happen with getxattr? Do we need to convert that too?

If a GETXATTR request can be generated such that buflen is less than
a page, but page_len > 0, then yes, it will happen there too. As Olga
says, NFS is unaware of the transport's inline threshold setting, so
there will always be some buflen value under which bad things happen.

Either way, I would prefer to see GETXATTR converted to avoid using
XDRBUF_SPARSE_PAGES. Does NFSv4 GETACL provide a good example?


> The basic issue here is that the RPC code does not deal with inlined =
data
> that exceeds PAGE_SIZE. That can only be done with raw pages.
>=20
> Since the upper layer has already allocated a buffer in the case of =
listxattr
> and getxattr, I would love to be able to just XDR code in to that =
buffer,
> and void the whole alloc+copy situation.

Do you mean like the READDIR entry encoders and decoders?


> But sadly, it might be > PAGE_SIZE,
> so the XDR code doesn't allow it. It's not all bad, having to use =
pages
> allows them to be directly hooked in to the cache in the case of =
getxattr,
> but for listxattr, decoding directly in to the provided buffer would =
be nice.
>=20
> Hm, I wonder if that restriction actually holds for listxattr - the =
invidual
> XDR items (xattr names) should never exceed PAGE_SIZE..

You'll have to worry about XDR data items crossing page boundaries.
Our XDR code uses a scratch buffer for that, so it can be handled
transparently.


--
Chuck Lever



