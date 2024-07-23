Return-Path: <linux-nfs+bounces-5022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E36793A50D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 19:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3EF28430B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C1158A17;
	Tue, 23 Jul 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="gUiVb8+r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-101a.earthlink-vadesecure.net (mta-101b.earthlink-vadesecure.net [51.81.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E21586C9
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756240; cv=none; b=vFnjCOnOEMvtWdDklkpRlfRUYs2Qh+Ba2EAKl4R/sYPQ7359VE31Wlcz3RuqpHG299vNpNdHnLmMrgf5rnHuh+rSpLPwl5As78y8QxBuklhUtYrgZ2gz/ya0GFZ2o1mPkHtCscu4cKK44X9nF0OS2DvA/S43PDNQcNJX7WSGZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756240; c=relaxed/simple;
	bh=6RvyKDDAl4Jv3Q5TrMZNA6w8l9uwi4/yYUn7pLSp6HQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0naXDTP8Nk8dAbfwCpUa/IxCd7V5HSq2D+ii6q1c+0W5ktrHHqANKV9TzLsrEm50iHO05Z5Ll0jDdKO8vwBAr4uNcRNLwWSbob5hBwGfgFEnI+AYj0RWat+v+VcWcBt9K+O8u/3yr336b0Hd+yDsIV7u0fFe1X20gPVPsqh4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com; spf=pass smtp.mailfrom=mindspring.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=gUiVb8+r; arc=none smtp.client-ip=51.81.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mindspring.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=6RvyKDDAl4Jv3Q5TrMZNA6w8l9uwi4/yYUn7pL
 Sp6HQ=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1721755322; x=1722360122; b=gUiVb8+r0T+o3waFi9uQQY8aHi5
 htRItYL6QmCy2VW5dm2raAOSyamYO8mpAZGCeqKjuf9RIifJEiwFwpA6mjL5rvD2uyL0WAa
 6YE07kSggv3yUZuOj46d4LRCedEiETFfQW7QoZ2kTOzd5lFCkT/MWMbT4QBbTRvqp16Luqm
 Xt7ToKixaSCBwGqjRPMW+1HInfljflE/gS+VTKicPpkvn89b5RDF/f+VR/xidfQONdAiKJH
 JU2FzC+b6PcpIMnHwBWPpsAMzW3awo7Wx46pm2PqyBrt6lx/zOH/E8OQpLERVMZWSJDM2tT
 tnamDwj8P4Qo3HfwC7Q6Yy8iX0KtuKA==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by vsel1nmtao01p.internal.vadesecure.com with ngmta
 id 3bb018e7-17e4e757d03bb4f5; Tue, 23 Jul 2024 17:22:02 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Brian Cowan'" <brian.cowan@hcl-software.com>,
	<linux-nfs@vger.kernel.org>
References: <CAGOwBeW31AThuSLW-aWE0wAz302qaXDaCKCOmmOPjCewB8rkgw@mail.gmail.com>
In-Reply-To: <CAGOwBeW31AThuSLW-aWE0wAz302qaXDaCKCOmmOPjCewB8rkgw@mail.gmail.com>
Subject: RE: Limits to number of files opened by remote hosts over NFSv4?
Date: Tue, 23 Jul 2024 10:22:01 -0700
Message-ID: <02af01dadd24$d51d7690$7f5863b0$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQMKQycs3wvwijO88vToxeb8/jxcO6+lwoHQ

Any server is likely to have some limit based on the memory use for the =
open state.

We recently introduced a configuration to limit the number of opens per =
clientid in nfs-ganesha for comparison, prior to that it was not =
specifically limited (and the configuration defaults to no limit) other =
than we would eventually run out of memory.

It's probably good to have a limit, but your case suggests a value in =
that limit being configurable.

Frank

> -----Original Message-----
> From: Brian Cowan [mailto:brian.cowan@hcl-software.com]
> Sent: Tuesday, July 23, 2024 7:16 AM
> To: linux-nfs@vger.kernel.org
> Subject: Limits to number of files opened by remote hosts over NFSv4?
>=20
> I am responsible for supporting an application that opens LOTS of =
files over NFS
> from a given host, and potentially a few files/host from a LOT of =
clients. We've
> run into some "interesting" limitations from other OS's when it comes =
to
> NFSv4...
>=20
> Solaris, for example, "only" allows 10K or so files per NFS export to =
be opened
> over NFSv4. When you have 2500+ client hosts opening files over NFSv4, =
the
> Solaris NFS server stops responding to "open" requests until an entry =
in its state
> table is freed up by a file close. Which causes single threaded client =
processes
> trying to open said files to hang... Luckily we convinced that =
customer to move
> the clients back to using NFSv3 since they didn't need the additional =
features of
> V4.
>=20
> We're also seeing a potential issue with NetApp filers where opening =
too many
> files from a single host seems to have issues. We're being told that =
DataOnTAP
> has a per-client-host limit on the number of files in the Openstate =
pool (and not
> being told what that limit is...) I say "potential" since the only =
report is from
> things falling apart after moving from AIX 7.2 to 7.3 (meaning there =
is a non-
> zero chance that this is actually an AIX NFS issue). In this case, =
NFSv3 is not an
> option since NFSv4 ACLs are required...
>=20
> Anyway, as a result, I'm trying to find out if the Linux NFSv4 server =
has a limit on
> either total number of files, total number of files per export, or =
total files per
> host.


