Return-Path: <linux-nfs+bounces-7535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F909B33F7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D391F226E7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0351D2B24;
	Mon, 28 Oct 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ryggyg00"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92818E778
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126865; cv=none; b=BOaiUpu9xSZm6GAizfRna9/JpoTb617sPf5wNET9bUb6czLy5YHTrNodtlQD7pNVZO4MSQSmZSYJRM1DXb+03vKhdR1+g/xB7IvV7XGjyuDKyzbTZquzPVM8NrUXyzIfnT3/aX4Uf1Ots6lfDVZ6wmszim4QVcFoVeKlC3kj4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126865; c=relaxed/simple;
	bh=bYGiFtoJeYsvUSN/1cqtGfXcNo4h987sEXDKXdv3Hz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ImhKWJd6/pQl0WIPNp4kG/ep7uBfUs0gg8+mnxu/8XJY6wnnu8EjfJ51y1qfg+YZM+mO8AeBmavX/zvdsUI33QajAo5TNl8YRojwY1Kb/1NTDerWyr3zC3G5Sp4CCN2NbVSaj/SvcM0erDTkQo3y7VCHGPlhmd+bxii2OLOSPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ryggyg00; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730126862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=x+t+k7lcgv8l/9Fa+/DZd22LRseM4N9A/y6HjU/0f3Q=;
	b=Ryggyg00Y+NY5rFHscQ3qRtbDbYJl77m1vXBNjY9kiTW4/u9/bLvqO4+9iJ1q5jh/8S/PQ
	zl0Rpw4ldzgSmkJ6jMh6Jtcz+CsLi/vDO4TPyrzt4gdSPI9KKKA5s3q1AoVvaS9GliFHkJ
	rImq2u93PKVuYnGEdCmF28YLd+BvubI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-kwM1VZHYNiq_1eFGrTz7QA-1; Mon,
 28 Oct 2024 10:47:40 -0400
X-MC-Unique: kwM1VZHYNiq_1eFGrTz7QA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DFB21955F3E;
	Mon, 28 Oct 2024 14:47:37 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.17])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5C8B1956088;
	Mon, 28 Oct 2024 14:47:33 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: steved@redhat.com, bcodding@redhat.com, smayhew@redhat.com,
 jlayton@kernel.org, chuck.lever@oracle.com, anna.schumaker@oracle.com,
 tom@talpey.com, loghyr@hammerspace.com, snitzer@kernel.org,
 trond.myklebust@hammerspace.com, rena.shah@microsoft.com, ffilz@ibm.com,
 okorniev@redhat.com, rmacklem@uoguelph.ca
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Bakeathon October 2024 Talks at 2 recordings published
Date: Mon, 28 Oct 2024 10:47:31 -0400
Message-ID: <679AC694-DEE7-4063-940F-7966A4CC6521@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Bakeathon Attendees and Lurkers,

Thanks for everyone that attended and participated.  Special thanks to our
Tat2 presenters, Chuck Lever, Tom Haynes, and Zhitao Li.  I've published the
recordings of their three talks on youtube in this playlist:

https://www.youtube.com/playlist?list=PLzl8_Ue6nacHZE9Fjow_7ZYhyWWZ8n0ka

Cheers,
Ben Coddington


