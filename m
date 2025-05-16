Return-Path: <linux-nfs+bounces-11784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC9CABA68D
	for <lists+linux-nfs@lfdr.de>; Sat, 17 May 2025 01:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AF2A00227
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92527FD71;
	Fri, 16 May 2025 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th0Te/dT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B958237176;
	Fri, 16 May 2025 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438039; cv=none; b=G4MGwk1gS1GaBwr3KU56MTiwgaDvzhxd1HJc+fscuU4YhfZYSvRfFXxaJdLguDsRpMREcgezvQPoMLkKvKDxemqPTBiUKATBfhLPbJidPvE/vcvvs5tbEFE9+a8iwPYrh8fCbUdP27BAG/0LW32H0ZAqhkQ7puPSgq52cdRhgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438039; c=relaxed/simple;
	bh=GwcbTMr0kPAvM4fbL9ENzctYnJzwYdCactN7buZzrXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNAqUKGg7AY6ClqzIoaRNiyuXDEs8DetAWIdtzlYKovj3MMkXhgyMaeWBD5WdFsTdvJnR1iY6ZJauCDW3TIiY1fR5H1r8Fm5IPasfeeu8Jv7AELZuNxemAm06gU+HCyTHi/Z6oRxoNgPfDOeJoS39ttjRo024cqCZMqpmZBHzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th0Te/dT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11D9C4CEE4;
	Fri, 16 May 2025 23:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747438037;
	bh=GwcbTMr0kPAvM4fbL9ENzctYnJzwYdCactN7buZzrXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Th0Te/dTtSUEtHKsMPU8aSEqAd8guNulh0AkI1F6yfbi4ycwoHhwzC/Yuyioih42k
	 1a0bG1QspQQfjYUO6iid4ulDwa8IU7PoU18FLscNmNX71/ARtUa2gr+MoonAvqIq4f
	 I+03qGd5hj8o0a3Btv1AtFaiGSincgT7s/iGH7SDqhZYq6fcLiJNuykejwMJ/UNF09
	 9hPII5f9LsHGwfxLgLfDcHlhDzCOe0tl6lm2whDmyO/zXnEyI5y96Si8rOpNMTHtRR
	 HUzcLKZKzaueSgi8pg+L3aPrjDwGdUgf11tVzpuUsUP++yyNHYqhVGDVQx6GuMUH0b
	 jfaSuql5FuCDQ==
Date: Fri, 16 May 2025 16:27:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, Steve Sears <sjs@hammerspace.com>, Thomas Haynes
 <loghyr@hammerspace.com>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, kernel-tls-handshake
 <kernel-tls-handshake@lists.linux.dev>
Subject: Re: RPC-with-TLS client does not receive traffic
Message-ID: <20250516162716.340fb97c@kernel.org>
In-Reply-To: <7014c4fa-fa99-45d4-9c3b-8bf3ff3f7b38@oracle.com>
References: <0288b61b-6a8e-409d-8e4c-3f482526cf46@oracle.com>
	<20d1d07b-a656-48ab-9e0e-7ba04214aa3f@oracle.com>
	<62cbd258-11df-4d76-9ab1-8e7b72f01ca4@suse.de>
	<7014c4fa-fa99-45d4-9c3b-8bf3ff3f7b38@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 11:05:21 -0400 Chuck Lever wrote:
> >>> The first tls_data_ready call then handles the waiting ingress data as
> >>> expected.
> >
> > I _think_ you are expected to set the callbacks prior to do the tls
> > handshake upcall (at least, that's what I'm doing).
> > It's not that you can (nor should) receive anything on the socket
> > while the handshake is active.
> > If it fails you can always reset them to the original callbacks.  
> 
> It looks to me like the socket callbacks are set up correctly. If I
> apply a patch to remove the msg_ready optimization from tls_data_ready,
> everything works as expected.

The thinking is that we can stop reporting "data ready" once we have 
a data record, because reader must check for pre-existing data when
starting to monitor the socket. I suspect when you say "everything
works as expected" you mean that the next chunk of data coming in
wakes the reader and reader catches up?

Could you point me to the exact code path that handles the callback
installation? Does it handle a socket with data in rcvq already?

