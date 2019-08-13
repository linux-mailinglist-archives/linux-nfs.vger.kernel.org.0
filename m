Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E531B8BB8D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2019 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfHMOaT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Aug 2019 10:30:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45724 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbfHMOaT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Aug 2019 10:30:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id m24so20201652otp.12
        for <linux-nfs@vger.kernel.org>; Tue, 13 Aug 2019 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SiL+a7lRBWw/WXuYuTmPPutdryUa+IHhCb6r6X2Z8Z4=;
        b=LVlvTGVLGFmcnZ2trCrIFNFC3W7iPwFqtLt4S2xvUoAq1Vcb+SuM7phbi+XNdBh5Pw
         SVzjGMM3Pr8AgjTFUkA+0DosYN5WUiu7RID3AH1a34qXYtTNTj3FGhBfZFlbjangmf4z
         nyhRi1OG6NPL2ghR90sjhqjkHMOrmERlzrI7Qzs0e3OaAwBd04ijJTL6aQ5QFkMYd4FL
         WErKjj5arFybyTmMMTxYmTyOrca5ogiqHn42F84jpaoAzMMJa6EbdPF86mobLA2p1gaj
         ZaTG4tTc85laodWImaPS6rPy+we9Q2WO5QGH2TTPWnDkPmzGOYiq004xpFv6qQau7TAU
         6/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiL+a7lRBWw/WXuYuTmPPutdryUa+IHhCb6r6X2Z8Z4=;
        b=qaTcgdtiqGXQhQ7PwvmaIEJkqJcS0pg2CLCmW8Z6n4Yhk7Grt7L1DeBGlQbL/DQ/Jy
         ZSRPJl5OsD77h8dzoLxg/FSzGDCV2s6fS4gmEw6gKDE5F3fqV4vl5fBvcwBOxZz4vTwC
         LD57z0TmLTXsiosRSDqPIZkYJF9gs/eqW2sQIQu0k5Xax7qeJkaD9gVvbEuHKaNakODH
         fq73mCjJtvNie9jRdAPz/IjQCG2VAoZUHhyK5GoOsPaLe02lLElbSflC6XnZ0rvO9p+B
         Q+xMBZLbyDhlfmGFQ8aqEyiO8gBEekUJsOkLiVco3hV8y28ESLYsNWEmrPJZBlrztQlj
         0BeQ==
X-Gm-Message-State: APjAAAU/TZrXYxPIhbLyHhJbzivsgZ7lJoD89MJDmQ6a6ydnlCEyDHN2
        bf7426aldVwY2O2SKBaRSfKPKRM=
X-Google-Smtp-Source: APXvYqyzSKQxkMcsSg7EAntzsbBbQEj3xKhZcuqah7INX+5Koe8L4X/v6FWUTA5N00X2T/LRvJ7uTQ==
X-Received: by 2002:a02:cc6c:: with SMTP id j12mr15419354jaq.29.1565706618360;
        Tue, 13 Aug 2019 07:30:18 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o6sm9429161ioh.22.2019.08.13.07.30.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:30:17 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFS: Ensure O_DIRECT reports an error if the bytes read/written is 0
Date:   Tue, 13 Aug 2019 10:28:06 -0400
Message-Id: <20190813142806.123268-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813142806.123268-4-trond.myklebust@hammerspace.com>
References: <20190813142806.123268-1-trond.myklebust@hammerspace.com>
 <20190813142806.123268-2-trond.myklebust@hammerspace.com>
 <20190813142806.123268-3-trond.myklebust@hammerspace.com>
 <20190813142806.123268-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the attempt to resend the I/O results in no bytes being read/written,
we must ensure that we report the error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Fixes: 0a00b77b331a ("nfs: mirroring support for direct io")
Cc: stable@vger.kernel.org # v3.20+
---
 fs/nfs/direct.c   | 27 ++++++++++++++++++---------
 fs/nfs/pagelist.c |  1 +
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 0cb442406168..222d7115db71 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -401,15 +401,21 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
 	unsigned long bytes = 0;
 	struct nfs_direct_req *dreq = hdr->dreq;
 
-	if (test_bit(NFS_IOHDR_REDO, &hdr->flags))
-		goto out_put;
-
 	spin_lock(&dreq->lock);
-	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags) && (hdr->good_bytes == 0))
+	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
 		dreq->error = hdr->error;
-	else
+
+	if (test_bit(NFS_IOHDR_REDO, &hdr->flags)) {
+		spin_unlock(&dreq->lock);
+		goto out_put;
+	}
+
+	if (hdr->good_bytes != 0)
 		nfs_direct_good_bytes(dreq, hdr);
 
+	if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
+		dreq->error = 0;
+
 	spin_unlock(&dreq->lock);
 
 	while (!list_empty(&hdr->pages)) {
@@ -782,16 +788,19 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	bool request_commit = false;
 	struct nfs_page *req = nfs_list_entry(hdr->pages.next);
 
-	if (test_bit(NFS_IOHDR_REDO, &hdr->flags))
-		goto out_put;
-
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 
 	spin_lock(&dreq->lock);
 
 	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
 		dreq->error = hdr->error;
-	if (dreq->error == 0) {
+
+	if (test_bit(NFS_IOHDR_REDO, &hdr->flags)) {
+		spin_unlock(&dreq->lock);
+		goto out_put;
+	}
+
+	if (hdr->good_bytes != 0) {
 		nfs_direct_good_bytes(dreq, hdr);
 		if (nfs_write_need_commit(hdr)) {
 			if (dreq->flags == NFS_ODIRECT_RESCHED_WRITES)
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 15c254753f88..56cefa0ab804 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1266,6 +1266,7 @@ int nfs_pageio_resend(struct nfs_pageio_descriptor *desc,
 	if (!list_empty(&pages)) {
 		int err = desc->pg_error < 0 ? desc->pg_error : -EIO;
 		hdr->completion_ops->error_cleanup(&pages, err);
+		nfs_set_pgio_error(hdr, err, hdr->io_start);
 		return err;
 	}
 	return 0;
-- 
2.21.0

