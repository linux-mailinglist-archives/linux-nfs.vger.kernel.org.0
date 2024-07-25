Return-Path: <linux-nfs+bounces-5051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F693C969
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 22:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2AEFB20F06
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 20:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB4B47A5C;
	Thu, 25 Jul 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iaa/Yiu/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFE4D8B9
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938655; cv=none; b=g6Da0bt8XM2+22MurrUzcyizLcgp9SJP9t8sKBp3PsSQesm2npytT64Cp3oZqM7mTTWOcq2q6TUaTOFSUgFHPpIXWA71fgBaRcyYKOSF/VSL5Vg8P2hdsXLcsWlgRnESYe//ohNPWO2s6ZUo2Up8MnlcNmgffSgBx539DfBZzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938655; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBVygCVkMr/Q19uBjjpPb2TF0B5cS9aj6l7hBMaqyrbVK2gvNuhPd/u2t9E/iGaf5czXIFP+i+7byUBLShGxq4l/gAaTtIHIvP9O7vaN9ary3JuVtoWiYgXJ8Y+UOLjP4BM6cSjsifmB3fYXfUKM3G04PYxn7hOq2GnhkW3mqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iaa/Yiu/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1726576a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938651; x=1722543451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=Iaa/Yiu/x2vapiBTIHcL6hpkJ2QMAF6vurRJ8uW5p5FWF296cC+BiltMJV6bOUwel9
         Uft0vbflsmiHZmPSQOt7rZIFsl4g6xvSAwS0b7TKXVA7CIjhI7lJKwD5IsW8ok2nzxd8
         Z+H28aaeIEvzkgBelx0gde4xBqjydDAFecsAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938651; x=1722543451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=UqQ+BrOaB/Bj4syvbNkTX4861bG64mGlZQF3rUEmjGkyw0MYd9I5SfGgaardtjl153
         OLNRSH8xJC2+tZ5GWB6zEhNTQjRiCjA6mmqVkAeqQkxKDdu/1YdNtl93pn+ujuWVlhns
         cAS7tua3YBzRQQHus8EACp8DixOw5juewA9KRiZDxpjB1NH/BlC+6nZtm87hwQeGJgz0
         3pVyWqQNBN4xJQiWjT6YLcvCroJKiimH9oxyYLwJYEeqant8hwEvKVR7mzOdphbe92+Q
         eihWPrKIqff1Mxqvn5Tq62vDSLBNkFt5bIoMV0eLDhHKyg8wrYgJalPQ0C25zFCquIrg
         gSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3kzSpWyKP7S4EDHqHWLQjyFzTaXLyoQg/fMQe+L+v6RO3MaBnH0mAwGFAp16dHvWLhDrXPAh60ePpYX872y2xFf89Zs0dQ3pL
X-Gm-Message-State: AOJu0YyjRjE1F5CFklT5IJcO36FEGI1D3SA4WURAYrgyMthtzF0quwSc
	uEGlFRW/mBq8563CavPgvmIjS7iTZYBz8FN917uJzeVOdJzujn+z2N1rkuKc40GKeNYHt5/EfzY
	AUAdimQ==
X-Google-Smtp-Source: AGHT+IEGnVK9hK6WuPo+9GHo6/m5L9il4Swsr52WBub0lGvAQPBjWEF1xy6f57ZApw6sajPB+c9qCg==
X-Received: by 2002:a50:d4c2:0:b0:57c:db99:a131 with SMTP id 4fb4d7f45d1cf-5ac64cc7b31mr2200667a12.29.1721938651661;
        Thu, 25 Jul 2024 13:17:31 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b0459sm1148124a12.7.2024.07.25.13.17.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:17:31 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso1631740a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 13:17:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqUrjYgm5ndjm48yqOqXe31hvJJ2TfQ5IV/wdGJe0ngcZeGnI7qXOAwoD6TjtF2yHJlb+eJR6nwloeZrwZc4ICvy95YUXHnhVP
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus

