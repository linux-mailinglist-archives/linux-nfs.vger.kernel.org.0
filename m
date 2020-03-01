Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED261750F4
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 00:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCAXZX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 18:25:23 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33271 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgCAXZW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 18:25:22 -0500
Received: by mail-yw1-f67.google.com with SMTP id j186so9530226ywe.0
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2020 15:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U14Uy4stoVVLCX7z3eAHr/J7no/Y5EZ7ZoEpafZVGbk=;
        b=RuZZD6G0ydqhvfQDgzlWyAL3zjtZ60VfWDcCOPMuuHw7jw14D2d2wA4zcUsUjNg2DR
         MMecdQW74NTkV0GaX7/FfNaw3tqFvFix1rNClaUlovL57pbtxH9BYLHiC35c3gTpArNU
         Fy6JCyvVe/GYrfWX0yNiuW6gHA+gSW+2e+En3gqQ7iyxPM6Bmzt6azjv0nHFD5lh5iy0
         nVX09fNLtKkMkvxg0fjELXh0y6bs3lDbf6lysTinIr0o9rTwsDlwAAQVd4JPPmX5EvMc
         WDYu251PGoxhYN//CI+LRa9fRfSzCKu8MhpErcbfisNfbqbeRQ2UIB4JnpctAvH8kiWP
         2otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U14Uy4stoVVLCX7z3eAHr/J7no/Y5EZ7ZoEpafZVGbk=;
        b=c/MFvCb6znjTpNX5TBm/aZhyhoP/rfSwCRorq9RUTUS9i830OlUxmOs+D8dxuE5UWB
         q9bqjyTeF+/fujOWFY6Yj+WRVVoFzrtyD9HKX9GKGJ3AQIDNwt6+R7fp0N/9XQbMz4fE
         AKSAH/JKn+uNbytP3rfesO02V7qtAyrhM5gPSCGItImXiNkp2Fms8OwQqE5rUpVeOal9
         dIm93Sbdctsgg5oV+TTmQ/HULi8VcAFdQNfaAKVrhRCQQVngfkt8n/C+AeyhZhmgsFnE
         m6W59+/0b7Jr3EJP6hV/P0hIgtRliq2S9+n0vY8vM8GliGEa7ChpFJMkbm/kWjJWS1EV
         /p3Q==
X-Gm-Message-State: APjAAAWF9cekg3oMwTuJxr894/ewlgsmFbS6/lgkmaWX0sJgiN7uiQGn
        z7T5QjzUmaMkDj3y3AY90w==
X-Google-Smtp-Source: APXvYqzGYnnf6TQShe/Q82d/fM3T8RYzOVDQb6SgJP6valb5CRt+NUN6GPw20aj45Vf5m+WCVCIKpA==
X-Received: by 2002:a25:8804:: with SMTP id c4mr14255517ybl.387.1583105121539;
        Sun, 01 Mar 2020 15:25:21 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm7167301ywu.26.2020.03.01.15.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:25:21 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/8] sunrpc: Drop the connection when the server drops a request
Date:   Sun,  1 Mar 2020 18:21:45 -0500
Message-Id: <20200301232145.1465430-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301232145.1465430-8-trond.myklebust@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-5-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-6-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-7-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a server wants to drop a request, then it should also drop the
connection, in order to let the client know.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/svc_xprt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index de3c077733a7..83a527e56c87 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -873,6 +873,13 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
+static void svc_drop_connection(struct svc_xprt *xprt)
+{
+	if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
+	    !test_and_set_bit(XPT_CLOSE, &xprt->xpt_flags))
+		svc_xprt_enqueue(xprt);
+}
+
 /*
  * Drop request
  */
@@ -880,6 +887,8 @@ void svc_drop(struct svc_rqst *rqstp)
 {
 	trace_svc_drop(rqstp);
 	dprintk("svc: xprt %p dropped request\n", rqstp->rq_xprt);
+	/* Close the connection when dropping a request */
+	svc_drop_connection(rqstp->rq_xprt);
 	svc_xprt_release(rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_drop);
@@ -1148,6 +1157,7 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
 	if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
 		spin_unlock(&xprt->xpt_lock);
 		dprintk("revisit canceled\n");
+		svc_drop_connection(xprt);
 		svc_xprt_put(xprt);
 		trace_svc_drop_deferred(dr);
 		kfree(dr);
-- 
2.24.1

