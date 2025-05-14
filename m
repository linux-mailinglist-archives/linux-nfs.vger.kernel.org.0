Return-Path: <linux-nfs+bounces-11728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099CEAB7831
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 23:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9351BA46D2
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 21:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4C221F2F;
	Wed, 14 May 2025 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWyjzxHY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9D213E71
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747259499; cv=none; b=oXOHywIcq2xl0cLfm7lPiAGO/eAWkrF6wN58hmKZTDQiwKeZtgOgFyNxec+RHI7UdwyTMQpZIiFeB7+SIXRf2IShMJRhZT2mgRBItLNhTujFGIRfKCSlVdIKoDdsAxeoFKAJC0+f4K4iqmf0SnKkGfUMEawKoLCGF0NuYqrnf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747259499; c=relaxed/simple;
	bh=HNU8O8Ud5MPcRK3hgrJXsqtvVRiLaCMw5kegXI4M0Ig=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i9A/F5QGYlo69cy3OhYvAuTqCl8TuJ/lsg6cPwsLmn1qHaGXkMyg8nNTGuoP6fy4R7iNrwiwv/geSBUBkFtpWYWX5RaJUQ2wANCwmK4QTCjTlib9shRB6AoQsSKhxhEgJ7ek15uvuQ2blrjPnZa3K4OnPzQtugJr5KGTslSUZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWyjzxHY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso523601a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747259495; x=1747864295; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNU8O8Ud5MPcRK3hgrJXsqtvVRiLaCMw5kegXI4M0Ig=;
        b=QWyjzxHY4VoVznhkGnLNIfKpnS1a58Tqogl+aXGOY2vRLbrms3mDKxLxbN+3VsONNN
         Q3U4+c3aSN6PlEhFmJzPkwNcjv6TITrKwjwBU84P9An31fjSNnkJ8kmGKiovkzSr952h
         u1Ha0+PL5cjmrsb8L6Y7aR35V/1H1Wb5SouAOwmHakz9pBVnNVaRw+06yV+1WePp0kk/
         1a7dRCO07obbn0LwWcl7TJdHPhD1r7bFS0sSSqn5I1ylS+xDCZzYmFtk66QbiFfCuUW0
         rHegV+AZsf2J8ie/1Ll+WIwQ4n6uz93KbkgzANSsYx3IUJcoz7+PngAAWqbl/9o1fPF1
         7iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747259495; x=1747864295;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNU8O8Ud5MPcRK3hgrJXsqtvVRiLaCMw5kegXI4M0Ig=;
        b=c339RsvOlAOQMD3sdF+/XJa6XBTqRcZlpN5GhGmDXQ7zEOzwhnFi+rUNp+t7gS5QOU
         rLaEL2ODDrFzUDHk6Q1gLg91D90G5NLDinnn2AXIuDWXVGtTqa4RCeESRtHd0VgmAkJn
         UHToi8YaJ9JK3E8ZchdTmMaLf+aGaSaIRoNz++88v4UnhUQXOsbEiWXmzAYazHiUvXgh
         0TJG8ZZ2A09crTVwlUJd/R+PKjUAomqlzyAFYycxTexh0Fqz24J/FUYlqVEt6H8C89Mv
         Q6qNMCwyqyLe0oSJdnWymasKZ1rpGWQQq+xdaEZ2kNCkckgTDQWk3A7yJ7eGu6dAqGTO
         1QYQ==
X-Gm-Message-State: AOJu0YwMYFgRxajkqWd5LiRnLO1/qhybGMArkJ1DpRb5wah13JTNeoWD
	8o/+3uzVPt3zxafZkIwvUaUcmgJV14WUjtimCIgbyfJd/SbVMyL26ykyJMFLzIWbY7YYnO7ncPa
	gyvmhW/EH0RINGpAw0kSk46WDDjIAfk/y
X-Gm-Gg: ASbGncs8PHR51XAM/tQWpjaAsDFt9zthU3yuBSAzZrCoV2BAqmPNMLn8Z2/zzrwCM0O
	tRhalMq4GZOC6OrYXmasHMJB56KWAJ5r0C3zRjC5nJnMGgpRQRUhJF9Esek0eIDE6TkjNl5RKvo
	uBuRLxzGPO09YW7uER2O3Pe/csq+9erGQA
X-Google-Smtp-Source: AGHT+IGt0ytEgoqdCZQYUGexSCsfE0fdvYwZhdKIy9chVujluYk5vYGqkkEbavG1zW5MlQDEbUgP/gd2XypYgBIceFY=
X-Received: by 2002:a05:6402:13c7:b0:5f6:25d6:71e1 with SMTP id
 4fb4d7f45d1cf-5ffcf7a8ec9mr55502a12.0.1747259495149; Wed, 14 May 2025
 14:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Wed, 14 May 2025 23:50:00 +0200
X-Gm-Features: AX0GCFvxvvBjkLQesyHsT5Z-x97HTg4MLLpm25rDPRQN-n1Sf-YuBWTnJP1nsUk
Message-ID: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
Subject: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 1:55=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 14 May 2025, Jeff Layton wrote:
> Ignoring source ports makes no sense at all unless you enforce some other
> authentication, like krb5 or TLS, or unless you *know* that there are no
> unprivileged processes running on any client machines.

I don't like to ruin that party, but this is NOT realistic.

1. Kerberos5 support is HARD to set up, and fragile because not all
distributions test it on a regular basis. Config is hard, not all
distributions support all kinds of encryption methods, and Redhat's
crusade&maintainer mobbing to promote sssd at the expense of other
solutions left users with a half broken, overcomplicated Windows
Active Directory clone called sssd, which is an insane overkill for
most scenarios.
gssproxy is also a constant source of pain - just Google for the
Debian bug reports.

Short: Lack of test coverage in distros, not working from time to
time, sssd and gssproxy are more of a problem than a solution.

It really only makes sense for very big sites and a support contract
which covers support and bug fixes for Kerberos5 in NFS+gssproxy.


2. TLS: Wanna make NFS even slower? Then use NFS with TLS.

NFS filesystem over TLS support then feels like working with molasses.

Exacerbated by Linux's crazy desire to only support hyper-secure
post-quantum encryption method (so no fast arcfour, because that is
"insecure", and everyone is expected to only work with AMD
Threadripper 3995WX), lack of good threading through the TLS eye of
the needle, and LACK of support in NFS clients.

Interoperability is also a big problem (nay, it's ZERO
interoperability), as this is basically a Linux kernel client/kernel server=
 only
solution.
libtirpc doesn't support TLS, Ganesha doesn't support TLS, so yeah,
this is an issue, and not a solution.

Fazit: Supporting your argumentation with Kerberos5 or TLS is not gonna fly=
.

Thanks,
Martin

