Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E153D806E7
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2019 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfHCPAk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 11:00:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41906 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfHCPAj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Aug 2019 11:00:39 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so154570196ioj.8
        for <linux-nfs@vger.kernel.org>; Sat, 03 Aug 2019 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2RjX4xJ+cxt3dLtKsWxFiNtC9Mhb5keEj/q7VRtZ0X4=;
        b=oL5F6dl1gqpHBlHo+vU929bXge79R2gvhjoOaLjTarNNzpdTOQYfprUecQJc+y98/0
         KMqMusyfvDROr5zV6bz3JPrImbT15eINphXoVKRIwas3ZZz/Sqqm4AnhOyV7TE9czkvD
         r5FWwJaZXWRKTsymdu/alraZbcpg0NDyIU4G3G95+o+S0gZpicoaluXD9QX/9J2vv3nB
         oDVx7xicMGgn4irpNTanZ0D6Mo/viwGRHhkBjtV41B7zoXnbG7DTUg093Wunlxh8WOZf
         nmg9OSl61y+/4oqP1Imgyz0QyeNcMlz6aNR8enMYSzFDuxuuLGrpYWGYCM7FRPjeA+Mj
         0yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RjX4xJ+cxt3dLtKsWxFiNtC9Mhb5keEj/q7VRtZ0X4=;
        b=XbGXW7mC07dJRAIhMLWAe3gFNCyIK1Mt3rJ9PsNzpQNJLUpaBkYWwWY1raw9nbRO51
         JgKn1v5iavp9nvwQa8IpbkRRBNt+M4sRTN0MDM9fsZef3gzjVTV+BwatawFSHkdDkV4X
         6ronjP2KEiLmqCtQE4a43Bvg/Ib9lE/bsSktipeh7G6CancOiWqiOAPz/pfFlNGHpLDm
         VMYtXoRfvHOIN2rBt7EKxWKsYIhNkoGvdCjAnYxfjnT0jVJSJKg/nN8IB5n5tM9AalH2
         EfmN1RS5bD9y5bppu1D1vO7Ftu5yxHnEC9ROAiqc0HGavXbnufRB5mmWu7CFxng7t2Kl
         3tcA==
X-Gm-Message-State: APjAAAVoMWZEg20Fv7dmAJgPM7FEDMqT5MZUmcpBFM8CzJd+VVupGYIW
        A7nGLPeWc9DmF80kPuFKM96SCNU=
X-Google-Smtp-Source: APXvYqx/6LKWfV9H/Po2QH+yyt84jGztyqbt7YjRrduAJ8mSeyTRo15EfVQJGQjIJJ5z55Pko4YgOg==
X-Received: by 2002:a6b:cd86:: with SMTP id d128mr130476671iog.234.1564844438649;
        Sat, 03 Aug 2019 08:00:38 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f20sm60820416ioh.17.2019.08.03.08.00.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 08:00:38 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/8] NFSv4: Check the return value of update_open_stateid()
Date:   Sat,  3 Aug 2019 10:58:26 -0400
Message-Id: <20190803145826.15504-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803145826.15504-7-trond.myklebust@hammerspace.com>
References: <20190803145826.15504-1-trond.myklebust@hammerspace.com>
 <20190803145826.15504-2-trond.myklebust@hammerspace.com>
 <20190803145826.15504-3-trond.myklebust@hammerspace.com>
 <20190803145826.15504-4-trond.myklebust@hammerspace.com>
 <20190803145826.15504-5-trond.myklebust@hammerspace.com>
 <20190803145826.15504-6-trond.myklebust@hammerspace.com>
 <20190803145826.15504-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we always check the return value of update_open_stateid()
so that we can retry if the update of local state failed.

Fixes: e23008ec81ef3 ("NFSv4 reduce attribute requests for open reclaim")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v3.7+
---
 fs/nfs/nfs4proc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c9e14ce0b7b2..3e0b93f2b61a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1915,8 +1915,9 @@ _nfs4_opendata_reclaim_to_nfs4_state(struct nfs4_opendata *data)
 	if (data->o_res.delegation_type != 0)
 		nfs4_opendata_check_deleg(data, state);
 update:
-	update_open_stateid(state, &data->o_res.stateid, NULL,
-			    data->o_arg.fmode);
+	if (!update_open_stateid(state, &data->o_res.stateid,
+				NULL, data->o_arg.fmode))
+		return ERR_PTR(-EAGAIN);
 	refcount_inc(&state->count);
 
 	return state;
@@ -1981,8 +1982,11 @@ _nfs4_opendata_to_nfs4_state(struct nfs4_opendata *data)
 
 	if (data->o_res.delegation_type != 0)
 		nfs4_opendata_check_deleg(data, state);
-	update_open_stateid(state, &data->o_res.stateid, NULL,
-			data->o_arg.fmode);
+	if (!update_open_stateid(state, &data->o_res.stateid,
+				NULL, data->o_arg.fmode)) {
+		nfs4_put_open_state(state);
+		state = ERR_PTR(-EAGAIN);
+	}
 out:
 	nfs_release_seqid(data->o_arg.seqid);
 	return state;
-- 
2.21.0

