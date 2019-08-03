Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4A806E6
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2019 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfHCPAj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 11:00:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44334 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfHCPAj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Aug 2019 11:00:39 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so158534444iob.11
        for <linux-nfs@vger.kernel.org>; Sat, 03 Aug 2019 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=m27ZvLzHwiRctmX2AA9qRyAWINQZyTlknWtR5CenV2I=;
        b=C8iNXGKRtWAGMDxk1MySlBvUEJMsExYjRVZo5RhgXZ/CVfqVdbf6I+VJf0hCD4mVz1
         56xBmOl2zidapfxYLzu0SvVAkjdKIs4aT4Y3KQrNNmPjARxBR7khaYePjFSQiICB5TQf
         h0IGgDAGi5qnMT7XnGq8MYTCueMuFnUEmPjQfsgMDlVmeGt8eoSUKC3h/RaWXsvyTwpT
         aw80KQIVlzFd4sWgvb5CWMz01rCyVBMEYN1al4rCZsA0bUTvMC73lKX770C3zEyLaHp2
         1sscDpWV49Q5ADPxhfZ+xhsDrkwW4a20XAmhu6FTzMig6l1Pk17CiC2eHvVzuhYtCrR8
         q6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m27ZvLzHwiRctmX2AA9qRyAWINQZyTlknWtR5CenV2I=;
        b=YoQiUWJY+tK5msXOPrf4k2qGz0N1cuKXMnIf7j8NJFduuGJeT5ruvKCK21yPQL+HeV
         1B6shcnZPyoROV28ETtbCW3yg97hNdDoNZbKs3wYEl6oYPQLj26XmVppUyLePd2wtUj4
         2JA0oKz3UF1KKdWMIBYF8KAEg1DtbfId7TJoljZcBIQO+9BIuhPv29885p3jeQQNk2MC
         6Mran7G6dfpc2SfEpBBg34v1ETjzjdu/h6NMCc1GS6NLc7yKPRymn65GKjdCW5zI1BWf
         XOb8uwUhsovukiVzVY21Cf9DUuLgQlWwpFiE7ojeh9JUOQIV1g20Q86QuS3L/cnXi4uD
         atWw==
X-Gm-Message-State: APjAAAXho3EtX1LdmToyW0/2+3TWaq5o/KPX3nvbU9cHBQMuwtrf7QIm
        BkGoBA58O7esHnv4AVVv0k1E5DU=
X-Google-Smtp-Source: APXvYqwx7Ft0wO+c6oyom9iv2PfRIlovbBkk0hZxmLvYhk4UY1vbOnIE4iHTiUy474qF7eKr384IWg==
X-Received: by 2002:a02:8663:: with SMTP id e90mr143203385jai.98.1564844438025;
        Sat, 03 Aug 2019 08:00:38 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f20sm60820416ioh.17.2019.08.03.08.00.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 08:00:37 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/8] NFSv4.1: Only reap expired delegations
Date:   Sat,  3 Aug 2019 10:58:25 -0400
Message-Id: <20190803145826.15504-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803145826.15504-6-trond.myklebust@hammerspace.com>
References: <20190803145826.15504-1-trond.myklebust@hammerspace.com>
 <20190803145826.15504-2-trond.myklebust@hammerspace.com>
 <20190803145826.15504-3-trond.myklebust@hammerspace.com>
 <20190803145826.15504-4-trond.myklebust@hammerspace.com>
 <20190803145826.15504-5-trond.myklebust@hammerspace.com>
 <20190803145826.15504-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix nfs_reap_expired_delegations() to ensure that we only reap delegations
that are actually expired, rather than triggering on random errors.

Fixes: 45870d6909d5a ("NFSv4.1: Test delegation stateids when server...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 0af854cce8ff..071b90a45933 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1046,6 +1046,22 @@ void nfs_test_expired_all_delegations(struct nfs_client *clp)
 	nfs4_schedule_state_manager(clp);
 }
 
+static void
+nfs_delegation_test_free_expired(struct inode *inode,
+		nfs4_stateid *stateid,
+		const struct cred *cred)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	const struct nfs4_minor_version_ops *ops = server->nfs_client->cl_mvops;
+	int status;
+
+	if (!cred)
+		return;
+	status = ops->test_and_free_expired(server, stateid, cred);
+	if (status == -NFS4ERR_EXPIRED || status == -NFS4ERR_BAD_STATEID)
+		nfs_remove_bad_delegation(inode, stateid);
+}
+
 /**
  * nfs_reap_expired_delegations - reap expired delegations
  * @clp: nfs_client to process
@@ -1057,7 +1073,6 @@ void nfs_test_expired_all_delegations(struct nfs_client *clp)
  */
 void nfs_reap_expired_delegations(struct nfs_client *clp)
 {
-	const struct nfs4_minor_version_ops *ops = clp->cl_mvops;
 	struct nfs_delegation *delegation;
 	struct nfs_server *server;
 	struct inode *inode;
@@ -1088,11 +1103,7 @@ void nfs_reap_expired_delegations(struct nfs_client *clp)
 			nfs4_stateid_copy(&stateid, &delegation->stateid);
 			clear_bit(NFS_DELEGATION_TEST_EXPIRED, &delegation->flags);
 			rcu_read_unlock();
-			if (cred != NULL &&
-			    ops->test_and_free_expired(server, &stateid, cred) < 0) {
-				nfs_revoke_delegation(inode, &stateid);
-				nfs_inode_find_state_and_recover(inode, &stateid);
-			}
+			nfs_delegation_test_free_expired(inode, &stateid, cred);
 			put_cred(cred);
 			if (nfs4_server_rebooted(clp)) {
 				nfs_inode_mark_test_expired_delegation(server,inode);
-- 
2.21.0

