Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22124D91AA
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 01:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbiCOAmt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 20:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiCOAms (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 20:42:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5AA3AA6D
        for <linux-nfs@vger.kernel.org>; Mon, 14 Mar 2022 17:41:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7134921905;
        Tue, 15 Mar 2022 00:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647304893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFJZ7IEJtye5O5sn7N/zXb1V3GDdDyS0FpLf4ft883Y=;
        b=qyG5IVtjbgSLwZXHeVqt56zXxj6ra7JeIO+gvblO+XRFiy2NQsX4wPtVi+iB6iiJP2gMLX
        UdAJBvZDXwBOXdZWkGm5aIbUww93GY2yFCikwwk4NPzxTCNPorEbel5n83sXi+t/TM2ncE
        +vawaeMw5b6UsPtxh+Dc0zvR9Y6wkrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647304893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFJZ7IEJtye5O5sn7N/zXb1V3GDdDyS0FpLf4ft883Y=;
        b=4EHrbSe3bC3nPlKINkv2SUNEo9dvHkPh1cnUMgFIrzGlZsWKvSqWSjcNR3hH9TZ/GbBdyw
        /Wt7+q7hzUHBnFDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7546D13ADA;
        Tue, 15 Mar 2022 00:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0w14C7vgL2IfVAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Mar 2022 00:41:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs.man: document requirements for NFSv4 identity
In-reply-to: <ED6618CE-EC09-448D-904C-F34FCE8E8935@oracle.com>
References: <164721984672.11933.15475930163427511814@noble.neil.brown.name>,
 <ED6618CE-EC09-448D-904C-F34FCE8E8935@oracle.com>
Date:   Tue, 15 Mar 2022 11:41:28 +1100
Message-id: <164730488811.11933.18315180827167871419@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 15 Mar 2022, Chuck Lever III wrote:
> Hi Neil-
>=20
> > On Mar 13, 2022, at 9:04 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> >=20
> > When mounting NFS filesystem in a network namespace using v4, some care
> > must be taken to ensure a unique and stable client identity.  Similar
> > case is needed for NFS-root and other situations.
> >=20
> > Add documentation explaining the requirements for the NFS identity in
> > these situations.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >=20
> > I think I've address most of the feedback, but please forgive and remind
> > if I missed something.
> > NeilBrown
> >=20
> > utils/mount/nfs.man | 109 +++++++++++++++++++++++++++++++++++++++++++-
> > 1 file changed, 108 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> > index d9f34df36b42..5f15abe8cf72 100644
> > --- a/utils/mount/nfs.man
> > +++ b/utils/mount/nfs.man
> > @@ -1,7 +1,7 @@
> > .\"@(#)nfs.5"
> > .TH NFS 5 "9 October 2012"
> > .SH NAME
> > -nfs \- fstab format and options for the
> > +nfs \- fstab format and configuration for the
> > .B nfs
> > file systems
>=20
> Suggest "configuration for nfs file systems" (remove "the")

Agreed.

>=20
>=20
> > .SH SYNOPSIS
> > @@ -1844,6 +1844,113 @@ export pathname, but not both, during a remount. =
 For example,
> > merges the mount option
> > .B ro
> > with the mount options already saved on disk for the NFS server mounted a=
t /mnt.
> > +.SH "NFS CLIENT IDENTIFIER"
> > +NFSv4 requires that the client present a unique identifier to the server
> > +to be used to track state such as file locks.  By default Linux NFS uses
> > +the host name, as configured at the time of the first NFS mount,
> > +together with some fixed content such as the name "Linux NFS" and the
> > +particular protocol version.  When the hostname is guaranteed to be
> > +unique among all client which access the same server this is sufficient.
> > +If hostname uniqueness cannot be assumed, extra identity information
> > +must be provided.
>=20
> The last sentence is made ambiguous by the use of passive voice.
>=20
> Suggest: "When hostname uniqueness cannot be guaranteed, the client
> administrator must provide extra identity information."

Why must the client administrator do this?  Why can't some automated
tool do this?  Or some container-building environment.
That's an advantage of the passive voice, you don't need to assign
responsibility for the verb.

>=20
> I have a problem with basing our default uniqueness guarantee on
> hostnames "most of the time" hoping it will all work out. There
> are simply too many common cases where hostname stability can't be
> relied upon. Our sustaining teams will happily tell us this hope
> hasn't so far been born out.

Maybe it has not been born out because there is no documented
requirement for it that we can point people to.
Clearly containers that use NFS are not currently all configured well to do
this.  Some change is needed.  Maybe adding a unique host name is the
easiest change ... or maybe not.

Surely NFS is not the *only* service that uses the host name.
Encouraging the use of unique host names might benefit others.

The practical reality is that a great many NFS client installations do
currently depend on unique host names - after all, it actually works.
Is it really so unreasonable to try to encourage the exceptions to fit
the common pattern better?

>=20
> I also don't feel that nfs(5) is an appropriate place for this level
> of detail. Documentation/filesystems/nfs/ is more appropriate IMO.
> In general, man pages are good for quick summaries, not for
> explainers. Here, it reads like "you, a user, are going to have to
> do this thing that is like filling out a tax form" -- in reality it
> should be information that should be:
>=20
>  - Ignorable by most folks
>  - Used by distributors to add value by automating set up
>  - Used for debugging large client installations

nfs(5) contains sections on TRANSPORT METHODS, DATA AND METADATA
COHERENCE, SECURITY CONSIDERATIONS.  Is this section really out of
place?=20

I could agree that all of these sections belong in "section 7" (Overview,
conventions, and miscellaneous) rather than "section 5" (File formats and
configuration files) but we don't have nfs.7 (yet).  I think section 7
is a reasonable fit for your 3 points above.

I don't agree that Documentation/filesystems/nfs/ is sufficient.  That
is (from my perspective) primarily of interest to kernel developers.
The whole point of this exercise that at we need to reach people outside
of that group.

>=20
> Maybe I'm just stating this to understand the purpose of this
> patch, but it could also be used as an "Intended audience"
> disclaimer in this new section.

OK, so the "purpose of this patch" relates in part to a comment you made
earlier, which I include here:

> Since it is just a line or two of code, it might be of little
> harm just to go with separate implementations for now and stop
> talking about it. If it sucks, we can fix the suckage.
>=20
> Who volunteers to implement this mechanism in mount.nfs ?

I don't think this is the best next step.  I think we need to get some
container system developer to contribute here.  So far we only have
second hand anecdotes about problems.  I think the most concrete is from
Ben suggesting that in at least one container system, using
/etc/machine-id is a good idea.

I don't think we can change nfs-utils (whether mount.nfs or mount.conf
or some other way) to set identity from /etc/machine-id for everyone.
So we need at least for that container system to request that change.

