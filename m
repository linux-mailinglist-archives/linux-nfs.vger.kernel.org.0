Return-Path: <linux-nfs+bounces-1436-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5F83CE30
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 22:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE98529B16E
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2C137C31;
	Thu, 25 Jan 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apUB9Z6s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C631CA89
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217106; cv=none; b=d2cRvRuKFWr2gn6uWMnLAuCY2bWQxDcD7stqA/VJGTPmQUJWwGVMrIH+oF376Z/nGuOD3VUDzkfTBDyLq/OyTEo0tyWpHxRqWjosj74rHEgWwldj6Ejs1+gyV10GHwKaOmRmUlZLIe+8DlrO1073e6lOtUmHueCqQ8hnkb3uZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217106; c=relaxed/simple;
	bh=PIgluVEpfKOifP/QVtYVGlqklshvjaJwUWwOQECZVGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKhkyQ8x4e5RJLuzzBnQctQi2W3HfmGQyZAHK0pjoSunTuepDGDAbQfZfjTezjNfHXghhneo9uwml6Rip2oUJDP1lNT+5KWR9zKF1pBPQq/dGynzRWFeC3ptzDM3/m2D+1fkgzNWuTr0pAoOomMq3HZFUMS80ylRmLH/0hdI52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apUB9Z6s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706217103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayAl4k6HCnqML46Chy9fHXc7OuX2Yp41bQ05V63wVaU=;
	b=apUB9Z6sa9RMYdnJxcfwduPvpQD0XGNyPK+V9r2gJ0C5q0ZPkcRczU221EIlangG5EJZeO
	FsnXGQny11I/es0efkNMFO3Qtf8A9ZblI5Z1bhOvJ/vAe/jd/Cy8hnrxJLwVmBIboTp19m
	lW62x1F0F9iAJW20S40JRftEJb/BiSE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-LzXBWGEbOyCu4QSufwPjrA-1; Thu, 25 Jan 2024 16:11:40 -0500
X-MC-Unique: LzXBWGEbOyCu4QSufwPjrA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB1BA827D89;
	Thu, 25 Jan 2024 21:11:39 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 188C0492BC9;
	Thu, 25 Jan 2024 21:11:38 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Dan Shelton <dan.f.shelton@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
Date: Thu, 25 Jan 2024 16:11:37 -0500
Message-ID: <96A320F4-AFC1-4DD9-8D5D-784F13DE94D4@redhat.com>
In-Reply-To: <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org>
References: <CAAvCNcBMY1mrgEgy4APSiFXDP5u=64YXNjiHHjh8RscPsB3row@mail.gmail.com>
 <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 25 Jan 2024, at 15:37, Jeff Layton wrote:

> On Thu, 2024-01-25 at 03:21 +0100, Dan Shelton wrote:
>> Hello!
>>
>> Is it possible for a NFSv4 client to implement TLS support via
>> /usr/bin/openssl s_client?
>>
>> /usr/bin/openssl s_client would do the connection, and a normal
>> libtirpc client would connect to the other side of s_client.
>>
>> Does that work?
>>
>> Dan
>
> Doubtful. RPC over TLS requires some cleartext setup before TLS is
> negotiated. At one time Ben Coddington had a proxy based on nginx that
> could handle the TLS negotiation, but I think that might have been base=
d
> on an earlier draft of the spec. It would probably need some work to be=

> brought up to the state of the RFC.

Yeah, its' a little bit rotted.  Wasn't super fresh to begin with, but it=

did help bootstrap some implementation.

You could also modify openssl to be aware of the clear text, something li=
ke:
https://github.com/bcodding/openssl/commit/9bf2c4d66eacccd3530fb2f3a0a6c8=
7d5878348c

=2E. but I think you're definitely in "what are you really trying to do?"=
 territory.

Ben


