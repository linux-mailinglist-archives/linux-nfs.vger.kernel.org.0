Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A319343D
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCYXK6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:10:58 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:53577 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgCYXK6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177858; x=1616713858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hWwqkmg5TS22zrjQw5GWVcZs5I/yvry3fcfLlo3Po2Y=;
  b=NRauHevOiKbs5pjTKmYak/BQpHa1mo03+yOw1TQl+Xk9Xc4nYDz9X5dc
   Di7kJeo2ZqQICF3kGaJ166DSohMXgOdWA8Ha2uLE2EdfwMN274+GT958u
   cnuZosh5Sqoyk05Jwii21n3dSpJYWmwBm9pyGar+nT3DkcBZhA/b5NvnE
   Y=;
IronPort-SDR: jXJdFwYwgQ5JffdMt4JzRoSiHBlOWjNEJHObNhsF6dMOMCb22W5hzoccUXBGidTcHHfn4lVwRl
 t0r0Sf9NpLsQ==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="33468193"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Mar 2020 23:10:54 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id BA137A205E;
        Wed, 25 Mar 2020 23:10:52 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:52 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:51 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 6D656D92C9; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 11/13] NFSv4.2: add the extended attribute proc functions.
Date:   Wed, 25 Mar 2020 23:10:49 +0000
Message-ID: <20200325231051.31652-12-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200325231051.31652-1-fllinden@amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
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

