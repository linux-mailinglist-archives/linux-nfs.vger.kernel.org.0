Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66A93895C2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhESStv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhESStv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 14:49:51 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7FEC06175F
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 11:48:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d11so14043521iod.5
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuoGN7JBHwUqZqy7m8vweTl4mwEgy/OwasjCHs0IVBI=;
        b=vhfq1rp7QcqQaBCQyq5WSL3ejIOBlVX7JwHQJljljFpLm99ZUQeZ6vqj3HwTOiG/tM
         8jPoPRQ5U6diyVcUZtXMtxnGSjclM8Ebhb+TeMkaXT8SaXrFoKEEtnbJLGJD3yl/Asbk
         x1vqmOh8D0bgynSitD6o+vp9e7vZKmhZOHZ108tjpKRS/l86AYIjjX4891Zv5IxBOP+Q
         Q1rdOweteUifxR9xw8cDlZXGWkqunCuGTf15QW/KI5hNDFduDRaY+d8iTnl5Cd8GKmCx
         2A04k+AsJ+eZr1gGqgcq+5pYHSiqBLRwLN5ZmSWU0UCaCmA0R5l65uzUC4Jt2nbuw8Q9
         reSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuoGN7JBHwUqZqy7m8vweTl4mwEgy/OwasjCHs0IVBI=;
        b=ZW4FAKo98HhaAv6WJS5amd2EQgdk3QyHsjWzkksqf5sDFvnAToVBnCVixhKXEtuZBG
         4SdPdG2gNvWpDUX+shSGB2UmnJWvjEUKF9xdvGR4xM7eZEbiO/19opbt2cRi+FoZwGGx
         Dguaix270t8ybUl/AZA/fiPQghbsgmh4/I2XUYrcIl+wBPHvNMu3RcQ4OUWSujZUlawG
         vCyxMmRetKdIj/6tNhJMM9o4qGu031Fd22qpSKlwDHGLqHwEawz93Vh9hrdYnmEQVebR
         sVmNLgCIqvTiAnV9z2Ko5dxZBV2ezlpdKzTqDiNroWItzSEmnwZJUwXjhktYSQhWDgUk
         7O/g==
X-Gm-Message-State: AOAM531ZMd3TJDtPnw9hBVyCg1Uc/0OhC70zqWwhvqySXpdafj1D2hHb
        +84LfJEgG18vNM0nKk63iso=
X-Google-Smtp-Source: ABdhPJxur/riKn0iF6zgsM1wB7QaUh0khpU5eTSiyTDUviHLu8qOJKnG4gp1Tm4ZSbFVC4RJttHm+w==
X-Received: by 2002:a02:354c:: with SMTP id y12mr488447jae.144.1621450110609;
        Wed, 19 May 2021 11:48:30 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:1006:e5d3:5ea4:ef52])
        by smtp.gmail.com with ESMTPSA id h30sm337748ila.15.2021.05.19.11.48.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 May 2021 11:48:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD add vfs_fsync after async copy is done
Date:   Wed, 19 May 2021 14:48:27 -0400
Message-Id: <20210519184827.5460-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

--- v2: moved the committed argument into the nfsd4_copy structure

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 14 +++++++++++++-
 fs/nfsd/xdr4.h     |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f4ce93d7f26e..dc7ac4b39eff 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1375,7 +1375,8 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
 
 static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 {
-	copy->cp_res.wr_stable_how = NFS_UNSTABLE;
+	copy->cp_res.wr_stable_how =
+		copy->committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
 	copy->cp_synchronous = sync;
 	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
 }
@@ -1386,6 +1387,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	u64 bytes_total = copy->cp_count;
 	u64 src_pos = copy->cp_src_pos;
 	u64 dst_pos = copy->cp_dst_pos;
+	__be32 status;
 
 	/* See RFC 7862 p.67: */
 	if (bytes_total == 0)
@@ -1403,6 +1405,16 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
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
+			copy->committed = true;
+	}
 	return bytes_copied;
 }
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a7c425254fee..3e4052e3bd50 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -567,6 +567,7 @@ struct nfsd4_copy {
 	struct vfsmount		*ss_mnt;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
+	bool			committed;
 };
 
 struct nfsd4_seek {
-- 
2.27.0

