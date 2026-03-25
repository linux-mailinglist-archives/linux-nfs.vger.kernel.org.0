Return-Path: <linux-nfs+bounces-20389-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMrVFzMLxGk+vgQAu9opvQ
	(envelope-from <linux-nfs+bounces-20389-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 17:20:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F6328D99
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 17:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF5B32331F3
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B63E4C7F;
	Wed, 25 Mar 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE8Cqive"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FB3537DE
	for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453802; cv=pass; b=inJBK6jN7KEhTWink0q/0bWzYGAEI//37aWzN88cqQmsp8LrgEq96jNO9VrP6qYOP9hlXPDuJpsVECMbtVq0+iE/cRPEPqBa4qQVfAxVdWEMbAfYCgzbIAL3Iw5jBTqFBTNloi5KZKne7qgReBi2Ac9DV321iLbf3mMl2AHjZCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453802; c=relaxed/simple;
	bh=1Fp+vu62d7+GgDhpjAEu59FtZICCeLh/0ubMdeGXaXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s98gPPFj7hS29wCoEcX1Z7OFhLjjNe2qTxd5IwWUMeTJMxUTPTLSC/XVTSOsSpuHxULZzUdsN7UTR59uvwzhjVWxOUIqAUSSNB+HfbcFaKxSxlluMHxesdIcbNY5o7AN03ilC3n5qIw/ttPGrcweM4fDTBDGAwGWVQI1PI3GDdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE8Cqive; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56ce54c8c82so24133e0c.2
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 08:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774453800; cv=none;
        d=google.com; s=arc-20240605;
        b=ODsbISXIk+gpYFfhjCmKwFAlWNz3tCPruXVzvwmYiUitzYXHJTtTp8iq9k6yKwJRnq
         DpPes0LlIwjE33wgNXaTAHA2xb+yjiOdmQcnFX3lf7QMLUBn2lUSaPgU8+cwYao1IM5R
         pGppx0NNECNnwpDZY6xQXcMcKipVeaNM4J6P8U2O/cGlr+sqIM64BNE1APta/n8Q458u
         Tn2RCa4KIMlynpq5BTaqBXylhOz630ZeNoISxmoE2UPey6SRJrujKWKa2SSKIqr+8tXJ
         cm6zE9Qre94bWHfZdvppRNt930q37YUvS4zck121jzBsjEOeZTlGKvJFkulT9eZY2cVR
         mnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4YyME46GpG0Gw1RKEMDOpkpe2Kju1Ab9MRx6y7uJH+s=;
        fh=RMSsVRcOmnedGfQrkl9l/JR8l03Ml3cbP9J8nRVWtIA=;
        b=Yk8g6B458snfsetMMFzbKlqok2At8fgNLSyqH0cBIaXswjSBWbyzGbqpq7vSezuEXp
         gYN3ZdteodJz/pxH9ArVNwQAyukzCzrsMwsc/qWwooXbYw7IbA2SXSnONX2RorQ/PHe8
         wcFEq7YaTOEuk80pDaD8xWAWznyZhBBqNxqMKUjErroPU3zRLjBLpr+nExt3aWRTPSvD
         Bz7qAImln+9dZzuiXHTUSJUApBWNHiT5GZVUGNap+c5oQvBtLrZv8lHxHwEyKjeM+kH+
         erfogsebmu75z/rpV6+Z3EpiisKl5ufndch3/44VtJfloE1+m2zVPqanUXfr8Ga8IZ34
         g18A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453800; x=1775058600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YyME46GpG0Gw1RKEMDOpkpe2Kju1Ab9MRx6y7uJH+s=;
        b=WE8CqiveS2f9yxvxek8zFPMlu1+i6ro0LInBOuhLyzu76QvTxri3ZqSaQ9Y2Xe5Jsa
         kvShTOJqz0cgXnMfHa8VMIePVTI5G4+9gN8o+fba6wFEjbi1nkQ4ZZ5aKZS3cxNMKkPv
         wjeLJchu5xt0w2HnGe+Np39Leu2byrEURgllqLmJ/JS8DOSPLEue6AzyB2WjoBzF7zNJ
         Ix1w0bNMnVtj4PbLg+gOQ43Gx0E6r4mBkUi9A4ULNDbicb/HUaEzRRikNrSWhkZVRpQ4
         Yyh61cF0/oQ2zXU6Rrg/4BYdkCf77/V+o6OcEoLG5hKdsnRrBydiaId2qvB0Zf77s4AH
         LU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453800; x=1775058600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4YyME46GpG0Gw1RKEMDOpkpe2Kju1Ab9MRx6y7uJH+s=;
        b=ZbPO6r4roI5wKNgFO2zJ+rZAkMiy74NYqu6u8w3qvkas10d4BN6ZleuJPuxGD8OAev
         Pj9zr3z9MN1Hfokj9UxeWvTBm6KCXmeTMLeIu6Zgzrff48zUkeGSOZIOz5bIJmcgFtP0
         Z7dDLuHg0KPfy3DFXWWTu4XHaOOY9qFaSvdNVifNwzkQeO8qOjz5ZQmtyjvzlailXHM8
         sKDpIwlVEEM8xvVZSkp7KsK7+xSdXLvc71OeiaraeJ7qjJbZ/79a824bk8zy3EFzcU/v
         unjyqJTjSg0aaFpQXJy8ctFnJ8mQ+rHfg173qGZiqApkL06TCv6qim4mNK0EUrndsUG/
         ZG1g==
X-Forwarded-Encrypted: i=1; AJvYcCWxyjJ+n+24efrBQSGuxRuvrmURibJ4o9nXi6VUaxw2+tY0OI6Mm/dlxHYdVizfgyrxfFDqaUXpR74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGh8u51qCrGj4tFum+yQwkIjqIdwWh0PGra689Bsz8GWQ7uJyQ
	PWUrUqgTUJRblOEU1hoAUAFX79PUXWkDn3t1/mWgc734ef0x1FQEjGY4pokHmYWBDmW1NLIW+tb
	MGOVirgceggySoy0+cj/25xU9hAk72mEfRyAf
X-Gm-Gg: ATEYQzw7qVPGqeCPhd6wtgbXikNyUpXxQBGMD5V6+B3/L8kKyChuHuiks6IXdXHD1I/
	0r0JAi3jAeNTYvf+LE8781FPOQ0my5aQMooY33ItKRd7F+Mg9FxU0FkaiDRtuoMpy0lNN5kLsXL
	O7jfWu5leN1pmwBon8q0cuFkIzCgoi2cIBAMuisO8VdC5DlVD1dB80z4Sh9IaJcoV0J+/KnWmyr
	HLkkVL93SKbR63lrbixKRu4TwGhy7jbhBSmrXipxv8HJ+9BVnw6gJvA21jEewRlmhj2UDAM5FTS
	EpPontk=
X-Received: by 2002:a05:6102:6cc:b0:5ff:bd9d:b1f8 with SMTP id
 ada2fe7eead31-6037904bf43mr1717003137.9.1774453799647; Wed, 25 Mar 2026
 08:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-2-seanwascoding@gmail.com> <e3702d11-2157-46bb-b6aa-0ab60b51eecf@oracle.com>
In-Reply-To: <e3702d11-2157-46bb-b6aa-0ab60b51eecf@oracle.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 25 Mar 2026 23:49:47 +0800
X-Gm-Features: AQROBzCswDx5a73paus1YHqMqijxhn4uV_LUOu8mN6APcMZNUZeywNxTGqTTlLU
Message-ID: <CAAb=EJV9-v4OsYeaQQH2ycDUCSx3VP2M2ji16xAzO3gT9OuzpA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] sunrpc: Fix dprintk type mismatch using do-while(0)
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Andrew Lunn <andrew@lunn.ch>, David Laight <david.laight.linux@gmail.com>, 
	Anna Schumaker <anna@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20389-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,intel.com,vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 579F6328D99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:38=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 3/21/26 10:15 AM, Sean Chang wrote:
