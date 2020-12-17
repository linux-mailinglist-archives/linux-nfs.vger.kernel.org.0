Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FB2DC9FB
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLQAg1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQAg1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:36:27 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72197C0617A7
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:47 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n7so19015365pgg.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CB2U6/mY/SGaoO98CwmNd1Z7m9MDE5jUgBWgxTJAuY0=;
        b=ms8Pz2XgCVZuC7n3cOpRWPi3LA6Pc+SnZd2MJtHDQi2J+i+v2gECfDnawKor37BulT
         QCZ5Y4jBe95/Amdg27LMLqfW2R6Z696P3Yd9PrjP41Pei76MgBTS7TBFH3wzYlI5q7L8
         tTN+6IXovqNuNUHkLpk/a8SVwVS1TXRRD+Mnj79nH73qwvnhsCW++7XBkCSAF2zM5dNA
         yN5mdP7zkfItgOOmO20ELBBEXw7K0NwxQNiH/M+idrxNBR9TAmUkTxTh0qGoN0v077r7
         wJUhNBxVdrpf6AhC+0k0uhUfX2QeM8sC0QLHWy1OT2iPHq2P+f9R3pxow/tDL5JQShit
         tBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB2U6/mY/SGaoO98CwmNd1Z7m9MDE5jUgBWgxTJAuY0=;
        b=dUscvdWU/vjVHDuATeVggXweg5hcgp7xuva+mlbE673y0OrThDT5Xv713CoJvY1f8Z
         ve91MrErctLHBRCWTgu1Rf2zU/G3GYLKI1T9CbpEAm+5nkKqYa+BTHCU3UlAr9rjDxKm
         AEis+vhKrCZ8TE10K52jExhA7Po9ZgNkZBFmcM7Kh9PZm9nNmXcbUsi55zLPJnuWdE9R
         rqsoxsuXw/VMsGBT3eG43XhZxXLiYdcMTM+zt4wINqkDTTy0zbtnDsSOaoaQ+KczO6Vf
         1KdKjs359AYBE0ZkhrGo3yr3tWJXMuT4bKUDwb3r0BI2jTNOAXhgxSE6kStzkPz0U3T1
         eXOQ==
X-Gm-Message-State: AOAM531HP+CAaXHUS/DZEq+SAAcmN9puzPXY1k75+t6hbDdS5LPq+6HO
        Z2FbNhbOaPRUuezqPLt+YCscdJVq9Cy2zQ==
X-Google-Smtp-Source: ABdhPJwwslzoL8gUbJ0Li1LQHUC9SUjvaHrZJ9cor/dj/d80NDryt+paMGFUcZrUSBxGORE8Lte4Yw==
X-Received: by 2002:a63:5856:: with SMTP id i22mr35262429pgm.349.1608165347094;
        Wed, 16 Dec 2020 16:35:47 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:46 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 03/10] Close the file for SEQ10b
Date:   Wed, 16 Dec 2020 16:35:09 -0800
Message-Id: <20201217003516.75438-4-loghyr@hammerspace.com>
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
 nfs4.1/server41tests/st_sequence.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/nfs4.1/server41tests/st_sequence.py b/nfs4.1/server41tests/st_sequence.py
index 9be1096..969deb8 100644
--- a/nfs4.1/server41tests/st_sequence.py
+++ b/nfs4.1/server41tests/st_sequence.py
@@ -225,6 +225,7 @@ def testReplayCache007(t, env):
     check(res)
     fh = res.resarray[-1].object
     stateid = res.resarray[-2].stateid
+
     ops = env.home + [op.savefh(),\
           op.rename(b"%s_1" % env.testname(t), b"%s_2" % env.testname(t))]
     res1 = sess1.compound(ops, cache_this=False)
@@ -233,6 +234,10 @@ def testReplayCache007(t, env):
     check(res2, [NFS4_OK, NFS4ERR_RETRY_UNCACHED_REP])
     close_file(sess1, fh, stateid=stateid)
 
+    # Cleanup
+    res = sess1.compound([op.putfh(fh), op.close(0, stateid)])
+    check(res)
+
 def testOpNotInSession(t, env):
     """Operations other than SEQUENCE, BIND_CONN_TO_SESSION, EXCHANGE_ID,
        CREATE_SESSION, and DESTROY_SESSION, MUST NOT appear as the
-- 
2.26.2

