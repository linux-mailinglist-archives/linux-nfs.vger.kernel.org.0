Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A98EB9D1
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfJaWnP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:15 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46157 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWnP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:15 -0400
Received: by mail-yw1-f65.google.com with SMTP id i2so2772689ywg.13
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L7PIPNwTpokXVUro30nAvcF3QqeHNnOPKiyU17Tyl8w=;
        b=XPiKPVscbO9G8foqjNsdvSjaAP1BgR/8GAllFraNT2fXXaCkO12fl164X2/vYr5M6Q
         rw0R3Xqp7PZVYekqH5IU+WuuqdzbKEe0jKXruioa8vuoouOar+BlZIShiro9JgGec6o4
         Rv9IGIdM4QjHL06VUyoqQ0P2TxaCNrVh0ajRR2AdCerj81ojVdqiOZDfx3h0IpCmGy5M
         RJpA/f6j6StFlEEFG7BAFiEqwr3me/C1xSBJKJeEd9IEI8BAUjiJ1VjB7dDnRZSBC20Y
         MheA/vdvK37QYEdkrz4GtZrOPdwi1h2R89MvQRI/wYpWjPwjJ5tQRG/tsgF/BWADYLKN
         RjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7PIPNwTpokXVUro30nAvcF3QqeHNnOPKiyU17Tyl8w=;
        b=g3m5Ru7UaerPkeJj2wQt19ibDB6XQRhew2ViAaBBn1GkOU4/g2RFQq5A0w4DyUu0f7
         C0myNfZY/eqOIqSM7sNvS+Hc9f0JpVo1jhNl8ifdnA3zlcyURj3s9eKAlwIX7QKko12W
         YfFyOyBNQ7K/a1UPV2DDyFwC+36QMbyP6voc6ioXhbexVa1U6D54DnLYzJbi+FVP3jFV
         /5zPKxUz5cQukeOTBJe0+Zhg0rEgBBXs+sAC7G0DA1wgkevfMWhYMbzzqYBtnwLimyJU
         CXub0NUUtf2wYHlmiy6PV+QIwj2V2bkuWxrwq9vORpE94+hWAfPriRATf76Zerw1eF6U
         83VA==
X-Gm-Message-State: APjAAAWHG0QjBms3fVTgD61B9efriNspjMNSF5A+CoEh7kqB6Up05Cnd
        yzZiahGrSYm0BuxEIAESBtEqZeQ=
X-Google-Smtp-Source: APXvYqxuMrFqkzVSZUVTHR1cxbtU0pWW3GW2MDGoZuMC+OGzIcVE5F0oFS02CkLc7gR3vW5PDnDhVQ==
X-Received: by 2002:a81:2d57:: with SMTP id t84mr6237469ywt.426.1572561794213;
        Thu, 31 Oct 2019 15:43:14 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:13 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/20] NFSv4: Don't remove the delegation from the super_list more than once
Date:   Thu, 31 Oct 2019 18:40:39 -0400
Message-Id: <20191031224051.8923-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-8-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a check to ensure that we haven't already removed the delegation
from the inode after we take all the relevant locks.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 0c9339d559f5..e80419a63fb5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -298,6 +298,10 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		return NULL;
 
 	spin_lock(&delegation->lock);
+	if (!delegation->inode) {
+		spin_unlock(&delegation->lock);
+		return NULL;
+	}
 	set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 	list_del_rcu(&delegation->super_list);
 	delegation->inode = NULL;
-- 
2.23.0

