Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20F22DF10F
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Dec 2020 19:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgLSSbi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Dec 2020 13:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgLSSbh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Dec 2020 13:31:37 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B8C061257
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:22 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c22so3445088pgg.13
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQgD9OtFG7dCo48p/I3yqxvAtbo3rjfCH/WpeBOk0kI=;
        b=gzFwUKuLvs0HT2kilg27FPUuh6/dLvh8ZAX0fTerqjyssTmoRw9ubb4V1qMVFPATGr
         uR40VAWHgGA2/NpToYlVy/MOsGwWkCU7b9SvNYWWqjzhDpmh4qOz0bQ9aBr+YtH9SzxN
         b+Aju4PKg38ZgkTcFe9BugX4XCab+6lOB3b2Trt+VXPrgo/0qziEBb3om0miYo9vPaj6
         1yxjiFniaBTb8wuMHzCGyeuHBPJ1rbHxUmNmmOVbWVQFHZ9+AoIEo4erPg0SQXpEeVbm
         mJGgVSTkg5yCXKp5bZBk35Ha8RjWUOLo1SfnfZHL9XLBQyyHmWMk0CE8rfAiDdpXOScz
         LSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQgD9OtFG7dCo48p/I3yqxvAtbo3rjfCH/WpeBOk0kI=;
        b=nPqQIz5D20ZeWsYY82Kupxs2SkL64izFBmmDI7yNTtouuIX8pWtvAL2HebVJ318Mcu
         AaHOCclXTAU4a0z8wtDzN3ldwOt58BohSVIDlCJglWqcQQDUQgw5GXVlp69RjKSp2+3X
         PBByyUOaxojXxEIZvNwIQwlP8Qx0xVJFAz99MeFBS3yPddljjSFgunNna1jGhKOawbbu
         6Z7Jajj05/4bLYFtI+F96JWb4iqq5DQ6H6w55s8+MO5uUvbjPKNuhVmBJirBlRyDuMco
         tYwPtWXfloFO5Q5kw6Forp+zLaFTpk6+uMVdh2WmVXWq9R75NBvYbh+xFv4LgBnbk1zF
         4+1g==
X-Gm-Message-State: AOAM532gXsjlXNo4HS1+rDVJNcHyq6mNFFLRiaQgi8LCZLIw76pGgoJ6
        JL/KQh0SgR1qBf4zj2gDueVm2Y3oyw5RPg==
X-Google-Smtp-Source: ABdhPJzVlhpzV910oQp1Wt037wrr0A8eDbIWYKMkdfmLV19HWH0SDCSqSg1RhIGuGBV4P2UwLVQ7QQ==
X-Received: by 2002:a05:6a00:1481:b029:197:fc39:f646 with SMTP id v1-20020a056a001481b0290197fc39f646mr9137291pfu.57.1608402622073;
        Sat, 19 Dec 2020 10:30:22 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id l197sm12318471pfd.97.2020.12.19.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 10:30:21 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs python3 5/7] st_flex: Test is now redundant
Date:   Sat, 19 Dec 2020 10:29:46 -0800
Message-Id: <20201219182948.83000-6-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201219182948.83000-1-loghyr@hammerspace.com>
References: <20201219182948.83000-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tom Haynes <loghyr@excfb.com>

Signed-off-by: Tom Haynes <loghyr@excfb.com>
---
 nfs4.1/server41tests/st_flex.py | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 80f5a85..3aae441 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -59,39 +59,11 @@ def testStateid1(t, env):
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
 
-def testFlexGetLayout(t, env):
-    """Verify layout handling
-
-    FLAGS: flex
-    CODE: FFGLO1
-    """
-    sess = env.c1.new_pnfs_client_session(env.testname(t))
-    # Create the file
-    res = create_file(sess, env.testname(t))
-    check(res)
-    # Get layout
-    fh = res.resarray[-1].object
-    open_stateid = res.resarray[-2].stateid
-    ops = [op.putfh(fh),
-           op.layoutget(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_READ,
-                        0, NFS4_MAXFILELEN, 4196, open_stateid, 0xffff)]
-    res = sess.compound(ops)
-    check(res)
-    # Parse opaque
-    for layout in res.resarray[-1].logr_layout:
-        if layout.loc_type == LAYOUT4_FLEX_FILES:
-            p = FlexUnpacker(layout.loc_body)
-            opaque = p.unpack_ff_layout4()
-            p.done()
-    res = close_file(sess, fh, stateid=open_stateid)
-    check(res)
-
 def testFlexLayoutReturnFile(t, env):
     """
     Return a file's layout
 
     FLAGS: flex
-    DEPEND: FFGLO1
     CODE: FFLOR1
     """
     sess = env.c1.new_pnfs_client_session(env.testname(t))
-- 
2.26.2

