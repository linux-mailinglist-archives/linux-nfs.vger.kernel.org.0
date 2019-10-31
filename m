Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F78EB9D3
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfJaWnS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:18 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37976 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWnS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:18 -0400
Received: by mail-yw1-f67.google.com with SMTP id s6so2790745ywe.5
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cvclt5ZKF/aNwsCBDjZ1qV6Hx5xfjUTWrsbcRqD5wGI=;
        b=PADw7enr170FiCidlbcNy5reryUqvqhcSjG7n+eVVYhTyzoOTMQsoK32jjbMIopPzJ
         C1u3f+jJj6o07a/VX/jyOOm5WNSdpG7RpbkroBwndRTw3vEBY8P48naTlleGgvOhWHai
         MjYMfQGo52h+54oojxWY8mH/BURuvFTIgEym3zdQZj61BtozJZNECXIhj2mDh/nHKXAx
         n4BbidpKSsvAlGhef+k/og5xdfLbz5sA+J4MCw+ZOoh6V9Ixu50WA+lXlTnYwA60N9Li
         78Z+rG6YlrLuQSjud/4K6U4XxAa2tdEN9Wl2ZgHGTThgQpXQO0k2oU9o5rMPatp+ak6O
         Qg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvclt5ZKF/aNwsCBDjZ1qV6Hx5xfjUTWrsbcRqD5wGI=;
        b=ZoMcEJpbvRFRNtBOZsPY/HoDthqyYWqTH3qxrv2dqDlx60erlpUaqCNmaQmteSlT2v
         /qcXRroTACXQ1QaPefE2UvLtX9npaNakFBKVfIFfc/BUvvf9YiodrsqYjEwPSHkQDooO
         ebwMkHQEpx9WIXESvU1j3aDk/vh8cgP6Nai7BQBK6xxfGYYO56j3n0L8FefQxAhMRm91
         wsUx0BFxX5B+cz1ah1ES/5E9kq8vBxK6IJDd5PzRSkMgBOKNKNQNvDuNs0HRVDkgD2Rd
         3uxJIwgLz1B4NvCbCWeDOQwxcijcYLP90LBVAiPw/waTbGQpQyNunkgCoNPwaLaR2Usk
         J1Bw==
X-Gm-Message-State: APjAAAUVlt9V/+3gdn+4IrUbyL2lMD1KfYoCcyMAnWE8G8LusSzG4wvo
        9JgyKFmp/zpOpGFGTbUKHmD0Jb0=
X-Google-Smtp-Source: APXvYqw1Ys8/6u5WwLInDbpC1jTv6XdO5QsxrbKBP1yo2vVm3JVu9j05NLiryijJZtEVbBGeB2+/Pw==
X-Received: by 2002:a0d:c802:: with SMTP id k2mr6288716ywd.358.1572561796656;
        Thu, 31 Oct 2019 15:43:16 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:15 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/20] NFSv4: Clear the NFS_DELEGATION_REVOKED flag in nfs_update_inplace_delegation()
Date:   Thu, 31 Oct 2019 18:40:41 -0400
Message-Id: <20191031224051.8923-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-10-trond.myklebust@hammerspace.com>
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
index 7ebeb57cb597..a0f798d3c74f 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -343,6 +343,7 @@ nfs_update_inplace_delegation(struct nfs_delegation *delegation,
 		delegation->stateid.seqid = update->stateid.seqid;
 		smp_wmb();
 		delegation->type = update->type;
+		clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
 	}
 }
 
-- 
2.23.0

