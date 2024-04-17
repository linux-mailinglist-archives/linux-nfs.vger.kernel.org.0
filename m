Return-Path: <linux-nfs+bounces-2863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4E8A79F2
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 02:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150AC1F222C1
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4056364;
	Wed, 17 Apr 2024 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G9hbrIEm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UrM4/XFI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G9hbrIEm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UrM4/XFI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67764C;
	Wed, 17 Apr 2024 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314653; cv=none; b=i4FqGsMIGg5Yqhsjhk9gOV7ThE7gXCz+/w5PBHz/HvbtRwH2IEqoIhF0N7st/CIMCUy0avhVBpU4KkcR0rL0hq1Z5/Lm+48BL1hF+/omyj1oNssdK9XGL37KCtFcMKWKIF8hYY5BP6cDFItLMtPoX0ixitk2JolPa1rXQ07jrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314653; c=relaxed/simple;
	bh=73D8atJlUbeSdHxOw+t6KXfhn/cnwkXx+aBpa2oegtY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aJFF7RRqSGSq93iccStFLb2NPcGoDXjTrmbArbHe9EepZLO88MZqSAkqPkDEi+LRTYjJys5Ut+xJcK1zSvSARmMVZnoS7v1V0MG1sCL3KbYKVLv/uGCb8E1PY+2YMywLaz8TPgTah38ZarWronjdI8oPMWTYqe2y/oZ23xAMvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G9hbrIEm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UrM4/XFI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G9hbrIEm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UrM4/XFI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F9EA22AC1;
	Wed, 17 Apr 2024 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713314649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqEfcgeWsOxLI5gdicc6L7/tqIl4eb/nOVL8VdGDytw=;
	b=G9hbrIEmrbh4E5jkk+dhU8DxV4xYMksOlV2FuquH4itkxz0AP9xbixG2qnNaAsTyxuztFy
	Md2VOGdFSmH99mvAoWmSRobXi6nI73XzBuGM5OczpS6FibO5JP1KtKqBwQUQ5kpRWZybbk
	XK0xiVlU/9KFwfPNiDbALm3L650Yt9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713314649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqEfcgeWsOxLI5gdicc6L7/tqIl4eb/nOVL8VdGDytw=;
	b=UrM4/XFISuCuI3vh5QyBya8gJvt5lrVicChBT8G3aTVQopn35IB8d1qt1ENaoKUWuQcj3Y
	odF2dBGpIp/QPxCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713314649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqEfcgeWsOxLI5gdicc6L7/tqIl4eb/nOVL8VdGDytw=;
	b=G9hbrIEmrbh4E5jkk+dhU8DxV4xYMksOlV2FuquH4itkxz0AP9xbixG2qnNaAsTyxuztFy
	Md2VOGdFSmH99mvAoWmSRobXi6nI73XzBuGM5OczpS6FibO5JP1KtKqBwQUQ5kpRWZybbk
	XK0xiVlU/9KFwfPNiDbALm3L650Yt9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713314649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqEfcgeWsOxLI5gdicc6L7/tqIl4eb/nOVL8VdGDytw=;
	b=UrM4/XFISuCuI3vh5QyBya8gJvt5lrVicChBT8G3aTVQopn35IB8d1qt1ENaoKUWuQcj3Y
	odF2dBGpIp/QPxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E41F31384C;
	Wed, 17 Apr 2024 00:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JgDlIVUbH2Z6MgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 17 Apr 2024 00:44:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
 lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, netdev@vger.kernel.org,
 kuba@kernel.org
Subject: Re: [PATCH v8 3/6] NFSD: add write_version to netlink command
In-reply-to: <5044bcf3bc796e76585e3a17b157dd3c47bea16a.camel@kernel.org>
References: <>, <5044bcf3bc796e76585e3a17b157dd3c47bea16a.camel@kernel.org>
Date: Wed, 17 Apr 2024 10:43:57 +1000
Message-id: <171331463783.17212.6690111336952371965@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Wed, 17 Apr 2024, Jeff Layton wrote:
> On Wed, 2024-04-17 at 09:05 +1000, NeilBrown wrote:
> > On Wed, 17 Apr 2024, Jeff Layton wrote:
> > > On Wed, 2024-04-17 at 07:48 +1000, NeilBrown wrote:
> > > > On Tue, 16 Apr 2024, Jeff Layton wrote:
> > > > > On Tue, 2024-04-16 at 13:16 +1000, NeilBrown wrote:
> > > > > > On Tue, 16 Apr 2024, Lorenzo Bianconi wrote:
> > > > > > > Introduce write_version netlink command through a "declarative"=
 interface.
