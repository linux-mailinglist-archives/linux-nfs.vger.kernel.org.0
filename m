Return-Path: <linux-nfs+bounces-9627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9804A1C7C1
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 13:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC17D164516
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397225A657;
	Sun, 26 Jan 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCdpbH1L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82C645;
	Sun, 26 Jan 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737896073; cv=none; b=abW10v1BsGsuHzBW49EHBpK/EUyMBmkpyiLDdLT1cVjaOhO2JjsVNT/20VA4fGKwUWGVtUp7EsRkZwEIad9OpSEaIfTyAlrwCPx6F+U5CCA7k+zMABS3FC+h3CWN4GZQn8RhXtGadvhtEdojwfILjjDcdqNV6Rfn8kSX+hJjoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737896073; c=relaxed/simple;
	bh=onvrZB6ca279KfbDTuAn5Wm8glDHntBewriaIJjhJBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxPa2V3pGEgYenFyCRlDW5H6P5UdT8aZi9tdC06Kq9PPc+XHf9wjo9ZQbePVaDFObwjQWd9He1jT/QMUyuKATeiVPTk+L9+HR80ZmkmXM9272AHQmXzgBHhHA/yAVx2U8JNFJtwoIBqjLB/FaOzXHkylIIRj42Ztp6cRYy/bpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCdpbH1L; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso5913948a12.0;
        Sun, 26 Jan 2025 04:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737896069; x=1738500869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLO01tKxNhgMywHJy1ux4gu8giKfm2lRApH8lq8PP+E=;
        b=CCdpbH1L935uJqqYHWCXEmVYa0h0PiIyk/yAKSe3r0HEE+AdB+z1ojNXuhuRcZPvM7
         EVIZ8Qzt4IRK70K4JBi/r+tQRI1trxOrSxSNa075n/vnfhBBtjcM6pzDATQQAdVlIgB7
         jvtohCtTsRVM8nMoGHMzZQ4bV9LRTzXBGPyKD1SQODRlWzNXHt7RQXeElJ9+/Hvful4z
         Za3xwmZ1EWRwKTINKyphEPoquP/efKE44e072z9XEGPnI+ylPEPid/EJWwFFHQAFk3rN
         mVUYgu3Qz38KznNXE5Eho5MP94lTqRI0bwUEGlpfB3JnrjQ3geKex4j1HJ12e5U05UzM
         6Qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737896069; x=1738500869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLO01tKxNhgMywHJy1ux4gu8giKfm2lRApH8lq8PP+E=;
        b=V4XGgFnRMQu+utBPas7HexH4ozv9w2SHoRVZE7/j3scfDAOaZ+Q90m5lpst7Oq+8J4
         S5lXV6lzc4uxcLWEiCZmmVR5W6Ze/hI5fZPrw4c3GGhkBw8R7XfwuQmOJfuNsfdKxFOk
         81+CsAO3z1V+4xKtjsnA9yOEbIp0RvrYIu1QTx4w6q7SYJfQvLCTxxTyGKY14pomvTez
         zNsmOYaytnzZ5UYUcPF4gpNcfRNBF1lcByzAPrD1Qil1E/1BZSM2PEM0ZLjbkAZf++1D
         GyFGVMhkpZW0J0b5URvzL5VPbKCCnOXbZGmQNxjgkj44sB+22n479GkwJ6KN9nGKyoZ5
         xOMA==
X-Forwarded-Encrypted: i=1; AJvYcCWA01F60bfDJkpXvjf+Vbmg3h1gkoEZ/KRIqrbyKQrQ3YNhZ8pYWXorCUCjG/XuQvfLFiTElz2nBuhZ@vger.kernel.org, AJvYcCWXULd0qzgh7XDmG00TnU1qvTRe1CCoIvJAgSgl0sI+w5GwJYvNJmMOU4gnEdtkP9hzNETeQZE184Ycuow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSeuo6oSvpq/+3hzj0/TjgLtNA776cUQ4cuCSgFIpcnHXeHpiu
	zR9zoST2yFVECh9SxFpQPveZ3kR81e2hCZrYWvJI/P9G8sDQcye/7mkts40n
X-Gm-Gg: ASbGncv4CIOruwKTX6GcEEqIbRQGe7HpbqggUMQXXkjp/LVnUa4nWQPIyoqRrjooI5U
	a3p3YECgUyNmYHzjWP8wT36B0mpI50MvRZmL51yHWTqnVyx8JVstMoTqeY+zWbZbRPA/0Z5d448
	ExMJJb7bxrxV4geEZqpIA+RBEeAzIAr3s9cZBfh1YV9EB14YZ1Wo/zKCV476UVkn6n8IETsTQxs
	TmEX68+z0JZFPFp7mjMAEoHzsD7U1dEhtEOrMCiAinn+bUAcXcSLkAYoJ915/pSSlhqvC8ebOdl
	oUsgl3Z1Yqep8oduuWx+2nB896V6i4sgPSmo7Q==
