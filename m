Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3094A4CB56D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Mar 2022 04:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiCCD11 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Mar 2022 22:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCCD10 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Mar 2022 22:27:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56EC11C7C4
        for <linux-nfs@vger.kernel.org>; Wed,  2 Mar 2022 19:26:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E2211F383;
        Thu,  3 Mar 2022 03:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646278000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwqQ7jrPq5fYB3j3BYDEFNug+p3ta4LLfrkREJLeyuk=;
        b=QBE7CBLZORUTcAQVZRoSkl3TUR+OnqNDl1sMZ9JB4oO6wHU1aB9EQq/LuIDPvDD7wFD/Zz
        +2GhU1Tz8+Cuenj/Qt8ZYLtGIDDV1tCBwLOFsgdrCLRMw4Fs57z3M692doXXqnBdAMysM6
        dIelBnc6Im9BiB0maMpMWYVhmwhi3kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646278000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwqQ7jrPq5fYB3j3BYDEFNug+p3ta4LLfrkREJLeyuk=;
        b=3nJcVbU6b8xq62u80yCo0NCH+mA9qS6c3NZnmmMqJJdko/VNu7fJtH93tvoyWxPruM+8eT
        W/zvPZVoTUmvuRCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 911E913AF6;
        Thu,  3 Mar 2022 03:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OarIEm41IGLsdAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 03 Mar 2022 03:26:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a container
In-reply-to: <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>,
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>,
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>,
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>,
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>,
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>,
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>,
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>,
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>,
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>,
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>,
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>,
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>,
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>,
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>,
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>,
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>,
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>,
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>,
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
Date:   Thu, 03 Mar 2022 14:26:26 +1100
Message-id: <164627798608.17899.14049799069550646947@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 02 Mar 2022, Chuck Lever III wrote:
>=20
> > On Feb 28, 2022, at 10:43 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> >=20
> > When mounting NFS filesystems in a network namespace using v4, some care
> > must be taken to ensure a unique and stable client identity.
> > Add documentation explaining the requirements for container managers.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >=20
> > NOTE I originally suggested using uuidgen to generate a uuid from a
> > container name.  I've changed it to use the name as-is because I cannot
> > see a justification for using a uuid - though I think that was suggested
> > somewhere in the discussion.
> > If someone would like to provide that justification, I'm happy to
> > include it in the document.
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> > utils/mount/nfs.man | 63 +++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 63 insertions(+)
> >=20
> > diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> > index d9f34df36b42..4ab76fb2df91 100644
> > --- a/utils/mount/nfs.man
> > +++ b/utils/mount/nfs.man
> > @@ -1844,6 +1844,69 @@ export pathname, but not both, during a remount.  =
For example,
> > merges the mount option
> > .B ro
> > with the mount options already saved on disk for the NFS server mounted a=
t /mnt.
> > +.SH "NFS IN A CONTAINER"
>=20
> To be clear, this explanation is about the operation of the
> Linux NFS client in a container environment. The server has
> different needs that do not appear to be addressed here.
> The section title should be clear that this information
> pertains to the client.

The whole man page is only about the client, but I agree that clarity is
best.  I've changed the section heading to

    NFS MOUNTS IN A CONTAINER

>=20
>=20
> > +When NFS is used to mount filesystems in a container, and specifically
> > +in a separate network name-space, these mounts are treated as quite
> > +separate from any mounts in a different container or not in a
> > +container (i.e. in a different network name-space).
>=20
> It might be helpful to provide an introductory explanation of
> how mount works in general in a namespaced environment. There
> might already be one somewhere. The above text needs to be
> clear that we are not discussing the mount namespace.

Mount namespaces are completely irrelevant for this discussion.
This is "specifically" about "network name-spaces" a I wrote.
Do I need to say more than that?
Maybe a sentence "Mount namespaces are not relevant" ??

>=20
>=20
> > +.P
> > +In the NFSv4 protocol, each client must have a unique identifier.
>=20
> ... each client must have a persistent and globally unique
> identifier.

I dispute "globally".  The id only needs to be unique among clients of
a given NFS server.
I also dispute "persistent" in the context of "must".
Unless I'm missing something, a lack of persistence only matters when a
client stops while still holding state, and then restarts within the
lease period.  It will then be prevented from establishing conflicting
state until the lease period ends.  So persistence is good, but is not a
hard requirement.  Uniqueness IS a hard requirement among concurrent
clients of the one server.

>=20
>=20
> > +This is used by the server to determine when a client has restarted,
> > +allowing any state from a previous instance can be discarded.
>=20
> Lots of passive voice here :-)
>=20
> The server associates a lease with the client's identifier
> and a boot instance verifier. The server attaches all of
> the client's file open and lock state to that lease, which
> it preserves until the client's boot verifier changes.

I guess I"m a passivist.  If we are going for that level of detail we
need to mention lease expiry too.

 .... it preserves until the lease time passes without any renewal from
      the client, or the client's boot verifier changes.

In another email you add:

