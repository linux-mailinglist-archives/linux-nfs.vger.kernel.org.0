Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2339E4DD2B5
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Mar 2022 03:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiCRCB6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Mar 2022 22:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiCRCB6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Mar 2022 22:01:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC22104A76
        for <linux-nfs@vger.kernel.org>; Thu, 17 Mar 2022 19:00:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27C121F37F;
        Fri, 18 Mar 2022 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647568828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEZr41uihxH3FsCaco4jowgLhp5TkkFwuau7a8qCSQQ=;
        b=l34QgsGip+Lcpc/DxUQemKz27neF+jeFp0jG18ODlqywLKPPjYWMGrsSCZSHxQUf/Zuqmc
        wStkVX05KuZSrBVv4ocItgqrbmBWAJ71tTJ8F9y+bCwDBAnN0LrFlsU+jqTC/WYX+Fezq0
        KE7nELrL9PNuYdWueVfpkv/B9wHTvFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647568828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEZr41uihxH3FsCaco4jowgLhp5TkkFwuau7a8qCSQQ=;
        b=79qCHIovTM7ReIDLvBUranbku6AAnF88ehToId1udoW/DEz5ljn4INwPvdlyg0uVfypqan
        5G7fyezeK5bXtpAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D6A413B01;
        Fri, 18 Mar 2022 02:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dXxwA7rnM2KqMwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 18 Mar 2022 02:00:26 +0000
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
In-reply-to: <9A7BF2ED-E125-4FEF-B984-C343C9E142F0@oracle.com>
References: <164721984672.11933.15475930163427511814@noble.neil.brown.name>,
 <ED6618CE-EC09-448D-904C-F34FCE8E8935@oracle.com>,
 <164730488811.11933.18315180827167871419@noble.neil.brown.name>,
 <9A7BF2ED-E125-4FEF-B984-C343C9E142F0@oracle.com>
Date:   Fri, 18 Mar 2022 13:00:16 +1100
Message-id: <164756881642.24302.4153094189268832687@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 17 Mar 2022, Chuck Lever III wrote:
> Howdy Neil-

G'day

> >> The last sentence is made ambiguous by the use of passive voice.
> >>=20
> >> Suggest: "When hostname uniqueness cannot be guaranteed, the client
> >> administrator must provide extra identity information."
> >=20
> > Why must the client administrator do this?  Why can't some automated
> > tool do this?  Or some container-building environment.
> > That's an advantage of the passive voice, you don't need to assign
> > responsibility for the verb.
>=20
> My point is that in order to provide the needed information,
> elevated privilege is required. The current sentence reads as
> if J. Random User could be interrupted at some point and asked
> for help.
>=20
> In other words, the documentation should state that this is
> an administrative task. Here I'm not advocating for a specific
> mechanism to actually perform that task.

???  This whole man page is primarily about mount options, particularly
as they appear in /etc/fstab.  These are not available to the non-admin.
Why would anyone think this section is any different?

>=20
>=20
> >> I have a problem with basing our default uniqueness guarantee on
> >> hostnames "most of the time" hoping it will all work out. There
> >> are simply too many common cases where hostname stability can't be
> >> relied upon. Our sustaining teams will happily tell us this hope
> >> hasn't so far been born out.
> >=20
> > Maybe it has not been born out because there is no documented
> > requirement for it that we can point people to.
> > Clearly containers that use NFS are not currently all configured well to =
do
> > this.  Some change is needed.  Maybe adding a unique host name is the
> > easiest change ... or maybe not.
>=20
> You seem to be documenting the client's current behavior.
> The tone of the documentation is that this behavior is fine
> and works for most people.

It certainly works for a lot of people.  Many people are using NFSv4
quite effectively.  I'm sure there are people who are having problems
too, but let's not fall for the squeaky wheel fallacy.

>=20
> It's the second part that I disagree with. Oracle Linux has
> bugs documenting this behavior is a problem, and I'm sure
> Red Hat does too. The current behavior is broken. It is this
> brokeness that we are trying to resolve.

