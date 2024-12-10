Return-Path: <linux-nfs+bounces-8500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD0F9EB091
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 13:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5461603C5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F31A0BFA;
	Tue, 10 Dec 2024 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS1K5JGo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E319F13B
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832880; cv=none; b=MXyF2869Fm1UKq8TvwRMUSNTWEA9qdnJXQqL4j11s0zsIueAcGmB7V+SFr1SplczRsz/po/fihfKrPzNZphl9k5vEykBgrLHmwsH7VyUDXxdI/NFqdfovlQznLSioSttyfkRXaC8/WBXX4pdcvcfvWygUfkjUiph/DVox2HVQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832880; c=relaxed/simple;
	bh=XfQPQbim+gJ4rhRyJvAgY5UM6MQMUkmHyMXTCzT2ieI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lZhzzzCtnoZdkb+yhcfnWqbi2QU5LxzN2fK1Clnb9FoMKDD2XzBj3dgPyzaFV2pR4D9hQ3XNQakcRo+vhAT0F6mwDJ3VBdorG852fRAEVn7T6YFykTtczhcxe77hUgVISNvLQXaScUc1GVXdfI9Orc9TUswqCnnuuCIoXPBti5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS1K5JGo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso5475543a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 04:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733832876; x=1734437676; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biE+rQCuVuu19OMMx2Kmovi1769nBgzMErnugtFJXvk=;
        b=IS1K5JGom4/cblKUG7AouXWWmPRegx/R9Bu5WYbu9A6/MOx4frSRz1p84xJlvi/JZG
         XYe1XfiylkIXGQJccBOs3zA63orH5GTVQlyrrH/Iz37zinCkucIJYR+ZSIa+JsLboi7p
         MZYPamjXIUAoqlGyP5OJEA8hFNSwEMyG12Ls1ZmdYHWeTPPwm9QB4mp0INJq/ZOOJDPN
         l00m60VTfoJli8Kbtdr/HIRQ4a/bX7z34Fm+d0QRGRBe/Djn9HI6kn6Inu5gueAxNcNp
         SFDHt4sZYQJ7+iVu/ekjZvJmHXjs/SLpn4/3k7LJWNkxJ2hRQ1RoqhjB3XQxDED28w9m
         5giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832876; x=1734437676;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biE+rQCuVuu19OMMx2Kmovi1769nBgzMErnugtFJXvk=;
        b=mqyzLLfiroVffQBTBKGdd9rd/6EkSJz6R3Xddv5JVrTArwmDfVU3rrRJvxxJbH3nQx
         ONV0SqYHjWZhqWM9QTuagWNA6rVhZ244+CEkQGX9cRCyco0iM91c2PspGph74aUNTa6B
         x33DBsxwoQ/KGgA2ZYVTAv9u/GIjeDiiM/Hg3ZfWYyPbVcQXhmNC8EUUr4tCFrJxQKNo
         4OnZIKK68Ozt3dH5HDRPcwb2i6J+KwZAkXlFIXurqJpnkUStLGdyBfU3JBATCvNTWP0z
         MDlim3Yv6IHBhR/J3xbiu5cpQNbfgffbU90z0/m26ZxweG2n6TpBflBuHYPgGXCKpMbt
         oHZw==
X-Gm-Message-State: AOJu0YyOqsbIsTi0fty6tOud0hrMWxJHsYyRl5kOSL+f/+Y0zhFeCI6S
	/1Fj32WKn/6LtW1yU7+BEg/hQ/Uk/0/ibic+cxyWZ8fLN4R07Bdkj58kt8LH6WsjiWxRt19jXkW
	Otz15yvgT00xsIlHnBD/UsyBQRLF9CBHFi34=
X-Gm-Gg: ASbGncvAzZ8DZ/f6opSi3W+gvD5SmD9ADjN/ektu0+XBceCYN/7kKyN16++NE4wZH5z
	cmhc4pBEL7UOvTgBkfAFg9N75VSG/US9buSs=
X-Google-Smtp-Source: AGHT+IGUDE2SIV/zTQMpIAZ7Xk4+thKig7dQUlPYFLzb/OAERBQ7H/eL0XNNpgKU9LNY/4lGRDQSYch2QTuigoojQdk=
X-Received: by 2002:a05:6402:2744:b0:5d0:d0c5:f259 with SMTP id
 4fb4d7f45d1cf-5d41e1639bbmr3141689a12.3.1733832876135; Tue, 10 Dec 2024
 04:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <173369594365.1734440.14357278787243353853@noble.neil.brown.name>
In-Reply-To: <173369594365.1734440.14357278787243353853@noble.neil.brown.name>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 10 Dec 2024 13:13:59 +0100
Message-ID: <CALXu0Udmn=AqRBAcBPf8=VAP3KN4f-vnEJFLg3OnkyRdT3b9rw@mail.gmail.com>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Dec 2024 at 23:12, NeilBrown <neilb@suse.de> wrote:
> > +
> > + /*
> > + * |pnu.uctx->path| is in UTF-8, but we need the data
> > + * in the current local locale's encoding, as mount(2)
> > + * does not have something like a |MS_UTF8_SPEC| flag
> > + * to indicate that the input path is in UTF-8,
> > + * independently of the current locale
> > + */
>
> I don't understand this comment at all.
> mount(2) doesn't care about locale (as far as I know).  The "source" is
> simply a string of bytes that it is up to the filesystem to interpret.
> NFS will always interpret it as utf8.  So no conversion is needed.

Not all versions of NFS use UTF-8. For example if you have NFSv3 and
the server runs ISO8859-16 (French), then the filenames are encoded
using ISO8859-16, and the NFS client is assumed to use ISO8859-16 too.
mount(2) has options to do filename encoding conversion
NFSv4 is an improvement compared to NFSv3 because it uses UTF-8 on the
wire, but if you use the (ANSSI/Clip-OS) nls=/iocharset= mount option
you can enable filename encoding conversion there.

Traditionally it is assumed that the admin runs its shell in the
locale (implies filesystem encoding) used to do the mount(2), hence
the iconv() to make sure there is no encoding mismatch.

Finally: Not everyone and everything will use English (we frog eaters
are proud of our language!) or UTF8, and it will remain that way for
the foreseeable future.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

