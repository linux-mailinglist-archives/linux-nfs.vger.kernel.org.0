Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A312A2FB8
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 17:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgKBQYy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 11:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgKBQYw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 11:24:52 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4B7C0617A6;
        Mon,  2 Nov 2020 08:24:52 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r186so11235206pgr.0;
        Mon, 02 Nov 2020 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZBqQ4wCTpFo7JQ/+ZUdkertgFqpSFCteIYsSJlfASc=;
        b=rsZz/krFx0jK9y6bXMs3iWIGx8wex+Sn7NY5d283V9Rf2EYiEjrs0pou22IPGHWbR1
         618qd59AiNQh2F3ZocneQqEhu9Ru+zhmvig3PJM3v6YfrvMy6coywqr3yTN1S6tJz+B5
         1sqq7vXRvE1U6nDZmVgCbEYPB8wF3b/YjlwPcZxLKCzt+QnX1sO6v5xMOf/txGt4CLVC
         AXEPwTVS6eeNzoZs+ZCBz16h+y4QgG4ms8P/U/8paQ82bSbwAd+PxPdy/ZWGuZPiG3sz
         27TWa644SJJx6AgU1bUNsh+n9inh/OBBCNClEVIXvE/VYZN82trXVURngWJZIOdHbG4h
         0+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZBqQ4wCTpFo7JQ/+ZUdkertgFqpSFCteIYsSJlfASc=;
        b=qRSMy+GfKFcVL5kKsH/uUrSOW4fOHMbqWKRcCRhn11dKTY5XROh1+nQefZFOc/PyfJ
         Sr18ucfd7jgAwcsxEmUZaxgOrtDjNCXgJub3s7EpobIrieK2MgAh0TwiSTt5NLs2T8w/
         8t6SoStGVDlpbxcu4uad82cAx7VfL0W7+uK4yopC9drKP8RBCEHWI1skUCRSw8whY0VR
         U/KHBGHEGHRxhFgD6RJOKNAoAmCXS1D+mhOXVkHBwDU+fJwzFHdvmcUcrmrnh/AtCGy/
         snTcdLFkdM4zbavT9IPMSMcxN2KGOczMuP2yrtitOXtAZ+nXvqOqpmUhvAXOWEnY+VoT
         msXw==
X-Gm-Message-State: AOAM531bFF2vKGL2fQupo1abuLxPlXLvkQBrvSxaO+MFHcpI7GOz7/WG
        rA0wmbnFnvEtE/dWYcM+zrQ=
X-Google-Smtp-Source: ABdhPJw3OFfZGzCC6bbK6rTbkBKAFDn39btr/v3RYXaunJQd/g8dMiQizc5Erh3vgL0ueVT4cZJHQA==
X-Received: by 2002:a17:90b:17c7:: with SMTP id me7mr18575577pjb.127.1604334292212;
        Mon, 02 Nov 2020 08:24:52 -0800 (PST)
Received: from opensuse.lan (173.28.92.34.bc.googleusercontent.com. [34.92.28.173])
        by smtp.googlemail.com with ESMTPSA id b29sm8379575pff.194.2020.11.02.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:24:51 -0800 (PST)
From:   Wenle Chen <solomonchenclever@gmail.com>
X-Google-Original-From: Wenle Chen <chenwenle@huawei.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenwenle@huawei.com, solachenclever@hotmail.com,
        nixiaoming@huawei.com, solachenclever@gmail.com
Subject: [PATCH 1/2] NFS: Reduce redundant comparison
Date:   Tue,  3 Nov 2020 00:24:37 +0800
Message-Id: <20201102162438.14034-2-chenwenle@huawei.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102162438.14034-1-chenwenle@huawei.com>
References: <20201102162438.14034-1-chenwenle@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

  The err wouldn't be change after sleep. There is no need
to compare err and -NFS4ERR_DELAY

Signed-off-by: Wenle Chen <chenwenle@huawei.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..f6b5dc792b33 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7399,7 +7399,7 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
 		if (err != -NFS4ERR_DELAY)
 			break;
 		ssleep(1);
-	} while (err == -NFS4ERR_DELAY);
+	} while (1);
 	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
 
-- 
2.29.1

