Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12653B8B75
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jul 2021 02:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhGAA51 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 20:57:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51200 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhGAA51 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 20:57:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C024722748;
        Thu,  1 Jul 2021 00:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625100896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juMpLHf8TkG+FHjDxwtM27wCjHpbUVUwwxeW+chW084=;
        b=CKJX8CW6cFZLpsyKvMpXX7+AtPOQevcdMN611P8bFCHcVDmI+iJ/5nHel20nwhhfCU6zKm
        l/7UkDbJX+WR/TXptdO6kTvVe+IFrihXEZgN0OubaZ2I5F8VAzmjsGr7NjbZcxINejYtgK
        cKZ3vdGYAw/ytdRkGv6V0fTJ3IlT0II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625100896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juMpLHf8TkG+FHjDxwtM27wCjHpbUVUwwxeW+chW084=;
        b=7wDTwI5A+MTgKFTE1N4FvdKn84rHF1upBcSzJifFRxog6WS9pQ03uS61gnSIq6ZvW6m4iE
        a735dYCexhe4FXDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 24707118DD;
        Thu,  1 Jul 2021 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625100896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juMpLHf8TkG+FHjDxwtM27wCjHpbUVUwwxeW+chW084=;
        b=CKJX8CW6cFZLpsyKvMpXX7+AtPOQevcdMN611P8bFCHcVDmI+iJ/5nHel20nwhhfCU6zKm
        l/7UkDbJX+WR/TXptdO6kTvVe+IFrihXEZgN0OubaZ2I5F8VAzmjsGr7NjbZcxINejYtgK
        cKZ3vdGYAw/ytdRkGv6V0fTJ3IlT0II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625100896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juMpLHf8TkG+FHjDxwtM27wCjHpbUVUwwxeW+chW084=;
        b=7wDTwI5A+MTgKFTE1N4FvdKn84rHF1upBcSzJifFRxog6WS9pQ03uS61gnSIq6ZvW6m4iE
        a735dYCexhe4FXDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id pjUiMV4S3WBpRQAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 01 Jul 2021 00:54:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <Anna.Schumaker@Netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH/rfc v2] NFS: introduce NFS namespaces.
In-reply-to: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
Date:   Thu, 01 Jul 2021 10:54:51 +1000
Message-id: <162510089174.7211.449831430943803791@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


When there are multiple NFS mounts from the same server using the same
NFS version and the same security parameters, various other mount
parameters are forcibly shared, causing the parameter requests on
subsequent mounts to be ignored.  This includes nconnect, fsc, and
others.

It is possible to avoid this sharing by creating a separate network
namespace for the new connections, but this can often be overly
burdensome.  This patch introduces the concept of "NFS namespaces" which
allows one group of NFS mounts to be completely separate from others
without the need for a completely separate network namespace.

Use cases for this include:
 - major applications with different tuning recommendations.  Often the
   support organisation for a particular application will require known
   configuration options to be used before a support request can be
   considered.  If two applications use (different mounts from) the same
   NFS server but require different configuration, this is currently
   awkward.
 - data policy restrictions.  Use of fscache on one directory might be
   forbidden by local policy, while use on another might be permitted
   and beneficial.
 - testing for problem diagnosis.  When an NFS mount is exhibiting
   problems it can be useful information to see if a second mount will
   suffer the same problems.  I've seen two separate cases recently with
   TCP-level problems where the initial diagnosis couldn't make this test
   as the TCP connection would be shared.  Allowing completely independent
   mounts would make this easier.

The NFS namespace concept addresses each of these needs.

A new mount option "namespace=3D" is added.  Any two mounts with different
namespace settings are treated as through there were to different
servers.  If no "namespace=3D" is given, then the empty string is used as
the namespace for comparisons.  Possible usages might be
"namespace=3Dapplication_name" or "namespace=3Dmustnotcache" or
"namespace=3Dtesting".

The namespace - if given - is included in the client identity string so
that the NFSv4 server will see two different mount groups as though from
separate clients.

A few white-space inconsistencies nearby changed code have been
rectified.

Signed-off-by: NeilBrown <neilb@suse.de>
---

Only change since V1 is a minor code fix from Dan Carpenter.

 fs/nfs/client.c           | 20 ++++++++++++++++++--
 fs/nfs/fs_context.c       | 11 ++++++++++-
 fs/nfs/internal.h         |  2 ++
 fs/nfs/nfs3client.c       |  1 +
 fs/nfs/nfs4client.c       | 15 ++++++++++++++-
 fs/nfs/nfs4proc.c         | 28 ++++++++++++++++++++--------
 fs/nfs/super.c            |  5 +++++
 include/linux/nfs_fs_sb.h |  4 ++--
 8 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 330f65727c45..f6f06ea649bc 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -173,6 +173,13 @@ struct nfs_client *nfs_alloc_client(const struct nfs_cli=
ent_initdata *cl_init)
 		if (!clp->cl_hostname)
 			goto error_cleanup;
 	}