The current behaviour of NFS is NOT broken.  Maybe is it not adequately
robust against certain configuration choices.  Certainly we should make
it as robust as we reasonably can.  But let's not overstate the problem.

>=20
> So let me make a stronger statement: we should not
> document that broken behavior in nfs(5). Instead, we should
> fix that behavior, and then document the golden brown and
> delicious behavior. Updating nfs(5) first is putting
> DeCarte in front of de horse.
>=20
>=20
> > Surely NFS is not the *only* service that uses the host name.
> > Encouraging the use of unique host names might benefit others.
>=20
> Unless you have specific use cases that might benefit from
> ensuring hostname uniqueness, I would beg that you stay
> focused on the immediate issue of how the Linux client
> constructs its nfs_client_id4 strings.
>=20
>=20
> > The practical reality is that a great many NFS client installations do
> > currently depend on unique host names - after all, it actually works.
> > Is it really so unreasonable to try to encourage the exceptions to fit
> > the common pattern better?
>=20
> Yes it is unreasonable.
>=20
> NFS servers typically have a fixed DNS presence. They have
> to because clients mount by hostname.
>=20
> NFS clients, on the other hand, are not under that constraint.
> The only time I can think of where a client has to have a
> fixed hostname is if a krb5 host principal is involved.
>=20
> In so many other cases, eg. mobile computing or elastic
> services, the client hostname is mutable. I don't think
> it's fair to put another constraint on host naming here,
> especially one with implications of service denial or
> data corruption (see below).
>=20
>=20
> >> Maybe I'm just stating this to understand the purpose of this
> >> patch, but it could also be used as an "Intended audience"
> >> disclaimer in this new section.
> >=20
> > OK, so the "purpose of this patch" relates in part to a comment you made
> > earlier, which I include here:
> >=20
> >> Since it is just a line or two of code, it might be of little
> >> harm just to go with separate implementations for now and stop
> >> talking about it. If it sucks, we can fix the suckage.
> >>=20
> >> Who volunteers to implement this mechanism in mount.nfs ?
> >=20
> > I don't think this is the best next step.  I think we need to get some
> > container system developer to contribute here.  So far we only have
> > second hand anecdotes about problems.  I think the most concrete is from
> > Ben suggesting that in at least one container system, using
> > /etc/machine-id is a good idea.
> >=20
> > I don't think we can change nfs-utils (whether mount.nfs or mount.conf
> > or some other way) to set identity from /etc/machine-id for everyone.
> > So we need at least for that container system to request that change.
> >=20
> > How would they like to do that?
> >=20
> > I suggest that we explain the problem to representatives of the various
> > container communities that we have contact with (Well...  "you", more
> > than "we" as I don't have contacts).
>=20
> I'm all for involving one or more container experts. But IMO
> it's not appropriate to update our man page to do that. Let's
> update nfs(5) when we are done with this effort.

Don't let perfect be the enemy of good.
We were making no progress with "fixing" nfs.  Documenting "how it works
today" should never be a bad thing.  Obviously we can (and must) update
the documentation when we update the behaviour.

But if some concrete behavioural changes can be agreed and implemented
through this discussion, I'm happy for the documentation to land only
after those changes.

>=20
>=20
> > We could use the documentation I provided to clearly present the
> > problem.
>=20
> No doubt, we need a crisp problem statement!
>=20
>=20
> > Then ask:
> >  - would you like to just run some shell code (see examples)
> >  - or would you like to provide an /etc/nfs.conf.d/my-container.conf
> >  - or would you like to run a tool that we provide
> >  - or is there already a push to provide unique container hostnames,
> >    and is this the incentive you need to help that push across the
> >    line?
> >=20
> > If we have someone from $CONTAINER_COMMUNITY say "if you do this thing,
> > then we will use it", then that would be hard to argue with.
> > If we could get two or three different communities to comment, I expect
> > the best answer would become a lot more obvious.
> >=20
> > But first we, ourselves, need to agree on the document :-)
>=20
> If the community is seeking help, then a wiki might be a better
> place to formulate a problem statement.
>=20
>=20
> >>> +.PP
> >>> +Some situations which are known to be problematic with respect to uniq=
ue
> >>> +host names include:
> >>=20
> >> A little wordy.
> >>=20
> >> Suggest: "Situations known to be problematic with respect to unique
> >> hostnames include:"
> >=20
> > Yep.
> >=20
> >>=20
> >> If this will eventually become part of nfs(5), I would first run
> >> this patch by documentation experts, because they might have a
> >> preference for "hostnames" over "host names" and "namespaces" over
> >> "name-spaces". Usage of these terms throughout this patch is not
> >> consistent.
> >=20
> > I've made it consistently "hostname" and "namespace" which is consistent
> > with the rest of the document
> >=20
> >>=20
> >>=20
> >>> +.IP \- 2
> >>> +NFS-root (diskless) clients, where the DCHP server (or equivalent) does
> >>> +not provide a unique host name.
> >>=20
> >> Suggest this addition:
> >>=20
> >> .IP \- 2
> >>=20
> >> Dynamically-assigned hostnames, where the hostname can be changed after
> >> a client reboot, while the client is booted, or if a client often=20
> >> repeatedly connects to multiple networks (for example if it is moved
> >> from home to an office every day).
> >=20
> > This is a different kettle of fish.  The hostname is *always* included
> > in the identifier.  If it isn't stable, then the identifier isn't
> > stable.
> >=20
> > I saw in the history that when you introduced the module parameter it
> > replaced the hostname.  This caused problems in containers (which had
> > different host names) so Trond changed it so the module parameter
> > supplemented the hostname.
> >=20
> > If hostnames are really so poorly behaved I can see there might be a
> > case to suppress the hostname, but we don't have that option is current
> > kernels.  Should we add it?
>=20
> I claim that it has become problematic to use the hostname in the
> nfs_client_id4 string.

