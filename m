Return-Path: <linux-nfs+bounces-16376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB06CC5B5D8
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 06:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361293BC8BD
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 05:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C22D595D;
	Fri, 14 Nov 2025 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="aWvu+bPh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E02D6E61
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763096962; cv=none; b=QfSXdJZwxnjznEgkpLTMGUAIOaOvUcwx+sDiiFvbnr3FfeYc2obMb4adY+pxA09Hg9qN5eY5PWpdwQty1EPR1y/Jq98VzLoH2319M3LNlyhdMyO45gq9Ve7pXY1MusgFnfgygwgkAKasaCiZQc27DAJ+cxKHz6DEuHQCZfobff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763096962; c=relaxed/simple;
	bh=pyWOZuQRvsdZiZsN6Sf7PLIY3twTa+nSS+ogAHU/jQo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3BqonR3x8xG2ujRBbR5iA6mE0n77SFqw1CbMie0DypmwtXpikipjRhtOAfXrL3N4UHuHcBMAaG7sAcEZKpHMWzp8M9vFFS1Fgp3MgOxZm1xkXZU2NO+d7kK/E4aGQp42aeX45GAMwL6C3J4MbGSxoPwtbfrM3c7hjgusW++DTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=aWvu+bPh; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763096951; x=1763356151;
	bh=pyWOZuQRvsdZiZsN6Sf7PLIY3twTa+nSS+ogAHU/jQo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aWvu+bPhmQpW606vAjvkk34iijxkUZaBdgtwgI55DCeVJmdq43QPzKQniKcYUHFF1
	 XjqgMpNmP/8ERi5AoVHOcNV0M61nLgfhAfqATZt/TBEPdm6e6zn2sjgV/oWth3qhPw
	 64Ond2ZvOuHoYmw3FFwJ/MJGgAHYHOkds3qrWQlIInz443ani7TDv+HbWx+DDtI5q4
	 /IEPiepwToTnsMM+kNv/aZRFSayXs7+S7wR3tzEstoaOcy5q2+9AeNd3bxV7m37E/B
	 nTmYIFdEzv8Gmr5r/2hf7nFdduP6XxRnllMAVwoQ5SYmTlSfLtjBTvp8siLgDlZ+pr
	 Rb4fQzNxx4urg==
Date: Fri, 14 Nov 2025 05:09:08 +0000
To: Chuck Lever <chuck.lever@oracle.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
In-Reply-To: <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net> <aRVl8yGqTkyaWxPM@eldamar.lan> <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com> <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com> <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com> <aRZL8kbmfbssOwKF@eldamar.lan> <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com> <aRZZoNB5rsC8QUi4@eldamar.lan> <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com> <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 04185800b5222f4d21a5df985779f0878c5cd553
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, November 13th, 2025 at 9:35 PM, Tyler W. Ross <TWR@tylerwross.=
com> wrote:

> I tried a couple vanilla/stock kernels today, without success.
>=20
> Most notably, I built 6.17.8 from upstream using the Kconfig from the
> working Fedora 43 client in my lab ("config-6.17.5-300.fc43.x86_64").
>=20
> Unfortunately, the rpc_xdr_overflow still occurs with this kernel.

Quick addendum:

I had not tried Debian 12, because CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2
was not enabled in the shipped Kconfig.

I just spun up a Debian 12 VM and installed the aforementioned
upstream 6.17.8 with Fedora 43 Kconfig kernel and confirmed the issue
also occurs on Debian 12.


TWR

