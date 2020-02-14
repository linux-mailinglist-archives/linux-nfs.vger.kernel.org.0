Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2818515F9C4
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 23:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgBNW2t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 17:28:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48924 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgBNW2t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 17:28:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01EMSaVE165777;
        Fri, 14 Feb 2020 22:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=IdK04gdJC5UhLK9nVZJb/kdXVD6nfzlnd8cXPlXwoEE=;
 b=F2HbD8OqhOI9wc5hvYJW6gt6HeaauOmzX6Dhp6EEVuda9z63aVN6SxcXb+5JV70O0GOE
 gKvBZVzDos8kO3hZKKMqSYTZl6dYNeOodqHZO6vRId5mM1ioKq5pXcuK26DwN5mPRq30
 vr5nf1w9DOklOO+/85din979TzSssKqpj6A7LDWEpTr3Pbp5jYYSupd6q3SRuQp1EWh6
 CyAgjN7lOW8yZ854+wkAhSoxOm96K27EPjkS407SlH/9KlL2n4654fl6Acscbb1PNuBu
 SxA8bTOOmI++4LiY1Jf3FvoyYf9PVIA9AaU2Gv5kkfVl4BiIaGVM0Vvx3Be5O9U9GRmm zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k88v14m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 22:28:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01EMRqAA145522;
        Fri, 14 Feb 2020 22:28:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y5dthxthg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 22:28:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01EMScpY001728;
        Fri, 14 Feb 2020 22:28:41 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Feb 2020 14:28:37 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 4/6] NFS: Add READ_PLUS data segment support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200214211227.407836-5-Anna.Schumaker@Netapp.com>
Date:   Fri, 14 Feb 2020 17:28:37 -0500
Cc:     Trond.Myklebust@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAF85957-285A-42BF-993D-7EB4843E2ED2@oracle.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
 <20200214211227.407836-5-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002140165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140165
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2020, at 4:12 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> This patch adds client support for decoding a single NFS4_CONTENT_DATA
> segment returned by the server. This is the simplest implementation
> possible, since it does not account for any hole segments in the =
reply.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfs/nfs42xdr.c         | 138 ++++++++++++++++++++++++++++++++++++++
> fs/nfs/nfs4proc.c         |  43 +++++++++++-
> fs/nfs/nfs4xdr.c          |   1 +
> include/linux/nfs4.h      |   2 +-
> include/linux/nfs_fs_sb.h |   1 +
> include/linux/nfs_xdr.h   |   2 +-
> 6 files changed, 182 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index c03f3246d6c5..bf118ecabe2c 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -45,6 +45,15 @@
> #define encode_deallocate_maxsz		(op_encode_hdr_maxsz + \
> 					 encode_fallocate_maxsz)
> #define decode_deallocate_maxsz		(op_decode_hdr_maxsz)
> +#define encode_read_plus_maxsz		(op_encode_hdr_maxsz + \
> +					 encode_stateid_maxsz + 3)
> +#define NFS42_READ_PLUS_SEGMENT_SIZE	(1 /* data_content4 */ + \
> +					 2 /* data_info4.di_offset */ + =
\
> +					 2 /* data_info4.di_length */)
> +#define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
> +					 1 /* rpr_eof */ + \
> +					 1 /* rpr_contents count */ + \
> +					 NFS42_READ_PLUS_SEGMENT_SIZE)
> #define encode_seek_maxsz		(op_encode_hdr_maxsz + \
> 					 encode_stateid_maxsz + \
> 					 2 /* offset */ + \
> @@ -128,6 +137,14 @@
> 					 decode_putfh_maxsz + \
> 					 decode_deallocate_maxsz + \
> 					 decode_getattr_maxsz)
> +#define NFS4_enc_read_plus_sz		=
(compound_encode_hdr_maxsz + \
> +					 encode_sequence_maxsz + \
> +					 encode_putfh_maxsz + \
> +					 encode_read_plus_maxsz)
> +#define NFS4_dec_read_plus_sz		=
(compound_decode_hdr_maxsz + \
> +					 decode_sequence_maxsz + \
> +					 decode_putfh_maxsz + \
> +					 decode_read_plus_maxsz)
> #define NFS4_enc_seek_sz		(compound_encode_hdr_maxsz + \
> 					 encode_sequence_maxsz + \
> 					 encode_putfh_maxsz + \
> @@ -252,6 +269,16 @@ static void encode_deallocate(struct xdr_stream =
*xdr,
> 	encode_fallocate(xdr, args);
> }
>=20
> +static void encode_read_plus(struct xdr_stream *xdr,
> +			     const struct nfs_pgio_args *args,
> +			     struct compound_hdr *hdr)
> +{
> +	encode_op_hdr(xdr, OP_READ_PLUS, decode_read_plus_maxsz, hdr);
> +	encode_nfs4_stateid(xdr, &args->stateid);
> +	encode_uint64(xdr, args->offset);
> +	encode_uint32(xdr, args->count);
> +}
> +
> static void encode_seek(struct xdr_stream *xdr,
> 			const struct nfs42_seek_args *args,
> 			struct compound_hdr *hdr)
> @@ -446,6 +473,29 @@ static void nfs4_xdr_enc_deallocate(struct =
rpc_rqst *req,
> 	encode_nops(&hdr);
> }
>=20
> +/*
> + * Encode READ_PLUS request
> + */
> +static void nfs4_xdr_enc_read_plus(struct rpc_rqst *req,
> +				   struct xdr_stream *xdr,
> +				   const void *data)
> +{
> +	const struct nfs_pgio_args *args =3D data;
> +	struct compound_hdr hdr =3D {
> +		.minorversion =3D =
nfs4_xdr_minorversion(&args->seq_args),
> +	};
> +
> +	encode_compound_hdr(xdr, req, &hdr);
> +	encode_sequence(xdr, &args->seq_args, &hdr);
> +	encode_putfh(xdr, args->fh, &hdr);
> +	encode_read_plus(xdr, args, &hdr);
> +
> +	rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> +				args->count, hdr.replen);
> +	req->rq_rcv_buf.flags |=3D XDRBUF_READ;

