Return-Path: <linux-nfs+bounces-19758-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF+0Cu5MqGmvsgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19758-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:17:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 814372026A1
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF6223020226
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD48283FC3;
	Wed,  4 Mar 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Tyo/AFgg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA63B5856
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636742; cv=pass; b=cAf1Wp/g67aUdoLPLkukQDUDD25at9UmQ1WvJnCA9x+jgFqv8JsMapK6oYFQJEnQGiJJbGMRBn3UA2zWrFheyw+yXPUMrAyjCKOVmf06nTo/SwFdt+8gMzIEwuCYJ/nUAlcLmHQHUDYQ/7pvwPrLb/Vf5YbyiF4C3DwfDpH1Wtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636742; c=relaxed/simple;
	bh=31u+jOt3Okd7qZoKUt2+Zv2M7uxDvqIiYT5DdpIOghQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brf5rOOYpw469OLFaqxOzDIGocixweaAoqnSIFqPW2lYfQ1vOf5drzQy8YsdLrCztokesEY3lkI2qPrrdPT/D9nKSHxwA4XfP0sE68s/B9jXWICyncjs9Yf1Y3EV7o377E57r8R1dOla8t7AM4tUJm+3vft24Erq3s09lmEeGLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Tyo/AFgg; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a2cc31e20so14991121fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Mar 2026 07:05:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772636737; cv=none;
        d=google.com; s=arc-20240605;
        b=cHmn5X2OO6gn2F6hu4+RJcy05j2CGMjcZnRR6wL2szioAbjdvTcP10HktNgxdu+Bn/
         NnfL3TLEnNBObZx2A/eLt26mGegCpsIopaWY5ulXFF59w/uS7Fk0x90Td4CNquDb6VtS
         3Q8lS5qwEGjdItn57oBp2NSLLr3lV8HtTxaV7ds7vaHgP/ZTVWD9NnCdto0cUGT5b5aT
         +ufxCNMKG8e//L7Dr5123bi0MhQxU/ptQjJtdaoL7PyEYYngsQv9oh3mD1+D9FVk69Fe
         hZUFBb+3HvzcMFcvDzusogMHWBosdTRf5/IUtKeSgHxrifN6yG3HcYakhsbsmQnuJkJD
         abiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O8Bn9h/TGg8RahqvjyEQM7uSOR/VAWRWvbMSu+QKfJg=;
        fh=UwOC0ovImxWgsvSEsErVYWNl05uLwOl+tm7dtHQohSo=;
        b=WctHNeYTDk6PLWP563sn568kYP1/zGuC08e6Zx5c9FF3P7UnqJDUxxcPmO2qkxJHli
         SVZ1MKbURJ3XYECfeJWosx4NGiZGqEgDi1PtkhdtRseUC3+1vRSIJZn/MzwK+TOrnS8y
         wy96F9Iubyhe0YrmvbTbzTwV16baOKPcrEg95H0DriR0xAuVqskUycLvk7lSjIOAj7Yj
         KOPAyJoEm2bSdyIec1P2O30e2DGR6Pm0+FBpvnFeuBz7H5xWur5gP6lLEbIOoeae6R4x
         bf8few2cFJBoS96ZiuKEBJg0apAkQ56NFCSe9aOg+ygMf+PB6HqkyMe0hS+Et36pQw85
         OL3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1772636737; x=1773241537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8Bn9h/TGg8RahqvjyEQM7uSOR/VAWRWvbMSu+QKfJg=;
        b=Tyo/AFggImyShwarZr29mR1gpMzKrsi+yBI4/haBB/w5AAUG3bO6qm2iTmDxf82OAr
         7VflFamsjzwZn0jaI0xO1SkC4zAoI7aBxxDrYgSwPENvr5D3eQxFtZXHCoNs99U6nqHU
         V2kLa306EjVmoeJAYPoqiDkVyxKt/qStFrc2S2CsWs7jCGOYw+1Ma4CCfHiYfjO6aBB+
         ZHO9Ft35h9rdK0ZMeMVUl/ySXdZfrNP85Yn0pytB2hwE0iOjHBUfSFMNp5Gc83tCshPT
         0PvRPqT+TbQBC9ga6xrOSSLVBree69Zd3RSs+dtdrFAMqlMScTjPewt6jDDyij3QPkzu
         JCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636737; x=1773241537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O8Bn9h/TGg8RahqvjyEQM7uSOR/VAWRWvbMSu+QKfJg=;
        b=P2vsA1FyiGHHKvpVYMdBVIrk/mQQQ42UiVAYgzcnmE6zUNQ3w4O4A7AxRtRbZdEHT8
         jJLXy6gqCnEiA7R584GlgpEGpb4dc2iYbwh1mIGPY0NJOXIxur3PK4rfDGfW3HuXa8j/
         iRsahB3q+FyLdWtliXLvTKpMFDV11Aj7jNJR+iIqg/UWtNqMH/HBo7Kj4We0tBeoknLd
         ucdIAUqXIcpDadoM2CTtDwyojCuLHKer9dq5pSZc1DMQPtruR9rDm64ulRiEiQgPFQBT
         8exAGzgAaZkNb2IBEGudC2PRclLdmoVvq8wIwsKubC32/uiNte+zp42I6HXdyrVgtT0W
         AlIg==
X-Forwarded-Encrypted: i=1; AJvYcCX2YYU0iI6sP7tFzTRrMUiEaTV9w+C2t1poj3jYK1Mjd+QV8yStAJNhKc0yXy7o+CSHYdRJnHKnXPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIffrXcTripUKwjjhjqxyBIsaHIzBJL76VC+cthsEcWQAl27Z
	CrOHzBkFWEe194qx+t1Wi68oyPYU5SowwEbqunHUh0/vyO46tHfMd92We93h03WYNOsYtwN1RKw
	QZ7uacz/M0GJ4pRT/H4yCb1/HnJbMBVbaZwCCpYk=
