Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314A2492E15
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 20:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbiARTDA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 14:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiARTDA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 14:03:00 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E010BC061574
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 11:02:59 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id x8so17149719qta.12
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 11:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5dkiJUYeqgvMrWyZaxBLupmpCYQ219lavZTTqX6vIk=;
        b=KYIh9nOILmuv9dMHHTVlZ0RUeOic6jR7+OEEXoo0DvbdFw8bIlPWqK1TZi5uzFPtPU
         eeiNZRJshmvyFjBqMuQoPcn/CfFKN0Df1+KZfxhBYx3A27Cs7ID3fEji9i8ijlWFAcQh
         Un8XQ8OCRgJG2sXLg2FZx+bOqzmkiK+nlTgX33lDizgpOiQfbtFV5GH10FlSGJeuZN7n
         uLIUwu2tgNcQOzrnS4Pr7pNmbj7QPevQcXNfRROOEM/gkyxpvMsq+L2Pu1JivUYQcqqS
         5GEjeK85R2P6Nnotp7NG2R+IcyX7dcFCVUBKNGDo2HJO9gG8yshxf4vTYP1VAaseZghd
         oMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5dkiJUYeqgvMrWyZaxBLupmpCYQ219lavZTTqX6vIk=;
        b=LgbE0YgEo9ewHKoKGy579iBf4vh/mBLUcJTGRhIsqt0KwaJMoMkIWgKanJABXnKiYK
         d8hs+b9I8w7bpdrcH12hvR0pGKmd84XLXDByzB2DOnrgNlHkzb5kCNmapLYAx+Fgi7vX
         iSOuqnSERBDydYifsnjyayQcBMkWl+IMn4Y7G7dDU4gzszvR41m/9sSOjEeNXnq+4i2+
         TicUeuGHhWSMuxeJOtN769jolSEeVSyEbvBqrbvTY7stuUNqE+eqWL2FphZv363PhP36
         qh2o68iB3r7PslhWtVRf/d1VM9LFFhsZ0O3128fabwSymxdeQx1njVcTDCnNIgfyFOQa
         jMPA==
X-Gm-Message-State: AOAM531JRQj3PuOy+s9xxb4tN0SRbTHUAzDvBVJuNRIPq+uv3m+8xuyQ
        iv1NzpkeTrFppQe8/erq/yQ=
X-Google-Smtp-Source: ABdhPJxzfoFxDCOH3qxD4hc5ZKxzwmqc7UF8QwLC0MXK2HZyAIGGKrplzlErsaBSOdwxlkARJVRmew==
X-Received: by 2002:a05:622a:1ce:: with SMTP id t14mr10905830qtw.39.1642532579081;
        Tue, 18 Jan 2022 11:02:59 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:8cb5:b68c:55a7:5e86])
        by smtp.gmail.com with ESMTPSA id m15sm8685104qtp.4.2022.01.18.11.02.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jan 2022 11:02:58 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH] NFSv4.1 support for NFS4_RESULT_PRESERVER_UNLINKED
Date:   Tue, 18 Jan 2022 14:02:51 -0500
Message-Id: <20220118190251.55526-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In 4.1+, the server is allowed to set a flag
NFS4_RESULT_PRESERVE_UNLINKED in reply to the OPEN, that tells
the client that it does not need to do a silly rename of an
opened file when it's being removed.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/dir.c              | 6 ++++--
 fs/nfs/nfs4proc.c         | 2 ++
 include/linux/nfs_fs.h    | 1 +
 include/uapi/linux/nfs4.h | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 00b222e48d6f..71f72e102b42 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2319,8 +2319,10 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 		/* Start asynchronous writeout of the inode */
 		write_inode_now(d_inode(dentry), 0);
-		error = nfs_sillyrename(dir, dentry);
-		goto out;
+		if (!(NFS_I(d_inode(dentry))->flags & NFS_INO_PRESERVE_UNLINKED)) {
+			error = nfs_sillyrename(dir, dentry);
+			goto out;
+		}
 	}
 	if (!d_unhashed(dentry)) {
 		__d_drop(dentry);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2fbe04d12e44..1a9d25f23dcd 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2727,6 +2727,8 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 		nfs4_sequence_free_slot(&o_res->seq_res);
 		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL);
 	}
+	if (o_res->rflags & NFS4_OPEN_RESULT_PRESERVE_UNLINKED)
+		set_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(dir)->flags);
 	return 0;
 }
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 7a134e4c03e8..36fcd8d0487c 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -297,6 +297,7 @@ struct nfs4_copy_state {
 #define NFS_INO_LAYOUTCOMMITTING (10)		/* layoutcommit inflight */
 #define NFS_INO_LAYOUTSTATS	(11)		/* layoutstats inflight */
 #define NFS_INO_ODIRECT		(12)		/* I/O setting is O_DIRECT */
+#define NFS_INO_PRESERVE_UNLINKED (13)		/* preserve file if removed while open */
 
 static inline struct nfs_inode *NFS_I(const struct inode *inode)
 {
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index 800bb0ffa6e6..14acfe5300b7 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -46,6 +46,7 @@
 #define NFS4_OPEN_RESULT_CONFIRM		0x0002
 #define NFS4_OPEN_RESULT_LOCKTYPE_POSIX		0x0004
 #define NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK	0x0020
+#define NFS4_OPEN_RESULT_PRESERVE_UNLINKED	0x0008
 
 #define NFS4_SHARE_ACCESS_MASK	0x000F
 #define NFS4_SHARE_ACCESS_READ	0x0001
-- 
2.27.0

