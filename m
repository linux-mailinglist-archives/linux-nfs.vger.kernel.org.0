Return-Path: <linux-nfs+bounces-3248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC368C3F9E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 13:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C4A1F213C1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE4714B95F;
	Mon, 13 May 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO/FgcyA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3A1487E1
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599024; cv=none; b=JZ+txdzJO/NIixbeoI5v+Tt7bBnraMLRUpF4m9iEtWiAInIk5Q6DHfGZH3YFqKNbyaoT8++Az6OxcmzeeLOlndE4bqRkunFQ53xm2wT+p0rK3nt07QDgD1AMnrAaDdG8AVNOz7bQ5hFS4/G3YRJqxLF2XCJAb0EyTCBFrYVsjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599024; c=relaxed/simple;
	bh=oF9SqHADEhWmSUqmeK7h0Oy9WUi6drReUbeX3mTVZGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0GX3TlsvGJi33FHTIp3RAQ0EiWuyOAHp3qz3Uco2BfzlAqYfVkmqBZghiNyiAh/KqlyEch8R77P3i8fmXR3FqJb5VEBV2BGmqQm9itGJ0TuuPjf1YZrHHbyYnhlZVGZOMeJ5dPuzuya+1X6tc1kjRHWLhoFLiubEka4yX75lDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cO/FgcyA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715599019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oF9SqHADEhWmSUqmeK7h0Oy9WUi6drReUbeX3mTVZGk=;
	b=cO/FgcyAxh/Zh0olRp5oN7IYUZmnaghZSqRYYjxJ34JMEbWCV++kz03DFL/axLZdMzyVHG
	qdcm+SQnYb+e+szlSXggsJT6ZJtBTc0WQNxMzXZ3MBPmJnILxmatWyfsFhJvASVI0FVBXi
	q8cBiB2qUuFVv+0ZhkI1V7nBsmZ7Nw8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-ev2pRz-hNBS3nxmHs2Kfaw-1; Mon, 13 May 2024 07:16:55 -0400
X-MC-Unique: ev2pRz-hNBS3nxmHs2Kfaw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84E0B800CB0;
	Mon, 13 May 2024 11:16:55 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B7645491032;
	Mon, 13 May 2024 11:16:52 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: fix undefined behavior in nfs_block_bits()
Date: Mon, 13 May 2024 07:16:51 -0400
Message-ID: <DBAC970F-9FB0-4872-97F5-5CFE5B8A1191@redhat.com>
In-Reply-To: <69333a8c-a5a7-5c76-bc39-8835f11b8dcf@omp.ru>
References: <69333a8c-a5a7-5c76-bc39-8835f11b8dcf@omp.ru>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 10 May 2024, at 16:24, Sergey Shtylyov wrote:

> Shifting *signed int* typed constant 1 left by 31 bits causes undefined
> behavior. Specify the correct *unsigned long* type by using 1UL instead.
>
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


