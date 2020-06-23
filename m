Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92CE20675F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbgFWWoS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:18 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16532 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbgFWWoN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952251; x=1624488251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hWwqkmg5TS22zrjQw5GWVcZs5I/yvry3fcfLlo3Po2Y=;
  b=UTF7JxUMaS8RB9MDyn2EHk5DXRrQ6WEfn3qKGh2DV/9bwWRSwgOyyIt5
   RneZPYWifccyLs5PdoqKF4a8SlgyTEnayZC5Gycq8Kd9pTAp5sSB/roDY
   Esq+bfL3OK/1ntzmtvkIwUfockJGtFouvQ81dJ7ob6fIk7kuSL3eElGtd
   A=;
IronPort-SDR: pykjIhzbYpona4GZlveIWKYYhuBwCyFooKTKpJ/En5UdTuJK9OQvs/8mWaz/ImIqeLELYvvq3H
 PnJ14GwJK5tg==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="39410333"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id B1830A2005;
        Tue, 23 Jun 2020 22:39:06 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:05 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id D846CCD365; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 11/13] NFSv4.2: add the extended attribute proc functions.
Date:   Tue, 23 Jun 2020 22:39:02 +0000
Message-ID: <20200623223904.31643-12-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Implement the extended attribute procedures for NFSv4.2 extended
attribute support (RFC 8276).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42.h     |   8 ++
 fs/nfs/nfs42proc.c | 236 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 51de8ddc7d88..0fe5aacbcfdf 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -39,6 +39,14 @@ static inline bool nfs42_files_from_same_server(struct file *in,
 					       c_out->cl_serverowner);
 }
 
+ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
+			    void *buf, size_t buflen);
+int nfs42_proc_setxattr(struct inode *inode, const char *name,
+			const void *buf, size_t buflen, int flags);
+ssize_t nfs42_proc_listxattrs(struct inode *inode, void *buf,
+			       size_t buflen, u64 *cookiep, bool *eofp);
+int nfs42_proc_removexattr(struct inode *inode, const char *name);
+
 /*
  * Maximum XDR buffer size needed for a listxattr buffer of buflen size.
  *
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index e2ae54b35dfe..8c2e52bc986a 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1088,3 +1088,239 @@ int nfs42_proc_clone(struct file *src_f, struct file *dst_f,
 	nfs_put_lock_context(src_lock);
 	return err;
 }
+
+#define NFS4XATTR_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE)
+
+static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs42_removexattrargs args = {
+		.fh = NFS_FH(inode),
+		.xattr_name = name,
+	};
+	struct nfs42_removexattrres res;
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVEXATTR],
+		.rpc_argp = &args,
+		.rpc_resp = &res,
+	};
+	int ret;
+	unsigned long timestamp = jiffies;
+
+	ret = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
+	    &res.seq_res, 1);
+	if (!ret)
+		nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
+
+	return ret;
+}
+
+static int _nfs42_proc_setxattr(struct inode *inode, const char *name,
+				const void *buf, size_t buflen, int flags)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct page *pages[NFS4XATTR_MAXPAGES];
+	struct nfs42_setxattrargs arg = {
+		.fh		= NFS_FH(inode),
+		.xattr_pages	= pages,
+		.xattr_len	= buflen,
+		.xattr_name	= name,
+		.xattr_flags	= flags,
+	};
+	struct nfs42_setxattrres res;
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_SETXATTR],
+		.rpc_argp	= &arg,
+		.rpc_resp	= &res,
+	};
+	int ret, np;
+	unsigned long timestamp = jiffies;
+
+	if (buflen > server->sxasize)
+		return -ERANGE;
+
+	if (buflen > 0) {
+		np = nfs4_buf_to_pages_noslab(buf, buflen, arg.xattr_pages);
+		if (np < 0)
+			return np;
+	} else
+		np = 0;
+
+	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
+	    &res.seq_res, 1);
+
+	for (; np > 0; np--)
+		put_page(pages[np - 1]);
+
+	if (!ret)
+		nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
+
+	return ret;
+}
+
+static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
+				void *buf, size_t buflen)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct page *pages[NFS4XATTR_MAXPAGES] = {};
+	struct nfs42_getxattrargs arg = {
+		.fh		= NFS_FH(inode),
+		.xattr_pages	= pages,
+		.xattr_len	= buflen,
+		.xattr_name	= name,
+	};
+	struct nfs42_getxattrres res;
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_GETXATTR],
+		.rpc_argp	= &arg,
+		.rpc_resp	= &res,
+	};
+	int ret, np;
+
+	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
+	    &res.seq_res, 0);
+	if (ret < 0)
+		return ret;
+
+	if (buflen) {
+		if (res.xattr_len > buflen)
+			return -ERANGE;
+		_copy_from_pages(buf, pages, 0, res.xattr_len);
+	}
+
+	np = DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
+	while (--np >= 0)
+		__free_page(pages[np]);
+
+	return res.xattr_len;
+}
+
+static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
+				 size_t buflen, u64 *cookiep, bool *eofp)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct page **pages;
+	struct nfs42_listxattrsargs arg = {
+		.fh		= NFS_FH(inode),
+		.cookie		= *cookiep,
+	};
+	struct nfs42_listxattrsres res = {
+		.eof = false,
+		.xattr_buf = buf,
+		.xattr_len = buflen,
+	};
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_LISTXATTRS],
+		.rpc_argp	= &arg,
+		.rpc_resp	= &res,
+	};
+	u32 xdrlen;
+	int ret, np;
+
+
+	res.scratch = alloc_page(GFP_KERNEL);
+	if (!res.scratch)
+		return -ENOMEM;
+
+	xdrlen = nfs42_listxattr_xdrsize(buflen);
+	if (xdrlen > server->lxasize)
+		xdrlen = server->lxasize;
+	np = xdrlen / PAGE_SIZE + 1;
+
+	pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
+	if (pages == NULL) {
+		__free_page(res.scratch);
+		return -ENOMEM;
+	}
+
+	arg.xattr_pages = pages;
+	arg.count = xdrlen;
+
+	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
+	    &res.seq_res, 0);
+
+	if (ret >= 0) {
+		ret = res.copied;
+		*cookiep = res.cookie;
+		*eofp = res.eof;
+	}
+
+	while (--np >= 0) {
+		if (pages[np])
+			__free_page(pages[np]);
+	}
+
+	__free_page(res.scratch);
+	kfree(pages);
+
+	return ret;
+
+}
+
+ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
+			      void *buf, size_t buflen)
+{
+	struct nfs4_exception exception = { };
+	ssize_t err;
+
+	do {
+		err = _nfs42_proc_getxattr(inode, name, buf, buflen);
+		if (err >= 0)
+			break;
+		err = nfs4_handle_exception(NFS_SERVER(inode), err,
+				&exception);
+	} while (exception.retry);
+
+	return err;
+}
+
+int nfs42_proc_setxattr(struct inode *inode, const char *name,
+			      const void *buf, size_t buflen, int flags)
+{
+	struct nfs4_exception exception = { };
+	int err;
+
+	do {
+		err = _nfs42_proc_setxattr(inode, name, buf, buflen, flags);
+		if (!err)
+			break;
+		err = nfs4_handle_exception(NFS_SERVER(inode), err,
+				&exception);
+	} while (exception.retry);
+
+	return err;
+}
+
+ssize_t nfs42_proc_listxattrs(struct inode *inode, void *buf,
+			      size_t buflen, u64 *cookiep, bool *eofp)
+{
+	struct nfs4_exception exception = { };
+	ssize_t err;
+
+	do {
+		err = _nfs42_proc_listxattrs(inode, buf, buflen,
+		    cookiep, eofp);
+		if (err >= 0)
+			break;
+		err = nfs4_handle_exception(NFS_SERVER(inode), err,
+				&exception);
+	} while (exception.retry);
+
+	return err;
+}
+
+int nfs42_proc_removexattr(struct inode *inode, const char *name)
+{
+	struct nfs4_exception exception = { };
+	int err;
+
+	do {
+		err = _nfs42_proc_removexattr(inode, name);
+		if (!err)
+			break;
+		err = nfs4_handle_exception(NFS_SERVER(inode), err,
+				&exception);
+	} while (exception.retry);
+
+	return err;
+}
-- 
2.17.2

