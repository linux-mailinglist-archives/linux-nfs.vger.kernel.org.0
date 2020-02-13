Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B53815CB69
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2020 20:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBMTxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Feb 2020 14:53:18 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41730 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBMTxS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Feb 2020 14:53:18 -0500
Received: by mail-yb1-f193.google.com with SMTP id j11so3567145ybt.8
        for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2020 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=seh5qGjdxQldQv3GyysssxDRYieEulLBJZF91+Ccaoc=;
        b=JQiuV0p6Inrdzs/gGVOdHBTypkMAXZcUwO9oadcy3l0KNpkEJiUkNsDzSFAPYYGL/K
         vF9WMeVtzQzYayTe68LiJig0OBKaLO8BzTz33ENm0WRLcAcsCwZIL6wjMP7+uTD0DseQ
         GtJFZHT4kzOxddFRNyN23JuH1PyGJq0njg9TxCNiQTVZXuNFJvf5OT4PtLaixvhm17/X
         uX0lbfELSx/zttpQKF3D9dVIMHpDDViuwWN9XLiMRgZyZUo2g7raqo55HHr6nRe7YGhd
         fFVfbQMUndj7sBZwZ9wOuqDeJgjLSnzdC5Mp7XSIsP1OLgIlkzK4vmKYeG6xOJc5v3LL
         w0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seh5qGjdxQldQv3GyysssxDRYieEulLBJZF91+Ccaoc=;
        b=BotfQyjYbyg2RJvsSDTxJ8TpdfgroZEC+sdiswBfnBop7uVMnBVAFZuLHkxpCmRgOb
         +UEdfAuxwh5YVECCSJGwthxBvOC8wKn2F7F0QvN48zSjo47jjG5BvaM+IhxNiDSsIfWx
         yS3XasfJq5kHl0zBFIwbZR9cx78dykGBSm/TGTQVPvi4YVJGVMDBjMNIxCH+R+V6WAO4
         hSxWw/InEJ9Hob4OEWxSJvGvvd9kcHydrhYXl3gh141h7t5r9+Zmk+T9KQoGsVNkg7Q4
         vCcqg1MXZpJbOCO94uOxmEX1Obr7fd6ovGE1dMyc4wupVjvB/vtV4fZNHfcAdHWFTiKj
         p4sg==
X-Gm-Message-State: APjAAAU9//gn2fYoxq0sFygjTxPNARJ5SODPc0Ex3uej97X1hrjgEaNT
        35jwoT2gLcAudra4lQpgmA==
X-Google-Smtp-Source: APXvYqw08+Pzb3qipOPzHKqF/hlk8pXPZY804ARj7A/DW8N9GC/dQzGyK0+4d5SImDvwlBUgiQq65Q==
X-Received: by 2002:a25:99c3:: with SMTP id q3mr9113641ybo.323.1581623597352;
        Thu, 13 Feb 2020 11:53:17 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l202sm1560717ywb.89.2020.02.13.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 11:53:16 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Ensure the delegation cred is pinned when we call delegreturn
Date:   Thu, 13 Feb 2020 14:51:07 -0500
Message-Id: <20200213195107.10095-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213195107.10095-1-trond.myklebust@hammerspace.com>
References: <20200213195107.10095-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure we don't release the delegation cred during the call to
nfs4_proc_delegreturn().

Fixes: ee05f456772d ("NFSv4: Fix races between open and delegreturn")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index c17ff826e7e9..1865322de142 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -255,13 +255,18 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 
 static int nfs_do_return_delegation(struct inode *inode, struct nfs_delegation *delegation, int issync)
 {
+	const struct cred *cred;
 	int res = 0;
 
-	if (!test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
-		res = nfs4_proc_delegreturn(inode,
-				delegation->cred,
+	if (!test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
+		spin_lock(&delegation->lock);
+		cred = get_cred(delegation->cred);
+		spin_unlock(&delegation->lock);
+		res = nfs4_proc_delegreturn(inode, cred,
 				&delegation->stateid,
 				issync);
+		put_cred(cred);
+	}
 	return res;
 }
 
-- 
2.24.1

