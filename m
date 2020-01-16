Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DDD13F711
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 20:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbgAPTJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 14:09:11 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:45487 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437354AbgAPTJG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 14:09:06 -0500
Received: by mail-yb1-f180.google.com with SMTP id x191so1857280ybg.12
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2020 11:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ckkzP+yL9tj6yrjGxw9BY9p5/uItt5Rg4Vpd+3titek=;
        b=rCXoPHw7SHaPHOJVpH6ebRe43qVIKLkWUuskkJfziDGajwGjzjydKIG5csASwuxjiE
         x6yduGTzwVXE0YNop9DRl8pkl9g1QPhFCuayja6wC6xanMGuhGuL+hTVWfmdXbYxcUM4
         HgXEIAWD7l0uz7NHI0qKSao82xgRQcnMqnGIQ1su2Nk/XfrAPAqRnwClca0GGBOEYY6I
         1be3iBBTI9XKXukkT3dALSkh+VvwlStOWU+2p9fXsDt6M4hziJUrDalAS1o5ktKS/wg0
         Si11E/njHZesGikmKhnb9+6P9j8OUqmbnhFMvyOGl9bK1ECwVj5Bnlmdn8ONo56ATMKc
         PSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ckkzP+yL9tj6yrjGxw9BY9p5/uItt5Rg4Vpd+3titek=;
        b=HFgzm9PggCEIzxxqTei7lUkkT68fDKrGQM8aK6cGw3K9EETeMx7kyfNQHylvtjmbVu
         VdgiX9VpNHLxlxaR7R9pCQrnaj0C2uW7jSib1mClS+wgJYFqueHZS7pm72Yv3OQfUGJD
         3rk9xw7Gl3dxglLfkCmdLfF0HSb9gwDd882bWA0uHLY5/OHo6yaMP36FdC8k8m6QKuU6
         E/ZvdRgXTrOK4q01Pe2ECaN7XvqHnlz4jjEGhKOfAHgdBXsIQra6GfvRebF79Psrd6+K
         fcJdnR9fvIJnA9ILcAqvb0FBEdGI7/aoH4exwsO/rIu/mUAdHTItriAw5RYALEBiOpeB
         oI3w==
X-Gm-Message-State: APjAAAUdbXa7UX0izeVOSBA4tHoD9iGjJEPx3ShRFdENrs5p648k4Q/B
        OP2gxRVjhtwPYg4Qu4jL3aw=
X-Google-Smtp-Source: APXvYqywzw/Tc4R6UQ8gCFj8rcO0njUk7QoGEWZD+N5X+cs5kvj2O011ku8qPf97r8wpLIRLf8Se2Q==
X-Received: by 2002:a25:5889:: with SMTP id m131mr24370982ybb.89.1579201745577;
        Thu, 16 Jan 2020 11:09:05 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p206sm10295332ywg.94.2020.01.16.11.08.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 11:09:00 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Date:   Thu, 16 Jan 2020 14:08:57 -0500
Message-Id: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 460d625..4df3fb0 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -881,7 +881,7 @@ static int nfs4_set_client(struct nfs_server *server,
 
 	if (minorversion == 0)
 		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
-	else if (proto == XPRT_TRANSPORT_TCP)
+	if (proto == XPRT_TRANSPORT_TCP)
 		cl_init.nconnect = nconnect;
 
 	if (server->flags & NFS_MOUNT_NORESVPORT)
-- 
1.8.3.1

