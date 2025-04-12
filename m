Return-Path: <linux-nfs+bounces-11120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98940A86E6A
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Apr 2025 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCE23BAA2F
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Apr 2025 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EAA1F8722;
	Sat, 12 Apr 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK57DY0P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16ED1F03D8
	for <linux-nfs@vger.kernel.org>; Sat, 12 Apr 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744478917; cv=none; b=gGDlBpktRpfgTchnfB++68xVZUYtVaPjEBeRQ1GizEQOulvlBdwoZE1sum/l3tzwMqbXFLaUakSsnnaL1lRxjXJKpi/hciBx1qUJAT7HyzscN01TYDPgYKCPv9m8AYZNZRStuSx7RXQ81PmGiW6c513XrfSl3Hx+qiYjNZKuFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744478917; c=relaxed/simple;
	bh=xYk42vloVrLijNrAhTXQJ02Hh5wyZfplTlmclV+n9Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaPCUJACsEQBSCHzFpu8zr7Y7bPWk+5CM65lP4TJkqNPJDuK2I4SMHzvMAb7XqH3M7zwmK/J1vRJNjzbnY7ZuOL247Lvo3OUCxV0RDCAobBHkHJWobyiksdKJYBN15LOuRWMEsvECzFz/z2ac7l/gG+SOX1yRcFuv5ZgyYz4YW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK57DY0P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744478914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPbwa16Mi9TWLQC0HXWXWiBVUkcD4StyWuDnukc0GHo=;
	b=dK57DY0PmsJ4iPqsoT/vqMEoR9AjQn+t2xkxN+mvLWqqL2REYSvyw3tLoV0sUyiQ/GDEcZ
	P4uw3jxnIxXcCY5PFBJZb8iBQDzCqWk4GpspioTJRniMyBBI9c4a1qCeXqYVQUcjhNsNbg
	v9VOPoJKRUCwbe7lLWmi3J38IGDn/xk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-O94QP9c_OEK0XGQ7pTG0hw-1; Sat,
 12 Apr 2025 13:28:30 -0400
X-MC-Unique: O94QP9c_OEK0XGQ7pTG0hw-1
X-Mimecast-MFC-AGG-ID: O94QP9c_OEK0XGQ7pTG0hw_1744478909
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E3618009FC;
	Sat, 12 Apr 2025 17:28:24 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2355A19560AD;
	Sat, 12 Apr 2025 17:28:23 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: =?utf-8?q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: Async client v4 mount results in unexpected number of extents on
 the server
Date: Sat, 12 Apr 2025 13:28:21 -0400
Message-ID: <85AA0B5B-64BF-4308-8730-D62AF68F23A2@redhat.com>
In-Reply-To: <8cb74904-331a-5615-6453-6ce8948236a2@applied-asynchrony.com>
References: <848f71b0-7e27-fce1-5e43-2d3c8d4522b4@applied-asynchrony.com>
 <3696A877-3C0E-4F70-9C7E-3FD8B9AD185F@redhat.com>
 <8cb74904-331a-5615-6453-6ce8948236a2@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12 Apr 2025, at 8:36, Holger Hoffstätte wrote:

> On 2025-04-11 15:29, Benjamin Coddington wrote:
>> On 10 Apr 2025, at 8:55, Holger Hoffstätte wrote:
>>> ...
>>> Does this behaviour seem familiar to anybody?
>>>
>>> I realize this is "not a bug" (all data is safe and sound etc.) but
>>> somehow it seems that various layers are not working together as one
>>> might expect. It's possible that my expectation is wrong. :)
>>
>> My first impression is that the writes are being processed out-of-order on
>> the server, so XFS is using a range of allocation sizes while growing the
>> file extents.
>
> Thanks for reading!
>
> Yes, that's true but not the cause of the re-ordering - the server just
> does what it's being told. The reordering has to come from the client in
> async mode.

There isn't any guarantee of write processing order for async writes, is
there?  I also don't think there's any practical impact.  So I'm wondering
what's the expectation of behavior and what problem you're trying to fix?

Ben


