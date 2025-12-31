Return-Path: <linux-nfs+bounces-17363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D0CEAF64
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 01:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 034C83008477
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 00:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EF19E819;
	Wed, 31 Dec 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="et+nASBk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xbSr43/S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0419F13F
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767140893; cv=none; b=ruo9yCva30h+jgOyIuKyxjktMSivqiAeWP/I3bKahTl3RAOT/aOxb44Ui5OuTWKFSCzz4r2TCvuKZpcRN67dOUEY2PmBwz71jGJdA+12mQiG1i/ku4/9/cxDRa++roc3aJC9uSrj9wmV8bKAm+5yFF6+iWu42D0VPxpRJDp3IP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767140893; c=relaxed/simple;
	bh=aDvARoBvcVfWcH2pZ6y6thyEpLPQjXvX71PHWY6gtLk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=K6WpP4SEg0MR4qeXvi6vb/cOqpiYjlVNStyc1iaQxrZzp68ce+ziMZxpTS3UBUy9QYZGsvLk3c/ks8lfxfu+IJ1lW4zEvpWIWIM3prTP84gKP93vYsupnH4awNJrLmZhsoMP6mYbsy2Gmo6NmfDpW8UXOxJBgkIFr51IECqY9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=et+nASBk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xbSr43/S; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C9E0EEC00CD;
	Tue, 30 Dec 2025 19:28:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Dec 2025 19:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767140890; x=1767227290; bh=7W79QEKY5pm9nMxJEVsXYtFVvTBQ8wyuuZf
	i8P6G/qc=; b=et+nASBkPBaIXDBwWY2O4NspytXsCbvtXjhmZ1nrXMk/LwRq/MT
	6I/Fm2SmeGZk7EPi0m3oSd8MhQXG27H9q5Bl9FpuJpjpETQrzFXj+Uw3utSgWgca
	3xNmjsME94ZQ4fbw3kFUyO4bWX/g+N3gd2yw4TKfQggaCHRzTo/WLB2SbOzBI6Va
	fWNHz2dvRUQm/UBHQqXim518PnOPjhujGgdS7HDcZ4muc3cc3Qrs/Qy0AgmmDldX
	TdQWhBXmas6WkYEEt2zyp1dwbWuJUYg1cEDfXw6tgQoqtCgmC4jjwQKvUsFZuA0d
	uzfUNEswmef7tH98iK770y5OMjJ1/UtcsDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767140890; x=
	1767227290; bh=7W79QEKY5pm9nMxJEVsXYtFVvTBQ8wyuuZfi8P6G/qc=; b=x
	bSr43/S3BAC9n9TXBMqdeJGC1HZ2LexBaOmKpHIUUUED8Jxa8s101sBf7T70KjAo
	D6T4NShC3wqXYwIlMwF+o7jQfUJaZt2957n9oEIHDdKHD64Yd0D5Z3OpgAwwNCgB
	ta6CQex7nscD11Rre7OM7RYb4tScyM5D/lu1u/7A7S+emgcC8JIY79gzdxLnrkyW
	KyuYfeIIvS4revVH52YTCgVEynsxkIzezNpL9yEXUtrn4Jw7k8MGQn+tAKf6oeUt
	ON1pRoB4eb1YbLlQ69doTSSg5nY5xXQuKjfonCaZUFRvubH9eP7Mc+O18jHEcGOL
	ZSBxzmgNj3CpRULfbHs0Q==
X-ME-Sender: <xms:Gm5UaWPqanUePrkx0yQyDUuvSOD_iW3DR9F-frAtHnmUaFVd9co4Aw>
    <xme:Gm5UaXPCLPka4vNfn527M24TSObB2ZLP520R0IXGgiXIG5v_OQn4aJp-c8Yfc_t5_
    kG4WBqnVXsaZoxr-npxl_FjRl5yWhyBY5jXa_RbZ7bE7AZLsg>
