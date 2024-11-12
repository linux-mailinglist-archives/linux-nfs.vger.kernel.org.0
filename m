Return-Path: <linux-nfs+bounces-7913-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D219C6461
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 23:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14158B29535
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174AB20ADED;
	Tue, 12 Nov 2024 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8kEfWiy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A8D53C
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449132; cv=none; b=su1AfvCTRiZEBdRUrbLMm3RUtYF+lwQ6pQSV0G9oyZ/h6GsL3DT1/YVaIx+9wPLnvR/5PipGHMdlYvDfpxUvVmVORczJ7KtFEkQeBKp0vpvvXBCy2sSKhrifo9m4sFsWaI63tBqaF5HQxE6RTlSrYJaGa/BAkGZYCRW4yE3impY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449132; c=relaxed/simple;
	bh=mRjLEonEdVANDcDtHp55s59A3cvGcvWQXaGcVHO6Oxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMnA/m/gZuztOqOI/o9KwNBouJF4WBUtj61fiZpIRAXUzXFJXkYge3LZyEkU7cS6Vnkjq8Q2ayqGTpYo1rTpHAxRm9S9oJuAuU9LVHNr8GVz0GNLfoIn6U+3QY3VUbwdecc73eo69T5SzGlhtne2zjqZbJYIhPObt8ZaoWyJ7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8kEfWiy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731449129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izza4to8ykixeWATuVDFmM0hsMG2wLgfuAvCzCWMuuA=;
	b=a8kEfWiy2A1WLQpKBvAMsMZFzGTdYD45IYOsfTWu7h3C3LrUaw7BuXl5rsNhVoEH72TwVn
	eCnioC/5aR8lTS3uJN9eNRaoaYljIrRWW4dsQNexOHgyN2pk3MW5E2+9SpUPM4fB3jllsL
	dSgFGP6SeOR6VnE8jRNwjuc5ZXX4NOM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-IDr2j_rGOGur8Q-_ZQvA8A-1; Tue,
 12 Nov 2024 17:05:27 -0500
X-MC-Unique: IDr2j_rGOGur8Q-_ZQvA8A-1
X-Mimecast-MFC-AGG-ID: IDr2j_rGOGur8Q-_ZQvA8A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6434B19792DB;
	Tue, 12 Nov 2024 22:05:26 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D00C5195607C;
	Tue, 12 Nov 2024 22:05:25 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: rsize/wsize chaos in heterogeneous environments Re: [PATCH]
 nfs(5): Update rsize/wsize options
Date: Tue, 12 Nov 2024 17:05:23 -0500
Message-ID: <1A03FF0A-1A24-40D2-9FCB-5CC0226A356D@redhat.com>
In-Reply-To: <CALXu0UdpPpM2GHX6cWr+YbYqCqb8eEuLhPJa+oKVr6GfuZGKsA@mail.gmail.com>
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
 <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com>
 <B74B2995-94D8-4E45-B2D7-3F7361D1A386@redhat.com>
 <CAHnbEGL_WD1M2FSQbNkCuZyUSMo8ktUsWRLYFjZ-NKKe1aoLAw@mail.gmail.com>
 <8F936203-8576-4309-B089-E8F38B477E7B@redhat.com>
 <CAHnbEGL1FVT+dfeSK=UUohNzRpvUZFnrM4dD1mwiYHCHeQUHLw@mail.gmail.com>
 <E358D8BB-3DCB-4784-A05F-35BF43A2CA6C@redhat.com>
 <CALXu0UdpPpM2GHX6cWr+YbYqCqb8eEuLhPJa+oKVr6GfuZGKsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 12 Nov 2024, at 13:52, Cedric Blancher wrote:

> On Tue, 12 Nov 2024 at 15:40, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 12 Nov 2024, at 9:25, Sebastian Feld wrote:
>>
>>> Because "pagesize" is a non-portable per-platform value?
>>
>> ah.  The code we're talking about is the linux kernel which is compiled for
>> the architecture and yes - not portable anyway.
>
> It has to be portable for an Administrator. NFS rsize and wsize should
> not depend on a machine's page size.

They don't, they're just optimized to the machine's page size.

> Otherwise you cannot have such entries in /etc/fstab, instead an
> Administrator has to rely on /usr/bin/pagesize, /bin/bc and manual
> mount script just to pass the rsize+wsize in a portable manner. 100%
> not compatible to puppet and common cluster software, and even less
> portable for people using nfsroot.

Puppet and common cluster software absolutely can dynamically generate fstab
values based on machine types for this theoretical problem.

Anyway, I'm sure reasonable patches will be accepted.

Ben


