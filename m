Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45E82DF10D
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Dec 2020 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgLSSbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Dec 2020 13:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLSSbA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Dec 2020 13:31:00 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EFCC061285
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:20 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x126so3577405pfc.7
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExE51Jcf7SYoXjqHzJf9S1Nq1Cvr8IAyQypLu6wCUqE=;
        b=p1JeK01t6Pqfs9HsTB9W//j74en0NlnDIKQkeSKtoWwLFP9Tzfze5sKD/RZDlX6gWS
         Sv+w+5sQ7i9U71TT2EMVMpYa+qeW86RCTpyOjJw39Rc0m7zcL7sP8Vra4n2ljizWI+WA
         djNS8j33uTuKohXEe7z4ETquI1sbv05W/6rrto1V5/mgHVX/NhcoPSt/aJcY0yNCj4fE
         opJm2boYQSXHUrFpNtPNlMd7XISCsj5uLWpiowCx7aQcShoiQk9m4OAYBDkRx6irfu+2
         DWc+k9wMWfISEUFT/FDD3RUpQJmJjGnC1OHgHfgtewKF5LUDRw945oTBqggQnrBDeNHP
         21Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExE51Jcf7SYoXjqHzJf9S1Nq1Cvr8IAyQypLu6wCUqE=;
        b=T61sjVvusjW11HdA4DUKRaOFJu+aEadWZuvLNWMp4natM7DGnvXB0JpRlrRfU5qCYe
         MYoVm7ovh348obwnKTMmZDVz3YoMLZPJVMlpdCacljEkytunAX/Jr34Z5FuUofMwW1Oh
         LVw6sIkKutxnDa+ochhsL6A1JCYcc5L6lbUlO9DLzfTsRjk7640BFb9X+mvg9u87zEG2
         YshEb06sEkqJqMahQ0e8ctK5piU71W2GKlItENkEGLxcrJ8ygplNDH9Sc8NAFYtPuT+3
         lLyVWzBZEVSsrnjAxyTCPBJsZOPOqkDTBixNXnU7EkqqmcjfVGJ5P3Udi3PT2LaomqI8
         1PQA==
X-Gm-Message-State: AOAM532bAsdm3q/atACvP+QcqAgE+RdtWsxR1IkDfPlUNqvatHa8fUtM
        rycFNt4b+h3QZkYr5c1f+o2rLrp0pyz9Ig==
X-Google-Smtp-Source: ABdhPJz58F17WJvHwTJZo8cdBwNZcCXdtaoYodaT1l5y2DxXbnuH8V0ApbypaW0j2sRKFinSCvYk5A==
X-Received: by 2002:a62:1749:0:b029:19d:960c:1bb8 with SMTP id 70-20020a6217490000b029019d960c1bb8mr9429931pfx.63.1608402619600;
        Sat, 19 Dec 2020 10:30:19 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id l197sm12318471pfd.97.2020.12.19.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 10:30:19 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs python3 3/7] st_flex: Provide an empty ff_layoutreturn4 by default for LAYOUTRETURN
Date:   Sat, 19 Dec 2020 10:29:44 -0800
Message-Id: <20201219182948.83000-4-loghyr@hammerspace.com>
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
 nfs4.1/server41tests/st_flex.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 8150054..7036271 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -10,6 +10,11 @@ from nfs4lib import FancyNFS4Packer, get_nfstime
 
 current_stateid = stateid4(1, '\0' * 12)
 
+empty_fflr = ff_layoutreturn4([], [])
+
+empty_p = FlexPacker()
+empty_p.pack_ff_layoutreturn4(empty_fflr)
+
 def check_seqid(stateid, seqid):
     if stateid.seqid != seqid:
         fail("Expected stateid.seqid==%i, got %i" % (seqid, stateid.seqid))
@@ -103,10 +108,12 @@ def testFlexLayoutReturnFile(t, env):
     check(res)
     # Return layout
     layout_stateid = res.resarray[-1].logr_stateid
+
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, NFS4_MAXFILELEN, layout_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            layout_stateid, empty_p.get_buffer())))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -167,7 +174,8 @@ def testFlexLayoutOldSeqid(t, env):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            lo_stateid, empty_p.get_buffer())))]
     res = sess.compound(ops)
     check(res, NFS4ERR_OLD_STATEID, "LAYOUTRETURN with an old stateid")
     res = close_file(sess, fh, stateid=open_stateid)
@@ -203,7 +211,8 @@ def testFlexLayoutStress(t, env):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            lo_stateid, empty_p.get_buffer())))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -251,7 +260,8 @@ def testFlexGetDevInfo(t, env):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            lo_stateid, empty_p.get_buffer())))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -395,7 +405,8 @@ def testFlexLayoutStatsSmall(t, env):
         ops = [op.putfh(fh),
                op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                                layoutreturn4(LAYOUTRETURN4_FILE,
-                                             layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, p.get_buffer()))),
+                                             layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                                lo_stateid, p.get_buffer()))),
                op.close(0, open_stateid)]
         res = sess.compound(ops)
         check(res)
@@ -492,7 +503,8 @@ def _LayoutStats(t, env, stats):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            lo_stateid, empty_p.get_buffer())))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -615,7 +627,7 @@ def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
                op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                                layoutreturn4(LAYOUTRETURN4_FILE,
                                              layoutreturn_file4(0, NFS4_MAXFILELEN,
-                                                                layout_stateid, "")))]
+                                                                layout_stateid, empty_p.get_buffer())))]
     else:  # Return layout with error
         # Get device id
         locb = res.resarray[-1].logr_layout[0].lo_content.loc_body
-- 
2.26.2

