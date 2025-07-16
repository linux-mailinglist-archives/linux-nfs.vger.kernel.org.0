Return-Path: <linux-nfs+bounces-13097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFCEB06BAF
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 04:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5914F4E0E55
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 02:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46212741D4;
	Wed, 16 Jul 2025 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTPESz17"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4627281D
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632950; cv=none; b=GBBvY8J3XV762XoWp4jEPD3u2DpfbpwoNB8RGS94STd2JWhGsbxeUZXvLMtXKlvsOXYvAGLmZHmNIqIQRsmlkOtzSwFHAvdvZ14VUkL2DianzZJlnDxTrTLfxeBgohrV2I95Lf05+W4X1UZO/IutcK5X+KQhW8dCPvU5h/Siw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632950; c=relaxed/simple;
	bh=sqK/Ka2gWL3E68MjOp5o4RXdOEwhLzYjZwH4wvnaqr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/+c40J7bzpMqjUIPE7miA0b4lBLILv7rfKztvRL3mdl+UhmO9Hqk10M3ilsbvsdatNsJ0UOh6CAlmgEAew5fq5gx8nVH6MrIJyjLKCtQ6m0QK6+zYjWvlZ4pa6fnX/MJoR3s8GHJaE1SO87bU9sfvxvQG6HopCxGjKtFfbUYo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTPESz17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95953C4CEFA;
	Wed, 16 Jul 2025 02:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752632950;
	bh=sqK/Ka2gWL3E68MjOp5o4RXdOEwhLzYjZwH4wvnaqr4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WTPESz175VDmbekPHcOGP6ADstddxo+m0RVPyLhtG2uUi9ms7mZsm+fZXFmAg64Hj
	 AZiRDSRlVdT1PMWg5Sv8BpojPMnjKDUJHtdL7+gNe/+4kvJaH0c8Tc1wcTXiMAoJuW
	 U/qqV0uG7LfctpP8FktzNZAARdA32w7la0Er5Xd8KzSuaL0KBSUoKWd2ipMhVoGDsb
	 ho+u7jH6tP4xRRTR80wNm/HS/AnVhIhJsOq/xQa9VHJ+OLa0/vi3KbYmqabXP4V6RF
	 9Qd48fltda6aX0eQfH+KePOtUmwg2A8NVnCenEKf8dcytFLwYom/xFeZOYicK30ldk
	 tMdSHOg9MCkJA==
Message-ID: <95aa4d502e6614cd589baec518e597faaa37c5fa.camel@kernel.org>
Subject: Re: [PATCH 2/3] NFS/localio: nfs_uuid_put() fix the wait for file
 unlink events
From: Trond Myklebust <trondmy@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Mike Snitzer
	 <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Date: Tue, 15 Jul 2025 19:29:08 -0700
In-Reply-To: <175262893035.2234665.1735173020338594784@noble.neil.brown.name>
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>
	,  =?utf-8?q?=3C5d191a4f112055a6b79881a2dade9c0721f91830=2E1752618161=2Egit=2E?= =?utf-8?q?trond=2Emyklebust=40hammerspace=2Ecom=3E?= <175262893035.2234665.1735173020338594784@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 11:22 +1000, NeilBrown wrote:
> On Wed, 16 Jul 2025, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > No reference to nfl is held when waiting in nfs_uuid_put(), so not
> > only
> > must the event condition check if the first entry in the list has
> > changed, it must also check if the nfl->nfs_uuid field is still
> > NULL,
> > in case the old entry was replaced.
>=20
> As no reference is held to nfl, it cannot be safe to check if
> nfl->nfs_uuid is still NULL.=C2=A0 It could be freed and the memory reuse=
d
> for anything.

It is quite safe.

The test first checks if the nfs_uuid->files list first entry still
points to 'nfl'. Then it checks the value of nfl->nfs_uuid.

All this happens while the nfs_uuid->lock is held.

>=20
> At this point, with nfs_uuid->net set to NULL, nothing can be added
> to
> nfs_uuid->files.=C2=A0 Things can only be removed.

There is nothing in either nfs_open_local_fh() or nfs_uuid_add_file()
that stops anyone from adding a new entry to nfs_uuid->files in the
case where nfs_uuid->net is NULL.

If that was the intention, then I agree that this patch is wrong, but
not for the reasons you listed.


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

