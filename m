Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B192DC9FD
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgLQAhE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQAhE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:37:04 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05813C06138C
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s21so17784234pfu.13
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHO5bIYwnL47DhNEYdQnRuELP368fNy4h91T61VHS2c=;
        b=VFXpb1wNkgPKiy4+K1TmZ+e+jsic1lfllqLvuFmxDb0YCygM/ehYqvxXDobJSMuQs4
         bjAjuelhNWNMV+RXKNAd2IcaUdbxajZHDefHCBf2SPnbvRzxMvYd3RPjcc2gdIuzMHYw
         PQav9EZ/GsASU6AUhqmWNahnukr0cTe/V9Yes9lmYc0KlWRv5lWA6lOFOUDHfuS8ZwPI
         HN55F/WEJ30PYdzDSxoX2RHYe57HJ8qXoU9pKPq914qQz+MmTDVuUSWs6LgKwiap5GJC
         EHSzHBjlZWTDS5Gw4ZQvy5gDWTvDg9bp2CEXYFQRHj8kx8f1JKdygSxGepeFhXC1Tk7Z
         ulnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHO5bIYwnL47DhNEYdQnRuELP368fNy4h91T61VHS2c=;
        b=SImTFNLrqn/2F9kAZVgO7hgdxII5J+C2PNIOEVPAFh2XBm2lQezWu8qNZ5a319cbsp
         DX+swuSs5zhw//HIQUd90YOI/g127Axrtgh4dt/OBDPnVHiCP37O8ejoiByr+D7evxcP
         AuLVRVai6N3RY8xA9w0k/IGL7bREU7E4lXMSh0jgr59jKWEBlqXVZzzGQR7imUISKTm2
         rPNTrTsCLUt//EvSEHICC8fLHs1r++7FcSH3NpTfdAWFRNYwe+XouOgvq/6xJex1F0SG
         fMmwFeMQwrCaylZ7SoVzEIRjYBG7D5qv7e0i4J+4zByjnm9vKmu7Ohh/vl8hnWyGmuVL
         ixpw==
X-Gm-Message-State: AOAM531SEd+NqLApx9panm/BvRpZJNT+m/69ImvEOrBKs2noGkeU99zv
        eZCZ8/Mi6XMux53Mtmn6DAY=
X-Google-Smtp-Source: ABdhPJx+0buMrjsdr0Pwfm/4B8fIKx7+EFCAw2HVdzU7TTnGEOV77pg9jFkxJLZjhkXJq/rmIlOyGA==
X-Received: by 2002:a63:f154:: with SMTP id o20mr34912766pgk.127.1608165349617;
        Wed, 16 Dec 2020 16:35:49 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:48 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 05/10] Fix testFlexLayoutOldSeqid
Date:   Wed, 16 Dec 2020 16:35:11 -0800
Message-Id: <20201217003516.75438-6-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217003516.75438-1-loghyr@hammerspace.com>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

LAYOUTRETURN should return NFS4ERR_OLD_STATEID when presented with an
older layout that wasn't recalled.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 nfs4.1/server41tests/st_flex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 4defa81..b46941e 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -169,7 +169,7 @@ def testFlexLayoutOldSeqid(t, env):
                            layoutreturn4(LAYOUTRETURN4_FILE,
                                          layoutreturn_file4(0, 0xffffffffffffffff, lo_stateid, "")))]
     res = sess.compound(ops)
-    check(res)
+    check(res, NFS4ERR_OLD_STATEID, "LAYOUTRETURN with an old stateid")
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
 
-- 
2.26.2

