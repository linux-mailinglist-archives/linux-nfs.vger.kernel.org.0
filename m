Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9354792D
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jun 2022 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiFLHXJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Jun 2022 03:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFLHXI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Jun 2022 03:23:08 -0400
Received: from out20-206.mail.aliyun.com (out20-206.mail.aliyun.com [115.124.20.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B8D21254
        for <linux-nfs@vger.kernel.org>; Sun, 12 Jun 2022 00:22:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04557695|-1;BR=01201311R181S36rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0306788-0.000804414-0.968517;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.O2fTfTn_1655018574;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O2fTfTn_1655018574)
          by smtp.aliyun-inc.com;
          Sun, 12 Jun 2022 15:22:54 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [RPC] nfsd: NFSv4 close a file completely
Date:   Sun, 12 Jun 2022 15:22:53 +0800
Message-Id: <20220612072253.66354-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFSv4 need to close a file completely (no lingering open) when it does
a CLOSE or DELEGRETURN.

When multiple NFSv4/OPEN from different clients, we need to check the
reference count. The flowing reference-count-check change the behavior
of NFSv3 nfsd_rename()/nfsd_unlink() too.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=387
Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
TO-CHECK:
1) NFSv3 nfsd_rename()/nfsd_unlink() feature change is OK?
2) Can we do better performance than nfsd_file_close_inode_sync()?
3) nfsd_file_close_inode_sync()->nfsd_file_close_inode() in nfsd4_delegreturn()
	=> 'Text file busy' about 4s
4) reference-count-check : refcount_read(&nf->nf_ref) <= 1 or ==0?
	nfsd_file_alloc()	refcount_set(&nf->nf_ref, 1);

 fs/nfsd/filecache.c | 2 +-
 fs/nfsd/nfs4state.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9cb2d590c036..8890a8fa7402 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -512,7 +512,7 @@ __nfsd_file_close_inode(struct inode *inode, unsigned int hashval,
 
 	spin_lock(&nfsd_file_hashtbl[hashval].nfb_lock);
 	hlist_for_each_entry_safe(nf, tmp, &nfsd_file_hashtbl[hashval].nfb_head, nf_node) {
-		if (inode == nf->nf_inode)
+		if (inode == nf->nf_inode && refcount_read(&nf->nf_ref) <= 1)
 			nfsd_file_unhash_and_release_locked(nf, dispose);
 	}
 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9409a0dc1b76..be4b480f5914 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6673,6 +6673,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
+
+	nfsd_file_close_inode_sync(d_inode(cstate->current_fh.fh_dentry));
 out:
 	return status;
 }
@@ -6702,6 +6704,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	destroy_delegation(dp);
 put_stateid:
 	nfs4_put_stid(&dp->dl_stid);
+
+	nfsd_file_close_inode_sync(d_inode(cstate->current_fh.fh_dentry));
 out:
 	return status;
 }
-- 
2.36.1

