Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63EB2D34B4
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 22:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgLHU5C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 15:57:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42958 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgLHU5C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 15:57:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Ks1dY124173;
        Tue, 8 Dec 2020 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=NIqTvRG+Jdbst5QanAu6hhkAT+g5FqQSl0hy4a7s21k=;
 b=cQ+H8l4a2Pszm6lPfpEgh35R4D+Lf2DmqZjdsRB7402J49+KbFHHNEyr4uppTp6xzH/X
 Q5Sv9yUv3o/1eznPpwPEzuUcV/x+TP38M7cIhKrwGTe9TE4V7OQC12Q88GLCXC+y9s7p
 zJTURhA6F23SyqJfPpQd++wlc0hN+JkF2TsZY0kzIEVL6KQ8zSeMeF8Ixr5nXYinxMML
 XOsQvAy0EKMAI9LAyusn54zEmTEjbJrbWRyt0tetO1ZD9tbD9czhCOrwvDVcm6TAq5TL
 w9rjD9iVdQLL0+ggI2LAz+pnn750JlCQqGf/li2C2p91bdZR6XiuxfJ6TKqmse8QzUQf JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825m50cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 20:56:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8KtjNj078037;
        Tue, 8 Dec 2020 20:56:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 358m4yeg88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 20:56:18 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8KuHOa021471;
        Tue, 8 Dec 2020 20:56:17 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 12:56:17 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 1/2] SUNRPC: Keep buf->len in sync with xdr->nwords
 when expanding holes
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201208202925.597663-2-Anna.Schumaker@Netapp.com>
Date:   Tue, 8 Dec 2020 15:56:16 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A6797DD-246D-4994-B38C-57AA0196D061@oracle.com>
References: <20201208202925.597663-1-Anna.Schumaker@Netapp.com>
 <20201208202925.597663-2-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080128
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 8, 2020, at 3:29 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Otherwise we could end up placing data a few bytes off from where we
> actually want to put it.
>=20
> Fixes: 84ce182ab85b "SUNRPC: Add the ability to expand holes in data =
pages"
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> net/sunrpc/xdr.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 71e03b930b70..5b848fe65c81 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1314,6 +1314,7 @@ uint64_t xdr_expand_hole(struct xdr_stream *xdr, =
uint64_t offset, uint64_t lengt
> 		unsigned int res =3D _shift_data_right_tail(buf, from + =
bytes - shift, shift);
> 		truncated =3D shift - res;
> 		xdr->nwords -=3D XDR_QUADLEN(truncated);
> +		buf->len -=3D 4 * XDR_QUADLEN(truncated);

If I understand what you're doing here correctly, the usual idiom
is "XDR_QUADLEN(truncated) << 2" .


> 		bytes -=3D shift;
> 	}
>=20
> @@ -1325,7 +1326,7 @@ uint64_t xdr_expand_hole(struct xdr_stream *xdr, =
uint64_t offset, uint64_t lengt
> 					bytes);
> 	_zero_pages(buf->pages, buf->page_base + offset, length);
>=20
> -	buf->len +=3D length - (from - offset) - truncated;
> +	buf->len +=3D length - (from - offset);
> 	xdr_set_page(xdr, offset + length, PAGE_SIZE);
> 	return length;
> }
> --=20
> 2.29.2
>=20

--
Chuck Lever



