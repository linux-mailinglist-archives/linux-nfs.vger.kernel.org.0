Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265F865B589
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjABRG6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbjABRGr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DA364DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5FC8CCE0EE7
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882D2C433F0
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679202;
        bh=XLOZGwCmrrPngXD3i1hxIWksEdDSGfVOPAX3dHWGAik=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Qr4W9RqKv8jyLo6aC02O6A2aL5sShuKaJuzLtdcSKNOH9oRAtUwR20CyFJMiesMoT
         5cNj+4/cSN4SanmJyK06fKyQebJcr/xbRSMMQGSQwCmn0wN5F7fTP2KqZH+0JfLsmO
         3UtwiSAHighB276TZ+cTYNXjhHdOfe1Ldhb63kAyhSOppDGmFxnqzfWnhSoGEFNFln
         SSC+wZvJSprscWktk0+8e1yXcgFBo0fNZ2tsVQli8d74IP9EnDKDZLpZ8Pob+5V1l7
         zmya7ZosC6wIvCXHZkj8/yTEddtYjD+tTh3rGocfQly2t8uR4fYrnAF5IMUx+rCeU1
         UR3zhhhb8HRtg==
Subject: [PATCH v1 12/25] SUNRPC: Replace read_u32_from_xdr_buf() with
 existing XDR helper
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:41 -0500
Message-ID: <167267920149.112521.13845164649149713172.stgit@manet.1015granger.net>
In-Reply-To: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

Clean up / code de-duplication - this functionality is already
available in the generic XDR layer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 8e8dec664a89..0f9700c86f62 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -891,19 +891,6 @@ svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
 }
 EXPORT_SYMBOL_GPL(svcauth_gss_register_pseudoflavor);
 
-static inline int
-read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
-{
-	__be32  raw;
-	int     status;
-
-	status = read_bytes_from_xdr_buf(buf, base, &raw, sizeof(*obj));
-	if (status)
-		return status;
-	*obj = ntohl(raw);
-	return 0;
-}
-
 /* It would be nice if this bit of code could be shared with the client.
  * Obstacles:
  *	The client shouldn't malloc(), would have to pass in own memory.
@@ -937,8 +924,7 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	if (xdr_buf_subsegment(buf, &integ_buf, 0, integ_len))
 		goto unwrap_failed;
 
-	/* copy out mic... */
-	if (read_u32_from_xdr_buf(buf, integ_len, &mic.len))
+	if (xdr_decode_word(buf, integ_len, &mic.len))
 		goto unwrap_failed;
 	if (mic.len > sizeof(gsd->gsd_scratch))
 		goto unwrap_failed;


