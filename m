Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE19F9C63
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 22:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfKLVh2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 16:37:28 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41516 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLVh2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 16:37:28 -0500
Received: by mail-yb1-f196.google.com with SMTP id d95so88330ybi.8
        for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2019 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqZ1ZBIQi/il/57SR2kusbuMSAFBuhzO0FqXfCdeRoc=;
        b=emqh2628RguSADma4+1ijRw6d2ScsMUbSqU3qKynr2G6JdNI8A2UByFy1fElsgJKf7
         O8fbGu+zSstR9Ic4VfjQqLRwwN0GkGnV0V6v2eKH5YnbP1O+7MRpcK20WQwaYXqHXwAa
         dBZbT1FY7Cs8u6gHhfGsZkjxmbvOClXnHqM4zPLyBDj4XPuy75LH0F0ZFBu2+79oSaIT
         Jy0u+fOMbHPWe2nEVdXuu/Ah9VJa3Ikki3wG8SmZ50wuiysK2Eb4OlrNzWT9k+qblwlR
         h9TKL/JlC2LPSrq7bmfhNS8MBX9Etunzcv+lirSE6stZOYjrQXePqYzjHSYs9u7Aw98j
         351A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bqZ1ZBIQi/il/57SR2kusbuMSAFBuhzO0FqXfCdeRoc=;
        b=KEyBIUtv3Q4eSFqA4uh0uXoln35JtNNc2MEtkZAeSShPlZrOqM6qLaJETaUl9lkYPY
         uVBiDba6bp9UglS3KehbKIT+1z95LP4SEpsj7VmpgEXFELIvr0tqvBTggH3o/raAQjSo
         T9eDwHIoP9kpL4VC4jQwpM6Q2k3mKnR/sO2eWLvh5BhoeoK83K6eB89AIfoZBUdGa3vb
         MIh1IhFVhdeKnIzFMr60pR9YPFbuPlOzDFSKAdhDWsuAoY8+CfwaMIF3B/YmjOGHKk6E
         9nJ4EY4ir82jVXS+13s680y2e7U8Zp7kC0aCJxrtuExwh23MLR310UuOmjuKRJsiXBpu
         WHaA==
X-Gm-Message-State: APjAAAWLMq1aymbCVafUXThGBIx0lqa8wEr1A+tkRM8KnVjJkKa+WwiU
        MKvAXoTDvYAFK9x7DODtfT4=
X-Google-Smtp-Source: APXvYqyia7SoSRgBY+liV0wxiZt6pRy3H/yCpyljKScn1xE3UKPK8eict+2oZzipoPBnWMA926bOoQ==
X-Received: by 2002:a25:7105:: with SMTP id m5mr112484ybc.167.1573594647525;
        Tue, 12 Nov 2019 13:37:27 -0800 (PST)
Received: from localhost.localdomain (c-68-42-68-242.hsd1.mi.comcast.net. [68.42.68.242])
        by smtp.gmail.com with ESMTPSA id 137sm14233490ywu.84.2019.11.12.13.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:37:26 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 1/2] NFS: Fallocate should use the nfs4_fattr_bitmap
Date:   Tue, 12 Nov 2019 16:37:24 -0500
Message-Id: <20191112213725.414154-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Changing a sparse file could have an effect not only on the file size,
but also on the number of blocks used by the file in the underlying
filesystem. The server's cache_consistency_bitmap doesn't update the
SPACE_USED attribute, so let's switch to the nfs4_fattr_bitmap to catch
this update whenever we do an ALLOCATE or DEALLOCATE.

This patch fixes xfstests generic/568, which tests that fallocating an
unaligned range allocates all blocks touched by that range. Without this
patch, `stat` reports 0 bytes used immediately after the fallocate.
Adding a `sleep 5` to the test also catches the update, but it's better
to do so when we know something has changed.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index aab6b7b6a24a..0a9720880e81 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -49,7 +49,7 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 		.falloc_fh	= NFS_FH(inode),
 		.falloc_offset	= offset,
 		.falloc_length	= len,
-		.falloc_bitmask	= server->cache_consistency_bitmask,
+		.falloc_bitmask	= nfs4_fattr_bitmap,
 	};
 	struct nfs42_falloc_res res = {
 		.falloc_server	= server,
-- 
2.24.0

