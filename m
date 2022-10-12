Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8A5FCAD2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Oct 2022 20:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJLSn0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Oct 2022 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJLSnZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Oct 2022 14:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80CA3453
        for <linux-nfs@vger.kernel.org>; Wed, 12 Oct 2022 11:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F6FC614E4
        for <linux-nfs@vger.kernel.org>; Wed, 12 Oct 2022 18:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9C1C433D6;
        Wed, 12 Oct 2022 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665600202;
        bh=R1ZAzJFd0tuFpVdwLyWfmNIKi8rFwxbZ38fD/QH2eyo=;
        h=From:To:Cc:Subject:Date:From;
        b=DvNaVP0Ipt1opmPu/0+26MEmSo4LrqJq6Zg9mEvqKcRUGoeYso+mY3t1V7QN8lD4e
         k4RAEcCNNNhS27ge7B5vNVTrkQcx3td/IDXKc9RE7xNhTZ+0JFeRFqOYb1fhTHAmKJ
         yPrnlm5VGdFjhlPWzMFRne4CjiIVcTPErd1VM3YpxX8EChcqS3Sd4Cigp+bNRxr8BM
         h8qT99k6WG2zJxLR97YojE78JOSWuqcg4yIFgFBT3elW/3fiGBmWNtSHn/NsX9NHci
         mVVap7batMDSImlVDrM5ZCLiKPaV/apXj5HOaG1DoxmKhYeSZZdR6uFPk+P4NCZKu7
         yiPHvt6/9V13Q==
From:   jlayton@kernel.org
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] nfsd: ensure we always call fh_verify_error tracepoint
Date:   Wed, 12 Oct 2022 14:42:54 -0400
Message-Id: <20221012184254.30539-1-jlayton@kernel.org>
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

From: Jeff Layton <jlayton@kernel.org>

This is a conditional tracepoint. Call it every time, not just when
nfs_permission fails.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 9c1f697ffc72..43bb34f1458e 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -392,8 +392,8 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
 	error = nfsd_permission(rqstp, exp, dentry, access);
-	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 out:
+	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
 		nfsd_stats_fh_stale_inc(exp);
 	return error;
-- 
2.37.3

