Return-Path: <linux-nfs+bounces-13407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF2B1A709
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B57163F4C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B220B800;
	Mon,  4 Aug 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOinsD4t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87917137C2A
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323680; cv=none; b=emcS55uAyy0Xqq75zJwjPxjmkaz54qHJIWCc3IfHd1qKBAf2dgjuW4e4vfyrUVb5I0Mu3691833vxMG2m7c0tWPrRpxljSUKmXB/wbrDcH42m1zh0GSRbwzlAWQEupZ8a7QRVXLJK1dYWulO8Oul/CLO0O70IY1lUwq0mKUjSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323680; c=relaxed/simple;
	bh=U3fY7qGm8WgkKOtu+Ew2yGfVCGp40ccaurP1suB3ETk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibq6RV85DYCnBikQF3fHRjtCw4CIn2CQVXNzZBVZax/y4yGR1QhFCz9wyWbIsOx6k3ytEozt/vn5GZfodxGDLW/U+hyozpQOa2XgkkR0bjSZTTwZO2MshZYnK3EQC3b5LX5KuZ5r4t5jXzy2PT94WCrQoLpgKYkptx73GXFDXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOinsD4t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754323677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3fY7qGm8WgkKOtu+Ew2yGfVCGp40ccaurP1suB3ETk=;
	b=EOinsD4tY+UzpdLxPnFTzpwK5aLLtu9IRNGJQH02YJxKImyZOEKWybK6+zmxBs+Lm3DDo4
	JT2WVLCub3hFS6uHePEwVMmuB7zqdSzGr21Qr0OCNz1xFniobTzT3EaZkwRZWrqQ7qndx3
	S0TtDXxdJ9L8Ic05KEafkD2F5eAO68M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-i1YSG_VpP5mxjHZLsy6c4w-1; Mon,
 04 Aug 2025 12:07:50 -0400
X-MC-Unique: i1YSG_VpP5mxjHZLsy6c4w-1
X-Mimecast-MFC-AGG-ID: i1YSG_VpP5mxjHZLsy6c4w_1754323668
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4212A195D026;
	Mon,  4 Aug 2025 16:07:48 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B246E1954B04;
	Mon,  4 Aug 2025 16:07:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] NFS: Fix the setting of capabilities when
 automounting a new filesystem
Date: Mon, 04 Aug 2025 12:07:45 -0400
Message-ID: <4ADF43F3-A45E-4C38-94D3-DA82B7D53F32@redhat.com>
In-Reply-To: <488da9a6a16ddd9bccc755448ccdf2832638f502.1754270543.git.trond.myklebust@hammerspace.com>
References: <cover.1754270543.git.trond.myklebust@hammerspace.com>
 <488da9a6a16ddd9bccc755448ccdf2832638f502.1754270543.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 3 Aug 2025, at 21:29, Trond Myklebust wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Capabilities cannot be inherited when we cross into a new filesystem.
> They need to be reset to the minimal defaults, and then probed for
> again.
>
> Fixes: 54ceac451598 ("NFS: Share NFS superblocks per-protocol per-server per-FSID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


