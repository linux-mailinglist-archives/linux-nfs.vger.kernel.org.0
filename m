Return-Path: <linux-nfs+bounces-16433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F54C6264C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 06:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A4EA4E458A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 05:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0032DC333;
	Mon, 17 Nov 2025 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="AbKkdlz2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2E30C610;
	Mon, 17 Nov 2025 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763356797; cv=none; b=hqFgzJFZFOgiIkjfsww+wT3Uh0s8vljqKMlRel2WBm1wroQVP32jevu/W1DzD73BLQDWTAnDXcmM+oAOUb11GJLxVCIm9Z6Jad4zGIi7RFWuOnbLWIVT25Y7kIsIda4XO9z5FCCs6+79fiZMawVrz2SA3le3wEpf8GOeUEbwUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763356797; c=relaxed/simple;
	bh=T0FtHqBLH8rDoT6dbIlAl/373R+brJM9tE1+6lJngCE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQj5LMbOeIyqJjvlmDQcUYpe17P7xSBMAdMHyvQ0z02kRjGvKhDfz11h7YsbH/yF9qN1ViAcD/ckbWpw9Ef71LAZi697n+FVlXtuCEOYSG3e9aQzWtKQouvN9rzFmnK4fgLk8VzuK9MoplRuelte5ENMejGmrWy3gw4JYXSmtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=AbKkdlz2; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763356785; x=1763615985;
	bh=T0FtHqBLH8rDoT6dbIlAl/373R+brJM9tE1+6lJngCE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AbKkdlz2lleWW6z7KZiscYvhb4RWBd0xXQzjAmyHkWVnLY8HrdC/S6hnvdHz8y7GB
	 wRJc2LwGdbQwUP/xch2eXrL6t9NuQJ9IwoTefHgxb0eDUdTFERASXGo4ZGaA0feGg4
	 tXHzRffceVm/DZ3wX82V228xZaIFazLZkJZ9MNBw90TG0qHsO8Ut+vihbJEvlUYpx2
	 s/42/gL8TBD5Cnoannm0+NRcZ7+XV1yfcXXGcQqK+qse6+EqWz59gox4DZfmEQnc3f
	 EeLux5GPD4i5d9kMJRANmLSPirHIiPBNHpZNmw+2qETpOyolYq2ki83NIkfLezkfcD
	 RvqTGedjXgD3A==
Date: Mon, 17 Nov 2025 05:19:38 +0000
To: Trond Myklebust <trondmy@kernel.org>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <ji2_uZ3RNtBdATHSokoxSrIXMAi4zh2jZXEd0WownMtXo_WNIseAeeDZoBFjT54nCE1Iw0PcGgfORC5p39CP9KGqjY6T2wqeBRGonjIjfXM=@tylerwross.com>
In-Reply-To: <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net> <aRZZoNB5rsC8QUi4@eldamar.lan> <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com> <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com> <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com> <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com> <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com> <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com> <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: af8e38192862ebbf5efa94aee527ad70b630bec3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Weird behavior I just discovered:

Explicitly setting allowed-enctypes in the gssd section of /etc/nfs.conf
to exclude aes256-cts-hmac-sha1-96 makes both SHA2 ciphers work as
expected (assuming each is allowed).

If allowed-enctypes is unset (letting gssd interrogate the kernel for
supported enctypes) or includes aes256-cts-hmac-sha1-96, then the XDR
overflow occurs.

Non-working configurations (first is the commented-out default in nfs.conf)=
:
allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,ca=
mellia256-cts-cmac,camellia128-cts-cmac,aes256-cts-hmac-sha1-96,aes128-cts-=
hmac-sha1-96
allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes256-cts-hmac-sha1-96
allowed-enctypes=3Daes128-cts-hmac-sha256-128,aes256-cts-hmac-sha1-96
allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,ae=
s256-cts-hmac-sha1-96

Working configurations (first is default sans aes256-cts-hmac-sha1-96):
allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,ca=
mellia256-cts-cmac,camellia128-cts-cmac,aes128-cts-hmac-sha1-96
allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128
allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha1-96
allowed-enctypes=3Daes128-cts-hmac-sha256-128,aes128-cts-hmac-sha1-96


Is this gssd mishandling some setup/initialization?
Or is there a miscalculation happening somewhere further up?


TWR

