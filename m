Return-Path: <linux-nfs+bounces-2637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660E898879
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 15:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6191F23A22
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ABE12E7E;
	Thu,  4 Apr 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2uMgI7T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B172E401
	for <linux-nfs@vger.kernel.org>; Thu,  4 Apr 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235869; cv=none; b=oTGXzP9auCdxrs/FBokKwjkIdsD8RWDBMWhLWR1I7CmqrzRwLCKQhptoouOPrDfDMjRbCoEJwdtAKktcLcqcKWUi/goAN5689EejeqgLWgal28v0JQk051P7WBXl01WsyQ7LPbXCERC8Lq+REnDQHKSCj+e0ugIcpSbMgSjiR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235869; c=relaxed/simple;
	bh=uSyEK5OiugxceipyjCNDUvQIQqs6b1Kf/kvgRWnJMW0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bG+2x821Z+cpHTYde3c5o/wTDyv6cc5d45Dvw+GpRmL2bdf7oEy0hlvyBjSJVFarNnSbx3+q5NkU8L0VA6uGF3XdTJtTyeR4EW/wb97rucr/WHNxdT0vlsWigXy2esUDzx7HRaML/oMa6oCj3JR80mBHJa4rPz+abgWzUYS/aXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2uMgI7T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712235867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4g4N9yKXelCmOiKWJZ2f1A2vviHVjaXSyy4DAuVPmD8=;
	b=Y2uMgI7TBeezTItv4j3KKCMV4a95/9wB34YZMgR4Qew9651fYi6r9dfEXCo5BBeHoZVizJ
	EEW/GR39Wepw5cvZQsGdFsm1rGJDQ0ypZRo3xn3SXnz+ywcJnBMOyrPMraTDIXxwNf1HmI
	CoffTAp0nbWZN/2GGioAgTvvjAocpDs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-vC0W5VbyM8ukohTHz4HI8Q-1; Thu, 04 Apr 2024 09:04:23 -0400
X-MC-Unique: vC0W5VbyM8ukohTHz4HI8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3011085A5B5;
	Thu,  4 Apr 2024 13:04:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5562110E4B;
	Thu,  4 Apr 2024 13:04:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <171215477898.1643.12386933275741788356.stgit@klimt.1015granger.net>
References: <171215477898.1643.12386933275741788356.stgit@klimt.1015granger.net>
To: Chuck Lever <cel@kernel.org>
Cc: dhowells@redhat.com, linux-nfs@vger.kernel.org,
    Jan Schunk <scpcom@gmx.de>,
    Alexander Duyck <alexander.duyck@gmail.com>,
    Jakub Kacinski <kuba@kernel.org>,
    Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2] SUNRPC: Fix a slow server-side memory leak with RPC-over-TCP
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3747894.1712235857.1@warthog.procyon.org.uk>
Date: Thu, 04 Apr 2024 14:04:17 +0100
Message-ID: <3747895.1712235857@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Chuck Lever <cel@kernel.org> wrote:

> That commit assumed that sock_sendmsg() releases all the pages in
> the underlying bio_vec array, but the reality is that it doesn't.
> svc_xprt_release() releases the rqst's response pages, but the
> record marker page fragment isn't one of those, so it is never
> released.

More like the network layer will take its own refs and drop those when it is
done.  As you say, it doesn't release the caller's refs.

Reviewed-by: David Howells <dhowells@redhat.com>


