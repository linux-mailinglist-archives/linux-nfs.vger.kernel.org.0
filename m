Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560132DF10E
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Dec 2020 19:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgLSSbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Dec 2020 13:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLSSbB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Dec 2020 13:31:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F393C061248
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w1so6122992pjc.0
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcafcFsF3exuV6RQUfYdPbxwdszjLSZqLsrKlz4PxyY=;
        b=NmhEesMHM3Uf17/pswG3ikkNe8UpQhBacEBwRCXkR6dXmhAN5LpBcw6rZIgJhZ30Y8
         SOPk686FZrOhjZNqK9bI78FdA2aU688yeMk4lY6JA6g864KBjrEyHtEi8V0lCFGG3oD6
         FMBesW9LHyHQIvxFmLWk+V6Q+Hphe2qv5/qMrBQYGT1GVCzfiXfUc5d6Yh44bUihv0s7
         1hBcBJ6e4c3CPP317C2FdfNJqxN3mv2/BpjUOOVp5qIqacue4JF08xq5lW4RePfWT1E4
         Y4JG6n2QtmlV9g2ke6iTIMuPsWVruQWMOHEfG7mWMcuPxUvSxBBWfW1S/7y1LmtsUH1B
         XzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcafcFsF3exuV6RQUfYdPbxwdszjLSZqLsrKlz4PxyY=;
        b=YcltKMMJyyojit/M6j27wA1QHWrCXTrtKdoOvNUfftmWCmDMrmuxH9u8nVkTMIeVhv
         gmj72OtV1oOYKoaykKTqBhYQq1zCS7cW48cxD+r98IEb6wvV4UrndL4SzDBK28Tm1tJx
         6a2+r72k+XhcGbJAsiChPL0o3NkQS7lt2tXnPdF6Bnu68KkQgAca2XN0nDJo45KnEqAQ
         2WwO1I1BDrtUJgtT5lcFnyAU0If9+oYIjruFPLGLq0yG/+6FBaT/io8CT68M47jTmPd2
         /AKPQyh0MdMW9q6aoHiW4144XC2m1qdN/SqYvPqjOEC/cg1VGmQPHbG411FthrbGF2rX
         PVHA==
X-Gm-Message-State: AOAM533cNeTi/VZWsGS5floiJM064zBEBAas5SfZEzcwMAvN/qjmpgFp
        sr1NC7gTh8aeybqzEdT2Ic0=
X-Google-Smtp-Source: ABdhPJwuQv2Xn5osCHGxVRGzfh/DZ3brOypeNmNGmdd+gSScu3NZbHdPspNtVEnTw/7TN8OzgWuFiA==
X-Received: by 2002:a17:902:c584:b029:da:cc62:22f1 with SMTP id p4-20020a170902c584b02900dacc6222f1mr9895301plx.54.1608402620870;
        Sat, 19 Dec 2020 10:30:20 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id l197sm12318471pfd.97.2020.12.19.10.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 10:30:20 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs python3 4/7] st_flex: Use range instead of xrange for python3
Date:   Sat, 19 Dec 2020 10:29:45 -0800
Message-Id: <20201219182948.83000-5-loghyr@hammerspace.com>
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
 nfs4.1/server41tests/st_flex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 7036271..80f5a85 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -1106,7 +1106,7 @@ def testFlexLayoutReturn100(t, env):
     fh = res.resarray[-1].object
     open_stateid = res.resarray[-2].stateid
 
-    for i in xrange(count):
+    for i in range(count):
         layout_error = None if i % layout_error_ratio else NFS4ERR_ACCESS
         layoutget_return(sess, fh, open_stateid, layout_error=layout_error)
 
-- 
2.26.2

