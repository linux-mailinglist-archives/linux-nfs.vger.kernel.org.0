Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A15C2DF110
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Dec 2020 19:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLSSbi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Dec 2020 13:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgLSSbi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Dec 2020 13:31:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E121C0611CA
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:25 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b5so3304974pjl.0
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dQ16zpkiKKpGEq/9mPVqRKfARPz8/ZOcbiS4ymT8+s=;
        b=doz7o2Gx4PtUwUoD6tVeWgOhl6F4CQ1gIsNWFIIredy1w+/0XUKZLil35uRGtFSCts
         kh0pMdEAJuzwlHgMIZNG8F1saqJuqL6XvH1v7QAeMBtDSCeVG9lRUUPPIaIOQiiMyrcy
         Ub3wls8q5yCJ0VQVgCCHLNEy3sUFWPMaTjFUi8+9pS2F2dHGWkV86z4hPWaz/Sele6b3
         U4SyxhM44MEGosTNpfAw+6Qf5N+pnXOqYlD6UaiMjs6R6by2V+Qd4+cYtA3FPB9iHKFh
         ctJlF+u+9Xc4cWT8+yyg9rHTIIFL72BRMh9GexXRJmXLf8COM6RQPaqEHx7qQZgHioa9
         ZHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dQ16zpkiKKpGEq/9mPVqRKfARPz8/ZOcbiS4ymT8+s=;
        b=L36bHELz6u59jNMr474TWRXy6ra5XS+6Ce7XzpjbNmv3dhbEGh31uKEFoz6ci9pnY8
         Wt1vbt7aOnoo1ZkfnE+4edKeenYuX+ePB9vUb72gRjbFbcvAhn3+nBjtHDwQIEs9+knk
         JxMADhkP2ijQxFKdhGechX1uGfDWxiDUpYtVWa7kTBAlBSnfg2qAdyMmUKtYt4L5lo0c
         YMydrbVyoMjyUP9P8fu/BtrdrAIRBpLH2OECQ59E+XPkFBwd77b5NWNjbEcnEAVnyoMJ
         MxuQZxU65xPfNfnU4biGE5lh9sttGN3yy2aLkHKwRNWupE0N640KO/l8+vghzaKWj7+J
         oSpw==
X-Gm-Message-State: AOAM531XgUbrHsYl6nk1U+3+4OYoHjNanv3ze8SSPruiPn9TGPIaVAy/
        imi42r/hNyGm2qHT2k/EYHg=
X-Google-Smtp-Source: ABdhPJyrVEG0Yc8yCmSh5oYd6vuH3M29AK4d6hGsxBA1QbEs8YdzFYGwZzNCOY+lwE2siYT5Lbj/Zg==
X-Received: by 2002:a17:90a:193:: with SMTP id 19mr10020163pjc.45.1608402624645;
        Sat, 19 Dec 2020 10:30:24 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id l197sm12318471pfd.97.2020.12.19.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 10:30:24 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs python3 7/7] st_flex: testFlexLayoutStatsSmall needed loving to pass python3
Date:   Sat, 19 Dec 2020 10:29:48 -0800
Message-Id: <20201219182948.83000-8-loghyr@hammerspace.com>
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
 nfs4.1/server41tests/st_flex.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 2b1820c..169db69 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -8,7 +8,7 @@ from xdrdef.nfs4_pack import NFS4Packer as FlexPacker, \
     NFS4Unpacker as FlexUnpacker
 from nfs4lib import FancyNFS4Packer, get_nfstime
 
-current_stateid = stateid4(1, '\0' * 12)
+current_stateid = stateid4(1, b'\0' * 12)
 
 empty_fflr = ff_layoutreturn4([], [])
 
@@ -347,8 +347,8 @@ def testFlexLayoutStatsSmall(t, env):
     sess = env.c1.new_pnfs_client_session(env.testname(t))
 
     for i in range(len(lats)):
-        open_op = open_create_file_op(sess, env.testname(t) + str(i), open_create=OPEN4_CREATE)
-        res = sess.compound( open_op +
+        open_op = open_create_file_op(sess, b'%s_%i' % (env.testname(t), i), open_create=OPEN4_CREATE)
+        res = sess.compound(open_op +
                [op.layoutget(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_RW,
                             0, NFS4_MAXFILELEN, 4196, current_stateid, 0xffff)])
         check(res, NFS4_OK)
-- 
2.26.2

