Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825E06B75E7
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 12:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCMLYI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCMLYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 07:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB3629435
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 04:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8508A61070
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 11:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D85C4339C;
        Mon, 13 Mar 2023 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678706644;
        bh=9Bn16TkRKwuNZyh/QyhM6dH7sZeD7Yv8zo7pheE5v5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTpnMmTltbMyneeBZY5/VoBMas/jl3cVh5WiD7hp6tUGBLd+bl4KkV1mQLzDbnc6M
         AcZPMiq65TkYMRmX4w4OTH1pTB8FF3EB5RCYRZWJsXdjlFVRgiiNB69iICszPBvvkM
         A4E4+HMtHmTWf/ZT/NN+cviI6lK2mGGGNbSn/viWe83jJlcwz8WX4A+62krjfce/D+
         jjDBUzXxG5A6XbQHqxaSRMEVBmqL662jhDE4d7spIvmNVbvUdW3AJCJjZQdBU2R2Aw
         bCWAo6j42qPd3ebj0+bGsd429v5VuGF4kTqUugtN6uQOElU4JT7xu2VhcSGh/v05Op
         ncP6d/YNRRWHQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     calum.mackay@oracle.com
Cc:     bfields@fieldses.org, ffilzlnx@mindspring.com,
        linux-nfs@vger.kernel.org
Subject: [pynfs PATCH v2 2/5] examples: add a new example localhost_helper.sh script
Date:   Mon, 13 Mar 2023 07:23:58 -0400
Message-Id: <20230313112401.20488-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313112401.20488-1-jlayton@kernel.org>
References: <20230313112401.20488-1-jlayton@kernel.org>
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

