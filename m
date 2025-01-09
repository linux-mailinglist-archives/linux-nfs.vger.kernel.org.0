Return-Path: <linux-nfs+bounces-9038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72CA08160
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3413A7CA4
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B21ACEC5;
	Thu,  9 Jan 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh6dDxpl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF6192D66
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736454596; cv=none; b=OpwsTUz2Ywy3APOq6fF4cXBI3Z8lvlr1PUCpB8i7PlC1+x4kB5lArPQgIJX3acVcxOI45xeg/XYC6u4/TmTWow0rZAcIYhWdTnEx0qVaMe+wmpe8/QzGUEA9QwpE23Qkfp9h1ukbcBcSE9uIefMMVIYlQOiE4dFK3INByIdzK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736454596; c=relaxed/simple;
	bh=VJu8IPmXrw+SXjn3AcYXdvczfKbk9wxZgNDaqwESmps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmf8YzkKehVEmb2Opno+cdAzStQLXaS02E2lsvT5Biemz91GYQX5yH2ERk1FD8uoVdZ6lQY5K/UAh6A9gJ+Dno4g0Vh5mrHYsjVcB29bqIULGAlSO3V5xtNcM3KI+0BEz9ZHA5vbpBP8MrNx/j1yT5C1CHm2WhfU0s5Mu7tDEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nh6dDxpl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736454593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U88tp4fZeqemnPRtbPi5zzwhdAlBdaPKM7BwMWUVTKI=;
	b=Nh6dDxplLQ66oaTiTN1Ke4ztQWzdC9RCSQ6wL+qAUbiPpBsnTtrYwqXv8djfXNmx/Nexd2
	YiSaI+Z3O0pLUSts6Dvl2tX8dR7eS6kMjBKUfeqNDRdqVz6JAjJkFRjtKOHDW3XGwvpCc3
	X6Mjw3C3DNmD015IEEC3/Hj4pEKFwaM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-As6HeD3DPhadbkddFnN5Bw-1; Thu,
 09 Jan 2025 15:29:49 -0500
X-MC-Unique: As6HeD3DPhadbkddFnN5Bw-1
X-Mimecast-MFC-AGG-ID: As6HeD3DPhadbkddFnN5Bw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E419319560B9;
	Thu,  9 Jan 2025 20:29:48 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88275195E3DE;
	Thu,  9 Jan 2025 20:29:48 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id F28632EA083; Thu, 09 Jan 2025 15:29:46 -0500 (EST)
Date: Thu, 9 Jan 2025 15:29:46 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsdctl: convert to xlog()
Message-ID: <Z4Axui-NRCuI0Epi@aion>
References: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
 <20250109-lockd-nl-v1-1-108548ab0b6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-lockd-nl-v1-1-108548ab0b6b@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, 09 Jan 2025, Jeff Layton wrote:

> Convert all of the fprintf(stderr, ...) calls to xlog(L_ERROR, ...)
> calls.  Change the -d option to not take an argument, and add a -s
> option that will make nfsdctl log to syslog instead of stderr.

I think there should be few xlog(D_GENERAL) calls, otherwise we'll wind
up getting bug reports from users saying they turned on debug logging
and they're not getting any output.  I was working on a similar patch,
with before each of the nl_send_auto() calls.

xlog(D_GENERAL, "%s: sending netlink message", __func__);

Even a single "nfsdctl started" log message would be better than
nothing.

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  utils/nfsdctl/nfsdctl.adoc |   3 ++
>  utils/nfsdctl/nfsdctl.c    | 103 ++++++++++++++++++++++++---------------------
>  2 files changed, 59 insertions(+), 47 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> index c5921458a8e81e749d264cc7dd8344889ec71ac5..2114693042594297b7c5d8600ca16813a0f2356c 100644
> --- a/utils/nfsdctl/nfsdctl.adoc
> +++ b/utils/nfsdctl/nfsdctl.adoc
> @@ -30,6 +30,9 @@ To get information about different subcommand usage, pass the subcommand the
>  *-h, --help*::
>    Print program help text
>  
> +*-s, --syslog*::
> +  Log to syslog instead of to stderr (the default)
> +
>  *-V, --version*::
>    Print program version
>  

You updated the adoc file but didn't regenerate the man page.

> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index b138f06d8b5504e4bf0362041ba36a68aeb12508..11fa4363907a0897ddf79f21916f9e25b9e88dbb 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -45,8 +45,6 @@
>   * gcc -I/usr/include/libnl3/ -o <prog-name> <prog-name>.c -lnl-3 -lnl-genl-3
>   */
>  
> -static int debug_level;
> -
>  struct nfs_version {
>  	uint8_t	major;
>  	uint8_t	minor;
> @@ -390,7 +388,7 @@ static struct nl_sock *netlink_sock_alloc(void)
>  		return NULL;
>  
>  	if (genl_connect(sock)) {
> -		fprintf(stderr, "Failed to connect to generic netlink\n");
> +		xlog(L_ERROR, "Failed to connect to generic netlink");
>  		nl_socket_free(sock);
>  		return NULL;
>  	}
> @@ -409,18 +407,18 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
>  
>  	id = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
>  	if (id < 0) {
> -		fprintf(stderr, "%s not found\n", NFSD_FAMILY_NAME);
> +		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
>  		return NULL;
>  	}
>  
>  	msg = nlmsg_alloc();
>  	if (!msg) {
> -		fprintf(stderr, "failed to allocate netlink message\n");
> +		xlog(L_ERROR, "failed to allocate netlink message");
>  		return NULL;
>  	}
>  
>  	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
> -		fprintf(stderr, "failed to allocate netlink message\n");
> +		xlog(L_ERROR, "failed to allocate netlink message");
>  		nlmsg_free(msg);
>  		return NULL;
>  	}
> @@ -462,7 +460,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
>  
>  	cb = nl_cb_alloc(NL_CB_CUSTOM);
>  	if (!cb) {
> -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> +		xlog(L_ERROR, "failed to allocate netlink callbacks");
>  		ret = 1;
>  		goto out;
>  	}
> @@ -480,7 +478,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
>  	while (ret > 0)
>  		nl_recvmsgs(sock, cb);
>  	if (ret < 0) {
> -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> +		xlog(L_ERROR, "Error: %s", strerror(-ret));
>  		ret = 1;
>  	}
>  out_cb:
> @@ -521,14 +519,14 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
>  
>  	cb = nl_cb_alloc(NL_CB_CUSTOM);
>  	if (!cb) {
> -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> +		xlog(L_ERROR, "failed to allocate netlink callbacks");
>  		ret = 1;
>  		goto out;
>  	}
>  
>  	ret = nl_send_auto(sock, msg);
>  	if (ret < 0) {
> -		fprintf(stderr, "send failed (%d)!\n", ret);
> +		xlog(L_ERROR, "send failed (%d)!", ret);
>  		goto out_cb;
>  	}
>  
> @@ -541,7 +539,7 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
>  	while (ret > 0)
>  		nl_recvmsgs(sock, cb);
>  	if (ret < 0) {
> -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> +		xlog(L_ERROR, "Error: %s", strerror(-ret));
>  		ret = 1;
>  	}
>  out_cb:
> @@ -586,13 +584,13 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
>  
>  			/* empty string? */
>  			if (targv[i][0] == '\0') {
> -				fprintf(stderr, "Invalid threads value %s.\n", targv[i]);
> +				xlog(L_ERROR, "Invalid threads value %s.", targv[i]);
>  				return 1;
>  			}
>  
>  			pool_threads[i] = strtol(targv[i], &endptr, 0);
>  			if (!endptr || *endptr != '\0') {
> -				fprintf(stderr, "Invalid threads value %s.\n", argv[1]);
> +				xlog(L_ERROR, "Invalid threads value %s.", argv[1]);
>  				return 1;
>  			}
>  		}
> @@ -621,14 +619,14 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
>  
>  	cb = nl_cb_alloc(NL_CB_CUSTOM);
>  	if (!cb) {
> -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> +		xlog(L_ERROR, "failed to allocate netlink callbacks");
>  		ret = 1;
>  		goto out;
>  	}
>  
>  	ret = nl_send_auto(sock, msg);
>  	if (ret < 0) {
> -		fprintf(stderr, "send failed: %d\n", ret);
> +		xlog(L_ERROR, "send failed: %d", ret);
>  		goto out_cb;
>  	}
>  
> @@ -641,7 +639,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
>  	while (ret > 0)
>  		nl_recvmsgs(sock, cb);
>  	if (ret < 0) {
> -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> +		xlog(L_ERROR, "Error: %s", strerror(-ret));
>  		ret = 1;
>  	}
>  out_cb:
> @@ -690,7 +688,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
>  
>  		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_PROTO_VERSION);
>  		if (!a) {
> -			fprintf(stderr, "Unable to allocate version nest!\n");
> +			xlog(L_ERROR, "Unable to allocate version nest!");
>  			ret = 1;
>  			goto out;
>  		}
> @@ -707,14 +705,14 @@ static int set_nfsd_versions(struct nl_sock *sock)
>  
>  	cb = nl_cb_alloc(NL_CB_CUSTOM);
>  	if (!cb) {
> -		fprintf(stderr, "Failed to allocate netlink callbacks\n");
> +		xlog(L_ERROR, "Failed to allocate netlink callbacks");
>  		ret = 1;
>  		goto out;
>  	}
>  
>  	ret = nl_send_auto(sock, msg);
>  	if (ret < 0) {
> -		fprintf(stderr, "Send failed: %d\n", ret);
> +		xlog(L_ERROR, "Send failed: %d", ret);
>  		goto out_cb;
>  	}
>  
> @@ -727,7 +725,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
>  	while (ret > 0)
>  		nl_recvmsgs(sock, cb);
>  	if (ret < 0) {
> -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> +		xlog(L_ERROR, "Error: %s", strerror(-ret));
>  		ret = 1;
>  	}
>  out_cb:
> @@ -752,7 +750,7 @@ static int update_nfsd_version(int major, int minor, bool enabled)
>  	/* the kernel doesn't support this version */
>  	if (!enabled)
>  		return 0;
> -	fprintf(stderr, "This kernel does not support NFS version %d.%d\n", major, minor);
> +	xlog(L_ERROR, "This kernel does not support NFS version %d.%d", major, minor);
>  	return -EINVAL;
>  }
>  
> @@ -794,7 +792,7 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
>  
>  			ret = sscanf(str, "%c%d.%d\n", &sign, &major, &minor);
>  			if (ret < 2) {
> -				fprintf(stderr, "Invalid version string (%d) %s\n", ret, str);
> +				xlog(L_ERROR, "Invalid version string (%d) %s", ret, str);
>  				return -EINVAL;
>  			}
>  
> @@ -806,7 +804,7 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
>  				enabled = false;
>  				break;
>  			default:
> -				fprintf(stderr, "Invalid version string %s\n", str);
> +				xlog(L_ERROR, "Invalid version string %s", str);
>  				return -EINVAL;
>  			}
>  
> @@ -839,14 +837,14 @@ static int fetch_current_listeners(struct nl_sock *sock)
>  
>  	cb = nl_cb_alloc(NL_CB_CUSTOM);
>  	if (!cb) {
> -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> +		xlog(L_ERROR, "failed to allocate netlink callbacks");
>  		ret = 1;
>  		goto out;
>  	}
>  
>  	ret = nl_send_auto(sock, msg);
>  	if (ret < 0) {
> -		fprintf(stderr, "send failed: %d\n", ret);
> +		xlog(L_ERROR, "send failed: %d", ret);
>  		goto out_cb;
>  	}
>  
> @@ -859,7 +857,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
>  	while (ret > 0)
>  		nl_recvmsgs(sock, cb);
>  	if (ret < 0) {
> -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> +		xlog(L_ERROR, "Error: %s", strerror(-ret));
>  		ret = 1;
>  	}
>  out_cb:
> @@ -994,7 +992,7 @@ static int update_listeners(const char *str)
>  	 */
>  	ret = getaddrinfo(addr, port, &hints, &res);
>  	if (ret) {
> -		fprintf(stderr, "getaddrinfo of \"%s\" failed: %s\n",
> +		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s",
>  			addr, gai_strerror(ret));
>  		return -EINVAL;
>  	}
> @@ -1046,7 +1044,7 @@ static int update_listeners(const char *str)
>  	}
>  	return 0;
>  out_inval:
> -	fprintf(stderr, "Invalid listener update string: %s", str);
> +	xlog(L_ERROR, "Invalid listener update string: %s", str);
>  	return -EINVAL;
>  }
>  
> @@ -1076,7 +1074,7 @@ static int set_listeners(struct nl_sock *sock)
>  
>  		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_SOCK_ADDR);
>  		if (!a) {
> -			fprintf(stderr, "Unable to allocate listener nest!\n");
> +			xlog(L_ERROR, "Unable to allocate listener nest!");
>  			ret = 1;
>  			goto out;
>  		}
> @@ -1091,14 +1089,14 @@ static int set_listeners(struct nl_sock *sock)
>  
>  	cb = nl_cb_alloc(NL_CB_CUSTOM);
>  	if (!cb) {
> -		fprintf(stderr, "Failed to allocate netlink callbacks\n");
> +		xlog(L_ERROR, "Failed to allocate netlink callbacks");
>  		ret = 1;
>  		goto out;
>  	}
>  
>  	ret = nl_send_auto(sock, msg);
>  	if (ret < 0) {
> -		fprintf(stderr, "Send failed: %d\n", ret);
> +		xlog(L_ERROR, "Send failed: %d", ret);
>  		goto out_cb;
>  	}
>  
> @@ -1111,7 +1109,7 @@ static int set_listeners(struct nl_sock *sock)
>  	while (ret > 0)
>  		nl_recvmsgs(sock, cb);
>  	if (ret < 0) {
> -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> +		xlog(L_ERROR, "Error: %s", strerror(-ret));
>  		ret = 1;
>  	}
>  out_cb:
> @@ -1188,14 +1186,14 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
>  
>  	cb = nl_cb_alloc(NL_CB_CUSTOM);
>  	if (!cb) {
> -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> +		xlog(L_ERROR, "failed to allocate netlink callbacks");
>  		ret = 1;
>  		goto out;
>  	}
>  
>  	ret = nl_send_auto(sock, msg);
>  	if (ret < 0) {
> -		fprintf(stderr, "send failed (%d)!\n", ret);
> +		xlog(L_ERROR, "send failed (%d)!", ret);
>  		goto out_cb;
>  	}
>  
> @@ -1208,7 +1206,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
>  	while (ret > 0)
>  		nl_recvmsgs(sock, cb);
>  	if (ret < 0) {
> -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> +		xlog(L_ERROR, "Error: %s", strerror(-ret));
>  		ret = 1;
>  	}
>  out_cb:
> @@ -1245,7 +1243,7 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
>  
>  		/* empty string? */
>  		if (*targv[0] == '\0') {
> -			fprintf(stderr, "Invalid threads value %s.\n", targv[0]);
> +			xlog(L_ERROR, "Invalid threads value %s.", targv[0]);
>  			return 1;
>  		}
>  		pool_mode = targv[0];
> @@ -1397,7 +1395,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>  
>  			threads[idx++] = strtol(n->field, &endptr, 0);
>  			if (!endptr || *endptr != '\0') {
> -				fprintf(stderr, "Invalid threads value %s.\n", n->field);
> +				xlog(L_ERROR, "Invalid threads value %s.", n->field);
>  				ret = -EINVAL;
>  				goto out;
>  			}
> @@ -1470,7 +1468,8 @@ static void usage(void)

