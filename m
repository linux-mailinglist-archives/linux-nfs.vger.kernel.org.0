Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415D52FF3F3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbhAUTMW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbhAUTLQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 14:11:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FBC06178A
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:29 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e15so2453883wme.0
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOugOCRo/rGPTtDDqtGndDinPnamB/mLfwUTnqd7MYE=;
        b=MwIJLVaAcg32N9wmnf0aWV1gd/K8E1Rt+EBEpbjHM3lSPd0ECBNNeL8tatfoAZBUha
         yS3lJNRAeSy7tUXzCweMlh2JqB8VgWEavNT1J/NXLB0kicaDdwpR8JRxiEPtj6T5OvtY
         8Liynh/Slh3IfrFLks1TUzSRfwZrdS8r9Hhg6GjV9BtGfglozQiQVpDZIDQYh2Nyny7q
         vjenQOGNl3fF+o+fpHsCWzyRXrWl7gr7UrCNP0di2YwTBFYZ1tXPa3jNgbX7pRak8tVZ
         HtIItMptycKuWUbE5rb2cfb7obo9Urr2dhVZ8xCEq9Hoavf1lK2Kv4P37VYjO0Odgj86
         ckQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOugOCRo/rGPTtDDqtGndDinPnamB/mLfwUTnqd7MYE=;
        b=P/bsNXzh3GAOMyDzAXx3FHj+EVmVqw/17Sy8sqburkbVmcSdQpjdjsTjXNDm9YPya4
         YQxxScN5N5Jj9wY7d7zVd1UJYbewmm3rI768hS+PpmFijLUm81ark1ocbqvLxEBTRoKV
         O0euuKOCQWkYRHk9tui7NvtW7/JT4Dr7dOO7w/cRXtBEUqDLJ/j3+tQeu0jRYJCEX/UZ
         WDM7eEPx8HnLOviLGxogfkQ6sZ+z1sRvnIh91d80yYKLoDd8xGywrOSsUx+titL9VKhC
         i1zsziOq/B6dIqNidzASc2xWI6XJQpXY95YIWSR4lLch4em9anm2o4tQmcpgYDYgvR3x
         JEZg==
X-Gm-Message-State: AOAM5304ugIX2HSSzYYqAPPmJZctMYWKf6ypUZ8t5/VhG4reogXalaeH
        ZiWWJJqjgJ4fbu6KpgoB3AhWYCGx+QQyUbEu
X-Google-Smtp-Source: ABdhPJzoX5D6H4Kf+bJOANmQfHnE/d6E8+6Owe5Kj95tkUPwQboa7IusXrtwz71d1a/4wpNfg4FXDQ==
X-Received: by 2002:a1c:5608:: with SMTP id k8mr713650wmb.91.1611256227640;
        Thu, 21 Jan 2021 11:10:27 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id d30sm11160353wrc.92.2021.01.21.11.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:10:26 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH v1 3/5] nfs: Extend nconnect with remoteports and localports mount params
Date:   Thu, 21 Jan 2021 21:10:18 +0200
Message-Id: <20210121191020.3144948-4-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121191020.3144948-1-dan@kernelim.com>
References: <20210121191020.3144948-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The new added mount parameters allow passing a vector of IP addresses to
be used with the extra transports that nconnect creates. The remoteports
parameter provides the destination addresses, and localports specifies
local address binds.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 fs/nfs/client.c           |  24 ++++++
 fs/nfs/fs_context.c       | 171 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h         |   4 +
 include/linux/nfs_fs_sb.h |   2 +
 4 files changed, 201 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index ff5c4d0d6d13..3560817ab5c4 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -166,6 +166,18 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	memcpy(&clp->cl_addr, cl_init->addr, cl_init->addrlen);
 	clp->cl_addrlen = cl_init->addrlen;
