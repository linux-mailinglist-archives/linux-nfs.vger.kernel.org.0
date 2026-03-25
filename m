Return-Path: <linux-nfs+bounces-20391-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOArNXsTxGmfwAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20391-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 17:55:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51931329721
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2BE9301AAB1
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C0F3F20E4;
	Wed, 25 Mar 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHJ+VuRj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B982264A3
	for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456793; cv=pass; b=GHgw1Z+NsrxOdiICKc1HtTsXhSg4/bduTlwzCAH89edhE7pf/jp7ucEDTnXXIDxrKquVI1uHluulK3DxX+Bui6UBoavn/e9Is1/NlcSqJNtW7FdIDxk8PWUYS6KRQZqzc93DQmj3S1givlXBp6BU42KGKb3cD0gjOrikz/CGlZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456793; c=relaxed/simple;
	bh=uc1+LCbY0eoe3upIZlO53VU2OLt3I4CuSqeTxMjq7sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDq5LnwWazBB46T+FmF31hEDGrmfJPOjSq4r7svgWOmg/1YKkEsm5wT//ZmuYXApM/ESjr77w6WBWuhPIEZt+SRiUltVh7h90qNDTW1kzxnFBU7arrk6buqad7sNvjm3CE53jWRbNmuDgGytLOZEmWchAUX7S4sltWL5BpEfZPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHJ+VuRj; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so7520241.1
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 09:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774456789; cv=none;
        d=google.com; s=arc-20240605;
        b=MIjLDq8DuOt0ctR5jpchjn0RwrYpaAOHO29LDtopP+WjlBn2C787blzq7VqZ32eevI
         6tNk92M/nY7veeOPmkB/WYNXstsJtjoTCO3o/gA+mDf1uGmwZ+3i9893O7vaAfpti2mI
         vncM4kG4szUwNziZ2TCMsLTAW+uP8jbB0uBLpWtth1E98jw10V3Ng8wSe3Wkt+H617YH
         rcaaZ6+ohda7SzRRUA/czD+ary/i6gRXrnApHGgh6gbqFEruM13MhxpUqvdKeXFp6FuK
         Mf/wzahQvY//OnXA07f74S4qtYFxcK1tjR527qWHQGOY/ULrEkIscwdv5Dp/KChS0e/x
         ymZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uc1+LCbY0eoe3upIZlO53VU2OLt3I4CuSqeTxMjq7sQ=;
        fh=YvJQNKtXFC9uvZfq6f/mKn8I1y1k+XFlaX0cIXMmYUI=;
        b=AAB46TXyDw2JK8w6aNIK4C8J9T8aolkHKLa/Th6sIPPraNZgNE4SCUIb7tr+zkrIHu
         J0WEEB4WPIyqXsOkJjcsIuR5zTOJ+g7yKPpKAF9O5iX3DuZkS3sobxW/NuJdG7/xO+XV
         q79sIMSyn49/XSviSWpEXeZ8hCaTPSamgG9dY3E3VcTOmVe6gDKtK8I5NTa6+24c2K/B
         AGBKoLlhApS7bqJeMuwd19F+AxZ7eCEtWkIgVKfdNq9ZSyGKMyYF3ZsirZIaNkBRkWzx
         qVyCsyT+WTcPLkeA2jitUbbBTXhTRpqkBxjsis0/i/EZsuhbQbDUXYYjTelDiKQsIwW1
         57LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774456789; x=1775061589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc1+LCbY0eoe3upIZlO53VU2OLt3I4CuSqeTxMjq7sQ=;
        b=AHJ+VuRjzqpXaRZBZuetbewVAFx9FXZXza9/SRIJTDHZzYsTsZbEfG6tFHUfIfsura
         L2hBdEEBC3Q0bhdux706vYa72mOufTLBD6nzy/hn2XQvdluh+93B60JACM5wu8Wvzckb
         uZoKLK2r2z8veUelREka86dF/P1MNUW/TijbAwjG0WFfKZymdFG2M/anTPmGKmj1reo1
         PppEAh8j9phIsGFFvcfsVckMp24RxSudK87pDqmNgwKrTkWUsBI8wSGQONVPE+7leAP5
         bSOZW5Kn5iauFmdYHmzCUUDIYzFqmgRWf+nfMH6D1MawFdPTYz2uj67uDn4ugr1KxMfO
         Im8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774456789; x=1775061589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uc1+LCbY0eoe3upIZlO53VU2OLt3I4CuSqeTxMjq7sQ=;
        b=aWhCK5usDa6SbZD01JtzKKn3XNFps1pTitm5PnOSZHVDIb41j31Kq6YuEPrBg92dY/
         MFe+TgrsS1aRJL6F/2/SIeW3Qs0S1xMNU+MuRG04x5txKOsibGnUMNDaN7SOUkHWdqyi
         nhhiC6hBhrP81P9VNAJVCKmwl5bGpWzAwwMn1VxWOh46VEaKxXY5LJLJFUKR2+SXsRYD
         0H9vlSeiasGcap20EnLwUpZkGjb1zJ6q91EnC3/d5u2i72GH4MhMKvgQci73apTjVfY9
         KxbywoDYX2POAOKFC0I8kQ6Vfrrrz2b7srYnQkexFsSaJ1cyaF6omRMzrhD16B9jYM6L
         rQrw==
