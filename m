Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58FCE2734
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbfJWX6N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:13 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33508 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWX6M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:12 -0400
Received: by mail-il1-f194.google.com with SMTP id v2so20669730ilm.0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UQJtG0eF3ROCDcYr9wQJYVSG7YUZRmSPD3to91dvFSk=;
        b=iq2Sc6U+KcNW4lr49M4x33ApWffbZnqoIRNeSkFmUwFV+2zPZDGHpuJ0tNncqDHH3r
         NSmd6GOaxp5SVaH4AmZ2lUSLNLl3RETo5h/s5Pkhwibeo1gs4OrFr/XgXXqXrr2BS+3M
         hQsDI46K2CDQfYZk3j4grU+rcSaIlGmlszcHzV86NTaZ0+GyNvjpAEmDQGaaWUZbhIzV
         Pw4Cj7SSouS9yekaUnpJ6diZc/3Xt3CTQV+LnxPlcY40CXcfEGXwtn1ZTTKYKrPrUSEg
         3QL6Ypqhv8RYaQsotXhL+mf+n9ilQf/x7Tp9kahmui4I8H2H5MAcifpbNYwj82oEXutF
         4Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQJtG0eF3ROCDcYr9wQJYVSG7YUZRmSPD3to91dvFSk=;
        b=ZS7AtDTCquap4YK00XgncEaiolrtmjMGJVUhPT0B3FDavFmKEbCGsRyrIaNuMlf9oQ
         YL1eBt46sQuevf2t6nd6EN/4sOg+VYTY5oY5x9eyqShtHUBTBcNAwPBmCJfr3Idf13lD
         8SvwXaR50nLRO6NW2pmxSexjp0tam+9yVqaXxB2mWz5ty5nMs3YsKPx0PKa2p6M6xHSB
         9ldXqDXYDEp66TN5ejCIgZVnbEGypzuaztGznVoud0/4WhFoxjryyA7IW5RTbQPQWDB6
         FA2Go6Z6+6wMjv6OgOdna+yc7AglKYQTAOgrY26tlc+z+0XGvanoAVcg0p185SniuJFx
         vXQQ==
X-Gm-Message-State: APjAAAULP0YiEA6aEsz3FOMYYptx7a+HtrlS5dydnR0DwYe0e0iSXXW7
        LAspsUiekIayeCajU+Dd4Ok5VAY=
X-Google-Smtp-Source: APXvYqz9RA4lBtZKECl+AkEg56FIkR7KNF6SS0f2szufNHQSijA+7Wt61iuEKTqRcxS8eycN+fcdsA==
X-Received: by 2002:a92:980f:: with SMTP id l15mr14130641ili.152.1571875091277;
        Wed, 23 Oct 2019 16:58:11 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:10 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/14] NFSv4: Fix delegation handling in update_open_stateid()
Date:   Wed, 23 Oct 2019 19:55:48 -0400
Message-Id: <20191023235600.10880-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-2-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <20191023235600.10880-2-trond.myklebust@hammerspace.com>
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
 fs/nfs/nfs4proc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 294ea8c1a163..c407e2eed3d5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1740,14 +1740,12 @@ static int update_open_stateid(struct nfs4_state *state,
 		goto no_delegation;
 
 	spin_lock(&deleg_cur->lock);
-	if (rcu_dereference(nfsi->delegation) != deleg_cur ||
-	   test_bit(NFS_DELEGATION_RETURNING, &deleg_cur->flags) ||
-	    (deleg_cur->type & fmode) != fmode)
+	if (!nfs4_is_valid_delegation(deleg_cur, fmode))
 		goto no_delegation_unlock;
 
 	if (delegation == NULL)
 		delegation = &deleg_cur->stateid;
-	else if (!nfs4_stateid_match(&deleg_cur->stateid, delegation))
+	else if (!nfs4_stateid_match_other(&deleg_cur->stateid, delegation))
 		goto no_delegation_unlock;
 
 	nfs_mark_delegation_referenced(deleg_cur);
-- 
2.21.0

