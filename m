Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BA2D30CF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 18:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgLHRTO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 12:19:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHRTO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 12:19:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HG3xP043715;
        Tue, 8 Dec 2020 17:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ZnZievA7w7+HZNF46hX5wfNF4Gy4p2Yc5Bm1iqvVYqk=;
 b=tUm31+W+pa5cYF/GTJerGXpcMlwhphhRXT81LeFYO8EadxNDnX9Lt1SEb/HotZ0ttLNK
 i/gIehzZu6FRCKThk0NYcJ4ItZGX+JgeYBTNYZ59Cl3g1xDk+0E6colZ2LH6hnTFfjn/
 4moK0BGlYJGKXnBFprGc+FCaM5o+XATNvSgiwE4FdMvhlNeIPK9P1OSGX9Ckz3yhGom+
 +j416BXFmi7CojErO1zP0QavZZ9b1zZD63Adl4c/AeltfXJ3A+4jn/hTRp23DQNZXEKM
 HL9ceTebE1uPw4v/eTEjddg50/4A3PX6spIcA8jXjAbS1yLa9onW9stP0n/jKJi6Lkc4 uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825m3yd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 17:18:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HFjBM183714;
        Tue, 8 Dec 2020 17:16:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 358m4y5x82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 17:16:25 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8HGOcn023559;
        Tue, 8 Dec 2020 17:16:24 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 09:16:24 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH RFC] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyFTMj8ed7Q+4KYgwtJhUGN3i_MVV60N7f0oZH8PL=77Pw@mail.gmail.com>
Date:   Tue, 8 Dec 2020 12:16:23 -0500
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50C48A0C-60BE-478B-830D-A0E60653EB31@oracle.com>
References: <160711969521.12486.14622797339746381076.stgit@manet.1015granger.net>
 <CAN-5tyFTMj8ed7Q+4KYgwtJhUGN3i_MVV60N7f0oZH8PL=77Pw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 8, 2020, at 12:03 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> Hi Chuck,
>=20
> Is the only user of SPARSE_PAGES is v3 ACLs?

There was one other, the gssproxy upcall, which I've proposed a fix
for, for v5.11. After that fix goes in and Frank's replacements for
GETXATTR and LISTXATTRS are merged, NFSv3 GETACL will be the only
user of XDRBUF_SPARSE_PAGES.


> Are you fixing this so that v3 ACLs would work over rdma?

As far as I know, NFSv3 GETACL works fine over RDMA because it always
expects a large Reply, and thus rpcrdma_marshal_req prepares a Reply
chunk. That triggers the code that allocates the receive pages
properly.

But you might be asking me why I'm sending this patch. Discussion?
Belt and suspenders? Fodder for backport, just in case?

It's always possible that someone might add another XDRBUF_SPARSE_PAGES
user before we are able to update NFSv3 GETACL. The below patch should
help make that situation less problematic, if it should occur.

So, after Frank's patches are merged, this fix is not addressing an
existing active crasher.


> On Fri, Dec 4, 2020 at 5:13 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> Olga K. observed that rpcrdma_marsh_req() allocates sparse pages
>> only when it has determined that a Reply chunk is necessary. There
>> are plenty of cases where no Reply chunk is needed, but the
>> XDRBUF_SPARSE_PAGES flag is set. The result would be a crash in
>> rpcrdma_inline_fixup() when it tries to copy parts of the received
>> Reply into a missing page.
>>=20
>> To avoid crashing, handle sparse page allocation up front.
>>=20
>> Until XATTR support was added, this issue did not appear often
>> because the only SPARSE_PAGES consumer always expected a reply large
>> enough to require a Reply chunk.
>>=20
>> Reported-by: Olga Kornievskaia <kolga@netapp.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/xprtrdma/rpc_rdma.c |   41 =
+++++++++++++++++++++++++++++++---------
>> 1 file changed, 32 insertions(+), 9 deletions(-)
>>=20
>> Here's a stop-gap that can be back-ported to earlier kernels if =
needed.
>> Untested. Comments welcome.
>>=20
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c =
b/net/sunrpc/xprtrdma/rpc_rdma.c
>> index 0f5120c7668f..09b7649fa112 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -179,6 +179,32 @@ rpcrdma_nonpayload_inline(const struct =
rpcrdma_xprt *r_xprt,
>>                r_xprt->rx_ep->re_max_inline_recv;
>> }
>>=20
>> +/* ACL likes to be lazy in allocating pages. For TCP, these
>> + * pages can be allocated during receive processing. Not true
>> + * for RDMA, which must always provision receive buffers
>> + * up front.
>> + */
>> +static int
>> +rpcrdma_alloc_sparse_pages(struct rpc_rqst *rqst)
>> +{
>> +       struct xdr_buf *xb =3D &rqst->rq_rcv_buf;
>> +       struct page **ppages;
>> +       int len;
>> +
>> +       len =3D xb->page_len;
>> +       ppages =3D xb->pages + xdr_buf_pagecount(xb);
>> +       while (len > 0) {
>> +               if (!*ppages)
>> +                       *ppages =3D alloc_page(GFP_NOWAIT | =
__GFP_NOWARN);
>> +               if (!*ppages)
>> +                       return -ENOBUFS;
>> +               ppages++;
>> +               len -=3D PAGE_SIZE;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> /* Split @vec on page boundaries into SGEs. FMR registers pages, not
>>  * a byte range. Other modes coalesce these SGEs into a single MR
>>  * when they can.
>> @@ -233,15 +259,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt =
*r_xprt, struct xdr_buf *xdrbuf,
>>        ppages =3D xdrbuf->pages + (xdrbuf->page_base >> PAGE_SHIFT);
>>        page_base =3D offset_in_page(xdrbuf->page_base);
>>        while (len) {
>> -               /* ACL likes to be lazy in allocating pages - ACLs
>> -                * are small by default but can get huge.
>> -                */
>> -               if (unlikely(xdrbuf->flags & XDRBUF_SPARSE_PAGES)) {
>> -                       if (!*ppages)
>> -                               *ppages =3D alloc_page(GFP_NOWAIT | =
__GFP_NOWARN);
>> -                       if (!*ppages)
>> -                               return -ENOBUFS;
>> -               }
>>                seg->mr_page =3D *ppages;
>>                seg->mr_offset =3D (char *)page_base;
>>                seg->mr_len =3D min_t(u32, PAGE_SIZE - page_base, =
len);
>> @@ -867,6 +884,12 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, =
struct rpc_rqst *rqst)
>>        __be32 *p;
>>        int ret;
>>=20
>> +       if (unlikely(rqst->rq_rcv_buf.flags & XDRBUF_SPARSE_PAGES)) {
>> +               ret =3D rpcrdma_alloc_sparse_pages(rqst);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>>        rpcrdma_set_xdrlen(&req->rl_hdrbuf, 0);
>>        xdr_init_encode(xdr, &req->rl_hdrbuf, =
rdmab_data(req->rl_rdmabuf),
>>                        rqst);
>>=20
>>=20

--
Chuck Lever



