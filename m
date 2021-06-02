Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA1399288
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhFBSa3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 14:30:29 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:38812 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSa3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 14:30:29 -0400
Received: by mail-qk1-f177.google.com with SMTP id q10so3369596qkc.5
        for <linux-nfs@vger.kernel.org>; Wed, 02 Jun 2021 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1/YAhXSiHnqFFYldu2ElK+ccazqY0NTe4Ixv5mzJSE=;
        b=MRBWQW4qaChtJrg6s2CL7NpQ72969e93mU80TExfjO0PrBGTSkgK8KaT0w+riPSJCv
         BcPLUVdw7T2d6EDcEyyhElHG4EaNi+d6J1+eNxPCoXQ67ct5fWYYMdNIRhkeZ/tJIb66
         Y+i4cw+MV68q1mpppQIZPMMqRoVhFHe5lBdKVVYUIGT9eHVRL764zAUGWbBmV6efuvvQ
         k8aqmMCKLGhaC8x6ByS3doT3NO3u64UL9uHSchV+JJuYGEBXvXOoxqxSPVjstcmiRzbB
         hyX8rzd9tvGdooj12ncurOs3K6k/T6+XEDPsUAuqBd8966Ni4DXOzKcHTK6EifmVDiP5
         mw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=i1/YAhXSiHnqFFYldu2ElK+ccazqY0NTe4Ixv5mzJSE=;
        b=Mz4Cj2Mk9kfElSItt15yOTjtBeHo4JjUjl8UxnnXEqhwVdJ606jCF5Zy3YhF6MNW6k
         c/7rbZdbS2FWAulQ9WK64q3F4HGWO1uqxqo5l9kRzbA+K4pqqu4IACR6DUcsrKjxqGD9
         AmhESS0d0NwA0jB1kBLfqQYDSU8yBoulrWfR39cNdXoE6rJi+s6xjto4t7Jl6+Vat+t1
         vnQquNdXCFA5Kg82SF/lqUh+xQ4RGgKa5GJ+UF43/RZMQ6y/N3e67AJvTSheHujy17jR
         Qk89vrVKZDvfRC40a543QH2wZj8PGYHeQDTnHx6u8lTptdUTFMuOL0sBpz9yiGyfr3i0
         DoVA==
X-Gm-Message-State: AOAM531/+OPrUpQK4eMmsi7OfyYmz/uBqaGM0SJ/WSjSsG/tgLqkq7Bi
        2fIN02Bg+xOSNflaAbu6DUs=
X-Google-Smtp-Source: ABdhPJyVmScCDH9c+1XhrxmXFEFIFuYz4ky8C/UVWXTBYeAOcHnM7i5Xc2Bc+TAAaAk2YyglYbueAw==
X-Received: by 2002:a37:b082:: with SMTP id z124mr28886918qke.446.1622658465300;
        Wed, 02 Jun 2021 11:27:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p2sm350439qkj.94.2021.06.02.11.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:27:44 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH] NFS: Fix use-after-free in nfs4_init_client()
Date:   Wed,  2 Jun 2021 14:27:43 -0400
Message-Id: <20210602182743.531623-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

KASAN reports a use-after-free when attempting to mount two different
exports through two different NICs that belong to the same server.

Olga was able to hit this with kernels starting somewhere between 5.7
and 5.10, but I traced the patch that introduced the clear_bit() call to
4.13. So something must have changed in the refcounting of the clp
pointer to make this call to nfs_put_client() the very last one.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 889a9f4c0310..42719384e25f 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -435,8 +435,8 @@ struct nfs_client *nfs4_init_client(struct nfs_client *clp,
 		 */
 		nfs_mark_client_ready(clp, -EPERM);
 	}
-	nfs_put_client(clp);
 	clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
+	nfs_put_client(clp);
 	return old;
 
 error:
-- 
2.29.2

