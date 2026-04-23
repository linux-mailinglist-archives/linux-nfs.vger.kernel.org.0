Return-Path: <linux-nfs+bounces-21050-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKRJEgtS6mkhxgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21050-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:08:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E533545559B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 428AC3006789
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45E27FD4F;
	Thu, 23 Apr 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlOEPdgQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C225386C0A
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964091; cv=pass; b=byyN0OKyvLHmsrxROvl0IsnncbrkKUftCox9T/LGHv4Fkm35T1sGzO3HACLMIDXm5Akeg0iLSXjgW2w0gr+34Qz5S6s+gsjY5EoDHQkWCHjCIRNh2D9UMK8lHdLZoe4kFyzg0Gy/EP2r1pRQazt34NTTdi3D9zObwgoxI0LXSoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964091; c=relaxed/simple;
	bh=eGlXIGoWQlYOJgSNV6M8K5Kj6x+UFoVG1JFeCvHN/us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Gt/27iDYXaayKe2dsOMlNPoC7CNXdMRWZXNt1H5HmRhxuaAGXI1wadP4A3fyq5ULXJCNoFJ6cKvnA+DMvpvFkfr1bD6y4pGPXUMnOwK+w/u/Boldhy74dha7Hqg9PwSNij7JSug1qBGije4h1zWPWIcaTAx8HNzdgcVDZ0tm/cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlOEPdgQ; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6720c7968e4so1812660a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 10:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776964088; cv=none;
        d=google.com; s=arc-20240605;
        b=CxDjeBE7y/4UiWc4/4zQZTgO1l1HFnH8ccT2faH0CYwR6EiQgZRBcgW0youXqqv6Ep
         ueR2DoUnwfGyHDTK+9+0MWf6DeZ85TTD/GEOjqVTKBGMO2Vl1WS443vbMnX+1kWKMCKn
         44c2g1GeUaYZ1yqOnhqLnE/pVZFVLAvpBcVE0/E5O+mvcmmENbMWBMiviWLB3vtxCZCO
         E79d0ZmFKB5nl8PbcLkLKjUgDxJ/b6iGb6TE+wNQzDdoihV/YQLR13THK+OTYLebFn03
         4SluvkLXhPmcSU76wm5nFv2BEJSPs3ayNk/iMffzweS1QaRxaO98BqPlrgnkTLPmoiLR
         ynRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tfW0k8cSW22PgICRafz8TJcAbBgock7zCON2i5/WCfo=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=CqInyCPcMSd+WuxzjZIU4uQjHSK5fYx1zKtEwQw2Pr0W/L1dsRM/PhyJreKlFSjm32
         74TRWlBl7RwTgs02FdIH9UDsaUBB5H0xcuoIU1iRkpht1893bolWXjA8H+VvY0qCeBfY
         DsPT+H1j4BAlP+r2vTH64Rjq5sbQoHdet2/irmsbJsLws/mgNk+AkGhiLh5hpvzhiaUt
         xfLo6CtseDpPyHW0yJpQrXq67RWJJ2me5r5BdI2Kg3UjjUtE/p7Kqh4bMXEQ+ybPpBLO
         Um37p6rf5CiaY8E8yHVJootMsDW117qVUk/zSMqvyZFTZSiCPAnS2yxoSgmtLaHjIWx/
         NNYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776964088; x=1777568888; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfW0k8cSW22PgICRafz8TJcAbBgock7zCON2i5/WCfo=;
        b=mlOEPdgQeHxkmNHCUI4pp3x8A3uuYsjjQUlN25SmYLwuxYCc6P6M79sM+y3vuu0hAc
         zjWMEjxJr43XUO5IrswAsB9yXhxVOtqt8ZXxTfk+2UHdK9tx9lxwFZQuerF91ClWmWKT
         qa4FrVuVkqYXYNwjGf7QLy3afUzcztnTmfxAgzkpNccZpbZBOSIBXBnkcT+oEM4eUOiw
         NEW8JvvluCMLhlO4TosMO34yLAfQGrO3SaKHeDkO7Me9/Bi7gp3nyXiB+wXKxaaZvu3w
         y/CKd5vk3BAti1N3DE4ytyPMnyqeTI8r9WV07VzndwN0OD46qW/6IHK7jOKjz8lkK9fg
         o/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776964088; x=1777568888;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfW0k8cSW22PgICRafz8TJcAbBgock7zCON2i5/WCfo=;
        b=tC+MI6diqghX0bBEODqfug/2P9xbq4v9FkpiVjKcStbYznnGVIl62PkG3MswXDizGd
         JBCn8JFUpg4KlgBi59VODqX3Ko0tF0FAM6U5Uw+hLwl1pWu9eNdApK/I4VlAq0wT9XBO
         LZXy8ieyzEIFjToFL+gXS6DBm2GpAaPfVM9pje2buS17RtIw6RZggBaCUoD1+g9zveSb
         wJkIZKYc/5tRaGDMvR6jUeyTz6+fAt7hxA2z20sC+badEoQL2JeGq3lUdC1Q1SahlzSg
         Ed/iHOiFBAH82hACG3vBko5QTHd/AFwoio65S2lLI3H9Wv1F3ZkXUHwLFMiktyog7YOc
         nF/Q==
