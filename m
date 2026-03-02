Return-Path: <linux-nfs+bounces-19493-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFv8GqOOpWmoDgYAu9opvQ
	(envelope-from <linux-nfs+bounces-19493-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:20:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD65E1D9A8D
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 508603047BFC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511C3E7148;
	Mon,  2 Mar 2026 13:15:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62B3E557F
	for <linux-nfs@vger.kernel.org>; Mon,  2 Mar 2026 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457334; cv=none; b=Tw6zUwXxHZz8/yDxzFoTr4GttT6T1lAQMw93bmrTfsXk5peypdJ8CoZuGgBbfvGoO2WrIn01Bh5rZW3lPyd3uimPi+JosWy2mNj/o5qtEXUePNZUKLPmaMgdDPQXyxK0nqUlF72Iij5PcWnY6kxW0IkajM84Urm0aMmxfiFnmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457334; c=relaxed/simple;
	bh=3/tNQBlxAxPEnfAoowoCr4sgDFqwDGoKIoGPrU3zXtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JN+1iiqOzcQFYnH5JSnSCyUyizgrgCrV8kTg0vSZvpyP/m4UDLeyirT6XrXGoQdxzO/BBfKvU64umlKbnzp//k4s6AWLY/Ox838HfMzWDkMjrmrosS6Hrxkw6oEiatrIWUI1OwNGyHqAm9gdk+d6CeAb4HRW7MBM1sJI4St1otk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ff10630b18so1209376137.3
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2026 05:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457328; x=1773062128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGMM6AwkrUzb9vYDMbSXuus6cNzIRf/v6/quBOI9l4g=;
        b=iwiq0Dai2ZNVD/6gZWg//KKo7cntMs2jElv5+vM2MsaGpc4mx+FkC2MmnZxx3Yjf/G
         gxnakiH7dM8lIGxKIGkIcusShAOEQhHGcOwq4Pcq0APOuv9Z8r6iVXqxWkr3wM0TjpKW
         K0uC3Uib6F/kURy10f2KRRedn2EDeAk1NuZFqRc8lfAC9479KXKYnvhNcGvn7HImFMGV
         vFydMwIajjWwx+4zfKeHh/iTtppUQv9P5u2XbuSDuiElGFCgmnlfEqfjFobkXsxAQb6m
         WS3MjLh4mR5ytZAqMw07eWKyh8jiyIJ+RYXX9jDHPD3T4qUKipada8LKuejAthiNqSYs
         Du9g==
X-Forwarded-Encrypted: i=1; AJvYcCXO4UjmpOnUyjf6asIZhjbrcNOZWRgt0cHVjas1jHo3HgRL1VimppZT5Xx5DEj6T0MdmswICixgkDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HSFTOd7V/gDWcF9Hk6Md6SOGsK27ShtyGgEVJD8vTlxbpw0q
	qkow5vmpg24h6t5j4s5gNLb9UMoMAzoWBkKqcgsPMWF2fzqmjXe5++6mgxMdoVOw
X-Gm-Gg: ATEYQzx1C602THtgbskobXJtbFOlI1iAyhbFXCFyZiRQTx8+pYpGyCnwwCq9sgHPpwH
	CXtYn4N1E1xKjZzgw1Ux2+tXTsWsJGfOZWtg8lOf9Qy44Utfi+i4ja6MgAjtHgsBvmRCb9mJ4XP
	NbCO5s3Yh7hP3a10GaylaGyACPCfsZekI9KHy90VJjmNRNX/1WJKWfY06C0EtY+48Fbp5QX6VQc
	YZKvTY4H0WC8k/m+bFs101ubczrvnQnraWLB3hdvTgaKZCREA7NBF0KsQ1fzt5aOkxkYMXPSYIZ
	TQc3yg5T9+xeZ0RJI3q/6GWKHljU8QSqVNoLStUav2xvJ4fGs+ww5xtNidIniYkcLnXavQjplNa
	OAXzctH6iQQcfTdykwWOoqCvFhhuQrl/vuXRlNnj+0kCPQOy3rVgSRZQrvpIfkS1VVpg9VXRrQ5
	lbZMacGZXvjmw9vFgRuWS1CMoN4Pebn0yXlderhPBMo3A8OX+VmJKqmOUDJk2l/7Dv
X-Received: by 2002:a05:6102:38c8:b0:5f5:5a45:ac5d with SMTP id ada2fe7eead31-5ff323bd8d0mr3868609137.17.1772457328370;
        Mon, 02 Mar 2026 05:15:28 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea6b5fcsm13147316137.11.2026.03.02.05.15.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 05:15:28 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso1488711e0c.0
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2026 05:15:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYAxiyJa0dxxXnQXobIGtEuSlSl5be2xvkabkkFFwEcgY7xha9wTrmU0LHdCskGrH2sM0Qn7lbomw=@vger.kernel.org
X-Received: by 2002:a05:6122:2a01:b0:559:67df:5889 with SMTP id
 71dfb90a1353d-56aa0a38ceemr5011229e0c.6.1772457327826; Mon, 02 Mar 2026
 05:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228180821.811683-1-seanwascoding@gmail.com>
 <20260228180821.811683-2-seanwascoding@gmail.com> <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
 <CAAb=EJVvkyGHE7RfPaQOLLYuFdXGJMUaAzyVrREcKYSBQ3iKMg@mail.gmail.com>
In-Reply-To: <CAAb=EJVvkyGHE7RfPaQOLLYuFdXGJMUaAzyVrREcKYSBQ3iKMg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Mar 2026 14:15:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVG=QR2iV=fUmdCvyguyYqQ98qXo3sKdL2gHzmLABMDA@mail.gmail.com>
X-Gm-Features: AaiRm50L9GoWm8b9Xv6BlZtnfCsVOO5Ue2-h72ixnE32z7WEMc_ot1ZvfsgtTwo
Message-ID: <CAMuHMdVVG=QR2iV=fUmdCvyguyYqQ98qXo3sKdL2gHzmLABMDA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd
 build error
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19493-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-nfs@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.121];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD65E1D9A8D
X-Rspamd-Action: no action

