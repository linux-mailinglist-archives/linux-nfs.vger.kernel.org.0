Return-Path: <linux-nfs+bounces-7729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC369BF67F
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 20:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDBA1C21F1D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5003A201115;
	Wed,  6 Nov 2024 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex+f9a29"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1DA18C903
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921417; cv=none; b=jyvjgyw3hxf6YT88NKL5lSgQATz5IZ3ZzvZeaKBXo9s6zNRiWnsjp5L58WUguQ52JABqtIeCV5UmiT1tSEcP/ElUlbCuDcXvCvCy540ax5pkC6Kw4zyBhjZfMHNqh3wjnNRMOwF0chn5pGxDrZcVe6VoJlEtTfx3bLAj1/phXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921417; c=relaxed/simple;
	bh=LYPx2RY7qWthrzmKtNx04Q/EDCTv0h2uWzWbldndaB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+4feX8ECYi5xfVzPTBu2UegjKdvkE0VAXOvOEOoh7ssfk7quzfG+VuT+QBXI3CgHD0LGlnsn0Yk7bDoqoO7cseAIEcWnIyocRbd8QYndQoiP8Uvl1a8lCIJI5q++aXF3rnBy4JOoWS3jsy+z1w6cVFWTKNZlCEzQhoXw3GCv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex+f9a29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730921414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYPx2RY7qWthrzmKtNx04Q/EDCTv0h2uWzWbldndaB8=;
	b=ex+f9a29zxgKW92XksMDP5QaunwtIUIr632Mc+pK51NvsG1Zed+w9XjGhoemoZSmozvZxA
	gzq+THrtuYbqSPVQTXz9XV9JucuCo11PEGoYny6Y2NEg4b/TdU2sev3RR/5K9UujRfAwul
	f1tJ9fZmU7XIFJHaHfSGgJQ/9sAAYjE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-Wl2NuUOLOLOFwl2VZQJD2A-1; Wed,
 06 Nov 2024 14:30:13 -0500
X-MC-Unique: Wl2NuUOLOLOFwl2VZQJD2A-1
X-Mimecast-MFC-AGG-ID: Wl2NuUOLOLOFwl2VZQJD2A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A926C19560A3;
	Wed,  6 Nov 2024 19:30:11 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 939991955F41;
	Wed,  6 Nov 2024 19:30:10 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "open list:NFS" <linux-nfs@vger.kernel.org>,
 "SUNRPC, AND LOCKD CLIENTS)," <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_sysfs_link_rpc_client(): Replace strcpy with strscpy
Date: Wed, 06 Nov 2024 14:30:08 -0500
Message-ID: <8A472C39-0EC9-469F-B568-012BC794C3D5@redhat.com>
In-Reply-To: <20241106024952.494718-1-danielyangkang@gmail.com>
References: <20241106024952.494718-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 5 Nov 2024, at 21:49, Daniel Yang wrote:

> The function strcpy is deprecated due to lack of bounds checking. The
> recommended replacement is strscpy.
>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


