Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44521317AA
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgAFSmw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:42:52 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40317 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSmv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:42:51 -0500
Received: by mail-yb1-f194.google.com with SMTP id a2so22482964ybr.7
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vonulXfr3czMCCV7WctXC4mLeKKqa+GGJ+EMXttiSE=;
        b=icoQlB+xq2Jia8PjloAxYIjpwSyg2TlssjHG/Z4lIBoV8qGxNEFD+yUu0XaCcfJF5S
         clwuZl8BSxo6FHvGfZ6vi1+WZe/1g/CNXWVOZQZBn5x/psA5rJkWBgBNHkhrvk2SKtSr
         awOYbSFrL3B2sORxEc0pvN8Xd1buycUBUpBS0NVwPWpVG3C60gnKyPLtP35B9MKsHZYy
         bBLfrW+WfdhKWVB129uWapnoEpyxV84JodgAZYPOcYELNMZAKWGsT/LXUTw2S90XkQyd
         13PZTY2Nem4/wzU4cVHCyKOw/QO9gBnFqHsgdKk0uDFJ6uH4G0We1jeJ58t0/7RifOZ7
         gOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vonulXfr3czMCCV7WctXC4mLeKKqa+GGJ+EMXttiSE=;
        b=m8g0fxjHGAJ6o7PlqQ9frafB0SyO/k1sbpKH4pLP7DQgK2QE2pXwkv3udTEWNoMe9a
         qfN5NO8shP9AhmBhEDzPWLl3p/aRaGRBB81PDmiN27SnX+0EFvHR5TnHU2/RRwdFXO8x
         1fGcqisYoIrQByN7WGyJ+xNOEvT97Qi3ih0AU+AGx3iJf+HPeV0vrjGjItNOy0f3vd0q
         5SAWs8L5wxtL65/R4o6TglTm/hIaSow5Zwuzb3dWKD/25pwjhr9yFCg99z4WYH/XxuaM
         9g8bhVVzyFqDTlwpOilT/LgcvM3SNGoMSvBookcebAWxboMebnl69KG+59YlJOVnDr8o
         1dZQ==
X-Gm-Message-State: APjAAAWDqOfAwfCpLxb4IBVwGmWYWcynFFYJYtr0Eru6hS4qYCea67c2
        i363eWlWfInPb4mxv0XZzm51uQrw5w==
X-Google-Smtp-Source: APXvYqzFZsqAPjg7AZvuGCBR7YLuj74KkhMj1cQYuhf2j0w/VQOn99AwUmB4YQMO7YQSYmmi7Bl2aw==
X-Received: by 2002:a25:6154:: with SMTP id v81mr42530434ybb.404.1578336170601;
        Mon, 06 Jan 2020 10:42:50 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm28223497ywf.101.2020.01.06.10.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:42:50 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/9] nfsd: Update the boot verifier on stable writes too.
Date:   Mon,  6 Jan 2020 13:40:31 -0500
Message-Id: <20200106184037.563557-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106184037.563557-3-trond.myklebust@hammerspace.com>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
 <20200106184037.563557-2-trond.myklebust@hammerspace.com>
 <20200106184037.563557-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We don't know if the error returned by the fsync() call is
exclusive to the data written by the stable write, so play it
safe.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 218b8293c633..38db4a083375 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -994,8 +994,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		host_err = vfs_iter_write(file, &iter, &pos, flags);
 		up_read(&nf->nf_rwsem);
 	}
-	if (host_err < 0)
+	if (host_err < 0) {
+		nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
+					 nfsd_net_id));
 		goto out_nfserr;
+	}
 	*cnt = host_err;
 	nfsdstats.io_write += *cnt;
 	fsnotify_modify(file);
-- 
2.24.1

