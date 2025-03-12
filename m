Return-Path: <linux-nfs+bounces-10576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAB3A5E7BC
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C81C3A8567
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9191F0E45;
	Wed, 12 Mar 2025 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foP8RWJd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA81EE7D9
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820251; cv=none; b=lnl9h1zMwBPiEPmwHKZKPjF+9WFC64U56JewGZsEfdy6RG671ExIcMt5b+gUYpD1kMT9WeOj9XIZ81b9qbk1wY+2gFXCD6nMiRlxbOZmBpNWqUmTOif6wv2jpUjAEA/Yxy0L8luZebrF2hLrw2gHyC5OAg4JFhFqGIK6aEwDOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820251; c=relaxed/simple;
	bh=zUzELXQHl4KspRcj+NkzjGyEbPhfQyG3QgVDWVxSmaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWSL+nl4WDR5VItBK/iJlTfUoqJOmjW5T5Jwysy7DKXhmmB8Whu3qCEin4O79jCclr8Vwbh/InjheRUKzFPA8Rdsr4f/fTcc9x1dfOrJfYFPZrlZi4ZvdGyngqwzQ+YLw2SoQFMQgAUwddUd7G30I8DVB2N3CyDE/2NB8xsZ/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foP8RWJd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741820249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMmNj9Ul56uoKKx9kzcq+VtcfjBkn3QGcwV8XUdB+Uo=;
	b=foP8RWJd6xnj90Ee9aphTL+1Hx1h1CxPPYoPqYYUmy8cFvuu51j1boS7NOGwU5fmnnLrIN
	A6nXlu0FQgtAqayif9PVFeEKjEQX2ElrCGaTbdLs9mz4Tr1bBIrg281Wc2qyYLrHXE66La
	4l3/ysIXhGkEYks4KcQ8n+obio/+6QE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-AEpyIF9wNtafa90j-jX3HQ-1; Wed,
 12 Mar 2025 18:57:25 -0400
X-MC-Unique: AEpyIF9wNtafa90j-jX3HQ-1
X-Mimecast-MFC-AGG-ID: AEpyIF9wNtafa90j-jX3HQ_1741820244
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FDE21956089;
	Wed, 12 Mar 2025 22:57:24 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB00F1800945;
	Wed, 12 Mar 2025 22:57:23 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFS: New mount option force_rdirplus
Date: Wed, 12 Mar 2025 18:57:21 -0400
Message-ID: <918EAA33-67C3-4E8A-9B20-1A019646713B@redhat.com>
In-Reply-To: <ef4218cd2eb30558692857d02ea1518e1e06684f.camel@hammerspace.com>
References: <cover.1741806879.git.bcodding@redhat.com>
 <4a471ab1bdea1052f45d894c967d0a6b6e38d4a6.1741806879.git.bcodding@redhat.com>
 <ef4218cd2eb30558692857d02ea1518e1e06684f.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 12 Mar 2025, at 18:48, Trond Myklebust wrote:

> On Wed, 2025-03-12 at 15:46 -0400, Benjamin Coddington wrote:
>> There are certain users that wish to force the NFS client to choose
>> READDIRPLUS over READDIR for a particular mount.  Add a new kernel
>> mount
>> option "force_rdirplus" to carry that intent.
>
> Could we perhaps convert rdirplus to be a string with an optional
> payload? Does the "fs_param_can_be_empty" flag allow you to convert
> rdirplus into something that can behave as currently if you just
> specify '-ordirplus', but that would allow you to specify '-
> ordirplus=force' if you wanted to always use readdirplus?

Yes, I think that's possible.  I originally started down that route, but
abandoned it after it appeared to be a bigger code diff because you have to
re-define the nordirplus option which we get for free with fsparam_flag_no.

I can send a v2 that way if it's preferred.

Ben


