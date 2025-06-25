Return-Path: <linux-nfs+bounces-12774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED5AE8C47
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735233AC340
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1D2D8DA4;
	Wed, 25 Jun 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5KzOUc9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50761CAA7B
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875821; cv=none; b=jt8lH+EPMw0XTvDY4jw2XOPNo3hAAqS8MwbTPbknxaYHGcw9kood+pU8WMWb+83Hkk79AcES6XDYVFhYvYQV0V46yKyjLE6abaElOjMxhvvg6wNddOw1qemJ8upXPEprZJdhhGeEbM9D3txzbUFPSgkOl7O2OdwzksfUlQ4ek9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875821; c=relaxed/simple;
	bh=Tw/+g9/20DXM6hrMTlAkevfJ/IBcxLqArA5CQYBq6ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgVBknAJ2+HHSgf+NldiSJSI7nre80xvcufAoO56v2XeUnh68y2vUHf8zM065RvXR2qveA6x3uP2mkGD3hloHV1pXx4n/BIfT3CX//4ovYi5u+6MLe98me0elZzccyKFFVCa+OYGt5cnf3VaMYyzblcVH2r3RpDxT6FqyNGXt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5KzOUc9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750875818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tw/+g9/20DXM6hrMTlAkevfJ/IBcxLqArA5CQYBq6ZI=;
	b=g5KzOUc9IMO0uEuj3efw7QBhH2vn3iu7T60GY85Yw35Id/jnkWg1ITmuVw/EC2v8fUTIBu
	Bt0SPVCgGj0+y0guhZhjvysTM8grsn9e5C6d/6FDVzOfJhQETs1DxcGBFaBra5DUF7jryJ
	hTg7BP95WHBY/MJ81oGA8ZkhnjwCYTA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-QEM-DnZ0P1qPD1oEO72zaQ-1; Wed,
 25 Jun 2025 14:23:35 -0400
X-MC-Unique: QEM-DnZ0P1qPD1oEO72zaQ-1
X-Mimecast-MFC-AGG-ID: QEM-DnZ0P1qPD1oEO72zaQ_1750875814
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02772180047F;
	Wed, 25 Jun 2025 18:23:34 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84E0519560A3;
	Wed, 25 Jun 2025 18:23:33 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Allow folio migration for the case of mode ==
 MIGRATE_SYNC
Date: Wed, 25 Jun 2025 14:23:31 -0400
Message-ID: <AC23E01F-E49F-4553-92F0-54DD652CD9C3@redhat.com>
In-Reply-To: <c0011b8a3943e35f7b63551613b9d6cd23e5428e.1750807060.git.trond.myklebust@hammerspace.com>
References: <c0011b8a3943e35f7b63551613b9d6cd23e5428e.1750807060.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 24 Jun 2025, at 19:17, Trond Myklebust wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> When the mode is MIGRATE_SYNC, we are allowed to call nfs_wb_folio()
> under the folio lock.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


