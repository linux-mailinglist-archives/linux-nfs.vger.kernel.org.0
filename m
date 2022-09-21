Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA35C053A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Sep 2022 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiIURYr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Sep 2022 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIURYo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Sep 2022 13:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC9AEE1F
        for <linux-nfs@vger.kernel.org>; Wed, 21 Sep 2022 10:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8674362820
        for <linux-nfs@vger.kernel.org>; Wed, 21 Sep 2022 17:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89890C433C1;
        Wed, 21 Sep 2022 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663781081;
        bh=wYbEwHukjdss8SMs+MWyBUr7I1VWHuodyi6Yi+BOIZs=;
        h=From:To:Cc:Subject:Date:From;
        b=PIPD0ro8PPWjzkUcIK1Ml2Tqsyn6YpGUvjV3ZUvrRZu1E9P3+uooidHKjDt0paOTo
         xF6URerHO+aNJCbeZP06TpPZJiwSpT2ZwnFMYJt1E7Bj4i6+k/SJRKfXfDbp1f5Tmf
         Jxmq8XRLXf2dYzTY9qjUqXLrynWfiElQlbl8MuDpSFSCjyxK9Qae+n0GmLhwV3w9LD
         nK65TgJe7DYEQz6XZH7uJOZG6AlGE1CnG6f77bpJNDjkK3FfO5Ak7lfMn5vDuH9wUp
         3DZwSFk1zCBZxHVaYO4Eh34b0L3kNdrai6V2cjvzoQ2jD88WEQXsmG/Tu/2CSrM07Y
         l5UMfZutjQbAw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH] NFSv4.2: Add special handling for LISTXATTR receiving NFS4ERR_NOXATTR
Date:   Wed, 21 Sep 2022 13:24:40 -0400
Message-Id: <20220921172440.158049-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We can translate this into an empty response list instead of passing an
error up to userspace.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index b56f05113d36..fe1aeb0f048f 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -569,6 +569,14 @@ static int decode_listxattrs(struct xdr_stream *xdr,
 		 */
 		if (status == -ETOOSMALL)
 			status = -ERANGE;
+		/*
+		 * Special case: for LISTXATTRS, NFS4ERR_NOXATTR
+		 * should be translated to success with zero-length reply.
+		 */
+		if (status == -ENODATA) {
+			res->eof = true;
+			status = 0;
+		}
 		goto out;
 	}
 
-- 
2.37.3