X-Google-Smtp-Source: AGHT+IFHnJ2GdaairKl3JSF9vUQhG4eg3KUMiAWdCG2pNRRV/f3p4o+NC0HO3fvgCtQ/J3LrJj/jYw==
X-Received: by 2002:a05:6402:2815:b0:5d2:7396:b0ca with SMTP id 4fb4d7f45d1cf-5db7d2f873cmr32991504a12.12.1737896069305;
        Sun, 26 Jan 2025 04:54:29 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18640df4sm3862218a12.48.2025.01.26.04.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 04:54:28 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id EEF06BE2EE7; Sun, 26 Jan 2025 13:54:26 +0100 (CET)
Date: Sun, 26 Jan 2025 13:54:26 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel NULL pointer dereference: Workqueue: events_unbound
 nfsd_file_gc_worker, RIP: 0010:svc_wake_up+0x9/0x20
Message-ID: <Z5YwgqH7t2BwYory@eldamar.lan>
References: <Z5VNJJUuCwFrl2Pj@eldamar.lan>
 <7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org>
 <Z5Xq4KOWcF3Z-GZT@eldamar.lan>
 <8d8de0b77a258e1c7e7fbcde956c8eba415d4b22.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d8de0b77a258e1c7e7fbcde956c8eba415d4b22.camel@kernel.org>

Hi Jeff,

On Sun, Jan 26, 2025 at 07:06:09AM -0500, Jeff Layton wrote:
> On Sun, 2025-01-26 at 08:57 +0100, Salvatore Bonaccorso wrote:
> > Hi Jeff,
> > 
> > On Sat, Jan 25, 2025 at 05:55:50PM -0500, Jeff Layton wrote:
> > > On Sat, 2025-01-25 at 21:44 +0100, Salvatore Bonaccorso wrote:
> > > > Hi Chuck, Jeff, NFSD maintainers,
> > > > 
> > > > In Debian we got a report from a user which triggered an issue during
> > > > package updates hwere nfs-kernel-server restart was involved, then
> > > > hanging and included a kernel trace of a NULL pointer dereference.
> > > > 
> > > > The full report is at:
> > > > https://bugs.debian.org/1093734
> > > > 
> > > > While I was not able to trigger the issue, the provided log is as
> > > > follows:
> > > > 
> > > > 2025-01-21T12:07:01.516291+01:00 $HOST kernel: device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> > > > 2025-01-21T12:07:01.516310+01:00 $HOST kernel: device-mapper: uevent: version 1.0.3
> > > > 2025-01-21T12:07:01.516312+01:00 $HOST kernel: device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
> > > > 2025-01-21T12:07:13.528044+01:00 $HOST kernel: NFSD: Using nfsdcld client tracking operations.
> > > > 2025-01-21T12:07:13.528061+01:00 $HOST kernel: NFSD: no clients to reclaim, skipping NFSv4 grace period (net f0000000)
> > > > 2025-01-21T12:07:17.558915+01:00 $HOST blkmapd[1148]: exit on signal(15)
> > > > 2025-01-21T12:07:17.574410+01:00 $HOST blkmapd[239859]: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No such file or directory
> > > > 2025-01-21T12:07:18.015541+01:00 $HOST kernel: BUG: kernel NULL pointer dereference, address: 0000000000000090
> > > 
> > > Thanks for the bug report. It's getting late here, so I can only take a
> > > quick look. svc_wake_up is pretty small:
> > > 
> > > void svc_wake_up(struct svc_serv *serv)
> > > {
> > >         struct svc_pool *pool = &serv->sv_pools[0];
> > > 
> > >         set_bit(SP_TASK_PENDING, &pool->sp_flags);
> > >         svc_pool_wake_idle_thread(pool);
> > > }
> > > 
> > > pahole on my machine says that struct svc_serv has this at offset 0x90:
> > > 
> > > 	struct svc_pool *          sv_pools;             /*  0x90   0x8 */
> > > 
> > > So it looks like the nn->nfsd_serv was a NULL pointer. That only
> > > happens when we shut down the server, so this looks like a race between
> > > filecache garbage collection with shutdown.
> > > 
> > > The filecache gets shut down in nfsd_shutdown_net, which gets called
> > > _after_ setting the nn->nfsd_serv pointer to NULL. We'll have to look
> > > at whether we can reorder the NULL pointer setting to later, or work
> > > around this some other way.
> > > 
> > > Could I trouble you to open a bug for this at bugzilla.kernel.org?
> > 
> > Thanks a lot for your quick response on it and the analysis.
> > 
> > Sure I can fill a bug in bugzilla.kernel.org, I see you submitted a
> > patch already, do you still want me to do it?
> >
> > If so I try to reference as well all followups so that the information
> > is not spread around threads.
> > 
> > Thanks a lot for your work!
> > 
> 
> I think you can skip the BZ for now.

Ok then I leave the bugzilla bug filling step off.

thanks again for your hard work on the NFS front!

Regards,
Salvatore

