Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AC624C807
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 00:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHTWuZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 18:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgHTWuT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 18:50:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F822C061385
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 15:50:18 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g13so3887667ioo.9
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 15:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wIq0aiBm2gUbkQKSh/vqCnW4UqmdY9aQcMbBlcDFbVY=;
        b=PNgrkJB9vndc/FNQ/83/zhRqzbvkkor1QuU+UscIN6ooWmSmCy2LfML+WQNETXq8Ha
         D68Op11l89nh2L5K8kZmXRkev13SYbWSbyiFVZ5UEZI8nsfpz7ujRpBbc32Io3eXbQEP
         sC9succoYcj/eW7TP5QkV6uAlhY5gvHt3rBmRU3moLlhmJT+YmatdQtrCE5Vlfx1YO29
         xmYe8h0tMkbfO7ASDbhBjrhYfCMk7cXo+dj8yEfcN4zAUbUjW7tCVI5Yma+psW3kFz6f
         wQZBH26MOb3FYKRwy/CW3U+o++I28C48d1NseQB2dY1pUnXWBS5KkTZcwjltnfJedfnj
         AJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wIq0aiBm2gUbkQKSh/vqCnW4UqmdY9aQcMbBlcDFbVY=;
        b=tRWdWJ5xI2Q0cftcjgj9QJRcHw0WUu15y2ejpWTDAuAhGhh9fxwVnNyijFXELicO4F
         Gf2vweJZQpPySFbbS6upUa5Bl7eyFkFmqLKxT6DUgILOJ0HUiR0IwkczO/zgmvugUcHt
         J6rkTj6oS1i6gfAlw3X704KKbDxiNbKwk0lduuvFcGrSEgqxMyLxO9ZCnMMACKpClxYK
         aZteutT4g/OG0De2nZ30s2S/LL6SeydFqmCedSkxgQV4jStunXhZ582/sAI6+cPArpI+
         CnvR6g5tpAjio1JITGUf0plgWI/uWdv05PVyj0A9aPe3xb9n0nX8K/ijvwzmI6IxmxH9
         h8Dg==
X-Gm-Message-State: AOAM532EMSkypg+HeXHRWK9P7H8vnWduxALums6WJIWeIn0Z5vG+VCCT
        vIX1S7z8sfeSCZRdO9AkV8M=
X-Google-Smtp-Source: ABdhPJz9HpCHFmT9LtRfNfjg2t9aJLArc1RaXJqmLEpAH+4rbl6w+o58YroknN6Jmi4lHIBz2HNJZg==
X-Received: by 2002:a05:6602:cb:: with SMTP id z11mr125260ioe.96.1597963817965;
        Thu, 20 Aug 2020 15:50:17 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p18sm60472iog.1.2020.08.20.15.50.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 20 Aug 2020 15:50:17 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1 handle ERR_DELAY error reclaiming locking state on delegation recall
Date:   Thu, 20 Aug 2020 18:52:43 -0400
Message-Id: <20200820225243.24825-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

A client should be able to handle getting an ERR_DELAY error
while doing a LOCK call to reclaim state due to delegation being
recalled. This is a transient error that can happen due to server
moving its volumes and invalidating its file location cache and
upon reference to it during the LOCK call needing to do an
expensive lookup (leading to an ERR_DELAY error on a PUTFH).

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dbd01548335b..4a6cfb497103 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7298,7 +7298,12 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
 	err = nfs4_set_lock_state(state, fl);
 	if (err != 0)
 		return err;
-	err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
+	do {
+		err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
+		if (err != -NFS4ERR_DELAY)
+			break;
+		ssleep(1);
+	} while (err == -NFS4ERR_DELAY);
 	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
 
-- 
2.18.1

