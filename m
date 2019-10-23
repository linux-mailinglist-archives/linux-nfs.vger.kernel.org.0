Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635F9E273C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404433AbfJWX6S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:18 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42339 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406310AbfJWX6S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:18 -0400
Received: by mail-il1-f196.google.com with SMTP id o16so12566256ilq.9
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T8D6q1Ea4/af1vMO59OuldPoVzw8cQL6pHgSwOa5LsI=;
        b=NW0ud2L2VFbksapFCxjzV267S3fj01kAjj+CzQ+eQ/mTMdZmX4ncevHMpL4kNruKud
         R0dmybnr7mt4UpU94maKbRuKfeYGuFvhPe9yZz0v/ZgwMlC8hz2vMIlAYamDRM9QLSp7
         blq/tay9QgkQ7GwTlIdWpoOIrTzrkCZGAje+tFuu1y6rkMX1BZ3fkgU1e1NUJez00quV
         qbvT2xZYhhz+/Sker/E2F0dRgRoEtjjcZUoInrzcmKyOxyjTjAga8yH0JecGGPqCjw4C
         UqSaflBkHpP/M+ZI7bGlc8g1myUzUE6D/v9Gw9Ath33Wqdnvc25LFu3T0r44DPA8VxRt
         kZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8D6q1Ea4/af1vMO59OuldPoVzw8cQL6pHgSwOa5LsI=;
        b=KrSdQs1+rr8tUKNzYluYbW4Dy2iSR6kdETt+lX0MHIYdh3YfR9wTxvCN6Ro595B9WE
         VpOjRXc9wJ6OiC+ZpoRkOXie6Gkw7i7aTUxPeoJdnvg/7/B7HC8+aUblhRyIaXgVHbGl
         oIazx+SmeAIKGMEnsru85shsftagJPYZB7RSPs82TOcKrxAIsHcHp2fwWygnn17k9+p4
         tyJ6dehU1pmgh4scNJp0YxzS5IcLZUKGaS7M65bZnPWLsFTt62KJFhk2IgFudLB/AINC
         J+zz6/0VFqmrlp27ET5M+0Fj3rMl95eol2H0l92xgyCVPcdzmefXGL1QBUVNwe7FRV9h
         fkPA==
X-Gm-Message-State: APjAAAXIn59pdJN+njkZxqyVhPGYTjtbzS+o3AH5fd6iacN4Ml4VaPTA
        E5ACj6e13p168GPCH2hxTCwkf8Q=
X-Google-Smtp-Source: APXvYqxKQ/BDhKC0MMbh55Ug8HqSKag9rcwBapJmayaLTq3Xtsho5/mMaRtxeoxQlIlm07KuCtS+HA==
X-Received: by 2002:a92:b70b:: with SMTP id k11mr24324324ili.125.1571875096739;
        Wed, 23 Oct 2019 16:58:16 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:16 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/14] NFSv4: Update the stateid seqid in nfs_revoke_delegation()
Date:   Wed, 23 Oct 2019 19:55:56 -0400
Message-Id: <20191023235600.10880-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-10-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <20191023235600.10880-2-trond.myklebust@hammerspace.com>
 <20191023235600.10880-3-trond.myklebust@hammerspace.com>
 <20191023235600.10880-4-trond.myklebust@hammerspace.com>
 <20191023235600.10880-5-trond.myklebust@hammerspace.com>
 <20191023235600.10880-6-trond.myklebust@hammerspace.com>
 <20191023235600.10880-7-trond.myklebust@hammerspace.com>
 <20191023235600.10880-8-trond.myklebust@hammerspace.com>
 <20191023235600.10880-9-trond.myklebust@hammerspace.com>
 <20191023235600.10880-10-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we revoke a delegation, but the stateid's seqid is newer, then
ensure we update the seqid when marking the delegation as revoked.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index b6cc2e71fcdb..5a87d32a8d7c 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -760,8 +760,19 @@ static bool nfs_revoke_delegation(struct inode *inode,
 	if (stateid == NULL) {
 		nfs4_stateid_copy(&tmp, &delegation->stateid);
 		stateid = &tmp;
-	} else if (!nfs4_stateid_match(stateid, &delegation->stateid))
-		goto out;
+	} else {
+		if (!nfs4_stateid_match_other(stateid, &delegation->stateid))
+			goto out;
+		spin_lock(&delegation->lock);
+		if (stateid->seqid) {
+			if (nfs4_stateid_is_newer(&delegation->stateid, stateid)) {
+				spin_unlock(&delegation->lock);
+				goto out;
+			}
+			delegation->stateid.seqid = stateid->seqid;
+		}
+		spin_unlock(&delegation->lock);
+	}
 	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
 	ret = true;
 out:
-- 
2.21.0

