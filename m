Return-Path: <linux-nfs+bounces-2462-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507AD88A5DF
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 16:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038EC1F61E3D
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC8146D40;
	Mon, 25 Mar 2024 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF+cAyVX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFBA14D443
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369316; cv=none; b=miAVuUpMNi/R3XsJJE/ZmfWtMwAwoUsREXbwwbcapof9VPhFysCnaDHq2BoqqDDDPgdWKKiFK/XD/RKYatzhLT7DQB4Y6ycRnuqRAJuKTTy7FmyHmcn5UdR9FxsDdVKkDnGoNFBltSyMHhZ3E7Q9BzCT1SfxLTnRUmWPQu48Z34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369316; c=relaxed/simple;
	bh=p3/BSuytQSZOv+MKuGN3TeinAdsCcQGErJQHkpfqqjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDOTq1XCBoqBXbU5w4F/1AdgOzCeVjmlDMZ9cgt0Y0BW9obhjVUNDPtgnMWvdeGL1cT7VDRzSvR0n+yhkzg1nJoiVGuGGWLizBJ5QSLDmsqQcK+tQlAspLdO+D+1XF6B60XFgPGt0iThnkD0nAM71iZyocJXrQSyFJcIZRQR0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FF+cAyVX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711369314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3/BSuytQSZOv+MKuGN3TeinAdsCcQGErJQHkpfqqjc=;
	b=FF+cAyVXcBUp8lA1s6grTUuBp8woyUqhajQTQGzKT6RoyJSiLj3lCwkl9ANv+/kN6ty8aE
	OtjghZmQv2OgGFucsu/3fGkOMHN8UQNXpV/LGKPGL1DmtHuYy4i3PApbpJP1mp4zX/AsUZ
	4vRzq/SmrUaYmZ+QPQG2zEFzT04uxVo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-qPARdqfLNzmJohshGSwJzA-1; Mon, 25 Mar 2024 08:21:50 -0400
X-MC-Unique: qPARdqfLNzmJohshGSwJzA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CC3584B065;
	Mon, 25 Mar 2024 12:21:50 +0000 (UTC)
Received: from [100.115.132.116] (unknown [10.22.50.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C6630492BD3;
	Mon, 25 Mar 2024 12:21:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: "svc_tcp_read_marker nfsd RPC fragment too large" with Linux 6.6
 LTS nfsd ...
Date: Mon, 25 Mar 2024 08:21:28 -0400
Message-ID: <B119F413-D9A5-494A-8981-5FF1A493D99F@redhat.com>
In-Reply-To: <CAKAoaQng8vUV2uHNwNxhcL-d17ULPqO0iCSUmVKHunfSaHLMTg@mail.gmail.com>
References: <CAKAoaQng8vUV2uHNwNxhcL-d17ULPqO0iCSUmVKHunfSaHLMTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 22 Mar 2024, at 7:11, Roland Mainz wrote:

> Hi!
>
> ----
>
> After updating my Debian 11 and RHEL 9 installations with Linux kernel
> 6.6.20-rt25 I start getting the following error messages
> "svc_tcp_read_marker nfsd RPC fragment too large".
> Client side is Linux NFSv4.2 client (Debian&&RHEL, both default kernel
> and Linux 6.6.20-rt25)+ms-nfs41-client HEAD.
>
> Is this a know issue, and is there a patch for it ?


I could be mistaken, but isn't the server complaining that the client is
sending requests larger than ca_maxrequestsize?

Ben


