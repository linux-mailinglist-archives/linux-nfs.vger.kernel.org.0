Return-Path: <linux-nfs+bounces-1259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90908375C1
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A10B244F6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1A48CC6;
	Mon, 22 Jan 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJjT56Ii"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528C48CCE
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960890; cv=none; b=NLD44xylSeWx+v7RgIQBovZMWWKRLNOTl2VSw5KDdoN8+91qkhpYeemec949V7xVGYoDq8ybR3RYF0TLlvZqSqqKQODRpIPSXeuB8qfZgB7flJzg8wagJBN6tpIHtRORyIe3zO22ZzARJUD8jSaSI1TlNutD5HhJ92Om5XUxHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960890; c=relaxed/simple;
	bh=V1yJVFjM67labChbznd10CJnK+mwAgP7GMH9rMtUC+s=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=U7/avl5MPpJlId089wNduHYcRTY+E+dXUl0fSKEYXsJWNS3aHQFaZuCOciL466Xa7yKL0ethB5V6kQ/yVZfqMuaSP6KuiqJVGwSXEcEO3dUm4B2gvjNTuaXYK8lb3QoF+38dmvtrDD1BFykupL+O16rBSTbYAznla/iBbQFyh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJjT56Ii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705960887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YgorZ9y1ABigf+8AfYUUWexSMaoGg5QlyfBL6eKu5CY=;
	b=RJjT56IiUiW5b9TpNIT0/HVi3FAPwuSwEv3AvB3nsUngLqALCnVEA/uqOA8ADEmUJNqAXJ
	UP+YTHj6buCM6BCX4vsnljfXgTN7WZ2Tl+63I41ONlFoAZiqTAdKeIIIYXm5gopmLDOZ7f
	K0GbZPGvxYuSs/Kwtg3lJ3CuNLEVMgA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-FVBxaMfkOUaLwqIkj88Zsg-1; Mon, 22 Jan 2024 17:01:24 -0500
X-MC-Unique: FVBxaMfkOUaLwqIkj88Zsg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9621845E60;
	Mon, 22 Jan 2024 22:01:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77F78492BC6;
	Mon, 22 Jan 2024 22:01:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <7790423f-665e-44cc-b4ae-d3f3d2996af5@linux.alibaba.com>
References: <7790423f-665e-44cc-b4ae-d3f3d2996af5@linux.alibaba.com> <20240122123845.3822570-1-dhowells@redhat.com> <20240122123845.3822570-7-dhowells@redhat.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
    Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH 06/10] cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3980815.1705960879.1@warthog.procyon.org.uk>
Date: Mon, 22 Jan 2024 22:01:19 +0000
Message-ID: <3980816.1705960879@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> > -	ret = cachefiles_ondemand_init_object(object);
> > -	if (ret < 0)
> > -		goto err_unuse;
> > +	if (object->ondemand) {
> > +		ret = cachefiles_ondemand_init_object(object);
> > +		if (ret < 0)
> > +			goto err_unuse;
> > +	}
> 
> I'm not sure if object->ondemand shall be checked by the caller or
> inside cachefiles_ondemand_init_object(), as
> cachefiles_ondemand_clean_object() is also called without checking
> object->ondemand. cachefiles_ondemand_clean_object() won't trigger the
> NULL oops as the called cachefiles_ondemand_send_req() will actually
> checks that.

Meh.  The above doesn't actually build if CONFIG_CACHEFILES_ONDEMAND=N.  I
think I have to push the check down into cachefiles_ondemand_init_object()
instead.

David


