Return-Path: <linux-nfs+bounces-19492-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EED8OhGNpWmoDgYAu9opvQ
	(envelope-from <linux-nfs+bounces-19492-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:13:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 910941D9930
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 14:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B9723016EEC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461C93E0C4F;
	Mon,  2 Mar 2026 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpD9VVJ/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAD3AE6E8
	for <linux-nfs@vger.kernel.org>; Mon,  2 Mar 2026 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457224; cv=pass; b=rF6ezSSgoXlR1rnN1TemBmBau84RbGxDL/PWgV47lqL+01Jb2NBMV6gGpQ9BbptqQfWdIxGG10EBbs3uQoerOCx/HYe+mAk2onqsKWeFlJJwczIEH94yJf5VyCJewo8MaggIGWDLF72LaIMUL6fUI/sTDXocrR2ngFCAOmBgYmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457224; c=relaxed/simple;
	bh=/xyQj50DpqxvizZBsCNSCIK6AmmQzK7MlnNIxtbk2I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlICWyREvG1PZMs2R26wBiyvQrNmZhkidFlJf0C3fKwM0gXpBSZ99nV6tn2ymhOjM34ayssOA7xBN6knEHkuUKLWCCp/Erfa7Bdp2+dwTYZjjkJYqpFfbPO3Y6h9ze0IS43Od3VJFXPBmEBna3qq8vQ3irRsTo8GGH93a8Jay4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpD9VVJ/; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94dddb3c3f0so1111679241.2
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2026 05:13:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772457222; cv=none;
        d=google.com; s=arc-20240605;
        b=dWUPXS5A2GktOG/nXTtO198nJK2pkHJj19QMC5YfzSifMLMy8x+FCnUssvYhY/RUZb
         WNIdhOQ9kBKT6A0NncfJhXXeZbZzsJLZdJ8MBhcsK9FjUoMVK6Vgzej8IwJzp1rJivF2
         A8hGydmI3KJHTzXWECPVdp7mb+zWUbDscfY+klHARRlHmdoP7msyLdgCew1hXDxsB835
         yKN2nqWRpLTxa7DVqNqKn/A25mVbB9xAcToeVY1ZtH4PmJSp6BnyVq0cqsCy8eJzEWxu
         1H8nxhwaydD5x/E6zufuHLEiteB4m/uAiuoix1LXLs7T8ruyCpS3q6Bxv8F0qKkS+/kL
         0KjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u5SW+u+DtecVJFoKUfzmKBIG1+8jq8Ae+IcGpfHwxLw=;
        fh=1YSdTPjE0tsQCyQEm2qJorDsFNKKqa16KZAKN2Tlgk8=;
        b=DUKDxTSRxfpEis0KW7HquzRSkMwI2w1N5s5xKrL+7CCS+teEjFhzP5ot3+IsqBu1AC
         A5TidUUioiERbzeMypO6uv1bU+3+iwI9UkNzver4BOS2TuvoUXdWQrXe6Ht9BNoYqzxI
         LU4r17e7BDDUe2Uaq+gG/VIJ7H7zijlbQ9Dwa5Lv46mUjR4MRoQ1BXkmFlFhMrxWSD8N
         ccoYiDr+Z+ocxf69mimEC6PN+BecgcCPC803dGrquQUcJvPzyAC+y6XAAB9wWMS5fn+/
         G/HC5xhxTLwEMqCBWdS27mUq772GauiGvcTg49GJPAyUsnwsHyTMvNC1MTYBCX6mOJMc
         o2uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772457222; x=1773062022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5SW+u+DtecVJFoKUfzmKBIG1+8jq8Ae+IcGpfHwxLw=;
        b=UpD9VVJ/t6QUSUbAIxlAqMGt3A3Qoj0V6hAFkKGn3Cs6IlCIVfST0Q2ByFWVKIfR6D
         3LyaTophT9pQiUtKVvjMAGLvJ1LJCfRZjRfEBRCrNJ79LH10GJb36EbTHhNaZFapRolq
         GulPdr/ORxIjrX9+m1RuHeRtDhaZPt/NgdzMFMY6lSQzFL+8SS1ffHK+RCBG0trvo++R
         ICJVHg4A1msFDVlDMYadaMBIJWc86V6l8NAWapQeq3fSQY4xDIYwovKgrVZnkvmRXjPZ
         ZTZ44ZK+ouLysp4sCq3N9DgWYZW/NkHcKA9VDheNM3WHFIM8tfxtvLDUUbGwxuq3k2QZ
         fbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457222; x=1773062022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5SW+u+DtecVJFoKUfzmKBIG1+8jq8Ae+IcGpfHwxLw=;
        b=ee1pqRESapHlujFOUhstsWM/SYdI5KRw4DLbXeSXb7Le5+SOOd1/k4hr8SGiEN9BUk
         BLVHd0TyesNr5FN4EKrM/y0wN6k+Q0YvZo5UUL0NJoEbz1gk9FSlXL8U+KrMOimMds5y
         CTlV72EbvMvoatWpjBpR8ulBL83omLUkTKvwoqFcChPL/N+AJQ80FK9Mvl6xShEIdRhk
         Rm/6ijpRwLhvCI2kyA+eELLWry8MfAYwQrYVmToCLOyn3iqkpgbpkvV0kWrQV8WrGLc3
         ukKxC5n3oxAdtikt1TipqLFvnuY09kOBfEmfEk9SX80jKfUv1lH4zgJtaEDnaTG4kvQ/
         PuCg==
X-Forwarded-Encrypted: i=1; AJvYcCXIl396w40wUHTfKyIcTpmzklGvHPA7+2wQQVU+zKPc6v+zBO94ZqTOAMCHmqsYI1yuDLXlPiwKz/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj79YwopyjK1EC79WJsDXIcJBsxlOf8jSmn4NjRlxutZU/cPeE
	ouw7JXxcFMff4TITeajTIVk88aAYmA4IXesuWtzQCDSDlcIf9SjNRbzE1RbfgfD1bnOb2IPXu3t
	TuxtS6NzKIF5OV52vqamvboW+z2EulBg=
X-Gm-Gg: ATEYQzxtnvqCV7uZhZWhRd/t8bCHVkpB9Y1hP5dcT4L5OFMcuS112RHdH/oSCwM4WJ4
	A6W2fWJ36wOyJvyXkopIGAiFqvCQ7H0xjlTmLVSJJ770Lgy9nPE4K+5vxqnIsR4E93RttCYGNO2
	K8DHyaZ0QbTd3r2EWDfRJQ1NBq+CeB3/Ru8wJ3a+1nMJrcw0/yHSKRI+2VDpnWfqOgnOkqeWrfq
	3cuQ6B+ffTE7g1DGwdQutfF1JWZCbSOYdrZMKiRraVXhb/wXHC01oWNGvDyPSqVhrmGhb1pEnSC
	ACGesw==
X-Received: by 2002:a05:6102:3ed1:b0:5f5:459f:9860 with SMTP id
 ada2fe7eead31-5ff325564cbmr5513365137.28.1772457221779; Mon, 02 Mar 2026
 05:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228180821.811683-1-seanwascoding@gmail.com>
 <20260228180821.811683-2-seanwascoding@gmail.com> <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
In-Reply-To: <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Mon, 2 Mar 2026 21:13:30 +0800
X-Gm-Features: AaiRm53B8vuxeY9WjpFdgtYM3uOj2HCAC2e6TQ_Q4wTQ-Ml1BLpjkVYWpye9UfE
Message-ID: <CAAb=EJVvkyGHE7RfPaQOLLYuFdXGJMUaAzyVrREcKYSBQ3iKMg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd
 build error
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19492-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 910941D9930
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 5:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> This should have been fixed alteady, cfr.
> "Re: [PATCH v3 0/3] sunrpc: Fix `make W=3D1` build issues"?
> https://lore.kernel.org/177024270291.126397.9981743455921781902.b4-ty@ora=
cle.com
>

Hi Geert,
Thanks for the feedback. Regarding the patch you mentioned, I've
actually addressed this in the v6 series sent yesterday [1].

My v6 approach is cleaner for a few reasons:
1. Compiler Optimization: In v6, we don't need explicit
IS_ENABLED(CONFIG_SUNRPC_DEBUG) checks in files like
fs/nfsd/nfsfh.c. With -O2, the compiler already proves these branches
are unreachable and optimizes them away automatically.

2. Eliminating Redundancy: In include/linux/sunrpc/debug.h, the patch
you cited adds no_printk inside an else branch of ifdebug, which is
redundant. Since no_printk already performs type checking via
##__VA_ARGS__, simply refactoring the macro is sufficient:
-# define dfprintk(fac, fmt, ...)  do {} while (0)
+# define dfprintk(fac, ...)       no_printk(__VA_ARGS__)

3. Reducing Stubs: This also avoids the need for extra stub functions
when CONFIG_SUNRPC_DEBUG is disabled, as seen in fs/lockd/svclock.c.

This v6 series has already been reviewed by Andrew Lunn. I would
appreciate it if you could take a look at the updated logic there.

[1] https://lore.kernel.org/all/20260301161709.1365975-1-seanwascoding@gmai=
l.com/T/#u

Best Regards,
Sean

