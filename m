Return-Path: <linux-nfs+bounces-17239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D45CD1065
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2D51302C715
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840B732827D;
	Fri, 19 Dec 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="w/j2ZItT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE73009E1
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163723; cv=none; b=pVvPmZmjpoJEhdOqRVwkl/Q63oHefa+QFag91ZMNkHM704hmTSGnVt0oPn0Stn8uPTES4rePJeBz3xTXYjw/P9LV0n/MKb58zvAXovcvcncOBrelKe6CvVgKPIqDOV6+JfGwAlg60DcqkLAWecTw6Z2WOkKTH4JDwzS2JYrj4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163723; c=relaxed/simple;
	bh=4SOBkthImmJzxLZLQ0s6iqP5eBQoze2VaxUSBNu4DVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXfSTIlRlih6O3PYiHFo7fKfCM49TRoXhfYYshpkkUGvxSV6ZR+ukc/pWivO8+ge/YWxXYxGnr8Bl5vkhcfJseeiYbMig40xM4OigTY6tK/7lFJ7JpV5iymEMtemHHfB8xnlPTP/vCpLelsnGgrP2MUnmUYAVjAZy3nJhrVqTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=w/j2ZItT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so813735a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1766163720; x=1766768520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4SOBkthImmJzxLZLQ0s6iqP5eBQoze2VaxUSBNu4DVY=;
        b=w/j2ZItTxx9ycfBwbQJ/N7/aiw8RgFvV3vfAbUIZZNSEE0bRQrBBqELZQeAJhEuQkQ
         0jKBTR+4rnywC3LDYCf8oYlSs9EPwhmtybVIV2WffD7H52MhJbFS1zwzh7uJiM5bX3g2
         iV9SHeIBMcLGIouBJPB2wWJXkJpTEQAgCizy2YwK9+ZCUKcUz0EvxC4ZXWd2isjn4FNj
         39NCc662DKe8Ana5xhy+lZlOs0IgqSUW2FKatpmsgM2eDmlGXky18SEKfJlrghbpScIa
         u2sOSfoTs55ZzsoSTKAhMySwVozZ1DgyJMS004juJsT6G8HDL2lv2h/N8EA0AI7isX1v
         zV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163720; x=1766768520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SOBkthImmJzxLZLQ0s6iqP5eBQoze2VaxUSBNu4DVY=;
        b=URZ2GOAMzJ+PIBBuFoGQ/19DUR2SWYhRdxaI95bvu5TgwMW+ylK1MBpSAvFxDjjb5/
         aQ6EvLhKM8EWTpEqXOqi+Up6hvl56l2JGM1WCgp7UT27f3omG726khUwu8PkpzKVa8al
         O3be4fClxL8Px/0uYqtO7ru0Drp2bmfbzGKyO0gbImpBJLwN4mAz6Wuax105hzSR4RDT
         kZV+p99aNUjCQAjKAO63la+D9EIKjDOo8eZJ6vbLYz/KxLnO5dmMw2FGt8/d0GOdbiuO
         1+RmXTiQBVjcQAYk1fW58vkseYeqzrhCn5AlpPRGTc5Hj5um5HmKISBGlE4IlN9kzyzt
         B8Ig==
X-Gm-Message-State: AOJu0Yx396sA8zyLnTQ1NQuoXE23x9adNAuxmXVngecA5PP4E8ZIzXZE
	3Y/LrQq1HAh2z1W2Zhap8JeUMXUOghncYAtqnxNOzJdYic0yuz05QxuKODG081NR9Ks85Cv5O5U
	9aXYKHOqSwQ/gXJ51zXxVYP2cMr4VcSUfqjTfcOs9CA==
X-Gm-Gg: AY/fxX6fWW4VrxjQ9D7dBwvTQ1+zET1nWUW9RrvPmWjftydMzg122jvF/RT0qDKOWCq
	9to+TdNqiA5kFIIzxM+wF6ncoIvN+4mWVREkbEv85Xzn0IgpH9HHxWvd2uPrirPgOfQdEyy7S5o
	AaPzIg2l6m8oPHI6r37UFZYHByQGZNMe0vFGGdcfLNryZdCQS6HI9TLno7vWtEpQKOmGLzn5pVz
	75rAtd4vRyVUObxEf1p1OGgSd9/x8DPUTXy9tm4/iFIBCwWaEzrGrz2SNScc5WlBQxMaw==
X-Google-Smtp-Source: AGHT+IFYZ+T/DDBxZfTv12nqi2MKs8l2/c/zepK2RVF8SggZrcKR3TLEu57nFKme181aAS6NO8AWiWlcMI4B7+apghM=
X-Received: by 2002:a05:6402:5108:b0:649:b4d8:7946 with SMTP id
 4fb4d7f45d1cf-64b8edb3335mr2602774a12.23.1766163719739; Fri, 19 Dec 2025
 09:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
In-Reply-To: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Fri, 19 Dec 2025 17:01:22 +0000
X-Gm-Features: AQt7F2oOfNfsPv8P8u21bp56Q8bnBK7hqHEOp3yV5u7A9mLHNUlUs2vFNcxWnPo
Message-ID: <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
Subject: Re: fscache/NFS re-export server lockup
To: mjnowen@gmail.com
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 16:25, Mike Owen <mjnowen@gmail.com> wrote:
>
> We are using NFS re-exporting with fscache but have had a number of
> lockups with re-export servers.
>
> The NFS re-export servers are running Ubuntu 24.04 with a
> 6.14.0-36-generic kernel mounting Isilon and NetApp filers over NFSv3.
>
> The NFS clients are mounting the re-exported shares over NFSv4 and
> running AlmaLinux 9.6.
>
> When the re-export server locks up, it is not possible to access the
> /var/cache/fscache directory (separate file system) on the server and
> all clients are hanging on their mounts from the re-export.

That does kind of point to a filesystem problem with /var/cache/fscache itself?

Can you stop the nfs server and is access to /var/cache/fscache still blocked?

> When the server is rebooted, most of the contents of the
> /var/cache/fscache directory is missing e.g. the file system contents
> before the lockup may have been a few TBs, but after a reboot only a
> few hundred GBs.

I can't say I've ever seen that before... we use ext4 for the fscache
filesystem mount on /var/cache/fscache.

And I presume there is definitely nothing else that might be
interacting with that /var/cache/fscache filesystem outside of fscache
or cachefilesd?

Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).

> The kern.log (below) from the re-export server reports the following
> when the lockup happens.
>
> We have tried using a more recent 6.17.11 kernel on the re-export
> server and changing the fscache file system from ext4 to xfs, but
> still have the same lockups.

We were running a heavily patched v6.4 kernel for almost 2 years and
have just updated to v6.18.1 with no patches - so far so good!

We are mostly re-exporting NFSv3 -> NFSv3 (Linux NFS storage servers)
with a small amount of NFSv3 -> NFSv4.2 (Netapps).

> Any ideas on what is happening here - and how it may be fixed?

Sorry I can't be more helpful.

Daire

