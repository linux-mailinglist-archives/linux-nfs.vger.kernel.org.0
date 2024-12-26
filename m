Return-Path: <linux-nfs+bounces-8783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7BF9FCBDD
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54721162429
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0486252;
	Thu, 26 Dec 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxzf16jU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3F4C74
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230249; cv=none; b=CpWg6H+y/j1LVlwtwLE5D5sW0Br3CORDH3xQLQRqRBf8uxe/qePbc/CnQ3tIogRZu+QGdj391+eUhKy8XR9Zu3dObSrD3eooYdRAsAetGRHKXBU83LBwXHQSIXSC9oicyuOJ7q9L34e7ykXKIkAn6ZNZc94b6XwKu1dRJzKMvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230249; c=relaxed/simple;
	bh=kz/hExN0ihoax+uGMZmTES8KQJDKy9q83KWAGDeliPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdEcuLkiEqlqH49xzQoBvdOO7nwcDUJoMJFFtwhmuR9m5jywS1ISEOSTr5QaEIfcf5f7U5Cw9fY+zRZBoWHJxpOAqVuHJ6cKIgsKXsFOg7VOOvkBRSmpLPUeVASO0doRY3iuTrd7wGsUniH5Y2rH5f4ngSx8hO9r734aMU3DGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxzf16jU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so10913997a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735230245; x=1735835045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCzcUnoROET+F0AZeCcs607ThuNghv3ZYE1azcLt4+4=;
        b=bxzf16jUONt9bKBzX/HdXL783uVBtYYfkSVfGOy0fW/FA5eK+JzlEP6mnNMOhy2I5z
         CU1WXnpZaVZUzv/yae012cW4DqdxKBF+ZPSqGDY7qes/J0XkZ0fozzgv61rk05Ga+Nh+
         ap/Lu2HjCb8n1XxjqT4hsTAWRKa0Z9Nelhck/aHFbnagaUVzaz05vQEAGnZAt+lMgvFY
         rqyH0oBagkGFktE59xlyevOPRuoB6e9oQOUTxV/Lr3ixqyLZtMl08IJyFh+x8zti7ttz
         +a0jMLFawRMhU6IFlE5GpFyofsSkPJN7GZn3tffEkqRWK53/8FNSC5Oxs6kVQgC6v2u3
         erzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735230245; x=1735835045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCzcUnoROET+F0AZeCcs607ThuNghv3ZYE1azcLt4+4=;
        b=TILFNDWTXcD50/ybVtzMeDZpHxOU+v8yYdfBqrt4Z9tQbuz1821lv6mo4Q47mMTtG0
         OlxvLQx+n/tY9HPK1yoOfNTw35LmWebpSo7qMJEzeakuMvUinLGuO0n1YFkGgdJmEeWk
         uqKS5LtWrOI5e6saeIRYloIMzfaMKuLi5EpZXFeVxaadnCZcJgPk5Mkae6Iz8a/npK4j
         Lk9rEOhn+kFy/F05SpKk3YNPxyY3hOy6f3mIlVBYwuk+WIGzqxYVXLYAXfAyAMS57OWm
         GNm5hWTNKSqfeUfc3aO5Qnl1RRapiFzefvfyQS5yNqolaeatjfA6za72SEonJbbtJKU/
         +eEw==
X-Forwarded-Encrypted: i=1; AJvYcCX6GGkb1Spb+4BFABPO+rLQQJ2eAyCwRrnUQrfgwiAFkSRAMSBZLgYa2b0zzDq9Ye4gacoI1IrvKYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbCCV/AczB3bAQdJdGG2vPlu1lqimosZbnGNrqBqG840ZcW3ci
	dTlR0naykAXLF8PYFOCsiqdAN+ZbZlV941NfQwaMq8AgY3JoUxq1
X-Gm-Gg: ASbGncuCFJvDWksDEWKC0920q3jfNRcx/Ka6KxqXl+Svms21JxvJRnGZviH9oSY1TaC
	bvNVr9yTrUx+QiOX9e18AniSvy3XwPQYt5o5Xi6sbP3XWopLEk6hqEpbg4uOTyrWL+QfthtOIez
	t7weKWtpAgYbTvAiTa6ArTR94+v8EisIr5PGkoVsruoWD/Ot3KC6HSVPcHoI/I0eF5n2lkWFbRQ
	JDlFc3h3w4kSEEcqP7Sav+gdhVKXllL6+VH/6cED2HpBDMA8hzFt8tV9Fz9jkVVwyUeFTygebIZ
	id6RkQWZzJ4/v9oF
