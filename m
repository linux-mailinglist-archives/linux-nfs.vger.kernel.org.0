Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA014FFE2
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2020 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgBBW7T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 17:59:19 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44858 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBBW7T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Feb 2020 17:59:19 -0500
Received: by mail-yw1-f65.google.com with SMTP id t141so11938206ywc.11
        for <linux-nfs@vger.kernel.org>; Sun, 02 Feb 2020 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zl75aPTk5GQwwI1uRlWeXrMVCwJuDdcVhpEeIXvEHyU=;
        b=FdhKsqv08yy81iscVOJBiBlR9GJXdbpxSE6Cnej8rCnQLnD6LwLGGHPmM6g+mQHU0/
         tAgScBiYqTM6doWoVOz84hdHU8JFnsmkX7OL7sRZZB+ub8PdU15vnBiWEB0GmmrkxKRs
         IZ3baN0KNXyWOWlTTuqiU+KmiBbdq+05AyB3SOaN6gVJ+tgzSbBEdjOt/nV21rGzlAO2
         0fntBxdESBtfi3zccNgoSK1+dzBOW4jEPuVKt3Htj5UZUmKHr/4lKByCKS+N1izSh2rQ
         4I31rYML/sSBbNatvtNpd2W28UwEToyjCm0KOvLWCDytrQg1hn7D16g+N9ILQXlutPLx
         XVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zl75aPTk5GQwwI1uRlWeXrMVCwJuDdcVhpEeIXvEHyU=;
        b=tp8mJD5MbE7o8HUfDUeRXTSWGj0eqTuKwxKG9NLZOJ7Q/5VDj7mxeB7dKexzllYeFy
         Aa0b6krCzeJuVNbwRZEqeqbXg53zvSF2j920cd6lcrgUlJjDRmMc3zJDI26N5RqQc8mh
         AMqQTyY9ZL3SNyOri8f57LC/y/zoVPKP2L6guR57ihv0H9a+MxdjWCrBQ64JyY4VfrGn
         Ym42YCCWQcP/i/lhmnphkDqYH8Ovvg4T18fZrYDHMgHVazLcViBCUnYdV9RFidu70B55
         vPB48Xuu9rC8Kl5dquwBwwJ/bEHyJf1bsg4EmES9I5+XoxIIUSMLuC4Y7Ahpel3AVeVy
         mMPA==
X-Gm-Message-State: APjAAAVyMQIc/fAiyf8Rm88mq6JO+uU3OVj7vmjlyPzQrJGHVn2iAvvJ
        JFf4hWUOBG8e4Q8qdbNsrg==
X-Google-Smtp-Source: APXvYqx95AycASY4cDaHVlPeqA2YX9uhSfWi2dbBFTwISSG7Tfa2OFqsKB9N2K7DxCkE7jTpOkJ87w==
X-Received: by 2002:a25:420c:: with SMTP id p12mr18557519yba.86.1580684358510;
        Sun, 02 Feb 2020 14:59:18 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j11sm7532238ywg.37.2020.02.02.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:59:18 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: Use kmemdup_nul() in rpc_parse_scope_id()
Date:   Sun,  2 Feb 2020 17:57:08 -0500
Message-Id: <20200202225708.995271-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202225708.995271-1-trond.myklebust@hammerspace.com>
References: <20200202225708.995271-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Using kmemdup_nul() is more efficient when the length is known.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index d024af4be85e..8b4d72b1a066 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -175,7 +175,7 @@ static int rpc_parse_scope_id(struct net *net, const char *buf,
 		return 0;
 
 	len = (buf + buflen) - delim - 1;
-	p = kstrndup(delim + 1, len, GFP_KERNEL);
+	p = kmemdup_nul(delim + 1, len, GFP_KERNEL);
 	if (p) {
 		u32 scope_id = 0;
 		struct net_device *dev;
-- 
2.24.1

