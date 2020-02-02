Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8D14FFDF
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2020 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgBBW4L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 17:56:11 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38327 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBBW4L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Feb 2020 17:56:11 -0500
Received: by mail-yw1-f67.google.com with SMTP id 10so11960740ywv.5
        for <linux-nfs@vger.kernel.org>; Sun, 02 Feb 2020 14:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2NHDirab5p1dosagLCqK710CjMeLB79QssC2AK7PVg=;
        b=it+9cEg3wcme4zWNIdp63ohylVZlm4sNo/aR3U2wBOie/b4iaTPdCj+PJXjdRyLgtY
         zPcNava41ZgmQU6yCC0kQU9evMeQkk7BM2wl/OXiGPPxebPNTJLQkmBb5fEuSfU9MC0o
         dsq/U/QF/RfhOdOguo6Ep5BBvAWU43IN/+fVduKX6nLGH73oG+djz3ldKT2VzGDx0WJ4
         z1ex6GOsiQhJJtbgmvrsR7Yo70OchngIrFQ1JqYtHwuwweLgrBJ8Fe1W8KsIQUdwiSe1
         n3qdUX1EjMnzlB5j0kp/aW1imI9SvkNjwiKLRQSOF03Vh1hB7j6eVCNREnDJeayMYRtF
         f7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2NHDirab5p1dosagLCqK710CjMeLB79QssC2AK7PVg=;
        b=bZmewPxqOMnSRnUjJ5kDI/YaGCCXhH+r4Zkizj+1k4JJo9/Hsy+5itT1e1A9B/Hovn
         ZMxzGyc5bvMSvffZI220CKI3QgZRDsF/G//Bnzms+l6DHy7pYbz39UZQUyPNw1qlA73P
         FsxD53l9YgUPAuBDEDFzO82mz5LWGvUINYfSp4uaXzOa8xcoL8lrI22wfvI7Op6yEFIg
         Xr5AnHOc1vPTLOou+JUfBykkx6TMssUdmYRAPaM23Ia4OLyphuiQgEhrBRhMnNp73VsH
         qLKMxD6xaI1RME3GZbnZymR4G4+xr/vaGiAqA130JwoSfDcSOiP4GJpBBXZz0XYHbm+n
         jYeQ==
X-Gm-Message-State: APjAAAWasfgNOE+9W6YHl52KYlu5bmTft9sAM/hm49NJXLUQrpD5PueX
        ywxWjTATGNbB79vfx9EbqA==
X-Google-Smtp-Source: APXvYqxVPSI0l+19oiVvjA2wItYO675PS3CACY5RUp4cpi0tSg0b3VUlhaxhIcm0aMfEyBAiw1+QAw==
X-Received: by 2002:a81:431d:: with SMTP id q29mr5354337ywa.411.1580684169938;
        Sun, 02 Feb 2020 14:56:09 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm7185529ywf.101.2020.02.02.14.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:56:09 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] NFS: Use kmemdup_nul() in nfs_readdir_make_qstr()
Date:   Sun,  2 Feb 2020 17:53:55 -0500
Message-Id: <20200202225356.995080-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202225356.995080-3-trond.myklebust@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
 <20200202225356.995080-2-trond.myklebust@hammerspace.com>
 <20200202225356.995080-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The directory strings stored in the readdir cache may be used with
printk(), so it is better to ensure they are nul-terminated.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 90467b44ec13..60387dec9032 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -199,7 +199,7 @@ static
 int nfs_readdir_make_qstr(struct qstr *string, const char *name, unsigned int len)
 {
 	string->len = len;
-	string->name = kmemdup(name, len, GFP_KERNEL);
+	string->name = kmemdup_nul(name, len, GFP_KERNEL);
 	if (string->name == NULL)
 		return -ENOMEM;
 	/*
-- 
2.24.1

