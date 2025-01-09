Return-Path: <linux-nfs+bounces-9019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3399FA0794C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 15:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E763A412D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECB21B19F;
	Thu,  9 Jan 2025 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgemNqqb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56791217652
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433198; cv=none; b=k/TzBZs35BTz8p5JBUyczkexUvmGUfPeXQbM6vK/E1VwlIUdN+E/un0aJA+SkpBy096/AvH5XrE2FncvqjRa3aV7XYF6/mnMpIbBVWdzoFBH3hwRsqnVg7ycieytLaD1oIkF/MmDffz6FcmW2nT+YnYmcQowxcinibNgH250ZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433198; c=relaxed/simple;
	bh=2IiqzLo15QDTgx3pNQnMhlFUgn3N3MSRlBUCQq5QrRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kb1e22sUeSBd+0Khq+eFjU8pjVQHsW38gR1WnzeTnSG+bFq33aHtoGzR/e5v29T8wlbEnCiJRGlO1NwX0k+DfMXmm7r+4+wZnW/P9V9yfUSiLctfZGhlLEtqCF/1a10ysdZhzHqOGAzFrJQfhDIXT2Pw67x1DE/FBo0H5l9P+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgemNqqb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736433194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lJFL/x4hcwWn2NViwmUSUTFWkPSrB35uv18Wzt5aNI=;
	b=cgemNqqbB9B4zgatuDxaoeAz+7ORp/Qe+Yp/0AnUm3Sci70rWTkNeM8eH2wqp9/qB6Ugp9
	BgrrX516kauMO6jqtOJnZJJoeHTBvgmfRgZRMjTL7hRFOTbqiePlM0lyjRXNVCkUsOnbLL
	SEonxxKL5G4bG6qeo2/qL/o7QXCNTcM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-0qqC7XEFNKquFgvT1_VTRA-1; Thu,
 09 Jan 2025 09:33:09 -0500
X-MC-Unique: 0qqC7XEFNKquFgvT1_VTRA-1
X-Mimecast-MFC-AGG-ID: 0qqC7XEFNKquFgvT1_VTRA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E4841955DA8;
	Thu,  9 Jan 2025 14:33:08 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B2C119560AB;
	Thu,  9 Jan 2025 14:33:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH 1/3] NFS: Add implid to sysfs
Date: Thu, 09 Jan 2025 09:33:05 -0500
Message-ID: <0430CAB9-DDCA-4DE7-B377-1AE485FB731E@redhat.com>
In-Reply-To: <20250108213632.260498-2-anna@kernel.org>
References: <20250108213632.260498-1-anna@kernel.org>
 <20250108213632.260498-2-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 8 Jan 2025, at 16:36, Anna Schumaker wrote:

> From: Anna Schumaker <anna.schumaker@oracle.com>
>
> The Linux NFS server added support for returning this information durin=
g
> an EXCHANGE_ID in Linux v6.13. This is something and admin might want t=
o
> query, so let's add it to sysfs.

I agree that admins will want to know (and they might not yet know they w=
ant
to know), good idea!

A couple comments..

> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---
>  fs/nfs/sysfs.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 79 insertions(+)
>
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index 7b59a40d40c0..6b82c92c45bf 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -272,6 +272,32 @@ shutdown_store(struct kobject *kobj, struct kobj_a=
ttribute *attr,
>
>  static struct kobj_attribute nfs_sysfs_attr_shutdown =3D __ATTR_RW(shu=
tdown);
>
> +#if IS_ENABLED(CONFIG_NFS_V4_1)
> +static ssize_t
> +implid_domain_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				char *buf)
> +{
> +	struct nfs_server *server =3D container_of(kobj, struct nfs_server, k=
obj);
> +	struct nfs41_impl_id *impl_id =3D server->nfs_client->cl_implid;
> +	return sysfs_emit(buf, "%s\n", impl_id->domain);
> +}
> +
> +static struct kobj_attribute nfs_sysfs_attr_implid_domain =3D __ATTR_R=
O(implid_domain);
> +
> +
> +static ssize_t
> +implid_name_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				char *buf)
> +{
> +	struct nfs_server *server =3D container_of(kobj, struct nfs_server, k=
obj);
> +	struct nfs41_impl_id *impl_id =3D server->nfs_client->cl_implid;
> +	return sysfs_emit(buf, "%s\n", impl_id->name);
> +}
> +
> +static struct kobj_attribute nfs_sysfs_attr_implid_name =3D __ATTR_RO(=
implid_name);
> +
> +#endif /* IS_ENABLED(CONFIG_NFS_V4_1) */
> +
>  #define RPC_CLIENT_NAME_SIZE 64
>
>  void nfs_sysfs_link_rpc_client(struct nfs_server *server,
> @@ -309,6 +335,33 @@ static struct kobj_type nfs_sb_ktype =3D {
>  	.child_ns_type =3D nfs_netns_object_child_ns_type,
>  };
>
> +#if IS_ENABLED(CONFIG_NFS_V4_1)
> +static void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
> +{
> +	struct nfs_client *clp =3D server->nfs_client;
> +	int ret;
> +
> +	if (clp->cl_implid && strlen(clp->cl_implid->domain) > 0) {

Can we create the files and leave them empty if the strings are not set?
Having an empty file might be a nice prompt for an implementation to star=
t
sending values.  I also have a slight preference for a less dynamic sysfs=
=2E

> +		ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid_d=
omain.attr,
> +					   nfs_netns_server_namespace(&server->kobj));
> +		if (ret < 0)
> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> +				server->s_sysfs_id, ret);
> +
> +		ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid_n=
ame.attr,
> +					   nfs_netns_server_namespace(&server->kobj));
> +		if (ret < 0)
> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> +				server->s_sysfs_id, ret);
> +
> +	}
> +}
> +#else /* CONFIG_NFS_V4_1 */
> +static inline void nfs_sysfs_add_nfsv41_server(struct nfs_server *serv=
er)
> +{
> +}
> +#endif /* CONFIG_NFS_V4_1 */
> +
>  void nfs_sysfs_add_server(struct nfs_server *server)
>  {
>  	int ret;
> @@ -325,6 +378,32 @@ void nfs_sysfs_add_server(struct nfs_server *serve=
r)
>  	if (ret < 0)
>  		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>  			server->s_sysfs_id, ret);
> +
> +	nfs_sysfs_add_nfsv41_server(server);

I think you didn't mean to send the hunk below.  :)

Ben

> +
> +/*	if (server->nfs_client->cl_serverowner) {
> +		ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_serverow=
ner.attr,
> +					nfs_netns_server_namespace(&server->kobj));
> +		if (ret < 0)
> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> +				server->s_sysfs_id, ret);
> +	}
> +
> +	if (server->nfs_client->cl_serverscope) {
> +		ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_serversc=
ope.attr,
> +					nfs_netns_server_namespace(&server->kobj));
> +		if (ret < 0)
> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> +				server->s_sysfs_id, ret);
> +	}
> +
> +	if (server->nfs_client->cl_implid) {
> +		ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid.a=
ttr,
> +					nfs_netns_server_namespace(&server->kobj));
> +		if (ret < 0)
> +			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> +				server->s_sysfs_id, ret);
> +	}*/
>  }
>  EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
>
> -- =

> 2.47.1


