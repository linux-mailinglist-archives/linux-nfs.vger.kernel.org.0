Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77EE5EAE1F
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 19:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIZRYF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 13:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiIZRXp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 13:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC91151DC6
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 09:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 642D161029
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 16:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E651C43470;
        Mon, 26 Sep 2022 16:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664210331;
        bh=4aQTxyFHk1yHlT+oR3aAscCn1o/8MjoCJ22b8O8VS0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYHIVw3MMdQXk9mxmpKIXKFofAjkTYzOwIwFNHeb05WCP4LTtxmt/l+z7urZTC5c1
         4z65Q12NST1zZB0tmMfI9LM8VUWF8n0OSWaYNpEnkJwd646qd545H8YXVkkITX/wM2
         mUeXVLlASX4IELpTGMTNAsjqXfWQOvCuP5sS1vlG6vzRxeLNgvQk/+bOeZQG1TxkC9
         LsGqeyGN9Wae9Bqc2/S7I6LR7S635KngVIHktsqA1T4J7RYXj05QlPSzq+UeAe8Vv7
         XH9y6PRe1Zs4xUJHqTYyIMv7cNCfi09P7kxoKg+sIODBPH7ssuQESb2YjS9Z8svj9c
         3mcaYJwdWu4XA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] nfsd: extra checks when freeing delegation stateids
Date:   Mon, 26 Sep 2022 12:38:47 -0400
Message-Id: <20220926163847.47558-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926163847.47558-1-jlayton@kernel.org>
References: <20220926163847.47558-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We've had some reports of problems in the refcounting for delegation
stateids that we've yet to track down. Add some extra checks to ensure
that we've removed the object from various lists before freeing it.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2127067
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

This one may need adjustment after Dai fixes the use of openlockstateid
here.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 90533f43fea9..490092a10285 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1060,9 +1060,12 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct nfs4_client *clp)
 
 static void nfs4_free_deleg(struct nfs4_stid *stid)
 {
-	struct nfs4_ol_stateid *stp = openlockstateid(stid);
+	struct nfs4_delegation *dp = delegstateid(stid);
 
-	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
+	WARN_ON_ONCE(!list_empty(&stid->sc_cp_list));
+	WARN_ON_ONCE(!list_empty(&dp->dl_perfile));
+	WARN_ON_ONCE(!list_empty(&dp->dl_perclnt));
+	WARN_ON_ONCE(!list_empty(&dp->dl_recall_lru));
 	kmem_cache_free(deleg_slab, stid);
 	atomic_long_dec(&num_delegations);
 }
-- 
2.37.3

