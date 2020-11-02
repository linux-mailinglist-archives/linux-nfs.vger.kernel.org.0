Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C302A2C12
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKBNvf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbgKBNuS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=olmwqf6JsIgz86urssgtccQehcjB82mMIquC/xJmX1Y=;
        b=gvWG2sryCvamBT0g7sjsIHxTMcgs1Vo+tsT7YqGG5dNynkvVwYhHD70v/QgkW+hs1RgF4o
        weMLaCNX+JKNJ+GO+KGP8o+aLG05Gg7nnsC7kIPm3snsERPQajAeaCerqu4oZAV4mej+Qj
        Sp4Mbpi5nUAFET+9GVzY+SWpUS48X4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-KvOOZk7QOyOIQAxgZRGY8A-1; Mon, 02 Nov 2020 08:50:15 -0500
X-MC-Unique: KvOOZk7QOyOIQAxgZRGY8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72063805F12;
        Mon,  2 Nov 2020 13:50:14 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 070DB5DA6B;
        Mon,  2 Nov 2020 13:50:13 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/11] NFSv4: Improve nfs4_readdir tracepoint by adding additional fields
Date:   Mon,  2 Nov 2020 08:50:01 -0500
Message-Id: <1604325011-29427-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When tracing NFSv4 readdir there are fields beyond the inode based
information that are useful, such as the cookie, count, and whether
readdirplus is enabled.  Add these fields to the nfs4_readdir
tracepoint which executes after a NFS4 readdir completes.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/nfs4proc.c  |  2 +-
 fs/nfs/nfs4trace.h | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6e95c85fe395..4f324ad5c5b0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4983,7 +4983,7 @@ static int nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 	do {
 		err = _nfs4_proc_readdir(dentry, cred, cookie,
 				pages, count, plus);
-		trace_nfs4_readdir(d_inode(dentry), err);
+		trace_nfs4_readdir(d_inode(dentry), cookie, count, plus, err);
 		err = nfs4_handle_exception(NFS_SERVER(d_inode(dentry)), err,
 				&exception);
 	} while (exception.retry);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index b4f852d4d099..c62e46451b16 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1449,9 +1449,51 @@
 
 DEFINE_NFS4_INODE_EVENT(nfs4_access);
 DEFINE_NFS4_INODE_EVENT(nfs4_readlink);
-DEFINE_NFS4_INODE_EVENT(nfs4_readdir);
 DEFINE_NFS4_INODE_EVENT(nfs4_get_acl);
 DEFINE_NFS4_INODE_EVENT(nfs4_set_acl);
+
+TRACE_EVENT(nfs4_readdir,
+		TP_PROTO(
+			const struct inode *inode,
+			u64 cookie,
+			unsigned int count,
+			bool plus,
+			int error
+		),
+
+		TP_ARGS(inode, cookie, count, plus, error),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(unsigned long, error)
+			__field(u64, cookie)
+			__field(u64, count)
+			__field(bool, plus)
+		),
+
+		TP_fast_assign(
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->error = error < 0 ? -error : 0;
+			__entry->cookie = cookie;
+			__entry->count = count;
+			__entry->plus = plus;
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x cookie=0x%08llx count=%llu plus=%s",
+			-__entry->error,
+			show_nfsv4_errors(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->cookie,
+			__entry->count, __entry->plus ? "true" : "false"
+		)
+);
+
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 DEFINE_NFS4_INODE_EVENT(nfs4_get_security_label);
 DEFINE_NFS4_INODE_EVENT(nfs4_set_security_label);
-- 
1.8.3.1

