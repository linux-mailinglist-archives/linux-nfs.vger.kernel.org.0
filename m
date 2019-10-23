Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D231FE2740
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406360AbfJWX6V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39010 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404828AbfJWX6V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:21 -0400
Received: by mail-io1-f65.google.com with SMTP id y12so9639416ioa.6
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=x3qKv2XL6fhCyvFwJljuqovgKRE53a58X4jjdOhqd/M=;
        b=WidDz8oK1mb4Z9dNQM2xI/Na4YJGdgwbH7vrPUOjrSqaOsIyqygL6eNVsYkbQPS4sY
         Psz02XLLWqcbokpXBs53nedchFQHWjVdnvgdUVkHs73HShp7JsU5pSpUAGkkjImnUnpm
         XvEBL4E6NYVNl6u8WrbVd7v94/L3Ag2x59jWb016sMgEwsxt3pBdlJzJEZ7BNf7k4Ldx
         TWEaQP7ZrmSRusAOUDQmn6rkJJ6cVo/msQ1OVCyTAxprKbHxkihgdBZN7Fd6NqNHCyV5
         AqE8Ysg+ujg+/DqRSPUpq8ShnH5iqoP8E2RUALrez5MOhivUfvThVhREJ0t4UR/ELWI7
         3JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3qKv2XL6fhCyvFwJljuqovgKRE53a58X4jjdOhqd/M=;
        b=tOF7KZ+lpMB1H5gNMjDRj0lAn+BoretnIlkHhgIjyru2eOBxDEPgu6e+pnkxP9TYP0
         ZhLgDMEBJxKPghJ3/WyDSmz0w2iKO2wYdx0Wj/72MAVVu44Aldkatf6Y9Pc49uUcSpUO
         kyRortE3MoDtVQiY2xVAd+Dh6KX/om2EXBWpvVhBeg1YixE91QK6J4g29oTQjfNp/qzn
         dXgpldV0Yvz+vl8ldjtekIcoI7Ea+OGxEQklkYuq0iLmK2M6tlEo4wIu3zDOzAXKw2tC
         dAY8e5eN7vfBYANezZh02uYKsnqtMjgUK+gxt/wSGxw/ggGYCf150s719X0U1QSLwtvL
         dnqg==
X-Gm-Message-State: APjAAAVNZhmhsbkXWCs401fKYw/65oADgfahua+K6WBrCCGnnPTLRd+p
        McKcmzI2sgEln9Dd4YIs8Drtp/k=
X-Google-Smtp-Source: APXvYqz0AWkPWN1xI05MQkX9AIP7zvn9oqMFgwnWi6w5SuvwExNj6Zc94zJmPjUQKZqVPgpSawq/Ug==
X-Received: by 2002:a6b:b458:: with SMTP id d85mr6302385iof.287.1571875099567;
        Wed, 23 Oct 2019 16:58:19 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:19 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 14/14] NFSv4: Fix races between open and delegreturn
Date:   Wed, 23 Oct 2019 19:56:00 -0400
Message-Id: <20191023235600.10880-15-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-14-trond.myklebust@hammerspace.com>
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
 <20191023235600.10880-11-trond.myklebust@hammerspace.com>
 <20191023235600.10880-12-trond.myklebust@hammerspace.com>
 <20191023235600.10880-13-trond.myklebust@hammerspace.com>
 <20191023235600.10880-14-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server returns the same delegation in an open that we just used
in a delegreturn, we need to ensure we don't apply that stateid if
the delegreturn has freed it on the server.
To do so, we ensure that we do not free the storage for the delegation
until either it is replaced by a new one, or we throw the inode out of
cache.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 00c6c343dced..db7cf480c108 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -218,7 +218,6 @@ static int nfs_do_return_delegation(struct inode *inode, struct nfs_delegation *
 				delegation->cred,
 				&delegation->stateid,
 				issync);
-	nfs_free_delegation(delegation);
 	return res;
 }
 
@@ -291,7 +290,6 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		spin_unlock(&delegation->lock);
 		return NULL;
 	}
-	set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 	list_del_rcu(&delegation->super_list);
 	delegation->inode = NULL;
 	rcu_assign_pointer(nfsi->delegation, NULL);
@@ -318,10 +316,12 @@ nfs_inode_detach_delegation(struct inode *inode)
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_delegation *delegation;
 
-	delegation = nfs_start_delegation_return(nfsi);
-	if (delegation == NULL)
-		return NULL;
-	return nfs_detach_delegation(nfsi, delegation, server);
+	rcu_read_lock();
+	delegation = rcu_dereference(nfsi->delegation);
+	if (delegation != NULL)
+		delegation = nfs_detach_delegation(nfsi, delegation, server);
+	rcu_read_unlock();
+	return delegation;
 }
 
 static void
@@ -420,8 +420,10 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	spin_unlock(&clp->cl_lock);
 	if (delegation != NULL)
 		nfs_free_delegation(delegation);
-	if (freeme != NULL)
+	if (freeme != NULL) {
 		nfs_do_return_delegation(inode, freeme, 0);
+		nfs_free_delegation(freeme);
+	}
 	return status;
 }
 
@@ -431,7 +433,6 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation *delegation, int issync)
 {
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
-	struct nfs_inode *nfsi = NFS_I(inode);
 	int err = 0;
 
 	if (delegation == NULL)
@@ -453,8 +454,6 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 		nfs_abort_delegation_return(delegation, clp);
 		goto out;
 	}
-	if (!nfs_detach_delegation(nfsi, delegation, NFS_SERVER(inode)))
-		goto out;
 
 	err = nfs_do_return_delegation(inode, delegation, issync);
 out:
@@ -597,6 +596,7 @@ void nfs_inode_evict_delegation(struct inode *inode)
 	if (delegation != NULL) {
 		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 		nfs_do_return_delegation(inode, delegation, 1);
+		nfs_free_delegation(delegation);
 	}
 }
 
@@ -744,10 +744,9 @@ static void nfs_mark_delegation_revoked(struct nfs_server *server,
 {
 	set_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
 	delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
-	nfs_mark_return_delegation(server, delegation);
 }
 
-static bool nfs_revoke_delegation(struct inode *inode,
+static void nfs_revoke_delegation(struct inode *inode,
 		const nfs4_stateid *stateid)
 {
 	struct nfs_delegation *delegation;
@@ -780,19 +779,12 @@ static bool nfs_revoke_delegation(struct inode *inode,
 	rcu_read_unlock();
 	if (ret)
 		nfs_inode_find_state_and_recover(inode, stateid);
-	return ret;
 }
 
 void nfs_remove_bad_delegation(struct inode *inode,
 		const nfs4_stateid *stateid)
 {
-	struct nfs_delegation *delegation;
-
-	if (!nfs_revoke_delegation(inode, stateid))
-		return;
-	delegation = nfs_inode_detach_delegation(inode);
-	if (delegation)
-		nfs_free_delegation(delegation);
+	nfs_revoke_delegation(inode, stateid);
 }
 EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
 
@@ -816,7 +808,7 @@ void nfs_delegation_mark_returned(struct inode *inode,
 	    nfs4_stateid_is_newer(&delegation->stateid, stateid))
 		goto out_clear_returning;
 
-	set_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
+	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-- 
2.21.0

