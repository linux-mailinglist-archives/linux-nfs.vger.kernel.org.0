Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17CA790187
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbjIARk2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjIARk1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 13:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8520E5A;
        Fri,  1 Sep 2023 10:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD2B621FA;
        Fri,  1 Sep 2023 17:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5926BC433C7;
        Fri,  1 Sep 2023 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693590023;
        bh=NT32IHHCo6NiGkkgXV2GnG57YP8dnHCRP7HvOyk4WX8=;
        h=From:Subject:Date:To:Cc:From;
        b=tN0GaLB58OK4/nAR+CUwdihi9e3Ds2TjJsGqyRyx+arkKYsMJwXa++Mu6XGhWhWGb
         bJPom8yNe6aEHBDNBfMa8yN+SjQ2FYwPSrdZTSY65POaTlHGN1I1H8cv8dev5aPDhO
         wMzu0lIONkieIFWr/Tn3blh6nlGnbcUR2KpbuSbYJydW5YEh7sfHKz9/jC/FM1pOTo
         OI8JI90xNRLfqyxSy/vI6+nHobrXtvuU1V+5sST+hILX/zW8bcqVzrD2S2+T6DRX4R
         Bn/pDJ9+HhTDCAWSeULLIUZZXquM9acZzF8R1DuBKurFr353BMf6L+Vkzm3u92UY95
         pV1x1CujPv3Cg==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH fstests v2 0/3] generic: skip a few tests on NFS
Date:   Fri, 01 Sep 2023 13:39:54 -0400
Message-Id: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsh8mQC/2WNywrDIBBFfyXMupZoXk1W/Y+ShSRjMqRocERag
 v9ecdvl4VzOvYDREzJM1QUeIzE5m0HdKlh2bTcUtGYGVaumfjRSWMOCDzrF0KtOd60ZsR8gz0+
 Phj4l9QLDATkwzFnsxMH5b7mIsuj/WpSiFmvXLnLp9aiNeh7oLb7vzm8wp5R+KISElaoAAAA=
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NT32IHHCo6NiGkkgXV2GnG57YP8dnHCRP7HvOyk4WX8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk8iIGxHxOtEo6e0yqXm7irha6Q6p5Fe9EX53q/
 OowwhN7F4aJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPIiBgAKCRAADmhBGVaC
 FfOaD/wLN6iJvDMzQdk2gNIH97MQeyf1AzcxMf1h1LOkJJXgyD58xBqbjUnhRoFhiGGVPHm46iJ
 I8wtlZMkNqdxPqeCnBgk0uRWUuy4blmiLWDevpDZa0RHquCykTg3JInuY2PDRkGJkcG2S5lA9xq
 LlPTDuWcygeHE0fDC3McAn+boDP7DZLLYXqW/v4ULgz745WNFZv1Ye6KSKwnaRne9i/paq2xKn0
 G/4fwWwNaSLlxVrp1C5K6vG2bzbd57j5AoJLg1FV44Pdql8Ws8cNipssg715m8TMsQ8OdDbnnY5
 Lj5JgIpPcBhhWjKa8R0NP8kIPuLlDvf04Z8Hr4wTqK00T2E6tqukIVX9V5wTzspjw0mpKogE2Mr
 JvH3seRXL1onqtoM/sBUVKPc5g3tRZUG9wgd2bukDuuKZdDSLnrzhO5CjEsK5VKLhOx/GBG//yV
 t2+l2aUzUF0Fh2SNZTem52qAyXyIvR6CphApRLJ7Hw+lhxnNmTpZ+gW+bo3TTR77yCI0f6YFISr
 uuqCqJINjJeswbGhk0yufefPO1eJNnkrDKvfZimj0XKQJHBz0d2b1SkqSm9X3rUr4/TUQNtl5UM
 q5TBnCgR7rpEdzBaxXoZ3KjiytcpX9QsbDz6g3nJTgdAk0/e2HZ5IyyyUKLApxjvmAg4g/scPca
 Zpv0WMat6V1fTIQ==
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

There are some tests in xfstests generic section that fail or are
unreliable for reasons that are known but are difficult to detect via
feature tests.

Check the FSTYP on these tests and _notrun if it's "nfs". Also add some
documenting comments as to why we skip them on NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- switch to using _supported_fs()
- Link to v1: https://lore.kernel.org/r/20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org

---
Jeff Layton (3):
      generic/294: don't run this test on NFS
      generic/357: don't run this test on NFS
      generic/187: don't run this test on NFS

 tests/generic/187 | 6 +++++-
 tests/generic/294 | 6 ++++--
 tests/generic/357 | 5 +++++
 3 files changed, 14 insertions(+), 3 deletions(-)
---
base-commit: 0ca1d4fbb2e9a492968f2951df101f24477f7991
change-id: 20230831-nfs-skip-7625a54f9e67

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

