Return-Path: <linux-nfs+bounces-1468-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2837383DCBA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580241C218BA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42E1B974;
	Fri, 26 Jan 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gljumD3u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C7134A6
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280591; cv=none; b=NUUlAfMC9t0+C0XmS7OtMxKuS+1AOX+B9zq99hbnWCYBy0CIrBxixPz9u25ZvCtvHdapa8fUKaBrkEAueslLzAfUSwzi+N1Bj8JlcIUgUNP/012riEQsd1Vt7gCpZqh53NvrAAJBrb1KXjtTIwHN2GLprv83uwbyjLRq9jiFVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280591; c=relaxed/simple;
	bh=/zYBZcx4v9usrAZRPolszdle6unUQjGL0+iI3V9+JEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjMhll8kxBdnyRFuj279APCyF+/ci9oZinM7RypIK3riqQhXVc9/Dm3QnqaIv4XH3UqXoUWY31L6piMxlAtNw78fpzxuCeaIrvaoQJ+85ThxSSXAkbu7wrHYwmX4saSvwxZILrfWHPkxm1lZq79KBQdi6HdLnbUzmOBH1oDv4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gljumD3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706280589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hP3F7tUOZj4NkFcIf9v3fxcPWZibPIm9ccpvXfyw+nY=;
	b=gljumD3uWCsshFBLnQkslO/pt/ix18tva2H6iJ16dPq9OtSoSk0/Gn73gnWTaqdp0uzzo0
	yjnc9BDRzCFfPIc6GSPlcs0SAefE24cwR7Fl29w3S/0UXRNpTIKsKScLyOaMnmxbBR6ARC
	zU8HcwoAr+dy3oDLgE+uLJIaGy3ABM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-H4oypw4INryXSqdgC_3fAg-1; Fri, 26 Jan 2024 09:49:45 -0500
X-MC-Unique: H4oypw4INryXSqdgC_3fAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 498C911BB5E8;
	Fri, 26 Jan 2024 14:49:45 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C54C2166B32;
	Fri, 26 Jan 2024 14:49:44 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jorge Mora <jmora1300@gmail.com>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
 anna@kernel.org
Subject: Re: [PATCH] NFSv4.2: fix nfs4_listxattr kernel BUG at
 mm/usercopy.c:102
Date: Fri, 26 Jan 2024 09:49:43 -0500
Message-ID: <8D1EF949-6A21-4839-B044-6AD4ABD49614@redhat.com>
In-Reply-To: <20240125145613.12995-1-mora@netapp.com>
References: <20240125145613.12995-1-mora@netapp.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 25 Jan 2024, at 9:56, Jorge Mora wrote:

> A call to listxattr() with a buffer size = 0 returns the actual
> size of the buffer needed for a subsequent call. When size > 0,
> nfs4_listxattr() does not return an error because either
> generic_listxattr() or nfs4_listxattr_nfs4_label() consumes
> exactly all the bytes then size is 0 when calling
> nfs4_listxattr_nfs4_user() which then triggers the following
> kernel BUG:
>
>   [   99.403778] kernel BUG at mm/usercopy.c:102!
>   [   99.404063] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   [   99.408463] CPU: 0 PID: 3310 Comm: python3 Not tainted 6.6.0-61.fc40.aarch64 #1
>   [   99.415827] Call trace:
>   [   99.415985]  usercopy_abort+0x70/0xa0
>   [   99.416227]  __check_heap_object+0x134/0x158
>   [   99.416505]  check_heap_object+0x150/0x188
>   [   99.416696]  __check_object_size.part.0+0x78/0x168
>   [   99.416886]  __check_object_size+0x28/0x40
>   [   99.417078]  listxattr+0x8c/0x120
>   [   99.417252]  path_listxattr+0x78/0xe0
>   [   99.417476]  __arm64_sys_listxattr+0x28/0x40
>   [   99.417723]  invoke_syscall+0x78/0x100
>   [   99.417929]  el0_svc_common.constprop.0+0x48/0xf0
>   [   99.418186]  do_el0_svc+0x24/0x38
>   [   99.418376]  el0_svc+0x3c/0x110
>   [   99.418554]  el0t_64_sync_handler+0x120/0x130
>   [   99.418788]  el0t_64_sync+0x194/0x198
>   [   99.418994] Code: aa0003e3 d000a3e0 91310000 97f49bdb (d4210000)
>
> Issue is reproduced when generic_listxattr() returns 'system.nfs4_acl',
> thus calling lisxattr() with size = 16 will trigger the bug.
>
> Add check on nfs4_listxattr() to return ERANGE error when it is
> called with size > 0 and the return value is greater than size.
>
> Fixes: 012a211abd5d ("NFSv4.2: hook in the user extended attribute handlers")
> Signed-off-by: Jorge Mora <mora@netapp.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


