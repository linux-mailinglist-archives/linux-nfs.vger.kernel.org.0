Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630AD23ACE1
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHCTTw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 15:19:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54634 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTTv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 15:19:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073J7QiS095901;
        Mon, 3 Aug 2020 19:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Q29dUbtgFxRvpB0zPvAMxcklpvJ1Gby5ncGZXIWCo50=;
 b=xVULNquRM+wCAdmh5Mu4SXLdwj5VED347qajBIetrOemIJbAJwHatZ1tQMC0cjgq23Hq
 MtGC3SUk2s7xKedHA5kVPwDQUoEpyuSCTkvHIgfA1DshQxOX2wtgfhJtrr/FAma39gfj
 pfqZTH+QaX+3/y7J0AdsMIlhOybyHZ3hcWMVdBEfB55I8GIhrLCfNq2q8OrM86eLCiGU
 Klk515P7y93ATA+829AO8AaJ0SQ26PdLzJ/o33jvznNt/mSDMTciytESdlYLV3949OGZ
 6xjKAzNfeGho1UzmKg5N+43zf4rPsd5D1nHlKrGdyNcGteRqd2o0GBW+6EvRc0mEbio/ jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32pdnq3k0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 19:19:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073J8mGH150067;
        Mon, 3 Aug 2020 19:17:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32pdnnt34e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 19:17:45 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073JHiCa008131;
        Mon, 3 Aug 2020 19:17:44 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 12:17:44 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 3/6] NFSD: Add READ_PLUS data support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200803165954.1348263-4-Anna.Schumaker@Netapp.com>
Date:   Mon, 3 Aug 2020 15:17:42 -0400
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E30AC25-1249-4D91-A2B6-13A38DB2A253@oracle.com>
References: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
 <20200803165954.1348263-4-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030133
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

