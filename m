Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF85EAE21
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiIZRYG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiIZRXp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 13:23:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C242C151DCB
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 09:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09215B80B40
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 16:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7BAC433D7;
        Mon, 26 Sep 2022 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664210330;
        bh=R/s/21M6ZNBdHTLFlT1qvJRkgxilLGAnNqbcANIwQao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zs+wFtj5pSXjwk+jycY4FwDwny0WgN8Dovbe3EuU4AZpsbGHr026Hb46Tzyjsv+rp
         V0XT3Wfi3VAYQRZUmSb+w1loep2yzPblzr5M8olrSo5+5Re6aD+A0YoessOdB1zn9U
         GsJbV01WGJlfDvTjL/6ddhzHn7YsXqqIXHDoprJVC2zm7WJyR159tr9mmyEv1BfMkT
         PM/oR7CdCKiVjkv6+pC2TqKCA40a5gc2BbKYz12LqKa4+dxyUG9IghEUpgv14XxUpw
         sYUhlcIYaElqQCN2B3WjZiMVb2r3UVmyPz4ogLmp1nVScsFmqwVcwGLCiamcAYhLz+
         JfkeguYrnA2Bw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] nfsd: fix comments about spinlock handling with delegations
Date:   Mon, 26 Sep 2022 12:38:45 -0400
Message-Id: <20220926163847.47558-3-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 273ed890562c..211f1af1cfb3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4857,14 +4857,14 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	 * We're assuming the state code never drops its reference
 	 * without first removing the lease.  Since we're in this lease
 	 * callback (and since the lease code is serialized by the
-	 * i_lock) we know the server hasn't removed the lease yet, and
+	 * flc_lock) we know the server hasn't removed the lease yet, and
 	 * we know it's safe to take a reference.
 	 */
 	refcount_inc(&dp->dl_stid.sc_count);
 	nfsd4_run_cb(&dp->dl_recall);
 }
 
-/* Called from break_lease() with i_lock held. */
+/* Called from break_lease() with flc_lock held. */
 static bool
 nfsd_break_deleg_cb(struct file_lock *fl)
 {
-- 
2.37.3

