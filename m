Return-Path: <linux-nfs+bounces-10898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED6A7150D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 11:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AB2173961
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228C1B78F3;
	Wed, 26 Mar 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jr+aV+ZP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6F19F48D
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985805; cv=none; b=a0+C+2jyYQUi+z8YpOjtBVYxfUhgLhw8htkMfBrSIlf/wVDlgz2nCgQU8kUqpW9xib3csXz2QOTAqlNg2aN8YvmU9xmamUI42O39Xy00bV+4Azqr0IkBAWItEyIwSwMDCh3QRZ7l05BdXI3vRmFgd/pqbvKupN1n7NzVjr/8LZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985805; c=relaxed/simple;
	bh=EEh38pOjTnDvT8q+QNWpuxnQRM1AtznfRfuj5VuXfw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVp9qyv1qOvWhxTDqEY+InwdJy+b1wKMKaNKmiHITUS2xlb2W9QwDXRs6EXAQs+T06EC2wCX/jcwmLD4Y8QOVTaTN3NI/tyIfgnOu8yOSeUZolqMoPPG0DvBG11CRZcE6hm65WYbq3jgDA9nyUTzp7Ut56r4M08FXIkFWd1HeE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jr+aV+ZP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742985803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8m+q/TL4RXDW2lhuPJFCgLuX/x9zgQTvOe4SQw6qKU=;
	b=Jr+aV+ZPIUefoHSwA0/QqRnfq8ACKhncxXCHEyI7wUPeTRo+rPnKuFZ0i0Em7Y4819VkaP
	BRC4eZCPaniVyzozKJYZ2yeojcEgZ3mNh82HmGbkbL1m7/ignGfqEN3OBMMrG0s6ZLi5sr
	EDYOxxV+tDTTXHzXJWoHFld1cgsEhZk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-Gf2vPx7SMFSXfTn5h1qdLg-1; Wed,
 26 Mar 2025 06:43:21 -0400
X-MC-Unique: Gf2vPx7SMFSXfTn5h1qdLg-1
X-Mimecast-MFC-AGG-ID: Gf2vPx7SMFSXfTn5h1qdLg_1742985800
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FB021800EC5;
	Wed, 26 Mar 2025 10:43:20 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1F9B1800944;
	Wed, 26 Mar 2025 10:43:19 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/6] SUNRPC: rpcbind should never reset the port to the
 value '0'
Date: Wed, 26 Mar 2025 06:43:17 -0400
Message-ID: <6161CDDF-5922-4BB1-903E-C00A8B48AA40@redhat.com>
In-Reply-To: <b8af12ef4fb9b3f0a3b22b23d13c573df3367ee8.1742941932.git.trond.myklebust@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
 <b8af12ef4fb9b3f0a3b22b23d13c573df3367ee8.1742941932.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 25 Mar 2025, at 18:35, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If we already had a valid port number for the RPC service, then we
> should not allow the rpcbind client to set it to the invalid value '0'.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/rpcb_clnt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
> index 102c3818bc54..53bcca365fb1 100644
> --- a/net/sunrpc/rpcb_clnt.c
> +++ b/net/sunrpc/rpcb_clnt.c
> @@ -820,9 +820,10 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
>  	}
>
>  	trace_rpcb_setport(child, map->r_status, map->r_port);
> -	xprt->ops->set_port(xprt, map->r_port);
> -	if (map->r_port)
> +	if (map->r_port) {
> +		xprt->ops->set_port(xprt, map->r_port);
>  		xprt_set_bound(xprt);
> +	}
>  }
>
>  /*
> -- 
> 2.49.0

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


