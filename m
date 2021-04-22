Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2957C3687E3
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 22:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhDVU3u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 16:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVU3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 16:29:49 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642CC06174A
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 13:29:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y12so34882764qtx.11
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4ph0CrvDNqS1hFw0T3aMNFdYeBxnYVqT0A8wFhW+ok=;
        b=bYTPCCGnz7VpQDuRn0DsQnaR5Ht7HKCEUYBWipPqmzVR4lz00TCTcFuTWVl3kNidjs
         KnvlccmuIZwSpAjX6LTCrwcop/wQ7ni1lJ5eWNRp5ZJNadNq7Gi9esNH23lfoDFKyvnr
         88J54SmFfEH4aGXqp2GxU3j/kNzBjF9OOGnLv1EWvmkhSF0IkSVqNk4eUlAeMl/HcrXo
         +WINmHpdP6VJ5BP41kOkCAIEVhiwuIZwFFHOHhdXaRJ7cxnmUwtJjOTCsLpaGzggdQBp
         O6XEy86t8jT3HUKGQeS+3zB8JZ7PGlcn2QKCdW2K/4NJYqyhOUU29J+N+bL5w0q0fcXi
         96kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4ph0CrvDNqS1hFw0T3aMNFdYeBxnYVqT0A8wFhW+ok=;
        b=YR1Xa0iQqBj+ila3aeNAW5wVPRs61R8dGUUVo8tAAzcemtkPfYFkKN3b8mZ3SCpk9k
         1OaGQvSawWru+hjINQz5jN1fgnSbcZrgeTfCJFbzLyFFTCH2QHzm5woreojEp5xPMozQ
         vIrEU82K/zqmtZ+SzWbOEHofCU0lOi3LhSf5Wyi7oQQDJyWiNa5RzWMWejEAIMa5fNz8
         Uvf3OHB2y957rKFH+jh5IEnqMY6OhalXwrom4WZ7+3h5sKNLWuxUFOyRGyEYJNO5As5d
         CqwCfRTpAVb0CX+bl6sNhs+KDOp888fdoX0UkXg8cZVov94sHh/gzOMUfi0rxrFD3BhB
         GByQ==
X-Gm-Message-State: AOAM5327rWd8UTvnnA5k/0/X/hA/bHCxAFgJ9I+0ZJumCx+rlUoOSjvM
        OxH0wfG8VIKLGk4Wy1o6snyr/LrAcOI=
X-Google-Smtp-Source: ABdhPJyNd1KkCZ/dYZDzByc8RYOgyKRMjIHnkxIKqeiSYIiCMrIJvYPdOD2OaaV3Rcg8GADzpwtbPA==
X-Received: by 2002:ac8:75ca:: with SMTP id z10mr281878qtq.137.1619123351590;
        Thu, 22 Apr 2021 13:29:11 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id d204sm2986934qke.3.2021.04.22.13.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Apr 2021 13:29:11 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC v2 1/1] NFSD add vfs_fsync after async copy is done
Date:   Thu, 22 Apr 2021 16:29:08 -0400
Message-Id: <20210422202908.60995-1-olga.kornievskaia@gmail.com>
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
 fs/nfsd/nfs4proc.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 66dea2f1eed8..f63a2cb14a5e 100644
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
@@ -1563,6 +1565,16 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 		src_pos += bytes_copied;
 		dst_pos += bytes_copied;
 	} while (bytes_total > 0 && !copy->cp_synchronous);
+	/* for a non-zero asynchronous copy do a commit of data */
+	if (!copy->cp_synchronous && copy->cp_res.wr_bytes_written > 0) {
+		down_write(&copy->nf_dst->nf_rwsem);
+		status = vfs_fsync_range(copy->nf_dst->nf_file,
+					 copy->cp_dst_pos,
+					 copy->cp_res.wr_bytes_written, 0);
+		up_write(&copy->nf_dst->nf_rwsem);
+		if (!status)
+			*committed = true;
+	}
 	return bytes_copied;
 }
 
@@ -1570,15 +1582,16 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
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

