Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45F079018A
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 19:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350443AbjIARkc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjIARkb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 13:40:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DDBE54;
        Fri,  1 Sep 2023 10:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4502EB82522;
        Fri,  1 Sep 2023 17:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90976C433C9;
        Fri,  1 Sep 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693590024;
        bh=UKS7WfwiBAf5L3NmDm0GoGm7mjygeHIx1WTlZp2pOqE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Zj2jIcx1jW0JgALfqpec4xfvlcDDegsCLacBNvcp1YEYNwqx6htxTiQZv0ZvydUou
         AG10CGiJBXZ3+92gZBG8pGMUJqvrDXtRBoWsN0VjGaB5Xz4E61s19GH6ty3ByScLdr
         lCFy5vfC1PWkBL7c4nvsK9tsBK0gkH7J4OefpkZ/jbbzna66paQIWrSyCcnNkb8/4e
         f6JcMEILkAhdNkmNPMk8SXUBihJHot3NJuI/qCroQrU6+4Uryfm8+46im2YyBLLIFp
         fHGKdy2GHfQ2xGR0afQoHFSGJ+sgPNq5b5irmBeOIPT3THHCEIYht+NzbHqPSPcU1L
         iEAlevNhsAyfA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 01 Sep 2023 13:39:56 -0400
Subject: [PATCH fstests v2 2/3] generic/357: don't run this test on NFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230901-nfs-skip-v2-2-9eccd59bc524@kernel.org>
References: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
In-Reply-To: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=756; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UKS7WfwiBAf5L3NmDm0GoGm7mjygeHIx1WTlZp2pOqE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk8iIGOowBUBmRDnzgVXoy1VT1eHgwwLRmxjJ94
 s3ClGUAuseJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPIiBgAKCRAADmhBGVaC
 FTfwD/0STzoYnbypLHV9JrNEcbjkS4eXJ2oO7RuLxsZDZkHb8IxtYuqlELWn9iXlOEJk7n0JPu0
 MGmaVCEeoluvruAc5fAxFxLMJgtJNSXGLF2skD1MMwIP6Q4H3j6ukozPPf0fV+YitA62HnPGqEc
 4wHWRD1fJOTuoqe0LsH9BAnY4emdl7WBMsy1x2NsuTX6Z574SyTfNNG+ZioyUSaAH0CxEhj4IpF
 +B6Z0vc8D3MBmx5VNEC+REnjTngoicihhGIQsRl4jwIypmylsJie4apehiEI7X1KJBvjAJaipEP
 EIa9GWNt6lvGOQMP1e4gb+GehJ6bmGi0mVrdUog7CUxzSscoF8E3hsiQSNfiwb9msOA+mCD1bpo
 X72CPe1XSwebNYzEL2LCsf4W/dKfRaDli5UiczMsQPIUYiHSC0nVd3XurJGDYwmKWxHmsaAWFND
 kvrgD2GDnTO3Fu5NZayNav+vEISSFn8JVw9JmJezpof9b+6MNOYfXNUH6tdxnCo9YeFajoQkWOv
 CDaOshA1MVGNbNaR/rWiNY2OmBuTJSwWCbeNyfI+STZ6dS7ltOllqhpx3+7YAR42KVb7OADziQS
 jjWy+GDPQ7HxoylF0kQr3WOPqXQ9EhF6h8GEePr/DPEMuRIpcy5fU2P1L7jtLyDL1pPGw3TwGy9
 /qZs73ccdwdAz8w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFS doesn't keep track of whether a file is reflinked or not, so it
doesn't prevent this behavior. It shouldn't be a problem for NFS anyway,
so just skip this test there.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/357 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/357 b/tests/generic/357
index ce748f854327..a0299b32bc90 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -24,6 +24,11 @@ _cleanup()
 . ./common/reflink
 
 # real QA test starts here
+
+# For NFS, a reflink is just a CLONE operation, and after that
+# point it's dealt with by the server.
+_supported_fs ^nfs generic
+
 _require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink

-- 
2.41.0

