Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4023EB9CE
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfJaWnN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:13 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34737 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaWnM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:12 -0400
Received: by mail-yw1-f68.google.com with SMTP id z144so1170882ywd.1
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TfZVcSzmWXLHAI2RilE5A2qvNvo3cZYOLKr7++TYasQ=;
        b=Txih3q9XiNr9biu+aLby4Td6GNKkvEnwDzUfHs2UqPJOuVwrk1K4FTd6WLNfe57tgS
         FD+bZDuz8psDixQlN8+31xykGWYBt2wrUyBYG8Ro+3QsyBkYOTmDWrpp69C7VgzSI0Yp
         0thBM3k+3nwtmlNwv8GWT+RyQi9m+eaeWKcoHFOSBpaQucBu8mOqSvlABD+5pXBgNdnn
         OQojRgN7Wx+BL+x1SKsLvyzgbhPtwNDB05aFtHwG9ZwIk0XJ6vTYdUIIiIpkIzUq7JDo
         4gXIfI8Zo2jaSTOICobLQIwUjzGXWiQbCOX1X2MHNatkwKq3DvjzoN41M4X3yuPALjhT
         dLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfZVcSzmWXLHAI2RilE5A2qvNvo3cZYOLKr7++TYasQ=;
        b=jQz6aCey7y0PE+CBacIBiz+glNorPwa6dltEOcD9JA+VAlvZM0A+4g3cdICkxi7cQt
         0zhE2ullZuBgEvLHFWHfeE+grdEdfURBcziuVmoYJ1R2E+DuaFD7aq1PJdITuU+Kd/uk
         MFt3Q2CIimJhuh6nQouwQdYzu6alGmQGRfVA/XqQf2IOlSpvXKJeRlZdSrgjMnD7QnLD
         WwsDRalAj08PCGUFwztWCS0R/qDvsF7jWvfotBo3HZM8V4z5sTl2pyeTbB16o1u9uUaF
         9Sj/v3fWbD1NTal+kSA7T/KJbxLD5krf28ghBzCHzhCnHbZh+71hVvOweHALenOYqmt/
         q2eA==
X-Gm-Message-State: APjAAAWBRWP4zQCEaGzi44vNLkP9jfieAWRDUR2frkTEj9pqg7YcG2Wn
        JVUxxg2F9ZsItgNEF0dpCpyTosw=
X-Google-Smtp-Source: APXvYqyGc50kovm4JxkCO8pLB6CSq4/PjQP/FhaKxoDHXl+w0yAdRnnn5/CtMNAH0y9bzuya0aUQ9A==
X-Received: by 2002:a81:2a08:: with SMTP id q8mr6343465ywq.195.1572561789342;
        Thu, 31 Oct 2019 15:43:09 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:08 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/20] NFSv4: Delegation recalls should not find revoked delegations
Date:   Thu, 31 Oct 2019 18:40:36 -0400
Message-Id: <20191031224051.8923-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-5-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we're processsing a delegation recall, ignore the delegations that
have already been revoked or returned.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index af549d70ec50..c34bb81d37e2 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -840,7 +840,7 @@ int nfs_async_inode_return_delegation(struct inode *inode,
 	struct nfs_delegation *delegation;
 
 	rcu_read_lock();
-	delegation = rcu_dereference(NFS_I(inode)->delegation);
+	delegation = nfs4_get_valid_delegation(inode);
 	if (delegation == NULL)
 		goto out_enoent;
 	if (stateid != NULL &&
@@ -866,6 +866,7 @@ nfs_delegation_find_inode_server(struct nfs_server *server,
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
 		spin_lock(&delegation->lock);
 		if (delegation->inode != NULL &&
+		    !test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) &&
 		    nfs_compare_fh(fhandle, &NFS_I(delegation->inode)->fh) == 0) {
 			freeme = igrab(delegation->inode);
 			if (freeme && nfs_sb_active(freeme->i_sb))
-- 
2.23.0