How would they like to do that?

I suggest that we explain the problem to representatives of the various
container communities that we have contact with (Well...  "you", more
than "we" as I don't have contacts).

We could use the documentation I provided to clearly present the
problem.
Then ask:
  - would you like to just run some shell code (see examples)
  - or would you like to provide an /etc/nfs.conf.d/my-container.conf
  - or would you like to run a tool that we provide
  - or is there already a push to provide unique container hostnames,
    and is this the incentive you need to help that push across the
    line?

If we have someone from $CONTAINER_COMMUNITY say "if you do this thing,
then we will use it", then that would be hard to argue with.
If we could get two or three different communities to comment, I expect
the best answer would become a lot more obvious.

But first we, ourselves, need to agree on the document :-)


>=20
>=20
> > +.PP
> > +Some situations which are known to be problematic with respect to unique
> > +host names include:
>=20
> A little wordy.
>=20
> Suggest: "Situations known to be problematic with respect to unique
> hostnames include:"

Yep.

>=20
> If this will eventually become part of nfs(5), I would first run
> this patch by documentation experts, because they might have a
> preference for "hostnames" over "host names" and "namespaces" over
> "name-spaces". Usage of these terms throughout this patch is not
> consistent.

I've made it consistently "hostname" and "namespace" which is consistent
with the rest of the document

