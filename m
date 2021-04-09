Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C33359CC0
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Apr 2021 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhDILM5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Apr 2021 07:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233607AbhDILM4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Apr 2021 07:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617966761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bic823Qpg0UIbdBp1AlM1MQR7teEWxxmvsucAoEoioY=;
        b=XIPC5gB8mzubFTFX6rHuKsB2IrQ/0CxEaI6nFJCPzzgTWlVqizChoi0fPY0NLldf9Em6/j
        hah0FzSjZ8X4ks2bbmeYeEgM08lnSaYw1vnDtsizbN9SgFp39YCcVGG3Hqk62M5vtnQ6yk
        yw0/EqqZusqgU0NYgT0ovAG8ZnLTp/A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-UFdpmpvcNbGG6fqFNcmQmg-1; Fri, 09 Apr 2021 07:12:39 -0400
X-MC-Unique: UFdpmpvcNbGG6fqFNcmQmg-1
Received: by mail-ej1-f70.google.com with SMTP id gn30so2051013ejc.3
        for <linux-nfs@vger.kernel.org>; Fri, 09 Apr 2021 04:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bic823Qpg0UIbdBp1AlM1MQR7teEWxxmvsucAoEoioY=;
        b=VDX8sfD8B9BAtqZRy+E0+aq9eGoG3ndBNa9MkqSdYAYnr7RxFj8z3ghAm1nSwqw5u2
         pj95ouVIPJE7F0DX5V7Rt3WUFH4XenVhvmCbfylEGITSdmTbTufrC6vhP7PDi3KDhXbW
         u/t51LXXZKCaGSEe+nVUpX6ooNsaZGkm15ADvrj/+SoUJOGCgzNRMCYMg8htV7Akdw74
         dz26PlOVoDqnw+IxiBnsFDSWbUCqEBTBr6GuySXeivWM6GFspiZDJAkBCoDpSqoNzwAr
         5yK2P/Zce552CZX39XfLj2ozwpT0tBjRWEzmwE+upmYnxt+Y+VHMZtHHrezP6uGPPgWW
         TgnA==
X-Gm-Message-State: AOAM5302u1F+gKWbJGd0LEMFBN9mQM1z0vAI/SePhOgRMC21orf0TEOA
        zQWwz6kdyilmWycPOeYLToi/WH4QB7oL1qmcl4xF2PqeJogPG/CXnYdGLyrVxvn6kNHQDymKBM9
        fWJsSRRBHgYTpDZFvl188
X-Received: by 2002:a17:907:c16:: with SMTP id ga22mr15467255ejc.120.1617966758230;
        Fri, 09 Apr 2021 04:12:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKmCtyYxCgoItu1rjqaew5l87gB4XKn8woRZ6AuvVgLaR11fjN9WbNEEdf+WGTbltsU3xEWA==
X-Received: by 2002:a17:907:c16:: with SMTP id ga22mr15467237ejc.120.1617966757927;
        Fri, 09 Apr 2021 04:12:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id t15sm1304810edw.84.2021.04.09.04.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:12:37 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] fs_context: drop the unused lsm_flags member
Date:   Fri,  9 Apr 2021 13:12:34 +0200
Message-Id: <20210409111234.271707-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This isn't ever used by VFS now, and it couldn't even work. Any FS that
uses the SECURITY_LSM_NATIVE_LABELS flag needs to also process the
value returned back from the LSM, so it needs to do its
security_sb_set_mnt_opts() call on its own anyway.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 Documentation/filesystems/mount_api.rst | 1 -
 fs/nfs/super.c                          | 3 ---
 include/linux/fs_context.h              | 1 -
 include/linux/security.h                | 2 +-
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index eb358a00be27..6fb8e22afe36 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -79,7 +79,6 @@ context.  This is represented by the fs_context structure::
 		unsigned int		sb_flags;
 		unsigned int		sb_flags_mask;
 		unsigned int		s_iflags;
-		unsigned int		lsm_flags;
 		enum fs_context_purpose	purpose:8;
 		...
 	};
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4aaa1f5dd381..a64c85234b59 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1263,9 +1263,6 @@ int nfs_get_tree_common(struct fs_context *fc)
 		if (ctx->clone_data.sb->s_flags & SB_SYNCHRONOUS)
 			fc->sb_flags |= SB_SYNCHRONOUS;
 
-	if (server->caps & NFS_CAP_SECURITY_LABEL)
-		fc->lsm_flags |= SECURITY_LSM_NATIVE_LABELS;
-
 	/* Get a superblock - note that we may end up sharing one that already exists */
 	fc->s_fs_info = server;
 	s = sget_fc(fc, compare_super, nfs_set_super);
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 37e1e8f7f08d..7ca88c7e108f 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -104,7 +104,6 @@ struct fs_context {
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
 	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */
 	unsigned int		s_iflags;	/* OR'd with sb->s_iflags */
-	unsigned int		lsm_flags;	/* Information flags from the fs to the LSM */
 	enum fs_context_purpose	purpose:8;
 	enum fs_context_phase	phase:8;	/* The phase the context is in */
 	bool			need_free:1;	/* Need to call ops->free() */
diff --git a/include/linux/security.h b/include/linux/security.h
index 9aeda3f9e838..cda04d052b9c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -67,7 +67,7 @@ struct watch_notification;
 /* If capable is being called by a setid function */
 #define CAP_OPT_INSETID BIT(2)
 
-/* LSM Agnostic defines for fs_context::lsm_flags */
+/* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
 #define SECURITY_LSM_NATIVE_LABELS	1
 
 struct ctl_table;
-- 
2.30.2

