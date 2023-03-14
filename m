Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F06B8FAA
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 11:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCNKV7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 06:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCNKVi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 06:21:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D379BE1D
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 03:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92B06B818DF
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 10:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97B8C433D2;
        Tue, 14 Mar 2023 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678789260;
        bh=IVQr2b2PGzyrTVkw2c87WGesfHlCwxdyfrJyp+MP7d4=;
        h=From:To:Cc:Subject:Date:From;
        b=jdP0cDZw+MTz6qD/CYGJLbJE3qktjjqd4w1wNuxcCk7r/a7vZPdkq7fHrg4oQp43i
         2ekpTol5UizBd9w0AGKPFVUaqjGQVwx9E3RDeL7IHuf+sF0bBJyM+rbIxU24LDplDH
         RQEDQ5dTKwZPg02IiuEv0hBdD9vtpT7St1pFXAImtCTJQ0yS4ee2xA8lbiZl69Y9Qn
         8hGoSwRuyI4nvp731cWkyG14XbNs7mCZe7lKA/+L3CJkGjU4PEhVd/vV56ERZv/USl
         KMvuK7vn898wGdO22wRQOBDPEJ6EZmd3YEMblvGbe3J6quwtJL8r+Uj1kS/h0ypShp
         mtSChtSPdVTXA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] lockd: set file_lock start and end when decoding nlm4 testargs
Date:   Tue, 14 Mar 2023 06:20:58 -0400
Message-Id: <20230314102058.10761-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 6930bcbfb6ce dropped the setting of the file_lock range when
decoding a nlm_lock off the wire. This causes the client side grant
callback to miss matching blocks and reject the lock, only to rerequest
it 30s later.

Add a helper function to set the file_lock range from the start and end
values that the protocol uses, and have the nlm_lock decoder call that to
set up the file_lock args properly.

Fixes: 6930bcbfb6ce ("lockd: detect and reject lock arguments that overflow")
Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/clnt4xdr.c        |  9 +--------
 fs/lockd/xdr4.c            | 13 ++++++++++++-
 include/linux/lockd/xdr4.h |  1 +
 3 files changed, 14 insertions(+), 9 deletions(-)

Hi Amir,

Thanks for the bug report. This patch seems to fix up the 30s stalls for
me. Can you give it a spin and see if it also helps you? I am still
seeing one test failure with nfstest_lock, but I'm not sure it's related
to this. I'll plan to follow up with Jorge.

Thanks,
Jeff

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 7df6324ccb8a..8161667c976f 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -261,7 +261,6 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 	u32 exclusive;
 	int error;
 	__be32 *p;
-	s32 end;
 
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(fl);
@@ -285,13 +284,7 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 	fl->fl_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
 	p = xdr_decode_hyper(p, &l_offset);
 	xdr_decode_hyper(p, &l_len);
-	end = l_offset + l_len - 1;
-
-	fl->fl_start = (loff_t)l_offset;
-	if (l_len == 0 || end < 0)
-		fl->fl_end = OFFSET_MAX;
-	else
-		fl->fl_end = (loff_t)end;
+	nlm4svc_set_file_lock_range(fl, l_offset, l_len);
 	error = 0;
 out:
 	return error;
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 712fdfeb8ef0..5fcbf30cd275 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -33,6 +33,17 @@ loff_t_to_s64(loff_t offset)
 	return res;
 }
 
+void nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len)
+{
+	s64 end = off + len - 1;
+
+	fl->fl_start = off;
+	if (len == 0 || end < 0)
+		fl->fl_end = OFFSET_MAX;
+	else
+		fl->fl_end = end;
+}
+
 /*
  * NLM file handles are defined by specification to be a variable-length
  * XDR opaque no longer than 1024 bytes. However, this implementation
@@ -80,7 +91,7 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 	locks_init_lock(fl);
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;
-
+	nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
 	return true;
 }
 
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index 9a6b55da8fd6..72831e35dca3 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -22,6 +22,7 @@
 #define	nlm4_fbig		cpu_to_be32(NLM_FBIG)
 #define	nlm4_failed		cpu_to_be32(NLM_FAILED)
 
+void	nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len);
 bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-- 
2.39.2

