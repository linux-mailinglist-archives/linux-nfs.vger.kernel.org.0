Return-Path: <linux-nfs+bounces-2869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0128A7F1E
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D05AB21C64
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F5012E1F7;
	Wed, 17 Apr 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnNrZPK1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1091292F2
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344693; cv=none; b=hWf7D4Q0jlh6FBbTPrQdfPZQZ2th37a+DlOls3MUc9BXPdsMcV1cLkB/4NeUnbYXo61GquyMqQojrJF8GZB4wc2DmefOg7R1JMOPgt+RRjrkCknW93vAymQBhm3qPf0cXuOaTnfEBEk+iS5P4a44VkMMAReBih8An+AsIGypyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344693; c=relaxed/simple;
	bh=qPI0pCxxPzUoBEsI0BzOZn8buvMBR2S+RPSF+No4b5c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=DfTn3yVi/Anw9xb5I7zZnG6B3IarKezOKfXzoy/qSlZOcHGKpYECnz+8FMwhesAZ4QqjZwEFQ5XIMZBz7VZ+xrOg9EriwxbjI+9utVD17XfGEqpzrNMBqRM35cvrbM1FRLVYcuL0utngKYlw1Cariv4TYISbJCBxLDGkshpGaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnNrZPK1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713344691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0o9cqWvopzRGIbQrWEpYy4RFrMHbVHwEFIkzoBARCg=;
	b=FnNrZPK19qJObcJ224UBeH6OrIfQtP6PryM+rmUkZCFxQbp8rffuQLGeaGLyA6tMQrqRNd
	3tpj/SXMTxGnpUW/3vZeNv6fJEVh9QjKWP1eqa9SwuS+SP+kBhuscgSwd6ut7+3Pmu+JKJ
	6I2S66IiKhT+ovXnXujSKpNDbvmN1zs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-NWduv8-0ObmjjPW5VGH_hQ-1; Wed, 17 Apr 2024 05:04:44 -0400
X-MC-Unique: NWduv8-0ObmjjPW5VGH_hQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A15C806528;
	Wed, 17 Apr 2024 09:04:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24BDC490DD;
	Wed, 17 Apr 2024 09:04:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <f555b324b79829d6fc63da0d05995ce337969f65.camel@kernel.org>
References: <f555b324b79829d6fc63da0d05995ce337969f65.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-18-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/26] netfs: Fix writethrough-mode error handling
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28313.1713344659.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 10:04:19 +0100
Message-ID: <28314.1713344659@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Jeff Layton <jlayton@kernel.org> wrote:

> Should this be merged independently? It looks like a bug that's present
> now.

Yes.  I've just posted that as a separate fix for Christian to pick up.  I
still need to keep it in this set, though, until it is upstream.

David


