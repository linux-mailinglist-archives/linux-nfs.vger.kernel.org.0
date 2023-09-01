Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE0790189
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 19:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbjIARkb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 13:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjIARka (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 13:40:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD69CF3;
        Fri,  1 Sep 2023 10:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF9D3B823C3;
        Fri,  1 Sep 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0062FC433CA;
        Fri,  1 Sep 2023 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693590024;
        bh=HjNvhwGQdVXb8EZQzq8Ia733+IrZkicCXID9IHHZpm4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AJKbyuBNXxDA9ZizliaFC4nRA0kjDqRQHFZZWmEThhVHEvUPmBhy4Tv0YVHbMxTha
         HfBf5XqNQtvjvA+SNzHV7AJ+lNazq6zkdf8TdsJIsg+kiT2whDkutbs73ac9s1G2tX
         CoQWzPQn43S7+E0DJlnJNFgbSzf3JvsQMZkKTTAUJIrzUuxBttJL4osJQBm+dJnXjx
         atFcHzhlI86mWUky1K05+pXFnHwDoDy3Ysl7Oxmc5PtTWZTFn15yKMOAMXwcIneVg3
         fegDffQ9LDRmWt3BJab+dq+4Ea0u3dDnNFy3761hQIccbMePzCWrAwIlkAWUIDmM4r
         pJEjFIriKEI/g==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 01 Sep 2023 13:39:55 -0400
Subject: [PATCH fstests v2 1/3] generic/294: don't run this test on NFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230901-nfs-skip-v2-1-9eccd59bc524@kernel.org>
References: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
In-Reply-To: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HjNvhwGQdVXb8EZQzq8Ia733+IrZkicCXID9IHHZpm4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk8iIGYs74+Rv8jzc/eL7sqtY4RZRtbAsH7p7jw
 w9RwTp1MHyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPIiBgAKCRAADmhBGVaC
 Fcy0D/sHEQynAoEw9tWklNOCi3/EsxdAt7Ig79qRNhQgaFHu3avas7JTvXw0j/uxUPhNTKht9E/
 Iz+Q0hZHmN/4KdnclYxYy1Py1aSenHSZiMKPxF0tgkM5w6TiNOKUMxM06KzZ4EA8mHv+/5glfY0
 Pqd1d8SOxKQodSVmiuyddivzw5ZrvVQy2s4P7U9owRlTivdb9DOevBlVkHhd+Pu1A081wc+HlHx
 k1gB8V1wsL6LMzyCPRc7PVHQRwDJehGai5mmqlHSGXYK00fWMWLr9LkMnxESt6VXYxoJChObRYZ
 JJACcvKwH0A6wg3iZXVHheEblsfqvCavysW5o6eBTy6uiNS7oyTt3CPHLmY+CG/2Aq5d1ZSK4d3
 iJybC0QwkeATuqyZBKLmCZPpmtXk5EL3JZbir9+9OztZzLvnpBnIBUpNPLvYNr8uFwgpOXCkvkB
 eN5xS3vIqlrVx3pH9D3vGDt5atq/HUcv7F2RGNCE/uiA+lip7vUSpNoz9elTJaZNyXWP1AvGeRl
 hzxGQtquE1OU0J/hoDxRKJ2Rjah6xpAK1L97jihyX3IeAcX2+VkHWKaSRJvz781zOu3YV2eCN2r
 MIoXQN/s3j7vauG5TKySiC7G3Eb5G1j8oM2L52Sb0W4r+IJp+/UAQBKi0Tz6NPyfVqAQunTpDfu
 aOtbl9c0t/0AJAQ==
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

When creating a new dentry (of any type), NFS will optimize away any
on-the-wire lookups prior to the create since that means an extra
round trip to the server. Because of that, it consistently fails this
test.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/294 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/294 b/tests/generic/294
index 406b1b3954b9..46c7001234a5 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -15,8 +15,10 @@ _begin_fstest auto quick
 
 # real QA test starts here
 
-# Modify as appropriate.
-_supported_fs generic
+# NFS will optimize away the on-the-wire lookup before attempting to
+# create a new file (since that means an extra round trip).
+_supported_fs ^nfs generic
+
 _require_scratch
 _require_symlinks
 _require_mknod

-- 
2.41.0