X-Forwarded-Encrypted: i=1; AJvYcCV1LWF3n3QhZFO9VhxFo0/lqXBvdyaL4vaxPR0s8t/qXTfboGfhFsCkfRbaWojFPJ3I0fzkugDYgg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfTMPGIb1H3z99PqMcdGFE7mBsWN5yiJL6kw/DdUHQ8qKIAZP
	TevXW1E4WLjHz7uYqwEsMtjxTJYd0Gj65ytnY1CNOjEKHdZf5ZJUsDAVfvl9RN6B9r5ehBSwaYv
	dN/mIqtk6i/ELyTpCgBOlkDzzajN1vuY=
X-Gm-Gg: ATEYQzxabSiqeaVlw3SjcocU9z/3Q5CAdne6ksuV38uNpM+3tA6tjLgRH95N6BK0Wr5
	rthGI/akDzvZWyjj2POTKMnLqxh9eMbf0M/wwNdLuqEEBMzLdv6rQy8Y46GRKM9BNspDbu6e6wG
	V5OwBklqtCx8Lt5hzRf9321AK4/lSjAmfrVUfAD8pHVSzScERqtPGtfjP245D1CW/b3V7qgTxW5
	UUGvoTn3iVipMyPPgxoCoSLBMWOx2ACibgAXwIzg8fY+aTOewkD1QT8JDU+3XzKUq7G323L/yO8
	X9chAD0=
X-Received: by 2002:a05:6102:504c:b0:5f9:39e6:cb04 with SMTP id
 ada2fe7eead31-60379034dedmr2401577137.9.1774456788570; Wed, 25 Mar 2026
 09:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-6-seanwascoding@gmail.com> <1319acf7-36fb-4be6-9921-b0d19a2aac7b@oracle.com>
In-Reply-To: <1319acf7-36fb-4be6-9921-b0d19a2aac7b@oracle.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 26 Mar 2026 00:39:37 +0800
X-Gm-Features: AQROBzAud2z6ycdDihUpsB0b5GDaCiO63XRd--2rd1xo0jQDuzo6gaLIj1dDNpg
Message-ID: <CAAb=EJU856-J9tTZCKeUS8toMPEZd5gRckmkYCLDTdZX-9DtbQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] Revert "nfsd: Mark variable __maybe_unused to
 avoid W=1 build break"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20391-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51931329721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:38=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 3/21/26 10:15 AM, Sean Chang wrote:
> > This reverts commit ebae102897e760e9e6bc625f701dd666b2163bd1.
> >
> > The __maybe_unused attributes are no longer needed because dprintk()
> > now uses no_printk(), which ensures variables are referenced by the
> > compiler even when debugging is disabled.
>
> Some commit message improvements are needed:
>
> This revert is safe only because ("sunrpc: Fix dprintk type mismatch
> using do-while(0)") already changed the non-debug dfprintk path to use
> no_printk(__VA_ARGS__). The commit message doesn't reference that
> enabling commit by SHA or subject. If this revert is cherry-picked or
> backported without that pre-requisite, the W=3D1 build warning returns
> silently.
>
> The commit message says "dprintk() now uses no_printk()", but this is
> true only for the !CONFIG_SUNRPC_DEBUG path. When CONFIG_SUNRPC_DEBUG is
> enabled, dfprintk expands inode directly via __sunrpc_printk, not
> through no_printk.
>

Hi Chunk,

Thanks for pointing out these issues. I will update the commit message
to be more precise and clearly state the dependencies.

The corrected version will be:
The __maybe_unused attributes are no longer needed for the
!CONFIG_SUNRPC_DEBUG case. This revert depends on a prerequisite
change in this series: "sunrpc: Fix dprintk type mismatch using do-while(0)=
"

That change updated the non-debug dfprintk path to use no_printk(),
which ensures that arguments are always referenced by the compiler
for type checking, even when debugging is disabled.

