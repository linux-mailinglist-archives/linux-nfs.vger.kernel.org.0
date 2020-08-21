Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A124E038
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgHUS7n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Aug 2020 14:59:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60612 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHUS7m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Aug 2020 14:59:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LIuKXC086022;
        Fri, 21 Aug 2020 18:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=74fQrl+0aDN7t3rdM01glAclbzNUqTNmPpfHgb2NWCk=;
 b=JBUQMfbsyJmP4gMT1HlU2ZTSU/d2BjKMLy9K0rPFpoyWUDfFfJ0mL5SdviPgv31kqFi1
 QaR1RJv7CPUx7tiUMnK2paKyqNfx/2xcpEjsAVPek+iu89KiO8L2chnjGZEp/zEVyeqa
 A56pPF3Dvd4rVvdBz21wau6O/wu1Js5vmiagtRzg14gn+vJWM6R1kTbtORGgvteL5AHJ
 oVq3rHhN3RHlungAD6p8QZfvl56gPWdDxnLcXPbNWeHO9apxkuPS9kxG23Y7eXgdQXHn
 VHtXvzZmnsBkR5xTIX1BUuFMU5nqSx8z2AmZ9o+KsKcAVgXgXICsGNTHiH3sCDJ/S65J lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32x74rqk95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 18:59:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LIr5x0059675;
        Fri, 21 Aug 2020 18:59:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32xsn2vb55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 18:59:37 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07LIxX4F012450;
        Fri, 21 Aug 2020 18:59:36 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 18:59:33 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] NFSD: Fix listxattr receive buffer size
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <159803139578.514751.6905262413915309673.stgit@manet.1015granger.net>
Date:   Fri, 21 Aug 2020 14:59:32 -0400
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F5EBDEC-BBF5-4B15-8EE2-E6B57CC7BBCF@oracle.com>
References: <159803139578.514751.6905262413915309673.stgit@manet.1015granger.net>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210178
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Oops. Short description should read:

NFS: Fix listxattr receive buffer size


> On Aug 21, 2020, at 1:36 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Certain NFSv4.2/RDMA tests fail with v5.9-rc1.
>=20
> rpcrdma_convert_kvec() runs off the end of the rl_segments array
> because rq_rcv_buf.tail[0].iov_len holds a very large positive
> value. The resultant kernel memory corruption is enough to crash
> the client system.
>=20
> Callers of rpc_prepare_reply_pages() must reserve an extra XDR_UNIT
> in the maximum decode size for a possible XDR pad of the contents
> of the xdr_buf's pages. That guarantees the allocated receive buffer
> will be large enough to accommodate the usual contents plus that XDR
> pad word.
>=20
> encode_op_hdr() cannot add that extra word. If it does,
> xdr_inline_pages() underruns the length of the tail iovec.
>=20
> Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for =
extended attributes")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> fs/nfs/nfs42xdr.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index cc50085e151c..d0ddf90c9be4 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -179,7 +179,7 @@
> 				 1 + nfs4_xattr_name_maxsz + 1)
> #define decode_setxattr_maxsz   (op_decode_hdr_maxsz + =
decode_change_info_maxsz)
> #define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
> -#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1)
> +#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + =
1)
> #define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
> 				  nfs4_xattr_name_maxsz)
> #define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
> @@ -504,7 +504,7 @@ static void encode_listxattrs(struct xdr_stream =
*xdr,
> {
> 	__be32 *p;
>=20
> -	encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz + 1, =
hdr);
> +	encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz, hdr);
>=20
> 	p =3D reserve_space(xdr, 12);
> 	if (unlikely(!p))
>=20
>=20

--
Chuck Lever



