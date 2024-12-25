Return-Path: <linux-nfs+bounces-8776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F399FC462
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 10:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6E6163915
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93AA17993;
	Wed, 25 Dec 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhxo524+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2D24B34
	for <linux-nfs@vger.kernel.org>; Wed, 25 Dec 2024 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735118152; cv=none; b=Odfw6sfrYOonzQCyNO6qqtZQnmtn9jqZ42/uJL7v967cmC4LoWzvQI6sx/zCAGr4XSo+dMxpKr99wKelGUX8LVUtZs8U9/qLfN0tDhtRflb8/bLSrDY9GpZm49ffLcRZCph/tUHrJDdMzsPGDGQNmGc4xY3RjbRcIQXQJIabPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735118152; c=relaxed/simple;
	bh=xFYhYKoZWh94YI11wxvj6/NoY1VwFiJ19YaDnS9q81Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1VmIKbsZ3QpEyUAWCqb+2YVl02DODNwdh01Ok4kWPOEWfuWBofT3+kO/3DIOuwz0d/JFpiAwFgLHUB0hLVbaijEU/vY+8Le6KkUZS0XDMLz6uZUgUHKFZ+PPd69IOWk3JJq/+1oc49Ri8GsDuomJ5kBcfhanj81Z327DoS6WHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lhxo524+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaeecbb7309so233791166b.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Dec 2024 01:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735118149; x=1735722949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrXAHy7bFssZtn2+hXzCCNKCRoNl/u0JDKVfaKj7ZpU=;
        b=Lhxo524++KKq4l16PTgQk0hAA9gpE+WEao8bZTaQpSlu7zrxNi6wKyEzGz3XWf8Uig
         0biaZfTyLwPgSoOHrNOfZfhnyyZhhsNlbUjGC/jbGov4oU34+sFnWT1NLNG53tswG63F
         p6dV3qXGaQmrWsjb2xBpYbphDArWI5l9jVrjEwAo+Z8ziW1lHJMjWis1pxigwFu85UbJ
         pm96ZVnhROKCyne8UCDZUEfuPvhBi2hoyZbfAjQ0GD/NE69IbbxB1cIAymCeA0a5Hh4f
         btaWIF2lNpSJn+vb52FPDn3z6pODwCH79iycb+UlLkmA0VJNaBHoGZ6LmpV+PwJa20a/
         klXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735118149; x=1735722949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrXAHy7bFssZtn2+hXzCCNKCRoNl/u0JDKVfaKj7ZpU=;
        b=AWgvb7pegKBCmuO9PyMmUCJkEiELkObqI1H5nCk73hvNs7cywSRKPM3AVDOwSpTIb+
         7/SbMn0OyX3mHLwUYLMYwj91Jdyj91XMiRJkouRCSpIHNpy/OHaqAJVDYc6JED2rn4Kx
         pBzR36jnCcFn+WinCtHTmMO5h3qUzzCaLUKmn8TRUbdkEUNvIqZnUGjE3WfMw3rskGgr
         gkOkFZZTzYp8NgGQ1cpuYCGG4Ud7QRO+YUgVyTjK/RChzB/U4dutKqPN6FKn0N26Uf02
         AKT7Of8uolXT2oKugz3XVOp7PX1/98Gj7DDsItQutB4EncJ35oM80lxNdvyioZfLM63Y
         EaOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSZO19T2vMynxd5Uti8uDHg+vmmW1wpPCuBaoP662KcqCV+W1pKFecbJUnz5LRTuNvLUL4JoT2/DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Yi09vFofaoNWusYiH/lJ4z82aSyvfZ/2WICmt6X7rV2wN5/k
	DCMHa/XqZDWdnb2RSgtZ4w8QbokRMXm5754eULlSCsNCPkJhhdkM
X-Gm-Gg: ASbGncvjGgZYme1rsDasmVp0vSyZBwAaLoxjstkDTV2ITFWl77upbYtC06CDhPx3LbF
	BhJBgL+80S73Do2XNOnrpZnI/cEF7G8I2O3SD4Z4+stvGKq/x16B7oyExpqLKElrRQod/Os3ubs
	I+vbCV/Q3ES1t9MkNRqevijiDXdQtcqdKzRBCb0ioTdzIJO3AMCZq33S5FNhKLUg84FgZZQSrfY
	Z8tQzck3bNHunJPJBmzZiWFi77JjRoC4832yqcSEIALjEc2IYK4PzHoihZgOUvYsyBhqoUWQpXK
	cFiJkrsb43a14kuP
