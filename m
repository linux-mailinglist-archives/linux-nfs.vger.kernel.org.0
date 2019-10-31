Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCBEB9D7
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfJaWnY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:24 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40689 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWnX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id a67so2787749ywg.7
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qt/cmllgWyFyQXjgEd/PehmbeSEG9aGD5ZDxJMCTumo=;
        b=dHdHmkJXa7esx20smKDriVkcHdtWvHxQQB3ECLetMA2Gw/uRuC+M6sgaDk1gsPBxGA
         MQi3Nh7Ez5C4/N4wCv5LnngfGtu6/9354Btqph8n55G5AoSs+1BA5E1pSu7/6C1LX3Kh
         Ft4adl88Ra+JDRoZiIwfhjnCBGTD7lRorAXHEiPiSI6UCAxs10JTHUF5TLTAURwL9uAb
         BKsU7IMjvxs8V9a4d/o/azDvA6FmHCXAUCrom52Fz1EIkdBtcOJJyTSAQf4zJI67ew3I
         Sh85kE1V78keO5Hx5cP9hpC2/yESVYIurx3lfJnHXgBLdzHH4krlRqPsNDdDc8b4Nt3v
         xg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qt/cmllgWyFyQXjgEd/PehmbeSEG9aGD5ZDxJMCTumo=;
        b=MmVkbDPurKlqQ3saCVTWPE3EaC8hPYSUXjR4GArPVrx3PmZi/znYhGyLbE/HcQPa/B
         Z+x4piC6B5tyVtXXAIPOBgs4vR5L4WkxGcruqepiikyYQtUfVMA5XWW7I5g1xpz1s7Al
         LqQ0S8/F/F4hCMy8/iADQd4EHuS36TBpmJU1kuba8jFm1w7l9sqgyLf1KCjr1ZmEXsIy
         sO3r87uX/fqJIKiMJAw0/RHuxlI5bjg0wogrOzWV69PM7PTqGkwdIZF/NuQoy4urt73m
         cIsDfufERtmUma1DGkJcSrZnum5jKiBonhZxXsD7NFVS6ZaRqGUR3/zVYl52XMLnPuBY
         ungg==
X-Gm-Message-State: APjAAAXcwpBJ2Dzawx4PTqkb4l+4TgYQka21KnpAion//v0Kdl+kVhpi
        16Jhb8M0mtO7VpxU5DvTmqzwA2I=
X-Google-Smtp-Source: APXvYqxrxyrR7x69EevUIhFMapJ73mrTavEE/jfDTQZaAa/i5bPTj9w5w4RxL+YHJEBSnK5iYTErGQ==
X-Received: by 2002:a81:4948:: with SMTP id w69mr6312034ywa.404.1572561802541;
        Thu, 31 Oct 2019 15:43:22 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:21 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 14/20] NFSv4: Don't reclaim delegations that have been returned or revoked
Date:   Thu, 31 Oct 2019 18:40:45 -0400
Message-Id: <20191031224051.8923-15-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-14-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
 <20191031224051.8923-10-trond.myklebust@hammerspace.com>
 <20191031224051.8923-11-trond.myklebust@hammerspace.com>
 <20191031224051.8923-12-trond.myklebust@hammerspace.com>
 <20191031224051.8923-13-trond.myklebust@hammerspace.com>
 <20191031224051.8923-14-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation has already been revoked, we want to avoid reclaiming
it on reboot.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index ebd83e4db300..78df1cde286e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -199,7 +199,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
 	if (delegation != NULL) {
 		spin_lock(&delegation->lock);
-		if (delegation->inode != NULL) {
+		if (nfs4_is_valid_delegation(delegation, 0)) {
 			nfs4_stateid_copy(&delegation->stateid, stateid);
 			delegation->type = type;
 			delegation->pagemod_limit = pagemod_limit;
-- 
2.23.0

