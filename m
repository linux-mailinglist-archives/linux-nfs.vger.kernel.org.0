Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B386F757C19
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGRMoq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGRMop (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 08:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15411188
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 05:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 832D66156A
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 12:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63D8C433C7;
        Tue, 18 Jul 2023 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689684283;
        bh=IoUNfcaF7/tZbN2IZSKCjZTyL731YwfjWh/+43zItSs=;
        h=From:To:Cc:Subject:Date:From;
        b=qUYfJQuVBQKS0EuP+gGybAjm5pLDribNvOIltNQY+oUq3Ca5rJfWqxZHvh64qbhLK
         ifhKPfhcwJw7tJ6T/lZeJrhPPFkuICY5hkrGlSt1XA/z64LWYCxE/bBxHVTBnLcSmP
         D7eTKuWLX+h7JV9Ws8muOIP76DnwcJX73Ha/XTmiy7fmepBQ2K49AC4dBnhlc/Ab67
         21jBSNbRSYntYgmlj3zhhCgSDr0senNNneu0femlsPGV3C3QrAdK0qG9t9D7BOV8jZ
         PTTcQeGTsALFbiwjs3KTghdtse2ycHHLlJ8LDQqJgJDwfYCuZpOl/OJ1goTXfb5EM3
         u5/DICpatHRww==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
Date:   Tue, 18 Jul 2023 08:38:37 -0400
Message-ID: <20230718123837.124780-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the client is calling TEST_STATEID, then it is because some event
occurred that requires it to check all the stateids for validity and
call FREE_STATEID on the ones that have been revoked. In this case,
either the stateid exists in the list of stateids associated with that
nfs4_client, in which case it should be tested, or it does not. There
are no additional conditions to be considered.

Reported-by: Frank Ch. Eigler <fche@redhat.com>
Fixes: 663e36f07666 ("nfsd4: kill warnings on testing stateids with mismatched clientids")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6e61fa3acaf1..3aefbad4cc09 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6341,8 +6341,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
-- 
2.41.0

