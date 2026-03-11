Return-Path: <linux-nfs+bounces-20039-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME/5HQZusWlVvAIAu9opvQ
	(envelope-from <linux-nfs+bounces-20039-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 14:28:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4543264860
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 14:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D72EF30659C0
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470E1AC44D;
	Wed, 11 Mar 2026 13:22:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40861EEA3C
	for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235350; cv=none; b=BT5GYLtRtbWqZoklfx7UYddt1Hup8TGbV3/VgQ0RhDfy2/4aLF96j3SJSgb9w0AD6j3mqZzjhfWLxOHLYuBCimD3UA1pbBruEIaDKTBJIZ/vlL4jy27g/lAQjPiRPkO6j9JHa4Y4R1bGEERe9Q9G8XRkfhP3lyU2wA5xO3PNBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235350; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkvIBG2QFx0xb7TpNmqPnS91W0NqyA7/GAjHWzNO42L2R/mbqRA7Gof99+ow6tmzOL+em7WghlXXykwnHdhmwQu9rkIregHfWTfBsBH6BIwiTgxRAlKLh518TkB7/VzNVmqzkU73O5EyVx/ByVk9H1oKkz6AA8dnNy3FyY4PGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5675d609621so11791478e0c.2
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 06:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235349; x=1773840149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=rHDosC4FshS/6VmX3hVpse8734havBYnM71GCv5P1nTcsEpXjRKjH/Yi2bIarg0X8v
         mT9sAnAb0RTv6NwbZam82tgkO+PjcZdlQr7eaVDWT2feCL7VbRCIF84cx1qJoLJbnl38
         kUCOdA+K6UEJQR3t6EaofC+LWqe/VWaVcmkHpViGbQyakxYdrh+RdbTRYIs86mSi1jEg
         bxOb2LZWyYm+gvgOImRUplbJ95G4JXpAmyQxKSyAcAk76MHh1XMPh4GaWZfZrqUna0Zr
         a9XQwabfPqAO1zeSmDij0G08FCcdYSA3kq/nO9yO6GMMq+pjGVNUZAoPbKVDMdyTYaEp
         D6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqUNpFBNfBZRw/UfarAYvvjvveJ4yw07RVax/Q1Tc7k4xMDhYmXKf9XQuavqYKgqPW4wWdByiCAac=@vger.kernel.org
X-Gm-Message-State: AOJu0YztB5WdbP2haQBOLguhA3/Bo+3Yf0/CZUyZL1XJm4Yrac0G/VxE
	iU/hNPyhcFO+d76GrWhHot1a5AE+zuZD3sntOcN1DBiejFL67PddTAeXZJutqqLZpnw=
X-Gm-Gg: ATEYQzw20b9Cc9f5YU0gXnuuRplTZJv8mI0uWLfOJUJphxCfoIe8WQjVweUmLx83q2O
	ZHiy55ReFtl4SQhzTsdfnzYI/jsM68sSdh84EA7RmTn5IjHfl/QOkXtyby8JUGsDAck3LehJs/L
	Bb1DozAzQhdpZMqXtylPL4YkpPPwFucpR/wa+pjgWKbbM/iSOCm9lC82a7LVckFOyBVvv7RXxfC
	HY9xp7bh1lwrNa+iEXOombIz2OgkSlDe9/j1EWJqQUKmBzYT7m5JSchvFbX+AgSI0/UN0EsA3P3
	d2YBbjVyZ0hLr9bx1xp10P6DxihLbrmScwXtzuqB5Rz6OmIAWiAv9AVcdH/tBdv8aTBws0tOLvl
	5bT+b8GIjYZ/BMv3BAl4oogq2+Kwgrhzvqhcfm1PS/+heoyz7h2sPqtEkO1BKZ9rt7QAO50m9R5
	ZievW+dFlSQu3Mh/nsulTJ6a37mxg6i3bbBxB5/leNRFKV7uccN3TsaSvIhlyO
X-Received: by 2002:a05:6122:1820:b0:56b:1f83:bc60 with SMTP id 71dfb90a1353d-56b47685394mr819851e0c.18.1773235348761;
        Wed, 11 Mar 2026 06:22:28 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b46311c18sm940445e0c.1.2026.03.11.06.22.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:22:28 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fff774800cso3499967137.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 06:22:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFHm41V9ozVp6dEYa+uR3pnfblGP0KjmQ2//sJlfptLqsM4HOLquI1JBGqJmGFiWkzNhIFleZ0vgs=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D4543264860
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20039-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourceforge.jp:email,linux-m68k.org:email,avm.de:email,glider.be:email,mail.gmail.com:mid,libc.org:email,fu-berlin.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

