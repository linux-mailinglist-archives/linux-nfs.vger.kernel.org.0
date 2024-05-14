Return-Path: <linux-nfs+bounces-3255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 790788C5D06
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 23:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F011F217E6
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 21:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10725181BA9;
	Tue, 14 May 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="mKEZc+qz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-202a.earthlink-vadesecure.net (mta-202b.earthlink-vadesecure.net [51.81.232.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B985180A77
	for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.232.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723528; cv=none; b=em0K1pdNJ0uMLIQ0VWbD8m3ZTujpyqqPvPiwagcFqhCYnp5VmtbYJd31jIyN/boDZjdYn7Egj0i/REiWzne6ii95qQUOdLRmW/Qwmx5WJT7OW2k/zQrxmlFt1rfv7DyucdOPHqxZHvz4OSxgDEjMOLHzSTR+EEhA/lNabIPB2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723528; c=relaxed/simple;
	bh=krokBtMPyJGObhBFFEyIJHlGk0D6dR8xCzDJkom3sQM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dS/6kvs+gQZ3Iel3uq3xVTpZVcn9VXH6hDi+JKGJYDGB9ZPxN2FWdiU7H+7+2Q2q8h55+UIJZWg/BS0wmAvSSP/hYUmX0H9VSqiCYwZlz4S8vOqThtOVsCSn2sZcxOgYpGCaVscvr+TrWWr5/zCjyWvwG3RLCPoGp+NeI7IsN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com; spf=pass smtp.mailfrom=mindspring.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=mKEZc+qz; arc=none smtp.client-ip=51.81.232.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mindspring.com
DKIM-Signature: v=1; a=rsa-sha256; bh=krokBtMPyJGObhBFFEyIJHlGk0D6dR8xCzDJko
 m3sQM=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1715722606;
 x=1716327406; b=mKEZc+qz0R1s9IHf5oUGwNQ7QVkPgX/YoK+6T6CBSHLeH5bXuRuzKXE
 f1cr+XR+71o5foqC+m53PnQGM8EETkpkuYip1fdNF7+b/Cbue9hYPFCmvVen6JcWsw3EGbh
 cwBVha2LruxMvk7+MlsJLA2xCVM6DFyjcSKxlqPVstirzNqaNTc2ajNSFhHKRkCDIUGr8xo
 E7e1MOSbjm7ImW349r/1U0o8TrhzFjI568Q5vOma1t/8xiTgotEt9BWRAkA1oHQ/LLDcfz6
 LC1dei2oaVerdArg+42Yi0wAfR2QhfQCjUqrFHVVY1A9hx1swb6NYeCTd6vh3tAMW6dVGXo
 RXQ==
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by vsel2nmtao02p.internal.vadesecure.com with ngmta
 id 7d8895d6-17cf789eca5e61d6; Tue, 14 May 2024 21:36:46 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Chuck Lever III'" <chuck.lever@oracle.com>,
	"'Olga Kornievskaia'" <aglo@umich.edu>
Cc: "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References:  <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com> <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com>
In-Reply-To: <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com>
Subject: RE: sm notify (nlm) question
Date: Tue, 14 May 2024 14:36:46 -0700
Message-ID: <0b1101daa646$d26a6300$773f2900$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHEASMWtXHACiXspnILht8YFbc9TwH0RebzsbTofqA=

> > On May 14, 2024, at 2:56=E2=80=AFPM, Olga Kornievskaia =
<aglo@umich.edu> wrote:
> >
> > Hi folks,
> >
> > Given that not everything for NFSv3 has a specification, I post a
> > question here (as it concerns linux v3 (client) implementation) but =
I
> > ask a generic question with respect to NOTIFY sent by an NFS server.
>=20
> There is a standard:
>=20
> https://pubs.opengroup.org/onlinepubs/9629799/chap11.htm
>=20
>=20
> > A NOTIFY message that is sent by an NFS server upon reboot has a
> > monitor name and a state. This "state" is an integer and is modified
> > on each server reboot. My question is: what about state value
> > uniqueness? Is there somewhere some notion that this value has to be
> > unique (as in say a random value).
> >
> > Here's a problem. Say a client has 2 mounts to ip1 and ip2 (both
> > representing the same DNS name) and acquires a lock per mount. Now =
say
> > each of those servers reboot. Once up they each send a NOTIFY call =
and
> > each use a timestamp as basis for their "state" value -- which very
> > likely is to produce the same value for 2 servers rebooted at the =
same
> > time (or for the linux server that looks like a counter). On the
> > client side, once the client processes the 1st NOTIFY call, it =
updates
> > the "state" for the monitor name (ie a client monitors based on a =
DNS
> > name which is the same for ip1 and ip2) and then in the current =
code,
> > because the 2nd NOTIFY has the same "state" value this NOTIFY call
> > would be ignored. The linux client would never reclaim the 2nd lock
> > (but the application obviously would never know it's missing a lock)
> > --- data corruption.
> >
> > Who is to blame: is the server not allowed to send "non-unique" =
state
> > value? Or is the client at fault here for some reason?
>=20
> The state value is supposed to be specific to the monitored host. If =
the client is
> indeed ignoring the second reboot notification, that's incorrect =
behavior, IMO.

If you are using multiple server IP addresses with the same DNS name, =
you may want to set:

sysctl fs.nfs.nsm_use_hostnames=3D0

The NLM will register with statd using the IP address as name instead of =
host name. Then your two IP addresses will each have a separate monitor =
entry and state value monitored.

Frank


