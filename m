Return-Path: <linux-nfs+bounces-12975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD39AFFF75
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490AE16BAB3
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208402DCF5B;
	Thu, 10 Jul 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYbTi+Lm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE022DC33D
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144170; cv=none; b=dReEX0j+g1XcGHs3Vo+8w6XK9R/6W1Yp0mFZZbxbdH1kb+n6MpB9HqP+/F94rehCJBDU0iZzSbaQQBdXmATGaw7uLaM33wXpB+tJwcHDv7BjCOI7pY8M1YnRcP2tnElpBAz+EQY8/ohenmfi3rzeGK2moZpGaOwNhK1h8nHs5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144170; c=relaxed/simple;
	bh=Qi2xN9CPi8kxytydc+W5j/C1kv7krEztkFXcmE6uBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFUEjDoWghUNBnxM/oVLRhlfXIa1ENh79tGXitMi6ZzrKDwudryEIZlptDSHwQGbKMuB3+LBRAcAVU5X6bHOXtFF4064ru9zlczJGdp2x14KI4JnG1kZmqgRPdzhgac8aNVUbzInaRlWesS/Kz65/ZYuipn07sVpVVnhKHzjwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYbTi+Lm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752144167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sll3bpBa0MX5q7fvhJLieJE4y/lWcuh1mvZXcpgpszs=;
	b=cYbTi+LmZl8ECzjaxO1A8IzYt5JD2erzhcYUaCFAzQ/LmUUwh+nWYPolOsc3mmkC4/NhWM
	USiOtaIYJ4MaEThyCHJ8GP4asXU5KPdEb/ZcibtTwkPrR4tW9wxevsyCDrheCj5KNhLz68
	r4qRiE3rsR+aXlD0ySaPrZLxbtKA+l8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-iswCAqURPFazXzORGj_Jrg-1; Thu,
 10 Jul 2025 06:42:44 -0400
X-MC-Unique: iswCAqURPFazXzORGj_Jrg-1
X-Mimecast-MFC-AGG-ID: iswCAqURPFazXzORGj_Jrg_1752144163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 882271800290;
	Thu, 10 Jul 2025 10:42:42 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 145C618002B6;
	Thu, 10 Jul 2025 10:42:40 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Laurence Oberman <loberman@redhat.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3] NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY
Date: Thu, 10 Jul 2025 06:42:38 -0400
Message-ID: <BAD83C9F-5F54-4E8C-AC57-A3DE51A9227D@redhat.com>
In-Reply-To: <aG9qCtldrjhqW-s7@infradead.org>
References: <f83ac1155a4bc670f2663959a7a068571e06afd9.1752111622.git.bcodding@redhat.com>
 <aG9qCtldrjhqW-s7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10 Jul 2025, at 3:21, Christoph Hellwig wrote:

> On Wed, Jul 09, 2025 at 09:47:43PM -0400, Benjamin Coddington wrote:
>> If the NFS client is doing writeback from a workqueue context, avoid using
>> __GFP_NORETRY for allocations if the task has set PF_MEMALLOC_NOIO or
>> PF_MEMALLOC_NOFS.  The combination of these flags makes memory allocation
>> failures much more likely.
>
> Can we take a step back and figre out why this blanket usage of
> __GFP_NORETRY exists at all?

Added in 515dcdcd48736 there's a decent explanation which boils down to: its
usually OK for nfsiod to have an allocation failure, we want it to fail
quickly and not get hung up waiting for an allocation.

Ben


