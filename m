Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615C4E2739
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404444AbfJWX6Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:16 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33808 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404433AbfJWX6Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:16 -0400
Received: by mail-il1-f196.google.com with SMTP id a13so6303580ilp.1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+EtWcd+iPMrQx+J+zI9H8qCQS/FT6dcSSPMKFDxnKyI=;
        b=VXBBrlAMC9fgI8ECLKrNfrjC6R+sEeQaU3aSNkuRkWCj+2nQTzvSYZmTG+7xPjU63B
         2Gmf3mC77y9xKmTXRcSVbDSbX4/iEFODCaX6+sBl4F4IhWjR53rtRaRMDwCxTf0t5TYy
         yaXzpGY8FGOrtJut1Tb9PkCZZkoiXl0j+MGgyZJsqTnVm8TUgdITFqxsZ8wWWx4ixDSn
         A8AtlXhqe/A3pDaNfvTqo/62a/gDFt99wZASILoC1tbEOvTTR7Z/mTX5xGOFbH8aPVte
         BcolLa1eELvMV/xdH2hPORDgErOq9mqmoOJAA/Kmi7/VcGMZbkS/lUnrunX+K2PHVmbZ
         xRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EtWcd+iPMrQx+J+zI9H8qCQS/FT6dcSSPMKFDxnKyI=;
        b=WI8lOQGSFqLpcks7eXsFBL6dTlvCSX9RV6zg5VNV9Rk6U2vHrZPzlSeKQ4z12UWaTI
         tvrJ+wE/v4l3S5clSpYeEl9cFnJJWv5K3u8neCJ2IeHqpDCnKaR0kaWPtcb/aBplgv/7
         EtuWkr1zFVOEylNqhYzJVaSdmbqWQKQrPDBxpTM1DMIsU474XkZb0HkSYdB4XnNDzMwQ
         yQpIvuyyj6LT8V5I7XVII+UPHCo8NGQJgO+KXg77mWNd7AGEFAPifC7eOhMrAfK65OQr
         VLEV4UZ0kMSZ37/U79TfaBrTk0gcqswrwMXro3tqT6fIa8Uou7lasSzs2+BR6dlWqE6L
         qTjw==
X-Gm-Message-State: APjAAAVvfWxI2dYXKUQfnPZzOupZUMeBqc1zNHei80mr1W+ttdmnExWA
        kT3DpHaqPLfe4jlCPmDhbHFazAI=
X-Google-Smtp-Source: APXvYqzn6JLx+Wc9y6XXu8ELvEeNY4b16AaMUAdnjyVGFPiNjvEtpI0NzSothPm2X7oQiydB05ELbw==
X-Received: by 2002:a92:4144:: with SMTP id o65mr37498482ila.222.1571875094804;
        Wed, 23 Oct 2019 16:58:14 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:14 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/14] NFSv4: Don't remove the delegation from the super_list more than once
Date:   Wed, 23 Oct 2019 19:55:53 -0400
Message-Id: <20191023235600.10880-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-7-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <20191023235600.10880-2-trond.myklebust@hammerspace.com>
 <20191023235600.10880-3-trond.myklebust@hammerspace.com>
 <20191023235600.10880-4-trond.myklebust@hammerspace.com>
 <20191023235600.10880-5-trond.myklebust@hammerspace.com>
 <20191023235600.10880-6-trond.myklebust@hammerspace.com>
 <20191023235600.10880-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a check to ensure that we haven't already removed the delegation
from the inode after we take all the relevant locks.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index e60737be6f26..b49faf1b3d91 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -287,6 +287,10 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		return NULL;
 
 	spin_lock(&delegation->lock);
+	if (!delegation->inode) {
+		spin_unlock(&delegation->lock);
+		return NULL;
+	}
 	set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 	list_del_rcu(&delegation->super_list);
 	delegation->inode = NULL;
-- 
2.21.0

