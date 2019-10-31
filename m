Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CFFEB9CB
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfJaWnG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:06 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41547 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaWnG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:06 -0400
Received: by mail-yb1-f194.google.com with SMTP id b2so3098781ybr.8
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=faFf2iylaTkeS0qV7rlKf6L0S80aVsYgn7LhWX7gbUg=;
        b=ZL+tT7ffriF6uh0WQGwMSzS7PWFpvVOIPUrn1S/MqiMGXPVk5evnxNxFHnF63pysC4
         A3E10um4nNgwBghBHD7pfQYubPlKSY5qNxZ2zCSaEHARhz+vuxZ8IIBcHPv5qsJquCB5
         9D7XE4cJ++U/+h86u5fm5dW/3mMKN3tvtbt4UG2DRNP91Xtcbf2JlDtQePHNTiGV+/XS
         kqssNAKqzFBIh3wh8gYZnD+TS86DPTdicsc5IQ1vVJHLD4hEtLzk26cWzzGLkTx6Oxj7
         fi1tp/imLIWpJtFAUf8C1u1a0+mjok6NDPbUAA/PGtnOpP+jMLwPIbCDiiWqtfwJOIAl
         AkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=faFf2iylaTkeS0qV7rlKf6L0S80aVsYgn7LhWX7gbUg=;
        b=BZUlDf1w6PFtfb8oqxf6EGrzMs3OuxdNZ5R2RkKDUQ7SnQ/Z2Vq5Af8Rcv2n/PgrN+
         7aRTvhhY0LiRB5xsx64FMaj4oaWIwKh6KTQBLXv+w0SWMGEqX4lUggbGKDxiB76E+8EO
         SHB1KJl2gLkhKca7HKnPLPgRnktpBj4bCpgoYRBgO7wO4ivz37Kpp/Bdr7qvtysEpkd+
         xUVpzco1p6QNRBesEEr9sxxmgcXK/Ei+M7/pCuftw81LabpUUHn1ozMzgzVQSu4Ih6OL
         LfQEmfiqSsQaKAuW1ic3SWgierYfBxHQR84XH7L5ZAyTUVcxuyJ9tqd+UBthtuIDqJig
         98CQ==
X-Gm-Message-State: APjAAAVlZsUBfX/2dX5Ucg2iqqHY0/mgyHUHKrGBAE3BZE+gOobPO3jE
        NMDCQ96nQTlUyrOPVDaUU4rI6fk=
X-Google-Smtp-Source: APXvYqzhnFKRQEEb7y+MLZqfoq2tgx+u5ccPcewddQkkfjLAwJib7KSVNPQLa1kJ6a0heMG5fZR5LQ==
X-Received: by 2002:a25:4b03:: with SMTP id y3mr6681269yba.497.1572561784793;
        Thu, 31 Oct 2019 15:43:04 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:04 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/20] NFS: Fix an RCU lock leak in nfs4_refresh_delegation_stateid()
Date:   Thu, 31 Oct 2019 18:40:33 -0400
Message-Id: <20191031224051.8923-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-2-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A typo in nfs4_refresh_delegation_stateid() means we're leaking an
RCU lock, and always returning a value of 'false'. As the function
description states, we were always supposed to return 'true' if a
matching delegation was found.

Fixes: 12f275cdd163 ("NFSv4: Retry CLOSE and DELEGRETURN on NFS4ERR_OLD_STATEID.")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index ccdfb5f98f35..af549d70ec50 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1191,7 +1191,7 @@ bool nfs4_refresh_delegation_stateid(nfs4_stateid *dst, struct inode *inode)
 	if (delegation != NULL &&
 	    nfs4_stateid_match_other(dst, &delegation->stateid)) {
 		dst->seqid = delegation->stateid.seqid;
-		return ret;
+		ret = true;
 	}
 	rcu_read_unlock();
 out:
-- 
2.23.0

