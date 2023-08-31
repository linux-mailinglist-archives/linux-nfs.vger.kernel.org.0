Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED278F2BD
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347076AbjHaSkh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjHaSkg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 14:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABAEE64;
        Thu, 31 Aug 2023 11:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10EE063A78;
        Thu, 31 Aug 2023 18:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334CDC433C9;
        Thu, 31 Aug 2023 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693507232;
        bh=dprYPF1VZHCmXuM3H7T70x/zNnsCwEro0wn2qUK90c4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ss2hYmxoawmlmWgeFCfhrfGJXzPETA0SbJ872XWmw68QWUXnS01nXUzks3VKAeYpi
         VdlYoWNg7QQuptDXjFIPfM8v9SZc2tOyEAIzGkQyrOFmZapR9BgeycyvNMfVbgCCA7
         vnqk/j3QSqVL0mWklqueRyqdPF79RHqMvZQ+OTFe+GlSTIcqDJmRdkJU/IBNzFe03D
         IYXrYK9EviYPdKlhZxUmSXCqI/psbk2bGGaNhOhdfoINiy42FW0jjR3Wz0ux9zcJd8
         Rk7UUHe+42y6zEZIbO8ANDyEljpTv7onz9h51+OOf0C3fNnefIgMX5out32ihfZEC6
         adNBZwaJUTBJg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 31 Aug 2023 14:40:28 -0400
Subject: [PATCH fstests 1/3] generic/294: don't run this test on NFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230831-nfs-skip-v1-1-d54c1c6a9af2@kernel.org>
References: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
In-Reply-To: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dprYPF1VZHCmXuM3H7T70x/zNnsCwEro0wn2qUK90c4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk8N6fVyTHNgGxTqgqs/t/Y6qwXaDD9ux6TaJ16
 bRz4QTSOBWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPDenwAKCRAADmhBGVaC
 FWMlD/47o7zxv6uhOJhxGZIQphJue3CUB7rODjPnlljbMxzMYE/fNYjI0zTZX6FAkjzxYkXtCUT
 8QyL3rpk5Oc2UMG7LMDJyDTKD7FxrRzV09cCHfNunqC49y2ka0yLOhTTbDPl/zsRdwrtYIlwn+p
 7IGBIu/FWprP5u7oVH1f4dcpImsDrqq+T6zGMSgXY3Fyl0dbTR3ZPNVsMuzcyUNvy9iFgKct80L
 K0g928cg7OhVUirVRDGAohop4QB1q7wd1Z+kMw5z1IyFbM9/OqVx3KPch1jxMFK5y0jreBEuxhi
 qgErKgW+67DDcBVM3vy2NQAwyMNxhFhU2jA2bidwPNurrsjj9gjZXzl2xA/6Tt7Li1O3JvKz38T
 Ztr0MCDoapwMWEDUBn6skQz0mS3B0UMpuH79Qe/OLt/nF6ytTgbrgC1tze9jTTegyxk3kZt8DK+
 Jen+IJR1v/SicKVqzYmdg3Q1PGNPRX5owjObMaXLmtCOLW+WhwPhk7JFjDYhPYNPU1+4z0szzuR
 YFv/1nBHW7/NiIVnKkdnRZ+6l4W6W5YWjePrOt/Te/HY88rCVfNrquXf8sEQg0t/YqmV/gzlL0i
 MBMHP6goEaToP7QX9TwaxFkZXeyMTUIwB1RAuQ0z2WilT17cF/JMT3jDnNb8r6hsf3AOjJn+hEk
 mUmxgHiM+2gVHsg==
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

When creating a new dentry (of any type), NFS will optimize away any
on-the-wire lookups prior to the create since that means an extra
round trip to the server. Because of that, it consistently fails this
test.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/294 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/294 b/tests/generic/294
index 406b1b3954b9..777b62aec9ad 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -15,6 +15,10 @@ _begin_fstest auto quick
 
 # real QA test starts here
 
+# NFS will optimize away the on-the-wire lookup before attempting to
+# create a new file (since that means an extra round trip).
+test $FSTYP = "nfs"  && _notrun "NFS optmizes away lookups on exclusive creates"
+
 # Modify as appropriate.
 _supported_fs generic
 _require_scratch

-- 
2.41.0

