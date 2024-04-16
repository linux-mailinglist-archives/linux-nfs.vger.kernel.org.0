Return-Path: <linux-nfs+bounces-2860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD908A7848
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 01:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1D01C232FC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6D13A415;
	Tue, 16 Apr 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lvh0Z5fM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB866EB4C
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308604; cv=none; b=b1jYub564h4ta/N/eJnjVq6Qr1D3HPhqJlhBZ5dYjrUYneNdx+wOJLD01BbLvA45F60OA8t+dde7EhlSftYwEsVp8FFObd7PsmUJ7kg5H+m4VI4aWvujCssQnl1YnjuLPnb84zZeEG4Tos+JytJtMcEQR3gRDMwdV6TXuUVaFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308604; c=relaxed/simple;
	bh=DNSKqIczlyBwuQ67ZFkxtx1MZSnOD27Vgyxg6uryKIE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kb8vHjqMRssiB+rIMhBj5DOTJ1ncsg9WSQMccGvLArGb+yiVL2mlu1YkZNT8NcJXY0aov3Dwg8j2jGeVERxBIuYAbydyeJz5wUOapHAyAgt1MQRTKN2tzIue2tZq5gVTi3meG3Cv1dIIiAdcdtDfBpjcQL4gau5msFyd/o0KTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lvh0Z5fM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713308601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omkePlcDB8enwqcFXRle7B6BhP/V3w40pUO+LmEoCqU=;
	b=Lvh0Z5fMAwbVrYEwtHPv3osqiAesVAbuF2WvT9/VBqjI/ikcZhHZK6/PmtfXWNAE4fj5k3
	e0IksAdbSfOI+UnBMK7rqeCDUn1vcsJykAP4MsHfqTsmDOsgbW1QNditMXbVtGof4NUWzu
	OC0nbQWDzbB78yI8Q5Qg8AM62/Mox9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-HZB_5gEsP8-Mrh_g6kWHzA-1; Tue, 16 Apr 2024 19:03:20 -0400
X-MC-Unique: HZB_5gEsP8-Mrh_g6kWHzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADE98803513;
	Tue, 16 Apr 2024 23:03:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3961BDAA;
	Tue, 16 Apr 2024 23:03:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <9b7de2417924192fb411744171015877c1d4c677.camel@kernel.org>
References: <9b7de2417924192fb411744171015877c1d4c677.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-12-dhowells@redhat.com>
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
    linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 11/26] 9p: Use alternative invalidation to using launder_folio
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2756051.1713308590.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 00:03:10 +0100
Message-ID: <2756052.1713308590@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jeff Layton <jlayton@kernel.org> wrote:

> Shouldn't this include a call to filemap_invalidate_inode? Is just
> removing launder_folio enough to do this?

Good point.  netfs_unbuffered_write_iter() calls kiocb_invalidate_pages() -
which uses invalidate_inode_pages2_range() to discard the pagecache.  It
should probably use filemap_invalidate_inode() instead.

David