In that case, we should fix it - make it possible to exclude the
hostname from the nfs_client_id4 string.  You make a convincing case.
Have you thoughts on how we should implement that?

Add a new bool sysfs attribute: identity_includes_hostname which
defaults to true and the current behaviour, but which can be set to
false?  Or should it transparently be set to false when the "identity"
is set?=20

>=20
> 25 years ago when NFSv4.0 was being crafted, it was assumed that
> client hostnames were unchanging. The original RFC 3010 recommended
> adding the hostname, the client IP address, and the server IP
> address to the nfs_client_id4 string.
>=20
> Since then, we've learned that the IP addresses are quite mutable,
> and thus not appropriate for a fixed identifier. I argue that the
> client's hostname is now the same.
>=20
> The Linux NFSv4 prototype and subsequent production code used the
> local hostname because it's easy to access in the kernel via the
> UTS name. That was adequate 20 years ago, but has become less so
> over time. You can view this evolution in the commit log.
>=20
> It doesn't seem that complicated (to me) to divorce the client_id4
> string from the local hostname, and the benefits are significant.
>=20
>=20
> >>> +.IP \- 2
> >>> +"containers" within a single Linux host.  If each container has a sepa=
rate
> >>> +network namespace, but does not use the UTS namespace to provide a uni=
que
> >>> +host name, then there can be multiple effective NFS clients with the
> >>> +same host name.
> >>> +.IP \=3D 2
> >>=20
> >> .IP \- 2
> >=20
> > Thanks.
> >=20
> >>=20
> >>=20
> >>> +Clients across multiple administrative domains that access a common NFS
> >>> +server.  If assignment of host name is devolved to separate domains,
> >>=20
> >> I don't recognize the phrase "assignment is devolved to separate domains=
".
> >> Can you choose a friendlier way of saying this?
> >>=20
> >=20
> > If hostnames are not assigned centrally then uniqueness cannot be
> > guaranteed unless a domain name is included in the hostname.
>=20
> Better, thanks.
>=20
>=20
> >>> +.RS
> >>> +.PP
> >>> +This value is empty on name-space creation.
> >>> +If the value is to be set, that should be done before the first
> >>> +mount.  If the container system has access to some sort of per-contain=
er
> >>> +identity then that identity, possibly obfuscated as a UUID is privacy =
is
> >>> +needed, can be used.  Combining the identity with the name of the
> >>> +container systems would also help.
> >>=20
> >> I object to recommending obfuscation via a UUID.
> >>=20
> >> 1. This is confusing because there has been no mention of any
> >>   persistence requirement so far. At this point, a reader
> >>   might think that the client can simply convert the hostname
> >>   and netns identifier every time it boots. However this is
> >>   only OK to do if these things are guaranteed not to change
> >>   during the lifetime of a client. In a world where a majority
> >>   of systems get their hostnames dynamically, I think this is
> >>   a shaky foundation.
> >=20
> > If the hostname changes after boot (weird concept ..  does that really
> > happen?) that is irrelevant.
>=20
> It really happens. A DHCP lease renewal can do it. Moving to a
> new subnet on the same campus might do it. I can open "Device
> Settings" on my laptop and change my laptop's hostname on a
> whim. Joining a VPN might do it.
>=20
> A client might have multiple network interfaces, each with a
> unique hostname. Which one should be used for the nfs_client_id4
> string? RFCs 7931 and 8587 discuss how trunking needs to work:
> the upshot is that the client needs to have one consistent
> nfs_client_id4 string it presents to all servers (in case of
> migration) no matter which network path it uses to access the
> server.
>=20
>=20
> > The hostname is copied at boot by NFS, and
> > if it is included in the /sys/fs/nfs/client/identifier (which would be
> > pointless, but not harmful) it has again been copied.
> >=20
> > If it is different on subsequent boots, then that is a big problem and
> > not one that we can currently fix.
>=20
> Yes, we can fix it: don't use the client's hostname but
> instead use a separate persistent uniquifier, as has been
> proposed.
>=20
>=20
> > ....except that non-persistent client identifiers isn't an enormous
> > problem, just a possible cause of delays.
>=20
> I disagree, it's a significant issue.
>=20
> - If locks are lost, that is a potential source of data corruption.
>=20
> - If a lease is stolen, that is a denial of service.
>=20
> Our customers take this very seriously.

