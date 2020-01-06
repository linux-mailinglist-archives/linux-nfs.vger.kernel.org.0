Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0781317A8
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAFSmt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:42:49 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39235 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSms (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:42:48 -0500
Received: by mail-yb1-f195.google.com with SMTP id b12so137613ybg.6
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBM4GM4ScWgAI2ERG7Edy0voI9DiPcQQJ6qVFwzJ0jQ=;
        b=VzzY4qIPFi3m+IhfX0DE9QA/iIcZJN7jPWvU+v/IMOf0ZbwFpbS3Z/xa2tGzaMvDHq
         E2BCKYmjhhqkfb/Z58OWwtynUktJF0MTbS8bbCzq6S0KpvyW7ZekjPwjj9jP0qoa2aqz
         zcz7Llk3PhsV9dh6LGkpdgIdZ6N2riK2t3Js7ElaZ0scBVuY/TDSnffo/Kb6+YUPz7Cu
         MS1ihBAOrsAWFCzNSAUzYEyormazMR9vl0GG5UMBzzZvnx9Zjv1fs+z2gKYy+uyot/9Y
         w1id2k7oZFozqxx5iYJQhlo4uKChWisW8DodykVtGffssP/5ma7xirc9xuLGu/GFPjG+
         jHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBM4GM4ScWgAI2ERG7Edy0voI9DiPcQQJ6qVFwzJ0jQ=;
        b=j8c5ApEJqFwr5W4bE9V9GF0DRdMNeaFJMzn7iUtLAB+qt6cqSnTaviUBCAXu9w4lpP
         WMO2ektew+TaokjNybA5EaFp2dMo2bwcqS4vPUDAjJTzG0mJA8zCKNPrg6AkrH1pD25t
         GkNWuT3WaG8YPj/5jDtFkzL/Tr+tG3ABDjT/Rkv0c7zUrUn1nVat0F5lkTBqjKHfLeDG
         qPV0v8XN0SNODdTU6vcQTDy9jN6h93uQ3vPdIP02IN49Dv85YeyUMk1h/x0zireFtdhc
         VJ/Po4GPo6Ie3d/OmOTE+ih5buDHAhtSPdyqmoh4DMT8fQzwNumIvgkvCtzrqjZqduEO
         WAPA==
X-Gm-Message-State: APjAAAVCoMIw5UQrnM1DpwHxhj7GHBjhJml6axabaqo5yVMCmiYmpKhX
        Y/+4jxjxu6yxRgS0f/cBPw==
X-Google-Smtp-Source: APXvYqzb32iJtzoYK09EP1dekwqjnbpiZHupSI9I5YjYDiPfSiVK5nF75tCJLvgXlKkMLphOHPOEkg==
X-Received: by 2002:a5b:bc2:: with SMTP id c2mr50625876ybr.372.1578336167632;
        Mon, 06 Jan 2020 10:42:47 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm28223497ywf.101.2020.01.06.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:42:47 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/9] nfsd: Allow nfsd_vfs_write() to take the nfsd_file as an argument
Date:   Mon,  6 Jan 2020 13:40:29 -0500
Message-Id: <20200106184037.563557-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Needed in order to fix stable writes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 fs/nfsd/vfs.c      | 5 +++--
 fs/nfsd/vfs.h      | 4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4798667af647..3d4e78118e53 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1012,7 +1012,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				      &write->wr_head, write->wr_buflen);
 	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
-	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf->nf_file,
+	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
 				write->wr_how_written);
 	nfsd_file_put(nf);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 82cf80dde5c7..69cbdb62b262 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -947,10 +947,11 @@ static int wait_for_concurrent_writes(struct file *file)
 }
 
 __be32
-nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
+nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 				loff_t offset, struct kvec *vec, int vlen,
 				unsigned long *cnt, int stable)
 {
+	struct file		*file = nf->nf_file;
 	struct svc_export	*exp;
 	struct iov_iter		iter;
 	__be32			nfserr;
@@ -1057,7 +1058,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 	if (err)
 		goto out;
 
-	err = nfsd_vfs_write(rqstp, fhp, nf->nf_file, offset, vec,
+	err = nfsd_vfs_write(rqstp, fhp, nf, offset, vec,
 			vlen, cnt, stable);
 	nfsd_file_put(nf);
 out:
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index cc110a10bfe8..fd779c3bb35b 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -34,6 +34,8 @@
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
 #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
 
+struct nfsd_file;
+
 /*
  * Callback function for readdir
  */
@@ -93,7 +95,7 @@ __be32 		nfsd_read(struct svc_rqst *, struct svc_fh *,
 __be32 		nfsd_write(struct svc_rqst *, struct svc_fh *, loff_t,
 				struct kvec *, int, unsigned long *, int);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				struct file *file, loff_t offset,
+				struct nfsd_file *nf, loff_t offset,
 				struct kvec *vec, int vlen, unsigned long *cnt,
 				int stable);
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
-- 
2.24.1

