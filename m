Return-Path: <linux-nfs+bounces-13055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB58B044B9
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D861885999
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94E23BF9B;
	Mon, 14 Jul 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5YpVZKJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36025A65A
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508194; cv=none; b=k+mqRrF6DKj9A+GQD6w+h7BcKBnPnI9OmmWxFLkcvS8YaMrTksl9snW7sAi80i16Ij0uubPJ8tPg7CbEiTyZ5gS8UMNXCzLl61y7ZUkZFnGEpX7Ys/3XbxPXJerXlf6c6sEt2mJVgYeuhU0Xsml1PqtCUnFl4ZToylYK5J7Bp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508194; c=relaxed/simple;
	bh=CULFYzMnAF4+qcJ6/QYrsyxWiH9GIbqerOD02NKX550=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8PySslPsp/QvZICIiPEzToOnSMxP0IapI/o4y/VgjLRZbhwjAkILdI6y52LWQDKVLfWkiXc+8/UjoLR5rB77Vd71zvU4368l6XviFm8HncjUtO5MxiyVZNbuuT3+qss8vhyvQDLdUF7sPey15PDY2z9DAZA8y5FwaETr8/Bxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5YpVZKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F160C4CEF5;
	Mon, 14 Jul 2025 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752508193;
	bh=CULFYzMnAF4+qcJ6/QYrsyxWiH9GIbqerOD02NKX550=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=k5YpVZKJTQkAGN9TNx6vc5B6PcGYPDG2HzjKsSUcomIalnn0YIJZ0+NO85KwcCyAc
	 fneKo4Cl6PcdSULKhAVNC4zquUbpoZzgm8XjfiCik5WruKek4izx9NofMRrshs25jD
	 DlpCdaqQnwmLe9jp4iaespO5Ef14JagL0qlnlSnFHcp/PQ0T5OCRq2NUhcTaZfPfu/
	 JAV8/wwg5oDIZSGuSbqm2SC97WTSbih5z44FEZGqp6uzPvKtkUVpdIxlyvMl2S6jgS
	 LUVOMLvTi+2DFiz1ufcoY5lH9tOy3q5M+ZNR9ZCzGbPFVLzxWKWKpss1/q55ofnaDv
	 PSKRaB0Cfy1Sw==
Message-ID: <7045a21c6fb5c98c6b86754880589ce1fc5ec049.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFS: add a clientid mount option
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Date: Mon, 14 Jul 2025 08:49:51 -0700
In-Reply-To: <6b5de853-b283-4b5e-9628-fd0b50d7645c@oracle.com>
References: <20250714063053.1487761-1-hch@lst.de>
	 <20250714063053.1487761-3-hch@lst.de>
	 <cf337014-f8a6-44d6-8760-61663fef576d@oracle.com>
	 <20250714133135.GB10090@lst.de>
	 <6b5de853-b283-4b5e-9628-fd0b50d7645c@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-14 at 10:47 -0400, Chuck Lever wrote:
> On 7/14/25 9:31 AM, Christoph Hellwig wrote:
> > On Mon, Jul 14, 2025 at 09:24:20AM -0400, Chuck Lever wrote:
> > > On 7/14/25 2:30 AM, Christoph Hellwig wrote:
> > > > Add a mount option to set a clientid, similarly to how it can
> > > > be
> > > > configured through the per-netfs sysfs file.=C2=A0 This allows for
> > > > easy
> > > > testing of behavior that relies on the client ID likes locks or
> > > > delegations with having to resort to separate VMs or
> > > > containers.
> > >=20
> > > The problem with approaches like this is that it becomes
> > > difficult
> > > to manage multiple mounts of the same server. Each of those
> > > mounts
> > > really cannot have a different clientid.
> >=20
> > Having different clientids for multiple mounts from the same server
> > is the purpose and only reason for this option.
>=20
> It would be helpful to explain exactly what test you are trying to do
> or
> what bug you are trying to explore. I can't think of a way that the
> current client code base would ever need to behave this way. So I
> assume
> you are trying to test some kind of server behavior. If that's the
> case,
> why not craft one or more pynfs test cases? (Or, maybe pynfs already
> handles this case).
>=20
>=20
> > > For testing, why can't you use the per-container clientid
> > > setting?
> >=20
> > Because having to create a container is a lot of effort when all
> > that is needed is just a mount with a different clientid.
>=20
> Since this is for development testing (?) I am hesitant to endorse
> adding it as part of the everyday administrative interface.
> Especially
> since this will break things (on purpose, of course). I don't relish
> having to support administrators coming to us complaining that some
> unimagined future use case is not working with the clientid=3D mount
> option.
>=20
> If clientid=3D does get merged, though, what is your plan for an nfs(5)
> update?
>=20

There is a lot of potential for tripping over your own shoelaces with
this mount option.

I can't think of any circumstances where an ordinary user should need
to set a different client identifier depending on the server. I too am
therefore sceptical that anyone will need this functionality other than
for kernel development purposes. It requires very deep knowledge of the
NFSv4 protocol both to understand what it does, and to stay out of
trouble when using it.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

