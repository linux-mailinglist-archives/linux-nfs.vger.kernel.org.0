Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7866616B9
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjAHQcz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjAHQ2r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:28:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897071E1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:28:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48EDEB801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7D5C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195324;
        bh=CgQt5z+QmRjPlG92uuk3VbwwdRA8HOGso7urp92tBzE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=bzdOdsaT2nr6okbCWZpOjdIphWsp7MFk/w+iuguPK8F8OrhXJhqxrtdb4igJ7e4zp
         tK4J/IaqCGMC88AikhTH686hHX5dG4v6WBK14JOWQ1BeeW0GE5RYwq9D+XithaWvvW
         ql1X70/yZnx3Oot/IXmnGnnYAqTsLa0EYlsASFpJnGksi3danmerp46JK0Fay2RrEA
         Dg+r12moguQ2ImnEPW6T2xo9VUl15hAw6FnWu0rZnCdWwtqcE70JlaUHdCfoW0Eqkt
         WN6FgZoxd0VoOygPEJ8bxTOBSr5h/QEow8RflxvDqFwJkiXd7L2R6CTl2aFfTd22Kc
         mn9JsgwEQ9Ryg==
Subject: [PATCH v1 03/27] SUNRPC: Record gss_get_mic() errors in
 svcauth_gss_wrap_integ()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:28:42 -0500
Message-ID: <167319532298.7490.6629715101889997663.stgit@bazille.1015granger.net>
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

An error computing the checksum here is an exceptional event.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcgss.h     |    1 +
 net/sunrpc/auth_gss/svcauth_gss.c |   26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 3f121eed369e..261751ac241c 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -208,6 +208,7 @@ DECLARE_EVENT_CLASS(rpcgss_svc_gssapi_class,
 
 DEFINE_SVC_GSSAPI_EVENT(unwrap);
 DEFINE_SVC_GSSAPI_EVENT(mic);
+DEFINE_SVC_GSSAPI_EVENT(get_mic);
 
 TRACE_EVENT(rpcgss_svc_unwrap_failed,
 	TP_PROTO(
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index fe0bd0ad8ace..2d1e8431e903 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1782,10 +1782,9 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 	struct xdr_buf *buf = &rqstp->rq_res;
 	struct xdr_buf databody_integ;
 	struct xdr_netobj checksum;
+	u32 offset, len, maj_stat;
 	struct kvec *resv;
-	u32 offset, len;
 	__be32 *p;
-	int stat = -EINVAL;
 
 	p = svcauth_gss_prepare_to_wrap(buf, gsd);
 	if (p == NULL)
@@ -1796,21 +1795,20 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 		goto out;
 	*p++ = htonl(len);
 	*p++ = htonl(gc->gc_seq);
-	if (xdr_buf_subsegment(buf, &databody_integ, offset, len)) {
-		WARN_ON_ONCE(1);
-		goto out_err;
-	}
+	if (xdr_buf_subsegment(buf, &databody_integ, offset, len))
+		goto wrap_failed;
 	if (!buf->tail[0].iov_base) {
 		if (buf->head[0].iov_len + RPC_MAX_AUTH_SIZE > PAGE_SIZE)
-			goto out_err;
+			goto wrap_failed;
 		buf->tail[0].iov_base = buf->head[0].iov_base
 						+ buf->head[0].iov_len;
 		buf->tail[0].iov_len = 0;
 	}
 	resv = &buf->tail[0];
 	checksum.data = (u8 *)resv->iov_base + resv->iov_len + 4;
-	if (gss_get_mic(gsd->rsci->mechctx, &databody_integ, &checksum))
-		goto out_err;
+	maj_stat = gss_get_mic(gsd->rsci->mechctx, &databody_integ, &checksum);
+	if (maj_stat != GSS_S_COMPLETE)
+		goto bad_mic;
 	svc_putnl(resv, checksum.len);
 	memset(checksum.data + checksum.len, 0,
 	       round_up_to_quad(checksum.len) - checksum.len);
@@ -1818,11 +1816,13 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 	/* not strictly required: */
 	buf->len += XDR_QUADLEN(checksum.len) << 2;
 	if (resv->iov_len > PAGE_SIZE)
-		goto out_err;
+		goto wrap_failed;
 out:
-	stat = 0;
-out_err:
-	return stat;
+	return 0;
+bad_mic:
+	trace_rpcgss_svc_get_mic(rqstp, maj_stat);
+wrap_failed:
+	return -EINVAL;
 }
 
 static inline int


