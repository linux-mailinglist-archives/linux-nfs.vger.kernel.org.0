Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65C49D486
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbfHZQxv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 12:53:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43831 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbfHZQxv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 12:53:51 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so38881425ioe.10
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XDL4KoWkmx9PlF4CXcLYUPo7i1ojatgLjc2RjXIZH4=;
        b=qF68pKjOUdYCSXpdU0kQ+I/3ayneBPAU5pxLNWbIezoPAuOg/2UuHKtbVh1LQdy5O3
         4M2qJcn4VIfTAlOsQVwg7a6SQsDOyJTl4g1K06qPsKZgrO94tVDnhnbP/2rA9inUzTOg
         EycMJk2xK5XSta8LR6dEVxQdrQfO9m2xvjTlp5ZzAw0U+/Yu0/yUtnoenF0IV1v7gh+q
         hVWsQI2sQG6zbFLYL8asuaNnmYX7VhUkU6OTo3C6vvlzMHBQFN40TwCr8/VeQ+dj0q+S
         59kXNlKMHsDy6I83xJrf4yQ49F6FZpfPMNLKdNxc4knCbS9z+SDnODbOF6epqVE5gOyS
         JRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XDL4KoWkmx9PlF4CXcLYUPo7i1ojatgLjc2RjXIZH4=;
        b=ckRm6TNlIr+Jp5ThmTAVDsSvQBOsqD+TuJKAvGDBNgxpQIpUOyGMfK2yO7c+rM8MuP
         AhEhJsOLkR+91WkbfhjHCB7tQWlkqssgyMtbFduF7bCj0Mui3k4tmV5JkqwECg56FBMC
         k5zujbMZfCc1LRifZ1ZYjnea4wXHdDxsKnjYB2lwBdI7FNinsIbC5Fw11ErXtSL6YF/P
         sCYUWO+sRtnagKm/vT078e9IUihFRaLJayI0DZpuuXiFyu7wtZTIm0Tza5kI+3d7r5C9
         /pVHEaWrjdhlnlKExMoneF8ufMtxAQRnOZR9DeLkdTV/34zA7EwNdlvS/MTJMSiPI/1h
         R1ng==
X-Gm-Message-State: APjAAAWK5LWVRWkmpvhpBzJRMW1ib49zVQeL139n4s/LVTeAbVL1Eh4B
        C7GvbHtU1lhtuhzOu1PtUEQKfYgHdA==
X-Google-Smtp-Source: APXvYqzI0+0M/evVsNk+W+l8jLrcKOowsCauOhql3qqAWOhC5cB5bbijk++Rb1yCXcvNfaQa16/71g==
X-Received: by 2002:a5e:c00e:: with SMTP id u14mr1114993iol.196.1566838430240;
        Mon, 26 Aug 2019 09:53:50 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u24sm10613490iot.38.2019.08.26.09.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 09:53:49 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] nfsd: Don't garbage collect files that might contain write errors
Date:   Mon, 26 Aug 2019 12:50:21 -0400
Message-Id: <20190826165021.81075-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190826165021.81075-3-trond.myklebust@hammerspace.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826165021.81075-2-trond.myklebust@hammerspace.com>
 <20190826165021.81075-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a file may contain unstable writes that can error out, then we want
to avoid garbage collecting the struct nfsd_file that may be
tracking those errors.
So in the garbage collector, we try to avoid collecting files that aren't
clean. Furthermore, we avoid immediately kicking off the garbage collector
in the case where the reference drops to zero for the case where there
is a write error that is being tracked.

If the file is unhashed while an error is pending, then declare a
reboot, to ensure the client resends any unstable writes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d229fd3c825d..92d0998824a0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -216,6 +216,36 @@ nfsd_file_free(struct nfsd_file *nf)
 	return flush;
 }
 
+static bool
+nfsd_file_check_writeback(struct nfsd_file *nf)
+{
+	struct file *file = nf->nf_file;
+	struct address_space *mapping;
+
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return false;
+	mapping = file->f_mapping;
+	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
+		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
+}
+
+static int
+nfsd_file_check_write_error(struct nfsd_file *nf)
+{
+	struct file *file = nf->nf_file;
+
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return 0;
+	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
+}
+
+static bool
+nfsd_file_in_use(struct nfsd_file *nf)
+{
+	return nfsd_file_check_writeback(nf) ||
+			nfsd_file_check_write_error(nf);
+}
+
 static void
 nfsd_file_do_unhash(struct nfsd_file *nf)
 {
@@ -223,6 +253,8 @@ nfsd_file_do_unhash(struct nfsd_file *nf)
 
 	trace_nfsd_file_unhash(nf);
 
+	if (nfsd_file_check_write_error(nf))
+		nfsd_reset_boot_verifier(net_generic(nf->nf_net, nfsd_net_id));
 	--nfsd_file_hashtbl[nf->nf_hashval].nfb_count;
 	hlist_del_rcu(&nf->nf_node);
 	if (!list_empty(&nf->nf_lru))
@@ -277,9 +309,10 @@ void
 nfsd_file_put(struct nfsd_file *nf)
 {
 	bool is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
+	bool unused = !nfsd_file_in_use(nf);
 
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (nfsd_file_put_noref(nf) == 1 && is_hashed)
+	if (nfsd_file_put_noref(nf) == 1 && is_hashed && unused)
 		nfsd_file_schedule_laundrette(NFSD_FILE_LAUNDRETTE_MAY_FLUSH);
 }
 
@@ -345,6 +378,14 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	 */
 	if (atomic_read(&nf->nf_ref) > 1)
 		goto out_skip;
+
+	/*
+	 * Don't throw out files that are still undergoing I/O or
+	 * that have uncleared errors pending.
+	 */
+	if (nfsd_file_check_writeback(nf))
+		goto out_skip;
+
 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags))
 		goto out_rescan;
 
-- 
2.21.0

