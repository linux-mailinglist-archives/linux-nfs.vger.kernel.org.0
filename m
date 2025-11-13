Return-Path: <linux-nfs+bounces-16359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D47C59924
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 19:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762B33AE372
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAF2E11BC;
	Thu, 13 Nov 2025 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="cj77aCq5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCAC35957;
	Thu, 13 Nov 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059933; cv=none; b=EU82R/9OPLdh4S5qeWIITV1T+oC48Tm08itX3FFkyiSi9bQkmblR4UM/Nka//VByxibwtKHQIdxn2X900KL+13lS+DVU3lA6M8Iwcb1UgmxBxn+b6lGdaofOCvs73wl6oO/Tw7+nW4Xw4XtVlaOamyP+Z1rZ1cd9CGQ0xTKYPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059933; c=relaxed/simple;
	bh=FqbLIISeogDIGCCTnHJETiehz7+QH4OmW2DFoH1HTeE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzqVvyFKCs7fvbnGxJUSaFg2XWYbxH8lh+H+H1kf7QkbZJumjsouadfzl2V19PBm8/oO2SuIE2Yh6jh/SBESP2VQBaPNwzPQv2/SNXRGHxxCacfP1WEjMBLwND0B7z03cuc/RMPfcy2wpratFhqYlmvf4lV3v9kfsiRxMO+dKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=cj77aCq5; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763059920; x=1763319120;
	bh=FqbLIISeogDIGCCTnHJETiehz7+QH4OmW2DFoH1HTeE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cj77aCq5lL14I5BIzHlu2y8XTolhBNsFloY27u9uIBqsqNpGXFt7jkhi7YmD5e+kV
	 IpqOpqsvPi3074Y7pXWeXPrcaPw0t40Gr4gmurBEEH878YnL9tHMEIobFOAVsOp9oe
	 /M2UISEcubLKSnBNy2UpBDiVP9gpSZyUa0B1r+seXNImnY8MQXBMA9OIvwn3HBlMRf
	 WfPlGTKJVjjGfgA194qm1uq2xnsXakypLkxzJ1L6qPKLDauLkVYxlYYm0m5PWozEx8
	 cPvFYKrLgVpzDt0tdNDBtMAqmCBLJHTT7ys6P+Ob8XrxHEnftLxZJc8fbBct+ezpQd
	 J4JjUkcBcOAIQ==
Date: Thu, 13 Nov 2025 18:51:57 +0000
To: Chuck Lever <chuck.lever@oracle.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>, Salvatore Bonaccorso <carnil@debian.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <eUtqaTOrHO8Sj-82m04dsCpmYX8bPkr5r9Nla1muHxSnxBYq57wxk7LLf_RuI377WMpUcczBXteWGvF5OfNfe5gwLmfTn_YblJucaF58POo=@tylerwross.com>
In-Reply-To: <4b77bf39-bc1a-47a1-9a16-14c44c31614f@oracle.com>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net> <aRVl8yGqTkyaWxPM@eldamar.lan> <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com> <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com> <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com> <N14GL1WKSGqrFl8nF0e6sa0QxOZrnrpoC7IZlZ20YqUyfsxpsoqu2W3a31H_GfQv7OEqaEWKwDXdgtAV-xv613w_slTAFZIoyWMutIE5pKk=@tylerwross.com> <4b77bf39-bc1a-47a1-9a16-14c44c31614f@oracle.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 9eb9bbf23a0d1f0841a100d9503cd17805100d41
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, November 13th, 2025 at 11:12 AM, Chuck Lever <chuck.lever@orac=
le.com> wrote:

> Then I would start looking for differences between the Debian 13 and
> Fedora 43 kernel code base under net/sunrpc/ .
>=20
> Alternatively, "git bisect first, ask questions later" ... :-)

This is outside my day-to-day, so I don't have a workflow for this kind of
testing/debugging, but I'll see what I can do.

Thanks for the starting place.

> So I didn't find an indication of whether this was sec=3Dkrb5, sec=3Dkrb5=
i,
> or sec=3Dkrb5p. That might narrow down where the code changed.

I confirmed the issue with all 3 krb5 sec modes, in both the 6.12 kernel
that ships with Debian 13 and the 6.17 that currently ships with Debian
Sid/unstable. Similarly, I confirmed NFSv4.2, 4.1 and 4.0 are impacted.

> Also, the xdr_buf might have a page boundary positioned in the middle of
> an XDR data item. Knowing which data item is being decoded where the
> "overflow" occurs might be helpful (I think adding pr_info() call sites
> or trace_printk() will be adequate to gain some better observability).

No experience with kernel hacking, so I'm not confident I can locate
meaningful places to insert those.

I'll see where some snooping and a bisect gets me. Failing that, if
anyone has recommendations on where to add those calls, I'd appreciate
the guidance.


TWR

