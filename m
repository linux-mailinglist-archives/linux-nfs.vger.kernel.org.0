Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970B049F277
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 05:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiA1EYg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 23:24:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33870 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiA1EYg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 23:24:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 392331F391;
        Fri, 28 Jan 2022 04:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643343875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gq9eU9YsXGrKsC+D+sKGffel8O7NHbV0mlPNWpT7Rlw=;
        b=koMDVRG8/n22seSQN/vTrmH9jyLKV+D4CRoE8blFyLMWgbPknZgBrWZllKD2qMtc5m6GkJ
        zYaby4OvQzGJuiMjMJ4N5x0EJGwqzj+ZyP9fHI0WWeXgAEXXxFARwlzDcs92bNhiy5VuTH
        4uRyyUx2NU4hP9vLzDfoQNYri5sjR7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643343875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gq9eU9YsXGrKsC+D+sKGffel8O7NHbV0mlPNWpT7Rlw=;
        b=pLYeg9mEujjZyLlBh+UL+GIYhIPV4QGA3fTsJJurX6w+GvHeGTvx51u0L0tZoj8shZ0BVa
        +cdpw8TkZ0igFgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD72B13780;
        Fri, 28 Jan 2022 04:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TMclIgBw82GQCwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 28 Jan 2022 04:24:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
In-reply-to: <A933D67A-0C1B-4700-97E7-0DBEF4458A77@oracle.com>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>,
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>,
 <164332328424.5493.16812905543405189867@noble.neil.brown.name>,
 <A933D67A-0C1B-4700-97E7-0DBEF4458A77@oracle.com>
Date:   Fri, 28 Jan 2022 15:24:27 +1100
Message-id: <164334386787.5493.637178363398104896@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Jan 2022, Chuck Lever III wrote:
>=20
> > On Jan 27, 2022, at 5:41 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Fri, 28 Jan 2022, Chuck Lever III wrote:
> >> Hi Neil-
> >>=20
> >>> On Jan 26, 2022, at 11:58 PM, NeilBrown <neilb@suse.de> wrote:
> >>>=20
> >>> If a filesystem is exported to a client with NFSv4 and that client holds
> >>> a file open, the filesystem cannot be unmounted without either stopping=
 the
> >>> NFS server completely, or blocking all access from that client
> >>> (unexporting all filesystems) and waiting for the lease timeout.
> >>>=20
> >>> For NFSv3 - and particularly NLM - it is possible to revoke all state by
> >>> writing the path to the filesystem into /proc/fs/nfsd/unlock_filesystem.
> >>>=20
> >>> This series extends this functionality to NFSv4.  With this, to unmount
> >>> an exported filesystem is it sufficient to disable export of that
> >>> filesystem, and then write the path to unlock_filesystem.
> >>>=20
> >>> I've cursed mainly on NFSv4.1 and later for this.  I haven't tested
> >>> yet with NFSv4.0 which has different mechanisms for state management.
> >>>=20
> >>> If this series is seen as a general acceptable approach, I'll look into
> >>> the NFSv4.0 aspects properly and make sure it works there.
> >>=20
> >> I've browsed this series and need to think about:
> >> - whether we want to enable administrative state revocation and
> >> - whether NFSv4.0 can support that reasonably
> >>=20
> >> In particular, are there security consequences for revoking
> >> state? What would applications see, and would that depend on
> >> which minor version is in use? Are there data corruption risks
> >> if this facility were to be misused?
> >=20
> > The expectation is that this would only be used after unexporting the
> > filesystem.  In that case, the client wouldn't notice any difference
> > from the act of writing to unlock_filesystem, as the entire filesystem
> > would already be inaccessible.
> >=20
> > If we did unlock_filesystem a filesystem that was still exported, the
> > client would see similar behaviour to a network partition that was of
> > longer duration than the lease time.   Locks would be lost.
> >=20
> >>=20
> >> Also, Dai's courteous server work is something that potentially
> >> conflicts with some of this, and I'd like to see that go in
> >> first.
> >=20
> > I'm perfectly happy to wait for the courteous server work to land before
> > pursuing this.
> >=20
> >>=20
> >> Do you have specific user requests for this feature, and if so,
> >> what are the particular usage scenarios?
> >=20
> > It's complicated....
> >=20
> > The customer has an HA config with multiple filesystem resource which
> > they want to be able to migrate independently.  I don't think we really
> > support that,
>=20
> With NFSv4, the protocol has mechanisms to indicate to clients that
> a shared filesystem has migrated, and to indicate that the clients'
> state has been migrated too. Clients can reclaim their state if the
> servers did not migrate that state with the data. It deals with the
> edge cases to prevent clients from stealing open/lock state during
> the migration.
>=20
> Unexporting doesn't seem like the right approach to that.

