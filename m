Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8711719413B
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 15:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCZOZt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 10:25:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51896 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgCZOZt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 10:25:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QEOwFs026520;
        Thu, 26 Mar 2020 14:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=lbPAye3rNwkKkX/6IUO+Chkrv9DTjuCZgRGbj7WtxuA=;
 b=LxSWjnKmrV75dH0ewx3e7AvJTr88nOGzWnUEkRsNEPyXVh92qGCR6OfuH9waqIzFfKHo
 6vwhIUj+Pikrvo/DCjTit45+LT54hE+enICVGu0swIajg2PXKOEmIynU7YDKHYeYKOlq
 UxBGU04cpCVRKmxD9c5gn8axhTFfWZLPCfFZovyj+QQeGvy7vG60OVUzm6qa6auMTSKK
 y17jeQ2NTeDS0LFxJCp/J1TjPsHgTJMb7ZidMbYj6JJ7eIaUJYYEg74OMG9/dcWHDRyy
 +4Gzq1Do54ttYHyLVF2ktWArhxJICzT8klzpcw4bVb4KBplksFytlsyr3hf+q3VX1rXr 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 300urk0thf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:25:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QEM03t072108;
        Thu, 26 Mar 2020 14:25:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3006r8j28f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:25:43 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QEPhW1007764;
        Thu, 26 Mar 2020 14:25:43 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 07:25:42 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 1/1] SUNRPC: fix krb5p mount to provide large enough
 buffer in rq_rcvsize
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200326142451.3666-1-olga.kornievskaia@gmail.com>
Date:   Thu, 26 Mar 2020 10:25:41 -0400
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F945671A-CB6B-431B-9172-907294F3F1AA@oracle.com>
References: <20200326142451.3666-1-olga.kornievskaia@gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 spamscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260111
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 26, 2020, at 10:24 AM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> Ever since commit 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing
> reply buffer size"). It changed how "req->rq_rcvsize" is calculated. =
It
> used to use au_cslack value which was nice and large and changed it to
> au_rslack value which turns out to be too small.
>=20
> Since 5.1, v3 mount with sec=3Dkrb5p fails against an Ontap server
> because client's receive buffer it too small.
>=20
> For gss krb5p, we need to account for the mic token in the verifier,
> and the wrap token in the wrap token.
>=20
> RFC 4121 defines:
> mic token
> Octet no   Name        Description
>         --------------------------------------------------------------
>         0..1     TOK_ID     Identification field.  Tokens emitted by
>                             GSS_GetMIC() contain the hex value 04 04
>                             expressed in big-endian order in this
>                             field.
>         2        Flags      Attributes field, as described in section
>                             4.2.2.
>         3..7     Filler     Contains five octets of hex value FF.
>         8..15    SND_SEQ    Sequence number field in clear text,
>                             expressed in big-endian order.
>         16..last SGN_CKSUM  Checksum of the "to-be-signed" data and
>                             octet 0..15, as described in section =
4.2.4.
>=20
> that's 16bytes (GSS_KRB5_TOK_HDR_LEN) + chksum
>=20
> wrap token
> Octet no   Name        Description
>         --------------------------------------------------------------
>          0..1     TOK_ID    Identification field.  Tokens emitted by
>                             GSS_Wrap() contain the hex value 05 04
>                             expressed in big-endian order in this
>                             field.
>          2        Flags     Attributes field, as described in section
>                             4.2.2.
>          3        Filler    Contains the hex value FF.
>          4..5     EC        Contains the "extra count" field, in big-
>                             endian order as described in section =
4.2.3.
>          6..7     RRC       Contains the "right rotation count" in =
big-
>                             endian order, as described in section
>                             4.2.5.
>          8..15    SND_SEQ   Sequence number field in clear text,
>                             expressed in big-endian order.
>          16..last Data      Encrypted data for Wrap tokens with
>                             confidentiality, or plaintext data =
followed
>                             by the checksum for Wrap tokens without
>                             confidentiality, as described in section
>                             4.2.4.
>=20
> Also 16bytes of header (GSS_KRB5_TOK_HDR_LEN), encrypted data, and =
cksum
> (other things like padding)
>=20
> RFC 3961 defines known cksum sizes:
> Checksum type              sumtype        checksum         section or
>                                value            size         reference
>   =
---------------------------------------------------------------------
>   CRC32                            1               4           6.1.3
>   rsa-md4                          2              16           6.1.2
>   rsa-md4-des                      3              24           6.2.5
>   des-mac                          4              16           6.2.7
>   des-mac-k                        5               8           6.2.8
>   rsa-md4-des-k                    6              16           6.2.6
>   rsa-md5                          7              16           6.1.1
>   rsa-md5-des                      8              24           6.2.4
>   rsa-md5-des3                     9              24             ??
>   sha1 (unkeyed)                  10              20             ??
>   hmac-sha1-des3-kd               12              20            6.3
>   hmac-sha1-des3                  13              20             ??
>   sha1 (unkeyed)                  14              20             ??
>   hmac-sha1-96-aes128             15              20         =
[KRB5-AES]
>   hmac-sha1-96-aes256             16              20         =
[KRB5-AES]
>   [reserved]                  0x8003               ?         =
[GSS-KRB5]
>=20
> Linux kernel now mainly supports type 15,16 so max cksum size is =
20bytes.
> (GSS_KRB5_MAX_CKSUM_LEN)
>=20
> Re-use already existing define of GSS_KRB5_MAX_SLACK_NEEDED that's =
used
> for encoding the gss_wrap tokens (same tokens are used in reply).
>=20
> Fixes: 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing reply =
buffer size")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> net/sunrpc/auth_gss/auth_gss.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
> index 24ca861..d6cd2a5 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -20,6 +20,7 @@
> #include <linux/sunrpc/clnt.h>
> #include <linux/sunrpc/auth.h>
> #include <linux/sunrpc/auth_gss.h>
> +#include <linux/sunrpc/gss_krb5.h>
> #include <linux/sunrpc/svcauth_gss.h>
> #include <linux/sunrpc/gss_err.h>
> #include <linux/workqueue.h>
> @@ -1050,7 +1051,7 @@ static void gss_pipe_free(struct gss_pipe *p)
> 		goto err_put_mech;
> 	auth =3D &gss_auth->rpc_auth;
> 	auth->au_cslack =3D GSS_CRED_SLACK >> 2;
> -	auth->au_rslack =3D GSS_VERF_SLACK >> 2;
> +	auth->au_rslack =3D GSS_KRB5_MAX_SLACK_NEEDED >> 2;
> 	auth->au_verfsize =3D GSS_VERF_SLACK >> 2;
> 	auth->au_ralign =3D GSS_VERF_SLACK >> 2;
> 	auth->au_flags =3D 0;
> --=20
> 1.8.3.1
>=20

--
Chuck Lever



