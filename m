Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896C13684AA
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 18:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhDVQUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 12:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbhDVQUB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 12:20:01 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75114C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 09:19:26 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z25so11533309qtn.8
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4Won+z+SIOosS2Cf32ulmHS+mQZcmErNv1XOsooV7U=;
        b=GJJo2Z/5ywuz3/asEefy8x0vmJrUhzjcn2K9bL5jUDReevVdN5L/nHdqVZjgwMxNHA
         pSe2CI9y3hMB7g3IlF30L/99/yv+mepqCb9DKuHkP8JlHHmWL33NphAKMB4cRprRhZrT
         +zJ9QbvdcMIzYlwHNy92VTmFj3ZdVA7d9P3OAiU+A5RTyBISz+pILiPWROguj2da4Kmd
         dak1p4J+jt3ENL56tjWmubOibdhvNvVlQFjI+bY1nphkza2L9z7pTd5x0+1OBM6Q+3S9
         WStjsPesUqdrppLJXj2xOL7buX15Q3RF6gPOcVEnklhLin9nxtckadhyEVRpqDVow0bS
         lX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4Won+z+SIOosS2Cf32ulmHS+mQZcmErNv1XOsooV7U=;
        b=oNJeCpuiOMr1fa5nslQmjLQXrZtWz9OHuugb+HYo/nlLRocQQaNZkHfx/PYhsKkSsb
         x7Lq5sY2ce4lPGaQmKH3fUKszIBxQJRqWk9adSk0tEi0Hq0dqgEOMIkmNmYUWcrjww+R
         mSpaMhkzDmuEVA85A0Dv5xctIuNmWnbHDcu1lwHmi6n2ws0A25M19w6D76cqdLx2hfeI
         WDelcnayKL3ObOMM82Qukx0ib0GM2OBzKVdVSf3NbX6wlYxpsmrIwfCZEuOsjVuhDVvF
         uX9K0hlCQP7+dcUaUa080MKsaRmKBd2ka2dF07Y+ETPp12dcTtsyo2RZHIvJ7aIXWzWU
         IOuw==
X-Gm-Message-State: AOAM5316AQkvAgTSTocOex07We/EheTVuIAKaNrhYCfPbKPfPGVk2u/V
        SODSOVB/cRPNOaEmP04jcV4=
X-Google-Smtp-Source: ABdhPJyRnfA0HcVsnNR1t/ovJWKvQoLaoHHc+iJmkVj2/ohWis7yfnuSS2eMzWPEDu83BS2K5EtA/Q==
X-Received: by 2002:ac8:548f:: with SMTP id h15mr3908603qtq.29.1619108365612;
        Thu, 22 Apr 2021 09:19:25 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id c26sm2524091qtw.36.2021.04.22.09.19.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Apr 2021 09:19:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC 1/1] NFSD add vfs_fsync after async copy is done
Date:   Thu, 22 Apr 2021 12:19:22 -0400
Message-Id: <20210422161922.56080-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, the server does all copies as NFS_UNSTABLE. For synchronous
copies linux client will append a COMMIT to the COPY compound but for
async copies it does not (because COMMIT needs to be done after all
bytes are copied and not as a reply to the COPY operation).

However, in order to save the client doing a COMMIT as a separate
rpc, the server can reply back with NFS_FILE_SYNC copy. This patch
proposed to add vfs_fsync() call at the end of the async copy.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 66dea2f1eed8..c6f45f67d59b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1536,19 +1536,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
 	.done = nfsd4_cb_offload_done
 };
 
-static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
+static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync,
+				bool committed)
 {
-	copy->cp_res.wr_stable_how = NFS_UNSTABLE;
+	copy->cp_res.wr_stable_how = committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
 	copy->cp_synchronous = sync;
 	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
 }
 
-static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
+static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy, bool *committed)
 {
 	ssize_t bytes_copied = 0;
 	size_t bytes_total = copy->cp_count;
 	u64 src_pos = copy->cp_src_pos;
 	u64 dst_pos = copy->cp_dst_pos;
+	__be32 status;
 
 	do {
 		if (kthread_should_stop())
@@ -1563,6 +1565,15 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 		src_pos += bytes_copied;
 		dst_pos += bytes_copied;
 	} while (bytes_total > 0 && !copy->cp_synchronous);
+	/* for a non-zero asynchronous copy do a commit of data */
+	if (!copy->cp_synchronous && bytes_copied > 0) {
+		down_write(&copy->nf_dst->nf_rwsem);
+		status = vfs_fsync_range(copy->nf_dst->nf_file,
+					 copy->cp_dst_pos, bytes_copied, 0);
+		up_write(&copy->nf_dst->nf_rwsem);
+		if (!status)
+			*committed = true;
+	}
 	return bytes_copied;
 }
 
@@ -1570,15 +1581,16 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
 {
 	__be32 status;
 	ssize_t bytes;
+	bool committed = false;
 
-	bytes = _nfsd_copy_file_range(copy);
+	bytes = _nfsd_copy_file_range(copy, &committed);
 	/* for async copy, we ignore the error, client can always retry
 	 * to get the error
 	 */
 	if (bytes < 0 && !copy->cp_res.wr_bytes_written)
 		status = nfserrno(bytes);
 	else {
-		nfsd4_init_copy_res(copy, sync);
+		nfsd4_init_copy_res(copy, sync, committed);
 		status = nfs_ok;
 	}
 
-- 
2.27.0

