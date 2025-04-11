Return-Path: <linux-nfs+bounces-11105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED36AA85BFE
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 13:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C46E9C196C
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91C278E4B;
	Fri, 11 Apr 2025 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T10u2biL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D929CB54
	for <linux-nfs@vger.kernel.org>; Fri, 11 Apr 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371254; cv=none; b=hFshbOGDGG6GfM8qI8ZIFbvqkzl/xujtbUiCyCLYkU+WOYJOOTE4Qese/WP6eL5BsUJGfCMO/EXuQ98rnxxdHlzEtiZXwqjE7Jz2JCe1/PjJM/LPlcMdClROLOIezN6LZSTES76isMflzfupudoxEXlhA8DL77859b/6zMTcR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371254; c=relaxed/simple;
	bh=uE7xrA8IBj9EeIPl3m2MoDcXeIc4kpnSQil7p33Rs6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIkRUKLFweIAh9+fTQAa/cfhrj/potuTOlFBVUjIP8ArQBUidDQxH+e9BpYEYCKwdKxDOhEieBBI5uyjAuBBJETR0CaTY+RHNLdHrmGMtwSlJaNSCXfJZAqAE4jywtVSImRckZfpy2U6KFgi1rRDqlNDFbJDDvpee8/3bu7hJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T10u2biL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744371252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uE7xrA8IBj9EeIPl3m2MoDcXeIc4kpnSQil7p33Rs6o=;
	b=T10u2biLOLdLeTMi4s37nvZvYtWT5WZhHCALcmxf5MnkFhB6R5rSV3gH3o74+6IDFOWsjT
	C67WbNZ94x26HvhKLBgTFQN1EKr54yZxUqHhY1+VfVVgfKN7px5EqoaKsxD9PuUB6Ta4rW
	/wzgf5TtwBb/yPf7Rh+k5OB2aNGTPg8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-aj8SgROlOaGHGeP7Flps4g-1; Fri,
 11 Apr 2025 07:34:08 -0400
X-MC-Unique: aj8SgROlOaGHGeP7Flps4g-1
X-Mimecast-MFC-AGG-ID: aj8SgROlOaGHGeP7Flps4g_1744371247
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1F26180025F;
	Fri, 11 Apr 2025 11:33:55 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 616A41809B63;
	Fri, 11 Apr 2025 11:33:52 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfs: nfs3acl: drop useless assignment in nfs3_get_acl()
Date: Fri, 11 Apr 2025 07:02:53 -0400
Message-ID: <A5D4FA3C-CD08-4F6C-B220-082CA6246D8D@redhat.com>
In-Reply-To: <c32dced7-a4fa-43c0-aafe-ef6c819c2f91@omp.ru>
References: <c32dced7-a4fa-43c0-aafe-ef6c819c2f91@omp.ru>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 9 Apr 2025, at 16:36, Sergey Shtylyov wrote:

> In nfs3_get_acl(), the local variable status is assigned the result of
> nfs_refresh_inode() inside the *switch* statement, but that value gets
> overwritten in the next *if* statement's true branch and is completely
> ignored if that branch isn't taken...
>
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


