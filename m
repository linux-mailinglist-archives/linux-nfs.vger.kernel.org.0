Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB65FAD0F
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 08:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJKGwu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 02:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJKGws (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 02:52:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959780BD8
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 23:52:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g28so12693597pfk.8
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 23:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IhQCr2/mj1To+oAjfcYwW5DtgdU/tRz+Z1vgx/smBpw=;
        b=EIoaKf6Yioci3SpU35lj7pBWNJWY29BnptxpIevAzLWRb0fMQXSAVg9RZeBejpc3b/
         K6wswV5lkxcUX4noYIDUBvyRvXOK6DPTR/4tj1vT3l3HGO5FM2HjorhVjmt6xdSWwky9
         uMqRZskWt17tEX3HrKN2vJQhvQ2SrbWzknXc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhQCr2/mj1To+oAjfcYwW5DtgdU/tRz+Z1vgx/smBpw=;
        b=ZsPIhZtIqiblWil9mk3q5NpAXBKYWyRYJQA2LFm1n/c1AxFTLc0VWUqRVUneNYuEGG
         lQU8tojl+ddevKBmEeBwvZc62fnUdV2GJE0BhD44haz+SS0H9G89WYPPMYdRDOFQCqsS
         b1w4qq0WUrv32mXpQRL6L4FAUOX6IEWSGS1sG7XamMBANSc9+rmzuu6oNfC7mS2M++HB
         2z0Udguxvw6ISv3Ga1cg1rvZKTgFywdlv2bnDGidGamOGWjBrdtMbAwxZ0N5WMrM2U9T
         JLNyJ5DU1pgw3w2JPlWGXaam3NH4PZ0QLdwTIa60XcDMcrOJkttZFEFvshj/IFe2btVy
         x6Aw==
X-Gm-Message-State: ACrzQf1zDEltB4a6JWlgtJ9Y6T6tBG3Na4iRR6D5xJajTZYGHIRvzbat
        Fz6BqGJyUyAN6QEtIq+37X3TCw==
X-Google-Smtp-Source: AMsMyM6Kqhfv3NRPyt5rnHl2Q1aXOBuD+1vkAjs24JUi0+hR4+9li1k2ug5+2Md9Hy66LdAUpxUW6w==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr23253507pfb.43.1665471166164;
        Mon, 10 Oct 2022 23:52:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0017ca9f4d22fsm7812359plf.209.2022.10.10.23.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 23:52:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <yujie.liu@intel.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] NFS: Avoid memcpy() run-time warning for struct sockaddr overflows
Date:   Mon, 10 Oct 2022 23:52:43 -0700
Message-Id: <20221011065243.583650-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123; h=from:subject; bh=jFWeG4mKZjaCTmVttsBT+shSjRAcSAR+gkBCMpwmSmY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRRK7yqXTcuhapb8wt0RJRmg09UAG/TKO7oglxRdW fUaVX0eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0USuwAKCRCJcvTf3G3AJvslD/ 9rMzqrDJsGp2lh6GKEvBs28bCjDeXE2T7Cxi/kcY7Ig0nB2jUPlBR154A5lHiv13nNOwzwYRI8KyzS EY4dr1JmOCtv+YV8friFXHDCl/XZH/sgm5ZORmxYe6eOhEtirlIUrtNX6L2H7OQaEZNJaxs95oTIcn YbVhs1hld/dcMc59jYatSH3UvFuxEtJuyYnSRrOShtEswSY7LN0JOlH4A/obtgk/TMuUAaPoSz5AGp 1eKqmPrd+J5xsxjSBgtpMai2oXbOCNGPKl32MVK4dtw+6q/TrOQefDa2Vuzyjiw/jQKyUPXCjkIaku uo+eA0VlKL38fsrRvDCWq/cnmMPLEhrhnre7qxrUPdXACIy/wmnDK/k0fyv89RZsJDM9mUris0UeQh 2K4j8XalOzH/JRH1fCx18YAEmk1S++Np4r+JZcljnvMTZxMQlbeBkGsC15XIbrnBKZHPn/zG/HVW6n ze9+P+Cw8kHf70qSXdAhM05uuXIPOCA1sWdgyj+dPDBO+e9y83MomkH2GLt+5M8fXvH2R52BwsRVyt Rf4KB0xdwYx411OgsdlBB7xBIHvxsZu7ifi9sism/ahCDpaE+IKFQofw2dadbmqQWO3hQU+oBCktaV uyC7fxejf/vGiBTuy7wdoKunj/0T2Z3k1r/qZvsT7MupKRZ3/hClJhm5HQFQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The 'nfs_server' and 'mount_server' structures include a union of
'struct sockaddr' (with the older 16 bytes max address size) and
'struct sockaddr_storage' which is large enough to hold all the supported
sa_family types (128 bytes max size). The runtime memcpy() buffer overflow
checker is seeing attempts to write beyond the 16 bytes as an overflow,
but the actual expected size is that of 'struct sockaddr_storage'. Adjust
the pointers to the correct union member. Avoids this false positive
run-time warning under CONFIG_FORTIFY_SOURCE:

  memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/all/202210110948.26b43120-yujie.liu@intel.com
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/nfs/fs_context.c | 2 +-
 fs/nfs/namespace.c  | 2 +-
 fs/nfs/super.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 4da701fd1424..bffa31bb35b9 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1540,7 +1540,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->version		= nfss->nfs_client->rpc_ops->version;
 		ctx->minorversion	= nfss->nfs_client->cl_minorversion;
 
-		memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
+		memcpy(&ctx->nfs_server._address, &nfss->nfs_client->cl_addr,
 			ctx->nfs_server.addrlen);
 
 		if (fc->net_ns != net) {
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 3295af4110f1..2f336ace7555 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -175,7 +175,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	}
 
 	/* for submounts we want the same server; referrals will reassign */
-	memcpy(&ctx->nfs_server.address, &client->cl_addr, client->cl_addrlen);
+	memcpy(&ctx->nfs_server._address, &client->cl_addr, client->cl_addrlen);
 	ctx->nfs_server.addrlen	= client->cl_addrlen;
 	ctx->nfs_server.port	= server->port;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 82944e14fcea..8ea7dfdea427 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -823,7 +823,7 @@ static int nfs_request_mount(struct fs_context *fc,
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_mount_request request = {
 		.sap		= (struct sockaddr *)
-						&ctx->mount_server.address,
+						&ctx->mount_server._address,
 		.dirpath	= ctx->nfs_server.export_path,
 		.protocol	= ctx->mount_server.protocol,
 		.fh		= root_fh,
@@ -854,7 +854,7 @@ static int nfs_request_mount(struct fs_context *fc,
 	 * Construct the mount server's address.
 	 */
 	if (ctx->mount_server.address.sa_family == AF_UNSPEC) {
-		memcpy(request.sap, &ctx->nfs_server.address,
+		memcpy(request.sap, &ctx->nfs_server._address,
 		       ctx->nfs_server.addrlen);
 		ctx->mount_server.addrlen = ctx->nfs_server.addrlen;
 	}
-- 
2.34.1

