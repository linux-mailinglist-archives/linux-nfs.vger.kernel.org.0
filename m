Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D733F586D5
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2019 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfF0QRI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jun 2019 12:17:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43130 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfF0QRI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jun 2019 12:17:08 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so5972675ios.10
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2019 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I0D8I3xHA7c8rSHJEH5drJL5to1T2GvEuOBLpyALn3s=;
        b=dJR2M3/d3JW5wF5ncr9wMgrjNss+0XQshFaKyKAlZnDrAya155VzEHkyyY9v34TXrs
         LQGGNgAFFpQ8WeczS5Fd+IlRUj3LNOT3Fo1/bbomxIAzy6S+kK6Zjv1Ey54tZjHOQmyr
         CcJ6VE7KD3U3CsHGbEO53kC0VHrNqvaOVE31N7CSpBT8NMP0Kf9c6YbCZONL96Qks6MN
         tq1EooJLjQYnPiZVXpltzC95HMK0DABWh921ivnNb6159Fktbb+dWAOV2CloYd32/8Jz
         CDw21fE/Qagex846ZZ9IdKYcKjJwEyCvu/kWa/i+xLRzJBkPpUw733Hk01VCuQ8kS29K
         4YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0D8I3xHA7c8rSHJEH5drJL5to1T2GvEuOBLpyALn3s=;
        b=iBWxux4NdEftmqajrXVu+Kly15uMWQhQdJtKBQM9qmn1s8uz9Jtkz1WLfmHPD0qAHJ
         jenXXiW6JHbBWQVPzp+pfIAfcuPC9WOsVfyszkKxEtQ8pCCkM+9U9UxbORBW+m7doeWQ
         h+vYUYyXATknZs9RoOP8LztgfoSMa73lb34wUGNB/9jGBCAAXuwS5aQ+c6xdtM+UUN67
         lMVlaHNLOEiJ76TusP//zuDUnLmH/tqWyMTC2AKohrnaUwotJtuzML/pYImmNUt9ViIL
         AXQ8lESFxlC31JHM1AyM+F7hOmYMiTEJCwnTTqQes2hO9SWKXRgxHDFl6qKJKH6zwi74
         lQKg==
X-Gm-Message-State: APjAAAUEGzULnJadjRhg4/DpdjqKgVipCMm/0cvgsKjr87IknFes7z9c
        Prn/n8ERdFTyIIT5K3AXvces1IV/sg==
X-Google-Smtp-Source: APXvYqwWOXDozgobJIVbsZGGgsUoEMkXxmZxhM46O8XoA19lXGMS0TeCicIAQf5X7JhV0gU4XI5UXw==
X-Received: by 2002:a6b:7b09:: with SMTP id l9mr5711126iop.114.1561652226787;
        Thu, 27 Jun 2019 09:17:06 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j1sm1896886iop.14.2019.06.27.09.17.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 09:17:06 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Handle the special Linux file open access mode
Date:   Thu, 27 Jun 2019 12:14:58 -0400
Message-Id: <20190627161458.46784-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627161458.46784-1-trond.myklebust@hammerspace.com>
References: <20190627161458.46784-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

According to the open() manpage, Linux reserves the access mode 3
to mean "check for read and write permission on the file and return
a file descriptor that can't be used for reading or writing."

Currently, the NFSv4 code will ask the server to open the file,
and will use an incorrect share access mode of 0. Since it has
an incorrect share access mode, the client later forgets to send
a corresponding close, meaning it can leak stateids on the server.

Fixes: ce4ef7c0a8a05 ("NFS: Split out NFS v4 file operations")
Cc: stable@vger.kernel.org # 3.6+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c    | 1 +
 fs/nfs/nfs4file.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0b4a1a974411..53777813ca95 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1100,6 +1100,7 @@ int nfs_open(struct inode *inode, struct file *filp)
 	nfs_fscache_open_file(inode, filp);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nfs_open);
 
 /*
  * This function is called whenever some part of NFS notices that
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index cf42a8b939e3..3a507c42c1ca 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -49,7 +49,7 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 		return err;
 
 	if ((openflags & O_ACCMODE) == 3)
-		openflags--;
+		return nfs_open(inode, filp);
 
 	/* We can't create new files here */
 	openflags &= ~(O_CREAT|O_EXCL);
-- 
2.21.0

