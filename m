Return-Path: <linux-nfs+bounces-11110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1AA85FCE
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5C71BA5486
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374186F30F;
	Fri, 11 Apr 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7BDzRiH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D331D95B3
	for <linux-nfs@vger.kernel.org>; Fri, 11 Apr 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379915; cv=none; b=H2Sa5LzN4mXK7Dk+ejhi9/UeocWy/jMPH9WeEtmO3DyjkRjJm2oro6e7A0p+gRmBspUiDyetlqfOm8N67dH3c+ls5WdhIPiBof1yGp0jwLz65q0vShHARzukHKYNuV/32bHpYZsvWc684q25v01qfFYN7v/fPSg34QmdPaTVi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379915; c=relaxed/simple;
	bh=vDnLG72LCYd10fHlImIqsQps4BBiquf11s9rZSx7hyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iw6snfDbkGRDNiSBlfcm1hkRizAsSm5+wEjGf8arfdUDcQsrGJCabq1glPmMzWHSckoH+ejqnjwdCdqj4J8iUTDjOaia4zS1enakdT04EIdKAou16gUrYlfOYw3D456vMm7ifU8tektrTEw5ET2jSM8GfyGV+/n+EwC17SGGbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7BDzRiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744379912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkb2rwVHMrQO1vrCc1zgV2cwtlIuml/FIIAdKay+62E=;
	b=c7BDzRiHTidn8I/brcxUBI5ghJEjmOZcUj7khvAg+WEWDK5G2FJf6i3Z8Qf5LY+1I7uzUx
	8gpVdZ9A4fAlyWKjueBb8ZLH1JxLs+sQyWUFDNg0PM924XejiSAUJziDja3BHIcfakq1gx
	/Nfum6xrxObyLLd6sdN7Y7q8hmiUIP8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-h-qS1FRYO-y5ttDd6TFTNQ-1; Fri,
 11 Apr 2025 09:57:19 -0400
X-MC-Unique: h-qS1FRYO-y5ttDd6TFTNQ-1
X-Mimecast-MFC-AGG-ID: h-qS1FRYO-y5ttDd6TFTNQ_1744379838
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6ABD180034D;
	Fri, 11 Apr 2025 13:57:17 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21A7419560AD;
	Fri, 11 Apr 2025 13:57:15 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Omar Sandoval <osandov@osandov.com>, Sargun Dillon <sargun@sargun.me>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nfs: don't share pNFS DS connections between net
 namespaces
Date: Fri, 11 Apr 2025 09:57:13 -0400
Message-ID: <1587C44B-7BDE-4B36-8CE6-C654CB154228@redhat.com>
In-Reply-To: <20250410-nfs-ds-netns-v2-1-f80b7979ba80@kernel.org>
References: <20250410-nfs-ds-netns-v2-0-f80b7979ba80@kernel.org>
 <20250410-nfs-ds-netns-v2-1-f80b7979ba80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10 Apr 2025, at 16:42, Jeff Layton wrote:

> Currently, different NFS clients can share the same DS connections, even
> when they are in different net namespaces. If a containerized client
> creates a DS connection, another container can find and use it. When the
> first client exits, the connection will which can lead to stalls in

                                         ^^ close ?

> other clients.
>
> Add a net namespace pointer to struct nfs4_pnfs_ds, and compare those
> value to the caller's netns in _data_server_lookup_locked() when
> searching for a nfs4_pnfs_ds to match.
>
> Reported-by: Omar Sandoval <osandov@osandov.com>
> Reported-by: Sargun Dillon <sargun@sargun.me>
> Closes: https://lore.kernel.org/linux-nfs/Z_ArpQC_vREh_hEA@telecaster/
> Tested-by: Sargun Dillon <sargun@sargun.me>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me,

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


