Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D24586F70
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiHARS0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 13:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiHARSZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 13:18:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B71D51
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 10:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04CE7B80EC0
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 17:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AE5C433C1;
        Mon,  1 Aug 2022 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374301;
        bh=6Yl4ApKRM1fLKWrVPHHLA9k89f1JwEzDtbi4GcNdQ4E=;
        h=From:To:Cc:Subject:Date:From;
        b=TLuUAJ4llVVFsEFwsIcTxeP5kt+GTkcmgjHXLHR470c8OFRavdG+4k89EpJaR+YBd
         EJQsxtsGsAfBONpvGSnFQs6z20549EDBJ0gMyKpmhmO/a+GfQTwjOKI2Nyf+HUDnaf
         0UdcAuoUhwWoLSwWUFQAkB/5ib1n4PXsjNflu3wKRVjS24o2CoawphtRS0S1iP+5l/
         kuCrWyn2YSUWaQFISZD2kgs/tTB+5UvYFyqlk6Bc2T7t20b9YufRv8Ra2xYfRVM+9x
         OSTqtf2nhTHaeLNRP0RdW8pKdAX+mfqGCJyLP79KM8039HXtYADOkCBlhvJE54AccK
         1syCTCrZ11cKg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     bfields@fieldses.org, linux-nfs@vger.kernel.org,
        Jan Kasiak <j.kasiak@gmail.com>
Subject: [PATCH] lockd: detect and reject lock arguments that overflow
Date:   Mon,  1 Aug 2022 13:18:19 -0400
Message-Id: <20220801171819.125532-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

lockd doesn't currently vet the start and length in nlm4 requests like
it should, and can end up requesting locks with arguments that overflow
to the filesystem.

The NLM4 protocol unsigned 64-bit arguments for both start and length,
whereas struct file_lock tracks the start and end as loff_t values. By
the time we get around to calling nlm4svc_retrieve_args, we've lost the
information that would allow us to determine if there was an overflow.

Track whether the arguments will overflow as a boolean in struct
nlm_lock, and test for that in nlm4svc_retrieve_args. While we're in
here, get rid of the useless s64_to_loff_t helper and just directly cast
the values.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=392
Reported-by: Jan Kasiak <j.kasiak@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc4proc.c       |  3 +++
 fs/lockd/xdr4.c           | 26 ++++++++++++--------------
 include/linux/lockd/xdr.h |  1 +
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 176b468a61c7..e781ac747961 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -32,6 +32,9 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	if (!nlmsvc_ops)
 		return nlm_lck_denied_nolocks;
 
+	if (lock->overflow)
+		return nlm4_fbig;
+
 	/* Obtain host handle */
 	if (!(host = nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
 	 || (argp->monitor && nsm_monitor(host) < 0))
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 856267c0864b..fd5de5481a6f 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -20,13 +20,6 @@
 
 #include "svcxdr.h"
 
-static inline loff_t
-s64_to_loff_t(__s64 offset)
-{
-	return (loff_t)offset;
-}
-
-
 static inline s64
 loff_t_to_s64(loff_t offset)
 {
@@ -71,7 +64,6 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 {
 	struct file_lock *fl = &lock->fl;
 	u64 len, start;
-	s64 end;
 
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
 		return false;
@@ -86,15 +78,21 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 	if (xdr_stream_decode_u64(xdr, &len) < 0)
 		return false;
 
+	/*
+	 * We don't preserve the actual arguments in the call, so once
+	 * the decoding is done, it's too late to detect overflow. Thus,
+	 * we track it here and check for it later.
+	 */
+	if (start > OFFSET_MAX || (len && ((len - 1) > (OFFSET_MAX - start)))) {
+		lock->overflow = true;
+		return true;
+	}
+
 	locks_init_lock(fl);
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;
-	end = start + len - 1;
-	fl->fl_start = s64_to_loff_t(start);
-	if (len == 0 || end < 0)
-		fl->fl_end = OFFSET_MAX;
-	else
-		fl->fl_end = s64_to_loff_t(end);
+	fl->fl_start = (loff_t)start;
+	fl->fl_end = len ? (loff_t)(start + len - 1) : OFFSET_MAX;
 
 	return true;
 }
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 398f70093cd3..a80112d18658 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -39,6 +39,7 @@ struct nlm_lock {
 	char *			caller;
 	unsigned int		len; 	/* length of "caller" */
 	struct nfs_fh		fh;
+	bool			overflow; /* lock range overflow */
 	struct xdr_netobj	oh;
 	u32			svid;
 	struct file_lock	fl;
-- 
2.37.1

