Return-Path: <linux-nfs+bounces-2857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EFB8A77E9
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 00:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764F71C22519
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289213A403;
	Tue, 16 Apr 2024 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jk4tJJuf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6106C138495
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307257; cv=none; b=jK2njKS6gw/1+Fs6e3NOkQfQabJEtceQtcyM/TYyStacaUcD2dhrgL+PaS4vbvPsQYT+Ce9hyPQbkinn1MSlwjTYU3aufoKx5pU3Iftk3KJUkYOFoEaDg8/RuzA1l9egVGNtDptoVjNAjRsn7N6mygBmB9GhrU3vJqAhKTxKcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307257; c=relaxed/simple;
	bh=N5nwDmbhe++pDB3bapq0vGCRdzBr3y4GS9c/nfTtZFY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=DwyIhFF43q3VNRM7LEChPi28B2nhcHyhTpXmV1Lvjq3/mMdupW2WRJ3QnnWs4IRKTpxefJd2H5A9hqJJNMt72gmsnloTYIARwZmnYxX7g7MLlHwy9k0tLyljSOa9DVhsbdXJuiuwBP5LPKPi4QYKeQxR1S98LvWDfMqAbk10BvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jk4tJJuf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713307254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5nwDmbhe++pDB3bapq0vGCRdzBr3y4GS9c/nfTtZFY=;
	b=Jk4tJJufgQknmnMhP5+X/FfuNKSApglDE0HCFWXGQ5CLF5YltzWETjuiEe8T1ocR0vvMh4
	9VRQhht1g6JhqR2PnxRp7VuZuSD+vy+s+2/fBVZy3uSbubMyEKozPel1Ws+wLBABPGq10r
	2/v5pQCg6NBxxiI7/F61B7dbZ8BwXbw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-Ck5vkIIGNTuza5woUV3wRQ-1; Tue,
 16 Apr 2024 18:40:49 -0400
X-MC-Unique: Ck5vkIIGNTuza5woUV3wRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F39E21C05149;
	Tue, 16 Apr 2024 22:40:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6583339DCA;
	Tue, 16 Apr 2024 22:40:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5msFoGAE79pS5bEt5T8a60LU82mdjNdpfe0bG4YpvY8t-g@mail.gmail.com>
References: <CAH2r5msFoGAE79pS5bEt5T8a60LU82mdjNdpfe0bG4YpvY8t-g@mail.gmail.com> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-2-dhowells@redhat.com> <39de1e2ac2ae6a535e23faccd304d7c5459054a2.camel@kernel.org> <2345944.1713186234@warthog.procyon.org.uk>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <christian@brauner.io>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
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
    linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH 01/26] cifs: Fix duplicate fscache cookie warnings
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2754965.1713307239.1@warthog.procyon.org.uk>
Date: Tue, 16 Apr 2024 23:40:39 +0100
Message-ID: <2754966.1713307239@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Steve French <smfrench@gmail.com> wrote:

> Should this be merged independently (and sooner? in rc5?)

It's already upstream through the cifs tree and I've dropped it from my
branch.

David