X-Google-Smtp-Source: AGHT+IEZ3fIH6S0/NcWuX9FYgSiOMmkWFW+1x3BqMt+IWCfW7Vvxr8zIob1rVpQViiKJryZ9rSD0Ow==
X-Received: by 2002:a05:6402:501b:b0:5d0:efaf:fb73 with SMTP id 4fb4d7f45d1cf-5d81ddc3ca4mr20223484a12.15.1735230244968;
        Thu, 26 Dec 2024 08:24:04 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a535sm9375392a12.6.2024.12.26.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 08:24:03 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C77B9BE2EE7; Thu, 26 Dec 2024 17:24:02 +0100 (CET)
Date: Thu, 26 Dec 2024 17:24:02 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jur van der Burg via Bugspray Bot <bugbot@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: anna@kernel.org, trondmy@kernel.org, jlayton@kernel.org,
	linux-nfs@vger.kernel.org, cel@kernel.org, 1091439@bugs.debian.org,
	1091439-submitter@bugs.debian.org, 1087900@bugs.debian.org,
	1087900-submitter@bugs.debian.org
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
Message-ID: <Z22DIiV98XBSfPVr@eldamar.lan>
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
 <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>

Hi Jur,

On Mon, Dec 09, 2024 at 04:50:05PM +0000, Jur van der Burg via Bugspray Bot wrote:
> Jur van der Burg writes via Kernel.org Bugzilla:
> 
> I tried kernel 6.10.1 and that one is ok. In the mean time I
> upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue.
> Sorry for the noise, case closed.
> 
> View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
> You can reply to this message to join the discussion.

Are you sure this is solved? I got hit by this today after trying to
check the report from another Debian user:

https://bugs.debian.org/1091439
the earlier report was
https://bugs.debian.org/1087900

Surprisingly I managed to hit this, after: 

Doing a fresh Debian installation with Debian unstable, rebooting
after installation. The running kernel is 6.12.6-1 (but now believe it
might be hit in any sufficient earlier version):

Notably, in kernel-log I see as well

[   50.295209] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   52.158301] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   52.158333] NFSD: Using legacy client tracking operations.
[   52.158337] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory

Normally it should have been (if using the more modern client racking
operations):


[  145.851951] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  146.891838] NFSD: Using nfsdcld client tracking operations.
[  146.891844] NFSD: no clients to reclaim, skipping NFSv4 grace period (net f0000000)

I can reproduce it if I do in following order:

Install Debian unstable, reboot after installation.

Install nfs-kernel-server package with its dependencies.

In our case this is nfs-utils upstream already at 2.8.2.

I notice the following observation: When installing under this
condition the package freshly there is not yet a valid:

/var/lib/nfs/nfsdcld/main.sqlite

for the nfsdcld, and so it used the legacy client tracking.

At this point we get the splat. if before installing the packages I
initialize /var/lib/nfs/nfsdcld/main.sqlite:

mkdir -p /var/lib/nfs/nfsdcld
chmod -c 0700 /var/lib/nfs/nfsdcld/

and

sqlite3 /var/lib/nfs/nfsdcld/main.sqlite <<SQL
CREATE TABLE parameters (key TEXT PRIMARY KEY, value TEXT);
CREATE TABLE grace (current INTEGER , recovery INTEGER);
INSERT OR FAIL INTO grace values (1, 0);
INSERT OR FAIL INTO parameters values ("version", "4");
INSERT OR FAIL INTO parameters values ("first_time", "1");
SQL

So to me it looks that the problem arises from actually starting the
services were we have to fallback to the legacy method as we cannot
use yet nfsdcld.

One other observation: if while installing the package the nfsdcltrack
utility is available and the these NFS client tracking methods are
availabe, it seems that the issue is not hit, and dmesg shows

[  216.206678] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  218.215961] NFSD: Using UMH upcall client tracking operations.
[  218.218074] NFSD: Using UMH upcall client tracking operations.
[  218.218078] NFSD: starting 90-second grace period (net f0000000)

In the most recent nfs-utils packages we do actually not install
nfsdcltrack anymore as as I understand it's encouraged to move away
form it as nfsdcld is available.

Regards,
Salvatore

