Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865F8451719
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 23:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348589AbhKOWFI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 17:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351086AbhKOWCA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 17:02:00 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1ADC03AA2D
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 13:30:43 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id m11so18200718ilh.5
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 13:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l84Rs68JQeLKs9TT54ykzpVM8QxmBN1kB7NDp2tzAHE=;
        b=nF5Pz1uxbfy27JxS3WThkloo9MXRr+tXfgvZdZgfoBbtG/tCPhqMndz7rPygCHxhWy
         2juqyis3yGiE4owawkDR5ir+KYehK0ZIRbSfWP/Gx+34RLWmOVj1/GrlEpRicMIftibI
         r0D6H3nDG59NNfjOt9cELQXazSOB3yBZKQIKDdv6XgmF/yeUIbk7xNcSx4JBgpcJiFxB
         +4uuxa44spq15rr1Orv/G3QeRnEZWCBzd3lhkx1whIR5fV9mRQUkkQYH3NMaBAFecyXZ
         5Q1FTWoKZPZEgydEsttVAMEU7fbi1k1/HQcCqEVFnwV/2AMLrzYvbBy6HLmYylbTs2zg
         vCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l84Rs68JQeLKs9TT54ykzpVM8QxmBN1kB7NDp2tzAHE=;
        b=K9NVeFDqUjbPYGIZSpIiBEo+w/itTU5dgz2fI8MaZnqZAaUtMC3wNKH3rHDufUbKx6
         R21D6j/uTbmsC829b+sg6V8ISWWF3QrIvOc76Yj2oQAnzvp+oTzculAvfKHFHInliN/t
         XBt3E0Q7et9z0nZJi7zEeKjtKukUs8tAOVUTsczkujiit197C3WtkHpVPvcTyU2JNnzJ
         Vm4+ZZANm4UlfXW12qSiByJ8sNrH+sTHQmmePDoad6jxDzYEWZY5ZVsg51/pfuwYPhMi
         eGYSyJ9/zjROYRC7p+0ZVNXgwCRUf5HgytAJ9Zd/4D+RYxdFsruUcEcDhv9lNcyNiBWQ
         Kaow==
X-Gm-Message-State: AOAM530r1JILs/QFSYSHRrUMM18VRdlLFFqMv4tD8yWicKN4BQwglAWs
        9dVRAH1b9Cw/9iGlwjleRRqFx6KH28Unmg==
X-Google-Smtp-Source: ABdhPJwzroV7Ggjm2BXPtlA7DSuq20vuC/byU2hCw8N5gkmh6MG25GuBaPsC1qOaXVR6/3ELcAT4ag==
X-Received: by 2002:a05:6e02:174e:: with SMTP id y14mr1289985ill.89.1637011843057;
        Mon, 15 Nov 2021 13:30:43 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:e1ee:4f50:6204:ea99])
        by smtp.gmail.com with ESMTPSA id q13sm11566676ilo.25.2021.11.15.13.30.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 13:30:42 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4.1: handle NFS4ERR_NOSPC by CREATE_SESSION
Date:   Mon, 15 Nov 2021 16:30:40 -0500
Message-Id: <20211115213040.337-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When the client receives ERR_NOSPC on reply to CREATE_SESSION
it leads to a client hanging in nfs_wait_client_init_complete().
Instead, complete and fail the client initiation with an EIO
error which allows for the mount command to fail instead of
hanging.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index ecc4594299d6..f63dfa01001c 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1998,6 +1998,10 @@ static int nfs4_handle_reclaim_lease_error(struct nfs_client *clp, int status)
 		dprintk("%s: exit with error %d for server %s\n",
 				__func__, -EPROTONOSUPPORT, clp->cl_hostname);
 		return -EPROTONOSUPPORT;
+	case -ENOSPC:
+		if (clp->cl_cons_state == NFS_CS_SESSION_INITING)
+			nfs_mark_client_ready(clp, -EIO);
+		return -EIO;
 	case -NFS4ERR_NOT_SAME: /* FixMe: implement recovery
 				 * in nfs4_exchange_id */
 	default:
-- 
2.27.0

