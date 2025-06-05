Return-Path: <linux-nfs+bounces-12137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D0ACF4D2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7A316C447
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59169272E41;
	Thu,  5 Jun 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNdtHzi/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F1274FF0
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142489; cv=none; b=r6TuknwvdO6m5aoRj9PBkWq97oWG4muuCB9qt0vFgnY4cIGa6dvgj3C0iJu+q9hRInOQm1ARqBYN0upBA54VT+dTLvsdNQd4F8Ad9gTul5TGZjbS9kgYDNm9AvxFK1WikNW8OuTdKIufsc4F995EDdEVS3Lv0dEtJ2ipfvzc7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142489; c=relaxed/simple;
	bh=K5oSDua7qP+cHboaB4BNpCoLtZbY3QcK4i4Dr6x2mzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FP/o2S2EFBwZNGRF/v6mtLT/9JsTcTHinrH1vd3al/hO1a2lRNNtpsch2zw3GpvDjNK1ov9u2g4XjZo8m5FYC9oL+eYgt39nxcroE1s0BJt6p++ynUfFxXE2khk+nyRcGx8VruJQTPxqKbLLwXQj+VXVRKKq6aq0EC+Uv0odbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNdtHzi/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749142486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REunxKtmpzwjcLnJcn2L8WAGz80v+ogDHLIH8Cn1NEo=;
	b=KNdtHzi/w246p8LnY3YueoN/N9zUmXh0kr/9kT7TYXWRdbh3s5xuVME77eO096C8StqDTs
	cBk/OUk3g0utnYEJzIADiH4wAMslmKHd6ZgNS40we0SttkDZ9+UPKoaOYHjpMT3p9bEp1m
	NNQX7vaiM48zGf5fT9aJKKR82Ry/0gc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-q3U9SPClMeyEtDRoVh7Ffw-1; Thu,
 05 Jun 2025 12:54:41 -0400
X-MC-Unique: q3U9SPClMeyEtDRoVh7Ffw-1
X-Mimecast-MFC-AGG-ID: q3U9SPClMeyEtDRoVh7Ffw_1749142480
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8A66195608E;
	Thu,  5 Jun 2025 16:54:39 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8643D18002B9;
	Thu,  5 Jun 2025 16:54:38 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Cleanup/fix initial rq_pages allocation
Date: Thu, 05 Jun 2025 12:54:36 -0400
Message-ID: <80457CF6-99FE-4EB5-BC07-F4A8D9A8D8D1@redhat.com>
In-Reply-To: <cdb4ce81-c05f-4e60-b351-34d713a51e96@oracle.com>
References: <458f45b2b7259c17555dd65aa7cdbbf1a459d5e6.1749131924.git.bcodding@redhat.com>
 <cdb4ce81-c05f-4e60-b351-34d713a51e96@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 5 Jun 2025, at 10:26, Chuck Lever wrote:

> This doesn't apply to v6.16-rc1 due to recent changes to use a
> dynamically-allocated rq_pages array. This array is allocated in
> svc_init_buffer(); the array allocation has to remain.

Well, shucks.  I guess I should be paying better attention.

Can we drop the bulk allocation in svc_init_buffer if we're just going to
try it more robustly in svc_alloc_arg?  Else we probably would need to grow
the same retry machinery in svc_init_buffer since the bulk allocator expects
it.

Ben


