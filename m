Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9962DF10B
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Dec 2020 19:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgLSSa6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Dec 2020 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLSSa5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Dec 2020 13:30:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68716C0617B0
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:17 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c79so3592841pfc.2
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvrYI53ARyLNi47g0r3LKgEekytDQ9rhf7H5l0uRxuE=;
        b=ejmtv9lSLpZjFCNpEe2h4SDXV6nzCEJnoqR4PCHRfMio13B36p4FOCespgD2L1MJHr
         M2BLuBkvAqBgRv7u9IkQop/p16XMCKn6xAPojzl1UMcfsb5KV4oNTFU7z6KawvFVDvyT
         6NZyegVP2cE9xm+MN1YgezJVMAInTxZ9p3wC+HinpgHA56VXQJA8jpCvSNk3m8nUuwZY
         gfly3g5zbGTswBFMSxP77wwlW0zwsgqsvahVcJHcbm+n4ZvLCg6NJMdPA6UxHJJRm+9J
         DoyufHKG8Jrdsux3TiKRvUJvn0VjssVL8//FDbCsp/vfepX43WpitfzfdNo45GH48+34
         gHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvrYI53ARyLNi47g0r3LKgEekytDQ9rhf7H5l0uRxuE=;
        b=dy+YbfEjvnZfs6j3y+mGXBzPKLbnmDV0Fm+F4QVB7ZQdfmUWKN+cJYz+5mQH77JR81
         Cnr2gc2LbJGmlbYDxbBXjMMcqDBwKX6cdWb4+BO6Tj2e4ViKoQC/SeHJov3JIKwcsCF7
         fsCYPKIbFHsanKW0QSOWTsjywEG15IE6MHIUxbTyw6iFF9SuJtQPZSEPj3LP3EQ+jcNn
         45gCBEDG+z3J0H4rt1V4W/yBmPspCe5fHOOgWsUnliGcHeC/P7yMP1Tq6BShFDJxfDmP
         LiRzhoMOaKUj4VEPki5FBkqF5o249mZ2XMlFQLd0dWkgSprvWkz16xSFJ14w2peSIn3h
         1dng==
X-Gm-Message-State: AOAM533RjU2FwRwaboPZ+F3nl5mX+LdWbpOEfp+a9Zlr+fM1ubZLcctc
        BzcBlAghei0oLPfrKae7PDU=
X-Google-Smtp-Source: ABdhPJw+KAXKaZkQRpAD9BYyBoJO2do5qIT5Nt+xLrGzqAI7wDvvNw9+bEgZezeqMpQuBsOR30lhAQ==
X-Received: by 2002:a65:47c7:: with SMTP id f7mr5093026pgs.305.1608402617024;
        Sat, 19 Dec 2020 10:30:17 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id l197sm12318471pfd.97.2020.12.19.10.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 10:30:16 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs python3 1/7] CB_LAYOUTRECALL: Make string a byte array
Date:   Sat, 19 Dec 2020 10:29:42 -0800
Message-Id: <20201219182948.83000-2-loghyr@hammerspace.com>
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
 nfs4.1/nfs4client.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f06d9c5..df573d6 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -296,7 +296,7 @@ class NFS4Client(rpc.Client, rpc.Server):
                       layoutreturn4(LAYOUTRETURN4_FILE,
                                     layoutreturn_file4(rclayout.lor_offset,
                                                        rclayout.lor_length, \
-                                                       rclayout.lor_stateid, "")))]
+                                                       rclayout.lor_stateid, b"")))]
             env.session.compound(ops)
         elif lo_recalltype not in [LAYOUTRECALL4_FSID, LAYOUTRECALL4_ALL]:
             res = NFS4ERR_NOTSUPP
-- 
2.26.2

