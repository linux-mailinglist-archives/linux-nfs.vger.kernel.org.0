Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8EF66169C
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjAHQ30 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjAHQ3X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EBD1E1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E7E60C8C
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F475C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195361;
        bh=XJlX7SVbSFooarE6ZChy3YEAsu1nxHsHLQduCtUC/Z8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=eTw67LBbpcQDXo1mBSahNQcY0jWDXsNjNlXNDg8I7UV3i6iWrQbFkJB/YSy1Fo5tS
         vlSEz4reGtja9IAk1yRXZTLxMSgZh4CArEKS6q+2VOGp4Uyn7IVeDh5/6hubn+rABq
         RPBmTwndujZ3oCtrSZADTMgZndI4oLRsYxCiNLpPBVRSXZtUDmIFYJlsjXBwEO7vms
         TEsJY6ex0yHvCyOjrT4Tmzt66jasuL+TBOd1JTG0loc+f2ZOX+AfI+AAOhoGNROpgR
         be2h8HoQzTurmkJZrPWrYdHLJuS7OtSvMyz6XRVaIn2PmuDORnDIiFe656Fl6PHJWj
         SSgEXJz78wVOQ==
Subject: [PATCH v1 09/27] SUNRPC: Convert svcauth_gss_wrap_priv() to use
 xdr_stream()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:20 -0500
Message-ID: <167319536020.7490.3861780856965318259.stgit@bazille.1015granger.net>
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

Actually xdr_stream does not add value here because of how
gss_wrap() works. This is just a clean-up patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index cfcd74e6369d..6c49750c0f7a 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1830,6 +1830,11 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
  *		unsigned int seq_num;
  *		proc_req_arg_t arg;
  *	};
+ *
+ * gss_wrap() expands the size of the RPC message payload in the
+ * response buffer. The main purpose of svcauth_gss_wrap_priv()
+ * is to ensure there is adequate space in the response buffer to
+ * avoid overflow during the wrap.
  */
 static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 {
@@ -1847,9 +1852,9 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 
 	lenp = p++;
 	offset = (u8 *)p - (u8 *)head->iov_base;
-	*p++ = htonl(gc->gc_seq);
-	/* XXX: Would be better to write some xdr helper functions for
-	 * nfs{2,3,4}xdr.c that place the data right, instead of copying: */
+	/* Buffer space for this field has already been reserved
+	 * in svcauth_gss_accept(). */
+	*p = cpu_to_be32(gc->gc_seq);
 
 	/*
 	 * If there is currently tail data, make sure there is
@@ -1889,8 +1894,8 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_wrap;
 
-	*lenp = htonl(buf->len - offset);
-	pad = 3 - ((buf->len - offset - 1) & 3);
+	*lenp = cpu_to_be32(buf->len - offset);
+	pad = xdr_pad_size(buf->len - offset);
 	p = (__be32 *)(tail->iov_base + tail->iov_len);
 	memset(p, 0, pad);
 	tail->iov_len += pad;


