Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA0E273A
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406151AbfJWX6R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:17 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33807 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404828AbfJWX6Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:16 -0400
Received: by mail-il1-f194.google.com with SMTP id a13so6303597ilp.1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CIbITOUXPbXRnQXw5ojtD+uvzTEzCqXnEDbdi6EaBWA=;
        b=VtZGLzmCpfgdJHOCcwWYiUJPhRbyA42u4jn1Z+bJ0GmRbL+hrn+BD8RDHtEyNlVHpa
         PgwDwvLhaTNV6VlU0l8r5Ejfx4R+ftSSypJLLQNTCLqmODFdual1v7Bb/YC+hlxAnqzL
         HwAuSrHxFswyU53AMZv1nk1mb3rdAA3SjA3gDXAcNLBVVIVRnYF178fvb67mEvTh+XsF
         js9BsTkkPQrThUGWi77noqj3ylrKnQUZ9giLUE/9sYPhzlqc6dM+4OUpqbAnucJkEAu8
         RJ4OUi9tuGAC4+RPFIV5ffKiC4qJjOtCtq6OzM2D2c0wVa7Am8g+5zzSLr1ODS24RSSt
         tXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIbITOUXPbXRnQXw5ojtD+uvzTEzCqXnEDbdi6EaBWA=;
        b=RlMT0+1KhLF5N5P3X/RNu3DDylUUnGNGtAZZLveyuZVYOVlfApwxtj4w/PJA1X383n
         JXKCkWrO5gKIYB6zqlAnlqmv3a5XoMhfibdCniVu3279cL02+4FR9RsegmGzDUAAkCdj
         1FNcloX2Ub5aP0Mx50O1JgWVBc3cvlMcxbsed2GMtgPHqtO/ZezLhEoZHEue58gE0lv9
         fZzFGlIGxgPGSmhzI9eRk4No0ThBgEU/muKNtmtErPfPJbuw76xvnUSRDdqJb+Jr3tWw
         c92QJvO/NHM8ywFVKw7gW9/fAVLtodZV8+0okCBKg3kPDrQAO1khl4z1N/4DnGi1Va8e
         lN3A==
X-Gm-Message-State: APjAAAW1aMnBhF25NN91rD4nBxheQP/pjGNsw10mbUNrBpyUQOTb4E3+
        wnZ1BjdHcS1/Nl1XE73oQ+AAXjI=
X-Google-Smtp-Source: APXvYqznw3jR8r0y62UF9ktSXxRuBkvGinzutonvCYzngxHbx5sS8mTigb1+lkS72pg4cKfO9EpopA==
X-Received: by 2002:a92:188:: with SMTP id 130mr20976393ilb.177.1571875095458;
        Wed, 23 Oct 2019 16:58:15 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:15 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/14] NFSv4: Hold the delegation spinlock when updating the seqid
Date:   Wed, 23 Oct 2019 19:55:54 -0400
Message-Id: <20191023235600.10880-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-8-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <20191023235600.10880-2-trond.myklebust@hammerspace.com>
 <20191023235600.10880-3-trond.myklebust@hammerspace.com>
 <20191023235600.10880-4-trond.myklebust@hammerspace.com>
 <20191023235600.10880-5-trond.myklebust@hammerspace.com>
 <20191023235600.10880-6-trond.myklebust@hammerspace.com>
 <20191023235600.10880-7-trond.myklebust@hammerspace.com>
 <20191023235600.10880-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index b49faf1b3d91..d9c80871cecc 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -376,8 +376,10 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 		/* Is this an update of the existing delegation? */
 		if (nfs4_stateid_match_other(&old_delegation->stateid,
 					&delegation->stateid)) {
+			spin_lock(&old_delegation->lock);
 			nfs_update_inplace_delegation(old_delegation,
 					delegation);
+			spin_unlock(&old_delegation->lock);
 			goto out;
 		}
 		/*
-- 
2.21.0

