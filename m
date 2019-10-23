Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90657E273B
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406349AbfJWX6S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39462 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404433AbfJWX6R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:17 -0400
Received: by mail-il1-f193.google.com with SMTP id i12so10115025ils.6
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q/TLhPeG3i+gvasxZ5F8IXG4BfmaFJzWMMDpYSNVO/Q=;
        b=ghHySkV231ZTGhvj6Gal/5Xk5ZTdTxiviquIjYiXrluNNv3Iypi0j3UUlrz7+Gh6s9
         Ekjr6lrG1U9BwZelg0yDu6V8Mhb1PgqTY7YZ6POIINrn3upJK+ok4qUhN0+sdwB5O9kW
         jMuuuvcD7Kg3yfmcan3ez2jtHO6Q+Kpy7qgfx3LlrL/fYr5hdU/c5YEBv35a0alrJz2S
         ++CiQwrWYY/fRp4eERBfmioeaeY1Z9REd2VOcSdox9dQt79J9zNRlwXXPrVIsc8rni6Q
         sR9LbhIFN64DsVVL8Bu+8abRnuJD6vz+HCF4ip6R7X3JvWJ1fBriqNt7DzGZjJLnQY3z
         9KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/TLhPeG3i+gvasxZ5F8IXG4BfmaFJzWMMDpYSNVO/Q=;
        b=LzwrFuAoW2GVL3vuRT0Xn6kgZP6s4u+tneSw3IQZIjCWS4l1vQLPYbtaZqZidwJfWL
         HUBMtDFpbM6Zdvef2D4mmvf0281e//HbwvIExs+dAwvqtA765CXgjCZS5o3dzqUypyuX
         bDCsFLUKlyekWWg5l+MpctEyWJS3koL1geTXtdiinOZDn2RYlW/2s6mDl0V+ida+jUfm
         8YP/Xp/fGyCIF7ebYSC7Tn8mZ+rAQnTsu/RiCf/iIkVi4xd0rthmgwsKvfNXFbxMOBkG
         BvpvDZBAPKQaJEIxgR+emR/baqN3UVDdHdqRXfRnPn92tBVSPNZdw9jHL1Pa9lu84CUX
         D28Q==
X-Gm-Message-State: APjAAAVQrrKqAgwgR65rj4rfGUO8chGztCxglTxK2WHQQSrr0X5rSAxb
        qojaJ7wF6k2jLt9WVYiytkQ726k=
X-Google-Smtp-Source: APXvYqxjCQP/UGcNB9OYe/cLit40gAu5yewl7GJm/nbC22NVyf3dHG/nsr6wqg6dyyYsK8TLYGlp0Q==
X-Received: by 2002:a05:6e02:c8e:: with SMTP id b14mr42597553ile.16.1571875096089;
        Wed, 23 Oct 2019 16:58:16 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:15 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/14] NFSv4: Clear the NFS_DELEGATION_REVOKED flag in nfs_update_inplace_delegation()
Date:   Wed, 23 Oct 2019 19:55:55 -0400
Message-Id: <20191023235600.10880-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-9-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <20191023235600.10880-2-trond.myklebust@hammerspace.com>
 <20191023235600.10880-3-trond.myklebust@hammerspace.com>
 <20191023235600.10880-4-trond.myklebust@hammerspace.com>
 <20191023235600.10880-5-trond.myklebust@hammerspace.com>
 <20191023235600.10880-6-trond.myklebust@hammerspace.com>
 <20191023235600.10880-7-trond.myklebust@hammerspace.com>
 <20191023235600.10880-8-trond.myklebust@hammerspace.com>
 <20191023235600.10880-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server sent us a new delegation stateid that is more recent than
the one that got revoked, then clear the NFS_DELEGATION_REVOKED flag.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index d9c80871cecc..b6cc2e71fcdb 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -332,6 +332,7 @@ nfs_update_inplace_delegation(struct nfs_delegation *delegation,
 		delegation->stateid.seqid = update->stateid.seqid;
 		smp_wmb();
 		delegation->type = update->type;
+		clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
 	}
 }
 
-- 
2.21.0

