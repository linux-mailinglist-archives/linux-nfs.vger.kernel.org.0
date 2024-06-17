Return-Path: <linux-nfs+bounces-3914-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3BD90B73F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338D8B328D0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6822B9B9;
	Mon, 17 Jun 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQRMXNHX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0FD53E;
	Mon, 17 Jun 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639112; cv=none; b=fJPulxGvR/2TSGWOkGGgaqnZ4xrm+we1gy01YBxCIIdEPR9fqiHGvEk645TCbIYTdLHg3e+sV7j4OrWe3KW1zZO/t9dtLFxvCZBZaigz3OhQ3oNVgU7UTPGojUJq6vYCE1bEOQqwFAFeUrBc0DSPU38xktuGWcpZRK8TE7/MW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639112; c=relaxed/simple;
	bh=zPno5OkucR9cTYw6c/LOvzB8+WqVlvwJsJ9jPDFqKbM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4SEnHZVfrMhukI5JGx9haxwSRg+xZR7X8+peukOYZ79/XATjBB4ka/8cR+ZcspvX7mVUPR0wx5QyqVVoKXFe3V1Se20OQUvyZuvMDrkdAi4DHVgNyCDBXTBWzdxFEFLHjGtKiwi/9DU57GsxobXsI6NADiGRTUbMer+/CxlTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQRMXNHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EE7C4AF1C;
	Mon, 17 Jun 2024 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718639111;
	bh=zPno5OkucR9cTYw6c/LOvzB8+WqVlvwJsJ9jPDFqKbM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oQRMXNHXy6qIvw/CA3RCIXXyyV5QB541KmxirHp0anWVZtCe1nRf5Fav4cQvxt+um
	 T0J5VwIqzDtDrmIU1M31KrLozzk+bgZcI2K7StQdQNaKJLEKAbUns8xPTJUjRPmF5i
	 NSF9tR9bDD47csdq3x25oKBOqF0Nm/Iu9/W8OAKeKHogqKIi2Syx7UafOTDPQd6w2S
	 ZcO8VIE0iE1VUBth+T09HUlu9dxPkxrNlW9g+M6cKB8oYTSBCqru8g4hfgGboM7B40
	 uMD6Iv4tCuydaBT1CE5Whi1gSa1roEoLoJuoaXO4OwCI+dA6/5Ellc1ugbn6hq+XCt
	 +snFKOvsyplPA==
Message-ID: <6180646a59df90da1b365605b6e0d5a55f47c4c6.camel@kernel.org>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
From: Jeff Layton <jlayton@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>, 
	Dai.Ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 17 Jun 2024 11:45:09 -0400
In-Reply-To: <20240617075129.7cb9ad1d@kernel.org>
References: <000000000000322bec061aeb58a3@google.com>
	 <1e36e3c4e4ee1243716f0da5f451ea15993a7e82.camel@kernel.org>
	 <20240617075129.7cb9ad1d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 07:51 -0700, Jakub Kicinski wrote:
> On Mon, 17 Jun 2024 06:15:25 -0400 Jeff Layton wrote:
> > We've had number of these reports recently. I think I understand
> > what's
> > happening but I'm not sure how to fix it. The problem manifests as
> > a
> > stuck nfsd_mutex:
> >=20
> > nfsd_nl_rpc_status_get_start takes the nfsd_mutex, and it's
> > released in
> > nfsd_nl_rpc_status_get_done. These are the ->start and ->done
> > operations for the rpc_status_get dumpit routine.
> >=20
> > I think syzbot is triggering one of the two "goto errout_skb"
> > conditions in netlink_dump (not sure which). In those cases we end
> > up
> > returning from that function without calling ->done, which would
> > lead
> > to the hung mutex like we see here.
> >=20
> > Is this a bug in the netlink code, or is the rpc_status_get dumpit
> > routine not using ->start and ->done correctly?
>=20
> Dumps are spread over multiple recvmsg() calls, even if we error out
> the next recvmsg() will dump again, until ->done() is called. And
> we'll
> call ->done() if socket is closed without reaching the end.
>=20
> But the multi-syscall nature puts us at the mercy of the user meaning
> that holding locks ->start() to ->done() is a bit of a no-no.
> Many of the dumps dump contents of an Xarray, so its easy to remember
> an index and continue dumping from where we left off.

Understood, thanks. I wasn't keyed into the fact that ->start and -
>done weren't always called in the context of the same syscall. In that
case, I think we have no choice but to move the locking into the -
>dumpit routine. I believe Lorenzo is drafting a patch along those
lines.
--=20
Jeff Layton <jlayton@kernel.org>

