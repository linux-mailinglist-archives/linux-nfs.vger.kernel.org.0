Return-Path: <linux-nfs+bounces-9023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999AA07B71
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB6A167E09
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7121D594;
	Thu,  9 Jan 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPZA0o78"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863721D003
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435411; cv=none; b=O4Nr5UcjlhvDJx0j5lvJYkVwd0B1QHE8l2gip7sIS+CODnRiZ1XC4XpDwybh1JEi9BHfF9q+7ZzTeJExG9YHVjqtgcA2GoLR+FktqV9R9Fmv6UNS2U1O/Ckvyf1GtW0TN8kyRciyAQlTc6axT5tgskzN06zohPLfDGe2nxv/njY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435411; c=relaxed/simple;
	bh=9Nlmv9W3FxATrnom1VbOuqDMi668UgtvWXFB/4bSi3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN603FkjdboFvqbbVnz9yg9EsGc4Pk2Fsm6spot2tlYRerDerpty5j2XwMCqgFvwbB8oxm5W+9TL/lmReEQ2GhT6a3RBbxUSD+hhPI1SsA1iSRW7RiulLDGje9yWJpd/0h0+tBOzBI220saW1lTXIVi7iKxXz6ZdNT+T8vT1X7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPZA0o78; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736435408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVRXRrON6Mv/wTFHmn0JF3Z4JJMQfJ37llMrKrVdiBU=;
	b=HPZA0o78BWc32o0mvOw3K7S/fSA3T/6o9GpjJ/y3nV++YcqVvTXh7zZMSD3CSJVIgSNlvi
	Kf9q5CKiGl8KmA6iYKEyp1zAmDGGgEs8ZG5HaT1++9aNkB/MbZel1G36WNmHH7AXwYkZ8R
	gBKFhgIVUY9SeRsCl7RzrfrAgsK4dus=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-imfLph9RNSuOyAmN9otNhA-1; Thu,
 09 Jan 2025 10:10:04 -0500
X-MC-Unique: imfLph9RNSuOyAmN9otNhA-1
X-Mimecast-MFC-AGG-ID: imfLph9RNSuOyAmN9otNhA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78F6919540EB;
	Thu,  9 Jan 2025 15:10:03 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DE353003E7F;
	Thu,  9 Jan 2025 15:10:02 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH 3/3] sunrpc: Add a sysfs file for adding a new xprt
Date: Thu, 09 Jan 2025 10:10:00 -0500
Message-ID: <8556AFF1-DA71-41C2-B3AE-6BE1F0883B37@redhat.com>
In-Reply-To: <20250108213632.260498-4-anna@kernel.org>
References: <20250108213632.260498-1-anna@kernel.org>
 <20250108213632.260498-4-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8 Jan 2025, at 16:36, Anna Schumaker wrote:

> From: Anna Schumaker <anna.schumaker@oracle.com>
>
> Writing to this file will clone the 'main' xprt of an xprt_switch and
> add it to be used as an additional connection.

I like this too!  I'd prefer it was ./add_xprt instead of
=2E/xprt_switch_add_xprt, since the directory already gives the context t=
hat
you're operating on the xprt_switch.

After happily adding a bunch of xprts, I did have to look up the source t=
o
re-learn how to remove them which wasn't obvious from the sysfs structure=
=2E
You have to write "offline", then "remove" to the xprt_state file.  This
made me wish there was just a ./xprt-N-tcp/del_xprt that would do both of=

those..

=2E. and in stark contrast to my previous preference on less dynamic sysf=
s, I
think that the ./del_xprt shouldn't appear for the "main" xprt (since you=

can't remove/delete them).

=2E. all just thoughts, these look good!

>
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---
>  include/linux/sunrpc/xprtmultipath.h |  1 +
>  net/sunrpc/sysfs.c                   | 54 ++++++++++++++++++++++++++++=

