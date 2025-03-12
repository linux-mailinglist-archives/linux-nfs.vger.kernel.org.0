Return-Path: <linux-nfs+bounces-10564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC42A5DE65
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE947A6383
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40C24A07E;
	Wed, 12 Mar 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAcKKqFG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346521DBB38
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787585; cv=none; b=mtINg07qABN1ll5b9+Ynm8O0h9rzBmlhviQ3pFSe1GkLou0Tz1jNWW202zQj9Rnsmm26lc05EOqoDOuZXIxz0OF/mXDQUbHPE0nmNn8blxvzwx9PXdRQhF5aJlhsM8KT80Cc3sQtksuhq0/XVecDfHUGQyBqk13JUpCmmN2iLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787585; c=relaxed/simple;
	bh=9pFNv4mMDkrQK9EtV/A+d92oiNgOaKY/6AvoREKm2yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIAln9aBz1248WEu7J0YUegsHgfmMQPU08+WBxpvrEcdnXJlZjl3DDmZ6OkZpb32a5v2yy8XXCv/AvPSh3UJ3fkIO+PmYFb+mYJFYVPj+bA3PFB7YY8Tuc5kS9lZxyu4G5R3JOqm2297cuHpU9oz1gd9Pcx4A+hz0tnslf8GSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAcKKqFG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741787582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxLqV2zUfc+QTKn0LRuM0MnWofOHxUgPLTZBZXnI2R4=;
	b=GAcKKqFGOQygTSWOt+I4LFc66rRXuGHD6cTkYdTINmzR/wp+EJLm2iHV3x60nzacSmFHRG
	AB3GPyxFDNAts2br4N1p3JiOlpORu79Y8A0ulH8SvBNy8rqGXhYUvL8dBVWmsi9ip9JHFw
	wk8YwABzAfOLmCkyUMwMhZmrN3nhKPQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-8P6kg09MMwSsB72nTu4EJA-1; Wed,
 12 Mar 2025 09:52:59 -0400
X-MC-Unique: 8P6kg09MMwSsB72nTu4EJA-1
X-Mimecast-MFC-AGG-ID: 8P6kg09MMwSsB72nTu4EJA_1741787577
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD2A6180034D;
	Wed, 12 Mar 2025 13:52:56 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A424C19560AD;
	Wed, 12 Mar 2025 13:52:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: add a rpc_clnt shutdown control in debugfs
Date: Wed, 12 Mar 2025 09:52:53 -0400
Message-ID: <7906109F-91D2-4ECF-B868-5519B56D2CEE@redhat.com>
In-Reply-To: <20250312-rpc-shutdown-v1-1-cc90d79a71c2@kernel.org>
References: <20250312-rpc-shutdown-v1-1-cc90d79a71c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12 Mar 2025, at 9:36, Jeff Layton wrote:

> There have been confirmed reports where a container with an NFS mount
> inside it dies abruptly, along with all of its processes, but the NFS
> client sticks around and keeps trying to send RPCs after the networking=

> is gone.
>
> We have a reproducer where if we SIGKILL a container with an NFS mount,=

> the RPC clients will stick around indefinitely. The orchestrator
> does a MNT_DETACH unmount on the NFS mount, and then tears down the
> networking while there are still RPCs in flight.
>
> Recently new controls were added[1] that allow shutting down an NFS
> mount. That doesn't help here since the mount namespace is detached fro=
m
> any tasks at this point.

That's interesting - seems like the orchestrator could just reorder its
request to shutdown before detaching the mount namespace.  Not an objecti=
on,
just wondering why the MNT_DETACH must come first.

