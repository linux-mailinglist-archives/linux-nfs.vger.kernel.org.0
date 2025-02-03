Return-Path: <linux-nfs+bounces-9836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE0A25B36
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 14:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951FD1885580
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E38201026;
	Mon,  3 Feb 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHvkcHKP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44941E87B
	for <linux-nfs@vger.kernel.org>; Mon,  3 Feb 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590231; cv=none; b=ri4M59NNsu7uC4l1Oq8jNFkTlk9SLHxUlN9nDDx5qgD/IARXHXJCCEPmqNDGKUdHnUnKIiusKwH/HYqXZ8uviBiyrOYdGfXfxGdDRqQJOFDyGmW6qn30HMSvnoglokt3LHgxC8vS6NgKRl1iX09T1EkK6ARP6JQkf4/1UtftNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590231; c=relaxed/simple;
	bh=RdhXdp84QCQJxwuCClEQyuFVIORLzL3L0V6w0J6e6Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsMBY47iw7P8bvaD2jLoBWfIeiznC3UbosUtWy8bmKO3v91iuu+oWQGVhN91q3AS0gi7LYQZWC85MVUC7r9sPaFFImy7OFR0UacZbQiZEi3nclTd4FnPV0XBaqs4POFIyONKa82bwAeOW+GQTVwbdU1/7OGWQWv0j0B4iC39Z4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHvkcHKP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738590228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdhXdp84QCQJxwuCClEQyuFVIORLzL3L0V6w0J6e6Vs=;
	b=KHvkcHKPbWmYZqAdmsDqD/XsODz9b5fqZJSirtyYNmw1WyTCLD3miz7fpO5prvoy6BMTWu
	7vPbtnm14iRkNsyYXapRpF282ZF16dQs2o4pVCs3d2XCc0iZh9fLIGatrZ0iC+fee8IMJ5
	rCKUOAgcqlx44iuqthCBV9TWEuWum/4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-oWGnkn47O1akk1LrcvFweA-1; Mon,
 03 Feb 2025 08:43:47 -0500
X-MC-Unique: oWGnkn47O1akk1LrcvFweA-1
X-Mimecast-MFC-AGG-ID: oWGnkn47O1akk1LrcvFweA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7644B1801F29;
	Mon,  3 Feb 2025 13:43:46 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97D6518008C8;
	Mon,  3 Feb 2025 13:43:45 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH v2 0/5] NFS & SUNRPC: Sysfs Improvements
Date: Mon, 03 Feb 2025 08:43:43 -0500
Message-ID: <780CB71B-6C2E-42AB-8596-3A68D2799DD5@redhat.com>
In-Reply-To: <20250127215019.352509-1-anna@kernel.org>
References: <20250127215019.352509-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 27 Jan 2025, at 16:50, Anna Schumaker wrote:

> From: Anna Schumaker <anna.schumaker@oracle.com>
>
> These are a handful of improvements that have been in the back of my
> mind for a while. The first patch adds a (read-only) file to the NFS
> client's sysfs collection to check the server's implementation id. The
> remaining patches are on the sunrpc side.
>
> I did look into the 'nconnect' and 'max_connect' NFS client mount
> options and how they interact with adding a new xprt in patch 4. My
> reading is that 'nconnect' is just the initial number of connections
> made by the NFS client during mounting. That shouldn't disallow adding a
> new connection. The 'max_connect' parameter refers to the maximum number
> of unique IP addresses in an xprt switch. The new connection I generate
> is a clone of the main xprt, not a new address, so this doesn't come
> into play either. So I'm convinced adding a new xprt is okay to do here.
>
> Thoughts?
> Anna

Looks great, one minor comment on 3/5.

For series:
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


