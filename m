Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB11233AC
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 18:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLQRhC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 12:37:02 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39588 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfLQRhB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Dec 2019 12:37:01 -0500
Received: by mail-yw1-f65.google.com with SMTP id h126so4265380ywc.6
        for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2019 09:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZkdtC5dKZEcUknr17nE9QRsza4xKXhhyCDCqIkKgEQ=;
        b=C5JGcT26z39uKM6306gfdPEEFdAKj2vy4TTs6jPMK29jnpYuotmBqRldAonG0gVTiL
         wqrRdxW0j8DwuRUbNmbhP3V8ojoezCLlnfGKrJeGqlZuNVpNPOg50hjzma0RcBpj1HDB
         kJ41S9Lhh/jVrRqAQsnzfzPZO4IuJ3coORLTZB1u+OZ5nM598Gru8WdQu7BP9CTCoX5T
         ITkFOi7HxXtNFotV/KNSPdTRjV74jwGmQAT5TwpLeYQBmPoCmWRsKQ21vTGpRqROa2g3
         jftbrGeTGrkbIvEJsStiRUplCD768QK9VoOMUZGFhpLe+xabbUFI8EBfi/bXz7R2pvxM
         dNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZkdtC5dKZEcUknr17nE9QRsza4xKXhhyCDCqIkKgEQ=;
        b=Xifi82PeMCP9CaquN+S4vsAi9Swy/WG0LS66ne4TjtaglP2EHn02dJqTBOhsepu0lv
         9gmRh2hafIRgz7j4pYmq22IaX36Mnhl312Kno0jb4H65aXs6jD7+q59mMArHBvwU4Vhc
         FBnl6kFjyVAMBVDEoYd2NS2YMRMEfeVkh7BeCjzz9GTbcDilgYVHkIBQjKwCwmqP37qv
         UNtp2qTwYbHsta9HLwAgUelZ0uTImSEhE/2UQ5r1Athof0lfF4VSxY/Ai79dBj6sTcd5
         dIU1AB9TSXwO0ZBcmpvaefsJ18ODxI9Arj+P/WHjGsgfzR0/7sr7wvAIRu2Wt9CKhvAd
         MH1g==
X-Gm-Message-State: APjAAAXaRiRuzMeEjgSCe+31z+MeZ9/hXe2fZXowXDIIPV+7/xiBHDwg
        5m9Q8vyMoJ9A2t3UzqdoRQ==
X-Google-Smtp-Source: APXvYqwsvZewB77OhWa6ZkeRIpcU8GScaUgOxsGu2j5iWuq2J+2KubFjzxIMAdFacgqYjq5OyY1AlQ==
X-Received: by 2002:a0d:dac6:: with SMTP id c189mr13047601ywe.256.1576604220435;
        Tue, 17 Dec 2019 09:37:00 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d13sm10155200ywj.91.2019.12.17.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 09:37:00 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Return the correct number of bytes written to the file
Date:   Tue, 17 Dec 2019 12:33:33 -0500
Message-Id: <20191217173333.105547-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We must allow for the fact that iov_iter_write() could have returned
a short write (e.g. if there was an ENOSPC issue).

Fixes: 73da852e3831 ("nfsd: use vfs_iter_read/write")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c0dc491537a6..f0bca0e87d0c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -975,6 +975,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0)
 		goto out_nfserr;
+	*cnt = host_err;
 	nfsdstats.io_write += *cnt;
 	fsnotify_modify(file);
 
-- 
2.23.0

