Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D630142E097
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhJNR5T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhJNR5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 13:57:18 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6FAC061570
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id z15so4204393qvj.7
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCc0FNN3Mdu7l4DV6pbSGmAPSEI5nFZIgawlHakFoTQ=;
        b=PNIEoacV1fHYNukXPU+8WhMMFhGn1f/K3NtBFPPfIIJ9IF5s9pbcNoYcgAPeA0AllE
         idNJD9LPDxXt99HCVcqFIUqOe8uv91maRzUTy2NAZV8DlroB02saBjKFnGiClKGlM5F9
         lvT4TWRXJMIzPWtba+CzABDBkjSzfNgqjXesTU65ox150ezLxqXpsfK396fwaeUBjVL2
         WLA6SF65vnZSRb+TZZ1mNiNt6CihzCk04z/u4hrkziwOuOjN2ODHiadaevEy6ZhS60f6
         sC4xvz+0mV9iQSeOdMD/AvjZwQOMeE0Bypr9vabl50iD2arsskEI1lu0JEH5RDxKTO9z
         8vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wCc0FNN3Mdu7l4DV6pbSGmAPSEI5nFZIgawlHakFoTQ=;
        b=FnAm5sXfizvduIY9OcMw8+zjVY5wnPh8OSj+vZpxIew7LNdu/4Tf0Kv9VasEYxC9zc
         GQ23iXWK38C/Xppp9nv/AqiHx2RrTKAJ0Kl8X0nDHa432y7WwVNAnga9eN4P0VS9ym/b
         yVO9tsb78Vn6c22EkiXbtIu8B1jWiF8mmlnWhc95bL/GGwm6Oy4MzBpZHCLm80n8E/RW
         aeHUNxa6d6HtLHHJ4m6YvfAwPA8yKmVeZJwYQZGtvldA4b/v9uRuMDhbWq1Mkef+uhKm
         kOXf5H1Lupf2LEYNocJb17J2uIpFfglXH2Gb8XlxGElqb/+bHa1xUjZMPUNRNhaHCKno
         YQ7g==
X-Gm-Message-State: AOAM530PjqT6wMJigNT5xLsU/jYVYu6La+VhLzXVJ2sD/2XqFF2NEp0o
        08Py63Ds86cEcvfdJc+5OQVDRuTZ938=
X-Google-Smtp-Source: ABdhPJznR9qkS21cS1J/DuCO3Q00dzfpc2r9wb4BH4OIZ33ktYU/15eRb7jM7M5A+X8uwnTrSEPOKQ==
X-Received: by 2002:ad4:5de9:: with SMTP id jn9mr6749093qvb.41.1634234112165;
        Thu, 14 Oct 2021 10:55:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id m6sm1536131qkh.69.2021.10.14.10.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:55:11 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 4/5] NFS: Call nfs_probe_server() during a fscontext-reconfigure event
Date:   Thu, 14 Oct 2021 13:55:07 -0400
Message-Id: <20211014175508.197313-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
References: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This lets us update the server's attributes when the user does a "mount
-o remount" on the filesystem.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index e65c83494c05..3aced401735c 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1004,6 +1004,7 @@ int nfs_reconfigure(struct fs_context *fc)
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct super_block *sb = fc->root->d_sb;
 	struct nfs_server *nfss = sb->s_fs_info;
+	int ret;
 
 	sync_filesystem(sb);
 
@@ -1028,7 +1029,11 @@ int nfs_reconfigure(struct fs_context *fc)
 	}
 
 	/* compare new mount options with old ones */
-	return nfs_compare_remount_data(nfss, ctx);
+	ret = nfs_compare_remount_data(nfss, ctx);
+	if (ret)
+		return ret;
+
+	return nfs_probe_server(nfss, NFS_FH(d_inode(fc->root)));
 }
 EXPORT_SYMBOL_GPL(nfs_reconfigure);
 
-- 
2.33.0

