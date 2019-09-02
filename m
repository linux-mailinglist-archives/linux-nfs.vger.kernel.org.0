Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98915A5BAE
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2019 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfIBRGa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Sep 2019 13:06:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39155 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfIBRG3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Sep 2019 13:06:29 -0400
Received: by mail-io1-f67.google.com with SMTP id d25so27777003iob.6
        for <linux-nfs@vger.kernel.org>; Mon, 02 Sep 2019 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qGSzyND4rX/g7mlQIjH5fUw5mfZyJz2GUWpcwS3xfQ=;
        b=WI0oEPHbWiFh7rMo21/DKwuBP3xQl9UeZJguYnjgVrMLsIVPoZRpLIn6V77o6i98RP
         FLhv/qOSCMks/QHMczZO0Kcc+j+pm/qoamLL7Pl5zAfowI25epLsG2cx55FjebSmyC7G
         faFz09VPHAzoLlLAa4aV3dC5s/NAZ0Rx1Zkk0tLXeCjEF6s5ZI2zhZ6xXbgu6MiGsJCs
         VpN13I63izZAi82mqULenfK8ZQ/vRbLMAoMNia/WdVRbZO/TbHcDwKk0FJRVwCL42YFX
         SO745ymn6JpwX+sJJ3hHUlfDURLiLeR0+UsgmZHIQbPrRjm2/gW7RtPoZNdBHO0mE7v+
         +CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qGSzyND4rX/g7mlQIjH5fUw5mfZyJz2GUWpcwS3xfQ=;
        b=kNfpwx40SXtGqtTqIfGX+90gYk1SCHZbpWyZs4vFv4Ci8MMb8VCjrSXUiJ9g7cH/Uf
         kFFEhSYjzlZHfgrPazyxN8iQ+FiXD0wcFx0Q1cbC2GNuRjdBo1jMOX2WHfhvtz6bWQ90
         ljSFgkds4nA+2IbGzxtx7J+/qL6SK70CQ1mpbQJJBLdHIxjCtXyIQkqjBTOj9fcJyHiH
         nA4mOsLJ3rchJTd80qoG0sDFifYb0E2I7tqnzvB10HakhDg3PYF9Wyr6erqdWSaz3Rf5
         jWht9EudWDH3jr405mE4vOEYa/VDKcN95p6EnlV6jp4fVXgCojGwkgL0AI96fzSXXpiT
         28nw==
X-Gm-Message-State: APjAAAU8/sWDZk2sZ2uT5JVvmW7zEkQuUg2nh2YB6XtlIpEf7WCGFcFz
        qwLd25xFgEjGj8Qww4D2WvwHuaiKbQ==
X-Google-Smtp-Source: APXvYqz51BaGZrIsPbTjSk5tUxmJJaZru4HrgZL6jli2DuGSFvbORyzYNhw56HxhHAK3+9jRSkbdFQ==
X-Received: by 2002:a02:920b:: with SMTP id x11mr11584591jag.17.1567443988318;
        Mon, 02 Sep 2019 10:06:28 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o3sm7655322iob.64.2019.09.02.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 10:06:27 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J.Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/4] nfsd: Reset the boot verifier on all write I/O errors
Date:   Mon,  2 Sep 2019 13:02:58 -0400
Message-Id: <20190902170258.92522-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902170258.92522-4-trond.myklebust@hammerspace.com>
References: <20190902170258.92522-1-trond.myklebust@hammerspace.com>
 <20190902170258.92522-2-trond.myklebust@hammerspace.com>
 <20190902170258.92522-3-trond.myklebust@hammerspace.com>
 <20190902170258.92522-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If multiple clients are writing to the same file, then due to the fact
we share a single file descriptor between all NFSv3 clients writing
to the file, we have a situation where clients can miss the fact that
their file data was not persisted. While this should be rare, it
could cause silent data loss in situations where multiple clients
are using NLM locking or O_DIRECT to write to the same file.
Unfortunately, the stateless nature of NFSv3 and the fact that we
can only identify clients by their IP address means that we cannot
trivially cache errors; we would not know when it is safe to
release them from the cache.

So the solution is to declare a reboot. We understand that this
should be a rare occurrence, since disks are usually stable. The
most frequent occurrence is likely to be ENOSPC, at which point
all writes to the given filesystem are likely to fail anyway.

So the expectation is that clients will be forced to retry their
writes until they hit the fatal error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 84e87772c2b8..0867d5319fdb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -958,8 +958,12 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 	nfsdstats.io_write += *cnt;
 	fsnotify_modify(file);
 
-	if (stable && use_wgather)
+	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
+		if (host_err < 0)
+			nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
+						 nfsd_net_id));
+	}
 
 out_nfserr:
 	if (host_err >= 0) {
@@ -1063,10 +1067,17 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (EX_ISSYNC(fhp->fh_export)) {
 		int err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
 
-		if (err2 != -EINVAL)
-			err = nfserrno(err2);
-		else
+		switch (err2) {
+		case 0:
+			break;
+		case -EINVAL:
 			err = nfserr_notsupp;
+			break;
+		default:
+			err = nfserrno(err2);
+			nfsd_reset_boot_verifier(net_generic(nf->nf_net,
+						 nfsd_net_id));
+		}
 	}
 
 	nfsd_file_put(nf);
-- 
2.21.0

