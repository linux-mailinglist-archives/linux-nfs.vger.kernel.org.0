Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7AA389430
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 18:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbhESQ4O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbhESQ4N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 12:56:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201AFC06175F
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 09:54:54 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 5so7162932qvk.0
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iZdOXDMsblVBUcTXUYdFLUwMLPKxC/oYxMqi6NA8Wrw=;
        b=cmOVKCJSuiHxp+eqspguDuCHd0OjxhGiZXbxwvay3aryrHcLZKKMqx5bNd1LsB3bDm
         r1Y2q1pKS81WZpHpjKMMDKx4+KYcRfBOX8ZA7d9TGWm5Brbwo9nhOhIsP/sqn5soJj7O
         Lx2ZM3cTPMvj+8EKOiZOZfXBvKrKTpDAVJEk950dY9XzyZVYRc3yoxX1CxLJAkOnjBll
         zR/8I7vrR8VjvfHG4T77WPrUtj/VsH8EQFngD5gQi4Pyw/8YdgiWGq4H7ETD25E1xj5K
         yqL38HzN5CtyaR++2QvRqDdSYbJTxjLPJh3QcrYXzyKvjXTp7xy8diPAIUduh6eB/l1l
         cMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=iZdOXDMsblVBUcTXUYdFLUwMLPKxC/oYxMqi6NA8Wrw=;
        b=DO5Y6k9iknDODfcKLsa+2X7dxvnMl0Uo7CmDkvCxSuRXQGL67NZR1/jOCNFvnxlMEh
         sHQN83LEQ+qzhX/i6a+YOSYKQJ4mlnG6Czs9IyfovNeXdDpCxajBX8bavnuZyImS6NXL
         dhhStwggsnsavBfpHZaUeUTBTiJltCOffU/6tyiKYPB2IvYiRAun2H88qIuD0iLqm1SO
         p7zsq6Y7pt0FYTcZ1mXAas49DzF5XEjn7NHPwWrIrZiLrwHML7hkNvL2Rf53lQU568jJ
         TsfNApqic+pe97dhXIbWQVsyDz6iHWTGGbHfD1b8mkA0vHhouakYTb7yGuz1VCm3Rtin
         QaZQ==
X-Gm-Message-State: AOAM533IjOUtYOMpFowrR6DgJ9VMdr77dR8+LIeKQshhIk3za9nqLpKB
        aX22CNIdzwR5SMTMV6S883Q4u8kePVo=
X-Google-Smtp-Source: ABdhPJwbaw6CRV9PEfWPYM19ecB9SwLikx0O/6dVs1WdIFzyFKewE3iCivR7l4C0t8GhIkTuXKLehQ==
X-Received: by 2002:ad4:4184:: with SMTP id e4mr460610qvp.13.1621443293056;
        Wed, 19 May 2021 09:54:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q6sm190129qkj.78.2021.05.19.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:54:52 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2] NFSv4: Fix a NULL pointer dereference in pnfs_mark_matching_lsegs_return()
Date:   Wed, 19 May 2021 12:54:51 -0400
Message-Id: <20210519165451.412566-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Commit de144ff4234f changes _pnfs_return_layout() to call
pnfs_mark_matching_lsegs_return() passing NULL as the struct
pnfs_layout_range argument. Unfortunately,
pnfs_mark_matching_lsegs_return() doesn't check if we have a value here
before dereferencing it, causing an oops.

I'm able to hit this crash consistently when running connectathon basic
tests on NFS v4.1/v4.2 against Ontap.

Fixes: de144ff4234f ("NFSv4: Don't discard segments marked for return in _pnfs_return_layout()")
Cc: stable@vger.kernel.org
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v2: Define a struct pnfs_layout_range to pass to
    pnfs_mark_matching_lsegs_return()
---
 fs/nfs/pnfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 03e0b34c4a64..40bba9b56e55 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1317,6 +1317,11 @@ _pnfs_return_layout(struct inode *ino)
 {
 	struct pnfs_layout_hdr *lo = NULL;
 	struct nfs_inode *nfsi = NFS_I(ino);
+	struct pnfs_layout_range range = {
+		.iomode		= IOMODE_ANY,
+		.offset		= 0,
+		.length		= NFS4_MAX_UINT64,
+	};
 	LIST_HEAD(tmp_list);
 	const struct cred *cred;
 	nfs4_stateid stateid;
@@ -1344,16 +1349,10 @@ _pnfs_return_layout(struct inode *ino)
 	}
 	valid_layout = pnfs_layout_is_valid(lo);
 	pnfs_clear_layoutcommit(ino, &tmp_list);
-	pnfs_mark_matching_lsegs_return(lo, &tmp_list, NULL, 0);
+	pnfs_mark_matching_lsegs_return(lo, &tmp_list, &range, 0);
 
-	if (NFS_SERVER(ino)->pnfs_curr_ld->return_range) {
-		struct pnfs_layout_range range = {
-			.iomode		= IOMODE_ANY,
-			.offset		= 0,
-			.length		= NFS4_MAX_UINT64,
-		};
+	if (NFS_SERVER(ino)->pnfs_curr_ld->return_range)
 		NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo, &range);
-	}
 
 	/* Don't send a LAYOUTRETURN if list was initially empty */
 	if (!test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags) ||
-- 
2.29.2

