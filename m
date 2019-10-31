Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44FCEB9D9
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfJaWn1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:27 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43992 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfJaWn0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:26 -0400
Received: by mail-yw1-f65.google.com with SMTP id g77so2780210ywb.10
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YwWywFVCwgzZ4LH/87FN5wOH2rsbvdar3vb9Xu2sSu4=;
        b=vE5l75GViOnfTGc9ccxX+PobFZOZ58h8Q7whh3SWc2HzQVt/DqmfUG7W6l4Y/o3G+3
         pgIWKc3VDTQT8WXF1fg2BDcr/LLgz8sliIJN9c5cI1bz1SvK4SVR5H+V9jHiYKyrTDtK
         09olcGvVh2jchjetz1ycUFIaWuq495by38as/rJrhg3WSSq9LPlOqcAH3mrAe8oRxiWx
         LuMt2+YvMgqNCA8eIHCb6FAlkWT1S/t2gMHgv49TlEAf8/03M4V9TKpWABNk024fTjq8
         zJfLJ4fcPT6v+cuT2voRPaMGPsO1KeXye/9BroMfMdMphZckP3DZ1j5oNdlHguEt2zDP
         f0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwWywFVCwgzZ4LH/87FN5wOH2rsbvdar3vb9Xu2sSu4=;
        b=IewIJTDd8c9q8x49+SsqfFMnyhPZNlIepj423A+FRkqmsEVBFMxnAAaHdvje/wyTgo
         0syvX2fxd24Xsn8W6wHcA/0HkXbVqty+t4v1lPCJ58iAYl1W8HICg4UeWnxpblVugXGL
         zdfQJJEiNB1NhvIq2KchyEwWnQVMJn7Vwa41zTfl9fbc9WGLbq1QivBSf1BzeoaxACU7
         NBGq56P1/5ROOHxumFzYgZmKUYg6A8dXhXNJ1uAzr32Y5h2hwxoHkpFht17BNXj5+NFf
         qSF0hEUrorrg+UTCH5oK3HGoWTuZTFyozbJsPtFIMGyw5LsWJQ4gCESiN2TQwbcGA7ix
         cvbA==
X-Gm-Message-State: APjAAAWBf28cAI5j2u0uUgWosOtAa2khux+8D++Hf6ERWQaUQOyE+drB
        zDVeAPbmwX6FLx87Hh1KDXaReaI=
X-Google-Smtp-Source: APXvYqzyY3Tr9AJABOo9SawxDpTmB1a3UdeAZnuzqdFnQY9hRUGZcHpWfGx2pyobSFBh9uoM8n4u7g==
X-Received: by 2002:a81:241:: with SMTP id 62mr6354289ywc.19.1572561803946;
        Thu, 31 Oct 2019 15:43:23 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:22 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 15/20] NFSv4: nfs4_return_incompatible_delegation() should check delegation validity
Date:   Thu, 31 Oct 2019 18:40:46 -0400
Message-Id: <20191031224051.8923-16-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-15-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
 <20191031224051.8923-10-trond.myklebust@hammerspace.com>
 <20191031224051.8923-11-trond.myklebust@hammerspace.com>
 <20191031224051.8923-12-trond.myklebust@hammerspace.com>
 <20191031224051.8923-13-trond.myklebust@hammerspace.com>
 <20191031224051.8923-14-trond.myklebust@hammerspace.com>
 <20191031224051.8923-15-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we check that the delegation is valid in
nfs4_return_incompatible_delegation() before we try to return it.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a222122e7151..c7e4a9ba8420 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1796,7 +1796,7 @@ static void nfs4_return_incompatible_delegation(struct inode *inode, fmode_t fmo
 
 	fmode &= FMODE_READ|FMODE_WRITE;
 	rcu_read_lock();
-	delegation = rcu_dereference(NFS_I(inode)->delegation);
+	delegation = nfs4_get_valid_delegation(inode);
 	if (delegation == NULL || (delegation->type & fmode) == fmode) {
 		rcu_read_unlock();
 		return;
-- 
2.23.0

