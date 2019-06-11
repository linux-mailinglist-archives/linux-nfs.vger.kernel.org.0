Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2243D57A
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407078AbfFKS1V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:27:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40834 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407075AbfFKS1V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:27:21 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so10728044ioc.7
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v0OkLxrQq/55+L6unlXoMOkNyHb2TA9TF2IJuUzD/5o=;
        b=KtBqAk9YxXZrtEJ3BEa3RaJonlGQ7nyAl5Vk7KU1kMfQaFl+tEFnfjV0K6rBpSnIIN
         i34NK3VP3aFL8xr2mZdw9O0VE7MkCL5Ubpzf1bK4VOEardVc60zXDkGTVD3uMTAJb1yP
         ehjANFtbaYkVc0SzHcbTLfuxoakEyQpFpJfiYPrM2wJzHbL+tCp4/DqB+Z4CyiAqlVey
         ZK3kvT50zDqQTfxxHOQ9soLmuPY5hSjpRJixaJ+DeV+Mff48z0pOGhEsbiwrMV1C7WHw
         tDg9x7Km6FiIlaraAVZ0LU/XsoGN+c+IWiIU4EpGZAcOUV1gFJM++6bRXxMGHF2iRna0
         FudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0OkLxrQq/55+L6unlXoMOkNyHb2TA9TF2IJuUzD/5o=;
        b=KC8MTuoa8BXZD5UqyJO7RcA8sm8D7265nLKgyAUpNmmSbsCTiVXpq3KoyXp4tVfFgR
         tyVGI2fLTNYR+miWV6sfTrUycLfR0Mp1ajHWE837joD7rrGfTOyRHOyiJ8Wcs9Eq/E4g
         iJiwFq3HfHpiKs9vstEJwyYZb5fAZLrrGpPlnMon6/Z7sGhhBvRlugAv1RW5PmlrbzhN
         jpUG9FR1Lr+pPCXptZboK4I8e/+rhsYMZChW4N5USAXzQ9jeaaSQ5okr2CxF4GsGHG0I
         9OIPh/6XKri7O5omJb5kmt3K+Avxg4rsyoSuyJy27wK9JpuHauU52dysw72rCF3sPnyX
         7uAA==
X-Gm-Message-State: APjAAAWRv4Bx4ZNESk9AhZRsccgHECPosnH+nvBYvlSv3zKhOvDCBB3A
        BDxbSEH6//A2HgfQmDBTaAj5eTg=
X-Google-Smtp-Source: APXvYqyAMsViZrHG6rtTsKQownM86FxTHCJaj8mxrSB592UihhrcVNMC7RWr20FIyj+xywABuJY3bg==
X-Received: by 2002:a6b:b593:: with SMTP id e141mr34195012iof.203.1560277639823;
        Tue, 11 Jun 2019 11:27:19 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q9sm4789830iot.80.2019.06.11.11.27.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:27:19 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Fix up ftrace printout of the cache invalidation flags
Date:   Tue, 11 Jun 2019 14:25:09 -0400
Message-Id: <20190611182511.120074-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
References: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update the ftrace printouts so they correctly reflect the cache
invalidation flags.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index a0d6910aa03a..c40aad6ef3ff 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -25,14 +25,18 @@
 
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
-			{ NFS_INO_INVALID_ATTR, "INVALID_ATTR" }, \
 			{ NFS_INO_INVALID_DATA, "INVALID_DATA" }, \
 			{ NFS_INO_INVALID_ATIME, "INVALID_ATIME" }, \
 			{ NFS_INO_INVALID_ACCESS, "INVALID_ACCESS" }, \
 			{ NFS_INO_INVALID_ACL, "INVALID_ACL" }, \
 			{ NFS_INO_REVAL_PAGECACHE, "REVAL_PAGECACHE" }, \
 			{ NFS_INO_REVAL_FORCED, "REVAL_FORCED" }, \
-			{ NFS_INO_INVALID_LABEL, "INVALID_LABEL" })
+			{ NFS_INO_INVALID_LABEL, "INVALID_LABEL" }, \
+			{ NFS_INO_INVALID_CHANGE, "INVALID_CHANGE" }, \
+			{ NFS_INO_INVALID_CTIME, "INVALID_CTIME" }, \
+			{ NFS_INO_INVALID_MTIME, "INVALID_MTIME" }, \
+			{ NFS_INO_INVALID_SIZE, "INVALID_SIZE" }, \
+			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" })
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
-- 
2.21.0