+	if (cl_init->namespace && *cl_init->namespace) {
+		err =3D -ENOMEM;
+		clp->cl_namespace =3D kstrdup(cl_init->namespace, GFP_KERNEL);
+		if (!clp->cl_namespace)
+			goto error_cleanup;
+	} else
+		clp->cl_namespace =3D "";
=20
 	INIT_LIST_HEAD(&clp->cl_superblocks);
 	clp->cl_rpcclient =3D ERR_PTR(-EINVAL);
@@ -187,6 +194,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_clie=
nt_initdata *cl_init)
 	return clp;
=20
 error_cleanup:
+	kfree_const(clp->cl_hostname);
 	put_nfs_version(clp->cl_nfs_mod);
 error_dealloc:
 	kfree(clp);
@@ -247,6 +255,7 @@ void nfs_free_client(struct nfs_client *clp)
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
 	kfree(clp->cl_acceptor);
+	kfree_const(clp->cl_namespace);
 	kfree(clp);
 }
 EXPORT_SYMBOL_GPL(nfs_free_client);
@@ -288,7 +297,7 @@ static struct nfs_client *nfs_match_client(const struct n=
fs_client_initdata *dat
=20
 again:
 	list_for_each_entry(clp, &nn->nfs_client_list, cl_share_link) {
-	        const struct sockaddr *clap =3D (struct sockaddr *)&clp->cl_addr;
+		const struct sockaddr *clap =3D (struct sockaddr *)&clp->cl_addr;
 		/* Don't match clients that failed to initialise properly */
 		if (clp->cl_cons_state < 0)
 			continue;
@@ -320,11 +329,17 @@ static struct nfs_client *nfs_match_client(const struct=
 nfs_client_initdata *dat
 		    test_bit(NFS_CS_DS, &clp->cl_flags))
 			continue;
=20
+		/* If admin has asked for different namespaces for these mounts,
+		 * don't share the client.
+		 */
+		if (strcmp(clp->cl_namespace, data->namespace ?: "") !=3D 0)
+			continue;
+
 		/* Match the full socket address */
 		if (!rpc_cmp_addr_port(sap, clap))
 			/* Match all xprt_switch full socket addresses */
 			if (IS_ERR(clp->cl_rpcclient) ||
-                            !rpc_clnt_xprt_switch_has_addr(clp->cl_rpcclient,
+			    !rpc_clnt_xprt_switch_has_addr(clp->cl_rpcclient,
 							   sap))
 				continue;
=20
@@ -676,6 +691,7 @@ static int nfs_init_server(struct nfs_server *server,
 		.timeparms =3D &timeparms,
 		.cred =3D server->cred,
 		.nconnect =3D ctx->nfs_server.nconnect,
+		.namespace =3D ctx->namespace,
 		.init_flags =3D (1UL << NFS_CS_REUSEPORT),
 	};
 	struct nfs_client *clp;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index d95c9a39bc70..7c644a31d304 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -59,6 +59,7 @@ enum nfs_param {
 	Opt_mountproto,
 	Opt_mountvers,
 	Opt_namelen,
+	Opt_namespace,
 	Opt_nconnect,
 	Opt_port,
 	Opt_posix,
@@ -156,6 +157,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[]=
 =3D {
 	fsparam_u32   ("mountport",	Opt_mountport),
 	fsparam_string("mountproto",	Opt_mountproto),
 	fsparam_u32   ("mountvers",	Opt_mountvers),
+	fsparam_string("namespace",	Opt_namespace),
 	fsparam_u32   ("namlen",	Opt_namelen),
 	fsparam_u32   ("nconnect",	Opt_nconnect),
 	fsparam_string("nfsvers",	Opt_vers),
@@ -824,7 +826,13 @@ static int nfs_fs_context_parse_param(struct fs_context =
*fc,
 			goto out_invalid_value;
 		}
 		break;
-
+	case Opt_namespace:
+		if (strpbrk(param->string, " \n\t,"))
+			goto out_invalid_value;
+		kfree(ctx->namespace);
+		ctx->namespace =3D param->string;
+		param->string =3D NULL;
+		break;
 		/*
 		 * Special options
 		 */
@@ -1462,6 +1470,7 @@ static void nfs_fs_context_free(struct fs_context *fc)
 		kfree(ctx->nfs_server.export_path);
 		kfree(ctx->nfs_server.hostname);
 		kfree(ctx->fscache_uniq);
+		kfree(ctx->namespace);
 		nfs_free_fhandle(ctx->mntfh);
 		nfs_free_fattr(ctx->clone_data.fattr);
 		kfree(ctx);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a36af04188c2..2010492b856a 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -62,6 +62,7 @@ struct nfs_client_initdata {
 	const struct sockaddr *addr;		/* Address of the server */
 	const char *nodename;			/* Hostname of the client */
 	const char *ip_addr;			/* IP address of the client */
+	const char *namespace;			/* NFS namespace */
 	size_t addrlen;
 	struct nfs_subversion *nfs_mod;
 	int proto;
@@ -97,6 +98,7 @@ struct nfs_fs_context {
 	unsigned short		protofamily;
 	unsigned short		mountfamily;
 	bool			has_sec_mnt_opts;
+	const char		*namespace;
=20
 	struct {
 		union {
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 5601e47360c2..61ad13e1b041 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -93,6 +93,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *md=
s_srv,
 		.net =3D mds_clp->cl_net,
 		.timeparms =3D &ds_timeout,
 		.cred =3D mds_srv->cred,
+		.namespace =3D mds_clp->cl_namespace,
 	};
 	struct nfs_client *clp;
 	char buf[INET6_ADDRSTRLEN + 1];
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 42719384e25f..7dbc521275ff 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -500,6 +500,12 @@ static int nfs4_match_client(struct nfs_client  *pos,  s=
truct nfs_client *new,
 	if (pos->cl_minorversion !=3D new->cl_minorversion)
 		return 1;
=20
+	/* If admin has asked for different namespaces for these mounts,
+	 * don't share the client.
+	 */
+	if (strcmp(pos->cl_namespace, new->cl_namespace) !=3D 0)
+		return 1;
+
 	/* If "pos" isn't marked ready, we can't trust the
 	 * remaining fields in "pos", especially the client
 	 * ID and serverowner fields.  Wait for CREATE_SESSION
@@ -863,6 +869,7 @@ static int nfs4_set_client(struct nfs_server *server,
 		const char *ip_addr,
 		int proto, const struct rpc_timeout *timeparms,
 		u32 minorversion, unsigned int nconnect,
+		const char *namespace,
 		struct net *net)
 {
 	struct nfs_client_initdata cl_init =3D {
@@ -873,6 +880,7 @@ static int nfs4_set_client(struct nfs_server *server,
 		.nfs_mod =3D &nfs_v4,
 		.proto =3D proto,
 		.minorversion =3D minorversion,
+		.namespace =3D namespace,
 		.net =3D net,
 		.timeparms =3D timeparms,
 		.cred =3D server->cred,
@@ -940,6 +948,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *=
mds_srv,
 		.nfs_mod =3D &nfs_v4,
 		.proto =3D ds_proto,
 		.minorversion =3D minor_version,
+		.namespace =3D mds_clp->cl_namespace,
 		.net =3D mds_clp->cl_net,
 		.timeparms =3D &ds_timeout,
 		.cred =3D mds_srv->cred,
@@ -1120,6 +1129,7 @@ static int nfs4_init_server(struct nfs_server *server, =
struct fs_context *fc)
 				&timeparms,
 				ctx->minorversion,
 				ctx->nfs_server.nconnect,
+				ctx->namespace,
 				fc->net_ns);
 	if (error < 0)
 		return error;
@@ -1209,6 +1219,7 @@ struct nfs_server *nfs4_create_referral_server(struct f=
s_context *fc)
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
+				parent_client->cl_namespace,
 				parent_client->cl_net);
 	if (!error)
 		goto init_server;
@@ -1224,6 +1235,7 @@ struct nfs_server *nfs4_create_referral_server(struct f=
s_context *fc)
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
+				parent_client->cl_namespace,
 				parent_client->cl_net);
 	if (error < 0)
 		goto error;
@@ -1321,7 +1333,8 @@ int nfs4_update_server(struct nfs_server *server, const=
 char *hostname,
 	error =3D nfs4_set_client(server, hostname, sap, salen, buf,
 				clp->cl_proto, clnt->cl_timeout,
 				clp->cl_minorversion,
-				clp->cl_nconnect, net);
+				clp->cl_nconnect,
+				clp->cl_namespace, net);
 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
 	if (error !=3D 0) {
 		nfs_server_insert_lists(server);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e653654c10bc..5f5caf26397c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6191,6 +6191,8 @@ nfs4_init_nonuniform_client_string(struct nfs_client *c=
lp)
 		strlen(rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR)) +
 		1;
 	rcu_read_unlock();
+	if (*clp->cl_namespace)
+		len +=3D strlen(clp->cl_namespace) + 1;
=20
 	buflen =3D nfs4_get_uniquifier(clp, buf, sizeof(buf));
 	if (buflen)
@@ -6210,15 +6212,19 @@ nfs4_init_nonuniform_client_string(struct nfs_client =
*clp)
=20
 	rcu_read_lock();
 	if (buflen)
-		scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
+		scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s%s%s",
 			  clp->cl_rpcclient->cl_nodename, buf,
 			  rpc_peeraddr2str(clp->cl_rpcclient,
-					   RPC_DISPLAY_ADDR));
+					   RPC_DISPLAY_ADDR),
+			  *clp->cl_namespace ? "/" : "",
+			  clp->cl_namespace);
 	else
-		scnprintf(str, len, "Linux NFSv4.0 %s/%s",
+		scnprintf(str, len, "Linux NFSv4.0 %s/%s%s%s",
 			  clp->cl_rpcclient->cl_nodename,
 			  rpc_peeraddr2str(clp->cl_rpcclient,
-					   RPC_DISPLAY_ADDR));
+					   RPC_DISPLAY_ADDR),
+			  *clp->cl_namespace ? "/" : "",
+			  clp->cl_namespace);
 	rcu_read_unlock();
=20
 	clp->cl_owner_id =3D str;
@@ -6238,6 +6244,8 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
=20
 	len =3D 10 + 10 + 1 + 10 + 1 +
 		strlen(clp->cl_rpcclient->cl_nodename) + 1;
+	if (*clp->cl_namespace)
+		len +=3D strlen(clp->cl_namespace) + 1;
=20
 	buflen =3D nfs4_get_uniquifier(clp, buf, sizeof(buf));
 	if (buflen)
@@ -6256,13 +6264,17 @@ nfs4_init_uniform_client_string(struct nfs_client *cl=
p)
 		return -ENOMEM;
=20
 	if (buflen)
-		scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
+		scnprintf(str, len, "Linux NFSv%u.%u %s/%s%s%s",
 			  clp->rpc_ops->version, clp->cl_minorversion,
-			  buf, clp->cl_rpcclient->cl_nodename);
+			  buf, clp->cl_rpcclient->cl_nodename,
+			  *clp->cl_namespace ? "/" : "",
+			  clp->cl_namespace);
 	else
-		scnprintf(str, len, "Linux NFSv%u.%u %s",
+		scnprintf(str, len, "Linux NFSv%u.%u %s%s%s",
 			  clp->rpc_ops->version, clp->cl_minorversion,
-			  clp->cl_rpcclient->cl_nodename);
+			  clp->cl_rpcclient->cl_nodename,
+			  *clp->cl_namespace ? "/" : "",
+			  clp->cl_namespace);
 	clp->cl_owner_id =3D str;
 	return 0;
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index fe58525cfed4..ea59248b64d1 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -479,6 +479,8 @@ static void nfs_show_mount_options(struct seq_file *m, st=
ruct nfs_server *nfss,
 	rcu_read_unlock();
 	if (clp->cl_nconnect > 0)
 		seq_printf(m, ",nconnect=3D%u", clp->cl_nconnect);
+	if (*clp->cl_namespace)
+		seq_printf(m, ",namespace=3D%s", clp->cl_namespace);
 	if (version =3D=3D 4) {
 		if (nfss->port !=3D NFS_PORT)
 			seq_printf(m, ",port=3D%u", nfss->port);
@@ -1186,6 +1188,9 @@ static int nfs_compare_super(struct super_block *sb, st=
ruct fs_context *fc)
 	/* Note: NFS_MOUNT_UNSHARED =3D=3D NFS4_MOUNT_UNSHARED */
 	if (old->flags & NFS_MOUNT_UNSHARED)
 		return 0;
+	if (strcmp(old->nfs_client->cl_namespace,
+		   server->nfs_client->cl_namespace) !=3D 0)
+		return 0;
 	if (memcmp(&old->fsid, &server->fsid, sizeof(old->fsid)) !=3D 0)
 		return 0;
 	if (!nfs_compare_userns(old, server))
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d71a0e90faeb..c62db98f3c04 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -62,8 +62,8 @@ struct nfs_client {
=20
 	u32			cl_minorversion;/* NFSv4 minorversion */
 	unsigned int		cl_nconnect;	/* Number of connections */
-	const char *		cl_principal;  /* used for machine cred */
-
+	const char *		cl_principal;	/* used for machine cred */
+	const char *		cl_namespace;	/* used for NFS namespaces */
 #if IS_ENABLED(CONFIG_NFS_V4)
 	struct list_head	cl_ds_clients; /* auth flavor data servers */
 	u64			cl_clientid;	/* constant */
--=20
2.32.0

