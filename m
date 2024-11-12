Return-Path: <linux-nfs+bounces-7899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11459C5A23
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E22284C58
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D017F477;
	Tue, 12 Nov 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMc/qS9s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C04DA04
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421277; cv=none; b=XXmaMlh4xGmNl4ci6hmJTGvVoTB0gdEd7rd6c3eM4FcCReuREmxCw6cSrDRITV3DxeqbovgQKhNCKoCMYXmGyi92uFtzJfikkQun2VF0SyuaEGZ9XYWINMmg19yZ2lydIT/O634VTw+Ea6FzTxjX5NJmUD29MihvMUfMd8YYWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421277; c=relaxed/simple;
	bh=EVdCNJqaDec7ixPsu1H/L6LLbrmAdh5rFCfd26vq7B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzJf6aPlH6P7wj+iUAJ0neq3QLgOU+neDNXKrplOW/QHX54xt/eh3k5a49WiQG3ah5rTr2BK//1kpN1ysXkE32fWkVYgWQJZrvxXXJqe3sBWE0OIMQBBsUySdwPwMekGJOXAZ8Y5rHNbXCuDJStbIjZ9/ALRva8QfVhHUVQeDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMc/qS9s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731421274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ES+eNizqGJozquYfZtu3QScYO00PO3CnA3+YP4S2Xc=;
	b=FMc/qS9s0HfA8iMGbXB93x2aR+yOESi2UtNeIz05lmXzGtJ5w+jJSLHs1/eudlxVZrTa51
	NMxkpq82kF0g0SWOxQDwCJKcdUo7z2K2UxOD3l62pJ1CK6p+vAPSzt7biC8cGBjlAOXy2z
	KBSYz7Uw6BWX8QSyGqUDZ6bHPIdJCPA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-jClB2VfLPEyv4dM5Mt-oqA-1; Tue,
 12 Nov 2024 09:21:13 -0500
X-MC-Unique: jClB2VfLPEyv4dM5Mt-oqA-1
X-Mimecast-MFC-AGG-ID: jClB2VfLPEyv4dM5Mt-oqA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75CCA1944A8D;
	Tue, 12 Nov 2024 14:21:12 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E71A01956052;
	Tue, 12 Nov 2024 14:21:11 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Sebastian Feld <sebastian.n.feld@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: rsize/wsize chaos in heterogeneous environments Re: [PATCH]
 nfs(5): Update rsize/wsize options
Date: Tue, 12 Nov 2024 09:21:09 -0500
Message-ID: <8F936203-8576-4309-B089-E8F38B477E7B@redhat.com>
In-Reply-To: <CAHnbEGL_WD1M2FSQbNkCuZyUSMo8ktUsWRLYFjZ-NKKe1aoLAw@mail.gmail.com>
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
 <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com>
 <B74B2995-94D8-4E45-B2D7-3F7361D1A386@redhat.com>
 <CAHnbEGL_WD1M2FSQbNkCuZyUSMo8ktUsWRLYFjZ-NKKe1aoLAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 12 Nov 2024, at 9:06, Sebastian Feld wrote:

> On Tue, Nov 12, 2024 at 2:56 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 12 Nov 2024, at 6:27, Sebastian Feld wrote:
>>
>>> On Mon, Nov 11, 2024 at 8:25 AM Seiichi Ikarashi (Fujitsu)
>>> <s.ikarashi@fujitsu.com> wrote:
>>>>
>>>> The rsize/wsize values are not multiples of 1024 but multiples of PAGE_SIZE
>>>> or powers of 2 if < PAGE_SIZE as defined in fs/nfs/internal.h:nfs_io_size().
>>>
>>> *facepalm*
>>>
>>> How should this work at all in a heterogeneous environment where
>>> pagesizes can be 4k or 64k (ARM)?
>>>
>>> IMHO this is a BIG, rsize and wsize should count in 1024 bytes, and
>>> warn if there is no exact match to a page size. Otherwise non-portable
>>> chaos rules.
>>
>>
>> I'm not following you - is "BIG" an acronym?
>
> I hit the wrong key. I wanted to write "BUG"
>
>>
>> Can you explain what you mean by non-portable chaos?  I'm having trouble
>> seeing the problem.
>
> x86-only-world-view: There are other platforms like PowerPC or ARM
> which can have other page sizes, and even the default page size for a
> platform can vary. ARM can do 4k, 64k defaults, servers default to
> 64k, IOT machines to 4k.
> So this is NOT a documentation bug, it's a bug in the code which
> should do what the doc says. Not the other way around.

What's the bug in the code again?  I'm still not seeing the bug.

Why should the code set the max io read/write size to a multiple of 1024
instead of a multiple of the page size?

Ben


