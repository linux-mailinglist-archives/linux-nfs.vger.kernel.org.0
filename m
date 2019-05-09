Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0972818929
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2019 13:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEILhx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 May 2019 07:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfEILhx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 May 2019 07:37:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D7FF307EA8F;
        Thu,  9 May 2019 11:37:53 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-112-5.rdu2.redhat.com [10.10.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62CEA1001E6D;
        Thu,  9 May 2019 11:37:51 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     anna.schumaker@netapp.com
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, trond.myklebust@hammerspace.com,
        "Roberto Bergantinos Corpas" <rbergant@redhat.com>,
        syzbot <syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com>
Subject: Re: WARNING: locking bug in nfs_get_client
Date:   Thu, 09 May 2019 07:37:50 -0400
Message-ID: <FE8462BD-2B07-4AC1-A739-E3D429DDA134@redhat.com>
In-Reply-To: <C6C33F7F-8CD2-4E0F-82BA-5443133FBB54@redhat.com>
References: <000000000000c3e9dc0588695e22@google.com>
 <C6C33F7F-8CD2-4E0F-82BA-5443133FBB54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 09 May 2019 11:37:53 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I think nfs_get_client and nfs_match_client could use a refactor.. but 
the
trivial fix is:

8<---------------------------------

 From 4ef2fc5912c5980890e781f8c0d941330254c100 Mon Sep 17 00:00:00 2001
Message-Id: 
<4ef2fc5912c5980890e781f8c0d941330254c100.1557401467.git.bcodding@redhat.com>
 From: Benjamin Coddington <bcodding@redhat.com>
Date: Thu, 9 May 2019 07:25:21 -0400
Subject: [PATCH] NFS: Fix a double unlock from nfs_match,get_client

Now that nfs_match_client drops the nfs_client_lock, we should be 
careful
to always return it in the same condition: locked.

Fixes: 950a578c6128 ("NFS: make nfs_match_client killable")
Reported-by: syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
  fs/nfs/client.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 06e8719655f0..da74c4c4a244 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -299,9 +299,9 @@ static struct nfs_client *nfs_match_client(const 
struct nfs_client_initdata *dat
  			spin_unlock(&nn->nfs_client_lock);
  			error = nfs_wait_client_init_complete(clp);
  			nfs_put_client(clp);
+			spin_lock(&nn->nfs_client_lock);
  			if (error < 0)
  				return ERR_PTR(error);
-			spin_lock(&nn->nfs_client_lock);
  			goto again;
  		}

-- 
2.20.1