IMO this line is incorrect.

RFC 8267 Section 6.1 does not list any part of the result of READ_PLUS
as DDP-eligible. There's no way for a client to know how to set up
Write chunks, unless it knows exactly where the file's holes are in
advance. Even then... racy.

Just curious, have you tried READ_PLUS with proto=3Drdma ?


> +	encode_nops(&hdr);
> +}
> +
> /*
>  * Encode SEEK request
>  */
> @@ -694,6 +744,67 @@ static int decode_deallocate(struct xdr_stream =
*xdr, struct nfs42_falloc_res *re
> 	return decode_op_hdr(xdr, OP_DEALLOCATE);
> }
>=20
> +static uint32_t decode_read_plus_data(struct xdr_stream *xdr, struct =
nfs_pgio_res *res,
> +				      uint32_t *eof)
> +{
> +	__be32 *p;
> +	uint32_t count, recvd;
> +	uint64_t offset;
> +
> +	p =3D xdr_inline_decode(xdr, 8 + 4);
> +	if (unlikely(!p))
> +		return -EIO;
> +
> +	p =3D xdr_decode_hyper(p, &offset);
> +	count =3D be32_to_cpup(p);
> +	if (count =3D=3D 0)
> +		return 0;
> +
> +	recvd =3D xdr_read_pages(xdr, count);
> +	if (count > recvd) {
> +		dprintk("NFS: server cheating in read reply: "
> +				"count %u > recvd %u\n", count, recvd);
> +		count =3D recvd;
> +		*eof =3D 0;
> +	}
> +
> +	return count;
> +}
> +
> +static int decode_read_plus(struct xdr_stream *xdr, struct =
nfs_pgio_res *res)
> +{
> +	__be32 *p;
> +	uint32_t count, eof, segments, type;
> +	int status;
> +
> +	status =3D decode_op_hdr(xdr, OP_READ_PLUS);
> +	if (status)
> +		return status;
> +
> +	p =3D xdr_inline_decode(xdr, 4 + 4);
> +	if (unlikely(!p))
> +		return -EIO;
> +
> +	eof =3D be32_to_cpup(p++);
> +	segments =3D be32_to_cpup(p++);
> +	if (segments =3D=3D 0)
> +		return 0;
> +
> +	p =3D xdr_inline_decode(xdr, 4);
> +	if (unlikely(!p))
> +		return -EIO;
> +
> +	type =3D be32_to_cpup(p++);
> +	if (type =3D=3D NFS4_CONTENT_DATA)
> +		count =3D decode_read_plus_data(xdr, res, &eof);
> +	else
> +		return -EINVAL;
> +
> +	res->eof =3D eof;
> +	res->count =3D count;
> +	return 0;
> +}
> +
> static int decode_seek(struct xdr_stream *xdr, struct nfs42_seek_res =
*res)
> {
> 	int status;
> @@ -870,6 +981,33 @@ static int nfs4_xdr_dec_deallocate(struct =
rpc_rqst *rqstp,
> 	return status;
> }
>=20
> +/*
> + * Decode READ_PLUS request
> + */
> +static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
> +				  struct xdr_stream *xdr,
> +				  void *data)
> +{
> +	struct nfs_pgio_res *res =3D data;
> +	struct compound_hdr hdr;
> +	int status;
> +
> +	status =3D decode_compound_hdr(xdr, &hdr);
> +	if (status)
> +		goto out;
> +	status =3D decode_sequence(xdr, &res->seq_res, rqstp);
> +	if (status)
> +		goto out;
> +	status =3D decode_putfh(xdr);
> +	if (status)
> +		goto out;
> +	status =3D decode_read_plus(xdr, res);
> +	if (!status)
> +		status =3D res->count;
> +out:
> +	return status;
> +}
> +
> /*
>  * Decode SEEK request
>  */
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 95d07a3dc5d1..ed3ec8c36273 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -69,6 +69,10 @@
>=20
> #include "nfs4trace.h"
>=20
> +#ifdef CONFIG_NFS_V4_2
> +#include "nfs42.h"
> +#endif /* CONFIG_NFS_V4_2 */
> +
> #define NFSDBG_FACILITY		NFSDBG_PROC
>=20
> #define NFS4_BITMASK_SZ		3
> @@ -5199,28 +5203,60 @@ static bool nfs4_read_stateid_changed(struct =
rpc_task *task,
> 	return true;
> }
>=20
> +static bool nfs4_read_plus_not_supported(struct rpc_task *task,
> +					 struct nfs_pgio_header *hdr)
> +{
> +	struct nfs_server *server =3D NFS_SERVER(hdr->inode);
> +	struct rpc_message *msg =3D &task->tk_msg;
> +
> +	if (msg->rpc_proc =3D=3D =
&nfs4_procedures[NFSPROC4_CLNT_READ_PLUS] &&
> +	    server->caps & NFS_CAP_READ_PLUS && task->tk_status =3D=3D =
-ENOTSUPP) {
> +		server->caps &=3D ~NFS_CAP_READ_PLUS;
> +		msg->rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_READ];
> +		rpc_restart_call_prepare(task);
> +		return true;
> +	}
> +	return false;
> +}
> +
> static int nfs4_read_done(struct rpc_task *task, struct =
nfs_pgio_header *hdr)
> {
> -
> 	dprintk("--> %s\n", __func__);
>=20
> 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
> 		return -EAGAIN;
> 	if (nfs4_read_stateid_changed(task, &hdr->args))
> 		return -EAGAIN;
> +	if (nfs4_read_plus_not_supported(task, hdr))
> +		return -EAGAIN;
> 	if (task->tk_status > 0)
> 		nfs_invalidate_atime(hdr->inode);
> 	return hdr->pgio_done_cb ? hdr->pgio_done_cb(task, hdr) :
> 				    nfs4_read_done_cb(task, hdr);
> }
>=20
> +#ifdef CONFIG_NFS_V4_2
> +static void nfs42_read_plus_support(struct nfs_server *server, struct =
rpc_message *msg)
> +{
> +	if (server->caps & NFS_CAP_READ_PLUS)
> +		msg->rpc_proc =3D =
&nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
> +	else
> +		msg->rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_READ];
> +}
> +#else
> +static void nfs42_read_plus_support(struct nfs_server *server, struct =
rpc_message *msg)
> +{
> +	msg->rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_READ];
> +}
> +#endif /* CONFIG_NFS_V4_2 */
> +
> static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
> 				 struct rpc_message *msg)
> {
> 	hdr->timestamp   =3D jiffies;
> 	if (!hdr->pgio_done_cb)
> 		hdr->pgio_done_cb =3D nfs4_read_done_cb;
> -	msg->rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_READ];
> +	nfs42_read_plus_support(NFS_SERVER(hdr->inode), msg);
> 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, =
0);
> }
>=20
> @@ -9970,7 +10006,8 @@ static const struct nfs4_minor_version_ops =
nfs_v4_2_minor_ops =3D {
> 		| NFS_CAP_SEEK
> 		| NFS_CAP_LAYOUTSTATS
> 		| NFS_CAP_CLONE
> -		| NFS_CAP_LAYOUTERROR,
> +		| NFS_CAP_LAYOUTERROR
> +		| NFS_CAP_READ_PLUS,
> 	.init_client =3D nfs41_init_client,
> 	.shutdown_client =3D nfs41_shutdown_client,
> 	.match_stateid =3D nfs41_match_stateid,
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 47817ef0aadb..68b2917d0537 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -7584,6 +7584,7 @@ const struct rpc_procinfo nfs4_procedures[] =3D =
{
> 	PROC42(COPY_NOTIFY,	enc_copy_notify,	=
dec_copy_notify),
> 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
> 	PROC42(LAYOUTERROR,	enc_layouterror,	=
dec_layouterror),
> +	PROC42(READ_PLUS,	enc_read_plus,		dec_read_plus),
> };
>=20
> static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 82d8fb422092..c1eeef52545c 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -540,8 +540,8 @@ enum {
>=20
> 	NFSPROC4_CLNT_LOOKUPP,
> 	NFSPROC4_CLNT_LAYOUTERROR,
> -
> 	NFSPROC4_CLNT_COPY_NOTIFY,
> +	NFSPROC4_CLNT_READ_PLUS,
> };
>=20
> /* nfs41 types */
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 465fa98258a3..11248c5a7b24 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -281,5 +281,6 @@ struct nfs_server {
> #define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
> #define NFS_CAP_LAYOUTERROR	(1U << 26)
> #define NFS_CAP_COPY_NOTIFY	(1U << 27)
> +#define NFS_CAP_READ_PLUS	(1U << 28)
>=20
> #endif
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 94c77ed55ce1..8efbf3d8b263 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -655,7 +655,7 @@ struct nfs_pgio_args {
> struct nfs_pgio_res {
> 	struct nfs4_sequence_res	seq_res;
> 	struct nfs_fattr *	fattr;
> -	__u32			count;
> +	__u64			count;
> 	__u32			op_status;
> 	union {
> 		struct {
> --=20
> 2.25.0
>=20

--
Chuck Lever



