Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CCB69F588
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 14:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBVNcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 08:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjBVNcN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 08:32:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA5D3B23B
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 05:31:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 930ABB8123A
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 13:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56F7C433D2;
        Wed, 22 Feb 2023 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677072623;
        bh=9Bn16TkRKwuNZyh/QyhM6dH7sZeD7Yv8zo7pheE5v5U=;
        h=From:To:Cc:Subject:Date:From;
        b=mVSBqNIaZcv6BI8R+dIYZHB7UXu7WJyGLSBOtrCg1MpY5zCZWc+DWngMNuqKkdM43
         Cbq0P7XHxo4ct5dj8FMuCMBg2IOAzGyon44LTFrOEOMbWA5YWoORZ+ZtMZJIYa4cWD
         YuSrRFoBZnPV9JdRhkaqXHNAFyxLEIxrtjiwYnG4NqxIlFqz5S5mYbfVSGfo2Kiz1m
         8AQLo7hBMc66laX4TS7D6pXn0qo64x85A2U8AZAHEMTi1/Ri3MR//JUTL50pLtzcEf
         7KfnOkv3a+aEsn0fzwoOtRLgi3Nq/4aFDCd2rcaASomLRmjaMMSwicfEu68Ur2PFQF
         aK9aEcvD08nmg==
From:   Jeff Layton <jlayton@kernel.org>
To:     bfields@fieldses.org, dai.ngo@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [pynfs PATCH] examples: add a new example localhost_helper.sh script
Date:   Wed, 22 Feb 2023 08:30:21 -0500
Message-Id: <20230222133021.29775-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
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

It's possible (and pretty common) to run pynfs against the server
running on the same host. Add a new serverhelper script for that
purpose.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 examples/localhost_helper.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 examples/localhost_helper.sh

diff --git a/examples/localhost_helper.sh b/examples/localhost_helper.sh
new file mode 100755
index 000000000000..6db123311e7a
--- /dev/null
+++ b/examples/localhost_helper.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+#
+# serverhelper script for running tests against knfsd running on localhost.
+# Note that this requires that the running user can use sudo to restart nfsd
+# without a password.
+#
+
+# server argument is ignored here
+server=$1
+command=$2
+shift; shift
+
+case $command in
+reboot )
+	sudo systemctl restart nfs-server.service
+	;;
+unlink )
+	rm $1
+	;;
+rename )
+	mv $1 $2
+	;;
+link )
+	ln $1 $2
+	;;
+chmod )
+	chmod $1 $2
+	;;
+esac
-- 
2.39.2

