Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC278F2BE
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHaSkh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347075AbjHaSkh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 14:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79777E5F;
        Thu, 31 Aug 2023 11:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1820062E98;
        Thu, 31 Aug 2023 18:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA81C433C7;
        Thu, 31 Aug 2023 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693507233;
        bh=FaouWXSyNoqlksAxTZI+qZRB+12JU+ombIJZqAmTK58=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gUQnxdHl0z+Oi0WidjuOIN+2xzAlJXV7YKh1HDSzNOA3Wq0M288bKQqEP/uk0FDEd
         h0R0K6zZMH2lzVxarlip9Q6TMtF9JRUzzkxUNVvvYVQy6ra/ekiEZnRj3yEjAS8QgA
         Eb41JIyIoLVb4bz1KV+fmCIG6jcYk64T85BCX37Llz9s7wZvk7dGK+L2wXVPbyWWUm
         ELedP0YVoF8YgcOTKic9Mh3kNP5Yv7O9QjI4Z5pCxz5UX2qbK1uDg7IkA+9a0gBdgz
         nej8VIpGMVVBe4b0X5xsOzOp1CteIo7K6V2906nn1eZk3EOjmsl4PXkljIvZABg9dd
         Zpx8Dsqelexuw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 31 Aug 2023 14:40:30 -0400
Subject: [PATCH fstests 3/3] generic/187: don't run this test on NFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230831-nfs-skip-v1-3-d54c1c6a9af2@kernel.org>
References: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
In-Reply-To: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FaouWXSyNoqlksAxTZI+qZRB+12JU+ombIJZqAmTK58=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk8N6falyHJGBS3IPQXF1/D/0xBMcZVxhdrAgDv
 tJeV1KAub2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPDenwAKCRAADmhBGVaC
 FZoqD/4pSHY+BTgYN0g2P2KAtgmeK1mCJxMl4fjxmVkQeyvEsYeBpblrG7MFTevXJ5ihoW19Qkl
 NtWQL4l/TdrvMo4xpPGIi/+aqIySxakWnGOjajJeQjDlK9QeyHw+JcDatSZ/uHZjl+aoEiWGa0L
 i89/fEdlJCPNx2fEyNiMIar88LpPXoXkYhMfYPagXD2mv7L6sdzTbxlD5AJflVfMUE8TnsJbl6I
 Q98J764SL63k3aw7SjM+8e1ERo1GkFnqNgQMfkF4+LkEBNU/WJyTTduztz69BcM1xgmEbzdXR5T
 tacqJgEyRqh8qgwvUZAZJNYECYOACZWPOs5M7vVjbrWluRMTfTMC/+0FFB3+zpe185Hdpfmv7Sc
 kdOo+M9euWgB/5KaYzRNFgB/BJmL8CA5HK0gpV+eZ4mZpHQoyd4pWlC3/9Mhv3c9g4sujeME6Vt
 I5QwisnmGbgxbpeDpKSvJWtqcImCnNvjW/kTTCpPnXKQWdJGGDdwfxsq5PwH8UYK7toU0onsooI
 mHh4WJ9+lge32P/hn8stYnQzp4najYQo+Iy+NQ8q2213M2YYteawCzSBHJOQbZGulEesLjYx8tb
 54oN8cKrmV1bgR9sPWcj3b9qDHLdf9aruHhUnwYsMYwRLrfvb5H12kzilsXR6C9T7tEtO7Pfe90
 RB9HgWRR3BO4zAA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This test is unreliable on NFS. It fails consistently when run vs. a
server exporting btrfs, but passes when the server exports xfs. Since we
don't have any sort of attribute that we can require to test this, just
skip this one on NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/187 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/187 b/tests/generic/187
index 0653b92f12f4..05e609964a9d 100755
--- a/tests/generic/187
+++ b/tests/generic/187
@@ -36,6 +36,9 @@ _require_xfs_io_command "fpunch"
 test $FSTYP = "btrfs" && _notrun "Can't fragment free space on btrfs."
 _require_odirect
 
+# This test is unreliable on NFS, as it depends on the exported filesystem.
+test $FSTYP = "nfs" && _notrun "This test is unreliable on NFS"
+
 _fragment_freesp()
 {
 	file=$1

-- 
2.41.0

