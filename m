Return-Path: <linux-nfs+bounces-9618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E66A1C6E8
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 08:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845E818855CB
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A72913D893;
	Sun, 26 Jan 2025 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrMJYvXL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7154654;
	Sun, 26 Jan 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737878246; cv=none; b=VSFvTvIHF/DVy6wAEm+u2k1aQ/bBcA3juyBzt9908It66WqSZtstqd8uOLR8WcRpbdd9zn9HeIOd+mpznqqH5xDqBIYhJ4Z7/OIXsT4Q4H/Kj3wf+Teo+UrRSMDI0Z2BjfWMnEfuOGIAi4OU5KuCBoH+CsLq8xoh6ZLSbPj0KD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737878246; c=relaxed/simple;
	bh=EXyzFk4KOKjkXRO5gk3CmopYRTlPYR4MXMrJ526c2J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5X3x8LNL23fyCG6qK26oOIm6MYRQTpXcdjSQmGAqIf6W19gtGTQHepnwO6je3EqPjZYkLWvphqj1k0KZnoNjP1CZNeIbQMWHIYTqDa6Ig7A3VbOgGU1qb7YP27EHd402HPLoIA0OSexgS5QlBVGc7Y5qUo3oc3RxJ+davYlaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrMJYvXL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf60d85238so578174766b.0;
        Sat, 25 Jan 2025 23:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737878242; x=1738483042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0I75JhZSSirWfEY55OO4Q365JrpYiXTEmbNdP/ZLjI=;
        b=BrMJYvXLj1XIINYQkbqYLq/EQ8nUgJOBufGUEEWQLKZrhdP/JzEC0QfxQo3kIOlx2d
         A5bUg85x6XJmQMGv2S2Flxeaa3Rv2F2DEZq35X9aQTIYu+ldFYOXzVgY0uSMPrk01uxC
         3kO2qKMptmZS12ACWVGBo5lL25ahI40OFFJgrEflcS3L3UlNTF/aRXE5er3tDTD5IA3M
         3WSDHyqzr+vde+6ixSkZd8Eo8kWKaj2JgVWSiMDWKecVEXgqueC1UWH6AS60frR4W7HZ
         tOM8cW99bwpVJNsj3sI9vjn47OaFVPfWZZ/7lxkEEL/BGS7aEsZfYFVKMg4tOPf22ivd
         2a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737878242; x=1738483042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0I75JhZSSirWfEY55OO4Q365JrpYiXTEmbNdP/ZLjI=;
        b=sUkCk0xiH2Awih+V+2g53/Oe2I+WVgBazRyp8+ilv97Uw5uQasPhXRvoorquAkFSLb
         +zDJc9vqFcBP85JCRPrDonYT4zO/ptwSXz4d7bFkCy0i/HCfCDQyFAmP/cSNOjp0T76X
         9dIX1SgGC+HLqNTlnAO1q9YWcpM4bWmc6pkd0lyk4YNGsPQ0pYyDMq3rAu+i8x2fs7FK
         +3gqvzgX/+yJQq+JS/dYveKAndixNvHJm7aLyFtsH9B/y+beyKCO+o/Qd0Nsbd+TSwJT
         zrgDEt+E0RbsSjYmemZrhOtAKvtPozreuwa98e62poygaTXoh1dDEegoK6hApe8Rg65p
         pUew==
X-Forwarded-Encrypted: i=1; AJvYcCU6yVJaQlwqO3jL8G+3x/n7rQvZIB1gGIyUNR3UPia2Sfq1cv6Klw1zrt1Kbv8nt6FiTVJ9EbJ8V9zT@vger.kernel.org, AJvYcCVqmyE972GEVSbaZrhAlX/yTx4hstsbG7PxOAkftO1TPQ5C7EHNVQuQu2iF8XiNr5kso3V36SzU3BdlUHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGa0dfy2mjaEFLfIe9GdbBUk6wd0AePz9c6vweynzWfOwHLrtz
	20jRZjbMhdYgA6E4x7Tg8iiQhSuvBLvdU46T4x3oAp7Chh3KTFem
