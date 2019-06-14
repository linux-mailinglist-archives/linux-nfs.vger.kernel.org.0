Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55E446875
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfFNUAX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45130 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFNUAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:23 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so8286301ioc.12
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbMlSBpf06q9f17aggELxyyLLTxlNI3h6Qh/Z4qZNW4=;
        b=K+cXJY8IgJrdaur3oeE2TpjXQB5CRf3tqwKYVLsRPqm7At3fjxuV8t8yqgNLDAxA2H
         kVH7tZ87MBEjqfx00lCCeScK2wwgI4OljYFCwWfwSFRsPR4EeFhUEk48ns96q5LH2gs8
         DC/YvFGnC+EER4u+m4RuOZUKnnwyLvHsWWRqPmi3G1tDEEqfeDJTgdeKOeMF+xBH4Csn
         RcYzOAeikaKTvdieu7BQ/Ia4YlW7/RuHUfdfQCuDRwDnD5l6DMvREyliqtvBq8q7qBc9
         vXiDTPQDV5XhpUvsg172WOJ9jyCZZtp7X1J2yw3zTUsz/ogARXyr8MEuyPAcdUp1IBDO
         NXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbMlSBpf06q9f17aggELxyyLLTxlNI3h6Qh/Z4qZNW4=;
        b=e/Ov0K0zjRY/tPOELDST0cxzQ1X2t0qdphLAQaJW728oE+LiVWTknA+gVt74q2xnSS
         /q51KWUQR2MVcdWII2L+S5d0lrUl/yeH/dmHtJ7lQvE4JluVXwiwrzSzsROKBYA52MZV
         q1BuaPbyS0KSijeYzFW3VDDnhGAF8qHmMlXRv0rP5zpkqUIMopaaby9+l8z0bz6DLq1R
         8d28OEgzoeC7OR1mBW+yIu8YwreZUd7Sc3xwmBiQkIJ12xq5UrWCQ4Af8HvMQwhoM/Rp
         e7Yz1ws+iYotSMn8Pp2NuUEIG00FvE9JeWPhmNt1GX4RyM8MIRmbnqqh99Ui4DUkd2p+
         S7OQ==
X-Gm-Message-State: APjAAAWrYmrUhYZZvAf+/ohrYcNDswdE6cXCagrO84ko7IdOPgEdznu7
        9iMkzplRtK+Hma0y4HFRjFY=
X-Google-Smtp-Source: APXvYqxiFXIHm0A3EC7a6n+MDKX/dIHssh3zK2z6ZxLJSpfB2NWjfRDTacywEmWz7OjIBk/NvUUeQw==
X-Received: by 2002:a5d:8f99:: with SMTP id l25mr40267499iol.92.1560542422422;
        Fri, 14 Jun 2019 13:00:22 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p63sm4623407iof.45.2019.06.14.13.00.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 04/11] NFS: also send OFFLOAD_CANCEL to source server
Date:   Fri, 14 Jun 2019 16:00:09 -0400
Message-Id: <20190614200016.12348-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
References: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In case of copy is cancelled, also send OFFLOAD_CANCEL to the source
server.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index e34ade8..bbf7c1e 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -206,12 +206,14 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
 	status = -copy->error;
 
+out_free:
 	kfree(copy);
 	return status;
 out_cancel:
 	nfs42_do_offload_cancel_async(dst, &copy->stateid);
-	kfree(copy);
-	return status;
+	if (!nfs42_files_from_same_server(src, dst))
+		nfs42_do_offload_cancel_async(src, src_stateid);
+	goto out_free;
 }
 
 static int process_copy_commit(struct file *dst, loff_t pos_dst,
-- 
1.8.3.1

