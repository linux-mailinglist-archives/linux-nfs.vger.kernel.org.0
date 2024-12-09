Return-Path: <linux-nfs+bounces-8441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B27F9E88BC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 01:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CE31884DD6
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 00:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDAA5234;
	Mon,  9 Dec 2024 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="STydgNR7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mZXu1huM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="STydgNR7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mZXu1huM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE3BE6C
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705027; cv=none; b=IaAVBn92inMOk/n2ZWdyuY+JwMIlHGnEDsEVzfThrGo3UjQeYoq2d3o2Wis2UNapyqePizYP8K4XvXOHi3zKhjYt3waPvV79xQzqgCDUv6n0LynlcDs0TuYapMU5ErJlvQcUchg1MxLjS9mlTb+0Q0un336sCKJxOs6P8AYNhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705027; c=relaxed/simple;
	bh=hw44rTC63nKatCi0McEOY1YBuweDH468cii7h0urG4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hk9l0SvIYcwKb0ID/oPnU1bA+MVgMzTZ/0t1Bba7si04HXRc+hUSeCX1z7eC2tyVj3DY2axAg0AG0MHFybtM0tvUfMfkD8F/aXpCEy+81wgjHpCF/PQXI04+MHhXwTgSqOnba+Ce141xiRC4q1CZ++el8/AX9tlBlB+sZdTHcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=STydgNR7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mZXu1huM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=STydgNR7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mZXu1huM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8323F21137;
	Mon,  9 Dec 2024 00:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733705023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxFA/loh56UbwpVLXTTx8KHa+x0VqE7B5Br+6MNZv+8=;
	b=STydgNR7HcWGuiA1y2BHmc1yI7HClQZZYKDNNW86f63qN6uYrOH9utwygnFItzPisuzoNf
	f4Vobzj6LFp6CAdJ4HLETkZaqM3IbITyri/HgqiOnd1754tOpOdfe3A8CiIca/kODPZSmO
	OFu5r1xDoy35oSAFqvVpqId7emLW8qA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733705023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxFA/loh56UbwpVLXTTx8KHa+x0VqE7B5Br+6MNZv+8=;
	b=mZXu1huMEFko59VxKI3YJBa44SbiqOkV1SLU5LJ332uXTh1bX9oBeUvDcX2tABvlMS982v
	RMC6dlzY6Zi/imAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=STydgNR7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mZXu1huM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733705023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxFA/loh56UbwpVLXTTx8KHa+x0VqE7B5Br+6MNZv+8=;
	b=STydgNR7HcWGuiA1y2BHmc1yI7HClQZZYKDNNW86f63qN6uYrOH9utwygnFItzPisuzoNf
	f4Vobzj6LFp6CAdJ4HLETkZaqM3IbITyri/HgqiOnd1754tOpOdfe3A8CiIca/kODPZSmO
	OFu5r1xDoy35oSAFqvVpqId7emLW8qA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733705023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxFA/loh56UbwpVLXTTx8KHa+x0VqE7B5Br+6MNZv+8=;
	b=mZXu1huMEFko59VxKI3YJBa44SbiqOkV1SLU5LJ332uXTh1bX9oBeUvDcX2tABvlMS982v
	RMC6dlzY6Zi/imAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58A66138A5;
	Mon,  9 Dec 2024 00:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M6bGAz09Vme9HQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 09 Dec 2024 00:43:41 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/2] sunrpc: remove all connection limit configuration
Date: Mon,  9 Dec 2024 11:41:27 +1100
Message-ID: <20241209004310.728309-3-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209004310.728309-1-neilb@suse.de>
References: <20241209004310.728309-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8323F21137
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Now that the connection limit only apply to unconfirmed connections,
there is no need to configure it.  So remove all the configuration and
fix the number of unconfirmed connections as always 64 - which is
now given a name: XPT_MAX_TMP_CONN

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c                  |  8 -------
 fs/nfsd/netns.h                 |  6 -----
 fs/nfsd/nfsctl.c                | 42 ---------------------------------
 fs/nfsd/nfssvc.c                |  5 ----
 include/linux/sunrpc/svc.h      |  4 ----
 include/linux/sunrpc/svc_xprt.h |  6 +++++
 net/sunrpc/svc_xprt.c           |  8 +------
 7 files changed, 7 insertions(+), 72 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 4ec22c2f2ea3..7ded57ec3a60 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -70,9 +70,6 @@ static unsigned long		nlm_grace_period;
 unsigned long			nlm_timeout = LOCKD_DFLT_TIMEO;
 static int			nlm_udpport, nlm_tcpport;
 
-/* RLIM_NOFILE defaults to 1024. That seems like a reasonable default here. */
-static unsigned int		nlm_max_connections = 1024;
-
 /*
  * Constants needed for the sysctl interface.
  */
@@ -136,9 +133,6 @@ lockd(void *vrqstp)
 	 * NFS mount or NFS daemon has gone away.
 	 */
 	while (!svc_thread_should_stop(rqstp)) {
-		/* update sv_maxconn if it has changed */
-		rqstp->rq_server->sv_maxconn = nlm_max_connections;
-
 		nlmsvc_retry_blocked(rqstp);
 		svc_recv(rqstp);
 	}
@@ -340,7 +334,6 @@ static int lockd_get(void)
 		return -ENOMEM;
 	}
 
