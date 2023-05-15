Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C280A702E38
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbjEONfz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbjEONfy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF719E69
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C601617FB
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A469C433D2;
        Mon, 15 May 2023 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157751;
        bh=2Wm3sgCuUscXz37QuEVDHUIcojYICj8WIschUf1pB40=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KAF2G7Yxn3u+krCv+QdnIYnflDLi9SYKCgdcWeTqb/Fdmzf5rDAhKyA5XrEiabnzz
         7YnuL2BRvmjuiPUYBTGcVbB0y8Plsgjd0GwgYPelB/H95Kqnb+bTxeoPyjA55xH6id
         VU+ovxCncEVSactysFHdGrmJ4rqTASP9L22f9E2Dn6SmY2H5z88A26gYEk1hysWqrz
         m4KiuVC+T/NDaXxTlTkcn0vetPgc8cESQYzUj/9kD/V5sAvBbGcToHDj/H15C6f/gh
         aqeB9vJBI/uUDf+H0PK1j3y0fGn3oEbqJ1H5zOZkrqJC/f6h6NCglbgBWZKdAtZ8bd
         pmuzPeD+NfTsQ==
Subject: [PATCH 3/3] NFSD: trace nfsctl operations
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:35:50 -0400
Message-ID: <168415775071.9589.10272896146949604302.stgit@manet.1015granger.net>
In-Reply-To: <168415762168.9589.16821927887100606727.stgit@manet.1015granger.net>
References: <168415762168.9589.16821927887100606727.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Add trace log eye-catchers that record the arguments used to
configure NFSD. This helps when troubleshooting the NFSD
administrative interfaces.

These tracepoints can capture NFSD start-up and shutdown times and
parameters, changes in lease time and thread count, and a request
to end the namespace's NFSv4 grace period, in addition to the set
of NFS versions that are enabled.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |   33 +++++--
 fs/nfsd/trace.h  |  259 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8e69a5c46a4c..724a5ec0939e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -25,6 +25,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "trace.h"
 
 /*
  *	We have a single directory with several nodes in it.
@@ -242,6 +243,7 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 	if (rpc_pton(net, fo_path, size, sap, salen) == 0)
 		return -EINVAL;
 
+	trace_nfsd_ctl_unlock_ip(net, buf);
 	return nlmsvc_unlock_all_by_ip(sap);
 }
 
@@ -275,7 +277,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	fo_path = buf;
 	if (qword_get(&buf, fo_path, size) < 0)
 		return -EINVAL;
-
+	trace_nfsd_ctl_unlock_fs(netns(file), fo_path);
 	error = kern_path(fo_path, 0, &path);
 	if (error)
 		return error;
@@ -353,6 +355,8 @@ static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
 	if (qword_get(&mesg, mesg, size) > 0)
 		return -EINVAL;
 
+	trace_nfsd_ctl_filehandle(netns(file), dname, path, maxsize);
+
 	/* we have all the words, they are in buf.. */
 	dom = unix_domain_find(dname);
 	if (!dom)
@@ -411,6 +415,7 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 			return rv;
 		if (newthreads < 0)
 			return -EINVAL;
+		trace_nfsd_ctl_threads(net, newthreads);
 		rv = nfsd_svc(newthreads, net, file->f_cred);
 		if (rv < 0)
 			return rv;
@@ -483,6 +488,7 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 			rv = -EINVAL;
 			if (nthreads[i] < 0)
 				goto out_free;
+			trace_nfsd_ctl_pool_threads(net, i, nthreads[i]);
 		}
 		rv = nfsd_set_nrthreads(i, nthreads, net);
 		if (rv)
@@ -548,6 +554,7 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 		if (buf[size-1] != '\n')
 			return -EINVAL;
 		buf[size-1] = 0;
+		trace_nfsd_ctl_version(netns(file), buf);
 
 		vers = mesg;
 		len = qword_get(&mesg, vers, size);
@@ -701,6 +708,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	err = get_int(&mesg, &fd);
 	if (err != 0 || fd < 0)
 		return -EINVAL;
+	trace_nfsd_ctl_ports_addfd(net, fd);
 
 	if (svc_alien_sock(net, fd)) {
 		printk(KERN_ERR "%s: socket net is different to NFSd's one\n", __func__);
@@ -737,6 +745,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 
 	if (port < 1 || port > USHRT_MAX)
 		return -EINVAL;
+	trace_nfsd_ctl_ports_addxprt(net, transport, port);
 
 	err = nfsd_create_serv(net);
 	if (err != 0)
@@ -870,6 +879,8 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 		int rv = get_int(&mesg, &bsize);
 		if (rv)
 			return rv;
+		trace_nfsd_ctl_maxblksize(netns(file), bsize);
+
 		/* force bsize into allowed range and
 		 * required alignment.
 		 */
@@ -920,6 +931,7 @@ static ssize_t write_maxconn(struct file *file, char *buf, size_t size)
 
 		if (rv)
 			return rv;
+		trace_nfsd_ctl_maxconn(netns(file), maxconn);
 		nn->max_connections = maxconn;
 	}
 
@@ -930,6 +942,7 @@ static ssize_t write_maxconn(struct file *file, char *buf, size_t size)
 static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 				  time64_t *time, struct nfsd_net *nn)
 {
+	struct dentry *dentry = file_dentry(file);
 	char *mesg = buf;
 	int rv, i;
 
@@ -939,6 +952,9 @@ static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 		rv = get_int(&mesg, &i);
 		if (rv)
 			return rv;
+		trace_nfsd_ctl_time(netns(file), dentry->d_name.name,
+				    dentry->d_name.len, i);
+
 		/*
 		 * Some sanity checking.  We don't have a reason for
 		 * these particular numbers, but problems with the
@@ -1031,6 +1047,7 @@ static ssize_t __write_recoverydir(struct file *file, char *buf, size_t size,
 		len = qword_get(&mesg, recdir, size);
 		if (len <= 0)
 			return -EINVAL;
+		trace_nfsd_ctl_recoverydir(netns(file), recdir);
 
 		status = nfs4_reset_recoverydir(recdir);
 		if (status)
@@ -1104,7 +1121,7 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 		case '1':
 			if (!nn->nfsd_serv)
 				return -EBUSY;
-			nfsd4_end_grace(nn);
+			trace_nfsd_end_grace(netns(file));
 			break;
 		default:
 			return -EINVAL;
@@ -1209,8 +1226,8 @@ static int __nfsd_symlink(struct inode *dir, struct dentry *dentry,
  * @content is assumed to be a NUL-terminated string that lives
  * longer than the symlink itself.
  */
-static void nfsd_symlink(struct dentry *parent, const char *name,
-			 const char *content)
+static void _nfsd_symlink(struct dentry *parent, const char *name,
+			  const char *content)
 {
 	struct inode *dir = parent->d_inode;
 	struct dentry *dentry;
@@ -1227,8 +1244,8 @@ static void nfsd_symlink(struct dentry *parent, const char *name,
 	inode_unlock(dir);
 }
 #else
-static inline void nfsd_symlink(struct dentry *parent, const char *name,
-				const char *content)
+static inline void _nfsd_symlink(struct dentry *parent, const char *name,
+				 const char *content)
 {
 }
 
@@ -1406,8 +1423,8 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 	ret = simple_fill_super(sb, 0x6e667364, nfsd_files);
 	if (ret)
 		return ret;
-	nfsd_symlink(sb->s_root, "supported_krb5_enctypes",
-		     "/proc/net/rpc/gss_krb5_enctypes");
+	_nfsd_symlink(sb->s_root, "supported_krb5_enctypes",
+		      "/proc/net/rpc/gss_krb5_enctypes");
 	dentry = nfsd_mkdir(sb->s_root, NULL, "clients");
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4183819ea082..0260ccb734a3 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1581,6 +1581,265 @@ TRACE_EVENT(nfsd_cb_recall_any_done,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_unlock_ip,
+	TP_PROTO(
+		const struct net *net,
+		const char *address
+	),
+	TP_ARGS(net, address),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__string(address, address)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__assign_str(address, address);
+	),
+	TP_printk("address=%s",
+		__get_str(address)
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_unlock_fs,
+	TP_PROTO(
+		const struct net *net,
+		const char *path
+	),
+	TP_ARGS(net, path),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__string(path, path)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__assign_str(path, path);
+	),
+	TP_printk("path=%s",
+		__get_str(path)
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_filehandle,
+	TP_PROTO(
+		const struct net *net,
+		const char *domain,
+		const char *path,
+		int maxsize
+	),
+	TP_ARGS(net, domain, path, maxsize),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, maxsize)
+		__string(domain, domain)
+		__string(path, path)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->maxsize = maxsize;
+		__assign_str(domain, domain);
+		__assign_str(path, path);
+	),
+	TP_printk("domain=%s path=%s maxsize=%d",
+		__get_str(domain), __get_str(path), __entry->maxsize
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_threads,
+	TP_PROTO(
+		const struct net *net,
+		int newthreads
+	),
+	TP_ARGS(net, newthreads),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, newthreads)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->newthreads = newthreads;
+	),
+	TP_printk("newthreads=%d",
+		__entry->newthreads
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_pool_threads,
+	TP_PROTO(
+		const struct net *net,
+		int pool,
+		int nrthreads
+	),
+	TP_ARGS(net, pool, nrthreads),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, pool)
+		__field(int, nrthreads)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->pool = pool;
+		__entry->nrthreads = nrthreads;
+	),
+	TP_printk("pool=%d nrthreads=%d",
+		__entry->pool, __entry->nrthreads
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_version,
+	TP_PROTO(
+		const struct net *net,
+		const char *mesg
+	),
+	TP_ARGS(net, mesg),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__string(mesg, mesg)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__assign_str(mesg, mesg);
+	),
+	TP_printk("%s",
+		__get_str(mesg)
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_ports_addfd,
+	TP_PROTO(
+		const struct net *net,
+		int fd
+	),
+	TP_ARGS(net, fd),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, fd)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->fd = fd;
+	),
+	TP_printk("fd=%d",
+		__entry->fd
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_ports_addxprt,
+	TP_PROTO(
+		const struct net *net,
+		const char *transport,
+		int port
+	),
+	TP_ARGS(net, transport, port),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, port)
+		__string(transport, transport)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->port = port;
+		__assign_str(transport, transport);
+	),
+	TP_printk("transport=%s port=%d",
+		__get_str(transport), __entry->port
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_maxblksize,
+	TP_PROTO(
+		const struct net *net,
+		int bsize
+	),
+	TP_ARGS(net, bsize),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, bsize)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->bsize = bsize;
+	),
+	TP_printk("bsize=%d",
+		__entry->bsize
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_maxconn,
+	TP_PROTO(
+		const struct net *net,
+		int maxconn
+	),
+	TP_ARGS(net, maxconn),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, maxconn)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->maxconn = maxconn;
+	),
+	TP_printk("maxconn=%d",
+		__entry->maxconn
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_time,
+	TP_PROTO(
+		const struct net *net,
+		const char *name,
+		size_t namelen,
+		int time
+	),
+	TP_ARGS(net, name, namelen, time),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, time)
+		__string_len(name, name, namelen)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->time = time;
+		__assign_str_len(name, name, namelen);
+	),
+	TP_printk("file=%s time=%d\n",
+		__get_str(name), __entry->time
+	)
+);
+
+TRACE_EVENT(nfsd_ctl_recoverydir,
+	TP_PROTO(
+		const struct net *net,
+		const char *recdir
+	),
+	TP_ARGS(net, recdir),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__string(recdir, recdir)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__assign_str(recdir, recdir);
+	),
+	TP_printk("recdir=%s",
+		__get_str(recdir)
+	)
+);
+
+TRACE_EVENT(nfsd_end_grace,
+	TP_PROTO(
+		const struct net *net
+	),
+	TP_ARGS(net),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+	),
+	TP_printk("nn=%d", __entry->netns_ino
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


