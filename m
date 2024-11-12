Return-Path: <linux-nfs+bounces-7905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9784E9C5A96
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0FF1F221D0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD671FEFC1;
	Tue, 12 Nov 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHNSD9OF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1F1FDF91
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422281; cv=none; b=lOjQWUAHTzzKq3NtRWJ7sj6h+K8G9bO+J9rTgCvTZ703noMUEAZJbYrU2wgDU3CRn6MwOPZuioVrOCQBM4etReKsPvEOEm3RLKNb3P+We8INe8gvm4j1jdG8k2EGulSIg27RpDXjdtquBxW4SpB1NyBTtWP9cgE5IJrNOsAaY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422281; c=relaxed/simple;
	bh=nPpBHD5uEHexyZdLKwLTev1sPWVB1+OspOBICPoKh8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuzDyhmyJ8baiiUfPOfKkF0Sb3v20Jp5xkUTPA7928NA8G2L81FmGuyb6AcBWj+gqMS2wCLzJWKmxb2/B3jvQLrSYK0fwAI7giJDjvWcn+W/PUnLf9Fk41SnNztI/i71xUiptXQXSIRCbgJ/6lRJ9FC8q+gh51IpvoNKeTT8U4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHNSD9OF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731422278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4R1M1vykbD1iiqabQJVX49PVUBOsHyEjnTbIunE+hs8=;
	b=iHNSD9OFnC0bm9ENaBZshKUD61fgxsxCrC3njDSaQutu7ejBsJapBntXAynrhXdDl0R2/z
	7OwsanjWHaTaSEtoJggPKXO8LhZuq1f/Zj8Ljz+5ARsG43sO0ptgpZlZMUKBsPwhAA1H/6
	nEfMxBH90b9G+V560OtYeparN50orhM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-ix8TEfuiMw26EcAr2TX8Sg-1; Tue,
 12 Nov 2024 09:37:55 -0500
X-MC-Unique: ix8TEfuiMw26EcAr2TX8Sg-1
X-Mimecast-MFC-AGG-ID: ix8TEfuiMw26EcAr2TX8Sg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B8A8195395C;
	Tue, 12 Nov 2024 14:37:54 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4C6019560A3;
	Tue, 12 Nov 2024 14:37:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Sebastian Feld <sebastian.n.feld@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: rsize/wsize chaos in heterogeneous environments Re: [PATCH]
 nfs(5): Update rsize/wsize options
Date: Tue, 12 Nov 2024 09:37:51 -0500
Message-ID: <E358D8BB-3DCB-4784-A05F-35BF43A2CA6C@redhat.com>
In-Reply-To: <CAHnbEGL1FVT+dfeSK=UUohNzRpvUZFnrM4dD1mwiYHCHeQUHLw@mail.gmail.com>
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
 <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com>
 <B74B2995-94D8-4E45-B2D7-3F7361D1A386@redhat.com>
 <CAHnbEGL_WD1M2FSQbNkCuZyUSMo8ktUsWRLYFjZ-NKKe1aoLAw@mail.gmail.com>
 <8F936203-8576-4309-B089-E8F38B477E7B@redhat.com>
 <CAHnbEGL1FVT+dfeSK=UUohNzRpvUZFnrM4dD1mwiYHCHeQUHLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12 Nov 2024, at 9:25, Sebastian Feld wrote:

> Because "pagesize" is a non-portable per-platform value?

ah.  The code we're talking about is the linux kernel which is compiled for
the architecture and yes - not portable anyway.

Ben