X-Google-Smtp-Source: AGHT+IGvX/HlVQjJOVLkdxqPLyTGB2XJarDfUuDzuJ94CDNllNRVs+beZ728R1jvuZAVZ2SyZqg5Dg==
X-Received: by 2002:a17:907:3687:b0:aa6:9198:75a6 with SMTP id a640c23a62f3a-aac2ad81a4emr1805650566b.21.1735118148716;
        Wed, 25 Dec 2024 01:15:48 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06cf19sm770585166b.198.2024.12.25.01.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 01:15:48 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 334E8BE2EE7; Wed, 25 Dec 2024 10:15:47 +0100 (CET)
Date: Wed, 25 Dec 2024 10:15:47 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever III <chuck.lever@oracle.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Harald Dunkel <harald.dunkel@aixigo.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	herzog@phys.ethz.ch, Martin Svec <martin.svec@zoner.cz>,
	Michael Gernoth <debian@zerfleddert.de>,
	Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
Subject: nfsd blocks indefinitely in nfsd4_destroy_session (was: Re: nfsd
 becomes a zombie)
Message-ID: <Z2vNQ6HXfG_LqBQc@eldamar.lan>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>

Hi Chuck, hi all,

[it was not ideal to pick one of the message for this followup, let me
know if you want a complete new thread, adding as well Benjamin and
Trond as they are involved in one mentioned patch]

On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
> > 
> > Hi folks,
> > 
> > what would be the reason for nfsd getting stuck somehow and becoming
> > an unkillable process? See
> > 
> > - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
> > - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
> > 
> > Doesn't this mean that something inside the kernel gets stuck as
> > well? Seems odd to me.
> 
> I'm not familiar with the Debian or Ubuntu kernel packages. Can
> the kernel release numbers be translated to LTS kernel releases
> please? Need both "last known working" and "first broken" releases.
> 
> This:
> 
> [ 6596.911785] RPC: Could not send backchannel reply error: -110
> [ 6596.972490] RPC: Could not send backchannel reply error: -110
> [ 6837.281307] RPC: Could not send backchannel reply error: -110
> 
> is a known set of client backchannel bugs. Knowing the LTS kernel
> releases (see above) will help us figure out what needs to be
> backported to the LTS kernels kernels in question.
> 
> This:
> 
> [11183.290619] wait_for_completion+0x88/0x150
> [11183.290623] __flush_workqueue+0x140/0x3e0
> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
> 
> is probably related to the backchannel errors on the client, but
> client bugs shouldn't cause the server to hang like this. We
> might be able to say more if you can provide the kernel release
> translations (see above).

In Debian we hstill have the bug #1071562 open and one person notified
mye offlist that it appears that the issue get more frequent since
they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
with a 6.1.y based kernel). 

Some people around those issues, seem to claim that the change
mentioned in
https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
would fix the issue, which is as well backchannel related.

This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
nfs_client's rpc timeouts for backchannel") this is not something
which goes back to 6.1.y, could it be possible that hte backchannel
refactoring and this final fix indeeds fixes the issue?

As people report it is not easily reproducible, so this makes it
harder to identify fixes correctly.

I gave a (short) stance on trying to backport commits up to
6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
seems to indicate it is probably still not the right thing for
backporting to the older stable series.

As at least pre-requisites:

2009e32997ed568a305cf9bc7bf27d22e0f6ccda
4119bd0306652776cb0b7caa3aea5b2a93aecb89
163cdfca341b76c958567ae0966bd3575c5c6192
f4afc8fead386c81fda2593ad6162271d26667f8
6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
57331a59ac0d680f606403eb24edd3c35aecba31

and still there would be conflicting codepaths (and does not seem
right).

Chuck, Benjamin, Trond, is there anything we can provive on reporters
side that we can try to tackle this issue better?

Regards,
Salvatore

