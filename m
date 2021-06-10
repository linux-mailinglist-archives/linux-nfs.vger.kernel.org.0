Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B323A21F5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 03:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFJBvI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 21:51:08 -0400
Received: from out20-63.mail.aliyun.com ([115.124.20.63]:42836 "EHLO
        out20-63.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBvI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 21:51:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.166512-0.00264227-0.830845;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.KQB.TRk_1623289750;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KQB.TRk_1623289750)
          by smtp.aliyun-inc.com(10.147.42.135);
          Thu, 10 Jun 2021 09:49:10 +0800
Date:   Thu, 10 Jun 2021 09:49:13 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
In-Reply-To: <20210609215319.5518-3-olga.kornievskaia@gmail.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com> <20210609215319.5518-3-olga.kornievskaia@gmail.com>
Message-Id: <20210610094912.4D54.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

We could extend 'nconnect' option rather than a new option 'max_connect'?

max of nconnect is 16 when trunk support of single ip (kernel 5.3-5.?).
max of nconnect is 64 when trunk support of multiple ip (kernel 5.?-).

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/10

> From: Olga Kornievskaia <kolga@netapp.com>
> 
> This option will control up to how many xprts can the client
> establish to the server. This patch parses the value and sets
> up structures that keep track of max_connect.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/client.c           |  1 +
>  fs/nfs/fs_context.c       |  8 ++++++++
>  fs/nfs/internal.h         |  2 ++
>  fs/nfs/nfs4client.c       | 12 ++++++++++--
>  fs/nfs/super.c            |  2 ++
>  include/linux/nfs_fs_sb.h |  1 +
>  6 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 330f65727c45..486dec59972b 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
>  
>  	clp->cl_proto = cl_init->proto;
>  	clp->cl_nconnect = cl_init->nconnect;
> +	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
>  	clp->cl_net = get_net(cl_init->net);
>  
>  	clp->cl_principal = "*";
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index d95c9a39bc70..cfbff7098f8e 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -29,6 +29,7 @@
>  #endif
>  
>  #define NFS_MAX_CONNECTIONS 16
> +#define NFS_MAX_TRANSPORTS 128
>  
>  enum nfs_param {
>  	Opt_ac,
> @@ -60,6 +61,7 @@ enum nfs_param {
>  	Opt_mountvers,
>  	Opt_namelen,
>  	Opt_nconnect,
> +	Opt_max_connect,
>  	Opt_port,
>  	Opt_posix,
>  	Opt_proto,
> @@ -158,6 +160,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>  	fsparam_u32   ("mountvers",	Opt_mountvers),
>  	fsparam_u32   ("namlen",	Opt_namelen),
>  	fsparam_u32   ("nconnect",	Opt_nconnect),
> +	fsparam_u32   ("max_connect",	Opt_max_connect),
>  	fsparam_string("nfsvers",	Opt_vers),
>  	fsparam_u32   ("port",		Opt_port),
>  	fsparam_flag_no("posix",	Opt_posix),
> @@ -770,6 +773,11 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>  			goto out_of_bounds;
>  		ctx->nfs_server.nconnect = result.uint_32;
>  		break;
> +	case Opt_max_connect:
> +		if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_TRANSPORTS)
> +			goto out_of_bounds;
> +		ctx->nfs_server.max_connect = result.uint_32;
> +		break;
>  	case Opt_lookupcache:
>  		switch (result.uint_32) {
>  		case Opt_lookupcache_all:
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index a36af04188c2..66fc936834f2 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -67,6 +67,7 @@ struct nfs_client_initdata {
>  	int proto;
>  	u32 minorversion;
>  	unsigned int nconnect;
> +	unsigned int max_connect;
>  	struct net *net;
>  	const struct rpc_timeout *timeparms;
>  	const struct cred *cred;
> @@ -121,6 +122,7 @@ struct nfs_fs_context {
>  		int			port;
>  		unsigned short		protocol;
>  		unsigned short		nconnect;
> +		unsigned short		max_connect;
>  		unsigned short		export_path_len;
>  	} nfs_server;
>  
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 42719384e25f..640c8235d817 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -863,6 +863,7 @@ static int nfs4_set_client(struct nfs_server *server,
>  		const char *ip_addr,
>  		int proto, const struct rpc_timeout *timeparms,
>  		u32 minorversion, unsigned int nconnect,
> +		unsigned int max_connect,
>  		struct net *net)
>  {
>  	struct nfs_client_initdata cl_init = {
> @@ -881,6 +882,8 @@ static int nfs4_set_client(struct nfs_server *server,
>  
>  	if (minorversion == 0)
>  		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
> +	else
> +		cl_init.max_connect = max_connect;
>  	if (proto == XPRT_TRANSPORT_TCP)
>  		cl_init.nconnect = nconnect;
>  
> @@ -950,8 +953,10 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
>  		return ERR_PTR(-EINVAL);
>  	cl_init.hostname = buf;
>  
> -	if (mds_clp->cl_nconnect > 1 && ds_proto == XPRT_TRANSPORT_TCP)
> +	if (mds_clp->cl_nconnect > 1 && ds_proto == XPRT_TRANSPORT_TCP) {
>  		cl_init.nconnect = mds_clp->cl_nconnect;
> +		cl_init.max_connect = mds_clp->cl_max_connect;
> +	}
>  
>  	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
>  		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
> @@ -1120,6 +1125,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
>  				&timeparms,
>  				ctx->minorversion,
>  				ctx->nfs_server.nconnect,
> +				ctx->nfs_server.max_connect,
>  				fc->net_ns);
>  	if (error < 0)
>  		return error;
> @@ -1209,6 +1215,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
>  				parent_server->client->cl_timeout,
>  				parent_client->cl_mvops->minor_version,
>  				parent_client->cl_nconnect,
> +				parent_client->cl_max_connect,
>  				parent_client->cl_net);
>  	if (!error)
>  		goto init_server;
> @@ -1224,6 +1231,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
>  				parent_server->client->cl_timeout,
>  				parent_client->cl_mvops->minor_version,
>  				parent_client->cl_nconnect,
> +				parent_client->cl_max_connect,
>  				parent_client->cl_net);
>  	if (error < 0)
>  		goto error;
> @@ -1321,7 +1329,7 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
>  	error = nfs4_set_client(server, hostname, sap, salen, buf,
>  				clp->cl_proto, clnt->cl_timeout,
>  				clp->cl_minorversion,
> -				clp->cl_nconnect, net);
> +				clp->cl_nconnect, clp->cl_max_connect, net);
>  	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
>  	if (error != 0) {
>  		nfs_server_insert_lists(server);
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index fe58525cfed4..e65c83494c05 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -480,6 +480,8 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
>  	if (clp->cl_nconnect > 0)
>  		seq_printf(m, ",nconnect=%u", clp->cl_nconnect);
>  	if (version == 4) {
> +		if (clp->cl_max_connect > 1)
> +			seq_printf(m, ",max_connect=%u", clp->cl_max_connect);
>  		if (nfss->port != NFS_PORT)
>  			seq_printf(m, ",port=%u", nfss->port);
>  	} else
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index d71a0e90faeb..2a9acbfe00f0 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -62,6 +62,7 @@ struct nfs_client {
>  
>  	u32			cl_minorversion;/* NFSv4 minorversion */
>  	unsigned int		cl_nconnect;	/* Number of connections */
> +	unsigned int		cl_max_connect; /* max number of xprts allowed */
>  	const char *		cl_principal;  /* used for machine cred */
>  
>  #if IS_ENABLED(CONFIG_NFS_V4)
> -- 
> 2.27.0


