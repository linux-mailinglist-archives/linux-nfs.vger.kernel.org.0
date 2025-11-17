Return-Path: <linux-nfs+bounces-16464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6E3C65BF2
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 19:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1D524E5F7B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD253161B2;
	Mon, 17 Nov 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="bvOK2umu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB1312803
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404763; cv=none; b=espq44h4voHLjCKJXfw+G+auApBz975zsIamVJVzvoosHzKXpwQi3He9/HWorztIZxCotkpRVo7CIW7C4NpnMZ3G1tOe8iG6VfCEJ1zKSugneDhOVfPgiYurJmWv1TsldpwtlviEi0uVkOa+Qwla09F5tv2meekjapRxWNNZZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404763; c=relaxed/simple;
	bh=UlmJdwRxFVPk8T/4S0TlNujP6UoJdeSO91T88q2IqZs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC22FWWVvlgu8SszoXe75HC8LjSCgFQP+jH2LjoYDohe0PTw6s61kbM41cGIPqWZbWoUe/VbQv2swvsB79tA7YnIo/1A3dFE1QZhklysSjVq77pDT/xbtYdqbF/l9Y84I6Eooi6SHAWvlG4Pa7CWqkwYlv72q5WYGnj15nqkcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=bvOK2umu; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763404751; x=1763663951;
	bh=UlmJdwRxFVPk8T/4S0TlNujP6UoJdeSO91T88q2IqZs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bvOK2umuBVMtRZFO+sBIPJtxvLqpww9sWgMdfhPlWlRODz0eu72AiYS7OS6IKtd4I
	 mSMyVGq3F55JsHKfnuQ9mLSaHi016vku+UMHYux2lN90jYbfMhAPM1dA9StdIBXT3t
	 gkZpk7grxaF4tTH3j0QrFtFpW1gOzmFGHy/V7w1L6H4cSwyV5cc2aQ08hP4a1Eb8D0
	 vNjY5UP8UpijW/ewlMwnXkVSvNr1rPTWHUQT4a1HqZWO6f2vFxyFq884NIxa0tv89o
	 yibeIHG44KdnTmW9+8IYBThgIF+7/d1JXGL+vjFOlaBnnhML7uLTvKjEcXyBdkdanN
	 GnWMtrycvXqHA==
Date: Mon, 17 Nov 2025 18:38:57 +0000
To: Chuck Lever <chuck.lever@oracle.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <xQVfdQl4QH2gCXCc1p3b183RlIulJzqZJfFUGwXVjzolxMXDJpacKVIHo-93VLFNbQWPjRJiR30Np_rLudFr49uNZxlKeZwkfhWH1qeiGhc=@tylerwross.com>
In-Reply-To: <e5112807-a427-4762-b7b9-ecaa95fa0482@oracle.com>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net> <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com> <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com> <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com> <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com> <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com> <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org> <ji2_uZ3RNtBdATHSokoxSrIXMAi4zh2jZXEd0WownMtXo_WNIseAeeDZoBFjT54nCE1Iw0PcGgfORC5p39CP9KGqjY6T2wqeBRGonjIjfXM=@tylerwross.com> <e5112807-a427-4762-b7b9-ecaa95fa0482@oracle.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: a6785a8a2ed18c1ee1f0f2f11dd72320ab2dd767
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, November 17th, 2025 at 6:41 AM, Chuck Lever <chuck.lever@oracle.=
com> wrote:

> > Is this gssd mishandling some setup/initialization?
> > Or is there a miscalculation happening somewhere further up?
>=20
> Does Debian's user space Kerberos support the sha2 enctypes?

Appears to. MIT Kerberos docs list sha2 enctypes support on releases
>=3D1.15 . Debian 13 and Fedora 43 are both shipping 1.21.3 . Debian
unstable currently has 1.22.1 . I haven't had any issues managing
sha2 keytabs, tickets, etc. with the userspace tools. And at least some
NFS operations other than READDIR do seem to work, though I haven't
tested that beyond observing cat, stat, and touch are functional.


TWR

