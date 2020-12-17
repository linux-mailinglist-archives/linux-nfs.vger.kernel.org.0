Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0152DCA02
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgLQAhH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgLQAhG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:37:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13671C0611C5
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:57 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id h186so7330199pfe.0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbDcaPNStrMJolfkpGDq8bo0+S1aM8kH57WGB+N/bgk=;
        b=BCk0K4AHVicQkXpcak5NU03djFCPq79vUOgCMFhfiDjFsAf5s2bV/NjFC/t77GgNz3
         RY23oXqxBPu+85OdD0HyPFetYBlPkakxfK5igqIGLSbEUlRif35dWHGeRICbEvbvkmwb
         VLXtFwKjOIwOSCdfq/tA2jv/69/0reqhYNyr9vPIgDA+jgOXKvmEPAtPd/ct4k8znfj/
         ZeGihvHBAHAUMc7kZ93y/oAEPl8fRqBM0a5rTxVFYa5XD274BWjjreRP7WMw+8BSyUtv
         s8zDzKVRX0Xjzdlbgp5JvQYjaOxtxwCKEYwFC0lWPRQJUEhdwVKbjlHah98kijQ10PLk
         DayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbDcaPNStrMJolfkpGDq8bo0+S1aM8kH57WGB+N/bgk=;
        b=bwnYlp9Jn53kVpSMCnoP/pFV/+tZw2owTysJT81me+VhyfxkdpVx/lVCc7LyLgdkXu
         y5+e48PERKj6iSiMSpPqiHvFzjy1yOTY0d6nwqnZNoihoHa5GHv31AH4y7woRczfKa7+
         /4vKffbZ7V4txn8k+YFCVbyx3xdlK3cziUnh8AZnBpAvdQVBbYwmaaZh2nG62fmfqQfu
         x3igGH2fjh+hddHGu6t13VSRrR2r4UbR/J5QwYBgSujxYW4pITdZ6/KiVEq4g4qGx1YV
         BnhW9eXYRuF3THkTXt9T6opdKyKBsKAwv3UnVDxQmuDwB4XLNUMCGXKGfSuLz896Iuw/
         qtZA==
X-Gm-Message-State: AOAM533tJzsl36ukNrWFS4wF+G/Tjt6lsWcQoIU5+DwqFiZtnKiXRyRk
        gib7qnupnFUI4Uu9uBsB/d4pj98dOewCIg==
X-Google-Smtp-Source: ABdhPJyAnIRqYqa81hN0c/Nj1IAB58jkeYejc85P+5aIZg1Fp0lkzbRz7CqsqIGgrNtICfY98fIjkA==
X-Received: by 2002:a63:545f:: with SMTP id e31mr35505651pgm.327.1608165356711;
        Wed, 16 Dec 2020 16:35:56 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:56 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 10/10] st_flex: Fixup check for error in layoutget_return()
Date:   Wed, 16 Dec 2020 16:35:16 -0800
Message-Id: <20201217003516.75438-11-loghyr@hammerspace.com>
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
 nfs4.1/server41tests/st_flex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index c6df68f..d70b216 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -605,7 +605,7 @@ def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
                         0, NFS4_UINT64_MAX, 4196, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res, allowed_errors)
-    if nfsstat4[res.status] is not NFS4_OK:
+    if nfsstat4[res.status] is not 'NFS4_OK':
         return [res] # We can't return the layout without a stateid!
     layout_stateid = res.resarray[-1].logr_stateid
 
-- 
2.26.2

