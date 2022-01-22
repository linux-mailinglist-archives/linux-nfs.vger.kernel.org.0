Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7395E496DB0
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiAVTuV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 14:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAVTuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 14:50:20 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7DBC06173B
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 11:50:19 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z7so2531519ljj.4
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 11:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=joEcAm6FEppBk6vSXt/6xsL1pjGawWUzoE2Kp7Bgaj0=;
        b=a16vp1dVqQtBMXJ/X4AfLFJDZJjkr1WEJrlJkBqoDbliRzQxlEPMmxZbcvliANiNNP
         YiQhlusGLXXRaRkheXm0pdoyestYgVwMiD+1AEB1ieEYBWf0sIy2PFWNBHzxg1wNu+v5
         iwpeRTTTuPwssKUMNHM8ckE9qH+qInFQIiyi88B5kmQHCV/mOLw5zhBGTAJAyQbBBPXg
         jt+RvW/O7h4mcz/Th6TbvqYzbUklhI+Xi1k3AAwFLBG4/u4O/NzKKVjD8v2lNictNggx
         k60vjRbRpu7FiBWtHXAT0X5Fo4OAOAs6U5SXkeJhCRy/ojHyxeWfvXwW6WhPvUw8Ucjf
         SMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=joEcAm6FEppBk6vSXt/6xsL1pjGawWUzoE2Kp7Bgaj0=;
        b=1jxRasYLusaC6UkE3VEJsES4zuZAH7LcECKJ/udMfxps+f8K9xUrQAiOUy1/W9rP/A
         7e73cAeHavBxWF4uA2M26TKFGJloZdC48lNq3Rqy1BawJu5o4o52aGZOqxly6ZBvmQHJ
         lj7OtSyFkxAKbXcvKZkb70Gpuzv+byZthe6g62qZCRt1uHJwb7gr0VI3R0lVbU5mQSRC
         TrLQYSn78UUZLybDpVWPvV2lhXCSHKy237chtMnG6AXQ8DTkazrBZMxX7GK+2n3blFUM
         UUJuYvD+T0bkb2eoOgdbd1bvSl9ZbDKkgITl8jq6bmckZW3UaX6lhpE3WsV3qHlvVtuv
         HA8Q==
X-Gm-Message-State: AOAM532M81VfsCGgYTqvkOzMfvf0iS01koVmDESwORd5bU+Mo2/5Ovig
        N3DbcFGsGPWLoRYWuxmUiO4=
X-Google-Smtp-Source: ABdhPJzvTP8DTXZSZ8u+IcqbBm4nSQwkSJc5o4xWkY7xXDqj3Da7I932+e+ivnMRrDQXatnsx6zKNw==
X-Received: by 2002:a2e:3c06:: with SMTP id j6mr6923600lja.484.1642881018146;
        Sat, 22 Jan 2022 11:50:18 -0800 (PST)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id x9sm78624lfn.282.2022.01.22.11.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 11:50:17 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        Ben Hutchings <benh@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] nfs-utils: tests: Skip test if /dev/log is missing
Date:   Sat, 22 Jan 2022 20:49:33 +0100
Message-Id: <20220122194932.118951-1-carnil@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Ben Hutchings <benh@debian.org>

Some build environments don't have a /dev/log, without which
the daemons will fail to run.

* Add a check_dev_log function to skip a test if it's missing
* Call it in t0001-statd-basic-mon-unmon.sh

Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 tests/t0001-statd-basic-mon-unmon.sh | 3 ++-
 tests/test-lib.sh                    | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/t0001-statd-basic-mon-unmon.sh b/tests/t0001-statd-basic-mon-unmon.sh
index 92517a144851..e1065e766ccc 100755
--- a/tests/t0001-statd-basic-mon-unmon.sh
+++ b/tests/t0001-statd-basic-mon-unmon.sh
@@ -21,8 +21,9 @@
 
 . ./test-lib.sh
 
-# This test needs root privileges
+# This test needs root privileges and /dev/log
 check_root
+check_dev_log
 
 start_statd
 if [ $? -ne 0 ]; then
diff --git a/tests/test-lib.sh b/tests/test-lib.sh
index e47ad13539ac..b62ac2a6db4d 100644
--- a/tests/test-lib.sh
+++ b/tests/test-lib.sh
@@ -37,6 +37,15 @@ check_root() {
 	fi
 }
 
+# Most tests require /dev/log. Skip the test if it doesn't exist in this
+# environment.
+check_dev_log() {
+	if ! [ -e /dev/log ]; then
+		echo "*** Skipping this tests as it requires /dev/log ***"
+		exit 77
+	fi
+}
+
 # is lockd registered as a service?
 lockd_registered() {
 	rpcinfo -p | grep -q nlockmgr
-- 
2.34.1