> Transplant shutdown_client() to the sunrpc module, and give it a more
> distinct name. Add a new debugfs sunrpc/rpc_clnt/*/shutdown knob that
> allows the same functionality as the one in /sys/fs/nfs, but at the
> rpc_clnt level.
>
> [1]: commit d9615d166c7e ("NFS: add sysfs shutdown knob").
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I have a TODO to patch Documentation/ for this knob mostly to write warni=
ngs
because there are some potential "gotchas" here - for example you can hav=
e
shared RPC clients and shutting down one of those can cause problems for =
a
different mount (this is true today with the /sys/fs/nfs/[bdi]/shutdown
knob).  Shutting down aribitrary clients will definitely break things in
weird ways, its not a safe place to explore.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

> ---
>  fs/nfs/sysfs.c               | 19 ++++---------------
>  include/linux/sunrpc/sched.h |  1 +
>  net/sunrpc/clnt.c            | 12 ++++++++++++
>  net/sunrpc/debugfs.c         | 15 +++++++++++++++
>  4 files changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index 7b59a40d40c061a41b0fbde91aa006314f02c1fb..c29c5fd639554461bdcd9ff=
612726194910d85b5 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -217,17 +217,6 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns=
)
>  	}
>  }
>
> -static bool shutdown_match_client(const struct rpc_task *task, const v=
oid *data)
> -{
> -	return true;
> -}
> -
> -static void shutdown_client(struct rpc_clnt *clnt)
> -{
> -	clnt->cl_shutdown =3D 1;
> -	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
> -}
> -
>  static ssize_t
>  shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
>  				char *buf)
> @@ -258,14 +247,14 @@ shutdown_store(struct kobject *kobj, struct kobj_=
attribute *attr,
>  		goto out;
>
>  	server->flags |=3D NFS_MOUNT_SHUTDOWN;
> -	shutdown_client(server->client);
> -	shutdown_client(server->nfs_client->cl_rpcclient);
> +	rpc_clnt_shutdown(server->client);
> +	rpc_clnt_shutdown(server->nfs_client->cl_rpcclient);
>
>  	if (!IS_ERR(server->client_acl))
> -		shutdown_client(server->client_acl);
> +		rpc_clnt_shutdown(server->client_acl);
>
>  	if (server->nlm_host)
> -		shutdown_client(server->nlm_host->h_rpcclnt);
> +		rpc_clnt_shutdown(server->nlm_host->h_rpcclnt);
>  out:
>  	return count;
>  }
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.=
h
> index eac57914dcf3200c1a6ed39ab030e3fe8b4da3e1..fe7c39a17ce44ec68c0cf05=
7133d0f8e7f0ae797 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -232,6 +232,7 @@ unsigned long	rpc_cancel_tasks(struct rpc_clnt *cln=
t, int error,
>  				 bool (*fnmatch)(const struct rpc_task *,
>  						 const void *),
>  				 const void *data);
> +void		rpc_clnt_shutdown(struct rpc_clnt *clnt);
>  void		rpc_execute(struct rpc_task *);
>  void		rpc_init_priority_wait_queue(struct rpc_wait_queue *, const char=
 *);
>  void		rpc_init_wait_queue(struct rpc_wait_queue *, const char *);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 2fe88ea79a70c134e58abfb03fca230883eddf1f..0028858b12d97e7b45f4c24=
cfbd761ba2a734b32 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -934,6 +934,18 @@ unsigned long rpc_cancel_tasks(struct rpc_clnt *cl=
nt, int error,
>  }
>  EXPORT_SYMBOL_GPL(rpc_cancel_tasks);
>
> +static bool shutdown_match_client(const struct rpc_task *task, const v=
oid *data)
> +{
> +	return true;
> +}
> +
> +void rpc_clnt_shutdown(struct rpc_clnt *clnt)
> +{
> +	clnt->cl_shutdown =3D 1;
> +	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
> +}
> +EXPORT_SYMBOL_GPL(rpc_clnt_shutdown);
> +
>  static int rpc_clnt_disconnect_xprt(struct rpc_clnt *clnt,
>  				    struct rpc_xprt *xprt, void *dummy)
>  {
> diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
> index 32417db340de3775c533d0ad683b5b37800d7fe5..4df31dcca2d747db6767c12=
ddfa29963ed7be204 100644
> --- a/net/sunrpc/debugfs.c
> +++ b/net/sunrpc/debugfs.c
> @@ -145,6 +145,17 @@ static int do_xprt_debugfs(struct rpc_clnt *clnt, =
struct rpc_xprt *xprt, void *n
>  	return 0;
>  }
>
> +static int
> +clnt_shutdown(void *data, u64 value)
> +{
> +	struct rpc_clnt *clnt =3D data;
> +
> +	rpc_clnt_shutdown(clnt);
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(shutdown_fops, NULL, clnt_shutdown, "%llu\n")=
;
> +
>  void
>  rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
>  {
> @@ -163,6 +174,10 @@ rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
>  	debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs, clnt,
>  			    &tasks_fops);
>
> +	/* make shutdown file */
> +	debugfs_create_file("shutdown", S_IFREG | 0200, clnt->cl_debugfs, cln=
t,
> +			    &shutdown_fops);
> +
>  	rpc_clnt_iterate_for_each_xprt(clnt, do_xprt_debugfs, &xprtnum);
>  }
>
>
> ---
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> change-id: 20250312-rpc-shutdown-ce9b6d3599da
>
> Best regards,
> -- =

> Jeff Layton <jlayton@kernel.org>