Of course, as they should.  data integrity is paramount.
non-persistent client identifier doesn't put that as risk - not in and
of itself.

If a client's identifier changed during the lifetime of one instance of
the client, then that would allow locks to be lost.  That does NOT
happen just because you happen to change the host name.  The hostname is
copied at first use.
It *could* happen if you changed the module parameter or sysfs identity
after the first mount, but I hope we can agree that not a justifiable
action.

A lease can only be "stolen" by a non-unique identifier, not simply by
non-persistent identifiers.  But maybe this needs a caveat.

If a set of clients are each given host names from time to time which
are, at any moment in time, unique, but are able to "migrate" from one
client to another, then it would be possible for two clients to both
have performed their first NFS mount when they have some common
hosttname X.  The "first" was given host X at boot time, it mounted
something.  The hostname was subsequently change to Y and some other
host booted and got X and then mounted from the same server.  This
would be seriously problematic.  I class this as "non-unique" hostnames,
not as non-persistent-identifier.

>                                         The NFS clients's
> out-of-the-shrink-wrap default behavior/configuration should be
> conservative enough to prevent these issues. Customers store
> mission critical data via NFS. Most customers expect NFS to work
> reliably without a lot of configuration fuss.

I've been working on the assumption that it is not possible to provide
ideal zero-config behaviour "out-of-the-shrink-wrap".  You have hinted
(or more) a few times that this is your goal.  Certainly a worthy goal if
possible.  Is it possible?

