Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DED399297
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 20:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhFBSeH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 14:34:07 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:40659 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFBSeG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 14:34:06 -0400
Received: by mail-qt1-f176.google.com with SMTP id i12so2545040qtr.7
        for <linux-nfs@vger.kernel.org>; Wed, 02 Jun 2021 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PpZDnFgEJP5vuNO17ms63fpsb709lUpfB1sjHKIlcgU=;
        b=EpfzFJOQJkQktwjE0cKdeo1pNdcEDISEVxdbhgCn7D0HRbdLpmI7z+ZdUCO7Nntbb1
         z+tY8UTbSt4x4l9dp4MXDU4qUVmLtHmMBbLPLj2QvrdtMxTUGRYVjvD2W84zX1oXGdpn
         4QC/GAnADnmb6W0X1MNaAcVAeGeKwkBEzE91frHA+BdVHEW4HU27aOqni14esHfOJuGB
         VIfdYuiXMCAVIlW0HPryoaJ3ZdHGqJUkF2NpoPtAER+X04UbxBf1YE/wQnmQ3CRR/3Ky
         ZYaIO8xnNy47+AHrUUch6P1IdeB+spoobf5CH857fSMqlImifTcZxtXx2YwRIwtLdwop
         dd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PpZDnFgEJP5vuNO17ms63fpsb709lUpfB1sjHKIlcgU=;
        b=A3rDVrNsEsVguoyZ7GlNrNA7nf3FhDfixOI7Mileuq+TOi+5lX9/iDImbI+ffi8t//
         s6T6JK3nt/xT4GsaKbei8xslZ/JUJBRfs0C7bbUDqMyCwtp+IQMPM46ONretA49eDwYW
         X/tS7FTECTc/YwDUKkJZbwecSZ8ZplZdxCkI/+/eu2zBx7syovnDojo5wSGjZHnYfjji
         XfmKZ+lvKg2/Qu4eH7NHbxjS8m0YHAEx6lJqEKFxfXGA8j9wLFB4+/1Z1Ow/Ig5pcpbZ
         IfCGMBNepv9+1VUB3eZY2696z3zqjd+/nPXKu/KrefOzTiyY5n2rz9aMj24agCsezTlG
         qmJg==
X-Gm-Message-State: AOAM533ZGLOpWaXxT3o98hYIZedYOiomF6EBvSIzAvPkRNNzYQDRHbB5
        n6nfD3klejkw5/Z2yxRDdSw=
X-Google-Smtp-Source: ABdhPJz6U4XmSTwHo0Sdn34CfJdkuXZMGK6I6ydC0q+UjSZIuQoKzftCkalz014/sYhlnvQw8+W3HA==
X-Received: by 2002:ac8:6911:: with SMTP id e17mr25599814qtr.135.1622658682569;
        Wed, 02 Jun 2021 11:31:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id t11sm299219qta.8.2021.06.02.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:31:22 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2] NFS: Fix use-after-free in nfs4_init_client()
Date:   Wed,  2 Jun 2021 14:31:20 -0400
Message-Id: <20210602183120.532206-1-Anna.Schumaker@Netapp.com>
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

Fixes: 8dcbec6d20 ("NFSv41: Handle EXCHID4_FLAG_CONFIRMED_R during NFSv4.1 migration")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v2: No changes except adding the fixes tag that I initially forgot
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

