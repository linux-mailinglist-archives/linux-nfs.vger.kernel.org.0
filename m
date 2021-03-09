Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B373328C7
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCIOlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 09:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhCIOl3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 09:41:29 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E74C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Mar 2021 06:41:29 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n132so14171167iod.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+B2p5u0j+76gmz0/hHCBloP/5cSj761dDQNcbEU8iwY=;
        b=Ebb6cEZ8iCkwyDtQdpccETEaS4lms+l6thVuQXQ1C6bxULoQfPKdWioyKQ4YVcDHQV
         hYpYnyyOqHvDSu7yqHF9fF0pc1BBXpBA+wiMP50ZUu3wwsERhLLYTlTeOdkgSF4nn8uf
         y6LGTXF6MS6Wzch/GZYv1WVKL1nj1Mu4omCCZuCrbx4gTdMQzaddLtQ8bQFWSSDAeMsS
         gP109dbYbi74tH1xdjFMz0hs+9uVblmAaV0wRM9ZxO1uqm0/h88mwdBjySfMmuQKdGHI
         2B4XEgHsvWvdCh+UG0BKq/0TZ6wezc323I7yeqHGtigP5MNBuVXu4cLeBtdoewT3xob2
         /YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+B2p5u0j+76gmz0/hHCBloP/5cSj761dDQNcbEU8iwY=;
        b=fwvuPBUks18O5Av4z9okx5eS8mM6VS9QEwbepJgRe+uSqPYFY0vQy3phT32KEbNiXY
         06Wv+1a22vZreC9Fet9eLyscq7vrpjHSEtQ4nfbV5w6kbsMnaVNAlRSfoZI/gwmUY6Wk
         xYKOFcfQU6wqxCC82ZQoIEo4eFTOqEHgWjRJMdnlhAe7rBiar/37yiM+mViIaXQ7H/7I
         myJtBtCxdEa1NFasjfJzbW40TRbNQ+YcDFu7e1XYfHOrowTj2Ssf16TYqgm0K5Br8jC7
         XoFrAd0eEnA+fVr5ZOK5j9fWKUGzXuk2iFAdP7XFQIHhPbyBNTZCBBbKIG0uttD4cQ1I
         B63Q==
X-Gm-Message-State: AOAM533sCjOT/5+UQtSr2qem2lFqTknaqzAEYUEO+d1qwa1chQbt5Bo+
        0shkruDoMqETx3YEYUDk4fk=
X-Google-Smtp-Source: ABdhPJymya3K75/9vyWKspeDn2O6P2c8/NAh9ygmT9hP5Jo4uBqkQ7ILZbtvYHjHftiwzbdWKDdkNQ==
X-Received: by 2002:a05:6602:80d:: with SMTP id z13mr22371000iow.17.1615300888986;
        Tue, 09 Mar 2021 06:41:28 -0800 (PST)
Received: from kolga-mac-1.lan (50-124-244-195.alma.mi.frontiernet.net. [50.124.244.195])
        by smtp.gmail.com with ESMTPSA id w16sm7705020ilh.35.2021.03.09.06.41.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:41:28 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: fix error handling in callbacks
Date:   Tue,  9 Mar 2021 09:41:27 -0500
Message-Id: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When the server tries to do a callback and a client fails it due to
authentication problems, we need the server to set callback down
flag in RENEW so that client can recover.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 052be5bf9ef5..7325592b456e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		switch (task->tk_status) {
 		case -EIO:
 		case -ETIMEDOUT:
+		case -EACCES:
 			nfsd4_mark_cb_down(clp, task->tk_status);
 		}
 		break;
-- 
2.27.0

