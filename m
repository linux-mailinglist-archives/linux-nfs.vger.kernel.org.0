Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566E112D17F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2019 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfL3Pgo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Dec 2019 10:36:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44762 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfL3Pgo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Dec 2019 10:36:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBUFU7Ts158654;
        Mon, 30 Dec 2019 15:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=kA5hAjGvhdrdPyhKw+jVMovEgDJcqVvKwB7Xq32HdCM=;
 b=QK5Szyq5UXnHqytd1XHM36YAtcIs9hwe85Kb1FrQQaTaYKabf1M0hZG4lAFNUvjwxq30
 lyKLhF4EzkxRH8ImOJhJZghCTyBfrJP3suQakrVSzb7WipC0aYFYLoqEoKnDBD2LkfxM
 wZc13DAirKc+g/VhLc64L6Ha1fDv1jz5VjOlgnUBQ1PmiO3yaav0JEbKOr2ba2ogTUuS
 1jjIjmU/fev3dbWjqr6Xre4m/VJx+LtBju+V+wKVnVAlxQvrH9aFSsW8ofwdF/tUzbyJ
 7me1Dvki21YYM795QXRGtIqwgwobCFVhPicXgqb00EzcLfRjERxw1dfch1iSkSoUT8jp qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2x5ypqe3kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Dec 2019 15:36:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBUFYI62181144;
        Mon, 30 Dec 2019 15:36:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2x6h6vgsbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Dec 2019 15:36:34 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBUFaYiq017761;
        Mon, 30 Dec 2019 15:36:34 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Dec 2019 07:36:34 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
 renewals
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <025801d5bf24$aa242100$fe6c6300$@gmail.com>
Date:   Mon, 30 Dec 2019 10:36:32 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com>
To:     Robert Milkowski <rmilkowski@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9486 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912300141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9486 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912300141
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 30, 2019, at 10:20 AM, Robert Milkowski <rmilkowski@gmail.com> =
wrote:
>=20
> From: Robert Milkowski <rmilkowski@gmail.com>
>=20
> Currently, each time nfs4_do_fsinfo() is called it will do an implicit
> NFS4 lease renewal, which is not compliant with the NFS4 =
specification.
> This can result in a lease being expired by an NFS server.
>=20
> Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> introduced implicit client lease renewal in nfs4_do_fsinfo(),
> which can result in the NFSv4.0 lease to expire on a server side,
> and servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.
>=20
> This can easily be reproduced by frequently unmounting a sub-mount,
> then stat'ing it to get it mounted again, which will delay or even
> completely prevent client from sending RENEW operations if no other
> NFS operations are issued. Eventually nfs server will expire client's
> lease and return an error on file access or next RENEW.
>=20
> This can also happen when a sub-mount is automatically unmounted
> due to inactivity (after nfs_mountpoint_expiry_timeout), then it is
> mounted again via stat(). This can result in a short window during
> which client's lease will expire on a server but not on a client.
> This specific case was observed on production systems.
>=20
> This patch makes an explicit lease renewal instead of an implicit one,
> by adding RENEW to a compound operation issued by nfs4_do_fsinfo(),
> similarly to NFSv4.1 which adds SEQUENCE operation.
>=20
> Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfs/nfs4proc.c       |  4 ++++
> fs/nfs/nfs4xdr.c        | 13 +++++++++++--
> include/linux/nfs_xdr.h |  3 +++
> 3 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 76d3716..6d075f0 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4998,12 +4998,16 @@ static int nfs4_proc_statfs(struct nfs_server =
*server, struct nfs_fh *fhandle, s
> static int _nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh =
*fhandle,
> 		struct nfs_fsinfo *fsinfo)
> {
> +	struct nfs_client *clp =3D server->nfs_client;
> 	struct nfs4_fsinfo_arg args =3D {
> 		.fh =3D fhandle,
> 		.bitmask =3D server->attr_bitmask,
> +		.clientid =3D clp->cl_clientid,
> +		.renew =3D nfs4_has_session(clp) ? 0 : 1,		=
/* append RENEW */
> 	};
> 	struct nfs4_fsinfo_res res =3D {
> 		.fsinfo =3D fsinfo,
> +		.renew =3D nfs4_has_session(clp) ? 0 : 1,
> 	};
> 	struct rpc_message msg =3D {
> 		.rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_FSINFO],
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 936c577..0ce9a10 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -555,11 +555,13 @@ static int decode_layoutget(struct xdr_stream =
*xdr, struct rpc_rqst *req,
> #define NFS4_enc_fsinfo_sz	(compound_encode_hdr_maxsz + \
> 				encode_sequence_maxsz + \
> 				encode_putfh_maxsz + \
> -				encode_fsinfo_maxsz)
> +				encode_fsinfo_maxsz + \
> +				encode_renew_maxsz)
> #define NFS4_dec_fsinfo_sz	(compound_decode_hdr_maxsz + \
> 				decode_sequence_maxsz + \
> 				decode_putfh_maxsz + \
> -				decode_fsinfo_maxsz)
> +				decode_fsinfo_maxsz + \
> +				decode_renew_maxsz)
> #define NFS4_enc_renew_sz	(compound_encode_hdr_maxsz + \
> 				encode_renew_maxsz)
> #define NFS4_dec_renew_sz	(compound_decode_hdr_maxsz + \
> @@ -2646,6 +2648,8 @@ static void nfs4_xdr_enc_fsinfo(struct rpc_rqst =
*req, struct xdr_stream *xdr,
> 	encode_sequence(xdr, &args->seq_args, &hdr);
> 	encode_putfh(xdr, args->fh, &hdr);
> 	encode_fsinfo(xdr, args->bitmask, &hdr);
> +	if (args->renew)
> +		encode_renew(xdr, args->clientid, &hdr);
> 	encode_nops(&hdr);
> }
>=20
> @@ -6778,6 +6782,11 @@ static int nfs4_xdr_dec_fsinfo(struct rpc_rqst =
*req, struct xdr_stream *xdr,
> 		status =3D decode_putfh(xdr);
> 	if (!status)
> 		status =3D decode_fsinfo(xdr, res->fsinfo);
> +	if (status)
> +		goto out;
> +	if (res->renew)
> +		status =3D decode_renew(xdr);
> +out:
> 	return status;
> }
>=20
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 72d5695..49bd673 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1025,11 +1025,14 @@ struct nfs4_fsinfo_arg {
> 	struct nfs4_sequence_args	seq_args;
> 	const struct nfs_fh *		fh;
> 	const u32 *			bitmask;
> +	clientid4			clientid;
> +	unsigned char			renew:1;
> };
>=20
> struct nfs4_fsinfo_res {
> 	struct nfs4_sequence_res	seq_res;
> 	struct nfs_fsinfo	       *fsinfo;
> +	unsigned char			renew:1;
> };
>=20
> struct nfs4_getattr_arg {
> --=20
> 1.8.3.1
>=20
>=20

--
Chuck Lever