>=20
>=20
> > +.IP \- 2
> > +NFS-root (diskless) clients, where the DCHP server (or equivalent) does
> > +not provide a unique host name.
>=20
> Suggest this addition:
>=20
> .IP \- 2
>=20
> Dynamically-assigned hostnames, where the hostname can be changed after
> a client reboot, while the client is booted, or if a client often=20
> repeatedly connects to multiple networks (for example if it is moved
> from home to an office every day).

This is a different kettle of fish.  The hostname is *always* included
in the identifier.  If it isn't stable, then the identifier isn't
stable.

I saw in the history that when you introduced the module parameter it
replaced the hostname.  This caused problems in containers (which had
different host names) so Trond changed it so the module parameter
supplemented the hostname.

If hostnames are really so poorly behaved I can see there might be a
case to suppress the hostname, but we don't have that option is current
kernels.  Should we add it?

>=20
>=20
> > +.IP \- 2
> > +"containers" within a single Linux host.  If each container has a separa=
te
> > +network namespace, but does not use the UTS namespace to provide a unique
> > +host name, then there can be multiple effective NFS clients with the
> > +same host name.
> > +.IP \=3D 2
>=20
> .IP \- 2

Thanks.

>=20
>=20
> > +Clients across multiple administrative domains that access a common NFS
> > +server.  If assignment of host name is devolved to separate domains,
>=20
> I don't recognize the phrase "assignment is devolved to separate domains".
> Can you choose a friendlier way of saying this?
>=20

 If hostnames are not assigned centrally then uniqueness cannot be
 guaranteed unless a domain name is included in the hostname.

>=20
> > +uniqueness cannot be guaranteed, unless a domain name is included in the
> > +host name.
> > +.SS "Increasing Client Uniqueness"
> > +Apart from the host name, which is the preferred way to differentiate
> > +NFS clients, there are two mechanisms to add uniqueness to the
> > +client identifier.
> > +.TP
> > +.B nfs.nfs4_unique_id
> > +This module parameter can be set to an arbitrary string at boot time, or
> > +when the=20
> > +.B nfs
> > +module is loaded.  This might be suitable for configuring diskless clien=
ts.
>=20
> Suggest: "This is suitable for"

OK

>=20
>=20
> > +.TP
> > +.B /sys/fs/nfs/client/net/identifier
> > +This virtual file (available since Linux 5.3) is local to the network
> > +name-space in which it is accessed and so can provided uniqueness between
> > +network namespaces (containers) when the hostname remains uniform.
>=20
> ^provided^provide
>=20
> ^between^amongst
>=20
> and the clause at the end confused me.
>=20
> Suggest: "in which it is accessed and thus can provide uniqueness
> amongst network namespaces (containers)."

The clause at the end was simply emphasising that the identifer is only
needed if the hostname does not vary across containers.  I have removed it.

>=20
>=20
> > +.RS
> > +.PP
> > +This value is empty on name-space creation.
> > +If the value is to be set, that should be done before the first
> > +mount.  If the container system has access to some sort of per-container
> > +identity then that identity, possibly obfuscated as a UUID is privacy is
> > +needed, can be used.  Combining the identity with the name of the
> > +container systems would also help.
>=20
> I object to recommending obfuscation via a UUID.
>=20
> 1. This is confusing because there has been no mention of any
>    persistence requirement so far. At this point, a reader
>    might think that the client can simply convert the hostname
>    and netns identifier every time it boots. However this is
>    only OK to do if these things are guaranteed not to change
>    during the lifetime of a client. In a world where a majority
>    of systems get their hostnames dynamically, I think this is
>    a shaky foundation.

