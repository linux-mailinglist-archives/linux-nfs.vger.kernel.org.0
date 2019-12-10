Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A832E1191F6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 21:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfLJU3w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 15:29:52 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42742 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLJU3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 15:29:51 -0500
Received: by mail-yb1-f196.google.com with SMTP id p137so8145900ybg.9
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2019 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GB97zh1aT6vdl33UGntJyfknfwBcQGtnm/vtVyhwkc=;
        b=E0WMenFLIw7i8U3xI3M6IjJEkbFjrj4ewyToVXMjne2R8FyI8s9DNfcPpLuU2Mjqg7
         lTFIul7a7LxELPqONtMKbNNtVBk5NrFFxO4eum60boa3GC7U2ft50POfY9uNaUR2yI2x
         pejAPcwmGwf8fkaImRaEtldh2nUFXHu1rio0r3YNjJs+AJY5wm0O/4v6qTRS+rj+x8SZ
         V0SkAqfZ2dJsC9YSER/xQ5jisZ2ZQNduUl4tpJacC5hhglJe0+yyxrB7KZrrrR/YFoPF
         fw0Qvzqq8BrBO5an/GVzYdxSRBEr6Zpph8mEMRnlRTaUhs7Tp93gwi8qpilTiyRGdrS4
         uZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GB97zh1aT6vdl33UGntJyfknfwBcQGtnm/vtVyhwkc=;
        b=lBkpyM/gkVqIL6OIQrBLxI1AA1hzT1ELhqQ9vAARaPumg/+B7gppCektj2jIgL+4Jn
         Q2roCUsNSMkIl+VtzZKmd4VK3pNgutS612rh2+oji0INzXhXCQSySCEJBpPeN2q0IW7C
         0mU4LVJGZifJ1SrgDKQncCxInobLdbzlVbOifaGjq/AC/rqge8MO1ponzfzs3eKWiNUM
         br8N6WzdSIQYJLyBsmcxAd65MKIEUMEqCndxx4ceI+317LRFuL5D9Vc68me9YndDGWVA
         zdXJh0G0GBa4F4XrM2aqCa646GraMfLB+SvUQvSGwo0cYFJ0eKKCJ6zmyiEXebdU0CjG
         ZkwA==
X-Gm-Message-State: APjAAAV+Onen1/+8REL4Fto1eEf8SGoTNmhUSdb1UR2kDS8QtYULk5qJ
        N0acsproQXjMH/h3+NJWDg==
X-Google-Smtp-Source: APXvYqwGFnLll97bQHhqBYCE85J6r5bQReOcdGnXCcopDahRPq0Eavj0aLrrOl2KurIdgzHSdCjRyg==
X-Received: by 2002:a25:d45:: with SMTP id 66mr24922384ybn.216.1576009790487;
        Tue, 10 Dec 2019 12:29:50 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id x84sm1947508ywg.47.2019.12.10.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:29:50 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 5/6] nfsd: Schedule the laundrette regularly irrespective of file errors
Date:   Tue, 10 Dec 2019 15:27:34 -0500
Message-Id: <20191210202735.304477-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210202735.304477-5-trond.myklebust@hammerspace.com>
References: <20191210202735.304477-1-trond.myklebust@hammerspace.com>
 <20191210202735.304477-2-trond.myklebust@hammerspace.com>
 <20191210202735.304477-3-trond.myklebust@hammerspace.com>
 <20191210202735.304477-4-trond.myklebust@hammerspace.com>
 <20191210202735.304477-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Emsure we schedule the laundrette even if the struct file is carrying
file errors.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 6b0ab43b0618..4cef03a7726c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -237,13 +237,6 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
 }
 
-static bool
-nfsd_file_in_use(struct nfsd_file *nf)
-{
-	return nfsd_file_check_writeback(nf) ||
-			nfsd_file_check_write_error(nf);
-}
-
 static void
 nfsd_file_do_unhash(struct nfsd_file *nf)
 {
@@ -307,10 +300,9 @@ void
 nfsd_file_put(struct nfsd_file *nf)
 {
 	bool is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
-	bool unused = !nfsd_file_in_use(nf);
 
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (nfsd_file_put_noref(nf) == 1 && is_hashed && unused)
+	if (nfsd_file_put_noref(nf) == 1 && is_hashed)
 		nfsd_file_schedule_laundrette();
 	if (atomic_long_read(&nfsd_filecache_count) >= NFSD_FILE_LRU_LIMIT)
 		nfsd_file_gc();
-- 
2.23.0

