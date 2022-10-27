Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3EB6100B6
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 20:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiJ0Swr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiJ0Swq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 14:52:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584DE55C7A
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 11:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1487FB82773
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 18:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BE4C433D6;
        Thu, 27 Oct 2022 18:52:42 +0000 (UTC)
Subject: [PATCH v6 10/14] NFSD: Add a remove_nfs4_file() helper
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de, jlayton@redhat.com
Date:   Thu, 27 Oct 2022 14:52:41 -0400
Message-ID: <166689676164.90991.13013025488619531170.stgit@klimt.1015granger.net>
In-Reply-To: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>
References: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor to relocate hash deletion operation to a helper function
that is close to most other nfs4_file data structure operations.

The "noinline" annotation will become useful in a moment when the
hlist_del_rcu() is replaced with a more complex rhash remove
operation. It also guarantees that hash remove operations can be
traced with "-p function -l remove_nfs4_file_locked".

This also simplifies the organization of forward declarations: the
to-be-added rhashtable and its param structure will be defined
/after/ put_nfs4_file().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c793b62e2ec0..9d35865ea16d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -84,6 +84,7 @@ static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
 void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
+static void remove_nfs4_file_locked(struct nfs4_file *fi);
 
 /* Locking: */
 
@@ -591,7 +592,7 @@ put_nfs4_file(struct nfs4_file *fi)
 	might_lock(&state_lock);
 
 	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
-		hlist_del_rcu(&fi->fi_hash);
+		remove_nfs4_file_locked(fi);
 		spin_unlock(&state_lock);
 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
@@ -4733,6 +4734,11 @@ find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
 	return insert_file(new, fh, hashval);
 }
 
+static noinline_for_stack void remove_nfs4_file_locked(struct nfs4_file *fi)
+{
+	hlist_del_rcu(&fi->fi_hash);
+}
+
 /*
  * Called to check deny when READ with all zero stateid or
  * WRITE with all zero or all one stateid


