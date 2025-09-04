Return-Path: <linux-nfs+bounces-14049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B854B44656
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 21:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28103BEF53
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7BD271475;
	Thu,  4 Sep 2025 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVIeXcQb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0527144B
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014003; cv=none; b=n7AHD7UjDadIX2ZUvsFeanEMmVFCuLCUro/2w6i4YtmoCRD61bvVHk+y7BRmVOZPCYQo+Zz6b66G7j+tnSL93gZKTknwgf64M9/aysu47a7n/QeqQypivluhkMsntq6T9rSO2ryp3vGxoj/5EeF20gUMtyRek6AxoI4NjfNYLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014003; c=relaxed/simple;
	bh=zaSNqNWr/ozA6Ijh9En3MDPWxOwBsI+hHrcq5pxJ/mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtFN0XHeU7bBCdtRVhFm9Rp+sYzPpt6EsHMYV93064sUeDiPQkK/EgRjM8uA8Dgwujl953zbtpDESK4IKhk+T42tAIUpkozq+NX+PJu0osLjV45587JKoTeGJWLQAOYxNEdfgk4e4TWvcHuuJMh7JPsAlcsG3LuN9ddBNlX1/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVIeXcQb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757014000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dac3Dl60syEmIm3dGi2bHfeTJ2Rbg7LOh3H/HPUT6/U=;
	b=KVIeXcQbeaTw4rRa6H4vglWRWgFWrLKuWzbG9CExaof+7X1E4mBN8Nl9ipZPRScHS2IRxR
	3LeQiWtsI3wkfF5q+wy75iPoyW73DxGzQChFLdRk5fTRz+MgicA+YaCKbCZTjVNVUdojKq
	INu+vkKSgF9GCbkoTf3M3LfDr8tOc2M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-zb8rTkA8O7SfBrtN72BJ9Q-1; Thu,
 04 Sep 2025 15:26:37 -0400
X-MC-Unique: zb8rTkA8O7SfBrtN72BJ9Q-1
X-Mimecast-MFC-AGG-ID: zb8rTkA8O7SfBrtN72BJ9Q_1757013996
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCFE119560B4;
	Thu,  4 Sep 2025 19:26:35 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 618661800452;
	Thu,  4 Sep 2025 19:26:35 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 9B73B42EE90; Thu, 04 Sep 2025 15:26:33 -0400 (EDT)
Date: Thu, 4 Sep 2025 15:26:33 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: delete unnecessary NULL check in __fh_verify()
Message-ID: <aLnn6ZngnxAR8tXW@aion>
References: <aLnhkm7q1Di0IiIu@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLnhkm7q1Di0IiIu@stanley.mountain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, 04 Sep 2025, Dan Carpenter wrote:

> In commit 4a0de50a44bb ("nfsd: decouple the xprtsec policy check from
> check_nfsd_access()") we added a NULL check on "rqstp" to earlier in
> the function.  This check is no longer required so delete it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Scott Mayhew <smayhew@redhat.com>

-Scott
> ---
>  fs/nfsd/nfsfh.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 062cfc18d8c6..3edccc38db42 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -403,9 +403,7 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;
>  
> -	/* During LOCALIO call to fh_verify will be called with a NULL rqstp */
> -	if (rqstp)
> -		svc_xprt_set_valid(rqstp->rq_xprt);
> +	svc_xprt_set_valid(rqstp->rq_xprt);
>  
>  check_permissions:
>  	/* Finally, check access permissions. */
> -- 
> 2.47.2
> 


