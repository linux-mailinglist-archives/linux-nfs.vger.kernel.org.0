Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21DA75928F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 12:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGSKSB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 06:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGSKR7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 06:17:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECEB1BF5
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 03:17:57 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5Wwd4FHBzBRDrZ
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 18:17:53 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689761873; x=1692353874; bh=OPzYp2r3St+A8ub/rS9zAYkNqGK
        Z1nd9QbmIsgDXZNg=; b=uWICH71hDS+2mPc980QwOBS8Chqp4GncOtzGK93Q0Xt
        GV0XQAI21kBFQ+KRVxRLzLeFsVByx2I6WcmV9Yo7RTars7rXqgAPzpcvd+h/aI6Z
        kXjKB7SSyiU0WWgtUs3iMUBaYfcIybrnCrIOjONPxBKuQe3qNYkljVedjr8lKTiU
        Qjw7hi8skfrBa0Y4BkZYagD8m7f1mDIu5+9ROeP7cHOha/12hYrCU3K+7OYO/i4m
        aLH4AxzQNED5G3m8HKFElwyZDO9cWgIaDDYmJ38xouGdzyGwwZcFd0LsLrbMVJUh
        j2yrS7n4IIBXHho19nYfUeVKT0BrcMkLj00cEKogl1Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UU2qw4c9b7Re for <linux-nfs@vger.kernel.org>;
        Wed, 19 Jul 2023 18:17:53 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5Wwd2JQ1zBRDrT;
        Wed, 19 Jul 2023 18:17:53 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 18:17:53 +0800
From:   huzhi001@208suo.com
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSv4.1: Fix errors in nfs4state.c
In-Reply-To: <tencent_5D2B9BC6DA996AFC3A398652FB2DAD9BB207@qq.com>
References: <tencent_5D2B9BC6DA996AFC3A398652FB2DAD9BB207@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <e19db8d4e30d076af0c9dc46413ad1df@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  fs/nfs/nfs4state.c | 58 ++++++++++++++++++++++------------------------
  1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index bbe49315d99e..8fedb9a4efd5 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -788,14 +788,14 @@ static void __nfs4_close(struct nfs4_state *state,
      /* Protect against nfs4_find_state() */
      spin_lock(&owner->so_lock);
      switch (fmode & (FMODE_READ | FMODE_WRITE)) {
-        case FMODE_READ:
-            state->n_rdonly--;
-            break;
-        case FMODE_WRITE:
-            state->n_wronly--;
-            break;
-        case FMODE_READ|FMODE_WRITE:
-            state->n_rdwr--;
+    case FMODE_READ:
+        state->n_rdonly--;
+        break;
+    case FMODE_WRITE:
+        state->n_wronly--;
+        break;
+    case FMODE_READ|FMODE_WRITE:
+        state->n_rdwr--;
      }
      newstate = FMODE_READ|FMODE_WRITE;
      if (state->n_rdwr == 0) {
@@ -905,9 +905,8 @@ void nfs4_free_lock_state(struct nfs_server *server, 
struct nfs4_lock_state *lsp
  static struct nfs4_lock_state *nfs4_get_lock_state(struct nfs4_state 
*state, fl_owner_t owner)
  {
      struct nfs4_lock_state *lsp, *new = NULL;
-
      for(;;) {
-        spin_lock(&state->state_lock);
+        spin_lock (&state->state_lock);
          lsp = __nfs4_find_lock_state(state, owner, NULL);
          if (lsp != NULL)
              break;
@@ -1120,25 +1119,25 @@ void nfs_free_seqid(struct nfs_seqid *seqid)
  static void nfs_increment_seqid(int status, struct nfs_seqid *seqid)
  {
      switch (status) {
-        case 0:
-            break;
-        case -NFS4ERR_BAD_SEQID:
-            if (seqid->sequence->flags & NFS_SEQID_CONFIRMED)
-                return;
-            pr_warn_ratelimited("NFS: v4 server returned a bad"
-                    " sequence-id error on an"
-                    " unconfirmed sequence %p!\n",
-                    seqid->sequence);
-            return;
-        case -NFS4ERR_STALE_CLIENTID:
-        case -NFS4ERR_STALE_STATEID:
-        case -NFS4ERR_BAD_STATEID:
-        case -NFS4ERR_BADXDR:
-        case -NFS4ERR_RESOURCE:
-        case -NFS4ERR_NOFILEHANDLE:
-        case -NFS4ERR_MOVED:
-            /* Non-seqid mutating errors */
+    case 0:
+        break;
+    case -NFS4ERR_BAD_SEQID:
+        if (seqid->sequence->flags & NFS_SEQID_CONFIRMED)
              return;
+        pr_warn_ratelimited("NFS: v4 server returned a bad"
+                " sequence-id error on an"
+                " unconfirmed sequence %p!\n",
+                seqid->sequence);
+        return;
+    case -NFS4ERR_STALE_CLIENTID:
+    case -NFS4ERR_STALE_STATEID:
+    case -NFS4ERR_BAD_STATEID:
+    case -NFS4ERR_BADXDR:
+    case -NFS4ERR_RESOURCE:
+    case -NFS4ERR_NOFILEHANDLE:
+    case -NFS4ERR_MOVED:
+        /* Non-seqid mutating errors */
+        return;
      }
      /*
       * Note: no locking needed as we are guaranteed to be first
@@ -1335,7 +1334,7 @@ int nfs4_client_recover_expired_lease(struct 
nfs_client *clp)
          if (ret != 0)
              break;
          if (!test_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state) &&
-            !test_bit(NFS4CLNT_CHECK_LEASE,&clp->cl_state))
+            !test_bit(NFS4CLNT_CHECK_LEASE, &clp->cl_state))
              break;
          nfs4_schedule_state_manager(clp);
          ret = -EIO;
@@ -1643,7 +1642,6 @@ static int nfs4_reclaim_open_state(struct 
nfs4_state_owner *sp,
  #ifdef CONFIG_NFS_V4_2
      bool found_ssc_copy_state = false;
  #endif /* CONFIG_NFS_V4_2 */
-
      /* Note: we rely on the sp->so_states list being ordered
       * so that we always reclaim open(O_RDWR) and/or open(O_WRITE)
       * states first.
