Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475AE2FF399
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 19:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbhAUSwI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 13:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbhAUSux (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 13:50:53 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B980CC061794
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 10:49:59 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 66B8468A6; Thu, 21 Jan 2021 13:49:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 66B8468A6
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/9] nfsd4: simplify process_lookup1
Date:   Thu, 21 Jan 2021 13:49:47 -0500
Message-Id: <1611254995-23131-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
References: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This STALE_CLIENTID check is redundant with the one in
lookup_clientid().

There's a difference in behavior is in case of memory allocation
failure, which I think isn't a big deal.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1d2cd6a88f61..f9f89229dba6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4680,8 +4680,6 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	struct nfs4_openowner *oo = NULL;
 	__be32 status;
 
-	if (STALE_CLIENTID(&open->op_clientid, nn))
-		return nfserr_stale_clientid;
 	/*
 	 * In case we need it later, after we've already created the
 	 * file and don't want to risk a further failure:
-- 
2.29.2

