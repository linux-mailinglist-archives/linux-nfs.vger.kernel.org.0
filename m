Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D616D0E35
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjC3S5p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjC3S5o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 14:57:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4B4EE
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 11:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D5E8B829FD
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 18:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2793C433EF;
        Thu, 30 Mar 2023 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680202651;
        bh=QDXMO2FEUG9Rq0gCBC/aH3GNSlZ95N80wNNvQFm9oDc=;
        h=From:To:Cc:Subject:Date:From;
        b=p4vjxyNZHY6N7jK3jmTGzzrlSxRUdj6kU8y8R6DifTrXsmstyAm6HPac84qeSIgri
         d5/+qdp/8+3IhLwGBY2MmPWBLGAe3WfJxprcqvxmiqAawQQuU8JcymeTLCdGxvExyX
         YeomJ1CLnwLYV9uUtwjpaA0YIVhhnjS+ovxGpewaZw/Th+Rb43TtR5RnxhJbgvE6Fn
         cfi6DqbG++aAebAki3kAuviWFuzwN2pYkbOA7ekUgMZQbpDsHcGUButj1ZI07R3qsi
         mOvtGgHNkeNnAOt7wxgLrIAoBwCjaxPVuRnImg28FXFRneZToVJmzyLX76sbjWrW0o
         PKppOGESxU8Pg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: don't allow OPDESC to walk off the end of nfsd4_ops
Date:   Thu, 30 Mar 2023 14:57:29 -0400
Message-Id: <20230330185729.22895-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that OPDESC() doesn't return a pointer that doesn't lie within
the array. In particular, this is a problem when this funtion is passed
OP_ILLEGAL, but let's return NULL for any invalid value.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

This is the patch that I think we want ahead of this one:

    nfsd: call op_release, even when op_func returns an error

If you end up with OP_ILLEGAL, then op->opdesc ends up pointing
somewhere far, far away, and the new op_release changes can trip over
that.  We could add a Fixes tag for this, I suppose:

    22b03214962e nfsd4: introduce OPDESC helper

...but that commit is from 2011, so it's probably not worth it.

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5ae670807449..5e7b4ca7a266 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2494,6 +2494,8 @@ static __be32 nfs41_check_op_ordering(struct nfsd4_compoundargs *args)
 
 const struct nfsd4_operation *OPDESC(struct nfsd4_op *op)
 {
+	if (op->opnum < FIRST_NFS4_OP || op->opnum > LAST_NFS42_OP)
+		return NULL;
 	return &nfsd4_ops[op->opnum];
 }
 
-- 
2.39.2