>  net/sunrpc/xprtmultipath.c           | 21 +++++++++++
>  3 files changed, 76 insertions(+)
>
> diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrp=
c/xprtmultipath.h
> index c0514c684b2c..c827c6ef0bc5 100644
> --- a/include/linux/sunrpc/xprtmultipath.h
> +++ b/include/linux/sunrpc/xprtmultipath.h
> @@ -56,6 +56,7 @@ extern void rpc_xprt_switch_add_xprt(struct rpc_xprt_=
switch *xps,
>  		struct rpc_xprt *xprt);
>  extern void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
>  		struct rpc_xprt *xprt, bool offline);
> +extern struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_=
switch *xps);
>
>  extern void xprt_iter_init(struct rpc_xprt_iter *xpi,
>  		struct rpc_xprt_switch *xps);
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index dc3b7cd70000..ce7dae140770 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -250,6 +250,55 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(str=
uct kobject *kobj,
>  	return ret;
>  }
>
> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_show(struct kobject *kob=
j,
> +						   struct kobj_attribute *attr,
> +						   char *buf)
> +{
> +	return sprintf(buf, "# add one xprt to this xprt_switch\n");
> +}
> +
> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *ko=
bj,
> +						    struct kobj_attribute *attr,
> +						    const char *buf, size_t count)
> +{
> +	struct rpc_xprt_switch *xprt_switch =3D
> +		rpc_sysfs_xprt_switch_kobj_get_xprt(kobj);
> +	struct xprt_create xprt_create_args;
> +	struct rpc_xprt *xprt, *new;
> +
> +	if (!xprt_switch)
> +		return 0;
> +
> +	xprt =3D rpc_xprt_switch_get_main_xprt(xprt_switch);
> +	if (!xprt)
> +		goto out;
> +
> +	xprt_create_args.ident =3D xprt->xprt_class->ident;
> +	xprt_create_args.net =3D xprt->xprt_net;
> +	xprt_create_args.dstaddr =3D (struct sockaddr *)&xprt->addr;
> +	xprt_create_args.addrlen =3D xprt->addrlen;
> +	xprt_create_args.servername =3D xprt->servername;
> +	xprt_create_args.bc_xprt =3D xprt->bc_xprt;
> +	xprt_create_args.xprtsec =3D xprt->xprtsec;
> +	xprt_create_args.connect_timeout =3D xprt->connect_timeout;
> +	xprt_create_args.reconnect_timeout =3D xprt->max_reconnect_timeout;
> +
> +	new =3D xprt_create_transport(&xprt_create_args);
> +	if (IS_ERR_OR_NULL(new)) {
> +		count =3D PTR_ERR(new);
> +		goto out_put_xprt;
> +	}
> +
> +	rpc_xprt_switch_add_xprt(xprt_switch, new);
> +	xprt_put(new);
> +
> +out_put_xprt:
> +	xprt_put(xprt);
> +out:
> +	xprt_switch_put(xprt_switch);
> +	return count;
> +}
> +
>  static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
>  					    struct kobj_attribute *attr,
>  					    const char *buf, size_t count)
> @@ -451,8 +500,13 @@ ATTRIBUTE_GROUPS(rpc_sysfs_xprt);
>  static struct kobj_attribute rpc_sysfs_xprt_switch_info =3D
>  	__ATTR(xprt_switch_info, 0444, rpc_sysfs_xprt_switch_info_show, NULL)=
;
>
> +static struct kobj_attribute rpc_sysfs_xprt_switch_add_xprt =3D
> +	__ATTR(xprt_switch_add_xprt, 0644, rpc_sysfs_xprt_switch_add_xprt_sho=
w,
> +		rpc_sysfs_xprt_switch_add_xprt_store);
> +
>  static struct attribute *rpc_sysfs_xprt_switch_attrs[] =3D {
>  	&rpc_sysfs_xprt_switch_info.attr,
> +	&rpc_sysfs_xprt_switch_add_xprt.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(rpc_sysfs_xprt_switch);
> diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> index 720d3ba742ec..a07b81ce93c3 100644
> --- a/net/sunrpc/xprtmultipath.c
> +++ b/net/sunrpc/xprtmultipath.c
> @@ -92,6 +92,27 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_swi=
tch *xps,
>  	xprt_put(xprt);
>  }
>
> +/**
> + * rpc_xprt_switch_get_main_xprt - Get the 'main' xprt for an xprt swi=
tch.
> + * @xps: pointer to struct rpc_xprt_switch.
> + */
> +struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch =
*xps)
> +{
> +	struct rpc_xprt_iter xpi;
> +	struct rpc_xprt *xprt;
> +
> +	xprt_iter_init_listall(&xpi, xps);
> +
> +	xprt =3D xprt_iter_get_xprt(&xpi);
> +	while (xprt && !xprt->main) {
> +		xprt_put(xprt);
> +		xprt =3D xprt_iter_get_next(&xpi);
> +	}
> +
> +	xprt_iter_destroy(&xpi);
> +	return xprt;
> +}
> +
>  static DEFINE_IDA(rpc_xprtswitch_ids);
>
>  void xprt_multipath_cleanup_ids(void)
> -- =

> 2.47.1


