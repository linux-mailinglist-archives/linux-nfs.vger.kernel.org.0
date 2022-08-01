Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAEE5871DC
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 21:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiHAT5c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiHAT5a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 15:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78771B848
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 12:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D0A6134F
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 19:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020BCC433C1;
        Mon,  1 Aug 2022 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659383848;
        bh=xQZ6DEhtmpuV7eWazUdBu4LXSsguZ4iCz5L9O507MXA=;
        h=From:To:Cc:Subject:Date:From;
        b=cDzHj6QD0j7Yprhv60lRwQmjzHY52astFra+rR5vSi6D+aw4rYOco9lugtih5Vhny
         +C4L9vuzY3obgIYYj1XwJl2DvlU/6gJjHNiX4UgfPz6BNlapdHQgfDzL/xk8r/gyrm
         ZQK3RgdzOcejOSyfaY2P5HjObTwtS1P3z9KoVv8m6y8DnN2I7PZlkcLHsYJ1Iv3HnI
         FT6qdhHanZBAB2MSdCZJ0q4dg594HFKu9EEBcpCt89drZrT7IrYNEyR5P0DWVjgy5A
         XE/UXMkD9e9sW7+3nZjoNFGUr+/ot+yc7WqHi94JuGrW76OvK9pQAozfuTgq9sbO2v
         vXzqJEvoShMGQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     bfields@fieldses.org, linux-nfs@vger.kernel.org,
        Jan Kasiak <j.kasiak@gmail.com>
Subject: [PATCH v2] lockd: detect and reject lock arguments that overflow
Date:   Mon,  1 Aug 2022 15:57:26 -0400
Message-Id: <20220801195726.154229-1-jlayton@kernel.org>
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
it should, and can end up generating lock requests with arguments that
overflow when passed to the filesystem.

The NLM4 protocol uses unsigned 64-bit arguments for both start and
length, whereas struct file_lock tracks the start and end as loff_t
values. By the time we get around to calling nlm4svc_retrieve_args,
we've lost the information that would allow us to determine if there was
an overflow.

Start tracking the actual start and len for NLM4 requests in the
nlm_lock. In nlm4svc_retrieve_args, vet these values to ensure they
won't cause an overflow, and return NLM4_FBIG if they do.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=392
Reported-by: Jan Kasiak <j.kasiak@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc4proc.c       |  8 ++++++++
 fs/lockd/xdr4.c           | 19 ++-----------------
 include/linux/lockd/xdr.h |  2 ++
 3 files changed, 12 insertions(+), 17 deletions(-)

v2: record args as u64s in nlm_lock and check them in
    nlm4svc_retrieve_args

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 176b468a61c7..e5adb524a445 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -32,6 +32,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	if (!nlmsvc_ops)
 		return nlm_lck_denied_nolocks;
 
+	if (lock->lock_start > OFFSET_MAX ||
+	    (lock->lock_len && ((lock->lock_len - 1) > (OFFSET_MAX - lock->lock_start))))
+		return nlm4_fbig;
+
 	/* Obtain host handle */
 	if (!(host = nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
 	 || (argp->monitor && nsm_monitor(host) < 0))
@@ -50,6 +54,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 		/* Set up the missing parts of the file_lock structure */
 		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
+		lock->fl.fl_start = (loff_t)lock->lock_start;
+		lock->fl.fl_end = lock->lock_len ?
+				   (loff_t)(lock->lock_start + lock->lock_len - 1) :
+				   OFFSET_MAX;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
 		if (!lock->fl.fl_owner) {
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 856267c0864b..712fdfeb8ef0 100644
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
@@ -70,8 +63,6 @@ static bool
 svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 {
 	struct file_lock *fl = &lock->fl;
-	u64 len, start;
-	s64 end;
 
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
 		return false;
@@ -81,20 +72,14 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 		return false;
 	if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
 		return false;
-	if (xdr_stream_decode_u64(xdr, &start) < 0)
+	if (xdr_stream_decode_u64(xdr, &lock->lock_start) < 0)
 		return false;
-	if (xdr_stream_decode_u64(xdr, &len) < 0)
+	if (xdr_stream_decode_u64(xdr, &lock->lock_len) < 0)
 		return false;
 
 	locks_init_lock(fl);
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;
-	end = start + len - 1;
-	fl->fl_start = s64_to_loff_t(start);
-	if (len == 0 || end < 0)
-		fl->fl_end = OFFSET_MAX;
-	else
-		fl->fl_end = s64_to_loff_t(end);
 
 	return true;
 }
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 398f70093cd3..67e4a2c5500b 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -41,6 +41,8 @@ struct nlm_lock {
 	struct nfs_fh		fh;
 	struct xdr_netobj	oh;
 	u32			svid;
+	u64			lock_start;
+	u64			lock_len;
 	struct file_lock	fl;
 };
 
-- 
2.37.1

