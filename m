Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1725C34F167
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhC3TE2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Mar 2021 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhC3TEC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Mar 2021 15:04:02 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC208C061574
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 12:04:02 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t6so15034074ilp.11
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vBl+0XbudBfo05DumLylhXIZnJo4/VVvY21GjXlCxE=;
        b=HmOfu3n4+YchOy+Hn85JNmZh0xFIiPxVHMH1xSJv+3YC62lepCrRh298IdpSyfhxmZ
         3N/tYiiFqHGMazh+AXLO0B/znxmRnJtOLXpKNPQHD4DyuQIMPryJcxllyyGtCA/FLsKk
         mlhjgVth0PnMYxwIxnX2Mz/kawDx2VXCpP2nRpNr46DnoOgxiWbcFBKxfDuj1i5J8zDP
         zZzBQ4pJNc80zj1dCff41vja1KfN2vCpPvUhLOzW3UGkaG777WZCeHE+5EpF8355MuUm
         7cz/klFMdjjceo5DLv+hcGOOurmo23tiACCVHah2fq7uKeDhsfvQfxeBBtWxuT462n/J
         s3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vBl+0XbudBfo05DumLylhXIZnJo4/VVvY21GjXlCxE=;
        b=NCLYUsltbH9iNZ4BgkYsk7Matz6OmWSHBj8PBhZ3XsBHXbsoWO8CHjU6eKQfjQBatR
         ArH82UBwqC6mRAqFxjNuAJdTsZJaIDsmNC3hJ8JX+8DFjhfflimvJGemf6+BxX9xFsU4
         uXbmfNQEbmjGKJRoDH6Tbt0FEy0wfrhDb7OOUdktIXV/zo8Uv45wHvIF2iWPmdCQ3WBf
         TUF7754bUFDLEAXqHGwuHJEVxo9KAB/Lru0aNCMUjlVrRpKryZUJvaS/Nn2MYbz23Z3I
         5mHm1cig4Mr6e0WzJRli8aqs7Hdz5aDgbKZiYJ2qfSF/VYHl5jhCela4AyIqkMpsW2Nh
         yk5A==
X-Gm-Message-State: AOAM530BYQwzkMwyhxGqjQI/2l1Ckbsv8CFw+PXeP2oauEk1/OBJkfWs
        0hLQNCsCziv6JwCo3XpzN24=
X-Google-Smtp-Source: ABdhPJzO4NkgcwYPaf8aiQcebztHSQMHMSO2tMZMFJHIbSSPb6mLwZR2jaJ+s0vrjzpKB2yu8t2QUA==
X-Received: by 2002:a05:6e02:12cc:: with SMTP id i12mr27357153ilm.10.1617131042128;
        Tue, 30 Mar 2021 12:04:02 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:88e0:61ac:4ccc:3822])
        by smtp.gmail.com with ESMTPSA id u10sm11654839ill.30.2021.03.30.12.04.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 12:04:01 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: fix copy stateid copying for the async copy
Date:   Tue, 30 Mar 2021 15:03:59 -0400
Message-Id: <20210330190359.13057-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This patch fixes Dan Carpenter's report that the static checker
found a problem where memcpy() was copying into too small of a buffer.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: e0639dc5805a: "NFSD introduce async copy feature"
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index dd9f38d072dd..e13c4c81fb89 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1538,8 +1538,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!nfs4_init_copy_state(nn, copy))
 			goto out_err;
 		refcount_set(&async_copy->refcount, 1);
-		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid,
-			sizeof(copy->cp_stateid));
+		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.stid,
+			sizeof(copy->cp_res.cb_stateid));
 		dup_copy_fields(copy, async_copy);
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
-- 
2.18.2

