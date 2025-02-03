Return-Path: <linux-nfs+bounces-9835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28FA25B2F
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 14:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BBE161385
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221B201026;
	Mon,  3 Feb 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9PWS4Ad"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532DF1E87B
	for <linux-nfs@vger.kernel.org>; Mon,  3 Feb 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590176; cv=none; b=j1ALjRrAtN4RTppz1kDckPkaA1uhppiWNSEOf0dS9KHknwqemPSiQdIIWu1+Vhm7Lget/fmOkme56ykuzYHmxWdcBpNFWXrtTJwcNYeSyJmneW0CdVgm6t4EiiJBXil+p0a0uRp3wBzWTw6j1wOAlbBZZWbnFlwWdM8ZAQtY1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590176; c=relaxed/simple;
	bh=dmrkMnZM0GllmoQHFowbeFdkoXyiHTAekUaKtQfQLiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgRfKNMO+QBbrCqq52/BCPQFwP7VKAIeR/5oFtOT7dGu9bHr9YBeR9OM7oO73lnH2Llaqq/uKaIKzbiQqFRrfQ5OlMASp+pAAGOHyIMD3EITjcLS00RNKBxzCtcg3mKKLRzuuYqSPKU3CgLMEVK8YM2f355nHRnH2YGyyxapYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9PWS4Ad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738590173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWlvFP5jw6tk+K0UFzBVKLRUI+2vRbIo1H1X992dgwU=;
	b=D9PWS4Adg1H6nVbNil5NieJJ44uqx6eCGjBEqIfFl0+Vt57AXGsildcj3dyY9bap2sEyGR
	UhG3hicvFOg+ZeLrapUMnhObFJwki+faiz8Jw3h4QGWc6m85zLwelwuE3QxRNUU8O9s74F
	fOiKD8LoVcYScL5/T3hv/TVC2YrLwEA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-YNFxbdTyPoyR7bwYH87z7Q-1; Mon,
 03 Feb 2025 08:42:49 -0500
X-MC-Unique: YNFxbdTyPoyR7bwYH87z7Q-1
X-Mimecast-MFC-AGG-ID: YNFxbdTyPoyR7bwYH87z7Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2CB01801F1A;
	Mon,  3 Feb 2025 13:42:48 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B727A1800365;
	Mon,  3 Feb 2025 13:42:46 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH v2 3/5] sunrpc: Add a sysfs files for rpc_clnt information
Date: Mon, 03 Feb 2025 08:42:44 -0500
Message-ID: <AD9EDEA0-B643-4441-B5F9-4D939E185E40@redhat.com>
In-Reply-To: <20250127215019.352509-4-anna@kernel.org>
References: <20250127215019.352509-1-anna@kernel.org>
 <20250127215019.352509-4-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 27 Jan 2025, at 16:50, Anna Schumaker wrote:

> From: Anna Schumaker <anna.schumaker@oracle.com>
>
> These files display useful information about the RPC client, such as th=
e
> rpc version number, program name, and maximum number of connections
> allowed.
>
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---
>  net/sunrpc/sysfs.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 73 insertions(+)
>
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index dc3b7cd70000..0d382ab24f1f 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -59,6 +59,16 @@ static struct kobject *rpc_sysfs_object_alloc(const =
char *name,
>  	return NULL;
>  }
>
> +static inline struct rpc_clnt *
> +rpc_sysfs_client_kobj_get_clnt(struct kobject *kobj)
> +{
> +	struct rpc_sysfs_client *c =3D container_of(kobj,
> +		struct rpc_sysfs_client, kobject);
> +	struct rpc_clnt *ret =3D c->clnt;
> +
> +	return refcount_inc_not_zero(&ret->cl_count) ? ret : NULL;
> +}
> +
>  static inline struct rpc_xprt *
>  rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
>  {
> @@ -86,6 +96,51 @@ rpc_sysfs_xprt_switch_kobj_get_xprt(struct kobject *=
kobj)
>  	return xprt_switch_get(x->xprt_switch);
>  }
>
> +static ssize_t rpc_sysfs_clnt_version_show(struct kobject *kobj,
> +					   struct kobj_attribute *attr,
> +					   char *buf)
> +{
> +	struct rpc_clnt *clnt =3D rpc_sysfs_client_kobj_get_clnt(kobj);
> +	ssize_t ret;
> +
> +	if (!clnt)
> +		return sprintf(buf, "<closed>\n");
> +
> +	ret =3D sprintf(buf, "%u", clnt->cl_vers);
> +	refcount_dec(&clnt->cl_count);
> +	return ret;
> +}
> +
> +static ssize_t rpc_sysfs_clnt_program_show(struct kobject *kobj,
> +					   struct kobj_attribute *attr,
> +					   char *buf)
> +{
> +	struct rpc_clnt *clnt =3D rpc_sysfs_client_kobj_get_clnt(kobj);
> +	ssize_t ret;
> +
> +	if (!clnt)
> +		return sprintf(buf, "<closed>\n");
> +
> +	ret =3D sprintf(buf, "%s", clnt->cl_program->name);
> +	refcount_dec(&clnt->cl_count);
> +	return ret;
> +}
> +
> +static ssize_t rpc_sysfs_clnt_max_connect_show(struct kobject *kobj,
> +					       struct kobj_attribute *attr,
> +					       char *buf)
> +{
> +	struct rpc_clnt *clnt =3D rpc_sysfs_client_kobj_get_clnt(kobj);
> +	ssize_t ret;
> +
> +	if (!clnt)
> +		return sprintf(buf, "<closed>\n");
> +
> +	ret =3D sprintf(buf, "%u\n", clnt->cl_max_connect);
> +	refcount_dec(&clnt->cl_count);
> +	return ret;
> +}
> +
>  static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
>  					   struct kobj_attribute *attr,
>  					   char *buf)
> @@ -423,6 +478,23 @@ static const void *rpc_sysfs_xprt_namespace(const =
struct kobject *kobj)
>  			    kobject)->xprt->xprt_net;
>  }
>
> +static struct kobj_attribute rpc_sysfs_clnt_version =3D __ATTR(rpc_ver=
sion,
> +	0444, rpc_sysfs_clnt_version_show, NULL);
> +
> +static struct kobj_attribute rpc_sysfs_clnt_program =3D __ATTR(program=
,
> +	0444, rpc_sysfs_clnt_program_show, NULL);
> +
> +static struct kobj_attribute rpc_sysfs_clnt_max_connect =3D __ATTR(max=
_connect,
> +	0644, rpc_sysfs_clnt_max_connect_show, NULL);

Wants 0444 here.

Ben


