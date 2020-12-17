Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EEA2DC9FA
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgLQAg0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQAg0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:36:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE03C0617A6
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hk16so2895506pjb.4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8YrcZrKeSFFqATQtiyrRFHewQ4YVS0MdlJV09OWEoc=;
        b=A+3CptrABWP45Y007gHeWnXYAu/pXWwYcFuyRTUHLPwRNbbN1NiDnSnPFLVf2CbI6M
         9s5UkMFu3LK5kRI5bUF7KDjVzZRBaB9zw/Eph2BsCdJWG61aw6FJ3ouhmb/QOY+9nnnt
         qazMUaBS0b0PbAugQJMpPOoVFobuEE7tZeIdAonqLyrlIdEG8epRwZx5NUTQ5p7PcVoC
         m5gb854rI+LCbxWkBJrpYJppqw/DKCSj01Q9zDpEBCE7dzrs1LIpL9AGaV9XJ2cpOEe6
         JWWlv2Vq8M2BXbbKE0fPHVQjAzYu8i8fr/q6e7WSCh4061Mn8N0EbusuIM5sDpcdZHuo
         pzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8YrcZrKeSFFqATQtiyrRFHewQ4YVS0MdlJV09OWEoc=;
        b=aAyZAvUOWtFjEvnMwT4spFRALMw9pjynKjRp8+aUWMX5w+JtbcSRzOvcwGf75DG7Yy
         m2zDEhvFhdynfDyTp1609P9jPhNhQrs3I00oCaJM1Ly/Sy6bhH1SkjOlvrFjUIgroH6x
         n8Tt7xQKx9GmuiRLygF8lmLh2djfAzyoI5A0neCzwBDozKJAJ5l5smW4xO/mGj3+yaA6
         zVXXGz9YNUeuljOhHhgxQppKnDG3Edo90bh7A/CTjABAH5FlP9K7z8vEk56SZ6HAtpYn
         LzcfNt9YP28h5p+uJUSVd9TajeRZ2TzrfmCbQzTq0oQAhg10/Mx/dzqEFYwuMLFeop6g
         T5xg==
X-Gm-Message-State: AOAM530aq6nVrgnvxwYgGEIKhZA8UDd+BIf/XDKPlkx6rkTOjuRAiym0
        3mmDMiREVTcSNt2XC+AEwOI=
X-Google-Smtp-Source: ABdhPJzSAuQvCZctE8tyVMliAg0biM1X11HzlSGKkCDo4/dVYn03xSzy6bZ73qbZUv5nl3HAO8BVDA==
X-Received: by 2002:a17:90a:31cb:: with SMTP id j11mr5456758pjf.6.1608165345854;
        Wed, 16 Dec 2020 16:35:45 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:45 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 02/10] st_flex.py - Fixed flag names
Date:   Wed, 16 Dec 2020 16:35:08 -0800
Message-Id: <20201217003516.75438-3-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217003516.75438-1-loghyr@hammerspace.com>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jean Spector <jean@primarydata.com>

---
 nfs4.1/server41tests/st_flex.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index a1d1f8c..cbc1166 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -502,7 +502,7 @@ def testFlexLayoutStatsReset(t, env):
     """These layoutstats are from when the client effectively resets them
     by having one field be less than the cumulative ancestor
 
-    FLAGS: flex layoustats
+    FLAGS: flex layoutstats
     CODE: FFLS2
     """
 
@@ -533,7 +533,7 @@ def testFlexLayoutStatsStraight(t, env):
     to keep the server from detecting the reset. I.e., the client
     has not lost it all!
 
-    FLAGS: flex layoustats
+    FLAGS: flex layoutstats
     CODE: FFLS3
     """
 
@@ -562,7 +562,7 @@ def testFlexLayoutStatsOverflow(t, env):
     """These layoutstats are a write intensive work load in which eventually one stat takes
     twice longer than the collection period.
 
-    FLAGS: flex layoustats
+    FLAGS: flex layoutstats
     CODE: FFLS4
     """
 
-- 
2.26.2

