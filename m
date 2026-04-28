Return-Path: <linux-nfs+bounces-21247-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGhpCdl58GnMTwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21247-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:11:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B747481022
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9ED33CF785
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4E313E07;
	Tue, 28 Apr 2026 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuTJgjhR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B4284B4F
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366772; cv=pass; b=QYCcFalIpR77HDa7SfvF5kIjsdwfCG1ONgIOUtmwNpQbaAOQlqjFqO2pywIfPdJP8bAXXnjdQYJgnNNVTLqfbzh0GaVTh0lS/bsdhBPUH+z7tumPiDb5MwWEOJeDVpW6QDr87cLyNqb7IXVjng38zVs9en3s1nE02vtMnPnbkik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366772; c=relaxed/simple;
	bh=Lsz9lkdgEikB1s28a2OLn+2gXOkJ31XbBe/r6JJlDNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kvUJv3iDxJEOI8GlNOTJUbwBEoIbxAqHqzznkmVthoeSr7icx4Ygb84ueYM2dCcqCRJQ44uVYwNRAgFK51W5mUEpS6Y6uwpgbad0c+SHb89FUdBW1kauMHNOVLHR+v4mg2BH48EMRCuZ+z6F8yw6U6kgLi1Ib7lLkEQU+WR2M9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuTJgjhR; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so19461431a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 01:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777366769; cv=none;
        d=google.com; s=arc-20240605;
        b=lc/DzZRy4iwObEDR9fbALXhYulsTNT4YCJ5r1X/qaJWJHRRJJ6JY1sKfp4Ogz1J8e3
         Ctwz9ibp9iMPs0P0Ndu2QLfRFqQsGivt9O+o7w8byjIip6vR2zf3RAb4Pk2ucuQYegkz
         E8ImpJMe+XokLXlB1gzWvC/Ax9HIjzsneFWbsb6zLIKPJfV0BdmK/iLfDZXHAppnxOqF
         /vvF2h0j2NTzUOtxM5kTfQUavQ/djpsVUJKcQZYLeByibiNwFn8wPIcQZIC8j1ATJpRF
         7JKPzdlIEcqYMlNTNEtz9IrELuvL96EAGYbmPfHDktAe+ofM0HOQEzjx84Hq+jvXEDHe
         KOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lsz9lkdgEikB1s28a2OLn+2gXOkJ31XbBe/r6JJlDNE=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=Jpa/A9hMROeK5vDjRPY+0yuAxA5Pxlq5knR7e5dMJgvFqI0a4IOkqwlMIHG896qAAa
         PG4zXch/HL2dpSiz61F7dBXis1SpQJJQq55Wc/2ko0ACw6XGKJuvzdpKO8cGkYS6l6Py
         Yf384IhlUEMTO/e9Z4pJpES1ILoabS4QpwCtnCKUSr2WAjMVt5b3S9knTiBqpqA6YHFw
         WrxnGXmPvShTtJgm5lUdmqImyqD0Q2p6MMViZ8raWUd0CLrruFZwPQXpnzrrqQjMVPXK
         T6aF/RS1+32NiLCLtnCNvzr4jpKKMoCF8hYtxpWLPePNu+yOa3nuhBCAiXGcY5a6oOfF
         3LgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777366769; x=1777971569; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lsz9lkdgEikB1s28a2OLn+2gXOkJ31XbBe/r6JJlDNE=;
        b=LuTJgjhR8qQ69AkjfY7yyD9gLRYsJ25YdUoYBPxgiLKMh/kjMbWB9V7X1u3lzREh0h
         k3i4XLxRVQeEYakSd8DGaK25kBfJva/HxJqfamEOYPu5Fd7A3Y5/r1uGmZImshTQ4NkR
         jJBbxwlKQSijRl5GDZ90zaJfASRY9rRabTrs34j/htZdhjQ1E1bYVdl46fiDgY6c3U5o
         2dI44uJkNL+T6uWxYyp+2cDm8K4DvCmPPbvCLM5BLHnej4tnCpt+wdsV15D+XjjF67ev
         8hIIK9c2vZnyPmag5h5nUwfZDTwPutrEObPJ9gDeZS2sk/SBnDwQh5Pe2lnFo8O4dVFG
         UTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366769; x=1777971569;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lsz9lkdgEikB1s28a2OLn+2gXOkJ31XbBe/r6JJlDNE=;
        b=RGmQKIDB9lU8v0rMyzsuLgItaZLuMWdJFvW1ml2f8gn1KWUs8P3ROoYij6BdPDfz4s
         9rWRcIO2ZFvh9uc1HT8JLCJvtLB1s/5J5h1163H9qYSd2RCWW5JsOIWRcOI9h69nnJe3
         2iBoj/dTJszCGLBUtxqjUh7wTXJqcGX3q4sHizbVvF3HpPw1cGFKiLnZEFRFJcw3phdk
         QjPXl4PIAK2qDRJiZ2w7ScD468cb6yiqzRMfmEb8yQb2n0hgNOXZSKgLGoQ02P7BtWhq
         xz5qKKPpuFmbmxdPPPquZEHXzQ5h7iJoe5ka0O+uEzvApPBHRyHo7SH6U0+RAMCk7M3U
         wCjw==
