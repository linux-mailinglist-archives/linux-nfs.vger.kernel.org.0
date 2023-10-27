Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828C87D9E0A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjJ0Qcm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjJ0Qck (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 12:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE8F1A5
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 09:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35400C433C8;
        Fri, 27 Oct 2023 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698424357;
        bh=bvcLB87EpiqMop2KcgSWPaepucbenRNUuyGDBtNBqt8=;
        h=Subject:From:To:Cc:Date:From;
        b=nAlRrSe9OO5EiNEbyVaRx8+lhhx2+7u9Uca754hTUhkzG3RieeLx5+KBD9rrnRXT3
         lLuUwMPTLflMMHUEbXHiwZQxfWb3cXkA2/xBJZ/JjwLBck8BDnWlI+mbvExhpTwmUS
         Ds1X9K8+m3sfI4TNGNXIYCwAIrEqG6npzARI+iZT/arVrerVsShrmmUvPerYWSMTXU
         xC1HEzIC6XXzzIqVwQtpBUbqnJtFC5lsuCgrR6VuRDGaHjL8x00UKzAPIx8lazc7op
         /NU8oFrZ57uUSm39MmAMy/bR+v182bsqE0pOBPgkUtLcN3/4ER6GnwnWcqP4yX+vFV
         tEAi4rmbj+VCQ==
Subject: [PATCH RFC] SunRPC: Split server-side GSS sequence number window
 update
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Russell Cattelan <cattelan@thebarn.com>,
        David Howells <dhowells@redhat.com>,
        Simo Sorce <simo@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 27 Oct 2023 12:32:36 -0400
Message-ID: <169842400684.2384.5932301559665706233.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

RFC 2203 Section 5.3.3.1 says that the sequence number window check
on a server can advance the highest received sequence number only if
GSS_VerifyMIC() returns GSS_S_COMPLETE. Thus NFSD's implementation
calls GSS_VerifyMIC() first, then checks and updates the sequence
window under a spin lock.

The problem with this arrangement is that the kernel's
implementation of GSS_VerifyMIC() can sleep and schedule. Or a
version of checksum verification that hides timing could be in use.

Sometimes it can take several milliseconds for GSS_VerifyMIC() to
return. By that time, on a fast transport, the client has advanced
the GSS sequence number until the current sequence number being
checked falls below the current window.

RFC 2203 mandates that the server silently discard the request in
that case, which translates to a dropped connection and retransmit.
In some cases this leads to spurious I/O errors or even data
corruption.

This issue affects all NFS versions using GSS Kerberos.

To avoid the latency of GSS_VerifyMIC() triggering GSS sequence
window bounds check failures, perform the lower bound check
/before/ calling gss_verify_mic().

Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=416
Cc: Russell Cattelan <cattelan@thebarn.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Simo Sorce <simo@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   63 ++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 16 deletions(-)

This is untested, but it's a possible way to reduce spurious
failures seen when using sec=krb5[ip]. At this point, I'm
interested in thoughts and comments.

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 18734e70c5dd..ebaa5c68d22f 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -640,7 +640,38 @@ gss_svc_searchbyctx(struct cache_detail *cd, struct xdr_netobj *handle)
 }
 
 /**
- * gss_check_seq_num - GSS sequence number window check
+ * gss_seq_num_lower_bound - GSS sequence number window check
+ * @rqstp: RPC Call to use when reporting errors
+ * @rsci: cached GSS context state (updated on return)
+ * @seq_num: sequence number to check
+ *
+ * Implements the lower bound check part of the sequence number
+ * algorithm as specified in RFC 2203, Section 5.3.3.1. "Context
+ * Management". This is lockless since we're not updating the
+ * window here. Also, it happens before GSS_VerifyMIC() since MIC
+ * verification can take a long time during which the window can
+ * advance considerably.
+ *
+ * Return values:
+ *   %true: @rqstp's GSS sequence number is inside the window
+ *   %false: @rqstp's GSS sequence number is below the window
+ */
+static bool gss_seq_num_lower_bound(const struct svc_rqst *rqstp,
+				    const struct rsc *rsci, u32 seq_num)
+{
+	const struct gss_svc_seq_data *sd = &rsci->seqdata;
+	unsigned int max = READ_ONCE(sd->sd_max);
+
+	if (seq_num + GSS_SEQ_WIN <= max) {
+		trace_rpcgss_svc_seqno_low(rqstp, seq_num,
+					   max - GSS_SEQ_WIN, max);
+		return false;
+	}
+	return true;
+}
+
+/**
+ * gss_seq_num_update - GSS sequence number window update
  * @rqstp: RPC Call to use when reporting errors
  * @rsci: cached GSS context state (updated on return)
  * @seq_num: sequence number to check
@@ -652,8 +683,8 @@ gss_svc_searchbyctx(struct cache_detail *cd, struct xdr_netobj *handle)
  *   %true: @rqstp's GSS sequence number is inside the window
  *   %false: @rqstp's GSS sequence number is outside the window
  */
-static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
-			      u32 seq_num)
+static bool gss_seq_num_update(const struct svc_rqst *rqstp, struct rsc *rsci,
+			       u32 seq_num)
 {
 	struct gss_svc_seq_data *sd = &rsci->seqdata;
 	bool result = false;
@@ -669,8 +700,6 @@ static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
 		}
 		__set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win);
 		goto ok;
-	} else if (seq_num + GSS_SEQ_WIN <= sd->sd_max) {
-		goto toolow;
 	}
 	if (__test_and_set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win))
 		goto alreadyseen;
@@ -681,11 +710,6 @@ static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
 	spin_unlock(&sd->sd_lock);
 	return result;
 
-toolow:
-	trace_rpcgss_svc_seqno_low(rqstp, seq_num,
-				   sd->sd_max - GSS_SEQ_WIN,
-				   sd->sd_max);
-	goto out;
 alreadyseen:
 	trace_rpcgss_svc_seqno_seen(rqstp, seq_num);
 	goto out;
@@ -709,6 +733,14 @@ svcauth_gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
 	struct xdr_netobj	checksum;
 	struct kvec		iov;
 
+	if (unlikely(gc->gc_seq > MAXSEQ)) {
+		trace_rpcgss_svc_seqno_large(rqstp, gc->gc_seq);
+		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
+		return SVC_DENIED;
+	}
+	if (!gss_seq_num_lower_bound(rqstp, rsci, gc->gc_seq))
+		return SVC_DROP;
+
 	/*
 	 * Compute the checksum of the incoming Call from the
 	 * XID field to credential field:
@@ -738,12 +770,11 @@ svcauth_gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
 		return SVC_DENIED;
 	}
 
-	if (gc->gc_seq > MAXSEQ) {
-		trace_rpcgss_svc_seqno_large(rqstp, gc->gc_seq);
-		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
-		return SVC_DENIED;
-	}
-	if (!gss_check_seq_num(rqstp, rsci, gc->gc_seq))
+	/*
+	 * RFC 2203 states that the sequence number window should
+	 * be updated only if GSS_VerifyMIC returns GSS_S_COMPLETE.
+	 */
+	if (!gss_seq_num_update(rqstp, rsci, gc->gc_seq))
 		return SVC_DROP;
 	return SVC_OK;
 }


