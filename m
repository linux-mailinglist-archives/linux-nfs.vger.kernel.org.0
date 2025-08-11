Return-Path: <linux-nfs+bounces-13551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110AB2099B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E28E7A5F26
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC7E2D3A69;
	Mon, 11 Aug 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G01nxdCy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D33B29E;
	Mon, 11 Aug 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917587; cv=none; b=nhBUp2Y1Kq2Eh84kfP5oruAs9tH3zpZdpRLysS+62LwUIq1ntr7RgIHI1ZbMCj+arCj58kXo//qDTLFn3esZdmkOUJ7ri3K4TIpR/FrMA7Hs7QbV8/QkIUjC5p4rlTmIL7nbity7Vi33TSM8MSi0JvKNv0uuc02BaDlLJDu/hbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917587; c=relaxed/simple;
	bh=Z5VyXkJ/irFT7Ip27n3nft/zmxsewW9pPyMBZlzYdZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UujTjYwi5mddkVgkd/ySrqRlU7DtwcbUTRXQwipbou1sE1LWvTdjq87iCCskoYyYkjxNk4iawuOw7sAqsIBSn2Xhp0PSY4OWkEfCkh0vm9dqrlhf54NCyJoklt8e9+4Kv5d/3ulPyMZI/sc04pQ9vZ28teJVpRgoJ5CsUrBunjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G01nxdCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1CBC4CEED;
	Mon, 11 Aug 2025 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754917586;
	bh=Z5VyXkJ/irFT7Ip27n3nft/zmxsewW9pPyMBZlzYdZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G01nxdCy1p0hp+ZzyOsApBDfdUiWYgSl1kZiY8izi8VQT1zCljK+mn7Doc+vyEtd8
	 ulz3BfPSTgQtN/gv6XF/1h0UQatUKzj3yjCEabzljGmJgNOTkIP05Hg9bhX9Z4vkjV
	 F5Xk9ctkG+Brg8ZfvdKQdUpv63LlqXtBAPNrCN7i4IX7d4JROWCc4MlvGedDJf/WxM
	 jyZ5BTWlCQvTfJBZdQ0QbN0m5/zIJ4lVN9Nr3eWw4AJIQ59+oK+WrOxwaArUeKAAWT
	 eq01kW6KgWMk2gzOrrT1ww6IxxaV/3pks9rw21dPVI2yeY/4u+2vzFI4PEp6xRHdtj
	 +/4fPGuxhpOyA==
Message-ID: <4a2a349225757422f2b0102a2517ba343e32465a.camel@kernel.org>
Subject: Re: [Question]nfs: never returned delegation
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, "zhangjian (CG)"
 <zhangjian496@huawei.com>, 	anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2025 06:06:25 -0700
In-Reply-To: <850dcbf562b7eb5848278937092d2d8511eb648f.camel@kernel.org>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
	 <850dcbf562b7eb5848278937092d2d8511eb648f.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 09:03 -0400, Jeff Layton wrote:
> On Mon, 2025-08-11 at 20:48 +0800, zhangjian (CG) wrote:
> > Recently, we meet a NFS problem in 5.10. There are so many
> > test_state_id request after a non-privilaged request in tcpdump
> > result. There are 40w+ delegations in client (I read the delegation
> > list from /proc/kcore).
> > Firstly, I think state manager cost a lot in
> > nfs_server_reap_expired_delegations. But I see they are all in
> > NFS_DELEGATION_REVOKED state except 6 in NFS_DELEGATION_REFERENCED
> > (I read this from /proc/kcore too).=20
> > I analyze NFS code and find if NFSPROC4_CLNT_DELEGRETURN procedure
> > meet ETIMEOUT, delegation will be marked as NFS4ERR_DELEG_REVOKED
> > and never return it again. NFS server will keep the revoked
> > delegation in clp->cl_revoked forever. This will result in
> > following sequence response with RECALLABLE_STATE_REVOKED flag.
> > Client will send test_state_id request for all non-revoked
> > delegation.
> > This can only be solved by restarting NFS server.
> > I think ETIMEOUT in NFSPROC4_CLNT_DELEGRETURN procedure may be not
> > the only case that cause lots of non-terminable test_state_id
> > requests after any non-privilaged request.=20
> > Wish NFS experts give some advices on this problem.
> >=20
>=20
> What should happen is that the client should issue a TEST_STATEID and
> then follow up with a FREE_STATEID once it's clear that it has been
> revoked. Alternately, if the client expires then the server will
> purge
> any state it held at that point. The server is required to keep a
> record of these objects until one of those events occurs.
>=20
> v5.10 is pretty old, and there have been a number of fixes in this
> area
> in both the client and server over the last several years. You may
> want
> to try a newer kernel (or look at doing some backporting).
>=20
> Cheers,

No. If you get an ETIMEDOUT, then it means you are doing soft mounts or
softerr. The client will not follow up with TEST_STATEID or
FREE_STATEID.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

