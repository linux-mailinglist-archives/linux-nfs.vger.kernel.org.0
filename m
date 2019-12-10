Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243F51191F7
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 21:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLJU3x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 15:29:53 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45866 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfLJU3w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 15:29:52 -0500
Received: by mail-yb1-f195.google.com with SMTP id i3so8132020ybe.12
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2019 12:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhsViqo0iLapQVB2vpZLRC2Hcy3AviaHK/eXGr600IY=;
        b=WxBbp/k+KUgx7hXmEjs+NTOGktmxEM8X8qUwdpysidExzTnlKuwOW508vY0peEp5kk
         hln/oSz4tn95aMgn5xD3cSFxsWO0t+0SXqlGV+ipT64vNy39zHlcjAiA28tB9QDJPzxx
         wKpq585Y+fgJT83NnML4AmgYvKzNH6N0BozMFIGqOpKPvuld2los5tN1whkoUpzun5j/
         fUUzn9v5K1QVmlpbs+5jjcj59MWfjcUKXrE4uVIG9ldsVMVnh2bW6HRsNMh95KZS4G3f
         BWDWUwf3aKHx4nDdhTQq9nbyvmfxsotdTfb475rK0hJBGkN0xhZccbXPTM4hHn9Ax/pj
         fSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhsViqo0iLapQVB2vpZLRC2Hcy3AviaHK/eXGr600IY=;
        b=PYv7M5Y6dkDYeJfJEXG25IBOeJkgxitgcw9BzdPZkjXrq1KLA8FGBd6vVIXszPVAFm
         jfgb7ATreAQqmirrP37ZBcsAqmvPOK2sf/I08AZ444omXHdcNAULRRzsMV3/+X+E4V8v
         SJh7wVdsbh2yv8lMBe6cBXWxOZp+qu7JvRJfqvMAep22cTanAELXXXdIWJuABC11LRuR
         jI03ZlnM2pfly4m74ia2L2H9KXAVQkf54v+MqdO+d9VBtdA5cJT1nVgQPOhKTogBWiqz
         WO6FkK8YX9HTrhjlpAj0Ux4fDlz4zTR/ssl3WYzWPWXEl6LdM/P3OMc7iPxI64L6zqJC
         7VYg==
X-Gm-Message-State: APjAAAUGUTRxNuT0vFYRGTOT84r8HZ82K4gBar5k7UqYdu//kXx6jOeF
        ul1OTvIxlR8c/1SOVmzp1w==
X-Google-Smtp-Source: APXvYqz7HLpdq9gR8IKUSPVehtEicwbYsPVuCz4V7/B87iGk/S2qXrPzLpGODJm6a0ulCyrWa5ctAw==
X-Received: by 2002:a25:a229:: with SMTP id b38mr12887653ybi.208.1576009791447;
        Tue, 10 Dec 2019 12:29:51 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id x84sm1947508ywg.47.2019.12.10.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:29:51 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 6/6] nfsd: Reduce the number of calls to nfsd_file_gc()
Date:   Tue, 10 Dec 2019 15:27:35 -0500
Message-Id: <20191210202735.304477-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210202735.304477-6-trond.myklebust@hammerspace.com>
References: <20191210202735.304477-1-trond.myklebust@hammerspace.com>
 <20191210202735.304477-2-trond.myklebust@hammerspace.com>
 <20191210202735.304477-3-trond.myklebust@hammerspace.com>
 <20191210202735.304477-4-trond.myklebust@hammerspace.com>
 <20191210202735.304477-5-trond.myklebust@hammerspace.com>
 <20191210202735.304477-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Don't call nfsd_file_gc() on every put of the reference in nfsd_file_put().
Instead, do it only when we're expecting the refcount to go to 1.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 4cef03a7726c..9c2b29e07975 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -282,27 +282,32 @@ nfsd_file_unhash_and_release_locked(struct nfsd_file *nf, struct list_head *disp
 	return true;
 }
 
-static int
+static void
 nfsd_file_put_noref(struct nfsd_file *nf)
 {
-	int count;
 	trace_nfsd_file_put(nf);
 
-	count = atomic_dec_return(&nf->nf_ref);
-	if (!count) {
+	if (atomic_dec_and_test(&nf->nf_ref)) {
 		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
 		nfsd_file_free(nf);
 	}
-	return count;
 }
 
 void
 nfsd_file_put(struct nfsd_file *nf)
 {
-	bool is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
+	bool is_hashed;
 
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (nfsd_file_put_noref(nf) == 1 && is_hashed)
+	if (atomic_read(&nf->nf_ref) > 2 || !nf->nf_file) {
+		nfsd_file_put_noref(nf);
+		return;
+	}
+
+	filemap_flush(nf->nf_file->f_mapping);
+	is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
+	nfsd_file_put_noref(nf);
+	if (is_hashed)
 		nfsd_file_schedule_laundrette();
 	if (atomic_long_read(&nfsd_filecache_count) >= NFSD_FILE_LRU_LIMIT)
 		nfsd_file_gc();
-- 
2.23.0