I contend that if there is no common standard for how containers (and
network namespaces in particular) are used, then it is simply not
possible to provide perfect out-of-the-box behaviour.  There *must* be
some local configuration that we cannot enforce through the kernel or
through nfs-utils.  We can offer, but we cannot enforce.  So we must
document.

The very best that we could do would be to provide a random component to
the identifier unless we had a high level of confidence that a unique
identifier had been provided some other way.  I don't know how to get
that high level of confidence in a way that doesn't break working
configurations.
Ben suggested defaulting 'identity' to a random string for any network
namespace other than init.  I don't think that is cautious enough.
Maybe if we did it when the network namespace is not init, but the UTS
namepsace is init.  But that feels like a hack and is probably brittle.

Can you suggest *any* way to improve the "out-of-shrink-wrap" behaviour
significantly?=20

>=20
>=20
> >> 2. There's no requirement that this uniquifier be in the form
> >>   of a UUID anywhere in specifications, and the Linux client
> >>   itself does not add such a requirement. (You suggested
> >>   before that we should start by writing down requirements.
> >>   Using a UUID ain't a requirement).
> >=20
> > The requirement here is that /etc/machine-id is documented as requiring
> > obfuscation.  uuidgen is a convenient way to provide obfuscation.  That
> > is all I was trying to say.
>=20
> Understood, but the words you used have some additional
> implications that you might not want.
>=20
>=20
> >>   Linux chooses to implement its uniquifer with a UUID because
> >>   it is assumed we are using a random UUID (rather than a
> >>   name-based or time-based UUID). A random UUID has strong
> >>   global uniqueness guarantees, which guarantees the client
> >>   identifier will always be unique amongst clients in nearly
> >>   all situations for nearly no cost.
> >>=20
> >=20
> > "Linux chooses" what does that mean?  I've lost the thread here, sorry.
>=20
> Try instead: "The documentation regarding the nfs_unique_id
> module parameter suggests the use of a UUID because..."

Ahhhh... that makes sense now - thanks.
That documentation needs to be updated.  It still says "used instead of
a system's node name" while the code currently implements "used together
with ..."

>=20
>=20
> >> If we want to create a good uniquifier here, then combine the
> >> hostname, netns identity, and/or the host's machine-id and then
> >> hash that blob with a known strong digest algorithm like
> >> SHA-256. A man page must not recommend the use of deprecated or
> >> insecure obfuscation mechanisms.
> >=20
> > I didn't realize the hash that uuidgen uses was deprecated.  Is there
> > some better way to provide an app-specific obfuscation of a string from
> > the command line?
> >=20
> > Maybe
> >    echo nfs-id:`cat /etc/machine-id`| sha256sum
> >=20
> > ??
>=20
> Something like that, yes. But the scriptlet needs to also
> involve the netns identity somehow.

Hmmm..  the impression I got from Ben was that the container system
ensured that /etc/machine-id was different in different containers.  So
there would be no need to add anything.  Of course I should make that
explicit in the documentation.

I would be nice if we could always use "ip netns identify", but that
doesn't seem to be generally supported.

>=20
>=20
> >> The man page can suggest a random-based UUID as long as it
> >> states plainly that such UUIDs have global uniqueness guarantees
> >> that make them suitable for this purpose. We're using a UUID
> >> for its global uniqueness properties, not because of its
> >> appearance.
> >=20
> > So I could use "/etc/nfsv4-identity" instead of "/etc/nfs4-uuid".
>=20
> I like. I would prefer not using "uuid" in the name. Ben and
> Steve were resistant to that idea, though.
>=20
>=20
> > What else should I change/add.
> >=20
> >>=20
> >>=20
> >>> For example:
> >>> +.RS 4
> >>> +echo "ip-netns:`ip netns identify`" \\
> >>> +.br
> >>> +   > /sys/fs/nfs/client/net/identifier=20
> >>> +.br
> >>> +uuidgen --sha1 --namespace @url  \\
> >>> +.br
> >>> +   -N "nfs:`cat /etc/machine-id`" \\
> >>> +.br
> >>> +   > /sys/fs/nfs/client/net/identifier=20
> >>> +.RE
> >>> +If the container system provides no stable name,
> >>> +but does have stable storage,
> >>=20
> >> Here's the first mention of "stable". It needs some
> >> introduction far above.
> >=20
> > True.  So the first para becomes:
> >=20
> >  NFSv4 requires that the client present a stable unique identifier to
> >  the server to be used to track state such as file locks.  By default
> >  Linux NFS uses the hostname, as configured at the time of the first
> >  NFS mount, together with some fixed content such as the name "Linux
> >  NFS" and the particular protocol version.  When the hostname is
> >  guaranteed to be unique among all client which access the same server,
> >  and stable across reboots, this is sufficient.  If hostname uniqueness
> >  cannot be assumed, extra identity information must be provided.  If
> >  the hostname is not stable, unclean restarts may suffer unavoidable
> >  delays.
>=20
> See above. The impact is more extensive than "unavoidable delays."
>=20
>=20
> >>> then something like
> >>> +.RS 4
> >>> +[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&=20
> >>> +.br
> >>> +cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier=20
> >>> +.RE
> >>> +would suffice.
> >>> +.PP
> >>> +If a container has neither a stable name nor stable (local) storage,
> >>> +then it is not possible to provide a stable identifier, so providing
> >>> +a random identifier to ensure uniqueness would be best
> >>> +.RS 4
> >>> +uuidgen > /sys/fs/nfs/client/net/identifier
> >>> +.RE
> >>> +.RE
> >>> +.SS Consequences of poor identity setting
> >>=20
> >> This section provides context to understand the above technical
> >> recommendations. I suggest this whole section should be moved
> >> to near the opening paragraph.
> >=20
> > I seem to keep moving things upwards....  something has to come last.
> > Maybe a "(See below)" at the end of the revised first para?
> >=20
> >>=20
> >>=20
> >>> +Any two concurrent clients that might access the same server must have
> >>> +different identifiers for correct operation, and any two consecutive
> >>> +instances of the same client should have the same identifier for optim=
al
> >>> +crash recovery.
> >>=20
> >> Also recovery from network partitions.
> >=20
> > A network partition doesn't coincide with two consecutive instances of the
> > same client.  There is just one client instance and one server instance.
>=20
> It's possible for one of the peers to reboot during the network
> partition.

True, but is that interesting?
There are situations where the client will lose locks no matter what it
does with its identity.  These don't have any impact on choices of what
you use for identity.  There are also situations where the client won't
lose locks.  These are equally irrelevant.=20

The only relevant situation (with respect to identifier stability) is
when the server reboots, and the client is able to contact the server
during the grace period.  If it doesn't use the same identity as it used
before, it can then lose locks.


>=20
>=20
> >>> +.PP
> >>> +If two different clients present the same identity to a server there a=
re
> >>> +two possible scenarios.  If the clients use the same credential then t=
he
> >>> +server will treat them as the same client which appears to be restarti=
ng
> >>> +frequently.  One client may manage to open some files etc, but as soon
> >>> +as the other client does anything the first client will lose access and
> >>> +need to re-open everything.
> >>=20
> >> This seems fuzzy.
> >>=20
> >> 1. If locks are lost, then there is a substantial risk of data
> >>   corruption.
> >>=20
> >> 2. Is the client itself supposed to re-open files, or are
> >>   applications somehow notified that they need to re-open?
> >>   Either of these scenarios is fraught -- I don't believe any
> >>   application is coded to expect to have to re-open a file
> >>   due to exigent circumstances.
> >=20
> > I wasn't very happy with the description either.  I think we want some
> > detail, but not too much.
> >=20
> > The "re-opening" that I mentioned is the NFS client resubmitting NFS
> > OPEN requests, not the application having to re-open.
> > However if the application manages to get a lock, then when the "other"
> > client connects to the server the application will lose the lock, and
> > all read/write accesses on the relevant fd will result in EIO (I
> > think).  Clearly bad.
> >=20
> > I wanted to say the clients could end up "fighting" with each other -
> > the EXCHANGE_ID from one destroys the state set up by the other - I that
> > seems to be too much anthropomorphism.
> >=20
> >    If two different clients present the same identity to a server there
> >    are two possible scenarios.  If the clients use the same credential
> >    then the server will treat them as the same client which appears to
> >    be restarting frequently.  The clients will each enter a loop where
> >    they establish state with the server and then find that the state
> >    has been destroy by the other client and so will need to establish
> >    it again.
> >=20
> > ???
>=20
> My colleague Calum coined the term "lease stealing". That might be
> a good thing to define somewhere and simply use that term as needed.
>=20

.PP
If two different clients present the same identity to a server there are
two possible scenarios.  If the clients do not use cryptographic
credentials, or use the same credential, then the server will treat them
as the same client which appears to be restarting frequently.  Each
client will effectively "steal" the lease established by the other and
neither will make useful progress.
.PP
If the clients use different cryptographic credentials, then the second
client to establish a connection to the server will be refused access
which is a safer failure mode.
.PP
Cryptographic credentials used to authenticate lease operations will be
the host principal from
.I /etc/krb5.keytab
or in some cases, the lone user principal.  These securely prevent lease
stealing.

>=20
> >>> +.PP
> >>> +If the clients use different credentials, then the second client to
> >>> +establish a connection to the server will be refused access.  For=20
> >>> +.B auth=3Dsys
> >>> +the credential is based on hostname, so will be the same if the
> >>> +identities are the same.  With
> >>> +.B auth=3Dkrb
> >>> +the credential is stored in=20
> >>> +.I /etc/krb5.keytab
> >>> +and will be the same only if this is copied among hosts.
> >>=20
> >> This language implies that copying the keytab is a recommended thing
> >> to do. It's not. I mentioned it before because some customers think
> >> it's OK to use the same keytab across their client fleet. But obviously
> >> that will result in lost open and lock state.=20
> >>=20
> >> I suggest rephrasing this last sentence to describe the negative lease
> >> recovery consequence of two clients happening to share the same host
> >> principal -- as in "This is why you shouldn't share keytabs..."
> >>=20
> >=20
> > How about
> >=20
> > .PP
> > If the clients use different credentials, then the second client to
> > establish a connection to the server will be refused access which is a
> > safer failure mode.  For
> > .B auth=3Dsys
> > the credential is based on hostname, so will be the same if the
> > identities are the same.  With
> > .B auth=3Dkrb
> > the credential is stored in=20
> > .I /etc/krb5.keytab
> > so providing this isn't copied among client the safer failure mode will r=
esult.
>=20
> With
> .BR auth=3Dkrb5 ,
> the client uses the host principal in
> .I /etc/krb5.keytab
> or in some cases, the lone user principal,
> to authenticate lease management operations.
> This securely prevents lease stealing.
>=20
>=20
>=20
> > ??
> >=20
> > Thanks for your details review!
> >=20
> > NeilBrown
> >=20
> >>=20
> >>> +.PP
> >>> +If the identity is unique but not stable, for example if it is generat=
ed
> >>> +randomly on each start up of the NFS client, then crash recovery is
> >>> +affected.  When a client shuts down uncleanly and restarts, the server
> >>> +will normally detect this because the same identity is presented with
> >>> +different boot time (or "incarnation verifier"), and will discard old
> >>> +state.  If the client presents a different identifier, then the server
> >>> +cannot discard old state until the lease time has expired, and the new
> >>> +client may be delayed in opening or locking files that it was
> >>> +previously accessing.
> >>> .SH FILES
> >>> .TP 1.5i
> >>> .I /etc/fstab
> >>> --=20
> >>> 2.35.1
> >>>=20
> >>=20
> >> --
> >> Chuck Lever
>=20
> --
> Chuck Lever
>=20

NeilBrown
