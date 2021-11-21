Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186D5458639
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Nov 2021 20:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhKUUAV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Nov 2021 15:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhKUUAV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 21 Nov 2021 15:00:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8B1060F42;
        Sun, 21 Nov 2021 19:57:15 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     paulmck@kernel.org
Subject: [PATCH] NFSD: Fix misuse of rcu_assign_pointer
Date:   Sun, 21 Nov 2021 14:57:14 -0500
Message-Id:  <163752463469.1397.703567874113623042.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; h=from:subject:message-id; bh=LxmHJecDlD00H9CTv7Fp5Nc9B/eHhqDFF56SXYICuGk=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhmqSa0+05pgAeqxkHBeiX7+bMZyXo9+stw2dgqzmV cwyAjmWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYZqkmgAKCRAzarMzb2Z/lw9kD/ 97mOPntGlUtUmq1277+NxZQgZYa8DJWSYpP4kbJEf/SIvcv4ocV8zGdlFNghcN6SesgGkFa2GXtHG7 GzId8rHbIpL3Z8yIVNaL4VmQcKjJgbVblQhuqKjqmTWmwuUxa60/DsDwOVcEuA8bUndQ8SbhF+/mA9 Z+Dj8/dmnFaO1630Hm6oIfKvdsiUzc7E9rJhiUKm3UE7LYdfSQWG8IpFR7CHK/2T/VUqUpLMlonXTi 16g3L0WDRp4udzimSWUdIFQmAgfsv58UuiwUZjKWB9UKNCEWNIO8ibTRf20XbehSliZfCv39Bs14I8 1fWRu/h+xcN/vn1bOxkFKi2n6GJTN4l5haSFqFqGVS7GR4LbZyaMe+rs/qnVaJKh+uPOQZ5nErx4KQ MJsitgX3ymlmNPaiIpaLsNjT84gTPfovML5IWvYD/c0N1ziCXGgyYfpz5A21l3wLWbpis21nltYus6 qV4BjWgnDGqcIgHW+Gk8NlEE104XhfO+Oym9yDWhYtpeiIKRvB+OGZzCBW33BAFxep2B4azNSBPOsC G+QEfEIDqbSSM+1SYjE3sxa7du2fA9T/NT1Z63XgIPvj4giPRabrChH04wW1lGVSdunaVCB1GevFnb 1y9nfYMwWKO1WCTzDndORo8J0GeLtb6meIkZjyFeoD8a6MvUw1HblR6+srYA==
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
requiring an RCU assignment.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fdf89fcf1a0c..3fa172f86441 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -772,7 +772,7 @@ nfsd_alloc_fcache_disposal(struct net *net)
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	rcu_assign_pointer(l->net, NULL);
+	l->net = NULL;
 	cancel_work_sync(&l->work);
 	nfsd_file_dispose_list(&l->freeme);
 	kfree_rcu(l, rcu);

