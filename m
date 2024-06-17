Return-Path: <linux-nfs+bounces-3910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E690B41C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E7528E0CD
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99D16CD1F;
	Mon, 17 Jun 2024 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRpVuwzs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138001581F4;
	Mon, 17 Jun 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635891; cv=none; b=eKG8/shccYXlIp2UEokmMCXqWKncu5pIeAoahTLaBUPbXoSjBv2DYxPBzZZYsr32mrLFkT3J9T3mtd8LnnEE/BixoAYVQq9mNd1NXqX/5GMNZp0gzy11cp0o4O/OyOXpEatP4nuwvsjtcVqYMoNK8L7gcnzTyJ48PTG/mrzD/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635891; c=relaxed/simple;
	bh=zZrXRYZGgB4Eo2yvoczR82kplFnacMGTB93xIv9WowM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcJkDFW6yditcMi8NBQTSsv2qR5WSFz+7p13UV1UonIXTlxLvbzMr5bRlOEQx08O4R8NYebwYDBMobBPQsmv+Bq+A+WjT9GnCZ33is+uCcxafXHL4fZ1C3pV4Kvr5K45B4KmzeGZa9JIb0mVsOQGRNhVzX+tQFqcbYlHnZvXd0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRpVuwzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E46CC4AF1C;
	Mon, 17 Jun 2024 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718635890;
	bh=zZrXRYZGgB4Eo2yvoczR82kplFnacMGTB93xIv9WowM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tRpVuwzsVkVidVECWcgbG23xQ77R+wxwfYAsWGMsv49qyCzDX95m2rIU1F65eVDPi
	 EGCIDE7Gs1aSsp5baF3nQkd40aPL6AUFS58BJcxEdWvjKNbNF/CxhSOVQCTDE0Hx63
	 PqBC5R1bTyKOSuImnMp8nfqzoZfnT1e8nKLEpNwuGLyw4lYTZ6TCdEcrRfnmqLkEEY
	 1COsDew6+dyDiMJBZeuB+b91gLOtL9HBxze/KIBXYWxWfiIT1+m94wRe1Ehef74kuK
	 h/ubkTeRkBe6r0kwEbInZLkGzqNT+04ige/PMWdjAFtEnZx86V1ffobPOSJwwzaIae
	 dNh/Xb7YTFNfg==
Date: Mon, 17 Jun 2024 07:51:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: syzbot <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>,
 Dai.Ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de,
 syzkaller-bugs@googlegroups.com, tom@talpey.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
Message-ID: <20240617075129.7cb9ad1d@kernel.org>
In-Reply-To: <1e36e3c4e4ee1243716f0da5f451ea15993a7e82.camel@kernel.org>
References: <000000000000322bec061aeb58a3@google.com>
	<1e36e3c4e4ee1243716f0da5f451ea15993a7e82.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 06:15:25 -0400 Jeff Layton wrote:
> We've had number of these reports recently. I think I understand what's
> happening but I'm not sure how to fix it. The problem manifests as a
> stuck nfsd_mutex:
> 
> nfsd_nl_rpc_status_get_start takes the nfsd_mutex, and it's released in
> nfsd_nl_rpc_status_get_done. These are the ->start and ->done
> operations for the rpc_status_get dumpit routine.
> 
> I think syzbot is triggering one of the two "goto errout_skb"
> conditions in netlink_dump (not sure which). In those cases we end up
> returning from that function without calling ->done, which would lead
> to the hung mutex like we see here.
> 
> Is this a bug in the netlink code, or is the rpc_status_get dumpit
> routine not using ->start and ->done correctly?

Dumps are spread over multiple recvmsg() calls, even if we error out
the next recvmsg() will dump again, until ->done() is called. And we'll
call ->done() if socket is closed without reaching the end.

But the multi-syscall nature puts us at the mercy of the user meaning
that holding locks ->start() to ->done() is a bit of a no-no.
Many of the dumps dump contents of an Xarray, so its easy to remember
an index and continue dumping from where we left off.

