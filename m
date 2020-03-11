Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF981181C1C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 16:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgCKPND (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 11:13:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33206 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgCKPND (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 11:13:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BFCAu4155408
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 15:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=corp-2020-01-29;
 bh=jcEj+st14A5m5ngTsmjIELxSbjJq5FWQyxtstn2V9iQ=;
 b=cOKempTzYC3ZkTsPGJgeWKRPyde2fz5xSPiK/4ZY5oAzQ95zm58Rp8M8or8OmQK/CYYs
 3jlBeLHejl56Ix9zYZ2UivPJgEO2bNjSOFlyFD55e0vXZ7H/Thf7jvHNgqlQ1H98Ulxq
 0uVDQsaHJ6YrpSNjt7iPw4OJNyEBwPXd5OgL7T5jxa9P8PfIVKiY3ty5LiNmAUqqjG+l
 PHc6xiqZhJRnJhDPWVDdGb0dN4iI/VhSXHHpIQqQS3uSK0OF103xlM8iawDiGcrtUbxq
 PihcfCB8JM5BVbt3iK+DBDTJrMvEtruvGqrwVA38f/nGB0mPoUwSize2rxA1WSk1xhtM cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yp9v67dv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 15:13:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BF7qD9003152
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 15:13:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2yp8qwpqem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 15:13:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02BFCx55003138
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 15:12:59 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 08:12:59 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 1/3] sunrpc: Fix gss_unwrap_resp_integ() again
Date:   Wed, 11 Mar 2020 11:12:57 -0400
References: <20200309140301.2637.9696.stgit@manet.1015granger.net>
 <20200309140618.2637.48251.stgit@manet.1015granger.net>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <20200309140618.2637.48251.stgit@manet.1015granger.net>
Message-Id: <480C209B-42E9-46FE-8A11-322A491D619F@oracle.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110097
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 9, 2020, at 10:06 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> xdr_buf_read_mic() tries to find unused contiguous space in a
> received xdr_buf in order to linearize the checksum for the call
> to gss_verify_mic. However, the corner cases in this code are
> numerous and we seem to keep missing them. I've just hit yet
> another buffer overrun related to it.
>=20
> This overrun is at the end of xdr_buf_read_mic():
>=20
> 1284         if (buf->tail[0].iov_len !=3D 0)
> 1285                 mic->data =3D buf->tail[0].iov_base + =
buf->tail[0].iov_len;
> 1286         else
> 1287                 mic->data =3D buf->head[0].iov_base + =
buf->head[0].iov_len;
> 1288         __read_bytes_from_xdr_buf(&subbuf, mic->data, mic->len);
> 1289         return 0;
>=20
> This logic assumes the transport has set the length of the tail
> based on the size of the received message. base + len is then
> supposed to be off the end of the message but still within the
> actual buffer.
>=20
> In fact, the length of the tail is set by the upper layer when the
> Call is encoded so that the end of the tail is actually the end of
> the allocated buffer itself. This causes the logic above to set
> mic->data to point past the end of the receive buffer.
>=20
> The "mic->data =3D head" arm of this if statement is no less fragile.
>=20
> As near as I can tell, this has been a problem forever. I'm not sure
> that minimizing au_rslack recently changed this pathology much.
>=20
> So instead, let's use a more straightforward approach: kmalloc a
> separate buffer to linearize the checksum. This is similar to
> how gss_validate() currently works.
>=20
> Coming back to this code, I had some trouble understanding what
> was going on. So I've cleaned up the variable naming and added
> a few comments that point back to the XDR definition in RFC 2203
> to help guide future spelunkers, including myself.
>=20
> As an added clean up, the functionality that was in
> xdr_buf_read_mic() is folded directly into gss_unwrap_resp_integ(),
> as that is its only caller.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> net/sunrpc/auth_gss/auth_gss.c |   79 =
++++++++++++++++++++++++++++++----------
> 1 file changed, 60 insertions(+), 19 deletions(-)
>=20
> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
> index 24ca861815b1..fa991f4fe53a 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -1934,35 +1934,71 @@ static int gss_wrap_req(struct rpc_task *task, =
struct xdr_stream *xdr)
> 	return 0;
> }
>=20
> +/*
> + * RFC 2203, Section 5.3.2.2
> + *
> + *	struct rpc_gss_integ_data {
> + *		opaque databody_integ<>;
> + *		opaque checksum<>;
> + *	};
> + *
> + *	struct rpc_gss_data_t {
> + *		unsigned int seq_num;
> + *		proc_req_arg_t arg;
> + *	};
> + */
> static int
> gss_unwrap_resp_integ(struct rpc_task *task, struct rpc_cred *cred,
> 		      struct gss_cl_ctx *ctx, struct rpc_rqst *rqstp,
> 		      struct xdr_stream *xdr)
> {
> -	struct xdr_buf integ_buf, *rcv_buf =3D &rqstp->rq_rcv_buf;
> -	u32 data_offset, mic_offset, integ_len, maj_stat;
> +	struct xdr_buf gss_data, *rcv_buf =3D &rqstp->rq_rcv_buf;
> 	struct rpc_auth *auth =3D cred->cr_auth;
> +	u32 len, offset, seqno, maj_stat;
> 	struct xdr_netobj mic;
> -	__be32 *p;
> +	int ret;
>=20
> -	p =3D xdr_inline_decode(xdr, 2 * sizeof(*p));
> -	if (unlikely(!p))
> +	ret =3D -EIO;
> +	mic.data =3D NULL;
> +
> +	/* opaque databody_integ<>; */
> +	if (xdr_stream_decode_u32(xdr, &len))
> 		goto unwrap_failed;
> -	integ_len =3D be32_to_cpup(p++);
> -	if (integ_len & 3)
> +	if (len & 3)
> 		goto unwrap_failed;
> -	data_offset =3D (u8 *)(p) - (u8 *)rcv_buf->head[0].iov_base;
> -	mic_offset =3D integ_len + data_offset;
> -	if (mic_offset > rcv_buf->len)
> +	offset =3D rcv_buf->len - xdr_stream_remaining(xdr);
> +	if (xdr_stream_decode_u32(xdr, &seqno))
> 		goto unwrap_failed;
> -	if (be32_to_cpup(p) !=3D rqstp->rq_seqno)
> +	if (seqno !=3D rqstp->rq_seqno)
> 		goto bad_seqno;
> +	if (xdr_buf_subsegment(rcv_buf, &gss_data, offset, len))
> +		goto unwrap_failed;
>=20
> -	if (xdr_buf_subsegment(rcv_buf, &integ_buf, data_offset, =
integ_len))
> +	/*
> +	 * The xdr_stream now points to the beginning of the
> +	 * upper layer payload, to be passed below to
> +	 * rpcauth_unwrap_resp_decode(). The checksum, which
> +	 * follows the upper layer payload in @rcv_buf, is
> +	 * located and parsed without updating the xdr_stream.
> +	 */
> +
> +	/* opaque checksum<>; */
> +	offset +=3D len;
> +	if (xdr_decode_word(rcv_buf, offset, &len))
> +		goto unwrap_failed;
> +	offset +=3D sizeof(__be32);
> +	if (len > GSS_VERF_SLACK << 2)
> 		goto unwrap_failed;

Based on the conversation in the other thread about NFSv3 + krb5p,
this would appear to be an arbitrary and over-aggressive sanity check.

I'll post a v3 of this series with this check removed.


> -	if (xdr_buf_read_mic(rcv_buf, &mic, mic_offset))
> +	if (offset + len > rcv_buf->len)
> 		goto unwrap_failed;
> -	maj_stat =3D gss_verify_mic(ctx->gc_gss_ctx, &integ_buf, &mic);
> +	mic.len =3D len;
> +	mic.data =3D kmalloc(len, GFP_NOFS);
> +	if (!mic.data)
> +		goto unwrap_failed;
> +	if (read_bytes_from_xdr_buf(rcv_buf, offset, mic.data, mic.len))
> +		goto unwrap_failed;
> +
> +	maj_stat =3D gss_verify_mic(ctx->gc_gss_ctx, &gss_data, &mic);
> 	if (maj_stat =3D=3D GSS_S_CONTEXT_EXPIRED)
> 		clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
> 	if (maj_stat !=3D GSS_S_COMPLETE)
> @@ -1970,16 +2006,21 @@ static int gss_wrap_req(struct rpc_task *task, =
struct xdr_stream *xdr)
>=20
> 	auth->au_rslack =3D auth->au_verfsize + 2 + 1 + =
XDR_QUADLEN(mic.len);
> 	auth->au_ralign =3D auth->au_verfsize + 2;
> -	return 0;
> +	ret =3D 0;
> +
> +out:
> +	kfree(mic.data);
> +	return ret;
> +
> unwrap_failed:
> 	trace_rpcgss_unwrap_failed(task);
> -	return -EIO;
> +	goto out;
> bad_seqno:
> -	trace_rpcgss_bad_seqno(task, rqstp->rq_seqno, be32_to_cpup(p));
> -	return -EIO;
> +	trace_rpcgss_bad_seqno(task, rqstp->rq_seqno, seqno);
> +	goto out;
> bad_mic:
> 	trace_rpcgss_verify_mic(task, maj_stat);
> -	return -EIO;
> +	goto out;
> }
>=20
> static int
>=20

--
Chuck Lever



