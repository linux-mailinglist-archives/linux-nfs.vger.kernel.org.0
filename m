Return-Path: <linux-nfs+bounces-3580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A920990019E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 13:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF061F22C5E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F9714F9C9;
	Fri,  7 Jun 2024 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM8Difsf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF8187321
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758493; cv=none; b=nswaPQhLzj9De0O+Ekn9FRahLL9s9Vo4lS3HRqMw6lufdQ/P7XTejoEYMCVaXYtEP7QTR4cWZdAce5uCV1WrGcsxoyQHDZZT1HejyfbbhHGhnu86vwKpvl08+05VfohoTu7qFu4xnz5nz0Jop1PqaTRDdfQ5flYJMgzn2w3e8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758493; c=relaxed/simple;
	bh=0tfo5ILZwZRBOJ/nNd09A2XNzBSvgdrc15CVXi/ngyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBRHMF8QwModGsiq8EmCpWqihH9YZgF8KhWgWOzGPyv7PpsbjSZtByp2GkKtlshBueMCPMvGL3tZlAHxyld4ebwVBP4jQl1Q1lmL7ldNA6w+omy/8AFU7IcdRk8ZJ26AWWA0XmIsJQnD+mh5ScOTkwktBvdD4dx2YUi8bHF+urU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM8Difsf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717758490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzDF2DGvCUGt5vR6xbdqlR1EOVxNuvckJwiT+/HHVV0=;
	b=UM8DifsfyDblYk8w2knPCqUFWguyW7qsuO6CyVf22VJzG8y+j9bcurtgkldnFN5N1CSwa/
	fcaEEh7Lfu/gnoWxk7itPrCMRRO6fe3ykFBwD3B0G2DyW5BYEA655VmL/2R8Tvo+mAWGfS
	CjxjZ88mkIo0+v6ezTDCFudsMbOU+bI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-D5sWAnC5O56ta6HveuvYpA-1; Fri,
 07 Jun 2024 07:08:09 -0400
X-MC-Unique: D5sWAnC5O56ta6HveuvYpA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 204BD1955D5B;
	Fri,  7 Jun 2024 11:08:08 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-11.rdu2.redhat.com [10.22.0.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 787DC30000C4;
	Fri,  7 Jun 2024 11:08:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
Date: Fri, 07 Jun 2024 07:08:04 -0400
Message-ID: <44A8B3C5-9486-40A3-9D2D-C317A0208A50@redhat.com>
In-Reply-To: <CAAvCNcAe4ho539uhJ32qQJj5dBxBBAbKgPXXC15R4b=axtEvGA@mail.gmail.com>
References: <CAAvCNcBMY1mrgEgy4APSiFXDP5u=64YXNjiHHjh8RscPsB3row@mail.gmail.com>
 <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org>
 <96A320F4-AFC1-4DD9-8D5D-784F13DE94D4@redhat.com>
 <CAAvCNcBjuTLwsLb7nQxaS_O8PVLGPxk=6y2Wj8rp3se0+YxvPQ@mail.gmail.com>
 <CAAvCNcAe4ho539uhJ32qQJj5dBxBBAbKgPXXC15R4b=axtEvGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 6 Jun 2024, at 19:53, Dan Shelton wrote:

> On Fri, 26 Jan 2024 at 02:05, Dan Shelton <dan.f.shelton@gmail.com> wro=
te:
>>
>> On Thu, 25 Jan 2024 at 22:11, Benjamin Coddington <bcodding@redhat.com=
> wrote:
>>>
>>> On 25 Jan 2024, at 15:37, Jeff Layton wrote:
>>>
>>>> On Thu, 2024-01-25 at 03:21 +0100, Dan Shelton wrote:
>>>>> Hello!
>>>>>
>>>>> Is it possible for a NFSv4 client to implement TLS support via
>>>>> /usr/bin/openssl s_client?
>>>>>
>>>>> /usr/bin/openssl s_client would do the connection, and a normal
>>>>> libtirpc client would connect to the other side of s_client.
>>>>>
>>>>> Does that work?
>>>>>
>>>>> Dan
>>>>
>>>> Doubtful. RPC over TLS requires some cleartext setup before TLS is
>>>> negotiated. At one time Ben Coddington had a proxy based on nginx th=
at
>>>> could handle the TLS negotiation, but I think that might have been b=
ased
>>>> on an earlier draft of the spec. It would probably need some work to=
 be
>>>> brought up to the state of the RFC.
>>>
>>> Yeah, its' a little bit rotted.  Wasn't super fresh to begin with, bu=
t it
>>> did help bootstrap some implementation.
>>>
>>> You could also modify openssl to be aware of the clear text, somethin=
g like:
>>> https://github.com/bcodding/openssl/commit/9bf2c4d66eacccd3530fb2f3a0=
a6c87d5878348c
>>>
>>> .. but I think you're definitely in "what are you really trying to do=
?" territory.
>>
>> For example legacy NFSv4 client add-on? You cannot expect that
>> everyone can or will update to the latest and greatest version, so
>> either you have clients without TLS, which is a security risk, or have=

>> a way to retrofit them.
>
> Is there a public NFSv4.1 server with TLS enabled, which I can use to
> test whether openssl with
> https://github.com/bcodding/openssl/commit/9bf2c4d66eacccd3530fb2f3a0a6=
c87d5878348c
> can be used to plug in older clients?

That little hack is really only appropriate to retrieve a server's
certificates, it will not work as TLS-offload layer.

Why not just do an implementation for libtirpc?

Ben


