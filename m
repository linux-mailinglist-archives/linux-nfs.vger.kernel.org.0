Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A555EEB9CC
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfJaWnH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:07 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38261 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaWnH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id w6so1529600ybj.5
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+n0mJF9y5GMEWpMGMu9q3t13jMd2L4Qm6XXL5xJbWQ0=;
        b=QnHBWqXSnCi5GtVlZ6sPy5I73fBI7KH0OiE0LMTpZ/g80MKdks2c5HfC9AnKANZkcI
         fFhaDQ+a3vACMUzQ8DJlCpTLaN5O67pKy94mFgz3ooRh16e/YULtSue3R625QnG/qwS8
         BJhGR5D4//VzTau6OVmIGTJNPE5hzWgRrB9iKRRkVs2C/VPHOADH8ucmijDhA81HuSZ/
         pXwnQuW0BN2n+v+/btP8at8iTgwbPoUzvnCUHUXyhvW853afYer8WnrlAjWbCSXpWsGY
         zJQGAmqQq0loWOXA5SQTsVZ2wE7Vbt1+R86u8cUaKAuUgUGeteVNL7VLetfPTt+tOT0I
         1wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+n0mJF9y5GMEWpMGMu9q3t13jMd2L4Qm6XXL5xJbWQ0=;
        b=ovjUPJC/hreXOAYRGXoQ+R+s0c7Q30Mv6j5OI/g2SkN1PC6uaum8ePdLvD+eDzPv2D
         zvCOfVZlSTEorZe/5uA1NolPu2QM1y9HC/oQbkA/MsiPi9oclbvyfjcdV1CqsNa2dYZ0
         1CKoOr0ijbjGU6Ilt1hjTxTrVEennORLWbPHxhwV9pl7HVZPMBQ1yAK38XB0VU9WkW06
         gU6C+B7eZ37/3hx+6/t/iE3b2MFKD07zE7KE+bT+r2MSNCdY4bclAQZYrR9PAPGaWxng
         GPfaIIZ0SNSI8eruNV+Jucu2yAbTMG42X63vKO2z2vqMoOPmaDh/XH8R1+pYFmCyNP3m
         ialQ==
X-Gm-Message-State: APjAAAUNbemz2COePo9wbqsougnXyN1hlQCaHff5U75lJ/LlJcqwqdwU
        Ak4AXXER9leZw0zMd35JPp8XuLc=
X-Google-Smtp-Source: APXvYqy0RkOYNd6pV8NjJzxaFfc4AKuex+9xyBidGjsVFRPJK+GWJ8nhWq6Xx54GAK0g6PGRGW0sZA==
X-Received: by 2002:a25:6345:: with SMTP id x66mr6572298ybb.212.1572561786003;
        Thu, 31 Oct 2019 15:43:06 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:05 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/20] NFSv4: Fix delegation handling in update_open_stateid()
Date:   Thu, 31 Oct 2019 18:40:34 -0400
Message-Id: <20191031224051.8923-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-3-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation is marked as being revoked, then don't use it in
the open state structure.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index caacf5e7f5e1..217885e32852 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1737,7 +1737,7 @@ static int update_open_stateid(struct nfs4_state *state,
 		ret = 1;
 	}
 
-	deleg_cur = rcu_dereference(nfsi->delegation);
+	deleg_cur = nfs4_get_valid_delegation(state->inode);
 	if (deleg_cur == NULL)
 		goto no_delegation;
 
@@ -1749,7 +1749,7 @@ static int update_open_stateid(struct nfs4_state *state,
 
 	if (delegation == NULL)
 		delegation = &deleg_cur->stateid;
-	else if (!nfs4_stateid_match(&deleg_cur->stateid, delegation))
+	else if (!nfs4_stateid_match_other(&deleg_cur->stateid, delegation))
 		goto no_delegation_unlock;
 
 	nfs_mark_delegation_referenced(deleg_cur);
-- 
2.23.0

