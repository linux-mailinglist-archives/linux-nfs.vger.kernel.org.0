Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C871214A6B7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 16:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgA0PAc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 10:00:32 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:47017 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgA0PAc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 10:00:32 -0500
Received: by mail-yw1-f67.google.com with SMTP id u139so4808469ywf.13
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2020 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+aiyqaA0x50RdWGHHvSb0M06M3Y7o7aVgQoJMBsV4M=;
        b=RzVkpexwhvFSmVeI17bQ0B5EZSIwQTVRv6B9t1duuEKjaTnKhoRb8gMfS4NftyLKTc
         zvezK4CQHxV5O2+TsoZrJXoZ06ZIJUfyXtzt6tjrGW8AoMmid8i/KMOoJrbK/O1/EewL
         LXay+U/O3R88h/qu5eAD69pkKU6hTDQkC+jo7EI+u/KnSqXOwJF9raf+JxF/En9pa3MY
         rgIKYMEQOWmDFfX1z7KSdmZvDOzZsNDiJBw7slwwHz5WqrQeZCVyRO7skGifBWnzbZHF
         7kEQvk9SDJx/Pxp0kKY/sj0SM/AcESYGk3hOV3I1JZuuj8e++lrSTXzOASd3u50SdDTG
         snsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+aiyqaA0x50RdWGHHvSb0M06M3Y7o7aVgQoJMBsV4M=;
        b=JBdduJ7Z9Vbq4btnHVFEVuivVUMQHm11LEhBt+se6PMdlRJ2sCOYU9SDMwsem1VbPt
         i3VUx8ZSoK3u0FpsaLdKqeSdf8hrq/jh/UCombks7GnCh6G5Pe7BHpzNNmFYk7hMkDjA
         ViS+haPB8A5z2WF7JEJ7DkYG3cpPcL3NvUNjMUTzJBa3cM2hLfAsodlUCqj94y/XimQE
         jrXIKw9rIE1CndyG+xZ/n4ZV9/VNx/tI2NDS9/LmNNe3AU/VytvhAns402MbeqjCFtHF
         X18vGodhg/VyTiiogkeWEeUDKdK2A8Me44bue14u6zXxYVx2J9PrSMshCzCekbTlYEd+
         fXMA==
X-Gm-Message-State: APjAAAXU77vCfZ0bO8YiilHCcGgLVbjU2cRJHVE2A3D4AC/YSeHNHzRN
        uOB33y882jJJ2PJr5BwepJeD3BFA4g==
X-Google-Smtp-Source: APXvYqyS7XDRqBeZT/lx5BHoghokKsWSbL1oTsUbsRrKphf+rK+ipKzz2viqBCo8Exx1I8UYCdV37A==
X-Received: by 2002:a0d:f2c2:: with SMTP id b185mr1430099ywf.380.1580137230755;
        Mon, 27 Jan 2020 07:00:30 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d186sm6809096ywe.0.2020.01.27.07.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:00:30 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] NFS: Clear NFS_DELEGATION_RETURN_IF_CLOSED when the delegation is returned
Date:   Mon, 27 Jan 2020 09:58:16 -0500
Message-Id: <20200127145819.350982-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127145819.350982-2-trond.myklebust@hammerspace.com>
References: <20200127145819.350982-1-trond.myklebust@hammerspace.com>
 <20200127145819.350982-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a delegation is marked as needing to be returned when the file is
closed, then don't clear that marking until we're ready to return
it.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index a7e42725c3b1..b5b14618b73e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -479,7 +479,7 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
-	if (test_and_clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags) && !ret) {
+	else if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
 		struct inode *inode;
 
 		spin_lock(&delegation->lock);
@@ -488,6 +488,8 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 			ret = true;
 		spin_unlock(&delegation->lock);
 	}
+	if (ret)
+		clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
 	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
 		ret = false;
-- 
2.24.1

