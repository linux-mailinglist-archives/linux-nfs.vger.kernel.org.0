Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21C8661694
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjAHQ24 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjAHQ2v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:28:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E411E1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1A9860CA4
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183FEC433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195330;
        bh=3j3GF5g7jnc2jqxOrkddOI7pyogY86xCrfJVtxdbELo=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=BohVGQt5pXlj6IDZlsAdEkQJcWHgGtTGyBXt3a/NwLce929AKgIyH9GmvsvWhvfjw
         B4AerQGcRZBjrocaXcekMuXB9FAs7wXPFaOT3MeTtDgFKsSEqFASKqzRjBD3RkwMdi
         tPDPLJcWVf1Feks7SyDjvwdotqCkQpo/QOpqOYuo595FnAcNi9Up2VbkqbHmzC06py
         /W4MKrbecWwKjZogbHfSAiE5vrumYhDFLsi859YuQzAYVbBK0/4vSZDaLyfr1iufXu
         lE4HgREE14P6UhpuX9nafAIUslIW6aaKBUcFWS+DSqxihNo3ctrv0GqNOtCAJf19Pd
         tf+rRgGYYxvdA==
Subject: [PATCH v1 04/27] SUNRPC: Replace checksum construction in
 svcauth_gss_wrap_integ()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:28:49 -0500
Message-ID: <167319532919.7490.2863207896087099817.stgit@bazille.1015granger.net>
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

Replace finicky logic: Instead of trying to find scratch space in
the response buffer, use the scratch buffer from struct
gss_svc_data.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 2d1e8431e903..6aefe24953fa 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1797,15 +1797,8 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 	*p++ = htonl(gc->gc_seq);
 	if (xdr_buf_subsegment(buf, &databody_integ, offset, len))
 		goto wrap_failed;
-	if (!buf->tail[0].iov_base) {
-		if (buf->head[0].iov_len + RPC_MAX_AUTH_SIZE > PAGE_SIZE)
-			goto wrap_failed;
-		buf->tail[0].iov_base = buf->head[0].iov_base
-						+ buf->head[0].iov_len;
-		buf->tail[0].iov_len = 0;
-	}
-	resv = &buf->tail[0];
-	checksum.data = (u8 *)resv->iov_base + resv->iov_len + 4;
+
+	checksum.data = gsd->gsd_scratch;
 	maj_stat = gss_get_mic(gsd->rsci->mechctx, &databody_integ, &checksum);
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_mic;


