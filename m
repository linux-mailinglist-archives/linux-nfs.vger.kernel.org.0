Return-Path: <linux-nfs+bounces-9334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6EA14B33
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 09:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6EC3A827E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44831F91FF;
	Fri, 17 Jan 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgQdy7mT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302571F91EF
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102631; cv=none; b=Mfb5+pdQ/3PVKoisDiooimRmArzA6lgUzV6Ml8XBcnW/HNObDH8bD/zj9/OJPHCzOweHvSY0T/but1CwzxdqxFaX5xwudzJn8kh+3JKMaX8pPUcGWReK7dMKT9UZV9x6Fjbiqp++Cx4DI9vPR+p/08douFLagO3/jXteN+V4wyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102631; c=relaxed/simple;
	bh=d/g53UtwtoeMdjaT+R1dbBcyNXXLezqX3/UcNtC6vm0=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=FbqLRmGUxxC7iL0kVwz0D0zXz/xsgeADUuYMEV3s7qQCUS60BGcMvV0n4/ZmdZi8KKDslQtDJGUztYOlezvTRPKJM7MZE3+DIoejMs8JIiyGmCcCAm33d3BRqzmcKq+M2X1Gmg67XoDHcNA1vBlbZ8dbkGS7y59jYLi9kY4/cjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgQdy7mT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737102629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HDiFi/c6f0Cw5829523ALaPbNuqbpB2s/qFVysdO5PY=;
	b=MgQdy7mTdJ1gX7UMrHv8q6FgSZt8x9Fe48pOasrd4BuLZkpQ8TXc4Rx67sHZ/FEvhAsUQM
	QgzQjpyi5K27YeCPuOAROsfwEmb2hfAvsyaPcY3WBCxGkutBXz+zpUi5xPHi8Dc/1vn2et
	MJC7pVnoU0/kfx2eKKTir/+Gva+kRbs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-a2EhEHctOkyte2ur2SK5Cg-1; Fri,
 17 Jan 2025 03:30:24 -0500
X-MC-Unique: a2EhEHctOkyte2ur2SK5Cg-1
X-Mimecast-MFC-AGG-ID: a2EhEHctOkyte2ur2SK5Cg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EFD51955D72;
	Fri, 17 Jan 2025 08:30:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B92C19560BF;
	Fri, 17 Jan 2025 08:30:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <477969.1737101629@warthog.procyon.org.uk>
References: <477969.1737101629@warthog.procyon.org.uk> <Z4Ds9NBiXUti-idl@gondor.apana.org.au> <20250110010313.1471063-1-dhowells@redhat.com> <20250110010313.1471063-3-dhowells@redhat.com>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through AEAD API
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <493306.1737102616.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jan 2025 08:30:16 +0000
Message-ID: <493307.1737102616@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

David Howells <dhowells@redhat.com> wrote:

> > rfc8009 is basically the same as authenc.
> =

> Actually, it's not quite the same :-/
> =

> rfc8009 chucks the IV from the encryption into the hash first, but authe=
nc()
> does not.  It may be possible to arrange the buffer so that the assoc da=
ta is
> also the IV buffer.

Actually actually, it's the starting IV, so I just need to chuck in a bloc=
k of
zeroes.

David


