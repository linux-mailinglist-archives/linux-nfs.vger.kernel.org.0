Return-Path: <linux-nfs+bounces-1573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE49C840FED
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 18:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA391283839
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 17:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9373726;
	Mon, 29 Jan 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTH7rqIt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BEF15B2F0
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548529; cv=none; b=URLJZslsnGztLUR8TCOzqgmqcoz5fKk91b3W9066kEAuo85/RPwamwsrt0tdfLRQxtYTjpzMOkYTXsavCboTkTLrIsynDkdS0winj4ANclKf+AF74FdoVpNxnLpVO/ix0mpu4oTqZkjA1v842PCWL740ltgrXn+XPDEclyAHRos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548529; c=relaxed/simple;
	bh=XFxHN+a4xvwB1s3Q4HxPErTWn7WHFh9Lvy5NNET8JJA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CCLb3qgSiRHHipwe7vu+PqWMDBvjJoAfwlDSM/ezZTFtEugHkgmuk5UHpETX7veDytiVtRc4e61NFf+HjMFdMedViBDeuZFmiFDAfnsJFmOSAS80TGZd7jSCWJEavH8P0FbxeBLWcCy4n+2bIiJb4UNHSNiqLOCHeojqrOEaVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTH7rqIt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706548527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bQuAQGhRowVFdmmhoNiLQ1TQFCaXCXcXk9/7Zurpy6M=;
	b=KTH7rqIttOQKoBmGqGBBZR1Pn/jM4/LbmDuVUSN82r3OH0zHwbyLSmhX3p+/I6B6P4Hmou
	pGAMiuwhlaeIpi2f0Qrc0ZaRKACRtJxe7deTYOrFWwImlMX+xgTVyLGjRvQz+PIFXOOnth
	+9XMpI6vRY0qrAE/18ThP5qkZTvhrj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-HdUemSpdNditR9uIDpT4cQ-1; Mon, 29 Jan 2024 12:15:23 -0500
X-MC-Unique: HdUemSpdNditR9uIDpT4cQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CD6583B870;
	Mon, 29 Jan 2024 17:15:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 98E4E2166B31;
	Mon, 29 Jan 2024 17:15:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240129154750.1245317-1-dwysocha@redhat.com>
References: <20240129154750.1245317-1-dwysocha@redhat.com>
To: Dave Wysochanski <dwysocha@redhat.com>
Cc: dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
    linux-cachefs@redhat.com
Subject: Re: [PATCH] NFS: Fix nfs_netfs_issue_read() xarray locking for writeback interrupt
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1526806.1706548521.1@warthog.procyon.org.uk>
Date: Mon, 29 Jan 2024 17:15:21 +0000
Message-ID: <1526807.1706548521@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Dave Wysochanski <dwysocha@redhat.com> wrote:

> -	xas_lock(&xas);
> +	xas_lock_irqsave(&xas, flags);
>  	xas_for_each(&xas, page, last) {

You probably want to use RCU, not xas_lock().  The pages are locked and so
cannot be evicted from the xarray.

David