X-Gm-Message-State: AOJu0Yz5w821B7bfuAeQw4sch8EcOT8Y3dSfhDf/0PGkCC3h54o8T3bN
	315w9R40qhJfYhjgDZ6iQ9rA9/lIbE5t458uBcssEWF+VMDW3fXsXMx6NKH4+lJru1nIsfIi1OU
	yzwRD6VYIeOKqbD+ZGT0X/dSYDqeEKYA7Iw==
X-Gm-Gg: AeBDiet8fWuROT0v9Jp+d9aryA78Si57fgSPOt3I+4ZC7t+bn8gh1TyStWuw8ieaYES
	CeCSEo4Ee5KiB18ckrOe8TH39No+LlyEhvNzfn89j6TrU38cfMoPQ8jjnLdMmGvl0LSAFC77aAe
	YVSIDt6A3JHjFVXZfReXrYPJGHQeFT8HwX9AMcHUAOkLc9ssBbhDZI8PmhD8YAw085v+CuGwp8o
	Sa3l7Z+wvmy4ofxQVua/rCLZeizN2cs8VWNH5Mrrkp1iafHcr1qoXXe/jKyFayOWspvCUHuMhXh
	h7qP6RFIPVeqC1B56w==
X-Received: by 2002:a05:6402:5384:b0:678:8f3e:2bb3 with SMTP id
 4fb4d7f45d1cf-6788f3e2f29mr1538219a12.12.1776964088299; Thu, 23 Apr 2026
 10:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=F7tO_6S9xGUyyqZnc89FxhpKgtF7soZ+59vnSeYB2xMw@mail.gmail.com>
In-Reply-To: <CALWcw=F7tO_6S9xGUyyqZnc89FxhpKgtF7soZ+59vnSeYB2xMw@mail.gmail.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Thu, 23 Apr 2026 19:07:31 +0200
X-Gm-Features: AQROBzAoiCN_FGOA-P9XgIbHB7Sh8UOZmvWGymENSMvubByOlZRS82BSNGZM-70
Message-ID: <CALWcw=HJ=3FxjLntfFrdjmFa-QKgs29uvna-m8mYRHTeHMJphA@mail.gmail.com>
Subject: Re: Why does Linux nfs not set EXCHGID4_FLAG_SUPP_FENCE_OPS in
 NFSv4.2 mode?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21050-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshinishimuralinux@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E533545559B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

?

On Tue, Jan 7, 2025 at 4:41=E2=80=AFPM Takeshi Nishimura
<takeshi.nishimura.linux@gmail.com> wrote:
>
> Why does Linux nfs not set EXCHGID4_FLAG_SUPP_FENCE_OPS in NFSv4.2 mode?
>
> From https://datatracker.ietf.org/doc/html/rfc7862#section-14.1.4
>    A client SHOULD request the EXCHGID4_FLAG_SUPP_FENCE_OPS capability
>    when it sends an EXCHANGE_ID operation.  The server SHOULD set this
>    capability in the EXCHANGE_ID reply whether the client requests it or
>    not.  It is the server's return that determines whether this
>    capability is in effect.  When it is in effect, the following will
>    occur:
>
> Why is Linux not doing this?
> --
> Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
> Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>



--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

