Return-Path: <linux-nfs+bounces-2991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F0A8B1FDC
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F45283432
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912622EE8;
	Thu, 25 Apr 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2Bun+CE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8A1CFA9
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043108; cv=none; b=uNIVs0BDSRMkz7hORtKS4qH0NQW745n+rwvuUU5HXnpodUfLtBTtDXzmM6/sc41mxamMYXw4Q7YRbhuyPvIuosnST/vgSy7MOACEy/jpBA0uYLq2g0TReWyl2iCAI0Jgz3z4VwwXNS+tWMBnjBMxQ2RwFejN53aoakpJBqwH5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043108; c=relaxed/simple;
	bh=8uVSQxT4sg6b6b2+KrgT5cx/6eDIK0JkScoenMNMm1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HR+i7o42xexoZDcCBfclHlo8e0GGWkm2Cg66l7043SpRbpOxKkzerfYnVflKIuRPFfmi2dRb2McmzxfXMn7ei3G/UHwXqDSGkgAi2v2S6dPRw4vBiofcByMNfO77GM3B4y8Tqa0wrg/1qw6wT6USj1P/vCXyopVdYRznS9mQipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2Bun+CE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714043105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mAWzo/DIIcKHOW3+D8JKaAzaXSHi4m5CIEM6KQ05Nk=;
	b=e2Bun+CE0HRXW7o7Aus9WZppSx0YGp5KpYrR4QzjSZmt86dz5HCkkj2getSNACQzcmZG9o
	os0d58/0VHm268gK0SIplbfEmVTg8wn6z0Mh4y+qt2F1FxJ4CeXiAoHF5JFtmCUPJ59UbX
	LvbYV9e6IVMb5wal0bYnXs5dBlMNtTA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-tSbmoXDMMTuhidg-HiwrUg-1; Thu,
 25 Apr 2024 07:05:00 -0400
X-MC-Unique: tSbmoXDMMTuhidg-HiwrUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 410201C106A4;
	Thu, 25 Apr 2024 11:05:00 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AA751C0F136;
	Thu, 25 Apr 2024 11:04:59 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: trondmy@hammerspace.com, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] sunrpc: fix NFSACL RPC retry on soft mount
Date: Thu, 25 Apr 2024 07:04:58 -0400
Message-ID: <E0350193-7373-4C04-9AC9-D9126DCD2714@redhat.com>
In-Reply-To: <20240425104938.3363417-1-dan.aloni@vastdata.com>
References: <20240425104938.3363417-1-dan.aloni@vastdata.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 25 Apr 2024, at 6:49, Dan Aloni wrote:

> It used to be quite awhile ago since 1b63a75180c6 ('SUNRPC: Refactor
> rpc_clone_client()'), in 2012, that `cl_timeout` was copied in so that
> all mount parameters propagate to NFSACL clients. However since that
> change, if mount options as follows are given:
>
>     soft,timeo=3D50,retrans=3D16,vers=3D3
>
> The resultant NFSACL client receives:
>
>     cl_softrtry: 1
>     cl_timeout: to_initval=3D60000, to_maxval=3D60000, to_increment=3D0=
, to_retries=3D2, to_exponential=3D0
>
> These values lead to NFSACL operations not being retried under the
> condition of transient network outages with soft mount. Instead, getacl=

> call fails after 60 seconds with EIO.
>
> The simple fix is to pass the existing client's `cl_timeout` as the new=

> client timeout.
>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Link: https://lore.kernel.org/all/20231105154857.ryakhmgaptq3hb6b@gmail=
=2Ecom/T/
> Fixes: 1b63a75180c6 ('SUNRPC: Refactor rpc_clone_client()')
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>

This also affects the local rpcbind, and makes the change in
6b996476f364 sunrpc: honor rpc_task's timeout value in rpcb_create()
redundant.  Just an observation, thanks for fixing this!

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

> ---
>  net/sunrpc/clnt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index cda0935a68c9..07ffd4ee695a 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1068,6 +1068,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_=
clnt *old,
>  		.version	=3D vers,
>  		.authflavor	=3D old->cl_auth->au_flavor,
>  		.cred		=3D old->cl_cred,
> +		.timeout	=3D old->cl_timeout,
>  	};
>  	struct rpc_clnt *clnt;
>  	int err;
> -- =

> 2.39.3