> > > > > > > This patch introduces a change in behavior since for version-se=
t userspace
> > > > > > > is expected to provide a NFS major/minor version list it wants =
to enable
> > > > > > > while all the other ones will be disabled. (procfs write_version
> > > > > > > command implements imperative interface where the admin writes =
+3/-3 to
> > > > > > > enable/disable a single version.
> > > > > >=20
> > > > > > It seems a little weird to me that the interface always disables =
all
> > > > > > version, but then also allows individual versions to be disabled.
> > > > > >=20
> > > > > > Would it be reasonable to simply ignore the "enabled" flag when s=
etting
> > > > > > version, and just enable all versions listed??
> > > > > >=20
> > > > > > Or maybe only enable those with the flag, and don't disable those
> > > > > > without the flag?
> > > > > >=20
> > > > > > Those don't necessarily seem much better - but the current behavi=
our
> > > > > > still seems odd.
> > > > > >=20
> > > > >=20
> > > > > I think it makes sense.
> > > > >=20
> > > > > We disable all versions, and enable any that have the "enabled" fla=
g set
> > > > > in the call from userland. Userland technically needn't send down t=
he
> > > > > versions that are disabled in the call, but the current userland pr=
ogram
> > > > > does.
> > > > >=20
> > > > > I worry about imperative interfaces that might only say -- "enable =
v4.1,
> > > > > but disable v3" and leave the others in their current state. That
> > > > > requires that both the kernel and userland keep state about what
> > > > > versions are currently enabled and disabled, and it's possible to g=
et
> > > > > that wrong.
> > > >=20
> > > > I understand and support your aversion for imperative interfaces.
> > > > But this interface, as currently implemented, looks somewhat imperati=
ve.
> > > > The message sent to the kernel could enable some interfaces and then
> > > > disable them.  I know that isn't the intent, but it is what the code
> > > > supports.  Hence "weird".
> > > >=20
> > > > We could add code to make that sort of thing impossible, but there is=
n't
> > > > much point.  Better to make it syntactically impossible.
> > > >=20
> > > > Realistically there will never be NFSv4.3 as there is no need - new
> > > > features can be added incrementally.=C2=A0
> > > >=20
> > >=20
> > > There is no need _so_far_. Who knows what the future will bring? Maybe
> > > we'll need v4.3 in order to add some needed feature?
> > >=20
> > > >  So we could just pass an array of
> > > > 5 active flags: 2,3,4.0,4.1,4.2.  I suspect you wouldn't like that and
> > > > I'm not sure that I do either.  A "read" would return the same array
> > > > with 3 possible states: unavailable, disabled, enabled.  (Maybe the
> > > > array could be variable length so 5.0 could be added one day...).
> > > >=20
> > >=20
> > > A set of flags is basically what this interface is. They just happen to
> > > also be labeled with the major and minorversion. I think that's a good
> > > thing.
> >=20
> > Good for whom?  Labelling allows for labelling inconsistencies.
> >=20
>=20
> Now you're just being silly. You wanted a variable length array, but
> what if the next slot is not v4.3 but 5.0? A positional interpretation
> of a slot in an array is just as just as subject to problems.

I don't think it could look like a imperative interface, which the
current one does a bit.

>=20
> > Maybe the kernel should be able to provide an ordered list of labels,
> > and separately an array of which labels are enabled/disabled.
> > Userspace could send down a new set of enabled/disabled flags based on
> > the agreed set of labels.
> >=20
>=20
> How is this better than what's been proposed? One strength of netlink is
> that the data is structured. The already proposed interface takes
> advantage of that.
>=20
> > Here is a question that is a bit of a diversion, but might help us
> > understand the context more fully:
> >=20
> >   Why would anyone disable v4.2 separately from v4.1 ??
> >=20
>=20
> Furthermore, what does it mean to disable v4.1 but leave v4.2 enabled?

Indeed!

>=20
> > I understand that v2, v3, v4.0, v4.1 are effectively different protocols
> > and you might want to ensure that only the approved/tested protocol is
> > used.  But v4.2 is just a few enhancements on v4.1.  Why would you want
> > to disable it?
> >=20
> > The answer I can think of that there might be bugs (perish the
> > thought!!) in some of those features so you might want to avoid using
> > them.
> > But in that case, it is really the features that you want to suppress,
> > not the protocol version.
> >=20
> > Maybe I might want to disable delegation - to just write delegation.
> > Can I do that?  What if I just want to disable server-side copy, but
> > keep fallocate and umask support?
> >=20
> > i.e.  is a list of versions really the granularity that we want to use
> > for this interface?
> >=20
>=20
> Our current goal is to replace rpc.nfsd with a new program that works
> via netlink. An important bit of what rpc.nfsd does is start the NFS
> server with the settings in /etc/nfs.conf. Some of those settings are
> vers3=3D, vers4.0=3D, etc. that govern how /proc/fs/nfsd/versions is set.
> We have an immediate need to deal with those settings today, and
> probably will for quite some time.
>=20
> I'm not opposed to augmenting that with something more granular, but I
> don't think we should block this interface and wait on that. We can
> extend the interface at some point in the future to take a new feature
> bitmask or something, and just declare that (e.g.) declaring vers4.2=3Dn
> disables some subset of those features.

I agree that we don't want to block "good" while we wait for "perfect".  I
just want to be sure that what we have is "good".

The current /proc interface uses strings like "v3" and "v4.1".
The proposed netlink interface uses pairs on u32s - "major" and "minor".
So we lose some easy paths for extensibility.  Are we comfortable with
that?

This isn't a big deal - certainly not a blocked.  I just don't feel
entirely comfortable about the current interface and I'm exploring to
see if there might be something better.

Thanks,
NeilBrown


>=20
> >=20
> > >=20
> > > >=20
> > > > I haven't managed to come up with anything *better* than the current
> > > > proposal and I don't want to stand in its way, but I wanted to highli=
ght
> > > > that it looks weird - as much imperative as declarative - in case
> > > > someone else might be able to come up with a better alternative.
> > > >=20
> > >=20
> > > The intention was to create a symmetrical interface. We have 2
> > > operations: a "get" that asks "what versions are currently supported and
> > > are they enabled?", and a "set" that says "here is the new state of
> > > version enablement".
> > >=20
> > > The userland tool always sends down a complete set of versions. The
> > > kernel is (currently) more forgiving, and treats omitted versions as
> > > being disabled. The kernel could require that every supported version be
> > > represented in the "set" operation, if that's more desirable.
> > >=20
> > > > >=20
> > > > > My thinking was that by using a declarative interface like this, we
> > > > > eliminate ambiguity in how these interfaces are supposed to work. T=
he
> > > > > client sends down an entire version map in one fell swoop, and we k=
now
> > > > > exactly what the result should look like.
> > > > >=20
> > > > > Note that you can enable or disable just a single version with the
> > > > > userland tool, but this way all of that complexity stays in userlan=
d.
> > > > >=20
> > > > > > Also for getting the version, the doc says:
> > > > > >=20
> > > > > >      doc: get nfs enabled versions
> > > > > >=20
> > > > > > which I don't think it quite right.  The code reports all support=
ed
> > > > > > versions, and indicates which of those are enabled.  So maybe:
> > > > > >=20
> > > > > >      doc: get enabled status for all supported versions
> > > > > >=20
> > > > > >=20
> > > > > > I think that fact that it actually lists all supported versions is
> > > > > > useful and worth making explicit.
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > > Agreed. We should make that change before merging anything.
> > > > >=20
> > > > > > >=20
> > > > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > Tested-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > ---
> > > > > > >  Documentation/netlink/specs/nfsd.yaml |  37 +++++++
> > > > > > >  fs/nfsd/netlink.c                     |  24 +++++
> > > > > > >  fs/nfsd/netlink.h                     |   5 +
> > > > > > >  fs/nfsd/netns.h                       |   1 +
> > > > > > >  fs/nfsd/nfsctl.c                      | 150 ++++++++++++++++++=
++++++++
> > > > > > >  fs/nfsd/nfssvc.c                      |   3 +-
> > > > > > >  include/uapi/linux/nfsd_netlink.h     |  18 ++++
> > > > > > >  7 files changed, 236 insertions(+), 2 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentat=
ion/netlink/specs/nfsd.yaml
> > > > > > > index cbe6c5fd6c4d..0396e8b3ea1f 100644
> > > > > > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > > > > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > > > > > @@ -74,6 +74,26 @@ attribute-sets:
> > > > > > >        -
> > > > > > >          name: leasetime
> > > > > > >          type: u32
> > > > > > > +  -
> > > > > > > +    name: version
> > > > > > > +    attributes:
> > > > > > > +      -
> > > > > > > +        name: major
> > > > > > > +        type: u32
> > > > > > > +      -
> > > > > > > +        name: minor
> > > > > > > +        type: u32
> > > > > > > +      -
> > > > > > > +        name: enabled
> > > > > > > +        type: flag
> > > > > > > +  -
> > > > > > > +    name: server-proto
> > > > > > > +    attributes:
> > > > > > > +      -
> > > > > > > +        name: version
> > > > > > > +        type: nest
> > > > > > > +        nested-attributes: version
> > > > > > > +        multi-attr: true
> > > > > > > =20
> > > > > > >  operations:
> > > > > > >    list:
> > > > > > > @@ -120,3 +140,20 @@ operations:
> > > > > > >              - threads
> > > > > > >              - gracetime
> > > > > > >              - leasetime
> > > > > > > +    -
> > > > > > > +      name: version-set
> > > > > > > +      doc: set nfs enabled versions
> > > > > > > +      attribute-set: server-proto
> > > > > > > +      flags: [ admin-perm ]
> > > > > > > +      do:
> > > > > > > +        request:
> > > > > > > +          attributes:
> > > > > > > +            - version
> > > > > > > +    -
> > > > > > > +      name: version-get
> > > > > > > +      doc: get nfs enabled versions
> > > > > > > +      attribute-set: server-proto
> > > > > > > +      do:
> > > > > > > +        reply:
> > > > > > > +          attributes:
> > > > > > > +            - version
> > > > > > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > > > > > index 20a646af0324..bf5df9597288 100644
> > > > > > > --- a/fs/nfsd/netlink.c
> > > > > > > +++ b/fs/nfsd/netlink.c
> > > > > > > @@ -10,6 +10,13 @@
> > > > > > > =20
> > > > > > >  #include <uapi/linux/nfsd_netlink.h>
> > > > > > > =20
> > > > > > > +/* Common nested types */
> > > > > > > +const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_=
ENABLED + 1] =3D {
> > > > > > > +	[NFSD_A_VERSION_MAJOR] =3D { .type =3D NLA_U32, },
> > > > > > > +	[NFSD_A_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> > > > > > > +	[NFSD_A_VERSION_ENABLED] =3D { .type =3D NLA_FLAG, },
> > > > > > > +};
> > > > > > > +
> > > > > > >  /* NFSD_CMD_THREADS_SET - do */
> > > > > > >  static const struct nla_policy nfsd_threads_set_nl_policy[NFSD=
_A_SERVER_WORKER_LEASETIME + 1] =3D {
> > > > > > >  	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > > > > > > @@ -17,6 +24,11 @@ static const struct nla_policy nfsd_threads_=
set_nl_policy[NFSD_A_SERVER_WORKER_L
> > > > > > >  	[NFSD_A_SERVER_WORKER_LEASETIME] =3D { .type =3D NLA_U32, },
> > > > > > >  };
> > > > > > > =20
> > > > > > > +/* NFSD_CMD_VERSION_SET - do */
> > > > > > > +static const struct nla_policy nfsd_version_set_nl_policy[NFSD=
_A_SERVER_PROTO_VERSION + 1] =3D {
> > > > > > > +	[NFSD_A_SERVER_PROTO_VERSION] =3D NLA_POLICY_NESTED(nfsd_vers=
ion_nl_policy),
> > > > > > > +};
> > > > > > > +
> > > > > > >  /* Ops table for nfsd */
> > > > > > >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > > > > > >  	{
> > > > > > > @@ -38,6 +50,18 @@ static const struct genl_split_ops nfsd_nl_o=
ps[] =3D {
> > > > > > >  		.doit	=3D nfsd_nl_threads_get_doit,
> > > > > > >  		.flags	=3D GENL_CMD_CAP_DO,
> > > > > > >  	},
> > > > > > > +	{
> > > > > > > +		.cmd		=3D NFSD_CMD_VERSION_SET,
> > > > > > > +		.doit		=3D nfsd_nl_version_set_doit,
> > > > > > > +		.policy		=3D nfsd_version_set_nl_policy,
> > > > > > > +		.maxattr	=3D NFSD_A_SERVER_PROTO_VERSION,
> > > > > > > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > > > > +	},
> > > > > > > +	{
> > > > > > > +		.cmd	=3D NFSD_CMD_VERSION_GET,
> > > > > > > +		.doit	=3D nfsd_nl_version_get_doit,
> > > > > > > +		.flags	=3D GENL_CMD_CAP_DO,
> > > > > > > +	},
> > > > > > >  };
> > > > > > > =20
> > > > > > >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > > > > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > > > > > index 4137fac477e4..c7c0da275481 100644
> > > > > > > --- a/fs/nfsd/netlink.h
> > > > > > > +++ b/fs/nfsd/netlink.h
> > > > > > > @@ -11,6 +11,9 @@
> > > > > > > =20
> > > > > > >  #include <uapi/linux/nfsd_netlink.h>
> > > > > > > =20
> > > > > > > +/* Common nested types */
> > > > > > > +extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_V=
ERSION_ENABLED + 1];
> > > > > > > +
> > > > > > >  int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> > > > > > >  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> > > > > > > =20
> > > > > > > @@ -18,6 +21,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_b=
uff *skb,
> > > > > > >  				  struct netlink_callback *cb);
> > > > > > >  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_=
info *info);
> > > > > > >  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_=
info *info);
> > > > > > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_=
info *info);
> > > > > > > +int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_=
info *info);
> > > > > > > =20
> > > > > > >  extern struct genl_family nfsd_nl_family;
> > > > > > > =20
> > > > > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > > > > index d4be519b5734..14ec15656320 100644
> > > > > > > --- a/fs/nfsd/netns.h
> > > > > > > +++ b/fs/nfsd/netns.h
> > > > > > > @@ -218,6 +218,7 @@ struct nfsd_net {
> > > > > > >  /* Simple check to find out if a given net was properly initia=
lized */
> > > > > > >  #define nfsd_netns_ready(nn) ((nn)->sessionid_hashtbl)
> > > > > > > =20
> > > > > > > +extern bool nfsd_support_version(int vers);
> > > > > > >  extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> > > > > > > =20
> > > > > > >  extern unsigned int nfsd_net_id;
> > > > > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > > > > index 38a5df03981b..2c8929ef79e9 100644
> > > > > > > --- a/fs/nfsd/nfsctl.c
> > > > > > > +++ b/fs/nfsd/nfsctl.c
> > > > > > > @@ -1757,6 +1757,156 @@ int nfsd_nl_threads_get_doit(struct sk_=
buff *skb, struct genl_info *info)
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > > =20
> > > > > > > +/**
> > > > > > > + * nfsd_nl_version_set_doit - set the nfs enabled versions
> > > > > > > + * @skb: reply buffer
> > > > > > > + * @info: netlink metadata and command arguments
> > > > > > > + *
> > > > > > > + * Return 0 on success or a negative errno.
> > > > > > > + */
> > > > > > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_=
info *info)
> > > > > > > +{
> > > > > > > +	const struct nlattr *attr;
> > > > > > > +	struct nfsd_net *nn;
> > > > > > > +	int i, rem;
> > > > > > > +
> > > > > > > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
> > > > > > > +		return -EINVAL;
> > > > > > > +
> > > > > > > +	mutex_lock(&nfsd_mutex);
> > > > > > > +
> > > > > > > +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > > > > > > +	if (nn->nfsd_serv) {
> > > > > > > +		mutex_unlock(&nfsd_mutex);
> > > > > > > +		return -EBUSY;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	/* clear current supported versions. */
> > > > > > > +	nfsd_vers(nn, 2, NFSD_CLEAR);
> > > > > > > +	nfsd_vers(nn, 3, NFSD_CLEAR);
> > > > > > > +	for (i =3D 0; i <=3D NFSD_SUPPORTED_MINOR_VERSION; i++)
> > > > > > > +		nfsd_minorversion(nn, i, NFSD_CLEAR);
> > > > > > > +
> > > > > > > +	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > > > > > > +		struct nlattr *tb[NFSD_A_VERSION_MAX + 1];
> > > > > > > +		u32 major, minor =3D 0;
> > > > > > > +		bool enabled;
> > > > > > > +
> > > > > > > +		if (nla_type(attr) !=3D NFSD_A_SERVER_PROTO_VERSION)
> > > > > > > +			continue;
> > > > > > > +
> > > > > > > +		if (nla_parse_nested(tb, NFSD_A_VERSION_MAX, attr,
> > > > > > > +				     nfsd_version_nl_policy, info->extack) < 0)
> > > > > > > +			continue;
> > > > > > > +
> > > > > > > +		if (!tb[NFSD_A_VERSION_MAJOR])
> > > > > > > +			continue;
> > > > > > > +
> > > > > > > +		major =3D nla_get_u32(tb[NFSD_A_VERSION_MAJOR]);
> > > > > > > +		if (tb[NFSD_A_VERSION_MINOR])
> > > > > > > +			minor =3D nla_get_u32(tb[NFSD_A_VERSION_MINOR]);
> > > > > > > +
> > > > > > > +		enabled =3D nla_get_flag(tb[NFSD_A_VERSION_ENABLED]);
> > > > > > > +
> > > > > > > +		switch (major) {
> > > > > > > +		case 4:
> > > > > > > +			nfsd_minorversion(nn, minor, enabled ? NFSD_SET : NFSD_CLEA=
R);
> > > > > > > +			break;
> > > > > > > +		case 3:
> > > > > > > +		case 2:
> > > > > > > +			if (!minor)
> > > > > > > +				nfsd_vers(nn, major, enabled ? NFSD_SET : NFSD_CLEAR);
> > > > > > > +			break;
> > > > > > > +		default:
> > > > > > > +			break;
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	mutex_unlock(&nfsd_mutex);
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * nfsd_nl_version_get_doit - get the nfs enabled versions
> > > > > > > + * @skb: reply buffer
> > > > > > > + * @info: netlink metadata and command arguments
> > > > > > > + *
> > > > > > > + * Return 0 on success or a negative errno.
> > > > > > > + */
> > > > > > > +int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_=
info *info)
> > > > > > > +{
> > > > > > > +	struct nfsd_net *nn;
> > > > > > > +	int i, err;
> > > > > > > +	void *hdr;
> > > > > > > +
> > > > > > > +	skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > > > > > > +	if (!skb)
> > > > > > > +		return -ENOMEM;
> > > > > > > +
> > > > > > > +	hdr =3D genlmsg_iput(skb, info);
> > > > > > > +	if (!hdr) {
> > > > > > > +		err =3D -EMSGSIZE;
> > > > > > > +		goto err_free_msg;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	mutex_lock(&nfsd_mutex);
> > > > > > > +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > > > > > > +
> > > > > > > +	for (i =3D 2; i <=3D 4; i++) {
> > > > > > > +		int j;
> > > > > > > +
> > > > > > > +		for (j =3D 0; j <=3D NFSD_SUPPORTED_MINOR_VERSION; j++) {
> > > > > > > +			struct nlattr *attr;
> > > > > > > +
> > > > > > > +			/* Don't record any versions the kernel doesn't have
> > > > > > > +			 * compiled in
> > > > > > > +			 */
> > > > > > > +			if (!nfsd_support_version(i))
> > > > > > > +				continue;
> > > > > > > +
> > > > > > > +			/* NFSv{2,3} does not support minor numbers */
> > > > > > > +			if (i < 4 && j)
> > > > > > > +				continue;
> > > > > > > +
> > > > > > > +			attr =3D nla_nest_start(skb,
> > > > > > > +					      NFSD_A_SERVER_PROTO_VERSION);
> > > > > > > +			if (!attr) {
> > > > > > > +				err =3D -EINVAL;
> > > > > > > +				goto err_nfsd_unlock;
> > > > > > > +			}
> > > > > > > +
> > > > > > > +			if (nla_put_u32(skb, NFSD_A_VERSION_MAJOR, i) ||
> > > > > > > +			    nla_put_u32(skb, NFSD_A_VERSION_MINOR, j)) {
> > > > > > > +				err =3D -EINVAL;
> > > > > > > +				goto err_nfsd_unlock;
> > > > > > > +			}
> > > > > > > +
> > > > > > > +			/* Set the enabled flag if the version is enabled */
> > > > > > > +			if (nfsd_vers(nn, i, NFSD_TEST) &&
> > > > > > > +			    (i < 4 || nfsd_minorversion(nn, j, NFSD_TEST)) &&
> > > > > > > +			    nla_put_flag(skb, NFSD_A_VERSION_ENABLED)) {
> > > > > > > +				err =3D -EINVAL;
> > > > > > > +				goto err_nfsd_unlock;
> > > > > > > +			}
> > > > > > > +
> > > > > > > +			nla_nest_end(skb, attr);
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	mutex_unlock(&nfsd_mutex);
> > > > > > > +	genlmsg_end(skb, hdr);
> > > > > > > +
> > > > > > > +	return genlmsg_reply(skb, info);
> > > > > > > +
> > > > > > > +err_nfsd_unlock:
> > > > > > > +	mutex_unlock(&nfsd_mutex);
> > > > > > > +err_free_msg:
> > > > > > > +	nlmsg_free(skb);
> > > > > > > +
> > > > > > > +	return err;
> > > > > > > +}
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * nfsd_net_init - Prepare the nfsd_net portion of a new net n=
amespace
> > > > > > >   * @net: a freshly-created network namespace
> > > > > > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > > > > > index ca193f7ff0e1..4fc91f50138a 100644
> > > > > > > --- a/fs/nfsd/nfssvc.c
> > > > > > > +++ b/fs/nfsd/nfssvc.c
> > > > > > > @@ -133,8 +133,7 @@ struct svc_program		nfsd_program =3D {
> > > > > > >  	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
> > > > > > >  };
> > > > > > > =20
> > > > > > > -static bool
> > > > > > > -nfsd_support_version(int vers)
> > > > > > > +bool nfsd_support_version(int vers)
> > > > > > >  {
> > > > > > >  	if (vers >=3D NFSD_MINVERS && vers < NFSD_NRVERS)
> > > > > > >  		return nfsd_version[vers] !=3D NULL;
> > > > > > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/l=
inux/nfsd_netlink.h
> > > > > > > index ccc78a5ee650..8a0a2b344923 100644
> > > > > > > --- a/include/uapi/linux/nfsd_netlink.h
> > > > > > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > > > > > @@ -38,10 +38,28 @@ enum {
> > > > > > >  	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> > > > > > >  };
> > > > > > > =20
> > > > > > > +enum {
> > > > > > > +	NFSD_A_VERSION_MAJOR =3D 1,
> > > > > > > +	NFSD_A_VERSION_MINOR,
> > > > > > > +	NFSD_A_VERSION_ENABLED,
> > > > > > > +
> > > > > > > +	__NFSD_A_VERSION_MAX,
> > > > > > > +	NFSD_A_VERSION_MAX =3D (__NFSD_A_VERSION_MAX - 1)
> > > > > > > +};
> > > > > > > +
> > > > > > > +enum {
> > > > > > > +	NFSD_A_SERVER_PROTO_VERSION =3D 1,
> > > > > > > +
> > > > > > > +	__NFSD_A_SERVER_PROTO_MAX,
> > > > > > > +	NFSD_A_SERVER_PROTO_MAX =3D (__NFSD_A_SERVER_PROTO_MAX - 1)
> > > > > > > +};
> > > > > > > +
> > > > > > >  enum {
> > > > > > >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > > > > >  	NFSD_CMD_THREADS_SET,
> > > > > > >  	NFSD_CMD_THREADS_GET,
> > > > > > > +	NFSD_CMD_VERSION_SET,
> > > > > > > +	NFSD_CMD_VERSION_GET,
> > > > > > > =20
> > > > > > >  	__NFSD_CMD_MAX,
> > > > > > >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > > > > > > --=20
> > > > > > > 2.44.0
> > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > >=20
> > > > > --=20
> > > > > Jeff Layton <jlayton@kernel.org>
> > > > >=20
> > > >=20
> > >=20
> > > --=20
> > > Jeff Layton <jlayton@kernel.org>
> > >=20
> >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