+	if (cl_init->localports) {
+		clp->cl_localports = vmalloc(sizeof(*cl_init->localports));
+		if (!clp->cl_localports)
+			goto error_cleanup;
+		*clp->cl_localports = *cl_init->localports;
+	}
+	if (cl_init->remoteports) {
+		clp->cl_remoteports = vmalloc(sizeof(*cl_init->remoteports));
+		if (!clp->cl_remoteports)
+			goto error_cleanup;
+		*clp->cl_remoteports = *cl_init->remoteports;
+	}
 
 	if (cl_init->hostname) {
 		err = -ENOMEM;
@@ -187,6 +199,10 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	return clp;
 
 error_cleanup:
+	if (clp->cl_remoteports)
+		vfree(clp->cl_remoteports);
+	if (clp->cl_localports)
+		vfree(clp->cl_localports);
 	put_nfs_version(clp->cl_nfs_mod);
 error_dealloc:
 	kfree(clp);
@@ -245,6 +261,10 @@ void nfs_free_client(struct nfs_client *clp)
 
 	put_net(clp->cl_net);
 	put_nfs_version(clp->cl_nfs_mod);
+	if (clp->cl_localports)
+		vfree(clp->cl_localports);
+	if (clp->cl_remoteports)
+		vfree(clp->cl_remoteports);
 	kfree(clp->cl_hostname);
 	kfree(clp->cl_acceptor);
 	kfree(clp);
@@ -508,6 +528,8 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		.nconnect	= clp->cl_nconnect,
 		.address	= (struct sockaddr *)&clp->cl_addr,
 		.addrsize	= clp->cl_addrlen,
+		.localports	= clp->cl_localports,
+		.remoteports	= clp->cl_remoteports,
 		.timeout	= cl_init->timeparms,
 		.servername	= clp->cl_hostname,
 		.nodename	= cl_init->nodename,
@@ -678,6 +700,8 @@ static int nfs_init_server(struct nfs_server *server,
 		.timeparms = &timeparms,
 		.cred = server->cred,
 		.nconnect = ctx->nfs_server.nconnect,
+		.localports = ctx->localports,
+		.remoteports = ctx->remoteports,
 		.init_flags = (1UL << NFS_CS_REUSEPORT),
 	};
 	struct nfs_client *clp;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 06894bcdea2d..3d41ba61b26d 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -49,6 +49,7 @@ enum nfs_param {
 	Opt_hard,
 	Opt_intr,
 	Opt_local_lock,
+	Opt_localports,
 	Opt_lock,
 	Opt_lookupcache,
 	Opt_migration,
@@ -65,6 +66,7 @@ enum nfs_param {
 	Opt_proto,
 	Opt_rdirplus,
 	Opt_rdma,
+	Opt_remoteports,
 	Opt_resvport,
 	Opt_retrans,
 	Opt_retry,
@@ -134,6 +136,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 		  fs_param_neg_with_no|fs_param_deprecated, NULL),
 	fsparam_enum  ("local_lock",	Opt_local_lock, nfs_param_enums_local_lock),
 	fsparam_flag_no("lock",		Opt_lock),
+	fsparam_string("localports",	Opt_localports),
 	fsparam_enum  ("lookupcache",	Opt_lookupcache, nfs_param_enums_lookupcache),
 	fsparam_flag_no("migration",	Opt_migration),
 	fsparam_u32   ("minorversion",	Opt_minorversion),
@@ -150,6 +153,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("proto",		Opt_proto),
 	fsparam_flag_no("rdirplus",	Opt_rdirplus),
 	fsparam_flag  ("rdma",		Opt_rdma),
+	fsparam_string("remoteports",	Opt_remoteports),
 	fsparam_flag_no("resvport",	Opt_resvport),
 	fsparam_u32   ("retrans",	Opt_retrans),
 	fsparam_string("retry",		Opt_retry),
@@ -430,6 +434,146 @@ static int nfs_parse_version_string(struct fs_context *fc,
 	return 0;
 }
 
+static int nfs_portgroup_add_parsed(struct fs_context *fc, struct rpc_portgroup *pg,
+				     const char *type, struct sockaddr_storage *addr,
+				     int len)
+{
+	if (pg->nr >= RPC_MAX_PORTS) {
+		nfs_invalf(fc, "NFS: portgroup for %s is too large, reached %d items",
+			   type, pg->nr);
+		return -ENOSPC;
+	}
+
+	if (pg->nr > 0 && pg->addrs[0].ss_family != addr->ss_family) {
+		nfs_invalf(fc, "NFS: all portgroup addresses must be of the same family");
+		return -EINVAL;
+	}
+
+	pg->addrs[pg->nr] = *addr;
+	pg->nr++;
+
+	return 0;
+}
+
+/*
+ * Parse a single address and add to portgroup.
+ */
+static int nfs_portgroup_add_single(struct fs_context *fc, struct rpc_portgroup *pg,
+				     const char *type, const char *single)
+{
+	struct sockaddr_storage addr;
+	size_t len = rpc_pton(fc->net_ns, single, strlen(single),
+			      (struct sockaddr *)&addr, sizeof(addr));
+
+	if (len == 0) {
+		nfs_invalf(fc, "NFS: portgroup for %s, unable to parse address %s",
+			   type, single);
+		return -EINVAL;
+	}
+
+	return nfs_portgroup_add_parsed(fc, pg, type, &addr, len);
+}
+
+/*
+ * Parse and add a portgroup address range. This is an inclusive address range
+ * that is delimited by '-', e.g. '192.168.0.1-192.168.0.16'.
+ */
+static int nfs_portgroup_add_range(struct fs_context *fc, struct rpc_portgroup *pg,
+				    const char *type, const char *begin, const char *end)
+{
+	struct sockaddr_storage addr;
+	struct sockaddr_storage end_addr;
+	int ret;
+	size_t len = rpc_pton(fc->net_ns, begin, strlen(begin),
+			      (struct sockaddr *)&addr, sizeof(addr)), end_len;
+
+	if (len == 0) {
+		nfs_invalf(fc, "NFS: portgroup for %s, unable to parse address %s",
+			   type, begin);
+		return -EINVAL;
+	}
+
+	end_len = rpc_pton(fc->net_ns, end, strlen(end),
+			   (struct sockaddr *)&end_addr, sizeof(end_addr));
+
+	if (end_len == 0) {
+		nfs_invalf(fc, "NFS: portgroup for %s, unable to parse address %s",
+			   type, end);
+		return -EINVAL;
+	}
+
+	while (0 == (ret = nfs_portgroup_add_parsed(fc, pg, type, &addr, len))) {
+		/* Check if end of range reached */
+		if (rpc_cmp_addr((const struct sockaddr *)&addr,
+				 (const struct sockaddr *)&end_addr))
+			break;
+
+		/* Bump address by one */
+		switch (addr.ss_family) {
+		case AF_INET: {
+			struct sockaddr_in *sin1 = (struct sockaddr_in *)&addr;
+			sin1->sin_addr.s_addr = htonl(ntohl(sin1->sin_addr.s_addr) + 1);
+			break;
+		}
+		case AF_INET6: {
+			nfs_invalf(fc, "NFS: IPv6 in address ranges not supported");
+			return -ENOTSUPP;
+		}
+		default:
+			nfs_invalf(fc, "NFS: address family %d not supported in ranges",
+				   addr.ss_family);
+			return -ENOTSUPP;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Parse and add a portgroup string. These are `~`-delimited single addresses
+ * or groups of addresses. An inclusive address range can be specified with '-'
+ * instead of specifying a single address.
+ */
+static int nfs_parse_portgroup(char *string, struct fs_context *fc,
+				struct rpc_portgroup **pg_out, const char *type)
+{
+	struct rpc_portgroup *pg = NULL;
+	char *string_scan = string, *item;
+	int ret;
+
+	if (!*pg_out) {
+		pg = vmalloc(sizeof(*pg));
+		if (!pg)
+			return -ENOMEM;
+
+		memset(pg, 0, sizeof(*pg));
+		*pg_out = pg;
+	} else {
+		pg = *pg_out;
+	}
+
+	while ((item = strsep(&string_scan, "~")) != NULL) {
+		const char *range_sep = strchr(item, '-');
+
+		if (range_sep != NULL) {
+			const char *range_start = strsep(&item, "-");
+			BUG_ON(range_start == NULL || item == NULL);
+			ret = nfs_portgroup_add_range(fc, pg, type,
+						       range_start, item);
+		} else {
+			ret = nfs_portgroup_add_single(fc, pg, type, item);
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	if (pg->nr == 0)
+		return nfs_invalf(fc, "NFS: passed empty portgroup is invalid");
+
+	return 0;
+}
+
 /*
  * Parse a single mount parameter.
  */
@@ -770,6 +914,24 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			goto out_invalid_value;
 		}
 		break;
+	case Opt_localports:
+		ret = nfs_parse_portgroup(param->string, fc, &ctx->localports, "local");
+
+		switch (ret) {
+		case -ENOMEM: goto out_nomem;
+		case -ENOSPC: goto out_portgroup_too_large;
+		case -EINVAL: goto out_invalid_address;
+		}
+		break;
+	case Opt_remoteports:
+		ret = nfs_parse_portgroup(param->string, fc, &ctx->remoteports, "remote");
+
+		switch (ret) {
+		case -ENOMEM: goto out_nomem;
+		case -ENOSPC: goto out_portgroup_too_large;
+		case -EINVAL: goto out_invalid_address;
+		}
+		break;
 
 		/*
 		 * Special options
@@ -782,6 +944,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 
 	return 0;
 
+out_nomem:
+	nfs_errorf(fc, "NFS: not enough memory to parse device name");
+	return -ENOMEM;
 out_invalid_value:
 	return nfs_invalf(fc, "NFS: Bad mount option value specified");
 out_invalid_address:
@@ -790,6 +955,8 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 	return nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
 out_bad_transport:
 	return nfs_invalf(fc, "NFS: Unrecognized transport protocol");
+out_portgroup_too_large:
+	return -EINVAL;
 }
 
 /*
@@ -1394,6 +1561,10 @@ static void nfs_fs_context_free(struct fs_context *fc)
 		if (ctx->nfs_mod)
 			put_nfs_version(ctx->nfs_mod);
 		kfree(ctx->client_address);
+		if (ctx->localports)
+			vfree(ctx->localports);
+		if (ctx->remoteports)
+			vfree(ctx->remoteports);
 		kfree(ctx->mount_server.hostname);
 		kfree(ctx->nfs_server.export_path);
 		kfree(ctx->nfs_server.hostname);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 62d3189745cd..8efdbd896b77 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -63,6 +63,8 @@ struct nfs_client_initdata {
 	const char *nodename;			/* Hostname of the client */
 	const char *ip_addr;			/* IP address of the client */
 	size_t addrlen;
+	struct rpc_portgroup *localports;      /* Local addresses to bind */
+	struct rpc_portgroup *remoteports;     /* Remote server addresses */
 	struct nfs_subversion *nfs_mod;
 	int proto;
 	u32 minorversion;
@@ -96,6 +98,8 @@ struct nfs_fs_context {
 	char			*fscache_uniq;
 	unsigned short		protofamily;
 	unsigned short		mountfamily;
+	struct rpc_portgroup	*localports;
+	struct rpc_portgroup	*remoteports;
 
 	struct {
 		union {
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 38e60ec742df..33fd23068546 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -50,6 +50,8 @@ struct nfs_client {
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
+	struct rpc_portgroup *  cl_localports;  /* Local addresses to bind */
+	struct rpc_portgroup *  cl_remoteports; /* Remote server addresses */
 	char *			cl_hostname;	/* hostname of server */
 	char *			cl_acceptor;	/* GSSAPI acceptor name */
 	struct list_head	cl_share_link;	/* link in global client list */
-- 
2.26.2

