Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8649603626
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 00:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJRWnx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 18:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJRWnw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 18:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33119D2586
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 15:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C726D61707
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 22:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F23C433C1;
        Tue, 18 Oct 2022 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666133030;
        bh=t2/xg3pT7kkeTRUALvA7eHeItxqCkGEC5tZzOF2LVPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRlNCOqq6ivJxGM8WQYsLzIAy3Be3WcsACYFvQgQKNXH8FEip5ahTScCHgFQ1zxOq
         VTvVz9uXID08jYxIxpymgLiMRaWC7m7t2jq6lGYygwD3i3i9Hrt8dlNwGHVQ8MnxLy
         yCJdzwG8TBmx9TCxzJsvIlG7ITCDHdbW3UvhcL3pazew8e0pZOUXvyTXv0/vS9c6DG
         /0+dw+ZFjcZ1GiLECv+8oT7Dvh/IpF0EqoKDv8n2/PjKTcPI1i8T253jGaE1OQOXYU
         74JR3nCgrzHtfLiSmG7YeayXuQbOx8sO8ouk4Ws4nNYdvjqQiHx2M7iLg71giBxQNA
         FfWGsQPk96W5Q==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv4.2: Always decode the security label
Date:   Tue, 18 Oct 2022 18:37:22 -0400
Message-Id: <20221018223723.21242-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018223723.21242-1-trondmy@kernel.org>
References: <20221018223723.21242-1-trondmy@kernel.org>
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

