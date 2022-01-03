Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD44837CF
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 20:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiACT4Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 14:56:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39460 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiACT4Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 14:56:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78D35B8109D
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 19:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9313C36AE9;
        Mon,  3 Jan 2022 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641239783;
        bh=z4PurGPupYocyZ8Wl4EKp0AqYlYv3BNFg3QN5mF5cyk=;
        h=From:To:Cc:Subject:Date:From;
        b=lO4VhCpxqbIFMOS/4iTtTvk41GPmAQHTo749Mt7S9f4dGs1lMpE5bbvXiT1GLKwm3
         QlDJOIfuswoI/Q3/hECCfwGsV9PIq8WAAO6bpLQPy7w2Lte1niBSDJm+8FQNNXuEC9
         dysV4zTz65UGqCBxUcXouSfqqGSpaHsYiYlT5+uePAQ+6/ULVZ1a2n47oAAfNmc1Tc
         OTxzzcKusnEErbtGV2ibbOS3SR8KuEHJ0I3QU41+DcAmH7Yb6kP0Bb9yl2SPyl/vaU
         VCvaRiMsljcHXztnRvHKuQc5yLDEN62JvI7HRFEAvmpx2POgvwGpvdh8JTYvKp4vPl
         O4bNdFUfpJ+Pg==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     rtm@csail.mit.edu, linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.1: Fix uninitialised variable in devicenotify
Date:   Mon,  3 Jan 2022 14:50:16 -0500
Message-Id: <20220103195016.17095-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When decode_devicenotify_args() exits with no entries, we need to
ensure that the struct cb_devicenotifyargs is initialised to
{ 0, NULL } in order to avoid problems in
nfs4_callback_devicenotify().

Reported-by: <rtm@csail.mit.edu>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback.h      |  2 +-
 fs/nfs/callback_proc.c |  2 +-
 fs/nfs/callback_xdr.c  | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 6a2033131c06..ccd4f245cae2 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -170,7 +170,7 @@ struct cb_devicenotifyitem {
 };
 
 struct cb_devicenotifyargs {
-	int				 ndevs;
+	uint32_t			 ndevs;
 	struct cb_devicenotifyitem	 *devs;
 };
 
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 09c5b1cb3e07..c343666d9a42 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -358,7 +358,7 @@ __be32 nfs4_callback_devicenotify(void *argp, void *resp,
 				  struct cb_process_state *cps)
 {
 	struct cb_devicenotifyargs *args = argp;
-	int i;
+	uint32_t i;
 	__be32 res = 0;
 	struct nfs_client *clp = cps->clp;
 	struct nfs_server *server = NULL;
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 4c48d85f6517..ce3d1d5b1291 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -258,11 +258,9 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 				void *argp)
 {
 	struct cb_devicenotifyargs *args = argp;
+	uint32_t tmp, n, i;
 	__be32 *p;
 	__be32 status = 0;
-	u32 tmp;
-	int n, i;
-	args->ndevs = 0;
 
 	/* Num of device notifications */
 	p = xdr_inline_decode(xdr, sizeof(uint32_t));
@@ -271,7 +269,7 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 		goto out;
 	}
 	n = ntohl(*p++);
-	if (n <= 0)
+	if (n == 0)
 		goto out;
 	if (n > ULONG_MAX / sizeof(*args->devs)) {
 		status = htonl(NFS4ERR_BADXDR);
@@ -330,19 +328,21 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 			dev->cbd_immediate = 0;
 		}
 
-		args->ndevs++;
-
 		dprintk("%s: type %d layout 0x%x immediate %d\n",
 			__func__, dev->cbd_notify_type, dev->cbd_layout_type,
 			dev->cbd_immediate);
 	}
+	args->ndevs = n;
+	dprintk("%s: ndevs %d\n", __func__, args->ndevs);
+	return 0;
+err:
+	kfree(args->devs);
 out:
+	args->devs = NULL;
+	args->ndevs = 0;
 	dprintk("%s: status %d ndevs %d\n",
 		__func__, ntohl(status), args->ndevs);
 	return status;
-err:
-	kfree(args->devs);
-	goto out;
 }
 
 static __be32 decode_sessionid(struct xdr_stream *xdr,
-- 
2.33.1

