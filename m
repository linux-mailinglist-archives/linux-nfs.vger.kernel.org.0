Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF225806E0
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2019 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfHCPAf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 11:00:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36124 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfHCPAf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Aug 2019 11:00:35 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so55101014iom.3
        for <linux-nfs@vger.kernel.org>; Sat, 03 Aug 2019 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyNHAH00KqBO+HMY5Y0wF6D7MG+dmxd2DUPH09N1l8o=;
        b=AE1Uo6wlj1DyTkwHu5FygbLM6VHI1lPuo8Fwad2nz3p2ez5oGfxt8zPal2zaIG4Pa0
         RAG9xXbGH/NG+SZ5JWIoaxCrOFaT7ampfUOu6y0kAdtpcmRwtAb6dWhtBlfnZnaZaWy1
         h6Iq/8SuhU2JJ6FzS2BMIXPQ2qRmFG7sAMJDNv+xoBIuSzh1NaViJXeveJXxfmh3OLb/
         /mTKiuaRdAeaLjSOpMSK+G8OZYzAPWNMgYRlGzZ3PCbZdhI6Vf4qmbKuiELdlYBCm25J
         59sgjf0sblD1mTme+XEic0qaDAIAeou3lJab8t4CawOMdium5wU8fLCqPvrXkRTH+316
         tIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyNHAH00KqBO+HMY5Y0wF6D7MG+dmxd2DUPH09N1l8o=;
        b=dfMNvxpfRTImYCnN7/mt1bSfkEBKLINwqW3tJ6jr8Y958t4sxaCDxfX5i8dMEdj5Dp
         GRmT+JJSl4A7fujnq5djymp5YVso/2a8ebREbCkV3pollpzbE9UCmmUt/NviDMowPtTh
         2lPi3dEPo5SLdX9NXqwgT1OToDgtZKxk7DetoHxccoqdsIYSbijcdM4NTlVIFKkpIcnC
         h3I4Q0B36ETQGGbB9vDfqy+vlWEsTylMsFVO4UQDxrHKI4gFy+gjuBI0GXh46Z5DiB5w
         EJCAxpUjDUIAJp4JpPx27VKMtEeAuozywikbJn5oJyLv+cmeGr8wCZYVHXUL5acEF+4S
         Z9cw==
X-Gm-Message-State: APjAAAUEJpPxoD7zPcp63pAAkRIyCN9ca6aXw2GMjOJuwvz47TCxsogJ
        Jit9k2ZJiNRxMY8tcuEerXsAVcQ=
X-Google-Smtp-Source: APXvYqw7bzgM+uTFO37ZWxIVx/Nsnsll4DLqv0vd2l9K2nSYpoRJi+0B0EPhwY4b2TZRN0wN+77r+w==
X-Received: by 2002:a6b:dc17:: with SMTP id s23mr20361891ioc.56.1564844433914;
        Sat, 03 Aug 2019 08:00:33 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f20sm60820416ioh.17.2019.08.03.08.00.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 08:00:33 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/8] NFSv4: Fix a credential refcount leak in nfs41_check_delegation_stateid
Date:   Sat,  3 Aug 2019 10:58:19 -0400
Message-Id: <20190803145826.15504-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is unsafe to dereference delegation outside the rcu lock, and in
any case, the refcount is guaranteed held if cred is non-zero.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 39896afc6edf..a6d73609b163 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2778,8 +2778,7 @@ static void nfs41_check_delegation_stateid(struct nfs4_state *state)
 	if (status == -NFS4ERR_EXPIRED || status == -NFS4ERR_BAD_STATEID)
 		nfs_finish_clear_delegation_stateid(state, &stateid);
 
-	if (delegation->cred)
-		put_cred(cred);
+	put_cred(cred);
 }
 
 /**
-- 
2.21.0