> > Following David Laight's suggestion, simplify the macro definitions by =
removing
> > the unnecessary 'fmt' argument and using no_printk(VA_ARGS) directly.
>
> Generally we prefer a commit message to open with an explanation of why
> the change is needed. Your first paragraph instead opens with what was
> done ("Following David Laight's suggestion, simplify ...") rather than
> why the change is necessary. The Sparse warning motivation is buried in
> the second paragraph. Consider leading with a problem statement in this
> and subsequent patches in this series.
>
>
> > To resolve a Sparse warning (void vs int mismatch) when dfprintk is use=
d in
> > conditional statements, wrap the non-debug definition in a do-while(0) =
block.
> > This ensures the macro always evaluates to a void expression.
>
> The non-debug definitions in the diff below are:
>
> > -# define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
> > -# define dfprintk_rcu(fac, fmt, ...)    no_printk(fmt, ##__VA_ARGS__)
> > +# define dfprintk(fac, ...)             no_printk(__VA_ARGS__)
> > +# define dfprintk_rcu(fac, ...) no_printk(__VA_ARGS__)
>
> These are not wrapped in do { ... } while (0), and no_printk()
> evaluates to int (0), not void. The do-while(0) wrapping that
> was discussed on the list and fixes the Sparse warning appears
> to be in a later patch in this series (the nfs_errorf
> refactoring), not in this one.
>
> Should the commit message second paragraph be removed or revised
> to reflect what this patch actually does?
>

Hi Chuck,
I notice that the commit messages are wrong because the current situation
is not the same as when I first sent it, so I will fix this message to the
correct one.

It may be like:
When RPC debugging is enabled, the dfprintk macros include redundant
else-branches that call no_printk(). Since no_printk() is a no-op
designed specifically for compile-time type checking, it is unnecessary
to invoke it explicitly when the ifdebug(fac) condition is not met
within a debug-enabled build.

Drop the explicit 'fmt' argument to allow the compiler to handle all
arguments directly through __VA_ARGS__. Since no_printk()
internally performs the same format string validation, passing the
entire argument list is more efficient and reduces macro complexity.

Best Regards,
Sean

