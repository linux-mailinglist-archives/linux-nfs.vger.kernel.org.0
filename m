Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7842DC9FF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgLQAhF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgLQAhF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:37:05 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E1C061285
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:52 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t37so18982909pga.7
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdDxYmnLb2wv9cm8W0ouLRKbEvYIyAmeD8bMBdjy3M4=;
        b=rqIKfXYXw0ct/c+5wuRq5wSkbsTO7bL0PNOkMZviBfJVm2pt5SK/cuVlqk8MNnYWC6
         EpGYrqyl7p857wBbxtYffwVeFdU3UQ8pYD+9dGolDNNfftjOxIqGZjXi8vztZIfAwEDW
         qGeegFgAc9KHxCU1KQ7BxJJ+z5zc7bXoQPjmUfXsICoLpJemxsa8YRnFKfZfweIZllAl
         qgKwJIcRN+bJwffsaCXauvULoddGsdScHyCwnKc/oel/HMg/xSA/D5Ob1gpcH1SVhspM
         si3CNdgYD5wunzNJ1tEXD7ilK8D3gc0BeBEyMhi4dWj7q5G9lqYzomwMP3cGKYJNZaf4
         vvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdDxYmnLb2wv9cm8W0ouLRKbEvYIyAmeD8bMBdjy3M4=;
        b=MKuMROnXESgRrScvq6Art1ky5S5rxhy0H7hztb2ws5YrHjnBinXRdIRDbAgKrAqQ/v
         b6UYDfSXhmdQJdeS73CFlPnRS5kO6E2EPNJUHzQSspfJ2JTRZSJb134x0zOTD4mZpVTZ
         meENXCTDOBhuUQ9OZWpfYS20wNQpTrEZifvzz3tqvS2yAlxe1zI6nARSWmvzgu7elK3z
         FQ3plT/ViJpePz261h5r0OQgwFQr42x8dxMaKUhr7Bbz2h7WkFU/MAFq4peXnqO0DmdP
         Oehq1wmFAgqm0ab353JZe7O0sWq3rZOGV26RLzlor1e3sXCv535gAcNuHsDzPE6oTfRR
         2eEw==
X-Gm-Message-State: AOAM532SpGS9WeM2wkEVd27rvu0zaV/T7iFzfsTeNjlKpFP5ev0nawi4
        GWbkQ4E6CLZVWJQWc1Z152s=
X-Google-Smtp-Source: ABdhPJxAdSIdzb32rTdY0UkpJKrzePjIWP8Rd22vpIibvQC6avCzLSbUq1veFipu6A/iI2luc/A8UQ==
X-Received: by 2002:a63:181b:: with SMTP id y27mr35048253pgl.408.1608165352485;
        Wed, 16 Dec 2020 16:35:52 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:51 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 07/10] st_flex: Fix up test names
Date:   Wed, 16 Dec 2020 16:35:13 -0800
Message-Id: <20201217003516.75438-8-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217003516.75438-1-loghyr@hammerspace.com>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Tom Haynes <loghyr@hammerspace.com>
---
 nfs4.1/server41tests/st_flex.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 9d09dbc..63efdd2 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -894,7 +894,7 @@ def testFlexLayoutReturnNospcWrite(t, env):
     Send LAYOUTRETURN with NFS4ERR_NOSPC on WRITE
 
     FLAGS: flex layoutreturn
-    CODE: FFLORNOSPC
+    CODE: FFLORNOSPCWRITE
     """
     name = env.testname(t)
     sess = env.c1.new_pnfs_client_session(env.testname(t))
@@ -947,7 +947,7 @@ def testFlexLayoutReturnFbigWrite(t, env):
     Send LAYOUTRETURN with NFS4ERR_FBIG on WRITE
 
     FLAGS: flex layoutreturn
-    CODE: FFLORFBIG
+    CODE: FFLORFBIGWRITE
     """
     name = env.testname(t)
     sess = env.c1.new_pnfs_client_session(env.testname(t))
-- 
2.26.2