You missed some other changes in the usage() function (some boilerplate
stuff in the printf's).

-Scott
>  /* Options given before the command string */
>  static const struct option pre_options[] = {
>  	{ "help", no_argument, NULL, 'h' },
> -	{ "debug", required_argument, NULL, 'd' },
> +	{ "debug", no_argument, NULL, 'd' },
> +	{ "syslog", no_argument, NULL, 's' },
>  	{ "version", no_argument, NULL, 'V' },
>  	{ },
>  };
> @@ -1524,7 +1523,7 @@ static int run_commandline(struct nl_sock *sock)
>  		if (!ret)
>  			ret = run_one_command(sock, argc, argv);
>  		if (ret)
> -			fprintf(stderr, "Error: %s\n", strerror(ret));
> +			xlog(L_ERROR, "Error: %s", strerror(ret));
>  		free(line);
>  	}
>  	return 0;
> @@ -1533,23 +1532,25 @@ static int run_commandline(struct nl_sock *sock)
>  int main(int argc, char **argv)
>  {
>  	int opt, ret;
> -	struct nl_sock *sock = netlink_sock_alloc();
> -
> -	if (!sock) {
> -		fprintf(stderr, "Unable to allocate netlink socket!");
> -		return 1;
> -	}
> +	struct nl_sock *sock;
>  
>  	taskname = argv[0];
>  
> +	xlog_syslog(0);
> +	xlog_stderr(1);
> +
>  	/* Parse the preliminary options */
> -	while ((opt = getopt_long(argc, argv, "+hd:V", pre_options, NULL)) != -1) {
> +	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
>  		switch (opt) {
>  		case 'h':
>  			usage();
>  			return 0;
>  		case 'd':
> -			debug_level = atoi(optarg);
> +			xlog_config(D_ALL, 1);
> +			break;
> +		case 's':
> +			xlog_syslog(1);
> +			xlog_stderr(0);
>  			break;
>  		case 'V':
>  			// FIXME: print_version();
> @@ -1557,6 +1558,14 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> +	xlog_open(basename(argv[0]));
> +
> +	sock = netlink_sock_alloc();
> +	if (!sock) {
> +		xlog(L_ERROR, "Unable to allocate netlink socket!");
> +		return 1;
> +	}
> +
>  	if (optind > argc) {
>  		usage();
>  		return 1;
> 
> -- 
> 2.47.1
> 