CC Andy

On Mon, 2 Mar 2026 at 14:13, Sean Chang <seanwascoding@gmail.com> wrote:
> On Mon, Mar 2, 2026 at 5:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > This should have been fixed alteady, cfr.
> > "Re: [PATCH v3 0/3] sunrpc: Fix `make W=3D1` build issues"?
> > https://lore.kernel.org/177024270291.126397.9981743455921781902.b4-ty@o=
racle.com
> >
>
> Hi Geert,
> Thanks for the feedback. Regarding the patch you mentioned, I've
> actually addressed this in the v6 series sent yesterday [1].
>
> My v6 approach is cleaner for a few reasons:
> 1. Compiler Optimization: In v6, we don't need explicit
> IS_ENABLED(CONFIG_SUNRPC_DEBUG) checks in files like
> fs/nfsd/nfsfh.c. With -O2, the compiler already proves these branches
> are unreachable and optimizes them away automatically.
>
> 2. Eliminating Redundancy: In include/linux/sunrpc/debug.h, the patch
> you cited adds no_printk inside an else branch of ifdebug, which is
> redundant. Since no_printk already performs type checking via
> ##__VA_ARGS__, simply refactoring the macro is sufficient:
> -# define dfprintk(fac, fmt, ...)  do {} while (0)
> +# define dfprintk(fac, ...)       no_printk(__VA_ARGS__)
>
> 3. Reducing Stubs: This also avoids the need for extra stub functions
> when CONFIG_SUNRPC_DEBUG is disabled, as seen in fs/lockd/svclock.c.
>
> This v6 series has already been reviewed by Andrew Lunn. I would
> appreciate it if you could take a look at the updated logic there.
>
> [1] https://lore.kernel.org/all/20260301161709.1365975-1-seanwascoding@gm=
ail.com/T/#u
>
> Best Regards,
> Sean