-	serv->sv_maxconn = nlm_max_connections;
 	error = svc_set_num_threads(serv, NULL, 1);
 	if (error < 0) {
 		svc_destroy(&serv);
@@ -542,7 +535,6 @@ module_param_call(nlm_udpport, param_set_port, param_get_int,
 module_param_call(nlm_tcpport, param_set_port, param_get_int,
 		  &nlm_tcpport, 0644);
 module_param(nsm_use_hostnames, bool, 0644);
-module_param(nlm_max_connections, uint, 0644);
 
 static int lockd_init_net(struct net *net)
 {
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index a05a45bb1978..4a07b8d0837b 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -128,12 +128,6 @@ struct nfsd_net {
 	seqlock_t writeverf_lock;
 	unsigned char writeverf[8];
 
-	/*
-	 * Max number of non-validated connections this nfsd container
-	 * will allow.  Defaults to '0' gets mapped to 64.
-	 */
-	unsigned int max_connections;
-
 	u32 clientid_base;
 	u32 clientid_counter;
 	u32 clverifier_counter;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3adbc05ebaac..95ea4393305b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -48,7 +48,6 @@ enum {
 	NFSD_Versions,
 	NFSD_Ports,
 	NFSD_MaxBlkSize,
-	NFSD_MaxConnections,
 	NFSD_Filecache,
 	NFSD_Leasetime,
 	NFSD_Gracetime,
@@ -68,7 +67,6 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size);
 static ssize_t write_versions(struct file *file, char *buf, size_t size);
 static ssize_t write_ports(struct file *file, char *buf, size_t size);
 static ssize_t write_maxblksize(struct file *file, char *buf, size_t size);
-static ssize_t write_maxconn(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
 static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
 static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
@@ -87,7 +85,6 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 	[NFSD_Versions] = write_versions,
 	[NFSD_Ports] = write_ports,
 	[NFSD_MaxBlkSize] = write_maxblksize,
-	[NFSD_MaxConnections] = write_maxconn,
 #ifdef CONFIG_NFSD_V4
 	[NFSD_Leasetime] = write_leasetime,
 	[NFSD_Gracetime] = write_gracetime,
@@ -902,44 +899,6 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 							nfsd_max_blksize);
 }
 
-/*
- * write_maxconn - Set or report the current max number of connections
- *
- * Input:
- *			buf:		ignored
- *			size:		zero
- * OR
- *
- * Input:
- *			buf:		C string containing an unsigned
- *					integer value representing the new
- *					number of max connections
- *			size:		non-zero length of C string in @buf
- * Output:
- *	On success:	passed-in buffer filled with '\n'-terminated C string
- *			containing numeric value of max_connections setting
- *			for this net namespace;
- *			return code is the size in bytes of the string
- *	On error:	return code is zero or a negative errno value
- */
-static ssize_t write_maxconn(struct file *file, char *buf, size_t size)
-{
-	char *mesg = buf;
-	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
-	unsigned int maxconn = nn->max_connections;
-
-	if (size > 0) {
-		int rv = get_uint(&mesg, &maxconn);
-
-		if (rv)
-			return rv;
-		trace_nfsd_ctl_maxconn(netns(file), maxconn);
-		nn->max_connections = maxconn;
-	}
-
-	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxconn);
-}
-
 #ifdef CONFIG_NFSD_V4
 static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 				  time64_t *time, struct nfsd_net *nn)
@@ -1372,7 +1331,6 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_Versions] = {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
-		[NFSD_MaxConnections] = {"max_connections", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 49e2f32102ab..b77097de5936 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -668,7 +668,6 @@ int nfsd_create_serv(struct net *net)
 	if (serv == NULL)
 		return -ENOMEM;
 
-	serv->sv_maxconn = nn->max_connections;
 	error = svc_bind(serv, net);
 	if (error < 0) {
 		svc_destroy(&serv);
@@ -954,11 +953,7 @@ nfsd(void *vrqstp)
 	 * The main request loop
 	 */
 	while (!svc_thread_should_stop(rqstp)) {
-		/* Update sv_maxconn if it has changed */
-		rqstp->rq_server->sv_maxconn = nn->max_connections;
-
 		svc_recv(rqstp);
-
 		nfsd_file_net_dispose(nn);
 	}
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 617ebfff2f30..9d288a673705 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -72,10 +72,6 @@ struct svc_serv {
 	spinlock_t		sv_lock;
 	unsigned int		sv_nprogs;	/* Number of sv_programs */
 	unsigned int		sv_nrthreads;	/* # of server threads */
-	unsigned int		sv_maxconn;	/* max connections allowed or
-						 * '0' causing max to be based
-						 * on number of threads. */
-
 	unsigned int		sv_max_payload;	/* datagram payload size */
 	unsigned int		sv_max_mesg;	/* max_payload + 1 page for overheads */
 	unsigned int		sv_xdrsize;	/* XDR buffer size */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 35929a7727c7..114051ad985a 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -105,6 +105,12 @@ enum {
 				 */
 };
 
+/*
+ * Maximum number of "tmp" connections - those without XPT_PEER_VALID -
+ * permitted on any service.
+ */
+#define XPT_MAX_TMP_CONN	64
+
 static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
 {
 	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ff5b8bb8a88f..070bdeb50496 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -619,16 +619,10 @@ int svc_port_is_privileged(struct sockaddr *sin)
  * The only somewhat efficient mechanism would be if drop old
  * connections from the same IP first. But right now we don't even
  * record the client IP in svc_sock.
- *
- * single-threaded services that expect a lot of clients will probably
- * need to set sv_maxconn to override the default value which is based
- * on the number of threads
  */
 static void svc_check_conn_limits(struct svc_serv *serv)
 {
-	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn : 64;
-
-	if (serv->sv_tmpcnt > limit) {
+	if (serv->sv_tmpcnt > XPT_MAX_TMP_CONN) {
 		struct svc_xprt *xprt = NULL, *xprti;
 		spin_lock_bh(&serv->sv_lock);
 		if (!list_empty(&serv->sv_tempsocks)) {
-- 
2.47.0