No, but it something that should work, and should allow the filesystem
to be unmounted.  You get to keep both halves.

>=20
>=20
> > but they seem to want to see if they can make it work (and
> > it should be noted that I talk to an L2 support technician who talks to
> > the customer representative, so I might be getting the full story).
> >=20
> > Customer reported that even after unexporting a filesystem, they cannot
> > then unmount it.
>=20
> My first thought is that probably clients are still pinning
> resources on that shared filesystem. I guess that's what the
> unlock_ interface is supposed to deal with. But that suggests
> to me that unexporting first is not as risk-free as you
> describe above. I think applications would notice and there
> would be edge cases where other clients might be able to
> grab open/lock state before the original holders could
> re-establish their lease.

Unexporting isn't risk free.  It just absorbs all the risks - none are
left of unlock_filesystem to be blamed for.

Expecting an application to recover if you unexport a filesystem and
later re-export it is certainly not guaranteed.  That isn't the use-case
I particularly want to fix.  I want to be able to unmount a filesystem
without visiting call clients and killing off applications.

>=20
>=20
> > Whether or not we think that independent filesystem
> > resources is supportable, I do think that the customer should have a
> > clear path for unmounting a filesystem without interfering with service
> > provided from other filesystems.
>=20
> Maybe. I guess I put that in the "last resort" category
> rather than "this is something safe that I want to do as
> part of daily operation" category.

Agree.  Definitely "last resort".

>=20
>=20
> > Stopping nfsd would interfere with
> > that service by forcing a grace-period on all filesystems.
>=20
> Yep. We have discussed implementing a per-filesystem
> grace period in the past. That is probably a pre-requisite
> to enabling filesystem migration.
>=20
>=20
> > The RFC explicitly supports admin-revocation of state, and that would
> > address this specific need, so it seemed completely appropriate to
> > provide it.
>=20
> Well the RFC also provides for migrating filesystems without
> stopping the NFS service. If that's truly the goal, then I
> think we want to encourage that direction instead of ripping
> out open and lock state.

I suspect that virtual IPs and network namespaces is the better approach
for migrating exported filesystems.  It isn't clear to me that
integrated migration support in NFS would add anything of value.

But as I think I said to Bruce - seamless migration support is not my
goal here.  In the context where a site has multiple filesystems that
are all NFS exported, there is a case for being able to forcibly
unexport/unmount one filesystem without affecting the others.  That is
my aim here.

Thanks,
NeilBrown


>=20
> Also, it's not clear to me that clients support administrative
> revocation as broadly as we might like. The Linux NFS client
> does have support for NFSv4 migration, though it's a bit
> fallow these days.
>=20
>=20
> > As an aside ...  I'd like to be able to suggest that the customer use
> > network namespaces for the different filesystem resources.  Each could
> > be in its own namespace and managed independently.  However I don't
> > think we have good admin infrastructure for that do we?
>=20
> None that I'm aware of. SteveD is the best person to ask.
>=20
>=20
> > I'd like to be able to say "set up these 2 or 3 config files and run=20
> > systemctl start nfs-server@foo and the 'foo' network namespace will be
> > created, configured, and have an nfs server running".
> > Do we have anything approaching that?  Even a HOWTO ??
>=20
> Interesting idea! But doesn't ring a bell.
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
