Return-Path: <linux-nfs+bounces-16477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7057C6737B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 05:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E53FC28D15
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F2248F72;
	Tue, 18 Nov 2025 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="RbPV6QEl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5F25F97C;
	Tue, 18 Nov 2025 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439030; cv=none; b=Oon1UcjK3Ugkc0yNHYX85LjHO+pd+D0KzkCCx4yAkLe+N8b2icpq0ruk9j93ivxAPxYFUoYjJyDH2dzou6EF7RQ7YlqyN4zXWo7apHiCozXnfsbVQE7CWiJGe6WQhbMJElfgAED0jEFYHs26w2qNn/BczkvoYW+lcMjPteu6sZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439030; c=relaxed/simple;
	bh=AgXiotAMXFD9dmEb8lubsdIkxKLh+jjGAbU1w8frdrY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJQm4UZFNhZwImWl9RqwulidqGlZwzuggHcAZ5n+9W1VKT03md8+XGr3IoyKw6g+tI45V6CV65kEUV+TlbZIVxQg+fKCgnw0n4ts+OoJ5xifRy165DFyzJqrqWDqRZMWbT2om2hi8eCitO9mGzty3oBFAf7302hlhZheYVsXaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=RbPV6QEl; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763439019; x=1763698219;
	bh=5twNK/31bDb4P5Qc0Na3Xk1G4KxzAV+2bDwRxGcSzhE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RbPV6QElA/KaiSPoS0y/qL3rm4ADpIzljcWi3dvFMwkmt+fcmg+UOWcC9mJh+/4GA
	 VZ5iyjBv6sC7OaN2gceUJ9523D2v2YDBP0amcJ/Ja8hs8pvPmaB64UxWBQ6uKbFCZo
	 8IpjsigH57E6PCFD5cXay1bWRAbPHzgVuydlBZM5JiV7L6YFrvU4VVCQ29F04ZGiEO
	 FrsqIT3zjiXo8LiWtj885XKd5QIek6UlAGGVLFTvYUmK8fh/FpbxQjbHuIk0lo6Zcb
	 pfzfOmnDNmo98r6Simk4lNcBitqh5NQGaaAsNVLbuG/JIjGoCietHX8KVQzemYvUUk
	 zU40+FN2yW8UQ==
Date: Tue, 18 Nov 2025 04:10:15 +0000
To: Scott Mayhew <smayhew@redhat.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <db8b1ef4-afbb-4c23-b7f1-9ae688cef363@TylerWRoss.com>
In-Reply-To: <aRunktdq8sJ7Eecj@aion>
References: <aRZL8kbmfbssOwKF@eldamar.lan> <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com> <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com> <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com> <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com> <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com> <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com> <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org> <aRunktdq8sJ7Eecj@aion>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 33e0bb7e15a59c5fc3f3c886597c7481f7b4a118
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/25 3:54 PM, Scott Mayhew wrote:
> FWIW I have both Debian Trixie and Sid/Forky VMs, and krb5{,i,p} is
> working across the board for me.  Normally I just use a plain MIT KDC,
> so I tried IPA and that works fine too.

Did you confirm the enctype used?

My repro steps, from initial mounted state:
kinit
kvno -e aes256-cts-hmac-sha384-192 <nfs spn>
ls /mnt/example

On my Debian Sid VM, if I do kinit and then immediately ls, the issue=20
does not occur. klist shows the acquired service ticket has an
aes256-cts-hmac-sha1-96 session key.


TWR


