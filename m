Return-Path: <linux-nfs+bounces-9158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C8A0B85F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 14:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DB03A06F0
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EDF125B2;
	Mon, 13 Jan 2025 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtI3tv7O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B322CF31
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775577; cv=none; b=ChRbaIbHaKTE4eAB9vZ6hzJYlsNuSRT5meqkNkiBP+WoMYoAvFb4V69TmQC/qTuZx2VzaBk55N0L40UG2l6iWj5mKSVRjQKNsBPnQd4jbASA+ISa7Hzx3s2i+x8lmCskC8jqk3t5dzTA+RjFthC0fanmxWRBtiSnaYrmwX1z0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775577; c=relaxed/simple;
	bh=2GIYyBI/CKVvx3ts0GpAEF1zpmIvV0KsM/FXyVpwt+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nhk/RY/H3Q2qqR5mdC4RmxZIdczsQxCsOu9CwodFvCXe4eIQbEouh6Kp2kmNSdpm7fGoXqGy0b235y3kE6g7I+v+6oChZl2qG+Bz0woQeyrh3Jo7eXeeLRwIPHf5/SImI2E9D6xT8b9z1D3PJUKj2283ICoi5rL/xVuBDYT4DHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtI3tv7O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736775574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2GIYyBI/CKVvx3ts0GpAEF1zpmIvV0KsM/FXyVpwt+I=;
	b=OtI3tv7O4vFvJss8lTSBNO9tU+B8KYKRko8Bev6ZEHoLxRxrp20nN1WN67kpUthAzUBxzV
	y/uxLpLd2pEJvlOS1uUgV9I//Oo2wUXyfZ0quZghzhrX3Nyg35dNw6SW4FmL1TYP63V1Sq
	gHUWtGS3QDQ24eMDZ1iGLSfKJPgBeNU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-TCY2wE7SOUCh3BIqjKgt_w-1; Mon,
 13 Jan 2025 08:39:33 -0500
X-MC-Unique: TCY2wE7SOUCh3BIqjKgt_w-1
X-Mimecast-MFC-AGG-ID: TCY2wE7SOUCh3BIqjKgt_w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA2C01955F69;
	Mon, 13 Jan 2025 13:39:32 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F0F51956056;
	Mon, 13 Jan 2025 13:39:31 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Tom Talpey <tom@talpey.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nfsdctl: add necessary bits to configure lockd
Date: Mon, 13 Jan 2025 08:39:29 -0500
Message-ID: <5C361E33-7765-4888-BA7B-E90FC6256893@redhat.com>
In-Reply-To: <65f2226e-0e7f-4969-bc16-d4d56d2a5cb8@talpey.com>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
 <20250110-lockd-nl-v2-3-e3abe78cc7fb@kernel.org>
 <6c6bdf9b-858b-4a10-9317-f55aeda1ab80@talpey.com>
 <5b7b7284cb844b36ab89e77689f5baf5035f93e1.camel@kernel.org>
 <65f2226e-0e7f-4969-bc16-d4d56d2a5cb8@talpey.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10 Jan 2025, at 10:40, Tom Talpey wrote:

> I wonder how many sysadmins are actually changing it, and why. It's
> not truly a correctness thing, more of an availability setting, so
> the choice of value is pretty soft. As you say, if the clients all
> reclaim promptly, nobody's the wiser. Do we have any data on how
> often the setting actually gets used?

Here's an anecdote - when I was a sysadmin (~12 years ago), we were very
aware of the grace period and tried to optimize it because too long meant
many of our clients applications would hang for a longer outage, and too
short meant that all the locks weren't recovered.

We also depended on lock recovery working well because we would often
update and migrate servers.

This was before knfsd v4 could end it early, which is.. quite nice.

Ben


