Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1979918C1
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfHRSVY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37887 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRSVV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:21 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so16090632iog.4
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3K3XIGYR9s7R3wBYixEYwPpofkE5Whnuo1MawmlerUg=;
        b=NzJEgrjCm4yt5u1HR1a9xrsBTMdEIqzd9bmTDDdoLT2EjrDdwP64eXgH+4aiIJaSWP
         SdA0lBr+3h4+lUY+mAcStw/1gTRb/jUkGXvdpFxsuOJUVGn1C3Tt/M4FRdDm9tqwknml
         YSW2+rnMpRPHETRQOwwuX8x9uHsrBPKj4wOU01Ui619C+DVTPStEifAuS0fiM1ZJCpJX
         a9KqR3vJUFqjlgTuQnKJyb9p+1lG/6vSImENA6d7Y5M7NEZIU4JZuY+mQB40zNpdbRyC
         zOERs/eQK6rF7y0Er/PfGO5QqH2Kjmwz2vnBCPz5us45ID899r3s9+nsqFt3DMyePK0g
         RF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3K3XIGYR9s7R3wBYixEYwPpofkE5Whnuo1MawmlerUg=;
        b=HsWmQuEsgMXW9PbL3qfn00GZR1t0Ye5uxR1d+J8h/CWJakgb0t+ANQZR2LY4yg7pq2
         y5BT5XDIhg1KDNOuj8JwjWgH1O7cxWDr9fIAFt7T2ANzcnQV7qKNnxQJAMyu5JCqLMU2
         u9zBEh6s3iHBPD5uDtqZ34+4uMDEaP0zK6FtVVK40JSVVQ78ZVQ7DSwvTc8Ub1Ns7wjM
         lvo0y+waOc7yOTcfcL+76hGSvU1c6ZEIikxVLXYSiO3bYHWKQN0mS4OIzidXLE5MIMyu
         9JXSPq+yMOMmAfb8WEJR9lqG1aBvMaEVd0r8Ggnq6Fi22FL0IpsFCav23DkG0PWQBTqD
         elug==
X-Gm-Message-State: APjAAAVnGfHz8mVyMMbVo8YUHfvTTaxU77xdMJL8wRD7YN1Vmo7eEQcA
        3U6R0a33t7LaiT3arouRWZ1BLjk=
X-Google-Smtp-Source: APXvYqzqSLeBhE5msGlBSeWVbW2p+MPqehjA4ShYULfk+ypCxtDvo0r2jNEc71RhSqtYMb3uop7IKw==
X-Received: by 2002:a02:caa8:: with SMTP id e8mr22287547jap.67.1566152480629;
        Sun, 18 Aug 2019 11:21:20 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:20 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/16] nfsd: hook up nfsd_read to the nfsd_file cache
Date:   Sun, 18 Aug 2019 14:18:50 -0400
Message-Id: <20190818181859.8458-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-7-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2f5b52004a18..8593c6423336 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1071,25 +1071,22 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	loff_t offset, struct kvec *vec, int vlen, unsigned long *count)
 {
+	struct nfsd_file	*nf;
 	struct file *file;
-	struct raparms	*ra;
 	__be32 err;
 
 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
-	err = nfsd_open(rqstp, fhp, S_IFREG, NFSD_MAY_READ, &file);
+	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
 
-	ra = nfsd_init_raparms(file);
-
+	file = nf->nf_file;
 	if (file->f_op->splice_read && test_bit(RQ_SPLICE_OK, &rqstp->rq_flags))
 		err = nfsd_splice_read(rqstp, fhp, file, offset, count);
 	else
 		err = nfsd_readv(rqstp, fhp, file, offset, vec, vlen, count);
 
-	if (ra)
-		nfsd_put_raparams(file, ra);
-	fput(file);
+	nfsd_file_put(nf);
 
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
 
-- 
2.21.0

