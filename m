Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1452B0E6D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 20:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgKLTph (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 14:45:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56258 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgKLTpg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 14:45:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACJTvsA039675
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 mime-version : cc : subject : to : references : from : in-reply-to :
 content-type; s=corp-2020-01-29;
 bh=+44P8hMM4rmuZyxG8yx06IzfxKnjLX8DKTq2EWskMkw=;
 b=zfuf+jnLSnI8op0wzcqjAmdz3I/mspH3r4ZxqQsOE7in++Cp6kyhOk38gkc5w6CEH4mO
 uqhuzpMgGp18/253nrFU+RxvWQy5fU4rHaxCxcfEAkyJVBMxWN5XLZ+dFW/NyuqvCGA8
 runLxbZ0QDKMVUHzpOfw/171ZXl1PWcIIU7id8ufBIIUTc54iHzEKO5Yvt853EldeHR0
 CDqnn0LVmyUU8JBtQrvfMuEAqKZ1Ms1hgOJE8PPD4n3/KilP6LMzl8QmAy0TVC7HuC3S
 H06n5S8doE5ytZviwcVBKTet0r0gAte61+3ThfxaUZoGu5bJqzCRgVgtsA/hdFSolS7R sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72ewg3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:45:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACJVLkN117589
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:45:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34p55rsxjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:45:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ACJjY3H007978
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 19:45:34 GMT
Received: from mbp2018.cdmnet.org (/84.69.16.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 11:45:33 -0800
Message-ID: <60bf9c24-a944-17c0-6f54-6dbb53970f44@oracle.com>
Date:   Thu, 12 Nov 2020 19:45:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:84.0)
 Gecko/20100101 Thunderbird/84.0a1
Cc:     Calum Mackay <calum.mackay@oracle.com>
Subject: Re: [PATCH v1 2/4] NFSD: Clean up the show_nf_may macro
Content-Language: en-GB
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
 <160519326660.1658.18351054451047271453.stgit@klimt.1015granger.net>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <160519326660.1658.18351054451047271453.stgit@klimt.1015granger.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lMK4odPS55z3U9Zh8mnQw2zAdxY4MqWvR"
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120116
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lMK4odPS55z3U9Zh8mnQw2zAdxY4MqWvR
Content-Type: multipart/mixed; boundary="DMj5b3nnqMPEVPkhSq34S9V9TKMSa8i8B";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <60bf9c24-a944-17c0-6f54-6dbb53970f44@oracle.com>
Subject: Re: [PATCH v1 2/4] NFSD: Clean up the show_nf_may macro
References: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
 <160519326660.1658.18351054451047271453.stgit@klimt.1015granger.net>
In-Reply-To: <160519326660.1658.18351054451047271453.stgit@klimt.1015granger.net>

--DMj5b3nnqMPEVPkhSq34S9V9TKMSa8i8B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 12/11/2020 3:01 pm, Chuck Lever wrote:
> Display all currently possible NFSD_MAY permission flags.
>=20
> Move and rename show_nf_may with a more generic name because the
> NFSD_MAY permission flags are used in other places besides the file
> cache.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/nfsd/trace.h |   40 ++++++++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 99bf07800cd0..532b66a4b7f1 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -12,6 +12,22 @@
>   #include "export.h"
>   #include "nfsfh.h"
>  =20
> +#define show_nfsd_may_flags(x)						\
> +	__print_flags(x, "|",						\
> +		{ NFSD_MAY_EXEC,		"EXEC" },		\
> +		{ NFSD_MAY_WRITE,		"WRITE" },		\
> +		{ NFSD_MAY_READ,		"READ" },		\
> +		{ NFSD_MAY_SATTR,		"SATTR" },		\
> +		{ NFSD_MAY_TRUNC,		"TRUNC" },		\
> +		{ NFSD_MAY_LOCK,		"LOCK" },		\
> +		{ NFSD_MAY_OWNER_OVERRIDE,	"OWNER_OVERRIDE" },	\
> +		{ NFSD_MAY_LOCAL_ACCESS,	"LOCAL_ACCESS" },	\
> +		{ NFSD_MAY_BYPASS_GSS_ON_ROOT,	"BYPASS_GSS_ON_ROOT" },	\
> +		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAD_LEASE" },	\

typo :)

> +		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
> +		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +
>   TRACE_EVENT(nfsd_compound,
>   	TP_PROTO(const struct svc_rqst *rqst,
>   		 u32 args_opcnt),
> @@ -421,6 +437,9 @@ TRACE_EVENT(nfsd_clid_inuse_err,
>   		__entry->cl_boot, __entry->cl_id)
>   )
>  =20
> +/*
> + * from fs/nfsd/filecache.h
> + */
>   TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
>   TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
>   TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);
> @@ -435,13 +454,6 @@ TRACE_DEFINE_ENUM(NFSD_FILE_REFERENCED);
>   		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	\
>   		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
>  =20
> -/* FIXME: This should probably be fleshed out in the future. */
> -#define show_nf_may(val)						\
> -	__print_flags(val, "|",						\
> -		{ NFSD_MAY_READ,		"READ" },		\
> -		{ NFSD_MAY_WRITE,		"WRITE" },		\
> -		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" })
> -
>   DECLARE_EVENT_CLASS(nfsd_file_class,
>   	TP_PROTO(struct nfsd_file *nf),
>   	TP_ARGS(nf),
> @@ -466,7 +478,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
>   		__entry->nf_inode,
>   		__entry->nf_ref,
>   		show_nf_flags(__entry->nf_flags),
> -		show_nf_may(__entry->nf_may),
> +		show_nfsd_may_flags(__entry->nf_may),
>   		__entry->nf_file)
>   )
>  =20
> @@ -492,10 +504,10 @@ TRACE_EVENT(nfsd_file_acquire,
>   		__field(u32, xid)
>   		__field(unsigned int, hash)
>   		__field(void *, inode)
> -		__field(unsigned int, may_flags)
> +		__field(unsigned long, may_flags)
>   		__field(int, nf_ref)
>   		__field(unsigned long, nf_flags)
> -		__field(unsigned char, nf_may)
> +		__field(unsigned long, nf_may)
>   		__field(struct file *, nf_file)
>   		__field(u32, status)
>   	),
> @@ -514,10 +526,10 @@ TRACE_EVENT(nfsd_file_acquire,
>  =20
>   	TP_printk("xid=3D0x%x hash=3D0x%x inode=3D0x%p may_flags=3D%s ref=3D=
%d nf_flags=3D%s nf_may=3D%s nf_file=3D0x%p status=3D%u",
>   			__entry->xid, __entry->hash, __entry->inode,
> -			show_nf_may(__entry->may_flags), __entry->nf_ref,
> -			show_nf_flags(__entry->nf_flags),
> -			show_nf_may(__entry->nf_may), __entry->nf_file,
> -			__entry->status)
> +			show_nfsd_may_flags(__entry->may_flags),
> +			__entry->nf_ref, show_nf_flags(__entry->nf_flags),
> +			show_nfsd_may_flags(__entry->nf_may),
> +			__entry->nf_file, __entry->status)
>   );
>  =20
>   DECLARE_EVENT_CLASS(nfsd_file_search_class,
>=20
>=20

--=20
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation

--DMj5b3nnqMPEVPkhSq34S9V9TKMSa8i8B--

--lMK4odPS55z3U9Zh8mnQw2zAdxY4MqWvR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAl+tkNsFAwAAAAAACgkQhSPvAG3BU+Kz
FQ//bzyLP2PuKdGEGV/ix0DyVmG1t6SENjrOr0yA6g2pJ80QX9BhF7iGxqJrctzaDa8qTqVHI++b
0Zom7/AhmsAmFz+hWNtofhKtDT96zzTIljEG93RM6dmQ8OpknyJnyHgpPZIiQ9yJDXW1fZVGWPld
NejcyzU1xRzI5GL4lLOAXb/sVfVdIeYArcmIvemTjdQErkLdixENY7xAjjks5hKhC9bLo9ZhCTDw
EjKSuc/Ludl2k2aIKau+y1dmz44hjaFidunHqbxOurGuuOPVYxLmVZjHtZrJnlxWpI8jU378jqeR
a7E03Dp7ASUgO8Dok9L0v72/myTBqkTDWyNXjltXV530tI6WpqalPvtnamZ2+DTfVcNsxGjz0nC3
8Ow4K4K6keRYKDBn30VMA0P+OMylBI+wM6/51Xxqs5Jvtm9jsiVYEUR6JlGSsjD05TIwMli9Xeb4
57gl9yOXYmGhNRNkCBiyqNQqZS4IcW76cw5Mjvgqd2ATaoFmS2DKKTiVCxYGXy64Ezby+/uLeSj2
ES/f/tC/uauxkBOr4NO7k9FDdINX2cLPLVHVjphbvBU4wIi/OufYgj/HdI7KcYIwQhZLhCmaqTm8
hrhdY7pGaXdAYLhSAQRkyMkAUEhnuGWv7MnMRsUKHqzrm+xBfolIAGMuudbBrsQYSjnJYcrh8hfM
EYg=
=9m3n
-----END PGP SIGNATURE-----

--lMK4odPS55z3U9Zh8mnQw2zAdxY4MqWvR--
