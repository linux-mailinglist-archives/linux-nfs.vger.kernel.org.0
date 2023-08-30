Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A482F78D803
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjH3S3M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244375AbjH3NGK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 09:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1499193
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 06:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 500E56134C
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 13:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610B5C433C8;
        Wed, 30 Aug 2023 13:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693400765;
        bh=8YNoDsKyvEOAqvMXS6auonxVy5cbm4WKA1mJHcz1uaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uw+KWRhq/eCFg0xBDHljYIgCY2ASTiTQtXZKw8fwbBAAFPbV5ZZzXZBj92UfxJvoo
         wOpYdUh3OqmdXPB/Zmx493AX6+akLxDa8W53zuiglZ2yr8xbhe+ThEvQi2jopZjTdn
         31v3Nn7yN+cYowvL/oGNSZtfmVhhwKV/sJacUG0c2+HxrU+KPkD8oenIbFx0w6AB88
         Eb4s+YvnMtIESDf4iYnsdxNFVR8Q7gMddsU1AkACPYAwKfskMa1HJdI0HuwR8OMkDe
         iAsPk05RCfb8XyxnSXhw55W2ejy7IU3oveHFFg9+/fG5hRnAVOG3CEjl54BS4G5fGD
         RLzt+Rqi3xEuQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v7 2/3] SUNRPC: export svc_proc_name utility routine
Date:   Wed, 30 Aug 2023 15:05:45 +0200
Message-ID: <8861f1a29674f6d1be43cb4b0adec2d46559f2de.1693400242.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693400242.git.lorenzo@kernel.org>
References: <cover.1693400242.git.lorenzo@kernel.org>
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

This is a preliminary patch to introduce nfsd_rpc_status netlink info
in order to dump pending RPC requests debugging information.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/sunrpc/svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index dc21e6c732db..458139a6a4d2 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1652,7 +1652,7 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
 		return rqstp->rq_procinfo->pc_name;
 	return "unknown";
 }
-
+EXPORT_SYMBOL_GPL(svc_proc_name);
 
 /**
  * svc_encode_result_payload - mark a range of bytes as a result payload
-- 
2.41.0