X-Gm-Gg: ASbGnctUJheOTmckbtJpO+jvwPDWMuz0cl7lv6u0W7X2IjRZv2JCvy9qQtZZAmwK+b2
	hi5073POzK53UaRM0+KULU7qXrvJa/Yi2p95iiepu3Wy7gHna1nLbFw9Lox783IyQjSsm4jn9Bh
	WgyEIKq3W6wtwhT99/i/u+ufByxo0amXObv85vpP+QJA7PslzQR1pf2i+IPLJ8Kv4TvC6hdr9KY
	13Ein6U7RTnRSf0QOGBZSgob2cgHT+crUFHc+bhLq+8d5D4i8qLdfOoRMCLtoo4TXP0AoelqzXS
	C4cpn0k8jLwWYDh0aBzMn1yi41JUG7upAwEjTQ==
X-Google-Smtp-Source: AGHT+IFn2nEVvH+i9/fMWdOmLr2kkmLJo39fFn44w1qVt7lyRyDSazEyYAnPn0T7JS75hWjLNLCMxA==
X-Received: by 2002:a17:907:9721:b0:ab6:6175:27fb with SMTP id a640c23a62f3a-ab661752890mr1319204766b.16.1737878242221;
        Sat, 25 Jan 2025 23:57:22 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760b7f25sm389643966b.118.2025.01.25.23.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 23:57:21 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8D655BE2EE7; Sun, 26 Jan 2025 08:57:20 +0100 (CET)
Date: Sun, 26 Jan 2025 08:57:20 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel NULL pointer dereference: Workqueue: events_unbound
 nfsd_file_gc_worker, RIP: 0010:svc_wake_up+0x9/0x20
Message-ID: <Z5Xq4KOWcF3Z-GZT@eldamar.lan>
References: <Z5VNJJUuCwFrl2Pj@eldamar.lan>
 <7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org>

Hi Jeff,

On Sat, Jan 25, 2025 at 05:55:50PM -0500, Jeff Layton wrote:
> On Sat, 2025-01-25 at 21:44 +0100, Salvatore Bonaccorso wrote:
> > Hi Chuck, Jeff, NFSD maintainers,
> > 
> > In Debian we got a report from a user which triggered an issue during
> > package updates hwere nfs-kernel-server restart was involved, then
> > hanging and included a kernel trace of a NULL pointer dereference.
> > 
> > The full report is at:
> > https://bugs.debian.org/1093734
> > 
> > While I was not able to trigger the issue, the provided log is as
> > follows:
> > 
> > 2025-01-21T12:07:01.516291+01:00 $HOST kernel: device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> > 2025-01-21T12:07:01.516310+01:00 $HOST kernel: device-mapper: uevent: version 1.0.3
> > 2025-01-21T12:07:01.516312+01:00 $HOST kernel: device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
> > 2025-01-21T12:07:13.528044+01:00 $HOST kernel: NFSD: Using nfsdcld client tracking operations.
> > 2025-01-21T12:07:13.528061+01:00 $HOST kernel: NFSD: no clients to reclaim, skipping NFSv4 grace period (net f0000000)
> > 2025-01-21T12:07:17.558915+01:00 $HOST blkmapd[1148]: exit on signal(15)
> > 2025-01-21T12:07:17.574410+01:00 $HOST blkmapd[239859]: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No such file or directory
> > 2025-01-21T12:07:18.015541+01:00 $HOST kernel: BUG: kernel NULL pointer dereference, address: 0000000000000090
> 
> Thanks for the bug report. It's getting late here, so I can only take a
> quick look. svc_wake_up is pretty small:
> 
> void svc_wake_up(struct svc_serv *serv)
> {
>         struct svc_pool *pool = &serv->sv_pools[0];
> 
>         set_bit(SP_TASK_PENDING, &pool->sp_flags);
>         svc_pool_wake_idle_thread(pool);
> }
> 
> pahole on my machine says that struct svc_serv has this at offset 0x90:
> 
> 	struct svc_pool *          sv_pools;             /*  0x90   0x8 */
> 
> So it looks like the nn->nfsd_serv was a NULL pointer. That only
> happens when we shut down the server, so this looks like a race between
> filecache garbage collection with shutdown.
> 
> The filecache gets shut down in nfsd_shutdown_net, which gets called
> _after_ setting the nn->nfsd_serv pointer to NULL. We'll have to look
> at whether we can reorder the NULL pointer setting to later, or work
> around this some other way.
> 
> Could I trouble you to open a bug for this at bugzilla.kernel.org?

Thanks a lot for your quick response on it and the analysis.

Sure I can fill a bug in bugzilla.kernel.org, I see you submitted a
patch already, do you still want me to do it?

If so I try to reference as well all followups so that the information
is not spread around threads.

Thanks a lot for your work!

Regards,
Salvatore

