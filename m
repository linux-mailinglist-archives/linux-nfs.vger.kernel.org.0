Return-Path: <linux-nfs+bounces-18439-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vhLyK6dFdWn6DAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18439-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 23:20:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFD7F1D6
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 23:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96579300B04F
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FEB225403;
	Sat, 24 Jan 2026 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MumsFYbX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FD221540
	for <linux-nfs@vger.kernel.org>; Sat, 24 Jan 2026 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769293220; cv=none; b=IEPAznX8BW8Gv23sQYOAf1q+lf9tceDI+IeROXvKDnw+OgZ4bCRnU8ibUfh0DTmblRv3LeVGpOtYI9rZ5ekNLQy7giSuVZeG+eSLSWws+t5SLh+aLtgE+RYA12bxQZt6h9WHNLTve3JUrd4DB4toadd/QDsuR/4L3Yuos8/m15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769293220; c=relaxed/simple;
	bh=+mo+ER0526ROcuxo8cb1/GWj9jsAmwMfYjpTIQHiKKQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jwe8M2Ydf50lgA2GTmjT+AqH09WvXTuNWuIIYmuczP3f2GkQJy8ntd4y8M0t0rke6fr4rU4L6gZndLLifkok/FdEM9BPezj9wzbE4Ka8N7PK6UCwEkOnwT10GF7lGEMxqzoYKaR5ZbxxOQ+T6yjbPTOcEWGtiWDX/cr/MHwc93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MumsFYbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108F8C116D0;
	Sat, 24 Jan 2026 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769293220;
	bh=+mo+ER0526ROcuxo8cb1/GWj9jsAmwMfYjpTIQHiKKQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MumsFYbXI5+66boHiKTT0n1FXMpLRh5ddgy+IOpLqjZP1Whk4vLSkh19A4JeURRiG
	 aeWPCXu71PvfV6juXUsQ/iygexm60Nn04DYU2CC+rUsSNwR3tEkCf86gPvDdloTrZ0
	 VFzmuhWlxP6lZF4H8qfa126k99aA/W+p1oiP/nsJMCaStzW9d9VsawYwfmqkOL+KX9
	 SSGQ0rU2zchTgJoYk5HrYwC0En5ZQZvEgo0Wqc0tKkH9vrVOL/1ZM/TQ1ehnOL+3hF
	 XDn2FTRYG2GMC+YADp5ixrdJWwmrRgjVA1ajq84VduMjvtxFfnvA39I79ZD7gqOLHa
	 zjnff4lZjCj7g==
Message-ID: <7c86e2c3ec73650696579a3e03be937a8b4205a1.camel@kernel.org>
Subject: Re: [PATCH 1/5] NFS: Protect against 'eof page pollution'
From: Trond Myklebust <trondmy@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Sat, 24 Jan 2026 17:20:19 -0500
In-Reply-To: <4a0a8181-b0b5-4f2f-84e1-3c935273b7df@lucifer.local>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com>
	 <a753650aeb789a1a3f2a748bf37415b92615382b.1757100278.git.trond.myklebust@hammerspace.com>
	 <4a0a8181-b0b5-4f2f-84e1-3c935273b7df@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18439-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFEFD7F1D6
X-Rspamd-Action: no action

On Sat, 2026-01-24 at 21:01 +0000, Lorenzo Stoakes wrote:
> On Fri, Sep 05, 2025 at 03:35:16PM -0400, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > This commit fixes the failing xfstest 'generic/363'.
> >=20
> > When the user mmaps() an area that extends beyond the end of file,
> > and
> > proceeds to write data into the folio that straddles that eof,
> > we're
> > required to discard that folio data if the user calls some function
> > that
> > extends the file length.
> >=20
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Hi Trond,
>=20
> Sorry to dig up an old patch but I wanted to ask about this change:
>=20
> > ---
> > =C2=A0fs/nfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 ++++++++++++++++=
+++++++++++++++++
> > =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++++--
> > =C2=A0fs/nfs/internal.h=C2=A0 |=C2=A0 2 ++
> > =C2=A0fs/nfs/nfs42proc.c | 14 +++++++++++---
> > =C2=A0fs/nfs/nfstrace.h=C2=A0 |=C2=A0 1 +
> > =C2=A05 files changed, 54 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > index 86e36c630f09..af2fdbfcbbf6 100644
> > --- a/fs/nfs/file.c
> > +++ b/fs/nfs/file.c
> > @@ -28,6 +28,7 @@
> > =C2=A0#include <linux/mm.h>
> > =C2=A0#include <linux/pagemap.h>
> > =C2=A0#include <linux/gfp.h>
> > +#include <linux/rmap.h>
> > =C2=A0#include <linux/swap.h>
> > =C2=A0#include <linux/compaction.h>
> >=20
> > @@ -280,6 +281,37 @@ nfs_file_fsync(struct file *file, loff_t
> > start, loff_t end, int datasync)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(nfs_file_fsync);
> >=20
> > +void nfs_truncate_last_folio(struct address_space *mapping, loff_t
> > from,
> > + =C2=A0=C2=A0=C2=A0=C2=A0 loff_t to)
>=20
> So this seems to be a slightly adjusted version of
> pagecache_isize_extend(),
> what was it about that that didn't work for you?
>=20
> It seems the main differences are - block size alignment (surely you
> still need
> that though?) switching folio_test_dirty() for folio_test_uptodate()
> (I'm not
> sure about this change though?) and adding the trace line.

   1. NFS is not a block protocol. Reads and writes are byte aligned.
   2. The test for bsize >=3D PAGE_SIZE is nonsense for a byte aligned
      filesystem.
   3. NFS does care about using folio_mkclean() to fix races between an
      application that is writing to the folio, and any zeroing of the
      data that may result from the file truncation.
   4. The existing folio dirty state isn't of interest here, since NFS
      won't extend existing writes to cover the part of the folio that
      lies after the old eof.
   5. The folio uptodate state is of interest, since any future
      pagecache read needs to see zeroed bytes starting at the old eof
      and extending either to the offset at the end of the folio, or to
      the new eof (whichever of the two is smaller).


--=20
Trond Myklebust Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

