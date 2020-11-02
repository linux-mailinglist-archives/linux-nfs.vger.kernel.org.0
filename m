Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7937C2A2FB9
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 17:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgKBQY7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 11:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgKBQYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 11:24:55 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2A2C0617A6;
        Mon,  2 Nov 2020 08:24:55 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id o129so11548524pfb.1;
        Mon, 02 Nov 2020 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/OZ8HTZ7OhKXvD7+u0886Hzbgg8nYkTvZEoAZO/9hE=;
        b=Th9lyTDK1FnMIa6sXygE30/GZFlqBziQAnhCPoDJ7wZv0q1G7Flj0yTRhY2NuxExgM
         v93a3jhDELYrN++eD55Vi5VTvQv/XEFFVcBxUXjLS4fn1Fari4vygY0crRqECJK+eTmy
         akLWU/Y77lSfXqbwTSqpDDzXw9BU5RIPUpeIqI4jCQ/IC6oUSaZ4fxfMdPraj4Ex/Lh4
         fJ8MX2COPRWVYgv3iwQCcTGj/Ay4iP+n9WYKWEOjomdz2f9ZOYD6EpudJJBIHZHv0RtY
         gZFCxv902bmM35r+fEL5z3PE5gUDy62IkBlHFCLZRN752sOtuSZDOQtVVpedQyO3/at3
         OR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/OZ8HTZ7OhKXvD7+u0886Hzbgg8nYkTvZEoAZO/9hE=;
        b=odgVu8XjLc3kdDRW+Ayssqv5Dk+4SXfgk3o6qIWGs7mPIWXfikvqbbjd0ng1W70wVT
         yHJll3M+FK3Lxwr0pj7acWb58tK/yvGzsqlQdS42KfOCqWHVjn2NIoqZALkIT8++sYJO
         BGJHfWSDV4+8R3V7f13nOfMGqdhntgzs5jYhp1G4cTCtIM3uKnJTaWkPMJfooA5P1YJn
         sqj7b2CES7CpwJZfF2tngdif4tY9Y8AyykhHw3H/4X+1vMqlst4e/Lj3qWbz5VhI9sLF
         vaH5dKzqwJLo1UY4wp1bvQXIzxHJBMcSBQ8l3RUKKStWy6LPOLTqk1BAHKIZO+0Q3pIc
         iQlw==
X-Gm-Message-State: AOAM530DE7Wea2twKhvAayoJtomdepSDZjjP1e77Z9KKnLnIRpli7hBL
        WIW+GSnCBpzGDfJX6TyBRyM=
X-Google-Smtp-Source: ABdhPJxgrk43v5H1bMEkCwTxLoq6l/p2ICSc6SsTxCqt4fWaW2f0yGVO/f72gldWyUDk8bHxjWn9Ww==
X-Received: by 2002:a17:90a:588d:: with SMTP id j13mr17600158pji.236.1604334294719;
        Mon, 02 Nov 2020 08:24:54 -0800 (PST)
Received: from opensuse.lan (173.28.92.34.bc.googleusercontent.com. [34.92.28.173])
        by smtp.googlemail.com with ESMTPSA id b29sm8379575pff.194.2020.11.02.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:24:54 -0800 (PST)
From:   Wenle Chen <solomonchenclever@gmail.com>
X-Google-Original-From: Wenle Chen <chenwenle@huawei.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenwenle@huawei.com, solachenclever@hotmail.com,
        nixiaoming@huawei.com, solachenclever@gmail.com
Subject: [PATCH 2/2] NFS: Limit the number of retries
Date:   Tue,  3 Nov 2020 00:24:38 +0800
Message-Id: <20201102162438.14034-3-chenwenle@huawei.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102162438.14034-1-chenwenle@huawei.com>
References: <20201102162438.14034-1-chenwenle@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

  We can't wait forever, even if the state
is always delayed.

Signed-off-by: Wenle Chen <chenwenle@huawei.com>
---
 fs/nfs/nfs4proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f6b5dc792b33..bb2316bf13f6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7390,15 +7390,17 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
 	int err;
+	int retry = 3;
 
 	err = nfs4_set_lock_state(state, fl);
 	if (err != 0)
 		return err;
 	do {
 		err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
-		if (err != -NFS4ERR_DELAY)
+		if (err != -NFS4ERR_DELAY || retry == 0)
 			break;
 		ssleep(1);
+		--retry;
 	} while (1);
 	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
-- 
2.29.1

