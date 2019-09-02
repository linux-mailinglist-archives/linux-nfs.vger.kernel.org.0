Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06156A5BAD
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2019 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfIBRG3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Sep 2019 13:06:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33904 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfIBRG2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Sep 2019 13:06:28 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so30378260ioa.1
        for <linux-nfs@vger.kernel.org>; Mon, 02 Sep 2019 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XDL4KoWkmx9PlF4CXcLYUPo7i1ojatgLjc2RjXIZH4=;
        b=MBaUDGNLNJXN2opE3Mlb2yUf+wQl7uAwFF/53Ib4KhjCNse87OvHnjUq6ZxvCSNep8
         UEltFVB8QUSD6Nltj14nHTZJkvZrrh3D7GwzpzKgKK8HeyucZMh+jjV/XN0tj/Ip1B+u
         iYNam8S86U5ANGmQpXxfz7+sEq1NrA5Bi4+Z1gbPy47MnqsyuhGJm8MGQE/IXWyAEySX
         RU2W5yQrKdwDnS2Ufei0uHa0HPOAQQR0mo/uLVNIHbifNg35LKr5XqCt6Kr78ltKhDxN
         4hFvKESxQD6PMV8iy1ihKF1n9jdPEByOnsMhL+ZSo8JdPk3v2MB0Umw23DwUujYc7t/L
         6blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XDL4KoWkmx9PlF4CXcLYUPo7i1ojatgLjc2RjXIZH4=;
        b=I6A1HuQb1DHUTZSs/Dxvt3eemTPMmcSFUXlo4udVbJMRUvDReuXlcBFugcpL4vuTlJ
         EeyhCUZXtWEWILRrVlevxWFor79BESgbjG8LH3SQPuY5I3xRs8wqsAHefXQNWY4ZIo2L
         U07I+JFnGqb7ANvvn/l5WAzngJ3J0Os8plAMtGLRtZgcs7Tz5WbxAzK4Ov2FLXkadNNs
         OZipIOwAqFj2lcgmJOi4wNJkJZL+DzAOk+P7apvGA1i2+mskzRHiI5dyvQL2F0mwQMFT
         /2upgqjRoLNTOGdz5z/g2AYQluzuCY5YZzJE+0NlEc20F2cbEoJmg7JLAvWGzA3HcomN
         teAA==
X-Gm-Message-State: APjAAAXi8uEMpzhBKgs9ERuopPFDCvvcyGmBKKDpqMCCfXsMJSAQobjb
        LICy7AELLDIyQP/jTdILdplOV8vI+A==
X-Google-Smtp-Source: APXvYqzKUFdyU9py8huN8OHe9DejDec/x3FbbQNqv76ioQW/gjFtAY/wbxJ1EaeVKxwKVcSx76elDw==
X-Received: by 2002:a02:3e86:: with SMTP id s128mr31322569jas.14.1567443987658;
        Mon, 02 Sep 2019 10:06:27 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o3sm7655322iob.64.2019.09.02.10.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 10:06:27 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J.Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/4] nfsd: Don't garbage collect files that might contain write errors
Date:   Mon,  2 Sep 2019 13:02:57 -0400
Message-Id: <20190902170258.92522-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902170258.92522-3-trond.myklebust@hammerspace.com>
References: <20190902170258.92522-1-trond.myklebust@hammerspace.com>
 <20190902170258.92522-2-trond.myklebust@hammerspace.com>
 <20190902170258.92522-3-trond.myklebust@hammerspace.com>
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

