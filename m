Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB675EAE22
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiIZRYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 13:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiIZRXq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 13:23:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE1151DC8
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 09:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 744ABB80B3C
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 16:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA798C433D6;
        Mon, 26 Sep 2022 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664210330;
        bh=salnlSZJRx/RgcK7N9RcDD7zm9apNgS7pq0wnLA5zxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/twETVyQcAs+GmxLVkl2EMRxzqDxfPlwkgf5OvxR04N0eSsPftrc3cKDC44BTo/k
         4/q2ERDvhTiGIqoOBAahTeJ2bQkE8doZJw54Ln4/PxegELUQobmDUwxrTNADCeSChq
         pN1gOXVQSrweAC9fwYxsTZ10iuO0Uq0WI6YYmHAG2rLUXi3EdfX3KG7YSnib4Bsa42
         oIDpJ/7PcdfwG6ivdxKT6iDiNSmNG7mBzYPfQ8S94nXwh+zo6TJjsk8Vf4QumMzbJK
         SL/czEcF6OslvYWjcTvEQslJq8NOZ+5YdoQv9hdURgopHFaeywicN6jVY3Dzic6VDZ
         k+eiCG06scNpw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] nfsd: only fill out return pointer on success in nfsd4_lookup_stateid
Date:   Mon, 26 Sep 2022 12:38:44 -0400
Message-Id: <20220926163847.47558-2-jlayton@kernel.org>
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

In the case of a revoked delegation, we still fill out the pointer even
when returning an error, which is bad form. Only overwrite the pointer
on success.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5a8f3d7cbe8..273ed890562c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6268,6 +6268,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		     struct nfs4_stid **s, struct nfsd_net *nn)
 {
 	__be32 status;
+	struct nfs4_stid *stid;
 	bool return_revoked = false;
 
 	/*
@@ -6290,15 +6291,16 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	}
 	if (status)
 		return status;
-	*s = find_stateid_by_type(cstate->clp, stateid, typemask);
-	if (!*s)
+	stid = find_stateid_by_type(cstate->clp, stateid, typemask);
+	if (!stid)
 		return nfserr_bad_stateid;
-	if (((*s)->sc_type == NFS4_REVOKED_DELEG_STID) && !return_revoked) {
-		nfs4_put_stid(*s);
+	if ((stid->sc_type == NFS4_REVOKED_DELEG_STID) && !return_revoked) {
+		nfs4_put_stid(stid);
 		if (cstate->minorversion)
 			return nfserr_deleg_revoked;
 		return nfserr_bad_stateid;
 	}
+	*s = stid;
 	return nfs_ok;
 }
 
-- 
2.37.3

