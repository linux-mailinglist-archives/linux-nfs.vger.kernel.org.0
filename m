Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C194687C
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfFNUA3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36874 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfFNUA3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:29 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so8453135iok.4
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sn/ULeJn5Huc//PLnteYL7PRUrhxOTsvNQ2mDITzXgc=;
        b=htFwofMi/KMkz856QBkEnA1W5XAUyFbYxsxrXUN+KwZXfJ6eRvvi52GsoAD6hPaMui
         jxBh1Zjh0uudsOcTHL+rBh9ZpPMxaoUoBbsHaxfXta8XjmfCK1orQ3dQTwJ+f/AJRcBa
         yR4GrfmRtXRvu4oM/bgoAiJbDzihfwuhj2E7QPxY4Nf6z1DoK8fV8/AbILZsmTJLMMny
         tTNuwOf4wzGl3AYhNhJ88F/VoIFZfpqnp0B9vfGSpkX5hhbxPKNEl16HOCRx3iib8kvC
         DeKzCdxmgMErsV8X8/W84li4IxIS0ERJ8sGeQA/pRztTSnhPDEnJ402FFOxt1mFUGrbp
         iJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sn/ULeJn5Huc//PLnteYL7PRUrhxOTsvNQ2mDITzXgc=;
        b=VjnEdpis4lGgS8sXK3Dd0MnmIq6z3wGfbt5NFyGaDNdXx3vdZKaP1lqeoDp2/MaCz6
         NAtu5q6LkTku4vP1fT9rorcvGm8irtPmQ4fpAE41UXtTRG53VxkKs+n4eqEx5WzejXdw
         rW5aV9AsokPhbQIFWdbSaachzZuFHohXueNSCfL6cyDrMxe2cSvEkQdGlswU+zMDt+V+
         nAw3ySCG5BesSaK6Phs6SvnA88tbQEvlRV8oFC23YqfRW67lMh3iys3CcPfYQVRKBix9
         vtUX6lNFkvTWVWyJwR+3wCtiw7t++cn9o8DccRnSjh+D2KECO3wfC0ZFRAQ7tkp744/a
         Pttg==
X-Gm-Message-State: APjAAAVS/Z49U/qD46xyix5l4WP21q2pqLaBPMzWLaoeqQSu68bUfXEA
        WMzrqHl1H8sVlnBGp9vwMgU=
X-Google-Smtp-Source: APXvYqxmzRcHBYFsXyd4FUc1H0TzUGFyyupl2/pzSRTsIKgRnW1XUOPbew1pEoaSkmJYt0c/21LUYw==
X-Received: by 2002:a5d:8f99:: with SMTP id l25mr40268043iol.92.1560542428804;
        Fri, 14 Jun 2019 13:00:28 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p63sm4623407iof.45.2019.06.14.13.00.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:28 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 11/11] NFS: replace cross device check in copy_file_range
Date:   Fri, 14 Jun 2019 16:00:16 -0400
Message-Id: <20190614200016.12348-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
References: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a check to disallow cross file systems copy offload, both
files are expected to be of NFS4.2+ type.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 3bfa041..0389fab 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -140,7 +140,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t ret;
 
 	/* Only offload copy if superblock is the same */
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+	if (file_in->f_op != &nfs4_file_operations)
 		return -EXDEV;
 	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
-- 
1.8.3.1

