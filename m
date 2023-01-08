Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538DF661698
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjAHQ3O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjAHQ3N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7331E1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25D74B801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6236C433EF
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195348;
        bh=q8ePbn7JgPU3n77v/Vqr3GIufd4WlayW8ZUdzCCFKeQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=HTZ0bYiFK5jj5vgtiUdlvPQZTAARnpPKIxAvGogVTSB43LHf9VdT6guNfcoZUsu8m
         y5ngtWIC3T4dIbP7S1FGJKpDdcnGMY51M8V0tlEilDhnyTq0wf5+qJ6FdpOBv+9XKS
         Lzoq4kiYe49HawsiY5uAHhii6/k6P16QnmDQ86hV+9Yg9LZCf8cANWDxBecglOb1ic
         3rZyuw9GJmyXWo4SW35lP2/EDRkOLCYxUYvczw0+iNWIlGjJ8nER4cXRGfIkoq++Uo
         y8l1d+UTruiCeKjSABphCezfxfACdUxUU6U2m/kQqdopmgwxdO/TJDOFWDZy9ftlsC
         Hozb9aldXbwDg==
Subject: [PATCH v1 07/27] SUNRPC: Record gss_wrap() errors in
 svcauth_gss_wrap_priv()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:07 -0500
Message-ID: <167319534785.7490.16274848447001502338.stgit@bazille.1015granger.net>
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Match the error reporting in the other unwrap and wrap functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcgss.h     |   21 +++++++++++++++++++++
 net/sunrpc/auth_gss/svcauth_gss.c |   29 +++++++++++++++++++----------
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 261751ac241c..ba2d96a1bc2f 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -206,10 +206,31 @@ DECLARE_EVENT_CLASS(rpcgss_svc_gssapi_class,
 			),						\
 			TP_ARGS(rqstp, maj_stat))
 
+DEFINE_SVC_GSSAPI_EVENT(wrap);
 DEFINE_SVC_GSSAPI_EVENT(unwrap);
 DEFINE_SVC_GSSAPI_EVENT(mic);
 DEFINE_SVC_GSSAPI_EVENT(get_mic);
 
+TRACE_EVENT(rpcgss_svc_wrap_failed,
+	TP_PROTO(
+		const struct svc_rqst *rqstp
+	),
+
+	TP_ARGS(rqstp),
+
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__string(addr, rqstp->rq_xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s xid=0x%08x", __get_str(addr), __entry->xid)
+);
+
 TRACE_EVENT(rpcgss_svc_unwrap_failed,
 	TP_PROTO(
 		const struct svc_rqst *rqstp
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index f0cd89f201bc..573b9d029709 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1813,7 +1813,9 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 
 bad_mic:
 	trace_rpcgss_svc_get_mic(rqstp, maj_stat);
+	return -EINVAL;
 wrap_failed:
+	trace_rpcgss_svc_wrap_failed(rqstp);
 	return -EINVAL;
 }
 
@@ -1834,18 +1836,16 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	struct gss_svc_data *gsd = rqstp->rq_auth_data;
 	struct rpc_gss_wire_cred *gc = &gsd->clcred;
 	struct xdr_buf *buf = &rqstp->rq_res;
-	struct page **inpages = NULL;
+	u32 offset, pad, maj_stat;
 	__be32 *p, *lenp;
-	int offset;
-	int pad;
 
 	p = svcauth_gss_prepare_to_wrap(buf, gsd);
 	if (p == NULL)
 		return 0;
+
 	lenp = p++;
 	offset = (u8 *)p - (u8 *)buf->head[0].iov_base;
 	*p++ = htonl(gc->gc_seq);
-	inpages = buf->pages;
 	/* XXX: Would be better to write some xdr helper functions for
 	 * nfs{2,3,4}xdr.c that place the data right, instead of copying: */
 
@@ -1859,12 +1859,12 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	if (buf->tail[0].iov_base) {
 		if (buf->tail[0].iov_base >=
 			buf->head[0].iov_base + PAGE_SIZE)
-			return -EINVAL;
+			goto wrap_failed;
 		if (buf->tail[0].iov_base < buf->head[0].iov_base)
-			return -EINVAL;
+			goto wrap_failed;
 		if (buf->tail[0].iov_len + buf->head[0].iov_len
 				+ 2 * RPC_MAX_AUTH_SIZE > PAGE_SIZE)
-			return -ENOMEM;
+			goto wrap_failed;
 		memmove(buf->tail[0].iov_base + RPC_MAX_AUTH_SIZE,
 			buf->tail[0].iov_base,
 			buf->tail[0].iov_len);
@@ -1879,13 +1879,16 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	 */
 	if (!buf->tail[0].iov_base) {
 		if (buf->head[0].iov_len + 2 * RPC_MAX_AUTH_SIZE > PAGE_SIZE)
-			return -ENOMEM;
+			goto wrap_failed;
 		buf->tail[0].iov_base = buf->head[0].iov_base
 			+ buf->head[0].iov_len + RPC_MAX_AUTH_SIZE;
 		buf->tail[0].iov_len = 0;
 	}
-	if (gss_wrap(gsd->rsci->mechctx, offset, buf, inpages))
-		return -ENOMEM;
+
+	maj_stat = gss_wrap(gsd->rsci->mechctx, offset, buf, buf->pages);
+	if (maj_stat != GSS_S_COMPLETE)
+		goto bad_wrap;
+
 	*lenp = htonl(buf->len - offset);
 	pad = 3 - ((buf->len - offset - 1) & 3);
 	p = (__be32 *)(buf->tail[0].iov_base + buf->tail[0].iov_len);
@@ -1894,6 +1897,12 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	buf->len += pad;
 
 	return 0;
+wrap_failed:
+	trace_rpcgss_svc_wrap_failed(rqstp);
+	return -EINVAL;
+bad_wrap:
+	trace_rpcgss_svc_wrap(rqstp, maj_stat);
+	return -ENOMEM;
 }
 
 /**


