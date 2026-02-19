Return-Path: <linux-nfs+bounces-19039-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEV9Hc1tl2nxyQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19039-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 21:08:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DC31623DD
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 21:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B00C33014C53
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6454B2D8370;
	Thu, 19 Feb 2026 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7PBT6IH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41937212F98
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531721; cv=none; b=eyfDO2Uayu4bHoXPFntZ/8eSWnimqyqEOBuQHmUMcMul5qsBq7qfTk57zFD6teYjlmmBndvVdh+STXiLug51Zf6W6KhAWb5N5YTRHkd5h8tqqG26/+iJqs7Nc6LySs8OiFurckCiwSE+754lJWhFDmMQIk5MrCTiC6F+2iyH06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531721; c=relaxed/simple;
	bh=I/qLJ3Mi7FAHSplOjTZTwAMLoPz2pSt6JBmXwfP7bBM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HhOcfv7I/xbJsiUJ8PKCqi2HOrCVt7LQmztWZmRkk7NBYtvX1s21NRZXbuqD0wJ4xJbFt8GS/pZA3q7UIeq+JSdgFayBj14UAvAcWoWzLejk1Pv+kBG1X9zP1DMxVh4k/0RD2rZvbYre+k4i+ABxK53RNcC+LE2bkbjgITyj/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7PBT6IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE60C19423;
	Thu, 19 Feb 2026 20:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771531720;
	bh=I/qLJ3Mi7FAHSplOjTZTwAMLoPz2pSt6JBmXwfP7bBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=K7PBT6IHMyOg/pXc5DroOARyd2oZDMJRzWj5gCyrgFEmRwu4XFYKApYx7KFHqYRA9
	 gyVI9YoAwJYs3fpJMbeJr0UhN4yXrC5wQMJXxfTUaUCXQ8sjJkoZnEnlpLwwRDYOhO
	 1QGWyc8Gifv4UtOPQ2do0mbJK+TKgtyiVD8JYRaPoeENLCDjQNmDd27UdzkMWmq69+
	 05BUItIXXL7EkhWnjFkw7mq8zxTK7GCIMdfLewqoVeUXjqMtR4T+kctAH/ds/e1XMO
	 j9XRFYrrNXqQNGOpxIo5bghnlJ0ijacIy3DwCk8VjB63anfoQjFheeta21QQW/2YG1
	 opMVHY3uhG+sw==
Message-ID: <00f3d1fe8b61410ad2296d76f0603a51e8e9991b.camel@kernel.org>
Subject: Re: [PATCH 1/1] pnfs: improve "Server wrote zero bytes" error
From: Trond Myklebust <trondmy@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: "okorniev@redhat.com" <okorniev@redhat.com>, "anna@kernel.org"
	 <anna@kernel.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date: Thu, 19 Feb 2026 15:08:39 -0500
In-Reply-To: <CAN-5tyFec2nw1=1-wsGYj4TnXmSbw4p+qW_1v9sPD+nPKiP1Gg@mail.gmail.com>
References: <20260219192327.34732-1-okorniev@redhat.com>
	 <c6be70378ce90b3316c997bfc9443172eaa145c5.camel@hammerspace.com>
	 <CAN-5tyFec2nw1=1-wsGYj4TnXmSbw4p+qW_1v9sPD+nPKiP1Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19039-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email]
X-Rspamd-Queue-Id: C6DC31623DD
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 14:44 -0500, Olga Kornievskaia wrote:
> On Thu, Feb 19, 2026 at 2:40=E2=80=AFPM Trond Myklebust
> <trondmy@hammerspace.com> wrote:
> >=20
> > Hmm... Is this needed? Shouldn't the test for task->tk_status < 0
> > in
>=20
> task_status is 0 when it gets to nfs_writeback_done because in
> filelayout/filelayout.c in filelayout_reset_write() is doing this
>=20
> task->tk_status =3D pnfs_write_done_resend_to_mds(hdr);
>=20
> > nfs_pgio_result() ensure that we can't call nfs_writeback_result()
> > in
> > the above case?

Oh... So isn't the hdr->pages list actually empty? Should we even
bother entering the short write condition when that happens?

IOW: Why not just change that test at the top of nfs_writeback_result()
to read something like

	if (resp->count < argp->count && !list_empty(hdr->pages)) {


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

