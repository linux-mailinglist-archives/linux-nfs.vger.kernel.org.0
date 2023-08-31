Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6375878F2BF
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 20:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347079AbjHaSki (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 14:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347075AbjHaSki (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 14:40:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D014AE5D;
        Thu, 31 Aug 2023 11:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55128B82344;
        Thu, 31 Aug 2023 18:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E04C433C8;
        Thu, 31 Aug 2023 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693507233;
        bh=sTbUtU7pe3hLO5cKrjbZHVIkvXTCJz4IN7jaRAjZQnw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uKMUinIRj3ctyEjlRmcp83bET50F1X8frlz5+u/ftvjAmuZ1yi5HUmgvXbYO3GQNp
         7wB+/sm4yPXkPifmIbqltGUKUQ7NUx46UI7ydbyejBNckrKxcDbbDUiVyZPxEBnqaQ
         XAbsi/fGn/zzCLbnGfFdjQZkYSHLl0FevUumv25k0xCTMbsJSq67oqCKGGcmZCPs+i
         ushgGaMRbolmmEA9el1VyLPiNXrL79jjYfwBVADM1hRiDsc8/RFNA7mrcE0IM0vL3T
         RMtEmfJc3IXAY9g14IuLnumX7ZkUbEG+uld9iaKDF26X+w1EvwQJNPeO5/YgieWO5m
         dJmkQdMV2xitQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 31 Aug 2023 14:40:29 -0400
Subject: [PATCH fstests 2/3] generic/357: don't run this test on NFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230831-nfs-skip-v1-2-d54c1c6a9af2@kernel.org>
References: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
In-Reply-To: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sTbUtU7pe3hLO5cKrjbZHVIkvXTCJz4IN7jaRAjZQnw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk8N6f9Bxt+Uut7uAZS43L1HCjDS3B89EjtW8TP
 4kRqVGEbmWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPDenwAKCRAADmhBGVaC
 FfnrD/oCwPdyHj3pRHpzwlNhXRvdBqgaUT6tmLF12riO7l3RyW1S5UZ6echRnoZzBwepgoRDcNA
 CZVIiH36pGJMrZ3XAgPDAm/Nu/eT8Xda8qYivOPV40ciwpGL5TqV/fWGpJtnOw3Mvpt5/aTb9YF
 sKatYB5ry4VTB9Jsds0B7HdQr7b4mx7LVJCtYp2hLwDPmrEbE32qqhxDUnZYq0WXhPGLtKi4JVG
 Cy2RX8Fb1lkHRzX3uowv+fTfA99rZULpSPZAyPg3bWbrlGJbo29A+OpZtoTdQaoIDFes2JzTk/B
 yOoH9tMP7Ir6uFnxVGDEBxr62n46sjdpyKHahQVP4FhrhJEi2O0CDakJjTZEzTvT5pKhF6XKIHF
 Owsm6Qbhb7ZXVRcPboIM5ioIu1+2/OH/lWLeztFDgeiMOKgwZUq7iCrKqVgCtsM5QzHKyPX6OvM
 tGiwPnDO/5ECqNCj4jZXmYQKSu7FepVUdS7+R/JKIRP4GDIVIHejG55citAMOmtVqUgPKbEgvCR
 /1Qw5309U0vCRKXJ2nNKLKkhKoy2GQsLKFzC+aeJnDwuWMnHkLT4604POwMeGcybQkFqO3j3tPh
 X/6hAwTNK8XHnYhCZNSWzOKt2hYNdhBSX57iZ6jTlbyMX1CncIC+gOCvlbL/ruPqIGVSjQ+4kbh
 UVJzu0A7nxHgX4Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index ce748f854327..909f0c8c6762 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -24,6 +24,11 @@ _cleanup()
 . ./common/reflink
 
 # real QA test starts here
+
+# For NFS, a reflink is just a CLONE operation, and after that
+# point it's dealt with by the server.
+test $FSTYP = "nfs"  && _notrun "NFS allows reflinked swapfiles"
+
 _require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink

-- 
2.41.0

