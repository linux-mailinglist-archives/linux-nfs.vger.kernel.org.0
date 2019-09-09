Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E09FADAA8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405095AbfIIODQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35920 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405066AbfIIODQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:16 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so28946968iof.3
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/GVnqkPBoCv5U4dJF5GCvANtn9QnHDChOd9TrjN6yM=;
        b=o2GOblOSk1Y78G1BrTTKOyzalgknADGSw57v4DYIEA8vNp70AifPW/YRrHJjDWPRPf
         8nCOZchMFuNViaT9U0+Y7Vws3SXdTDHZ5uxf8wsFq6jzn71ecNOv7TCkotxbndJDuPvq
         BGD0fn0o+7I//JVLC1Mv4EyAeC1dumnXlf3H9FW6YA+AyrhdOpu5O8a5kuFvnx5osi36
         rYPhbI6HisEG6hYY3uKxMCif1CsCWK0uyQeWIi4mEhxrw/C1Z4XehjOXNbzuHsR93n96
         zwWecVFbBH9foN5BWPUtXBbRi4Nya9V9hQAw5/FoCCZYQSGXWwP0ISc8DteryIeKo0OT
         t6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/GVnqkPBoCv5U4dJF5GCvANtn9QnHDChOd9TrjN6yM=;
        b=BQCp/0vXOxnrLjc42qSPVqCHLl/jT+PcYWUi9KexsBMsTSwb+MsIeWQ+xdulhxvFsO
         HFjXcGTDMrNtv8dcf1N/f1Bmxh0wVL3SLa5AIAg2dEKsjl1RjFzdGWulFRQ73OXbSPwR
         BI/fUBvsdZRHZmkGZ8ad9OWXcw1faryfPKo4GNd068XK39BfzXN7Ca/UEZO/PG7LW0IA
         rzW9Wm4zpfcW+FDaMTvLaSlSLoTHx909sT+yDvx3g/Brq3abSVHCo/BXNNkM2A/MCm/w
         NvOqGOqQFUHIUMdvmcnHGYjjs6nvExFgHeKxiNop8LOqj1hIwKk7m+fTKuut6F7EMSpo
         Ekrg==
X-Gm-Message-State: APjAAAUUGAOTlmpyg2wIM/7ednaM4OQwUJ+l+TwY3NN57AMQcR/OwKCM
        tgq8/IYYWYXgOL7o5BSv3yatxUx8PQ==
X-Google-Smtp-Source: APXvYqwU2ET+GKCKO0unOKplNixBph9+7uTiYhCDnUmo1ES1f/no4dz4CubloJ/4egLVFXJiDHtO7Q==
X-Received: by 2002:a5d:8cc1:: with SMTP id k1mr16154920iot.286.1568037795100;
        Mon, 09 Sep 2019 07:03:15 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:14 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/9] NFSv4: Handle NFS4ERR_DELAY correctly in return-on-close
Date:   Mon,  9 Sep 2019 10:00:58 -0400
Message-Id: <20190909140104.78818-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909140104.78818-2-trond.myklebust@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server sends a NFS4ERR_DELAY, then allow the caller to retry.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 8769422a12f5..6436047dc999 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1455,6 +1455,10 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
 	case 0:
 		retval = 0;
 		break;
+	case -NFS4ERR_DELAY:
+		/* Let the caller handle the retry */
+		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
+		return 0;
 	case -NFS4ERR_OLD_STATEID:
 		if (!nfs4_layoutreturn_refresh_stateid(&arg->stateid,
 					&arg->range, inode))
-- 
2.21.0

