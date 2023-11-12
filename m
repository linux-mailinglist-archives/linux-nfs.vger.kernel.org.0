Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA77E9285
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Nov 2023 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjKLUWh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Nov 2023 15:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLUWg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Nov 2023 15:22:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB32129;
        Sun, 12 Nov 2023 12:22:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E8012189E;
        Sun, 12 Nov 2023 20:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699820551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PRTsARRf4wBatpAVW6gWqFEvTJ1mDk/y2FhbQeP80g=;
        b=NdPXLPAqh/I93pYQNJZsKhemZKsBrwB0vXQSexcgCPBEbgwTJfkHqrqPWdccM7lVbJE1eD
        PCctPYLyCJB+hHAE1gB0K8bX6Wy6nOUdRuPnOv3bT2qXBXWxUg/+4sSY9wvHMFXbSnqqQK
        qF0VRNnfqvqLkjE4FnnwTdzqNKKZ9wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699820551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PRTsARRf4wBatpAVW6gWqFEvTJ1mDk/y2FhbQeP80g=;
        b=HSt4mM9tcf9eq9Nq29mArXQ+TWF+93j4KIxfQw7nN7zx8On8ODx85mGVuEd72oM4TBp46O
        hUz5pXILq/WjeSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4936313915;
        Sun, 12 Nov 2023 20:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FWQeAQU0UWXtYwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 12 Nov 2023 20:22:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH v4 0/3] convert write_threads, write_version and
 write_ports to netlink commands
In-reply-to: <0f0467f396777722022403727824104b4f0a8d85.camel@kernel.org>
References: <cover.1699095665.git.lorenzo@kernel.org>,
 <7fdd6dd0d8ab75181eb350f78a4822a039cacaa5.camel@kernel.org>,
 <ZVCiyNQtkumDheU4@lore-desk>,
 <0f0467f396777722022403727824104b4f0a8d85.camel@kernel.org>
Date:   Mon, 13 Nov 2023 07:22:26 +1100
Message-id: <169982054606.2582.2797096885323571291@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 12 Nov 2023, Jeff Layton wrote:
> On Sun, 2023-11-12 at 11:02 +0100, Lorenzo Bianconi wrote:
> > > On Sat, 2023-11-04 at 12:13 +0100, Lorenzo Bianconi wrote:
> > > > Introduce write_threads, write_version and write_ports netlink
> > > > commands similar to the ones available through the procfs.
> > > >=20
> > > > Changes since v3:
> > > > - drop write_maxconn and write_maxblksize for the moment
> > > > - add write_version and write_ports commands
> > > > Changes since v2:
> > > > - use u32 to store nthreads in nfsd_nl_threads_set_doit
> > > > - rename server-attr in control-plane in nfsd.yaml specs
> > > > Changes since v1:
> > > > - remove write_v4_end_grace command
> > > > - add write_maxblksize and write_maxconn netlink commands
> > > >=20
> > > > This patch can be tested with user-space tool reported below:
> > > > https://github.com/LorenzoBianconi/nfsd-netlink.git
> > > > This series is based on the commit below available in net-next tree
> > > >=20
> > > > commit e0fadcffdd172d3a762cb3d0e2e185b8198532d9
> > > > Author: Jakub Kicinski <kuba@kernel.org>
> > > > Date:   Fri Oct 6 06:50:32 2023 -0700
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0tools: ynl-gen: handle do ops with no input a=
ttrs
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0The code supports dumps with no input attribu=
tes currently
> > > > =C2=A0=C2=A0=C2=A0=C2=A0thru a combination of special-casing and luck.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0Clean up the handling of ops with no inputs. =
Create empty
> > > > =C2=A0=C2=A0=C2=A0=C2=A0Structs, and skip printing of empty types.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0This makes dos with no inputs work.
> > > >=20
> > > > Lorenzo Bianconi (3):
> > > > =C2=A0=C2=A0NFSD: convert write_threads to netlink commands
> > > > =C2=A0=C2=A0NFSD: convert write_version to netlink commands
> > > > =C2=A0=C2=A0NFSD: convert write_ports to netlink commands
> > > >=20
> > > > =C2=A0Documentation/netlink/specs/nfsd.yaml |  83 ++++++++
> > > > =C2=A0fs/nfsd/netlink.c                     |  54 ++++++
> > > > =C2=A0fs/nfsd/netlink.h                     |   8 +
> > > > =C2=A0fs/nfsd/nfsctl.c                      | 267 +++++++++++++++++++=
++++++-
> > > > =C2=A0include/uapi/linux/nfsd_netlink.h     |  30 +++
> > > > =C2=A0tools/net/ynl/generated/nfsd-user.c   | 254 +++++++++++++++++++=
+++++
> > > > =C2=A0tools/net/ynl/generated/nfsd-user.h   | 156 +++++++++++++++
> > > > =C2=A07 files changed, 845 insertions(+), 7 deletions(-)
> > > >=20
> > >=20
> > > Nice work, Lorenzo! Now comes the bikeshedding...
> >=20
> > Hi Jeff,
> >=20
> > >=20
> > > With the nfsdfs interface, we sort of had to split things up into
> > > multiple files like this, but it has some drawbacks, in particular with
> > > weird behavior when people do things out of order.
> >=20
> > what do you mean with 'weird behavior'? Something not expected?
> >=20
>=20
> Yeah.
>=20
> For instance, if you set up sockets but never write anything to the
> "threads" file, those sockets will sit around in perpetuity. Granted
> most people use rpc.nfsd to start the server, so this generally doesn't
> happen often, but it's always been a klunky interface regardless.

If you set up sockets but *do* write something to the "threads" file,
then those sockets will *still* sit around in perpetuity.
i.e. until you shut down the NFS server (rpc.nfsd 0).

I don't really see the problem.

It is true that you can use use the interface to ask for meaningless
things.  The maxim that applies is "If you make it fool-proof, only a
fool will use it". :-)

I'm not against exploring changes to the interface style in conjunction
with moving from nfsd-fs to netlink, but I would want a bit more
justification for any change.

Thanks,
NeilBrown

>=20
> > >=20
> > > Would it make more sense to instead have a single netlink command that
> > > sets up ports and versions, and then spawns the requisite amount of
> > > threads, all in one fell swoop?
> >=20
> > I do not have a strong opinion about it but I would say having a dedicated
> > set/get for each paramater allow us to have more granularity (e.g. if you=
 want
> > to change just a parameter we do not need to send all of them to the kern=
el).
> > What do you think?
> >=20
>=20
> It's pretty rare to need to twiddle settings on the server while it's up
> and running. Restarting the server in the face of even minor changes is
> not generally a huge problem, so I don't see this as necessary.

Restarting the server is not zero-cost.  It restarts the grace period.
So I would rather not require it for minor changes.

NeilBrown


>=20
> Also, it's always been a bit hit and miss as to which settings take
> immediate effect. For instance, if I (e.g.) turn off NFSv4 serving
> altogether on a running server, it doesn't purge the existing NFSv4
> state, but v4 RPCs would be immediately rejected. Eventually it would
> time out, but it is odd.
>=20
> Personally, I think this is amenable to a declarative interface:
>=20
> Have userland always send down a complete description of what the server
> should look like, and then the kernel can do what it needs to make that
> happen (starting/stopping threads, opening/closing sockets, changing
> versions served, etc.).
>=20
> > >=20
> > > That does presuppose we can send down a variable-length frame though,
> > > but I assume that is possible with netlink.
> >=20
> > sure, we can do it.
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

