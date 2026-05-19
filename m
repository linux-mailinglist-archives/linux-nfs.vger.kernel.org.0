Return-Path: <linux-nfs+bounces-21699-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G2BLVU5DGq2aAUAu9opvQ
	(envelope-from <linux-nfs+bounces-21699-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 12:20:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B8F57C139
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B995E3014C2D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77881394474;
	Tue, 19 May 2026 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLZkoiN+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D5405C5F;
	Tue, 19 May 2026 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186002; cv=none; b=U1rl+hXRop5e9ueMdI65nSytSzYv7S9Fu6qobr3ndvO9apajjGHpKQlZ8mPRJx7bKEu7aLl6N9LVdRbYBMASbv6X2QqqfoCJwDRyeKSnkIF4WAhggh1RSdjNFMQBP+jw3ccJbHeVlKrsxfrEZ1YACXnojZBD7AKoYsiboHPy8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186002; c=relaxed/simple;
	bh=QSWfKUODolan8XIlvp2cgyDzL7jfFjEB/UmNJs82uuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2OYqosK4+STpQF1OSkHbdTVdkYqlvI+9BkKVmXYPJnta1wy3MjYtV2ZgEvCM8daLvsHSQB/ntExM47eHmJOOTe7kyZ/xNGOXgfs/LW42MzZ/RVY9nZNQbSaViEY52MhB8EhPA+Kk/drnu47zTtfdWi5M7CKfCVesXYreqnEx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLZkoiN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A89BC2BCB3;
	Tue, 19 May 2026 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779186001;
	bh=QSWfKUODolan8XIlvp2cgyDzL7jfFjEB/UmNJs82uuQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gLZkoiN+WRjLOmQfaeQhxN8Jk7yw6fDweMBekoRMGdGANlpXdFynBClexBhXX4Drc
	 T0f7kWn6NtHFOzAV2dUFY66beuGvkXondIqYWBKxOovYlze/dDBFbOO/eNhWzzkqMZ
	 i+9VdC7kvq0IlTQH7JpCYv8DriBvgE9k4G6P8QerfY6nStMiWNgkA0yIXQyuO6EVVU
	 UqknXG7AhVQsdOqHg6qPXYibRaMdE8vcqdXwctCGMIXNlB0OtCo2atY8ehfAZuh+tn
	 Xy7mqrFvK+WniUKhOYPV7L63YWuW+q+mYhYLOQ7DKoSG8AK1zyGzbqLVwpZGWOLSCT
	 U+XMKFqBeG7YQ==
Message-ID: <85d465b40281a74c18c675fe40972132e7eb77b1.camel@kernel.org>
Subject: Re: try_break_deleg() and atomic_open()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Tue, 19 May 2026 06:19:58 -0400
In-Reply-To: <177916077874.3947082.12776465344029937479@noble.neil.brown.name>
References: 
	<177853810078.2788210.11836979435758859096@noble.neil.brown.name>
	  <72c8e1e9c9212aeb8a0cb9f5321dd576685a4f7e.camel@kernel.org>
	  <177855793113.2788210.10945921479429705266@noble.neil.brown.name>
	  <a278be1fa50f3c52af869233ce34d3139c33b653.camel@kernel.org>
	 <177916077874.3947082.12776465344029937479@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21699-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 25B8F57C139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 13:19 +1000, NeilBrown wrote:
> On Tue, 12 May 2026, Jeff Layton wrote:
> > On Tue, 2026-05-12 at 13:52 +1000, NeilBrown wrote:
> > > On Tue, 12 May 2026, Jeff Layton wrote:
> > > > On Tue, 2026-05-12 at 08:21 +1000, NeilBrown wrote:
> > > > > Hi Jeff,
> > > > >  quick question (I hope).
> > > > > Should atomic_open() call try_break_deleg() on the directory
> > > > > when a create is pending?
> > > > >=20
> > > > > This seems a bit iffy because the VFS doesn't necessarily know if=
 a
> > > > > create will happen before it calls ->atomic_open, so it cannot kn=
ow
> > > > > if it needs to break the deleg or not.
> > > >=20
> > > > Agreed, so I'm thinking no to doing that in generic code.
> > > >=20
> > > > > So maybe the individual ->atomic_open functions should do it?
> > > > >=20
> > > >=20
> > > > I think that's probably what has to happen:
> > > >=20
> > > > atomic_open() is there to handle the non-trivial open cases (mostly
> > > > network and clustered filesystems). Those, in general, also require
> > > > non-trivial delegation/lease handling. I think we sort of need to l=
eave
> > > > it to the underlying fs in those cases since the kernel doesn't hav=
e
> > > > enough info to do it.
> > >=20
> > > I had a look and could only find gfs2/nolocks and NFSv4 as filesystem=
s
> > > which support leases on directories and use ->atomic_open.
> > >=20
> >=20
> > Maybe also smb/client? Ceph also supports clustered leases, but the
> > kernel client never got support for it.
>=20
> Yes, those both *could* possible support directory leases, but neither
> actually do at present.
>=20
> > =20
> > > I wonder if gfs2/nolocks should not advertise ->atomic_open.  The
> > > implication of nolocks is (I assume) that there is only the one activ=
e
> > > client, and in that case no special handling is needed for exclusive
> > > create.
> > >=20
> >=20
> > Yeah, I don't see the point of GFS2's ->atomic_open in the case of a
> > single-client filesystem.
> >=20
> > > NFSv4 uses delegations to provide leases.  So the ->atomic_open
> > > handler does have work to do to cancel any lease while keeping the
> > > delegation.
> > > We would need to either allow ->atomic_open to return the deleg_inode
> > > somehow, or have ->atomic_open drop the parent lock so that it can
> > > safely wait.
> > >=20
> > > Or we could just ignore the issue until I manage to land my changed t=
o
> > > push locking down into the filesystem, and then locking/waiting becom=
es
> > > much easier.
> > >=20
> >=20
> > To make sure I understand the scenario: the NFS client has a directory
> > delegation on the parent directory and an application has taken out a
> > lease on that directory. We now want to issue an open(..., O_CREAT) on
> > a file in that directory for which we don't yet have a dentry?
>=20
> Yes, that is the scenario when ->atomic_open will be called and could
> created a file without first breaking the lease that some application
> holds on the directory.
>=20
> >=20
> > FWIW, the current NFSv4 client code won't hand out leases on a
> > directory, as struct nfs_dir_operations doesn't set the ->setlease
> > operation, so this situation shouldn't arise. Ditto for CIFS.
>=20
> Oh.... I had thought that I saw that it did.  Clearly I was wrong.
> So at present the only filesystem which supports directory leases and
> ->atomic_open is gfs2 when "nolocks" is active and we both agree that is
> an odd configuration.  But it likely doesn't work as expected and maybe
> we should discuss fixing it with the gfs2 devs.
>=20

AIUI, "nolocks" is mostly used with GFS2 in a single-node
configuration, so I think it should basically work in that case.

> >=20
> > But, let's pretend that it's possible: Ideally we'd just leave it up to
> > the server to recall the deleg if a create happens, but most servers
> > won't revoke the deleg of the client making the change. So I think if
> > we ever did want to support this, then the NFSv4 client would need to
> > revoke the (local application's) lease on its own.
>=20
> Yes.  One approach is to decide that ->atomic_open needs to handle any
> lease breaking that might be needed.  In that case we should document
> this requirement for atomic_open.
>=20
> The other approach is to have the VFS proactively break the lease if a
> create is expected.
>
> >=20
> > >=20
> > > >=20
> > > > > I'm looking at dentry_create() which calls atomic_open() is quite=
 a
> > > > > different way to how lookup_open() calls it.  I'd like to change
> > > > > nfsd4 so it calls something a lot more like lookup_open() and in
> > > > > looking at what I would need to change, delegated_inode stood out=
.
> > > > >=20
> > > >=20
> > > > Understood. I wish that were a bit less klunky, but I don't see a g=
reat
> > > > way to make it so.
> > >=20
> > > We could check for a lease and if one is present then do the lookup
> > > separately from ->atomic_open.  If that finds a match then no create =
is
> > > needed.  If it doesn't then there is justification to break the lease
> > > before calling ->atomic_open.
> > >=20
> > > This means that when there is a lease on an NFS directory, other apps
> > > have to do a LOOKUP for uncached names before sending a creating OPEN=
.
> > > Maybe that is an acceptable cost.
> > >=20
> > > Should an O_CREAT open *always* break a directory lease, even if the
> > > name happens to exist?
> > > I note that man/man2const/F_GETLEASE.2const in man-pages.git doesn't
> > > mention directories.

> > There is a coming update to the manpage, but it may not have trickled
> > out to the distros yet. My thinking at this point is that this would
> > have to be handled inside of the NFS (or CIFS) client.
>=20
> Where can I see the manpage update?  It isn't in
>    https://git.kernel.org/pub/scm/docs/man-pages/man-pages/
>=20

These got new F_SETDELEG/F_GETDELEG constants, so they're in:

    ./man2const/F_GETDELEG.2const


> >=20
> > Now though I'm wondering if the NFSv4 client-side lease implementation
> > is actually broken:
> >=20
> > Suppose an application takes out a read lease on a fd1 for a file and
> > then another application on the same client opens fd2 on the file for
> > write. I don't think a lease break will happen today since the activity
> > comes from the same client.
> >=20
> > OTOH, maybe it does work since the v4 client does set a local lease on
> > the file? I think we'll need to test this to see how that works.
>=20
> I think the local lease handling is enough to break the lease.
> As long as the NFS client only gives out leases when it holds a
> delegation, and break them when it loses the delegation (and this is
> what the code appears to do) then it should all work properly.  Testing
> wouldn't hurt of course.
>=20
> So the short answer to my original question is that something should
> break leases when ->atomic_create is called, but it doesn't actually
> matter for any filesystem at present so we can delay having a firm
> opinion until someone wants to implement directory leases combined with
> atomic_open.
>=20

Agreed.
--=20
Jeff Layton <jlayton@kernel.org>

