Return-Path: <linux-nfs+bounces-8497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130299EB01F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 12:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AB01881EC4
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97DE156F5F;
	Tue, 10 Dec 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdLaS79e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867E78F39
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831178; cv=none; b=jMCb4CMB6v6fwP02LW+QQWRH4Y4Ug+ejJwGyOF0ZS2trPk99O2dWjz3XgdlYjTmxPjiAHx0frw1LM2qQgXTg/WVRBFMFK0FTYPe9COY8GSSb3OL6jePCNLe8bdwxtu8jj8m98XUOe8j7rHYpiSnkJ6ZtqHfFa4BkPPeAMTRt3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831178; c=relaxed/simple;
	bh=naJBCT9RzG1fqm7R6LVsW3bYUZbaPj8Y7C5BuFuaswM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlY86YigCGjAZ8s1Sky5TEPawDNh0qdhI1jANHDJ59sCBlYwxZtyEqXTiEPA4jGdFINzUeRct6C7F/dXc5JzmE0emMrABDs9EDakB1wjAR2ItEbH6L2rDl2a32zDdJ2ZNkdAUqFwaezyUT6TvM4VNuVt2XDVdj/jQucT5D3w/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdLaS79e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733831175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pf7pbIwQyqKQPvfFgtnjf3bVfXhBc53ZJtNn5Vb1eok=;
	b=JdLaS79eIFPlyMA2fg3S+UgnIfwIFH0rLrEC5VawgBefftDckj21XBB4R507xd5WRX3My7
	PODAP+GaL8sxDc5B1bupOGNWLu1gU3ionclovrXiR9t6C2I76vlU4HUH0rc6JtXvpNOd5J
	3WM/L3GBJAUF8z2Cmx8vtaKa9MlYroI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-yAveNYuVOBe6jiw0RUQc2Q-1; Tue,
 10 Dec 2024 06:46:12 -0500
X-MC-Unique: yAveNYuVOBe6jiw0RUQc2Q-1
X-Mimecast-MFC-AGG-ID: yAveNYuVOBe6jiw0RUQc2Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A45001956088;
	Tue, 10 Dec 2024 11:46:11 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2344A19560A2;
	Tue, 10 Dec 2024 11:46:10 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
Date: Tue, 10 Dec 2024 06:46:08 -0500
Message-ID: <FB5D6967-6BB5-43F9-8561-AA8B3D020475@redhat.com>
In-Reply-To: <CALXu0UfT-M37mTF52BPP+cuFAi+gya=XeyerJgAzqXSs7Lmwcw@mail.gmail.com>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <CALXu0UfT-M37mTF52BPP+cuFAi+gya=XeyerJgAzqXSs7Lmwcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 8 Dec 2024, at 2:41, Cedric Blancher wrote:
>>> - This feature will not be provided for NFSv3
>>
>> Why shouldn't mount.nfs also support using an NFS URL to mount an
>> NFSv3-only server? Isn't this simply a matter of letting mount.nfs
>> negotiate down to NFSv3 if needed?
>
> NFSv3 is obsolete. Redhat support keeps telling us that for almost ten
> years now.

Red Hat does not consider NFSv3 to be obsolete.  We've no plans to change
our current support for it.

Ben


