Return-Path: <linux-nfs+bounces-16375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4326C5B53E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 05:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A29204E74C3
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 04:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0725260565;
	Fri, 14 Nov 2025 04:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="rarsM8OW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C762C17B3
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 04:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763094960; cv=none; b=Ay7V/1C1eI3SFsPHgdtig077Tnf49IZQMAUOsEOa8o/3icoV5guH12CUQfydZKlhJWhZPsj6MB5Xc5SvHIDRyx6w+EFQa1IGSAg/rAtSA08fzzD7w6fzB44m0wUALAKSaE4k2Z0imxfl1K2wzbQ6WNGM9cBLz/0V8+NuKjOEtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763094960; c=relaxed/simple;
	bh=354uOqmfFxSy8Lz98vwSeJb79HRJQUnQvFmjOg4U23k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3sC/l/aodmht5v/hnuWN0Ppfm3Luka2tGmH7i9uDTcxJRWQZN1wkvhjIStC0XQkJCQvD8AD1+LWl25310b3xWvTqSrh8A58H+SkcLArsf/X8J6BAxs9b54jAhuSdLcr+kSuMMAQjmwLa2zwEhPx+trAzLwinkr9ZyRAS9jprKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=rarsM8OW; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763094950; x=1763354150;
	bh=354uOqmfFxSy8Lz98vwSeJb79HRJQUnQvFmjOg4U23k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rarsM8OWbbfeYghEo70rnEGAXt4EIvD0LnayhPwC331wpXg/8k9otcczSPdw/Di+7
	 Pex01aGkR98U4wXjmbFvElDlgu5eHB2h2M11F07gU+9NFNLEgCx70jtvKAngYqTdy0
	 B0LxOGK3ndW+Ld9nYF0fD4O2yZjzbCSbwIMLjwg7K5stxGo+CPUitUp0sMD8LjFIBH
	 UBe2q4okd5PnNGHsf9nGAtsSJlYkAsmgW7b74V91eItHE72xhEJ2hr4V59TTv8vXR5
	 lI61/QMMxPpf27HH5M1N1YF3wXgA3YZaLdm7utAIrTMxcYjuQdNTkGPp4VGBeISleU
	 H4coEQfnUeRiw==
Date: Fri, 14 Nov 2025 04:35:46 +0000
To: Chuck Lever <chuck.lever@oracle.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
In-Reply-To: <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net> <aRVl8yGqTkyaWxPM@eldamar.lan> <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com> <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com> <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com> <aRZL8kbmfbssOwKF@eldamar.lan> <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com> <aRZZoNB5rsC8QUi4@eldamar.lan> <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 6e25dc47ebc0f71e5ee7770820042181f79d0f98
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I tried a couple vanilla/stock kernels today, without success.

Most notably, I built 6.17.8 from upstream using the Kconfig from the
working Fedora 43 client in my lab ("config-6.17.5-300.fc43.x86_64").

Unfortunately, the rpc_xdr_overflow still occurs with this kernel.


TWR

