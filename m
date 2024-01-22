Return-Path: <linux-nfs+bounces-1253-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73C7836EAA
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206901C28B38
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897BD3FB11;
	Mon, 22 Jan 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8AjW0bj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32751036
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944164; cv=none; b=WTSK6teAzNe4BFE1DGkYWr6NX8TnvT55qa194w/kyEfJItbLSWtMVvcTbwfaNlTUg7DgDHO1fH3dE8ZoS/Z0Vu02UB1tOM71ibBsMt2jO9wCkmYpHYUTwTq7mTRsU8XgjhfTJXTKuydzP8K/3itrI6H8vO2Vt8uAPQO0U6GyFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944164; c=relaxed/simple;
	bh=BK4/OCHtn9ZOarkwg23KKNRxOtPDGGPmaFy8ysvVxZ8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KF2Xdd/K4GIy5EG/8QJwHKVzhrlT/U7vnNYdTaX2N4ZHTrHAC7brP4FY5Hwf2ETaW0oKPSGTkEY+OgOLLAGnqo7HL7ootS/oZbGJ9JiepVoub9hsXTkRPeWzNmawvbOtb/Z+CXD1EqshYRfLMMRUCNJkmNVr3ZO6f0h92RKytFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8AjW0bj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyL8HkrfuDx15VmmUYeIG1cK/wCgWeV9TZeHPttzNv8=;
	b=Y8AjW0bjKzSyHDl22UwAH4NUILapVKrsgzyxZFWR6t1XrQ/Zr24jLJX5DnZjJoCqw/XOtd
	GErEetLPZSN8kZU5ARlQyzX0P607f/0vfN2wBqOMinoasrLWA9CE9oeehCQAevl1zt3FnV
	/E0+5CxD2AJDNWN13XMGgf4aXcQHMxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-HhQdjMHnNSCeJf9HAxnqqg-1; Mon, 22 Jan 2024 12:22:35 -0500
X-MC-Unique: HhQdjMHnNSCeJf9HAxnqqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A236285A597;
	Mon, 22 Jan 2024 17:22:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B2C10C0FDCA;
	Mon, 22 Jan 2024 17:22:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org>
References: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org> <20240122123845.3822570-1-dhowells@redhat.com> <20240122123845.3822570-2-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [PATCH 01/10] netfs: Don't use certain internal folio_*() functions
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3931925.1705944151.1@warthog.procyon.org.uk>
Date: Mon, 22 Jan 2024 17:22:32 +0000
Message-ID: <3931926.1705944152@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Jeff Layton <jlayton@kernel.org> wrote:

> > Filesystems should not be using folio->index not folio_index(folio) and
> 
> I think you mean "should be" here.

Ach.  I forgot to update the patch descriptions!

David


