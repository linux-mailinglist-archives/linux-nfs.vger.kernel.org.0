Return-Path: <linux-nfs+bounces-20681-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGVANmYe1GmJrQcAu9opvQ
	(envelope-from <linux-nfs+bounces-20681-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 22:58:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 333923A75AC
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 22:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A18303AB4F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 20:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CBD2F5A36;
	Mon,  6 Apr 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuG89PEM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66602BE65B
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509091; cv=none; b=puG7meHWP90CjGJL9piZWOXGYRxYbXtByUiv9sqFVB+HAI6/AAXZ+bXaoJPRxpP6a3boZZCXZW/qPHN61S7bJVZR5I0L3e10dfAKWsvDst51rjLHMyGCJAx+LaetRbUi75IqFf3WxLltXWtNrQOABSukrCCMtxhs7i6GT3/pO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509091; c=relaxed/simple;
	bh=1AoFkcJWucrajjbAU1v4ZU0q4qaM4sneGhJsbq+usS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9T87jjLvHFqNXO3HGYTbaPiu3hewH97g5LxSiNMGC1bnQ8YNXIsv8HFkqhu05eUdPvRKaQTrVte/U15dMOuVR+M6OZNmI3ZoY0czDmcVjadeQuDT2AiWaz1Y+Om4u7+f3bZ/qQFoFolQJJ2k3Ayq0omERMmRfqt4umt3/yn7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuG89PEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210C1C4CEF7;
	Mon,  6 Apr 2026 20:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775509091;
	bh=1AoFkcJWucrajjbAU1v4ZU0q4qaM4sneGhJsbq+usS0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LuG89PEMqTD1/h37czopm3+KhfhDzA/iRL821TWTwtzp31rKrFT8elQK4mSmFWKKb
	 rehh0DE7IO9cyyN2ECC0lqXVnjFvCxylr2POO8uy5PSZcrQ6+azkwM0zUZSkqxb6pK
	 R5GtLvhPxwKi/VUkaxIqZ8IuBoVwVxYSSUwaDeeUZhm5ntFXkOoL1oBOaqtR24lNON
	 dAky8fwrRjEqj+5LL0GWYRAn5w50arBWhzAfnDyHi1UTp5AATQfZ3tW6djgpfFnvFi
	 /6yueLhNVq+/4qvFLd6pbPPQ7HFujvOfuvLO/nxivvj60Lx72VwPmhH7aRzw0xzUS4
	 1TfVwtYgBY9gA==
Message-ID: <5b6c25a9f1d8d0f8c9a1fe8f7bf83f749aeacc20.camel@kernel.org>
Subject: Re: NFS close does not block when server is unavailable
From: Trond Myklebust <trondmy@kernel.org>
To: Jon Curley <jcurley@purestorage.com>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 06 Apr 2026 16:58:10 -0400
In-Reply-To: <CAHeb9+nedZXHXzeCQOo5tJ_kYAYC=sVrzNEtGBACmQKEis4mJA@mail.gmail.com>
References: 
	<CAHeb9+nedZXHXzeCQOo5tJ_kYAYC=sVrzNEtGBACmQKEis4mJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20681-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 333923A75AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jon,

On Mon, 2026-04-06 at 08:36 -0700, Jon Curley wrote:
> Hi Trond,
>=20
> We've recently been investigating test failures in our automation
> linked to server failures. What we've noticed is that failures during
> WRITE do not block close(). Close simply returns success even though
> the writes are in a failure loop.
>=20
> This is easy to reproduce using flexfiles. For example, the flexfile
> RFC states that returning EACCES is a mechanism for fencing files. If
> you create a server where writes always return that error, commands
> like dd will return success while the writes are in a RESET_TO_PNFS
> loop.
>=20
> I'm not trying to get into an O_PONIES argument here but I always
> thought NFS close-to-open semantics meant that NFS close makes a
> strict effort to flush writes to the server before finishing.
>=20
> I've been digging into how the NFS client guarantees writes get
> flushed. I noticed that nfs/file.c:nfs_file_fsync goes through a much
> more rigorous algorithm to flush writes in the face of server
> unavailability when compared to nfs/file.c:nfs_file_flush. The
> redirtied_pages interlock is especially critical for ensuring
> RESET_TO_PNFS events block the syscall from returning.
>=20
> At first I thought this was intentional. But after looking at the
> history, I found this commit:
>=20
> "NFS: Don't inadvertently clear writeback errors" -
> https://github.com/torvalds/linux/commit/aded8d7b54f250af6deb72fde475291c=
fba513d1
>=20
> That diff replaced calls to "vfs_fsync" with "nfs_wb_all" in several
> places including nfs_file_flush. Since the diff makes no mention of
> reducing the guarantees of nfs_file_flush & etc I'm wondering if this
> effect was unintentional?
>=20
> Does it make sense to modify nfs_wb_all to have a loop like
> nfs_file_fsync does? Or introduce a new function?
>=20

We've always had the rule that errors that are classified as "fatal" on
the server should be reported as such through the same mechanisms as
they would in POSIX, and that the effects should be the same. While
"EACCES" is not technically allowed by POSIX as a response to WRITE, it
was necessary to allow it in NFS because NFS servers do check
permissions on I/O. Even in NFSv4, the presence of a stateid that
passed OPEN checks does not guarantee that the client is allowed to
write out its data to the file.

Now that said, the pNFS flexfiles protocol introduces a subtlety here
in that the client should not be considering any error that was
returned by a data server as being fatal. Instead, it should be
reporting the error back to the metadata server, and either failing
over to another mirror (for the case of a READ) or returning the layout
and asking for a new layout (for the case of a WRITE or if there are no
more mirrors to READ from). The LAYOUTGET may then return the fatal
error, if the metadata server is out of options for fixing the problem.

So the above governs how hard mounts handle write errors.

Now the difference between how fsync() and close() work is really down
to whether or not we need to give a hard guarantee that the data is
really on disk or not when the syscall completes.

fsync() definitely needs to guarantee that data is really on storage in
the case where it doesn't flag an error. The problem is that a system
that relies on resends, and that doesn't block new writes from
occurring is inherently prone to live locks. We try to handle that in
nfs_file_fsync() by monitoring a 'redirtied_pages' counter that tells
us how many resends occurred in the last attempt to flush, however that
doesn't suffice to completely avoid live locks.

close() does not need to guarantee that the data is on storage, because
POSIX doesn't require it to. It's just a convenience that ensures
close-to-open semantics can be made to work. For that reason, it just
calls nfs_wb_all(), which does not wait for resends to finish, and thus
avoids live locks.

Now we can definitely discuss whether or not that close() behaviour is
correct: it does not lose data (so there are no hard mount violations),
but it also doesn't offer the same guarantees that fsync() does w.r.t.
whether the data is on disk on exit. I just wanted to first make sure
that we're on the same page concerning hard mount semantics.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

