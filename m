Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB187BA0EE
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjJEOsH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbjJEOpr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 10:45:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B5B2C291
        for <linux-nfs@vger.kernel.org>; Thu,  5 Oct 2023 07:27:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26A4C116D5;
        Thu,  5 Oct 2023 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696498706;
        bh=d5XE/MSf7FUNkmuxaAGhzKlGv4qni/ds0rW0I4rggWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GMdCxTyN/ZXrU2gvITOIWvT+zTvUviqiUiLbxFT9RdyUd4ushHr1L68d01WdLV9OF
         1PKmuA9cssRgDX0t3RRC17nDVHzzwJZ2MwDvfjPxW+6l4O5ebLix71VXpvWtxxOoHR
         rH5RfEKdSxN+wMxsugRNdog+8NMTDBt21/ckCiJnXsO7mbwajkMnWRqgylgCEVtYRH
         9EX26F+pE/MoDUaiXJWUdtDU8WV3fTM82dCIIIfBOlQVy8agJlm2CHcof4wRyfHmga
         GdUWVZZuhu1HoB/9Xbb+Rgh+uIlTwVsDGTAuHS8ISYevNs2RE90YDjC1HlIUh2nYxw
         hTH2/DQTwblJQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, jlayton@kernel.org, neilb@suse.de,
        chuck.lever@oracle.com, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH] NFSD: remove NLM_F_MULTI flag in nfsd_genl_rpc_status_compose_msg
Date:   Thu,  5 Oct 2023 11:38:17 +0200
Message-ID: <3dd8abe7304ed6649e581bcaaaf61fc1278cb3e2.1696498541.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Get rid of unnecessary NLM_F_MULTI flag in nfsd_genl_rpc_status_compose_msg
routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfsctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b71744e355a8..739ed5bf71cd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1527,8 +1527,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	u32 i;
 
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			  &nfsd_nl_family, NLM_F_MULTI,
-			  NFSD_CMD_RPC_STATUS_GET);
+			  &nfsd_nl_family, 0, NFSD_CMD_RPC_STATUS_GET);
 	if (!hdr)
 		return -ENOBUFS;
 
-- 
2.41.0

