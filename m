Return-Path: <linux-nfs+bounces-10009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091ADA2EF39
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 15:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A447D7A22B1
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FEC231A43;
	Mon, 10 Feb 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLk8t7Df"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161B231A56
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196484; cv=none; b=MLJB3kULZvxvQnxCNoVEiWIKAmAgS4NmrGQKR9VGRMANDFGv+HMl9glR50FLKe7QBnXok/msx0lBEuw9f2z+BIlJbns5cX90ber4xzn22brzAyUkS9oInPfPabu5FHviZN5mEDgUm4/jVxNUTtmnUOuP/gi9LFBeHS7H6UNGfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196484; c=relaxed/simple;
	bh=Qnyg4AhO7AlWzaAjgnfboS2ahykzojmyYz/dy7vhqn4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hD4mdWCHjaeesjq9XbYhrXK4DytSnXt4a/T81nRo3T41Hh9vh8qNcPjzlKTpwkOZ9cN9QEgRBNszdzODV3wYqBw7E3+CL1GM5wNtRnw1CkoeOyjREGHb9ABk5diXAGU1KtHqnQT3SC/As3Y8k9zOOfLYN8YQADAC9em15V2dlPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLk8t7Df; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739196481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNF2zPwPgiY6vDrjo37ivtvlQa7hoNvAO5mHqkBo7W0=;
	b=jLk8t7Dfp5MffAU0liQagjeBwKsoXvDxSzVi7NFqlphOECD6C5E/s2HczLNXdqGDVqP5HV
	Y17f6ipS/SjWBRYgxprS+i7ZAa32Erg9BQ5zVPgSx45bVI0wxjaWt84o4/9yWqA3KkDBzB
	EOQB1M91XVHqwfDMm4ORcI2uEaYHO6g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-SyPxNyfjPEedBtdoOq5Ryw-1; Mon,
 10 Feb 2025 09:07:58 -0500
X-MC-Unique: SyPxNyfjPEedBtdoOq5Ryw-1
X-Mimecast-MFC-AGG-ID: SyPxNyfjPEedBtdoOq5Ryw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FC581955D8E;
	Mon, 10 Feb 2025 14:07:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38B7B3001D19;
	Mon, 10 Feb 2025 14:07:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    LKML <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: "netfs: Can't donate prior to front"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3052001.1739196466.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Feb 2025 14:07:46 +0000
Message-ID: <3052002.1739196466@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Can you apply the attached patch to your kernel, and then run with:

   echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_read/enable
   echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq/enable
   echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq/enable
   echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_failure/enable
   echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_donate/enable
   echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_progress/enable

enabled.  If you can capture the trace output (and compress it!), that sho=
uld
hopefully help debug this.

David

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index e8624f5c7fcc..8b78c1ec0677 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -312,6 +312,7 @@ static bool netfs_consume_read_data(struct netfs_io_su=
brequest *subreq, bool was
 	printk("folio: %llx-%llx\n", fpos, fend - 1);
 	printk("donated: prev=3D%zx next=3D%zx\n", prev_donated, next_donated);
 	printk("s=3D%llx av=3D%zx part=3D%zx\n", start, avail, part);
+	tracing_off();
 	BUG();
 }
 =


