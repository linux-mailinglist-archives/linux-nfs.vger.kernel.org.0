Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757A604F16
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJSRnp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiJSRno (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 13:43:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D641C2F08
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 10:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A3B2B81E62
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 17:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA572C433D7;
        Wed, 19 Oct 2022 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666201419;
        bh=t2/xg3pT7kkeTRUALvA7eHeItxqCkGEC5tZzOF2LVPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkftqZ6arxFo9KTPueBx6JXeVMkDJ35jbGREQC7V0kD+TbQhVF0kSkMj2gSDRcQJ5
         pcNJ/QMwa+euS+wy8pykUKtAIuZ2f0jt5aVhM13BlrWymoriKOFsab3rJJDGf7+U3h
         MOq3ptiD1xWiYLcEEaJ3dj/zHFe+xtB90839wpNqm3z6UxIzznWX1UMBC9A3ReIM/L
         VSrgK4C7iPxCxJvZMyiJOjksczB67Brdq0TLmZsnLGMLk2YcvcMutws9svK7U5A+Mi
         QWmq8uz+90KodG3WbzEY8xts70Jyb8I7NUVAqPNqmh6c9mgmyDYN4z2fVKKqPNUmfC
         t0qBTjLMkyC8g==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/4] NFSv4.2: Always decode the security label
Date:   Wed, 19 Oct 2022 13:36:49 -0400
Message-Id: <20221019173651.32096-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019173651.32096-1-trondmy@kernel.org>
References: <20221019173651.32096-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server returns a reply that includes a security label, then we
must decode it whether or not we can store the results.

Fixes: 1e2f67da8931 ("NFS: Remove the nfs4_label argument from decode_getattr_*() functions")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 8c5298e37f0f..9103e022376a 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4755,12 +4755,10 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 	if (status < 0)
 		goto xdr_error;
 
-	if (fattr->label) {
-		status = decode_attr_security_label(xdr, bitmap, fattr->label);
-		if (status < 0)
-			goto xdr_error;
-		fattr->valid |= status;
-	}
+	status = decode_attr_security_label(xdr, bitmap, fattr->label);
+	if (status < 0)
+		goto xdr_error;
+	fattr->valid |= status;
 
 xdr_error:
 	dprintk("%s: xdr returned %d\n", __func__, -status);
-- 
2.37.3