> Oh and also, this might be a good opportunity to explain
> how the server requires that the client use not only the
> same identifier string, but also the same principal to
> reattach itself to its open and lock state after a server
> reboot.
>=20
> This is why the Linux NFS client attempts to use Kerberos
> whenever it can for this purpose. Using AUTH_SYS invites
> other another client that happens to have the same identifier
> to trigger the server to purge that client's open and lock
> state.

How relevant is this to the context of a container?
How much extra context would be need to add to make the mention of
credentials coherent?
Maybe we should add another section about credentials, and add it just
before this one??

>=20
>=20
> > So any two
> > +concurrent clients that might access the same server MUST have
> > +different identifiers, and any two consecutive instances of the same
> > +client SHOULD have the same identifier.
>=20
> Capitalized MUST and SHOULD have specific meanings in IETF
> standards that are probably not obvious to average readers
> of man pages. To average readers, this looks like shouting.
> Can you use something a little friendlier?
>=20

How about:

   Any two concurrent clients that might access the same server must
   have different identifiers for correct operation, and any two
   consecutive instances of the same client should have the same
   identifier for optimal handling of an unclean restart.

>=20
> > +.P
> > +Linux constructs the identifier (referred to as=20
> > +.B co_ownerid
> > +in the NFS specifications) from various pieces of information, three of
> > +which can be controlled by the sysadmin:
> > +.TP
> > +Hostname
> > +The hostname can be different in different containers if they
> > +have different "UTS" name-spaces.  If the container system ensures
> > +each container sees a unique host name,
>=20
> Actually, it turns out that is a pretty big "if". We've
> found that our cloud customers are not careful about
> setting unique hostnames. That's exactly why the whole
> uniquifier thing is so critical!

:-)  I guess we keep it as "if" though, not "IF" ....

>=20
>=20
> > then this is
> > +sufficient for a correctly functioning NFS identifier.
> > +The host name is copied when the first NFS filesystem is mounted in
> > +a given network name-space.  Any subsequent change in the apparent
> > +hostname will not change the NFSv4 identifier.
>=20
> The purpose of using a uuid here is that, given its
> definition in RFC 4122, it has very strong global
> uniqueness guarantees.

A uuid generated from a given string (uuidgen -N $name ...) has the same
uniqueness as the $name.  Turning it into a uuid doesn't improve the
uniqueness.  It just provides a standard format and obfuscates the
original.  Neither of those seem necessary here.
I think Ben is considering using /etc/mechine-id.  Creating a uuid from
that does make it any better.

>=20
> Using a UUID makes hostname uniqueness irrelevant.

Only if the UUID is created appropriately.  If, for example, it is
created with -N from some name that is unique on the host, then it needs
to be combined with the hostname to get sufficient uniqueness.

>=20
> Again, I think our goal should be hiding all of this
> detail from administrators, because once we get this
> mechanism working correctly, there is absolutely no
> need for administrators to bother with it.

Except when things break.  Then admins will appreciate having the
details so they can track down the breakage.  My desktop didn't boot
this morning.  Systemd didn't tell me why it was hanging though I
eventually discovered that it was "wicked.service" that wasn't reporting
success.  So I'm currently very focused on the need to provide clarity
to sysadmins, even of "irrelevant" details.

But this documentation isn't just for sysadmins, it is for container
developers too, so they can find out how to make their container work
with NFS.

>=20
>=20
> The remaining part of this text probably should be
> part of the man page for Ben's tool, or whatever is
> coming next.

My position is that there is no need for any tool.  The total amount of
code needed is a couple of lines as presented in the text below.  Why
provide a wrapper just for that?
We *cannot* automatically decide how to find a name or where to store a
generated uuid, so there is no added value that a tool could provide.

We cannot unilaterally fix container systems.  We can only tell people
who build these systems of the requirements for NFS.

Thanks,
NeilBrown

>=20
>=20
> > +.TP
> > +.B nfs.nfs4_unique_id
> > +This module parameter is the same for all containers on a given host
> > +so it is not useful to differentiate between containers.
> > +.TP
> > +.B /sys/fs/nfs/client/net/identifier
> > +This virtual file (available since Linux 5.3) is local to the network
> > +name-space in which it is accessed and so can provided uniqueness between
> > +containers when the hostname is uniform among containers.
> > +.RS
> > +.PP
> > +This value is empty on name-space creation.
> > +If the value is to be set, that should be done before the first
> > +mount (much as the hostname is copied before the first mount).
> > +If the container system has access to some sort of per-container
> > +identity, then a command like
> > +.RS 4
> > +echo "$CONTAINER_IDENTITY" \\
> > +.br
> > +   > /sys/fs/nfs/client/net/identifier=20
> > +.RE
> > +might be suitable.  If the container system provides no stable name,
> > +but does have stable storage, then something like
> > +.RS 4
> > +[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&=20
> > +.br
> > +cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier=20
> > +.RE
> > +would suffice.
> > +.PP
> > +If a container has neither a stable name nor stable (local) storage,
> > +then it is not possible to provide a stable identifier, so providing
> > +a random one to ensure uniqueness would be best
> > +.RS 4
> > +uuidgen > /sys/fs/nfs/client/net/identifier
> > +.RE
> > +.RE
> > .SH FILES
> > .TP 1.5i
> > .I /etc/fstab
> > --=20
> > 2.35.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
