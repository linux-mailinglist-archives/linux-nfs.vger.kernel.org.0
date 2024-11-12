Return-Path: <linux-nfs+bounces-7896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F559C59B0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606101F23781
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153A1FC7CE;
	Tue, 12 Nov 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5ArCuYZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0D1FBF55
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419772; cv=none; b=HsErZjJ46xYlOKBVIGhRi+25ydg7kZaJU0YV6vf768lo6C4cZkEi++sdjWNmBrY14K56rBq0Dy/neaZQ8pwl4ZD0vKJCaI2cBfEU3TKq+7FTgdwVuz/0LHHkSHiAmQmWnP3TE8vwgfdqcCa905bCiW77vd8kEHeVYpWBvqA5kMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419772; c=relaxed/simple;
	bh=jlFUGJzNnu//mR9/R+tgDc2QO3hxlONcfbDV4+jbi1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6FqqZtKnqxegglI9TTCLECrtmEepJOfErOEHJVOzpcixAxbPaAs/3aYq+1MAUNaBO7OE8yebXeBs53QDl9gPflKduu0l4ZciJH+PTW2VM1pftXyANGTKlcxXl2eoARGjNiu7VZDGVIwZVSW6naXOHE8/pH4+YReJENErRkM7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5ArCuYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731419769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCh3x7cJ8HyAge+pYfe0pfIRHL1rCUSTJppbRV+KIMI=;
	b=e5ArCuYZklQRpSVHZrE68A271nB/VibCRimTgeCz0YQnKE4C/yvsnM+FZ0QtTL1/wjlgvt
	c1AoC1ycEpa/gOdsapgc9yMH9/CWeU0SeApHgPLZjTo5iYJPyJjCMeCvhFwtUYqpfDkids
	zPXTO/9M+hbUy0HWZHW+xoL+nhFodyw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-02zQKE75MT6oZIb9O8NZ8g-1; Tue,
 12 Nov 2024 08:56:05 -0500
X-MC-Unique: 02zQKE75MT6oZIb9O8NZ8g-1
X-Mimecast-MFC-AGG-ID: 02zQKE75MT6oZIb9O8NZ8g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C52FB1955F29;
	Tue, 12 Nov 2024 13:56:04 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AB3219560A3;
	Tue, 12 Nov 2024 13:56:04 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Sebastian Feld <sebastian.n.feld@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: rsize/wsize chaos in heterogeneous environments Re: [PATCH]
 nfs(5): Update rsize/wsize options
Date: Tue, 12 Nov 2024 08:56:01 -0500
Message-ID: <B74B2995-94D8-4E45-B2D7-3F7361D1A386@redhat.com>
In-Reply-To: <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com>
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
 <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 12 Nov 2024, at 6:27, Sebastian Feld wrote:

> On Mon, Nov 11, 2024 at 8:25 AM Seiichi Ikarashi (Fujitsu)
> <s.ikarashi@fujitsu.com> wrote:
>>
>> The rsize/wsize values are not multiples of 1024 but multiples of PAGE_SIZE
>> or powers of 2 if < PAGE_SIZE as defined in fs/nfs/internal.h:nfs_io_size().
>
> *facepalm*
>
> How should this work at all in a heterogeneous environment where
> pagesizes can be 4k or 64k (ARM)?
>
> IMHO this is a BIG, rsize and wsize should count in 1024 bytes, and
> warn if there is no exact match to a page size. Otherwise non-portable
> chaos rules.


I'm not following you - is "BIG" an acronym?

Can you explain what you mean by non-portable chaos?  I'm having trouble
seeing the problem.

Ben


