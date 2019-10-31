Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C3DEB9D6
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfJaWnT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:19 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39247 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWnT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:19 -0400
Received: by mail-yw1-f66.google.com with SMTP id k127so2785386ywc.6
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IIX8Z8mWhJCHEQrj2Qtpg+z0E9LTeoAQUosLeSg92SE=;
        b=GrX8UUOEE74gx4N6R9jjmg05RjAYoXRJo0GQtZXgwXmgtUcd4UbVt6BIsJy7wskcvy
         xX3Yk/832jWeOkEkAF78h1O9l12lui/Ky0/sc5FfCD8SvgQwdoXkpNnmFD5awhr35zgS
         GBvr3e3557X+CNYoET5y4HD+FKJbfQfAkC3ABxEbvNoRC+1FpYjGtRz971FsLLiAwp+g
         BZbCLFshUog4FiHjJ56jTBIiQfCWXBCfIaTmgpecsOMrsdfHClU3Ii1iJs8wFd5X9IQL
         KL/+T+S4wzPxS55KPmNxiQ3OBVy6Hq1VfOOL4phTbYsIe/xLDsON85kQiAwGZRlxTH1P
         8dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIX8Z8mWhJCHEQrj2Qtpg+z0E9LTeoAQUosLeSg92SE=;
        b=c/8o5L1wFQS1ogc5u+h/Bz71jZQ4MaUSM1YbVUQRWb9EH9NfWXmCmPWtaioTBY5bRW
         sO5E/K2LU+AmqCDbMh2NtqupOty8nrhEhI3XAzfllwQMslI5Q2Ank7bY0uV5Oksl0mDz
         ucrX65N4Q0xFWXKqv2hicrNIPHPTEh3E6i2bnI92LeLw44LyL/nSOdLD46I6T5C3sGYq
         QgLFHYlQdZ0bsSQ2upe1l5aiU03Opk5Pnx8Z2WoRK/4nKtc/n85AIy6BYNnOF6zlWmqp
         6NMOzW7Hw6j8neQHZAzmnVvrXoyHEZE6+86PLEd1AHU94jF7jDSI2ZWF1kXKbUOYUALx
         HSoA==
X-Gm-Message-State: APjAAAW/In9GFf8gSye1DycEzUijbK2cqknWZKGGMnbRTZ4rffLZLfK3
        eYYT/h/Bhby5Bv3fWqkUbWjVB/c=
X-Google-Smtp-Source: APXvYqynU34EB/oZC+bMsuNWo8HsG6zep9SZsgNv2lmgAs4iN6FJVeYq+qFzdOuUT1S7JLTBPkMTuw==
X-Received: by 2002:a81:9ad3:: with SMTP id r202mr6407754ywg.152.1572561797912;
        Thu, 31 Oct 2019 15:43:17 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:17 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/20] NFSv4: Update the stateid seqid in nfs_revoke_delegation()
Date:   Thu, 31 Oct 2019 18:40:42 -0400
Message-Id: <20191031224051.8923-12-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-11-trond.myklebust@hammerspace.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we revoke a delegation, but the stateid's seqid is newer, then
ensure we update the seqid when marking the delegation as revoked.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index a0f798d3c74f..aff2416dc277 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -771,8 +771,19 @@ static bool nfs_revoke_delegation(struct inode *inode,
 	if (stateid == NULL) {
 		nfs4_stateid_copy(&tmp, &delegation->stateid);
 		stateid = &tmp;
-	} else if (!nfs4_stateid_match(stateid, &delegation->stateid))
-		goto out;
+	} else {
+		if (!nfs4_stateid_match_other(stateid, &delegation->stateid))
+			goto out;
+		spin_lock(&delegation->lock);
+		if (stateid->seqid) {
+			if (nfs4_stateid_is_newer(&delegation->stateid, stateid)) {
+				spin_unlock(&delegation->lock);
+				goto out;
+			}
+			delegation->stateid.seqid = stateid->seqid;
+		}
+		spin_unlock(&delegation->lock);
+	}
 	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
 	ret = true;
 out:
-- 
2.23.0

