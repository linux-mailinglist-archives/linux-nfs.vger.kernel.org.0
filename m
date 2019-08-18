Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A68918BC
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfHRSVW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46777 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfHRSVU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:20 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so16056901iog.13
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6bfPUQSm6jzE4vHT6AYhUiGZDNcrvafqhyvl42Bs0Do=;
        b=cEFYZEoA3QAQahJOvijnW0LhEEHFQIf95yfFnbPis2v+CZm7ESc2HGsu8mQ3cKkmfG
         sRp+nO+z9W0VkFdZbCaMaKz6cWU9HZZx2zL8JmpxpfXDK1AmJBEHrrspB5t2DAfs0lRe
         nNc1iQ0CIvXAP5mFm3b6XNPDk+Q0U3l4ZXW8S3gN3El6IQgCVaIbMXQB1GKd2H8QpoAN
         /m/V7uIQr3ipAzcCzOYKLRkTKQZqHqtMRT/NaiKaYXhmw1BqFB35Qzyp+5EYR82Sps5W
         IXKBy09TKgupEWzV1b625JnruUlPvh+eLBRkGjFWJXag8C9/Bg0nBfnlLspsvM4OS9Ep
         McSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bfPUQSm6jzE4vHT6AYhUiGZDNcrvafqhyvl42Bs0Do=;
        b=PmLVWw1CjMD+MbPMXA2sqYBDTk8WGA+2BqFIRYIA7aFXMLMV+kDuLMzvqWHRJGZ9EA
         bh4NYp8028evRA73cqEbcRzKY1mIQxAvNICZoi5zSC23P5QEsXwK935D+PZr80jhhAOX
         SiEAvdGrgxyaXLH4vc7lFXqPM3br5BK9hRgdeiC2Y4ZRFZkAlB9ysWB146hnm4OQc4/M
         rTLYWz2cpL+xS15lVtbWvXm5EjF2I9gebmFme5NAqEsKRPZt3QfWFIPPo0yvfeZrU5Wq
         H+avk6LxDL0ZNG4Hn4YIBVg+LsQDqxxb1WR+2OjSdGgHazblA/t6E7/25zXUT8KRGM65
         N/Xw==
X-Gm-Message-State: APjAAAUdH7J8ocEmdg6M1LZs6SH55yrmkioEaw1rSnumFBA3p7T/t0vV
        ynZJ+n/+TWanpw9rINBC7g==
X-Google-Smtp-Source: APXvYqxSOA/CKn/+Nmtzs4SuATPCdGkaZlQvkv2T55Yh6I+F3+L5XB7qSLAg/x+rfXf7czd8FABhDg==
X-Received: by 2002:a02:5ec3:: with SMTP id h186mr23774606jab.110.1566152479755;
        Sun, 18 Aug 2019 11:21:19 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:19 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 06/16] nfsd: hook up nfsd_write to the new nfsd_file cache
Date:   Sun, 18 Aug 2019 14:18:49 -0400
Message-Id: <20190818181859.8458-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-6-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
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
 fs/nfsd/vfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5983206ab036..2f5b52004a18 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -44,6 +44,7 @@
 
 #include "nfsd.h"
 #include "vfs.h"
+#include "filecache.h"
 #include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
@@ -1104,17 +1105,18 @@ __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 	   struct kvec *vec, int vlen, unsigned long *cnt, int stable)
 {
-	struct file *file = NULL;
-	__be32 err = 0;
+	struct nfsd_file *nf;
+	__be32 err;
 
 	trace_nfsd_write_start(rqstp, fhp, offset, *cnt);
 
-	err = nfsd_open(rqstp, fhp, S_IFREG, NFSD_MAY_WRITE, &file);
+	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_WRITE, &nf);
 	if (err)
 		goto out;
 
-	err = nfsd_vfs_write(rqstp, fhp, file, offset, vec, vlen, cnt, stable);
-	fput(file);
+	err = nfsd_vfs_write(rqstp, fhp, nf->nf_file, offset, vec,
+			vlen, cnt, stable);
+	nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
 	return err;
-- 
2.21.0

