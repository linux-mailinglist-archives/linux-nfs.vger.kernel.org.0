Return-Path: <linux-nfs+bounces-386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D9808C2B
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 16:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F61F21206
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6AF4596C;
	Thu,  7 Dec 2023 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3d+K9dZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1C10F1
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 07:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701964107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dirxUUjQYZtSpNeI1RF/bfETlI5tLKa7Fg66TYNIoXw=;
	b=P3d+K9dZVFrg0/KbL9SgKXE2UgCX2cr7diG/NKuHNKuLUrhR96fmCWFC8AUd271oZdQxQT
	9hKYNc5HuQX6HfbZbJLOLsSS/LTXxLEpfadrNeEO+/CII699RSJS6QF1ZyMziqEsAvnuAL
	83MN/JNiMjGBpLZyZM6jsvMmLXIb46A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-n1sQ4MzfOQaUwUMkdFQTXw-1; Thu, 07 Dec 2023 10:48:24 -0500
X-MC-Unique: n1sQ4MzfOQaUwUMkdFQTXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99EEA85A59C;
	Thu,  7 Dec 2023 15:48:24 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3002E3C2E;
	Thu,  7 Dec 2023 15:48:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: spurious backchannel -ETIMEDOUT and reset on v6.7-rc1
Date: Thu, 07 Dec 2023 10:48:22 -0500
Message-ID: <F8E8E80E-C4FB-4243-8A18-A4D2F242B112@redhat.com>
In-Reply-To: <3B324BE9-874E-487E-B6E4-E83889B30803@redhat.com>
References: <3B324BE9-874E-487E-B6E4-E83889B30803@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 7 Dec 2023, at 10:25, Benjamin Coddington wrote:

> Hey Trond,
>
> I've been noticing slower than usual xfstests, and in the logs:
>
>  "RPC: Could not send backchannel reply error: -110"
>
> Since "59464b262ff5 SUNRPC: SOFTCONN tasks should time out when on the
> sending list", some backchannel reqs will immediately reset the connection
> if they need to sleep on ->sending in xprt_reserve_xprt.
>
> I don't think we set up rq_timeout and rq_majortimeout for backchannel reqs,
> so they immediately fail with -ETIMEDOUT.
>
> I'm hunting around for the best fix, but maybe you've got one I can test.

Assuming we want backchannel reqs to actually check/timeout/reset, I think
its looking like we need to do a version of xprt_init_majortimeo() for every
xprt_get_bc_request()..

Ben