X-Gm-Message-State: AOJu0YzIzt639ZoUOAOEibpqMokZZGSdpkjfhxfOXx2MkIXG98bIUNHz
	oFRj2DE2OUW7Uv+x29QNr49E3dSpeautN4raGAUSeBUJ6cE3x9vOA/crgFbQ54H6Q1OF9hiwllj
	i7i1BWWM3mml5G0W8Mm0R3KbNhavSE3Flrw==
X-Gm-Gg: AeBDievadqfHPw0tRVKPcffSE2ok//9cURC6VHw6GQbTHgBNeO0k5ZKOmhqieMlkNZe
	98OPQ41aNkDwNH0C6RnWjk63xaFNdUjVyGUjjgfcJdTh8FEaoeplEHp3C56BX7h9QXBvwXBZWR+
	z8/rYwpp7dOBqgtEpjAMI1ka7XUB/gJiT5hKLYy3GKBtM+3Mg23JBOl2fl5Qhe/ybkBHqeHbtZA
	aY5X+RJ7NhrVLJYo03r5bJuawOA9VpzcKfB4pdtvTwwsRDeaAsZB2Xzv6cZGXP/HpR6w9kI5HZ9
	/vWwH46PG43JAK9sco1i3ehH52sYWI2zBy4qBC7Ct0ltoWLH/w==
X-Received: by 2002:a17:907:3e9c:b0:bae:642a:8712 with SMTP id
 a640c23a62f3a-bb804728367mr128215866b.26.1777366769038; Tue, 28 Apr 2026
 01:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+1jF5rm7u+CfBVOg-tS94Mx_kzM_sYoBUgbDBS-EMQOxkWuPw@mail.gmail.com>
In-Reply-To: <CA+1jF5rm7u+CfBVOg-tS94Mx_kzM_sYoBUgbDBS-EMQOxkWuPw@mail.gmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 28 Apr 2026 10:58:53 +0200
X-Gm-Features: AVHnY4JxMdFpt4nzbrQSJnWYoJNIRR-ys-0FOyaevzVAQpl4v7rUZZbqedHwTr4
Message-ID: <CA+1jF5oacaZdAtyqE-=KZmW+41G260eoM9Vqa8mYiWGpkrrYvQ@mail.gmail.com>
Subject: Fwd: Linux idmapper kernel and userland source code?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9B747481022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21247-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

---------- Forwarded message ---------
From: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Date: Tue, Apr 28, 2026 at 10:44=E2=80=AFAM
Subject: Linux idmapper kernel and userland source code?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>


Where can I find the Linux NFS idmapper kernel and userland sources?

Aur=C3=A9lien
--
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast


--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

