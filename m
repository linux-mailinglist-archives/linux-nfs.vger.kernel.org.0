Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 961ED131768
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAFSUa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:20:30 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41256 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgAFSUa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:20:30 -0500
Received: by mail-yw1-f65.google.com with SMTP id l22so22246331ywc.8
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9oOxowOdQD1G670wo6ZQAwloHGVMH3sqqzOg0q1KWUQ=;
        b=nZLylNO8GuI2iCHlEGUbiCMUH0LNBanT3eAwgWiZmzFvPlgmKemA1UjYC/hiZkPcpp
         BfaODNTcDMRfPr3Dss73Hti47at6SdyOCwsho7nVMlBrV/hkbHsFrMC7HWfLiJMB3ziR
         CVASG4GCzPrxmtKcI+ESShoLyYD4vsvmoGKTzFVXx3xIEP4V2xtT1Efwp3tPqYwsTeZI
         aSFXEPgoiV2tzFV8z/imOeCCSPzrk30GG21aOMfjkT70X0QK3ymQy7ohJY17uDzQK9sy
         6mRGR9Buh725AloepVDF8YclSNCwzjc5IAZXzYvWznWtB2UWLvrYBlWUotvdEBnk4LTj
         OVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9oOxowOdQD1G670wo6ZQAwloHGVMH3sqqzOg0q1KWUQ=;
        b=TxH22b1ftuMt5BABY5aLUfBPByTe9KoXgvqGJW/dD5jbYnQ3xxQt+nYjab+UUoBGVM
         Mhq0CmXWtVx0GH+L+Msvg17xCaM2lNVkljEazNziSiIKtFmcPJ1yREB88vzWt33J822K
         ETXngCEQZ+vqTOsrFE8SE+L83yJGUW8QHZbEVMC1hywUb9JQ4/L0TgrYUeZOlYMEAkIX
         6e3ku5n1TPfLIJPabk/vCjUu5TJaX0wJqBLrrHEfdETm3pzI+DsZRoZGqMRucAunQVRI
         qq8mgqBpZZ69RfCgZERc+DM5TSvW0uJpbLEhPgZ+dqFF8Ed9IEbDns33fMwyYh+vtVUl
         GZ6A==
X-Gm-Message-State: APjAAAW25Ki0jxArOF+Bar1PFDSIg/LNprc/7sr/e6TNxNwHii6vmKnj
        OzAGCmUpFY2FpnmwOEKpOQ==
X-Google-Smtp-Source: APXvYqwyTgBk9CBJoh0Ahm7xeAF/UfN3Oh/Ntnw1R9d4P2sKEcQ0rPmrQHEFKPCB8IpYR1Fwm7Gvxg==
X-Received: by 2002:a81:7913:: with SMTP id u19mr73020172ywc.321.1578334828892;
        Mon, 06 Jan 2020 10:20:28 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id r31sm24800524ywa.82.2020.01.06.10.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:20:28 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RESEND 6/6] nfsd: Reduce the number of calls to nfsd_file_gc()
Date:   Mon,  6 Jan 2020 13:18:08 -0500
Message-Id: <20200106181808.562969-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106181808.562969-6-trond.myklebust@hammerspace.com>
References: <20200106181808.562969-1-trond.myklebust@hammerspace.com>
 <20200106181808.562969-2-trond.myklebust@hammerspace.com>
 <20200106181808.562969-3-trond.myklebust@hammerspace.com>
 <20200106181808.562969-4-trond.myklebust@hammerspace.com>
 <20200106181808.562969-5-trond.myklebust@hammerspace.com>
 <20200106181808.562969-6-trond.myklebust@hammerspace.com>
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
2.24.1