> On Aug 3, 2020, at 12:59 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> This patch adds READ_PLUS support for returning a single
> NFS4_CONTENT_DATA segment to the client. This is basically the same as
> the READ operation, only with the extra information about data =
segments.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfsd/nfs4proc.c | 17 ++++++++++
> fs/nfsd/nfs4xdr.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 100 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index a09c35f0f6f0..9630d33211f2 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2523,6 +2523,16 @@ static inline u32 nfsd4_read_rsize(struct =
svc_rqst *rqstp, struct nfsd4_op *op)
> 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * =
sizeof(__be32);
> }
>=20
> +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, =
struct nfsd4_op *op)
> +{
> +	u32 maxcount =3D svc_max_payload(rqstp);
> +	u32 rlen =3D min(op->u.read.rd_length, maxcount);
> +	/* enough extra xdr space for encoding either a hole or data =
segment. */
> +	u32 segments =3D 1 + 2 + 2;
> +
> +	return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * =
sizeof(__be32);
> +}
> +
> static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct =
nfsd4_op *op)
> {
> 	u32 maxcount =3D 0, rlen =3D 0;
> @@ -3059,6 +3069,13 @@ static const struct nfsd4_operation nfsd4_ops[] =
=3D {
> 		.op_name =3D "OP_COPY",
> 		.op_rsize_bop =3D nfsd4_copy_rsize,
> 	},
> +	[OP_READ_PLUS] =3D {
> +		.op_func =3D nfsd4_read,
> +		.op_release =3D nfsd4_read_release,
> +		.op_name =3D "OP_READ_PLUS",
> +		.op_rsize_bop =3D nfsd4_read_plus_rsize,
> +		.op_get_currentstateid =3D nfsd4_get_readstateid,
> +	},
> 	[OP_SEEK] =3D {
> 		.op_func =3D nfsd4_seek,
> 		.op_name =3D "OP_SEEK",
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 6a1c0a7fae05..1d143bf02b83 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1957,7 +1957,7 @@ static const nfsd4_dec nfsd4_dec_ops[] =3D {
> 	[OP_LAYOUTSTATS]	=3D (nfsd4_dec)nfsd4_decode_notsupp,
> 	[OP_OFFLOAD_CANCEL]	=3D =
(nfsd4_dec)nfsd4_decode_offload_status,
> 	[OP_OFFLOAD_STATUS]	=3D =
(nfsd4_dec)nfsd4_decode_offload_status,
> -	[OP_READ_PLUS]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> +	[OP_READ_PLUS]		=3D (nfsd4_dec)nfsd4_decode_read,
> 	[OP_SEEK]		=3D (nfsd4_dec)nfsd4_decode_seek,
> 	[OP_WRITE_SAME]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> 	[OP_CLONE]		=3D (nfsd4_dec)nfsd4_decode_clone,
> @@ -4367,6 +4367,87 @@ nfsd4_encode_offload_status(struct =
nfsd4_compoundres *resp, __be32 nfserr,
> 		return nfserr_resource;
> 	p =3D xdr_encode_hyper(p, os->count);
> 	*p++ =3D cpu_to_be32(0);
> +	return nfserr;
> +}
> +
> +static __be32
> +nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> +			    struct nfsd4_read *read,
> +			    unsigned long maxcount,  u32 *eof)
> +{
> +	struct xdr_stream *xdr =3D &resp->xdr;
> +	struct file *file =3D read->rd_nf->nf_file;
> +	int starting_len =3D xdr->buf->len;
> +	__be32 nfserr;
> +	__be32 *p, tmp;
> +	__be64 tmp64;
> +
> +	/* Content type, offset, byte count */
> +	p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	read->rd_vlen =3D xdr_reserve_space_vec(xdr, =
resp->rqstp->rq_vec, maxcount);
> +	if (read->rd_vlen < 0)
> +		return nfserr_resource;
> +
> +	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, =
read->rd_offset,
> +			    resp->rqstp->rq_vec, read->rd_vlen, =
&maxcount, eof);

nfsd4_encode_read() has this:

3904         if (file->f_op->splice_read &&
3905             test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
3906                 nfserr =3D nfsd4_encode_splice_read(resp, read, =
file, maxcount);
3907         else
3908                 nfserr =3D nfsd4_encode_readv(resp, read, file, =
maxcount);

So READ_PLUS never uses ->splice_read.=20

readv is known to be less efficient than splice. Is there a measurable
server performance impact (either latency or CPU utilization) when
reading a file with no holes?


> +	if (nfserr)
> +		return nfserr;
> +	if (svc_encode_read_payload(resp->rqstp, starting_len + 16, =
maxcount))
> +		return nfserr_io;

Not sure you want a read_payload call here. This is to notify the
transport that there is a section of the message that can be sent
via RDMA, but READ_PLUS has no DDP-eligible data items; especially
not holes!

Although, the call is not likely to be much more than a no-op,
since clients won't be providing any Write chunks for READ_PLUS.


> +
> +	tmp =3D htonl(NFS4_CONTENT_DATA);
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> +	tmp64 =3D cpu_to_be64(read->rd_offset);
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> +	tmp =3D htonl(maxcount);
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> +	return nfs_ok;
> +}
> +
> +static __be32
> +nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		       struct nfsd4_read *read)
> +{
> +	unsigned long maxcount;
> +	struct xdr_stream *xdr =3D &resp->xdr;
> +	struct file *file;
> +	int starting_len =3D xdr->buf->len;
> +	int segments =3D 0;
> +	__be32 *p, tmp;
> +	u32 eof;
> +
> +	if (nfserr)
> +		return nfserr;
> +	file =3D read->rd_nf->nf_file;
> +
> +	/* eof flag, segment count */
> +	p =3D xdr_reserve_space(xdr, 4 + 4);
> +	if (!p)
> +		return nfserr_resource;
> +	xdr_commit_encode(xdr);
> +
> +	maxcount =3D svc_max_payload(resp->rqstp);
> +	maxcount =3D min_t(unsigned long, maxcount,
> +			 (xdr->buf->buflen - xdr->buf->len));
> +	maxcount =3D min_t(unsigned long, maxcount, read->rd_length);
> +
> +	eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
> +	if (!eof) {
> +		nfserr =3D nfsd4_encode_read_plus_data(resp, read, =
maxcount, &eof);
> +		segments++;
> +	}
> +
> +	if (nfserr)
> +		xdr_truncate_encode(xdr, starting_len);
> +	else {
> +		tmp =3D htonl(eof);
> +		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, =
4);
> +		tmp =3D htonl(segments);
> +		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, =
4);
> +	}
>=20
> 	return nfserr;
> }
> @@ -4509,7 +4590,7 @@ static const nfsd4_enc nfsd4_enc_ops[] =3D {
> 	[OP_LAYOUTSTATS]	=3D (nfsd4_enc)nfsd4_encode_noop,
> 	[OP_OFFLOAD_CANCEL]	=3D (nfsd4_enc)nfsd4_encode_noop,
> 	[OP_OFFLOAD_STATUS]	=3D =
(nfsd4_enc)nfsd4_encode_offload_status,
> -	[OP_READ_PLUS]		=3D (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_READ_PLUS]		=3D (nfsd4_enc)nfsd4_encode_read_plus,
> 	[OP_SEEK]		=3D (nfsd4_enc)nfsd4_encode_seek,
> 	[OP_WRITE_SAME]		=3D (nfsd4_enc)nfsd4_encode_noop,
> 	[OP_CLONE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> --=20
> 2.27.0
>=20

--
Chuck Lever



