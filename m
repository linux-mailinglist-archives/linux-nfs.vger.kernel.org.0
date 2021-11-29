Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04B7462505
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 23:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhK2WeG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 17:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhK2WdX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 17:33:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E159DC133F57
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 10:46:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5866B815C3
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 18:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4041C53FCF;
        Mon, 29 Nov 2021 18:46:08 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     paulmck@kernel.org
Subject: [PATCH v2] NFSD: Fix RCU-related sparse splat
Date:   Mon, 29 Nov 2021 13:46:07 -0500
Message-Id:  <163821156142.90770.4019362941494014139.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; h=from:subject:message-id; bh=x5MVCZwZoUhlgwaj3CPu5w6BlSXTBCu9vYGSA6VNi2U=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhpR/p3ux4DVCDSVMpkFq5Jwrm6ijiEu0pLsBceSiF 9Dr2iyyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYaUf6QAKCRAzarMzb2Z/l5tfEA CFsdXX7mmvJaKjUzaPqLW6oukM6K1dT9tamcKf6gEABQvNZrigSJiV1VqYcqg9JtMy3aretGqr6oGr LeMCPs2b4gUWLccp3Gs4UIDZ9WksZL/1W1Xw6tKPW4qF3+Vq8XrkIBUXtMk26lRVQu2YqS8HcKIz6C LAc3kJGpF3k8xPwGIYRUfnMsddlYU7NNC8vnuZlJAG5O8Ezv9Bkufc0dJv4aeorqRvJsIwabduSK06 PA+z3qcJIRGgtMLFFG3ThlEzp6jrCiwORqRNoCefXsaD7RQQV2XTJJC+7JZsixbynzGIMadzE2iyze KPMlwh3lHUAqvxVF6BiUVUZDwN1S2N7v2gg4JZ+4oIDXTgLV2UvwaEysz94AeBPcTN2H/xc1vLuIrF NUMeZbAHDxQEnFoH6iNgwL048Cknqhzkv+WiN7cqTRPVcO00OGhCZKLYqyFGgB+FKV1FJ/p+VvbDO4 O53WJ/8Hz/HD67VGb3b6sbwIDNJtH5kI8PiqVfN4eJzShxM76qRdGqZrsnEl67tIBxewKYBU+E8Pal KXERoXYcruLQThmfDFhrkZFfDy8SR2yZr5CN6VmW5rJcbUr2+wAVnY/ASFxRxcsnRinF0aynUsMao5 0AydCDDTlsh122Cfutl9I1Utq5hNk68glYwmYkRstsy/TeryN1hPSFCPhDfA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To address this error:

  CC [M]  fs/nfsd/filecache.o
  CHECK   /home/cel/src/linux/linux/fs/nfsd/filecache.c
/home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9: error: incompatible types in comparison expression (different address spaces):
/home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net [noderef] __rcu *
/home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net *

The "net" field in struct nfsd_fcache_disposal is not annotated as
requiring an RCU assignment, so replace the macro that includes an
invocation of rcu_check_sparse() with an equivalent that does not.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fdf89fcf1a0c..3b172eda0e9a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -772,7 +772,7 @@ nfsd_alloc_fcache_disposal(struct net *net)
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	rcu_assign_pointer(l->net, NULL);
+	WRITE_ONCE(l->net, NULL);
 	cancel_work_sync(&l->work);
 	nfsd_file_dispose_list(&l->freeme);
 	kfree_rcu(l, rcu);

