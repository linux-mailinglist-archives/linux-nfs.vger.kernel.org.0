Return-Path: <linux-nfs+bounces-1722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3007E847A84
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 21:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38291F21999
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 20:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279915E5B6;
	Fri,  2 Feb 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuCb8ZNM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB328060D
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905644; cv=none; b=oB6Dm9rn2ssGzU2qSk4R6uly+o7WddBAW8wVMeHLCwRCge/uxFAyzoqeLffA7Li7APi5QgizZO/qOCscGeCuQncThq2rIHR7TwQkYWe0MXzzkoHRpfG/ybAPIqHkBy8TKgAAIgdc8h0dQXuXfF5H8wpzvL/+5QepBBAXmBwinVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905644; c=relaxed/simple;
	bh=y1GVeOlfXdIEvjtC/Akq3oijnuu7sDYVHT4scwYaMWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAewoEXrZPPcYVqhrK+CN5Uv9T3D17DuIWtwHr91KDjy0XiLLDTI/d7GX5ahcofo26Vp5IWW4IQIAoUbyJjDVRH4Xd4cjIxI5Xuj/L/fprrMLcEaxqBYhglgBQG2VglHVWjxdaypJwgTTUxWYElgZR3MTVpFw0pgphbV5yDinxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuCb8ZNM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706905641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1GVeOlfXdIEvjtC/Akq3oijnuu7sDYVHT4scwYaMWY=;
	b=TuCb8ZNMS8C8Rytg+7m1oWlPxix7hRaIEfg9sGuIBJJHtxLu2jVneQ9OqbH2LAJF6J++Kx
	i1gzHUHs/spUL91C4fSUh1+QEaE2F+9PYVKsf55FIA5ISWgyExW8y1YWhEeUowejKrXkPj
	3xnPnToEQdXBKZqVGYOyOENTwLwFsMw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-vKqMArHxOLe7koy4qnQOlA-1; Fri,
 02 Feb 2024 15:27:19 -0500
X-MC-Unique: vKqMArHxOLe7koy4qnQOlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 245401C068DE;
	Fri,  2 Feb 2024 20:27:19 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FD072026D66;
	Fri,  2 Feb 2024 20:27:18 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] NFSv4.1: add tracepoint to trunked nfs4_exchange_id
 calls
Date: Fri, 02 Feb 2024 15:27:16 -0500
Message-ID: <6DC3E1F1-E931-4437-950E-01AA45556988@redhat.com>
In-Reply-To: <20240202202113.16945-1-olga.kornievskaia@gmail.com>
References: <20240202202113.16945-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 2 Feb 2024, at 15:21, Olga Kornievskaia wrote:

> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a tracepoint to track when the client sends EXCHANGE_ID to test
> a new transport for session trunking.
>
> nfs4_detect_session_trunking() tests for trunking and returns
> EINVAL if trunking can't be done, add EINVAL mapping to
> show_nfs4_status() in tracepoints.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