If the hostname changes after boot (weird concept ..  does that really
happen?) that is irrelevant.  The hostname is copied at boot by NFS, and
if it is included in the /sys/fs/nfs/client/identifier (which would be
pointless, but not harmful) it has again been copied.

If it is different on subsequent boots, then that is a big problem and
not one that we can currently fix.

....except that non-persistent client identifiers isn't an enormous
problem, just a possible cause of delays.

>=20
> 2. There's no requirement that this uniquifier be in the form
>    of a UUID anywhere in specifications, and the Linux client
>    itself does not add such a requirement. (You suggested
>    before that we should start by writing down requirements.
>    Using a UUID ain't a requirement).

The requirement here is that /etc/machine-id is documented as requiring
obfuscation.  uuidgen is a convenient way to provide obfuscation.  That
is all I was trying to say.

>=20
>    Linux chooses to implement its uniquifer with a UUID because
>    it is assumed we are using a random UUID (rather than a
>    name-based or time-based UUID). A random UUID has strong
>    global uniqueness guarantees, which guarantees the client
>    identifier will always be unique amongst clients in nearly
>    all situations for nearly no cost.
>=20

"Linux chooses" what does that mean?  I've lost the thread here, sorry.


> If we want to create a good uniquifier here, then combine the
> hostname, netns identity, and/or the host's machine-id and then
> hash that blob with a known strong digest algorithm like
> SHA-256. A man page must not recommend the use of deprecated or
> insecure obfuscation mechanisms.

I didn't realize the hash that uuidgen uses was deprecated.  Is there
some better way to provide an app-specific obfuscation of a string from
the command line?

Maybe
    echo nfs-id:`cat /etc/machine-id`| sha256sum

??

>=20
> The man page can suggest a random-based UUID as long as it
> states plainly that such UUIDs have global uniqueness guarantees
> that make them suitable for this purpose. We're using a UUID
> for its global uniqueness properties, not because of its
> appearance.

So I could use "/etc/nfsv4-identity" instead of "/etc/nfs4-uuid".
What else should I change/add.

>=20
>=20
> >  For example:
> > +.RS 4
> > +echo "ip-netns:`ip netns identify`" \\
> > +.br
> > +   > /sys/fs/nfs/client/net/identifier=20
> > +.br
> > +uuidgen --sha1 --namespace @url  \\
> > +.br
> > +   -N "nfs:`cat /etc/machine-id`" \\
> > +.br
> > +   > /sys/fs/nfs/client/net/identifier=20
> > +.RE
> > +If the container system provides no stable name,
> > +but does have stable storage,
>=20
> Here's the first mention of "stable". It needs some
> introduction far above.

True.  So the first para becomes:

  NFSv4 requires that the client present a stable unique identifier to
  the server to be used to track state such as file locks.  By default
  Linux NFS uses the hostname, as configured at the time of the first
  NFS mount, together with some fixed content such as the name "Linux
  NFS" and the particular protocol version.  When the hostname is
  guaranteed to be unique among all client which access the same server,
  and stable across reboots, this is sufficient.  If hostname uniqueness
  cannot be assumed, extra identity information must be provided.  If
  the hostname is not stable, unclean restarts may suffer unavoidable
  delays.

>=20
>=20
> > then something like
> > +.RS 4
> > +[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&=20
> > +.br
> > +cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier=20
> > +.RE
> > +would suffice.
> > +.PP
> > +If a container has neither a stable name nor stable (local) storage,
> > +then it is not possible to provide a stable identifier, so providing
> > +a random identifier to ensure uniqueness would be best
> > +.RS 4
> > +uuidgen > /sys/fs/nfs/client/net/identifier
> > +.RE
> > +.RE
> > +.SS Consequences of poor identity setting
>=20
> This section provides context to understand the above technical
> recommendations. I suggest this whole section should be moved
> to near the opening paragraph.

I seem to keep moving things upwards....  something has to come last.
Maybe a "(See below)" at the end of the revised first para?

>=20
>=20
> > +Any two concurrent clients that might access the same server must have
> > +different identifiers for correct operation, and any two consecutive
> > +instances of the same client should have the same identifier for optimal
> > +crash recovery.
>=20
> Also recovery from network partitions.

A network partition doesn't coincide with two consecutive instances of the
same client.  There is just one client instance and one server instance.

>=20
>=20
> > +.PP
> > +If two different clients present the same identity to a server there are
> > +two possible scenarios.  If the clients use the same credential then the
> > +server will treat them as the same client which appears to be restarting
> > +frequently.  One client may manage to open some files etc, but as soon
> > +as the other client does anything the first client will lose access and
> > +need to re-open everything.
>=20
> This seems fuzzy.
>=20
> 1. If locks are lost, then there is a substantial risk of data
>    corruption.
>=20
> 2. Is the client itself supposed to re-open files, or are
>    applications somehow notified that they need to re-open?
>    Either of these scenarios is fraught -- I don't believe any
>    application is coded to expect to have to re-open a file
>    due to exigent circumstances.

I wasn't very happy with the description either.  I think we want some
detail, but not too much.

The "re-opening" that I mentioned is the NFS client resubmitting NFS
OPEN requests, not the application having to re-open.
However if the application manages to get a lock, then when the "other"
client connects to the server the application will lose the lock, and
all read/write accesses on the relevant fd will result in EIO (I
think).  Clearly bad.

I wanted to say the clients could end up "fighting" with each other -
the EXCHANGE_ID from one destroys the state set up by the other - I that
seems to be too much anthropomorphism.

    If two different clients present the same identity to a server there
    are two possible scenarios.  If the clients use the same credential
    then the server will treat them as the same client which appears to
    be restarting frequently.  The clients will each enter a loop where
    they establish state with the server and then find that the state
    has been destroy by the other client and so will need to establish
    it again.

???

>=20
>=20
> > +.PP
> > +If the clients use different credentials, then the second client to
> > +establish a connection to the server will be refused access.  For=20
> > +.B auth=3Dsys
> > +the credential is based on hostname, so will be the same if the
> > +identities are the same.  With
> > +.B auth=3Dkrb
> > +the credential is stored in=20
> > +.I /etc/krb5.keytab
> > +and will be the same only if this is copied among hosts.
>=20
> This language implies that copying the keytab is a recommended thing
> to do. It's not. I mentioned it before because some customers think
> it's OK to use the same keytab across their client fleet. But obviously
> that will result in lost open and lock state.=20
>=20
> I suggest rephrasing this last sentence to describe the negative lease
> recovery consequence of two clients happening to share the same host
> principal -- as in "This is why you shouldn't share keytabs..."
>=20

How about

.PP
If the clients use different credentials, then the second client to
establish a connection to the server will be refused access which is a
safer failure mode.  For
.B auth=3Dsys
the credential is based on hostname, so will be the same if the
identities are the same.  With
.B auth=3Dkrb
the credential is stored in=20
.I /etc/krb5.keytab
so providing this isn't copied among client the safer failure mode will resul=
t.


??

Thanks for your details review!

NeilBrown

>=20
> > +.PP
> > +If the identity is unique but not stable, for example if it is generated
> > +randomly on each start up of the NFS client, then crash recovery is
> > +affected.  When a client shuts down uncleanly and restarts, the server
> > +will normally detect this because the same identity is presented with
> > +different boot time (or "incarnation verifier"), and will discard old
> > +state.  If the client presents a different identifier, then the server
> > +cannot discard old state until the lease time has expired, and the new
> > +client may be delayed in opening or locking files that it was
> > +previously accessing.
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
