Return-Path: <linux-nfs+bounces-6157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58502969D6B
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 14:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9857B20B12
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A471C7685;
	Tue,  3 Sep 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sjat4Cy+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D741B12F0
	for <linux-nfs@vger.kernel.org>; Tue,  3 Sep 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366302; cv=none; b=MwDpLlQdwsyOM6kBV1EUZ9D3Ybk/6KB5i5d/sOsET94cc/MAn8X44etP30qA/RD1O3hAJ2AYA0smaUdSGmLeu2Nh5KI9sjYkSqF3T0tBfCowxbaJNxYp+aSwOzNQQXKFpoVYrke3jXWSkw1OEwUFtzojovD4yv0GPqbpGLMA/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366302; c=relaxed/simple;
	bh=CrPIZuNFAn8C+KcaHJBf3GDWASFTheOELb4SGggMTq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5mleZNotsODillpvkzBg2svKgirVqZW+5V5J0GYmmWgXpnKn6ju5IxoBsy+DRdLRG1LEggulea0l6NZljzfwWN89p+s/PfQIvTO/0QPVY82JR6aMS2a9vIlsz7siiXcp2KbnaJYfXMJ4w5ztYKYuEUt5JT7G3OyA/XgpSpbqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sjat4Cy+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725366300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rouf9QA+7Ghs8U4aEq+DyhBr7BZnG6TkAkEAd1/msLo=;
	b=Sjat4Cy+lgJwKGc6VH4bF6IfotL9BLjMhGHrXL1KxPLGxElhWQgkwmcs/f8P/f3fJNmysu
	151KjJevFEPFWlmEN0XtPPsmDr26BMLOkbm3H8vZJ9B5nhpXJ6H/B6C6fQHe9n4LbKy7Yp
	yH5+EysJyeJlVGXr13vcRjZqeaQMV58=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-6bLB6fcVMU6-ylBuujLW7Q-1; Tue,
 03 Sep 2024 08:24:55 -0400
X-MC-Unique: 6bLB6fcVMU6-ylBuujLW7Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8D461955D45;
	Tue,  3 Sep 2024 12:24:53 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD23A19560AE;
	Tue,  3 Sep 2024 12:24:52 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFS: Fix missing files in `ls` command output
Date: Tue, 03 Sep 2024 08:24:50 -0400
Message-ID: <C8B9D665-9E8D-4E4D-A8A0-21AC90E798DE@redhat.com>
In-Reply-To: <CALOAHbD0vhRypzEJDKJgCzYTzrhoiofzRZWF4rgr304NMXTjBw@mail.gmail.com>
References: <20240829091340.2043-1-laoar.shao@gmail.com>
 <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
 <CALOAHbDuThEW=osQudcxGQtFQqePaHzbG3MJyzGi=fLGbUqmKg@mail.gmail.com>
 <6B62A228-6C9C-4CDD-8334-E26C11DB51A1@redhat.com>
 <CALOAHbD0vhRypzEJDKJgCzYTzrhoiofzRZWF4rgr304NMXTjBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 2 Sep 2024, at 7:46, Yafang Shao wrote:

> Hello Ben,
>
> Upon thorough examination, we have identified the root cause of the
> issue to lie within the NFS server, specifically its behavior of
> truncating file listings to match the client's READDIR RPC args->size
> parameter without appropriately adjusting the cookie value. After
> implementing a fix on the server side, the issue has been resolved.

Nice work!  Out of curiosity, what server implemenation did you fix?

> However, to enhance resilience and mitigate future server-side
> vulnerabilities, it may be prudent to implement client-side handling
> mechanisms for such issues. What do you think?

We have in the past modified the client to be more resilient, but usually
only for cases where the server can cause the client to crash and/or corrupt
data.  For a bug like this, the maintainers usually assert "we do not fix
the client for server bugs", since doing so can paper over protocol
correctness issues created by the server.  I think that's what would happen
here if you keep working to justify your fix --  which you're free to do, of
course!

Regards,
Ben


