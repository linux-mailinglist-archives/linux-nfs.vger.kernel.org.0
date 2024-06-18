Return-Path: <linux-nfs+bounces-4003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A2990DCA2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EFE1F22ED4
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 19:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B016CD2F;
	Tue, 18 Jun 2024 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCxHRHuz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE816CD22
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739526; cv=none; b=a1clF+W9YtDI51VXALooHiO6izjAMHEnlSilXA9Y5iMgYjEMqzcyUi2HiLXhEavIE+ZOWEZkfCcyLy5TWsxbJ/dVI2g1xmYQKFkeP3i3L5wPi3HNaToYwNMR8ZG5BX+CCYCOgre2/cZ2aMV08KTnGdfxceEcAYuX8NRXObKzg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739526; c=relaxed/simple;
	bh=++kbzjL3kfBTMZPmowAy+ylUDhygZYob4E/zkcNFvBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ay2ZzxXM5hW7fDXlN3TrEetu+5fmBvdk04wzwGN3hjSz9QjB9xudj91OZJG+bAinMURWbQJ+M2nxlrhBsAs+XYIg+YdYhunRZxFU70ZBSmDfRb7BYY8+uebgrConXV8vv5WZt28j7sZ7Jbu3vUBIOyh/8F+uOIwkuySmVZ5IH6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCxHRHuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFEEC3277B;
	Tue, 18 Jun 2024 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718739525;
	bh=++kbzjL3kfBTMZPmowAy+ylUDhygZYob4E/zkcNFvBo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HCxHRHuzt4IdI+9JJv5Gv/nlMDEloPGBdNi9sDpkn7wfy/OnOwgJJ7iX8NR/8B2kd
	 ApK/KVNi2YBCi9XvYSXj+kxSkQr8ZzwMA4Cf7tNX0ONy6SkVBoa9PBrpzZk9N9Ltdu
	 8K2dkKUkrm915cOjXk+1cpS0p2LD/H9jKYKfbBO2blq2wX+LyRv1Q3myFf5tBoS0eH
	 exVeOsgfp3/wf0o3ptQ+iXLwPLrD6vWC7PNC06prtFqtkV4us0sKpGmPZTKJmVuP17
	 YJnpWB072G9UFsz/1yUTeyPDOgPTcU3q53EEdWVpsj+TKKbxLSYBRQor5DNZs5cjE8
	 Cx2LSO6qEKXCA==
Message-ID: <a59ede76404c0f38f684475f1fe44f895f6bda80.camel@kernel.org>
Subject: Re: knfsd performance
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>, "neilb@suse.com"
 <neilb@suse.com>,  "Chuck.Lever@oracle.com" <Chuck.Lever@oracle.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date: Tue, 18 Jun 2024 15:38:43 -0400
In-Reply-To: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 18:32 +0000, Trond Myklebust wrote:
> I recently back ported Neil's lwq code and sunrpc server changes to
> our
> 5.15.130 based kernel in the hope of improving the performance for
> our
> data servers.
>=20
> Our performance team recently ran a fio workload on a client that was
> doing 100% NFSv3 reads in O_DIRECT mode over an RDMA connection
> (infiniband) against that resulting server. I've attached the
> resulting
> flame graph from a perf profile run on the server side.
>=20
> Is anyone else seeing this massive contention for the spin lock in
> __lwq_dequeue? As you can see, it appears to be dwarfing all the
> other
> nfsd activity on the system in question here, being responsible for
> 45%
> of all the perf hits.
>=20
>=20

I haven't spent much time on performance testing since I keep getting
involved in bugs. It looks like that's just the way lwq works. From the
comments in lib/lwq.c:

 * Entries are dequeued using a spinlock to protect against multiple
 * access.  The llist is staged in reverse order, and refreshed
 * from the llist when it exhausts.
 *
 * This is particularly suitable when work items are queued in BH or
 * IRQ context, and where work items are handled one at a time by
 * dedicated threads.

...we have dedicated threads, but we usually have a lot of them, so
that lock ends up being pretty contended.

Is the box you're testing on NUMA-enabled? Setting the server for
pool_mode=3Dpernode might be worth an experiment. At least you'd have
more than one lwq and less cross-node chatter. You could also try
pool_mode=3Dpercpu, but that's rumored to not be as helpful.

Maybe we need to consider some other lockless queueing mechanism longer
term, but I'm not sure how possible that is.
--=20
Jeff Layton <jlayton@kernel.org>