X-Gm-Gg: ATEYQzyGYOg3on9iMrkCz7tkUzDwXz7Yt36t/itRo4X9QD3FJInB7Mx2IJGaKR0p8Be
	H7R4SIj5r9rzL+PUU5Fv95e2lbqKuxsdtBxodWSKwQBLpucv5eGuQ4+U0Dhpu0RNdG5UirkRmzH
	j4prYjCv88cxLGCgYGE6gSZ0Wyvbz7SNf9C5rEcBoncWAMLKvxTHOG61fedW6+cHz9KXncf1aaZ
	XoomkIl+g4iMBTZQAhdbV+AY5xJkJmBWl5j2tqfhMs2qT+XaIRbe7KOSCPKIQrdDxGzugV7hdmH
	iJsC+ajSlXFi0hHoNjK3n9gQtqPHUgBtd0cPWqU3
X-Received: by 2002:a2e:9659:0:b0:38a:1eb8:b435 with SMTP id
 38308e7fff4ca-38a2c7c6255mr13711101fa.38.1772636736764; Wed, 04 Mar 2026
 07:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me> <418f30b5-06ae-471f-bf5f-f14f3f75deff@leemhuis.info>
In-Reply-To: <418f30b5-06ae-471f-bf5f-f14f3f75deff@leemhuis.info>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 4 Mar 2026 10:05:24 -0500
X-Gm-Features: AaiRm51PI1Lp7O44wLc1I1pkNDqWhOjyYlFKiOF_nsZ7SE-96pmYevd16B6C1nk
Message-ID: <CAN-5tyGgiKnBAjrMq_vJ+rBhFQ1DDWWv_Szxdxy0WVbsJ0FwOg@mail.gmail.com>
Subject: Re: Regression: Missing check in nfsd_permission() causes -ENOLCK No
 locks available
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Tj <tj.iam.tj@proton.me>, 1128861@bugs.debian.org, 
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, stable@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 814372026A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19758-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,spinics.net:url]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 5:00=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [CCing a few people and lists]
>
> On 2/24/26 03:09, Tj wrote:
> > Upstream commit 4cc9b9f2bf4dfe13fe573 "nfsd: refine and rename
> > NFSD_MAY_LOCK" and
> >   stable v6.12.54 commit 18744bc56b0ec
>
> In case anyone just like me is wondering: the latter is a backport of
> the former.
>
> >  (re)moves checks from  fs/nfsd/vfs.c::nfsd_permission().>   This cause=
s NFS clients to see
> >
> > $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> > flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks availabl=
e
>
> Does this happen on mainline (e.g. 7.0-rc1) as well?

I believe it probably does.

I could be wrong but I suspect that this occurs when the user running
flock does not have write access to the file it's trying to get an
exclusive lock on. Furthermore, it has been noted that the export
policy of the server contains "auth_nlm".

I ran into this before and there is an email thread titled: "[PATCH
3/3] nfsd: reset access mask for NLM calls in nfsd_permission" which
tried to "fix the nfsd: refine and rename NFSD_MAY_LOCK" (this is in
the middle of the discussion link
https://www.spinics.net/lists/linux-nfs/msg111534.html .. that
basically says flock should fail) . There was a period of time related
to commit 4cc9b9f2bf4d when such access was allowed until it was not.

Change export policy to no_auth_nlm if it's desired that flock gets an
exclusive lock on a file without write permissions. Or give write
permissions to get


>
> Ciao, Thorsten
>
> > Keeping the check in nfsd_permission() whilst also copying it to
> > fs/nfsd/nfsfh.c::__fh_verify() resolves the issue.
> >
> > This was discovered on the Debian openQA infrastructure server when
> > upgrading kernel from v6.12.48 to later v6.12.y where worker hosts (wit=
h
> > any earlier or later kernel version) pass NFSv3 mounted ISO images to
> > qemu-system-x86_64 and it reports:
> >
> > !!! : qemu-system-x86_64: -device
> > scsi-cd,id=3Dcd0-device,drive=3Dcd0-overlay0,serial=3Dcd0: Failed to ge=
t
> > "consistent read" lock: No locks available
> > QEMU: Is another process using the image
> > [/var/lib/openqa/pool/2/20260223-1-debian-testing-amd64-netinst.iso]?
> >
> > A simple reproducer with the server using:
> >
> > # cat /etc/exports.d/test.exports
> > /srv/NAS/test
> > fdff::/64(fsid=3D0,rw,no_root_squash,sync,no_subtree_check,auth_nlm)
> >
> > and clients using:
> >
> > # mount -t nfs [fdff::2]:/srv/NAS/test /srv/NAS/test -o
> > proto=3Dtcp6,ro,fsc,soft
> >
> > will trigger the error as shown above:
> >
> > $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> > flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks availabl=
e
> >
> > A simple test program calling fcntl() with the same arguments QEMU uses
> > also fails in the same way.
> >
> > $ ./nfs3_range_lock_test
> > /srv/NAS/test/debian-13.3.0-amd64-netinst.{iso,overlay}
> > Opened base file: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> > Opened overlay file: /srv/NAS/test/debian-13.3.0-amd64-netinst.overlay
> > Attempting lock at 4 on /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> > fcntl(fd, F_GETLK, &fl) failed on base: No locks available
> > Attempting lock at 8 on /srv/NAS/test/debian-13.3.0-amd64-netinst.overl=
ay
> > fcntl(fd, F_GETLK, &fl) failed on overlay: No locks available
> >
> >
>
>

