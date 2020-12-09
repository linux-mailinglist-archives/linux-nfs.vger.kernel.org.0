Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB31F2D475E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgLIRBY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:01:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38574 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgLIRBY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 12:01:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9Gtrmx190345;
        Wed, 9 Dec 2020 17:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=RsuTagCai+js7c0deMOd+FwfyMS2OZlX6rRO1IpyS74=;
 b=tMsK7atzsdPvLZRhX+nnqgq7O1IZiJ6l265so1eRAjL/53JPBneuVGWvhUBLbxb7vhJw
 pVbEdlv4ow208Th5tUByjrcdVAjJANs5Uz/9O2wFOZd7pvrFv8MuDr0jk8kqMRF9gB4z
 PTNKDBeMsYrWIejQZmoY9Zl1Y5Okiy1/qoEq5TJLi9LFaMvIgB+362R24ZBtD0IbIUUx
 ijhnVDz9+r66BD6xwoj5Tba4Kt/ZG6lMqf1HiW7y9qg9T/qmri3CkI0XQdkrA22NpJtE
 uXMrGCFeSLlnlD/ve2Wtz/gq711iLXlxYqpZOFB8Gwd/l+8KS3IeAmynzS7wLXB5xpxZ Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 357yqc1br1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 17:00:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9GuiY2063639;
        Wed, 9 Dec 2020 16:58:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 358kyuyeem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 16:58:38 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9GwbvD025311;
        Wed, 9 Dec 2020 16:58:37 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 08:58:37 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v5] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyGPzJUSSb3SGixo0L+CcFV=A12Er5+R=egc3orA9rz8Aw@mail.gmail.com>
Date:   Wed, 9 Dec 2020 11:58:36 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E59C0E34-2172-4DBE-AD51-E57129FAE9E1@oracle.com>
References: <160746979784.1926.1490061321200284214.stgit@manet.1015granger.net>
 <CAN-5tyGPzJUSSb3SGixo0L+CcFV=A12Er5+R=egc3orA9rz8Aw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090119
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 9, 2020, at 11:47 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Dec 8, 2020 at 6:31 PM Chuck Lever <chuck.lever@oracle.com> =
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
>> enough to always require a Reply chunk.
>>=20
>> Reported-by: Olga Kornievskaia <kolga@netapp.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> net/sunrpc/xprtrdma/rpc_rdma.c |   40 =
+++++++++++++++++++++++++++++++---------
>> 1 file changed, 31 insertions(+), 9 deletions(-)
>>=20
>> Hi-
>>=20
>> v4 had a bug, which I've fixed. This version has been tested.
>=20
> This version on top of the same commit  (rc4) passes generic/013
> without oopsing for me too.

Excellent, thanks for confirming!


>> In kernels before 5.10-rc5, there are still problems with the way
>> LISTXATTRS and GETXATTR deal with the tail / XDR pad for the page
>> content that this patch does not address. So backporting this fix
>> alone is not enough to get those working again -- more surgery would
>> be required.
>>=20
>> Since none of the other SPARSE_PAGES users have a problem, let's
>> leave this one on the cutting room floor. It's here in the mail
>> archive if anyone needs it.
>>=20
>>=20
>> Changes since v4:
>> - xdr_buf_pagecount() was simply the wrong thing to use.
>>=20
>> Changes since v3:
>> - I swear I am not drunk. I forgot to commit the change before =
mailing it.
>>=20
>> Changes since v2:
>> - Actually fix the xdr_buf_pagecount() problem
>>=20
>> Changes since RFC:
>> - Ensure xdr_buf_pagecount() is defined in rpc_rdma.c
>> - noinline the sparse page allocator -- it's an uncommon path
>>=20
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c =
b/net/sunrpc/xprtrdma/rpc_rdma.c
>> index 0f5120c7668f..c48536f2121f 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -179,6 +179,31 @@ rpcrdma_nonpayload_inline(const struct =
rpcrdma_xprt *r_xprt,
>>                r_xprt->rx_ep->re_max_inline_recv;
>> }
>>=20
>> +/* ACL likes to be lazy in allocating pages. For TCP, these
>> + * pages can be allocated during receive processing. Not true
>> + * for RDMA, which must always provision receive buffers
>> + * up front.
>> + */
>> +static noinline int
>> +rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
>> +{
>> +       struct page **ppages;
>> +       int len;
>> +
>> +       len =3D buf->page_len;
>> +       ppages =3D buf->pages + (buf->page_base >> PAGE_SHIFT);
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
>> @@ -233,15 +258,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt =
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
>> @@ -867,6 +883,12 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, =
struct rpc_rqst *rqst)
>>        __be32 *p;
>>        int ret;
>>=20
>> +       if (unlikely(rqst->rq_rcv_buf.flags & XDRBUF_SPARSE_PAGES)) {
>> +               ret =3D =
rpcrdma_alloc_sparse_pages(&rqst->rq_rcv_buf);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>>        rpcrdma_set_xdrlen(&req->rl_hdrbuf, 0);
>>        xdr_init_encode(xdr, &req->rl_hdrbuf, =
rdmab_data(req->rl_rdmabuf),
>>                        rqst);

--
Chuck Lever



