Return-Path: <linux-nfs+bounces-9404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB552A172F5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 20:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15CC3AA684
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0ED1F1934;
	Mon, 20 Jan 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ogdkx4Lb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA841F191D
	for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399596; cv=none; b=irvPntNd3tP/HpTatXM63Qg6kEHaNyFJxYH+hPSDbwXUHZlLILt4i5qS5QxwIKxRHEOrh80YAWmiAZ9FlyUC9JBA6touAsv7e+S2prC5IziFs2qjfrc0d+ZU5f5E5/P47Sl10V6cMWr1xYIPQQuUf80tOOseUglvWkDYKcnps4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399596; c=relaxed/simple;
	bh=Ls1w6WAZHqAu+rKTuk9SnEmg6HlNyISTMJ4PCXdFLCM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pEVbIRlZ4Y0ixyrmqBzY7OnjylrxtV6siQUIZO8/4RRNx/Zwpvp2R2BvXTk/bn/fvjZlzfqAmC7whRVaGHlfjiJ1WNzsaYgNb0/j668sHdwq6tEnAg6zabVFmbgFUD2oaXYA93ZyFZGMOQNwXbwGMbxlTsT96BhP7xMmRR8uUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ogdkx4Lb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737399594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+iwfJA5iVvxl+Bip7TYLzvSBg2GTpA1L9rYj66ARLZ4=;
	b=Ogdkx4LbgE5rQ6AhFDhuk6mQ1rOVGiVgCm779V73nQAnmltZtlzU3aicUxk6kP20vzIjYO
	/oeICSSMhx98CA4twe2Ro8kPBz5Cl6aUEGkH4jVLHpC+vVy6O+s6Im4SI7CXkjunR/UOku
	BUxzP2kS4NWu82XkZEBv8inEDUhEXpU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-iEfANEuSOWKUq3mmmokOjQ-1; Mon,
 20 Jan 2025 13:59:49 -0500
X-MC-Unique: iEfANEuSOWKUq3mmmokOjQ-1
X-Mimecast-MFC-AGG-ID: iEfANEuSOWKUq3mmmokOjQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5B93195608A;
	Mon, 20 Jan 2025 18:59:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8816919560A7;
	Mon, 20 Jan 2025 18:59:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250120173937.GA2268@sol.localdomain>
References: <20250120173937.GA2268@sol.localdomain> <20250120135754.GX6206@kernel.org> <20250117183538.881618-1-dhowells@redhat.com> <20250117183538.881618-4-dhowells@redhat.com> <1201143.1737383111@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, Simon Horman <horms@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1212969.1737399580.1@warthog.procyon.org.uk>
Date: Mon, 20 Jan 2025 18:59:40 +0000
Message-ID: <1212970.1737399580@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Eric Biggers <ebiggers@kernel.org> wrote:

> Multiple requests in parallel, I think you mean?  No, it doesn't, but it
> should.

Not so much.  This bug is on the asynchronous path and not tested by my
rxrpc/rxgk code which only exercises the synchronous path.  I haven't tried to
make that asynchronous yet.  I presume testmgr also only tests the sync path.

David


