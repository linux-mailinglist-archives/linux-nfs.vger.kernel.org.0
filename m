Return-Path: <linux-nfs+bounces-16357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A3C59735
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 19:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 998585032C5
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A935C183;
	Thu, 13 Nov 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="RCsAX8PN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0B35B13F;
	Thu, 13 Nov 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057162; cv=none; b=bBzvM8Td8s/gyskXzMx5ve73gRL+35OxyqqwiMu5p6K/GtO/eFlan+vO3a6pPtdgMW4Oe7FglwlX5TrFGzn/oP7FDyFTLj1cXaIlKdZB/jeOrQvyKPZHopoQLJEIw42jqfl4RHvv1z9rsYcDI9GImV6q18/T7d7566wtdeW9lBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057162; c=relaxed/simple;
	bh=8hE+/9C8JikjOqpJM9YJF+ct/ykwKE6bKDb+Wuq4xUg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9/DWncUbP513un87tUg/fKc32g7gyO0uj9BobR2PzbfzqOkx64PJKCWdwd2mm1Jtddjm6nbRA9iK1PXQVF+LO/uA2oz0vh92i82i7zFXQGXg1OMYp/hpDNSSwJyiJlyhbb03y6xMaExmwYyFdtyh/RgUWiJmlCq/EGffZ6UbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=RCsAX8PN; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763057142; x=1763316342;
	bh=8hE+/9C8JikjOqpJM9YJF+ct/ykwKE6bKDb+Wuq4xUg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RCsAX8PNo+GD+uRJV3AxYDQ6cqHtk/WcX4Ng5aWWjr1yCbAnDePVAzcNV/PXN0JPI
	 5qlPffgqAk660I5Gk8Bup/0gjM4i7DcpHTV2ujuQvqTHysm7O0Z8Yw2jYTkHt2DERj
	 xzZxaZWtsQm2ancO95/ejY8OmBAtSt817/GE53q61/RMpvnxJzraFE8LDm2j9LXcop
	 5uhi5MAaAEyFyh6LQVwMTvnouWzLZaJ1Tb0Q5CPaLRltV3FklrtJvs2+KY3zlZ2hN8
	 2JBZJ/EDYRdU5CznnMHS8cRt+a/W20p+DmRwInnvJUKuibA1eg+a6rIDizPLrNOLUB
	 2DXBWn8qAAjiA==
Date: Thu, 13 Nov 2025 18:05:36 +0000
To: Chuck Lever <chuck.lever@oracle.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>, Salvatore Bonaccorso <carnil@debian.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <N14GL1WKSGqrFl8nF0e6sa0QxOZrnrpoC7IZlZ20YqUyfsxpsoqu2W3a31H_GfQv7OEqaEWKwDXdgtAV-xv613w_slTAFZIoyWMutIE5pKk=@tylerwross.com>
In-Reply-To: <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net> <aRVl8yGqTkyaWxPM@eldamar.lan> <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com> <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com> <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 1d0c04c3c03391bfbaad55a148ea3741dbfd938d
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, November 13th, 2025 at 10:47 AM, Chuck Lever <chuck.lever@orac=
le.com> wrote:

> > ls-969 [003] ..... 270.327063: rpc_xdr_recvfrom: task:00000008@00000005=
 head=3D[0xffff8895c29fef64,140] page=3D4008(88) tail=3D[0xffff8895c29feff0=
,36] len=3D988
> > ls-969 [003] ..... 270.327067: rpc_xdr_overflow: task:00000008@00000005=
 nfsv4 READDIR requested=3D8 p=3D0xffff8895c29fefec end=3D0xffff8895c29feff=
0 xdr=3D[0xffff8895c29fef64,140]/4008/[0xffff8895c29feff0,36]/988
>=20
>=20
> Here's the problem. This is a sign of an XDR decoding issue. If you
> capture the traffic with Wireshark, does Wireshark indicate where the
> XDR is malformed?

Wireshark appears to decode the READDIR reply without issue. Nothing is obv=
iously marked as malformed, and values all appear sane when spot-checking f=
ields in the decoded packet.


TWR

