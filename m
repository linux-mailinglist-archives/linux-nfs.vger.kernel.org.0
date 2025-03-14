Return-Path: <linux-nfs+bounces-10616-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A959EA610BC
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 13:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31FC165439
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD353C6BA;
	Fri, 14 Mar 2025 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOQ9X6YZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4681FDA61
	for <linux-nfs@vger.kernel.org>; Fri, 14 Mar 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954720; cv=none; b=KlqGH2YEVbAhn2CVNlHmEEbIr8brLFG14L5AbW1vDYNH9W7xrueMCh4yvXJ3o0xWG/E8LShIQ6WVodSko/KK0k9NVAUrYjfG7ny52YYm5/9FLoXe8NqmBRLmr0fLWFJeOAcBOVu+cNJM8cJXdK1r3ltvIEIJCmJHunz8wbtw6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954720; c=relaxed/simple;
	bh=z+b0qSUp3qEAUrGMqSh97WV3PdLM6+lRWDdKYyKYkGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flwEkX8M4Xs8vVk9/qhFVar3ErKU6YXO/AwQ1OsftXaMmo9+9gc5paodBzmeBTgcoHSO5o29iRyLdnp9X4fgEz7Me8wcQy18yircOVak3KuzRsopkZ5bj6FzXi2ijHvg6u1SHY4XBuRZGa7B8PdF/TuHQQjgE2Qku99nNar2WUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOQ9X6YZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741954716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObU7/ql0kvXDnQRDU7S9QZljpE3OrC3UO7VldJ5p95M=;
	b=UOQ9X6YZ0W6jgHNRyuQvOXxTm8AkB15PQpjPOBXF50Q6KWwRX5Mds7PPLQTcKrJO0ACMDi
	SILn1gISqk/zxkHlr+m0Vj8JpwPV95VzWujYzX178Wnfa+xjCiXn/DJGLHm3QSCk+26IZt
	VVT7cc+mlyEFpiMTV9W9PCY3Zh6MzoM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-E7x32_0XN2GQzIWuAqopDg-1; Fri,
 14 Mar 2025 08:18:32 -0400
X-MC-Unique: E7x32_0XN2GQzIWuAqopDg-1
X-Mimecast-MFC-AGG-ID: E7x32_0XN2GQzIWuAqopDg_1741954711
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88D84180882E;
	Fri, 14 Mar 2025 12:18:31 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C53B81955F2D;
	Fri, 14 Mar 2025 12:18:30 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: "Andrew J. Romero" <romero@fnal.gov>, Steved <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is development
 still active or is it being depreciated
Date: Fri, 14 Mar 2025 08:18:28 -0400
Message-ID: <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com>
In-Reply-To: <PH0PR09MB115990D120B04F28C93F4014CA7D32@PH0PR09MB11599.namprd09.prod.outlook.com>
References: <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
 <PH0PR09MB115990D120B04F28C93F4014CA7D32@PH0PR09MB11599.namprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 13 Mar 2025, at 7:30, Andrew J. Romero wrote:

> Hi
>
> Alexander Bokovoy provided excellent answers to most of my questions on
> this topic See: Thread: gssproxy  security, configuration and life-cycle
> questions on gss-proxy@lists.fedorahosted.org
>
> Remaining question:
>
> Prior to RHEL-9 , in the section of the gssd man page ( under the heading
> CONFIGURATION FILE ...  ....options  that  can be set on the command line
> can also be controlled through .... values set in the [gssd] section of
> /etc/nfs.conf ) there was a configuration parameter "use-gss-proxy"

I don't see any git history of gssd.man with use-gss-proxy, but the value
does appear in nfs.conf.man.  It has not been removed there.  It probably
should be added to gssd.man.

> why was this parameter removed from the current man page, can it be
> re-added ?  ( apparently the parameter is still functional ... if that's
> the case , it should not simply be removed from the documentation with no
> commentary )

I'm not sure thats what happened.  It looks like it wasn't ever in gssd.man
to me.  Maybe Steve D can clarify?

Ben


