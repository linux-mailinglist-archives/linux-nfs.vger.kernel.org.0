Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE21F1F06
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 20:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgFHSbv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgFHSbu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 14:31:50 -0400
X-Greylist: delayed 95387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Jun 2020 11:31:49 PDT
Received: from chicago.messinet.com (chicago.messinet.com [IPv6:2603:300a:134:50e0::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF76C08C5C2
        for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2020 11:31:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by chicago.messinet.com (Postfix) with ESMTP id 6F46AD24EA;
        Mon,  8 Jun 2020 13:31:48 -0500 (CDT)
X-Virus-Scanned: amavisd-new at messinet.com
Received: from chicago.messinet.com ([127.0.0.1])
        by localhost (chicago.messinet.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id fcauc2yDW7lq; Mon,  8 Jun 2020 13:31:47 -0500 (CDT)
Received: from linux-ws1.messinet.com (unknown [IPv6:2603:300a:134:50e0:c85d:2a82:9e5a:450f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by chicago.messinet.com (Postfix) with ESMTPSA id 2EFFDD24E8;
        Mon,  8 Jun 2020 13:31:47 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 chicago.messinet.com 2EFFDD24E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=messinet.com;
        s=20170806; t=1591641107;
        bh=udhEx4cjyZ0TAnIz16NCdeGdJeYd5EGL59vddiDQ1oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSrP/09A8wAGvJaTsGJpLQ43BsNFEPCTdIASmjG+NPkYW71i9CdjvdCOl0KBYlo2P
         vT0g0qNu8oDnWV/28Kcj6caxapXxbVzQoxMfekMD1/GSJVih+H979ARxgGpLoYJjQM
         +mToVJQZUvD9wJS/+77cAYmei4yDasgv8gq0zbfhQQbRS3aj28jBjDo3Nzrh6eNmTx
         uyD1EikQGwgMwrGgjeYpSorGokVT27Vl7zFE00E/Sfy1rK4iAFjKustqx7SBV1uvFD
         LzR9z691SGl2GOSJzVR6zk6jgJ4NtRsqxUSK0gjXws902QBge/m3dAyhfHTLjhcYes
         DPpP4Ay8FJumg==
From:   Anthony Joseph Messina <amessina@messinet.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Hans-Peter Jansen <hpj@urpla.net>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: general protection fault, probably for non-canonical address in nfsd
Date:   Mon, 08 Jun 2020 13:31:41 -0500
Message-ID: <4609258.31r3eYUQgx@linux-ws1.messinet.com>
In-Reply-To: <13519623.o9HzBvYcLm@xrated>
References: <15780697.tcFqIYE18H@xrated> <2B6CBC8C-A1D4-4C39-AF45-958847C99572@oracle.com> <13519623.o9HzBvYcLm@xrated>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2202458.ElGaqSPkdT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--nextPart2202458.ElGaqSPkdT
Content-Type: multipart/mixed; boundary="nextPart4281770.LvFx2qVVIh"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart4281770.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 8, 2020 12:53:26 PM CDT Hans-Peter Jansen wrote:
> Am Montag, 8. Juni 2020, 17:28:53 CEST schrieb Chuck Lever:
> > > On Jun 7, 2020, at 1:44 PM, Hans-Peter Jansen <hpj@urpla.net> wrote:
> > > 
> > > Am Sonntag, 7. Juni 2020, 18:01:55 CEST schrieb Anthony Joseph Messina:
> > >> On Sunday, June 7, 2020 10:32:44 AM CDT Hans-Peter Jansen wrote:
> > >>> Hi,
> > >>> 
> > >>> after upgrading the kernel from 5.6.11 to 5.6.14, we suffer from
> > >>> regular
> > >>> crashes of nfsd here:
> > >>> 
> > >>> 2020-06-07T01:32:43.600306+02:00 server rpc.mountd[2664]:
> > >>> authenticated
> > >>> mount request from 192.168.3.16:303 for /work (/work)
> > >>> 2020-06-07T01:32:43.602594+02:00 server rpc.mountd[2664]:
> > >>> authenticated
> > >>> mount request from 192.168.3.16:304 for /work/vmware (/work)
> > >>> 2020-06-07T01:32:43.602971+02:00 server rpc.mountd[2664]:
> > >>> authenticated
> > >>> mount request from 192.168.3.16:305 for /work/vSphere (/work)
> > >>> 2020-06-07T01:32:43.606276+02:00 server kernel: [51901.089211] general
> > >>> protection fault, probably for non-canonical address
> > >>> 0xb9159d506ba40000:
> > >>> 0000 [#1] SMP PTI 2020-06-07T01:32:43.606284+02:00 server kernel:
> > >>> [51901.089226] CPU: 1 PID: 3190 Comm: nfsd Tainted: G           O
> > >>> 5.6.14-lp151.2-default #1 openSUSE Tumbleweed (unreleased)
> > >>> 2020-06-07T01:32:43.606286+02:00 server kernel: [51901.089234]
> > >>> Hardware
> > >>> name: System manufacturer System Product Name/P7F-E, BIOS 0906
> > >> 
> > >> I see similar issues in Fedora kernels 5.6.14 through 5.6.16
> > >> https://bugzilla.redhat.com/show_bug.cgi?id=1839287
> > >> 
> > >> On the client I mount /home with sec=krb5p, and /mnt/koji with sec=krb5
> > > 
> > > Thanks for confirmation.
> > > 
> > > Apart from the hassle with server reboots, this issue has some DOS
> > > potential, I'm afraid.
> > 
> > If you have a reproducer (even a partial one) then bisecting between a
> > known good kernel and v5.6.14 (or 16) would be helpful.
> 
> I would love to bisect, but this is my primary production machine, that
> needs to be up as much as possible. Apart from that, I'm about to leave the
> site for a week and been severely time constrained for the next couple of
> weeks..
> 
> Sorry.
> 
> Anthony?

Unfortunately, this is also my main workstation and I have no experience 
building custom kernels.  The diff in net/sunrpc between v5.6.13 and v5.6.14 
is relatively small, though it may not point to the root issue.  I'm typically 
only able to "follow along" code like this to spot issues, being a nurse, not 
a kernel programmer.

Thank you for your help.  -A

-- 
Anthony - https://messinet.com
F9B6 560E 68EA 037D 8C3D  D1C9 FF31 3BDB D9D8 99B6

--nextPart4281770.LvFx2qVVIh
Content-Disposition: attachment; filename="net-sunrpc-v5.6.13_v5.6.14.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="net-sunrpc-v5.6.13_v5.6.14.txt"

 net/sunrpc/auth_gss/auth_gss.c        | 12 ++++------
 net/sunrpc/auth_gss/gss_krb5_crypto.c |  8 +++----
 net/sunrpc/auth_gss/gss_krb5_wrap.c   | 44 +++++++++++++++++++++++------------
 net/sunrpc/auth_gss/gss_mech_switch.c |  3 ++-
 net/sunrpc/auth_gss/svcauth_gss.c     | 10 +++-----
 net/sunrpc/clnt.c                     |  5 ++++
 net/sunrpc/xdr.c                      | 41 ++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/backchannel.c     |  2 +-
 net/sunrpc/xprtrdma/frwr_ops.c        | 14 +++++++----
 net/sunrpc/xprtrdma/transport.c       |  2 +-
 net/sunrpc/xprtrdma/verbs.c           | 15 +++++-------
 net/sunrpc/xprtrdma/xprt_rdma.h       |  5 ++--
 12 files changed, 108 insertions(+), 53 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 2dc740acb3bf..a7ad150fd4ee 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -2030,7 +2030,6 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 	struct xdr_buf *rcv_buf = &rqstp->rq_rcv_buf;
 	struct kvec *head = rqstp->rq_rcv_buf.head;
 	struct rpc_auth *auth = cred->cr_auth;
-	unsigned int savedlen = rcv_buf->len;
 	u32 offset, opaque_len, maj_stat;
 	__be32 *p;
 
@@ -2041,9 +2040,9 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 	offset = (u8 *)(p) - (u8 *)head->iov_base;
 	if (offset + opaque_len > rcv_buf->len)
 		goto unwrap_failed;
-	rcv_buf->len = offset + opaque_len;
 
-	maj_stat = gss_unwrap(ctx->gc_gss_ctx, offset, rcv_buf);
+	maj_stat = gss_unwrap(ctx->gc_gss_ctx, offset,
+			      offset + opaque_len, rcv_buf);
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
 		clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
 	if (maj_stat != GSS_S_COMPLETE)
@@ -2057,10 +2056,9 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 	 */
 	xdr_init_decode(xdr, rcv_buf, p, rqstp);
 
-	auth->au_rslack = auth->au_verfsize + 2 +
-			  XDR_QUADLEN(savedlen - rcv_buf->len);
-	auth->au_ralign = auth->au_verfsize + 2 +
-			  XDR_QUADLEN(savedlen - rcv_buf->len);
+	auth->au_rslack = auth->au_verfsize + 2 + ctx->gc_gss_ctx->slack;
+	auth->au_ralign = auth->au_verfsize + 2 + ctx->gc_gss_ctx->align;
+
 	return 0;
 unwrap_failed:
 	trace_rpcgss_unwrap_failed(task);
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 6f2d30d7b766..e7180da1fc6a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -851,8 +851,8 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 }
 
 u32
-gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
-		     u32 *headskip, u32 *tailskip)
+gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
+		     struct xdr_buf *buf, u32 *headskip, u32 *tailskip)
 {
 	struct xdr_buf subbuf;
 	u32 ret = 0;
@@ -881,7 +881,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
 
 	/* create a segment skipping the header and leaving out the checksum */
 	xdr_buf_subsegment(buf, &subbuf, offset + GSS_KRB5_TOK_HDR_LEN,
-				    (buf->len - offset - GSS_KRB5_TOK_HDR_LEN -
+				    (len - offset - GSS_KRB5_TOK_HDR_LEN -
 				     kctx->gk5e->cksumlength));
 
 	nblocks = (subbuf.len + blocksize - 1) / blocksize;
@@ -926,7 +926,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
 		goto out_err;
 
 	/* Get the packet's hmac value */
-	ret = read_bytes_from_xdr_buf(buf, buf->len - kctx->gk5e->cksumlength,
+	ret = read_bytes_from_xdr_buf(buf, len - kctx->gk5e->cksumlength,
 				      pkt_hmac, kctx->gk5e->cksumlength);
 	if (ret)
 		goto out_err;
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 6c1920eed771..cf0fd170ac18 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -261,7 +261,9 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
 }
 
 static u32
-gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
+gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, int len,
+		       struct xdr_buf *buf, unsigned int *slack,
+		       unsigned int *align)
 {
 	int			signalg;
 	int			sealalg;
@@ -279,12 +281,13 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	u32			conflen = kctx->gk5e->conflen;
 	int			crypt_offset;
 	u8			*cksumkey;
+	unsigned int		saved_len = buf->len;
 
 	dprintk("RPC:       gss_unwrap_kerberos\n");
 
 	ptr = (u8 *)buf->head[0].iov_base + offset;
 	if (g_verify_token_header(&kctx->mech_used, &bodysize, &ptr,
-					buf->len - offset))
+					len - offset))
 		return GSS_S_DEFECTIVE_TOKEN;
 
 	if ((ptr[0] != ((KG_TOK_WRAP_MSG >> 8) & 0xff)) ||
@@ -324,6 +327,7 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	    (!kctx->initiate && direction != 0))
 		return GSS_S_BAD_SIG;
 
+	buf->len = len;
 	if (kctx->enctype == ENCTYPE_ARCFOUR_HMAC) {
 		struct crypto_sync_skcipher *cipher;
 		int err;
@@ -376,11 +380,15 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	data_len = (buf->head[0].iov_base + buf->head[0].iov_len) - data_start;
 	memmove(orig_start, data_start, data_len);
 	buf->head[0].iov_len -= (data_start - orig_start);
-	buf->len -= (data_start - orig_start);
+	buf->len = len - (data_start - orig_start);
 
 	if (gss_krb5_remove_padding(buf, blocksize))
 		return GSS_S_DEFECTIVE_TOKEN;
 
+	/* slack must include room for krb5 padding */
+	*slack = XDR_QUADLEN(saved_len - buf->len);
+	/* The GSS blob always precedes the RPC message payload */
+	*align = *slack;
 	return GSS_S_COMPLETE;
 }
 
@@ -486,7 +494,9 @@ gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
 }
 
 static u32
-gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
+gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
+		       struct xdr_buf *buf, unsigned int *slack,
+		       unsigned int *align)
 {
 	time64_t	now;
 	u8		*ptr;
@@ -532,7 +542,7 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	if (rrc != 0)
 		rotate_left(offset + 16, buf, rrc);
 
-	err = (*kctx->gk5e->decrypt_v2)(kctx, offset, buf,
+	err = (*kctx->gk5e->decrypt_v2)(kctx, offset, len, buf,
 					&headskip, &tailskip);
 	if (err)
 		return GSS_S_FAILURE;
@@ -542,7 +552,7 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	 * it against the original
 	 */
 	err = read_bytes_from_xdr_buf(buf,
-				buf->len - GSS_KRB5_TOK_HDR_LEN - tailskip,
+				len - GSS_KRB5_TOK_HDR_LEN - tailskip,
 				decrypted_hdr, GSS_KRB5_TOK_HDR_LEN);
 	if (err) {
 		dprintk("%s: error %u getting decrypted_hdr\n", __func__, err);
@@ -568,18 +578,19 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	 * Note that buf->head[0].iov_len may indicate the available
 	 * head buffer space rather than that actually occupied.
 	 */
-	movelen = min_t(unsigned int, buf->head[0].iov_len, buf->len);
+	movelen = min_t(unsigned int, buf->head[0].iov_len, len);
 	movelen -= offset + GSS_KRB5_TOK_HDR_LEN + headskip;
-	if (offset + GSS_KRB5_TOK_HDR_LEN + headskip + movelen >
-	    buf->head[0].iov_len)
-		return GSS_S_FAILURE;
+	BUG_ON(offset + GSS_KRB5_TOK_HDR_LEN + headskip + movelen >
+							buf->head[0].iov_len);
 	memmove(ptr, ptr + GSS_KRB5_TOK_HDR_LEN + headskip, movelen);
 	buf->head[0].iov_len -= GSS_KRB5_TOK_HDR_LEN + headskip;
-	buf->len -= GSS_KRB5_TOK_HDR_LEN + headskip;
+	buf->len = len - GSS_KRB5_TOK_HDR_LEN + headskip;
 
 	/* Trim off the trailing "extra count" and checksum blob */
-	buf->len -= ec + GSS_KRB5_TOK_HDR_LEN + tailskip;
+	xdr_buf_trim(buf, ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
 
+	*align = XDR_QUADLEN(GSS_KRB5_TOK_HDR_LEN + headskip);
+	*slack = *align + XDR_QUADLEN(ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
 	return GSS_S_COMPLETE;
 }
 
@@ -603,7 +614,8 @@ gss_wrap_kerberos(struct gss_ctx *gctx, int offset,
 }
 
 u32
-gss_unwrap_kerberos(struct gss_ctx *gctx, int offset, struct xdr_buf *buf)
+gss_unwrap_kerberos(struct gss_ctx *gctx, int offset,
+		    int len, struct xdr_buf *buf)
 {
 	struct krb5_ctx	*kctx = gctx->internal_ctx_id;
 
@@ -613,9 +625,11 @@ gss_unwrap_kerberos(struct gss_ctx *gctx, int offset, struct xdr_buf *buf)
 	case ENCTYPE_DES_CBC_RAW:
 	case ENCTYPE_DES3_CBC_RAW:
 	case ENCTYPE_ARCFOUR_HMAC:
-		return gss_unwrap_kerberos_v1(kctx, offset, buf);
+		return gss_unwrap_kerberos_v1(kctx, offset, len, buf,
+					      &gctx->slack, &gctx->align);
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		return gss_unwrap_kerberos_v2(kctx, offset, buf);
+		return gss_unwrap_kerberos_v2(kctx, offset, len, buf,
+					      &gctx->slack, &gctx->align);
 	}
 }
diff --git a/net/sunrpc/auth_gss/gss_mech_switch.c b/net/sunrpc/auth_gss/gss_mech_switch.c
index db550bfc2642..69316ab1b9fa 100644
--- a/net/sunrpc/auth_gss/gss_mech_switch.c
+++ b/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -411,10 +411,11 @@ gss_wrap(struct gss_ctx	*ctx_id,
 u32
 gss_unwrap(struct gss_ctx	*ctx_id,
 	   int			offset,
+	   int			len,
 	   struct xdr_buf	*buf)
 {
 	return ctx_id->mech_type->gm_ops
-		->gss_unwrap(ctx_id, offset, buf);
+		->gss_unwrap(ctx_id, offset, len, buf);
 }
 
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 65b67b257302..322fd48887f9 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -900,7 +900,7 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	if (svc_getnl(&buf->head[0]) != seq)
 		goto out;
 	/* trim off the mic and padding at the end before returning */
-	buf->len -= 4 + round_up_to_quad(mic.len);
+	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
 	stat = 0;
 out:
 	kfree(mic.data);
@@ -928,7 +928,7 @@ static int
 unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
 {
 	u32 priv_len, maj_stat;
-	int pad, saved_len, remaining_len, offset;
+	int pad, remaining_len, offset;
 
 	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
@@ -948,12 +948,8 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	buf->len -= pad;
 	fix_priv_head(buf, pad);
 
-	/* Maybe it would be better to give gss_unwrap a length parameter: */
-	saved_len = buf->len;
-	buf->len = priv_len;
-	maj_stat = gss_unwrap(ctx, 0, buf);
+	maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
 	pad = priv_len - buf->len;
-	buf->len = saved_len;
 	buf->len -= pad;
 	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
 	 * In the krb5p case, at least, the data ends up offset, so we need to
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 7324b21f923e..3ceaefb2f0bc 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2416,6 +2416,11 @@ rpc_check_timeout(struct rpc_task *task)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 
+	if (RPC_SIGNALLED(task)) {
+		rpc_call_rpcerror(task, -ERESTARTSYS);
+		return;
+	}
+
 	if (xprt_adjust_timeout(task->tk_rqstp) == 0)
 		return;
 
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e5497dc2475b..f6da616267ce 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1150,6 +1150,47 @@ xdr_buf_subsegment(struct xdr_buf *buf, struct xdr_buf *subbuf,
 }
 EXPORT_SYMBOL_GPL(xdr_buf_subsegment);
 
+/**
+ * xdr_buf_trim - lop at most "len" bytes off the end of "buf"
+ * @buf: buf to be trimmed
+ * @len: number of bytes to reduce "buf" by
+ *
+ * Trim an xdr_buf by the given number of bytes by fixing up the lengths. Note
+ * that it's possible that we'll trim less than that amount if the xdr_buf is
+ * too small, or if (for instance) it's all in the head and the parser has
+ * already read too far into it.
+ */
+void xdr_buf_trim(struct xdr_buf *buf, unsigned int len)
+{
+	size_t cur;
+	unsigned int trim = len;
+
+	if (buf->tail[0].iov_len) {
+		cur = min_t(size_t, buf->tail[0].iov_len, trim);
+		buf->tail[0].iov_len -= cur;
+		trim -= cur;
+		if (!trim)
+			goto fix_len;
+	}
+
+	if (buf->page_len) {
+		cur = min_t(unsigned int, buf->page_len, trim);
+		buf->page_len -= cur;
+		trim -= cur;
+		if (!trim)
+			goto fix_len;
+	}
+
+	if (buf->head[0].iov_len) {
+		cur = min_t(size_t, buf->head[0].iov_len, trim);
+		buf->head[0].iov_len -= cur;
+		trim -= cur;
+	}
+fix_len:
+	buf->len -= (len - trim);
+}
+EXPORT_SYMBOL_GPL(xdr_buf_trim);
+
 static void __read_bytes_from_xdr_buf(struct xdr_buf *subbuf, void *obj, unsigned int len)
 {
 	unsigned int this_len;
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 1a0ae0c61353..4b43910a6ed2 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -115,7 +115,7 @@ int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst)
 	if (rc < 0)
 		goto failed_marshal;
 
-	if (rpcrdma_ep_post(&r_xprt->rx_ia, &r_xprt->rx_ep, req))
+	if (rpcrdma_post_sends(r_xprt, req))
 		goto drop_connection;
 	return 0;
 
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 125297c9aa3e..79059d48f52b 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -372,18 +372,22 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 }
 
 /**
- * frwr_send - post Send WR containing the RPC Call message
- * @ia: interface adapter
- * @req: Prepared RPC Call
+ * frwr_send - post Send WRs containing the RPC Call message
+ * @r_xprt: controlling transport instance
+ * @req: prepared RPC Call
  *
  * For FRWR, chain any FastReg WRs to the Send WR. Only a
  * single ib_post_send call is needed to register memory
  * and then post the Send WR.
  *
- * Returns the result of ib_post_send.
+ * Returns the return code from ib_post_send.
+ *
+ * Caller must hold the transport send lock to ensure that the
+ * pointers to the transport's rdma_cm_id and QP are stable.
  */
-int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req)
+int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
+	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct ib_send_wr *post_wr;
 	struct rpcrdma_mr *mr;
 
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 3cfeba68ee9a..46e7949788e1 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -694,7 +694,7 @@ xprt_rdma_send_request(struct rpc_rqst *rqst)
 		goto drop_connection;
 	rqst->rq_xtime = ktime_get();
 
-	if (rpcrdma_ep_post(&r_xprt->rx_ia, &r_xprt->rx_ep, req))
+	if (rpcrdma_post_sends(r_xprt, req))
 		goto drop_connection;
 
 	rqst->rq_xmit_bytes_sent += rqst->rq_snd_buf.len;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 353f61ac8d51..a48b99f3682c 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1502,20 +1502,17 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 }
 
 /**
- * rpcrdma_ep_post - Post WRs to a transport's Send Queue
- * @ia: transport's device information
- * @ep: transport's RDMA endpoint information
+ * rpcrdma_post_sends - Post WRs to a transport's Send Queue
+ * @r_xprt: controlling transport instance
  * @req: rpcrdma_req containing the Send WR to post
  *
  * Returns 0 if the post was successful, otherwise -ENOTCONN
  * is returned.
  */
-int
-rpcrdma_ep_post(struct rpcrdma_ia *ia,
-		struct rpcrdma_ep *ep,
-		struct rpcrdma_req *req)
+int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *send_wr = &req->rl_wr;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int rc;
 
 	if (!ep->rep_send_count || kref_read(&req->rl_kref) > 1) {
@@ -1526,8 +1523,8 @@ rpcrdma_ep_post(struct rpcrdma_ia *ia,
 		--ep->rep_send_count;
 	}
 
-	rc = frwr_send(ia, req);
-	trace_xprtrdma_post_send(req, rc);
+	trace_xprtrdma_post_send(req);
+	rc = frwr_send(r_xprt, req);
 	if (rc)
 		return -ENOTCONN;
 	return 0;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 37d5080c250b..600574a0d838 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -469,8 +469,7 @@ void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt);
 int rpcrdma_ep_connect(struct rpcrdma_ep *, struct rpcrdma_ia *);
 void rpcrdma_ep_disconnect(struct rpcrdma_ep *, struct rpcrdma_ia *);
 
-int rpcrdma_ep_post(struct rpcrdma_ia *, struct rpcrdma_ep *,
-				struct rpcrdma_req *);
+int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp);
 
 /*
@@ -544,7 +543,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
 				int nsegs, bool writing, __be32 xid,
 				struct rpcrdma_mr *mr);
-int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req);
+int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);

--nextPart4281770.LvFx2qVVIh--

--nextPart2202458.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE+bZWDmjqA32MPdHJ/zE729nYmbYFAl7ehA4ACgkQ/zE729nY
mbb0hQ/8CGZA/BeRtJFsD+CNzyQbweEPUwqLi4I6T0PEBuHOooYE+MdjaxxaUDW6
xFIkNhGHTjiAnlcxpA6hoJb1yBH3dioIAJWW65YG8MevP3oF2sbL7fgXo1NaWIxD
+sY+Ewi4LAJn+aUI/Pna5cTWeGZ0evTpNbLjgEdlWmiJXXpjp3EzQk/8H5/tYs61
NHQXKc20BiyDsdQLAIoYJgR4a0uQG9iOjg9o152miNffLTeYUOQ9+8fI5ykKwY5c
jbiMGiF30TDTNO+9n0nhCXbUiz33kCF5tM1V7171jaf+4caoFoY/NcqkNdZ51R5i
koCHulfQiRUMYW1hl9huFNW8uH/XcPhVcYBm5i4QXxKf6K9if9XQukdjfQvn0Ds0
L3iLCymMDjkR1CZr94mZ/jkYaVm6BBkLRhy0h8F0pMs1LJRCbl5PaKqh2GC/mZMu
FNM0Eg3/leyUCKU3SFUxmPuBlGkebLegQ26lMu/SduzsJ1jEWm/93sfGZHcDAKHv
hiaIwcJuoNRHoshPmpwLVgl60mEFAH5WA/ZCIiIj8r44q+y0suMk16LErVYElEGo
thmCGT8Om8+qJ8N8efvosBC7EjbYiFciOwRLvoF0kNRO7Odz7i21u3C0RwWtk2Xr
wTUWmfDNsElIEBnFD+TzKa8Jsv/1R8mVuEkgrTs1xZky7B6IER0=
=p4my
-----END PGP SIGNATURE-----

--nextPart2202458.ElGaqSPkdT--



