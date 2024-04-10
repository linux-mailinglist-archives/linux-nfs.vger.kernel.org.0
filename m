Return-Path: <linux-nfs+bounces-2751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDB89FF34
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7962874F0
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720817F375;
	Wed, 10 Apr 2024 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXszPOJF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8B168DC
	for <linux-nfs@vger.kernel.org>; Wed, 10 Apr 2024 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771728; cv=none; b=Ahy+kPOt0vERqNe9p5KVELfS49kWF/IMDo2/jJItDbVy1OM1jbuMx3TPTS5dW6Ev3sp+byr0yp7aTmog5tzq1ZQiskvXPXemaXaA9Em7zCV9vZjLfuUlfrzQRnrWS20E1XI0p39fQHe/gwPbIGFlz0ZtUeNh6PfrBgyG+hGModc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771728; c=relaxed/simple;
	bh=GokhNY9u/aeNi03VjCug/C81HFqSrTZ+DEYqOKcTkQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHsW7RaFAlDEyUxr4FJpZ/hZRZe7W4Im6MjClQDadmM4KjOwtCzJq6zS2Jmu8dm/EZXuETes719A5U9JgcJFYrHFSbtLlxnpqqdd+Xm+YqHkwCgT/pff/rT+IGrcJVRyok308a7TH5KdTuL5N6ikpbE8CBOvlcnQKjFa6Zehwxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXszPOJF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712771725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1scWUYOt8vy5e2arWgxlPTQFk0XeU00oR5LERfll4w=;
	b=bXszPOJFo6YdAeofXCqAQ136ANZ2hfJ0F3x/F41L8I4JinGfGwElSJ+FJFr3Qe191Q8KgL
	QmEd7ujbcliBPjI8E4MegLOCwYdJbo/V/OI8YNc7gliW9lLzFm0u7rELnujyATX0jx8e+W
	ljFS13QlW/s0mNHaAFfCAtW1J8KuoHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-s9Nga816PkSMqCMgy_NWlw-1; Wed, 10 Apr 2024 13:55:24 -0400
X-MC-Unique: s9Nga816PkSMqCMgy_NWlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B9D0180A1F6;
	Wed, 10 Apr 2024 17:55:24 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-15.rdu2.redhat.com [10.22.0.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A21A110E4B;
	Wed, 10 Apr 2024 17:55:23 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: =?utf-8?q?Z=C3=A9_Geraldo?= <zgcarvalho@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: Configuring NFS with UID/GID Offset (sec=sys approach)
Date: Wed, 10 Apr 2024 13:55:22 -0400
Message-ID: <64DB2D25-5A33-434B-8898-7683ADCE3C92@redhat.com>
In-Reply-To: <CABJN9r6n1mxLNqFo2nsM9gBz6LDku9kk_V6c-85pMeH=CGzEaw@mail.gmail.com>
References: <CABJN9r6n1mxLNqFo2nsM9gBz6LDku9kk_V6c-85pMeH=CGzEaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 9 Apr 2024, at 16:50, Zé Geraldo wrote:

> Hello,
>
> I'm seeking advice on configuring NFS to handle a specific scenario
> where the server and client have an offset in their UID/GID values. On
> the server, a UID/GID translates to a UID/GID + 10000 on the client
> side.
>
> Ideally, I'd like to avoid modifying server configurations or changing
> client UIDs at this time.
>
> My current approach involves utilizing the sec=sys option with an
> offset to bridge this UID/GID gap. However, I'm unsure about the
> effectiveness of this method and would appreciate any insights from
> the community about how I could do this.
>
> Here's a summary of the situation:
>
> Problem: Server and client have a UID/GID offset (server UID/GID =
> client UID/GID + 10000)
> Goal: Configure NFS to handle this offset without server config
> changes or client UID modifications.
> Possible Solution (under consideration): Using sec=sys with an offset
> in the mount options.
>
> While alternative configurations like sec=krb5 functioned in a test
> environment, modifying the server configuration is not preferred.
>
> If anyone has experience with similar scenarios or can offer guidance
> on using sec=sys with offsets for NFS, your expertise would be greatly
> appreciated.
>
> Thanks,
>
> José Geraldo

Hi José,

Have you looked into whether user namespaces on top of NFS can solve your
problem?  I haven't specifically used them on NFS, but it might be an
existing tool you can build upon.  When you set them up, you can specify a
mapping; see user_namespaces(7).  A more in-depth explanation of how they
work is here:
https://docs.kernel.org/filesystems/idmappings.html#general-notes

You must know that sec=sys doesn't provide real security, though.  As long
as a particular NFS client has sec=sys access to a server, processes on that
client can impersonate any UID/GID.

Ben