X-ME-Received: <xmr:Gm5Uafj4CTZVQTgnKbuLFxR-mnq2UqM6Mx3w06iYbtrVXKe4HK6wJ6QZPcjwOcNw-vOdNUM1Q_Uhz9OxKevO_nC18xoMKe9hSKo0Gd3WTabN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Gm5Uacs_PRu37unH-JGL0GTPie3e9lKaVtbEL45ptgjTyEvtPavPIw>
    <xmx:Gm5UadRfPcFoTV1viH5-6_gGbOkeJzJ1ZeaZ-86mmjyeTdO4hW7nmw>
    <xmx:Gm5UaQ2l9-yJ0HbnqDqbBYL83KG-oy97ufaQEBPy8dSO_HeqUWjfvw>
    <xmx:Gm5UaStQkUXcglbs16_u2ABYXXjIsgY8alHzosSJcjgMIPQ4JrD7ZQ>
    <xmx:Gm5Uae6VB2Cqco_nxNEPwrj68r74GDRMhkvc-8SqgHn_KrdQZNTCNZPE>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 19:28:08 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v1 0/5] Automatic NFSv4 state revocation on filesystem unmount
In-reply-to: <20251230141838.2547848-1-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>
Date: Wed, 31 Dec 2025 11:28:06 +1100
Message-id: <176714088647.16766.1296067005074563041@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 31 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When an NFS server exports a filesystem and clients hold NFSv4 state
> (opens, locks, delegations), unmounting the underlying filesystem
> fails with EBUSY. The /proc/fs/nfsd/unlock_fs interface exists for
> administrators to manually revoke state before retrying the unmount,
> but this approach has significant operational drawbacks.
> 
> Manual intervention breaks automation workflows. Containerized NFS
> servers, orchestration systems, and unattended maintenance scripts
> cannot reliably unmount exported filesystems without implementing
> custom logic to detect the failure and invoke unlock_fs. System
> administrators managing many exports face tedious, error-prone
> procedures when decommissioning storage.

Thanks for working on this.  Making automated workflows more reliable
is certainly a worthy goal.  It has been explored before but never got
to a working state.  Hopefully this time it will.

> 
> The server also provides no notification to NFS clients when their
> state becomes invalid due to filesystem removal. Clients continue
> using stale state until they encounter errors, potentially
> corrupting data or experiencing mysterious failures long after the
> underlying storage disappeared.

I don't understand this claim.  You code uses exactly the same internal
mechanisms, which trigger ADMIN_REVOKED errors to the extent supported
by the protocol (v4.1 does this better than v4.0).
How is this para relevant?

> 
> This series enables the NFS server to detect filesystem unmount
> events and automatically revoke associated state. The mechanism
> uses the kernel's existing fs_pin infrastructure, which provides
> callbacks during mount lifecycle transitions. When a filesystem
> is unmounted, all NFSv4 opens, locks, and delegations referencing
> it are revoked, async COPY operations are cancelled with
> NFS4ERR_ADMIN_REVOKED sent to clients, NLM locks are released,
> and cached file handles are closed.

As I said in response to the relevant patch, I think you aren't catching
umount, only "mount -o remount,ro"

You said there are lock-ordering problems with revoking state from a
unmount-time callback.  Maybe can initiate the unpin callback from
somewhere else, before those locks are taken?

Thanks,
NeilBrown


> 
> With automatic revocation, unmount operations complete without
> administrator intervention once the brief state cleanup finishes.
> Clients receive immediate notification of state loss through
> standard NFSv4 error codes, allowing applications to handle the
> situation appropriately rather than encountering silent failures.
> 
> Chuck Lever (5):
>   nfsd: cancel async COPY operations when admin revokes filesystem state
>   fs: export pin_insert and pin_remove for modular filesystems
>   fs: add pin_insert_group() for superblock-only pins
>   nfsd: revoke NFSv4 state when filesystem is unmounted
>   nfsd: close cached files on filesystem unmount
> 
>  fs/fs_pin.c            |  50 ++++++++
>  fs/nfsd/Makefile       |   2 +-
>  fs/nfsd/filecache.c    |  39 ++++++
>  fs/nfsd/filecache.h    |   1 +
>  fs/nfsd/netns.h        |   4 +
>  fs/nfsd/nfs4proc.c     | 124 +++++++++++++++++--
>  fs/nfsd/nfs4state.c    |  44 +++++--
>  fs/nfsd/nfsctl.c       |  11 +-
>  fs/nfsd/pin.c          | 272 +++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/state.h        |   9 ++
>  fs/nfsd/xdr4.h         |   1 +
>  include/linux/fs_pin.h |   1 +
>  12 files changed, 537 insertions(+), 21 deletions(-)
>  create mode 100644 fs/nfsd/pin.c
> 
> -- 
> 2.52.0
> 
> 


