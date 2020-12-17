Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C455A2DCA01
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgLQAhG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgLQAhG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:37:06 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67236C061257
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:55 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p18so7394603pgm.11
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amNE1/ZvbK41u6+sZBiwKUhq349CVzHsftZ5n2dksVU=;
        b=PDOPoqjVxngXc12d2XyduKQ8HYafeWQDbXk1m1tSupt40rLCdsODI7Pw99kbW7mkZ/
         7mCqGx3s19iVRfU8orf87v0z9oI9qV3BqgvuUOxmawz6CV7Fuv4zij+bQjtDC4xawZYK
         l43XyFuXofhp9E6FomqqhGUoDkegKj0B8i/z9/Xa+nAp4Yu+ZOkohjq5GW1CCOIZ+0MD
         +2vC78zc2S3TtrwV4wZA44ADlmSty2EhLQyzlPGiaLBaS5I9qJ6YFMdym5q7P4NrEtUl
         FErv4QRL5H1nrClzrBNEbtrr+FbrV4gaeeeTWp6+937qVxV4yhuOgOR3boGH0i4qluGp
         2+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amNE1/ZvbK41u6+sZBiwKUhq349CVzHsftZ5n2dksVU=;
        b=kpFT2UIn6Q7hNf6vrifk/Ar4+n9NLPuCeNX8umHZCd2wraHn3vFg/dPE6c6zD0bzqG
         kMC1zdbIz4snU5zOxCHxw/o735Ax5b8g2SbEpatsmiY2etoZO/35GiBmZ3PM1pFnxSTw
         UwrM+Q7mALtRItNlqlD7UL5bYvqYWFj1UbJSUOcRph8WEeSfSfqwnptPxWwPfv+njjl4
         +dbIf4XO6ITWf0stdxy4XKhbjojBXZxbv6c3/UsviEskUKmyAoCr5rCGnCMkk+3Zn7Vk
         QCdpBjnwebzIqEtlwOpfP5P47NcM//2cfwc5QldFDghLPNo9dXojbZTeLbQkJUDX20Dd
         WIrA==
X-Gm-Message-State: AOAM531WJJRuOoo2BxVzNfsgn31Fw72QANDR2hy7hatISDk7bsNMIJ8t
        TpOaoHzFgLBjD2of6r3ACEJHnDGMv3u6bQ==
X-Google-Smtp-Source: ABdhPJzoqm9p1+titXv0qPwwZDxKt0RmJZMYFEWd2ETsVRhV4BIUL6Nk5lYx5mWvY4Jm7oafE729Cg==
X-Received: by 2002:a63:1d59:: with SMTP id d25mr11398935pgm.259.1608165355037;
        Wed, 16 Dec 2020 16:35:55 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:54 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 09/10] st_flex: We can't return the layout without a layout stateid
Date:   Wed, 16 Dec 2020 16:35:15 -0800
Message-Id: <20201217003516.75438-10-loghyr@hammerspace.com>
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
 nfs4.1/server41tests/st_flex.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 596c75e..c6df68f 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -605,6 +605,8 @@ def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
                         0, NFS4_UINT64_MAX, 4196, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res, allowed_errors)
+    if nfsstat4[res.status] is not NFS4_OK:
+        return [res] # We can't return the layout without a stateid!
     layout_stateid = res.resarray[-1].logr_stateid
 
     # Return layout
-- 
2.26.2

