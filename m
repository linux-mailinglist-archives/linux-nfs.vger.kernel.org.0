Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B3A4515E0
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 21:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhKOU5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 15:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350470AbhKOUXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 15:23:54 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2DC0432CD
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 12:18:38 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id k22so22910864iol.13
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 12:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=USnwtj38ydYfc31fxsFcNNDjom5QyQ0RUByrrLbjDIs=;
        b=aB50ZGOoAaPIvBqh+dXnjGnrzmeUcQQ3iSEHb3Ursnm4HKF22el9Z52nsyVmt5deBd
         1kcTyyQjpzMYvPRSAcN2Vkltlx1nlxaqxNsbLcPeG/gz3D3t58SNa3yEEO077JNUxofN
         C8XlG7/RkFqhYPAqvCAOICnEOcw50YamEeZkrO0+r+iRXed5K5vipKaLB6VnBboGI5To
         yhZ5Bd9uFLaINdBqDifOSRItLkxizJdKjQxdgUyOeojUScX50jVSY07wWsIVVMmnbQAr
         raHMdyUjJtfcCi6YoGnyHH0zrJZO5CUdmJa55xcSEnkGQ07h/NLh/L9CyihMwy9t7q35
         pe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=USnwtj38ydYfc31fxsFcNNDjom5QyQ0RUByrrLbjDIs=;
        b=NUtpJ3m0VKDLGGb8Y1DOabToNpMA7xYL16BfBGwGfF7rOvnCzJ9sLJyRCookqvsFPa
         11hfL6HnnvJC9x5JNrdCe1/l9EtCpixxGabmohrXAUHYvLhthhqs5xY9FLlZTaTezaGP
         wr5mlHN+6KK44tPlacsA+VYZwpkoISZnJYGaDvqJXFhKQqM9ZkkC2rTd0Oq+a0Jq6uPe
         rH/WKkqMDoRwSYo7jsASqouXJQX2plgS20P51TUnefze+2ofSGlecY1Y+SFDoWA3al32
         i6O9P4RgP6+s0hq0pxPH+Xbu77jQzliyAefiKxS/+wzYhEeT0NOC4fqqCEZtgi/Fl9VM
         R8Kg==
X-Gm-Message-State: AOAM530NA3BJ6T65GCdieQuzP3DincSvSA4rjZlDpCb66dblaRWyTgM5
        5vFP/ndTujWn/Eb0yBqSTu+WK0jNWZj0GA==
X-Google-Smtp-Source: ABdhPJw0f8PMLdFR+EVXE3O6vIvv0D7VGfRFEjRMgoJ5QbuAax5KU9RuNuyS3odp227HZA0tZO426w==
X-Received: by 2002:a05:6638:224d:: with SMTP id m13mr1155346jas.86.1637007516994;
        Mon, 15 Nov 2021 12:18:36 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:e1ee:4f50:6204:ea99])
        by smtp.gmail.com with ESMTPSA id h14sm9377955ils.75.2021.11.15.12.18.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 12:18:36 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: handle NFS4ERR_NOSPC by CREATE_SESSION
Date:   Mon, 15 Nov 2021 15:18:34 -0500
Message-Id: <20211115201834.98705-1-olga.kornievskaia@gmail.com>
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
index ecc4594299d6..50fa963665ba 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1998,6 +1998,10 @@ static int nfs4_handle_reclaim_lease_error(struct nfs_client *clp, int status)
 		dprintk("%s: exit with error %d for server %s\n",
 				__func__, -EPROTONOSUPPORT, clp->cl_hostname);
 		return -EPROTONOSUPPORT;
+	case -NFS4ERR_NOSPC:
+		if (clp->cl_cons_state == NFS_CS_SESSION_INITING)
+			nfs_mark_client_ready(clp, -EIO);
+		return -EIO;
 	case -NFS4ERR_NOT_SAME: /* FixMe: implement recovery
 				 * in nfs4_exchange_id */
 	default:
-- 
2.27.0

