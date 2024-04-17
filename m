Return-Path: <linux-nfs+bounces-2862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AD28A79AA
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 02:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAE81C21D64
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C018184F;
	Wed, 17 Apr 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h94b0a45"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0D184D;
	Wed, 17 Apr 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312661; cv=none; b=AaVDuPKZigcwT4v4NvccIYFNmzwnhodR4ZzVieIg/xZ5Nhi9OfOOCcdfGXQ/kK/MBSTQEk8ecSn/w0xyfZKgNKqbt/N9rM+2esxLh3BnIXlTZn9PYpVhgHBMkShmyT/OcgJD4tdfTLN92Q541z80baRDnkR+RkzXlY9WewmbdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312661; c=relaxed/simple;
	bh=Na1iv5+krLpJkOgavL9sDqjjQkzNMfvEBSfnSC+2cqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KWHFMJywnjmxVckl0ecgv1alEdPmHNqu2Nte0zVsLxnSjH5S/TuTNCLZaL+iSUc+uKWJR3DU7MvXEiZXW8yjaBpmB0o7w3vETEQCEBkfCZAu5t5+OlFDhTrNudA7S5N3XMzUYVYcIar/MyhUlqHYvSqi+s81Lt7FD5a/ZkDhIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h94b0a45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DC8C113CE;
	Wed, 17 Apr 2024 00:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713312660;
	bh=Na1iv5+krLpJkOgavL9sDqjjQkzNMfvEBSfnSC+2cqE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h94b0a453KSUnIr1NJ7qvpX4DeL5IWqIuOAnmBcBJuoLi4VX3O1CA8o5VpwzORqEi
	 gx7E8mdDca52GAEbo3E+vplymfr1JcfhNd5vjkHl8zIEcsFQxo0HcOHewNG/y5uFW/
	 OehbCC0OS6Pn64GWy3etUEocC0onO5wJyYFyw+08Zds/T+4UVRuZcNJMQ/tnoXM5Oc
	 Ki9n+wjY6ZXV5Jbdd0xZQ7pQBsYgLyDTeK+om9AJ+eLTXfdUuIsP9LSHDx+mMvX1b5
	 jW+Lk6ljRQr0XIy+Z9YyfSJNPL6MbNnga4hHyKanqPXCJsH94fpzSaU2K4HjMCsZG5
	 cr/FFb+Ca6mmA==
Message-ID: <5044bcf3bc796e76585e3a17b157dd3c47bea16a.camel@kernel.org>
Subject: Re: [PATCH v8 3/6] NFSD: add write_version to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org, 
 lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
 netdev@vger.kernel.org,  kuba@kernel.org
Date: Tue, 16 Apr 2024 20:10:58 -0400
In-Reply-To: <171330870816.17212.18412845227056589318@noble.neil.brown.name>
References: <>, <5b0ca756d84dd72a3eccb05290a3986d9786f1a8.camel@kernel.org>
	 <171330870816.17212.18412845227056589318@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-17 at 09:05 +1000, NeilBrown wrote:
> On Wed, 17 Apr 2024, Jeff Layton wrote:
> > On Wed, 2024-04-17 at 07:48 +1000, NeilBrown wrote:
> > > On Tue, 16 Apr 2024, Jeff Layton wrote:
> > > > On Tue, 2024-04-16 at 13:16 +1000, NeilBrown wrote:
> > > > > On Tue, 16 Apr 2024, Lorenzo Bianconi wrote:
> > > > > > Introduce write_version netlink command through a "declarative"=
 interface.
> > > > > > This patch introduces a change in behavior since for version-se=
t userspace
> > > > > > is expected to provide a NFS major/minor version list it wants =
to enable
> > > > > > while all the other ones will be disabled. (procfs write_versio=
n
> > > > > > command implements imperative interface where the admin writes =
+3/-3 to
> > > > > > enable/disable a single version.
> > > > >=20
> > > > > It seems a little weird to me that the interface always disables =
all
> > > > > version, but then also allows individual versions to be disabled.
> > > > >=20
> > > > > Would it be reasonable to simply ignore the "enabled" flag when s=
etting
> > > > > version, and just enable all versions listed??
> > > > >=20
> > > > > Or maybe only enable those with the flag, and don't disable those
> > > > > without the flag?
> > > > >=20
> > > > > Those don't necessarily seem much better - but the current behavi=
our
> > > > > still seems odd.
> > > > >=20
> > > >=20
> > > > I think it makes sense.
> > > >=20
> > > > We disable all versions, and enable any that have the "enabled" fla=
g set
> > > > in the call from userland. Userland technically needn't send down t=
he
> > > > versions that are disabled in the call, but the current userland pr=
ogram
> > > > does.
> > > >=20
> > > > I worry about imperative interfaces that might only say -- "enable =
v4.1,
> > > > but disable v3" and leave the others in their current state. That
> > > > requires that both the kernel and userland keep state about what
> > > > versions are currently enabled and disabled, and it's possible to g=
et
> > > > that wrong.
> > >=20
> > > I understand and support your aversion for imperative interfaces.
> > > But this interface, as currently implemented, looks somewhat imperati=
ve.
> > > The message sent to the kernel could enable some interfaces and then
> > > disable them.  I know that isn't the intent, but it is what the code
> > > supports.  Hence "weird".
> > >=20
> > > We could add code to make that sort of thing impossible, but there is=
n't
> > > much point.  Better to make it syntactically impossible.
> > >=20
> > > Realistically there will never be NFSv4.3 as there is no need - new
> > > features can be added incrementally.=A0
> > >=20
> >=20
> > There is no need _so_far_. Who knows what the future will bring? Maybe
> > we'll need v4.3 in order to add some needed feature?
> >=20
> > >  So we could just pass an array of
> > > 5 active flags: 2,3,4.0,4.1,4.2.  I suspect you wouldn't like that an=
d
> > > I'm not sure that I do either.  A "read" would return the same array
> > > with 3 possible states: unavailable, disabled, enabled.  (Maybe the
> > > array could be variable length so 5.0 could be added one day...).
> > >=20
> >=20
> > A set of flags is basically what this interface is. They just happen to
> > also be labeled with the major and minorversion. I think that's a good
> > thing.
>=20
> Good for whom?  Labelling allows for labelling inconsistencies.
>=20

Now you're just being silly. You wanted a variable length array, but
what if the next slot is not v4.3 but 5.0? A positional interpretation
of a slot in an array is just as just as subject to problems.

> Maybe the kernel should be able to provide an ordered list of labels,
> and separately an array of which labels are enabled/disabled.
> Userspace could send down a new set of enabled/disabled flags based on
> the agreed set of labels.
>=20

How is this better than what's been proposed? One strength of netlink is
that the data is structured. The already proposed interface takes
advantage of that.

> Here is a question that is a bit of a diversion, but might help us
> understand the context more fully:
>=20
>   Why would anyone disable v4.2 separately from v4.1 ??
>=20

Furthermore, what does it mean to disable v4.1 but leave v4.2 enabled?

> I understand that v2, v3, v4.0, v4.1 are effectively different protocols
> and you might want to ensure that only the approved/tested protocol is
> used.  But v4.2 is just a few enhancements on v4.1.  Why would you want
> to disable it?
>=20
> The answer I can think of that there might be bugs (perish the
> thought!!) in some of those features so you might want to avoid using
> them.
> But in that case, it is really the features that you want to suppress,
> not the protocol version.
>=20
> Maybe I might want to disable delegation - to just write delegation.
> Can I do that?  What if I just want to disable server-side copy, but
> keep fallocate and umask support?
>=20
> i.e.  is a list of versions really the granularity that we want to use
> for this interface?
>=20

Our current goal is to replace rpc.nfsd with a new program that works
via netlink. An important bit of what rpc.nfsd does is start the NFS
server with the settings in /etc/nfs.conf. Some of those settings are
vers3=3D, vers4.0=3D, etc. that govern how /proc/fs/nfsd/versions is set.
We have an immediate need to deal with those settings today, and
probably will for quite some time.

I'm not opposed to augmenting that with something more granular, but I
don't think we should block this interface and wait on that. We can
extend the interface at some point in the future to take a new feature
bitmask or something, and just declare that (e.g.) declaring vers4.2=3Dn
disables some subset of those features.

>=20
> >=20
> > >=20
> > > I haven't managed to come up with anything *better* than the current
> > > proposal and I don't want to stand in its way, but I wanted to highli=
ght
> > > that it looks weird - as much imperative as declarative - in case
> > > someone else might be able to come up with a better alternative.
> > >=20
> >=20
> > The intention was to create a symmetrical interface. We have 2
> > operations: a "get" that asks "what versions are currently supported an=
d
> > are they enabled?", and a "set" that says "here is the new state of
> > version enablement".
> >=20
> > The userland tool always sends down a complete set of versions. The
> > kernel is (currently) more forgiving, and treats omitted versions as
> > being disabled. The kernel could require that every supported version b=
e
> > represented in the "set" operation, if that's more desirable.
> >=20
> > > >=20
> > > > My thinking was that by using a declarative interface like this, we
> > > > eliminate ambiguity in how these interfaces are supposed to work. T=
he
> > > > client sends down an entire version map in one fell swoop, and we k=
now
> > > > exactly what the result should look like.
> > > >=20
> > > > Note that you can enable or disable just a single version with the
> > > > userland tool, but this way all of that complexity stays in userlan=
d.
> > > >=20
> > > > > Also for getting the version, the doc says:
> > > > >=20
> > > > >      doc: get nfs enabled versions
> > > > >=20
> > > > > which I don't think it quite right.  The code reports all support=
ed
> > > > > versions, and indicates which of those are enabled.  So maybe:
> > > > >=20
> > > > >      doc: get enabled status for all supported versions
> > > > >=20
> > > > >=20
> > > > > I think that fact that it actually lists all supported versions i=
s
> > > > > useful and worth making explicit.
> > > > >=20
> > > > >=20
> > > >=20
> > > > Agreed. We should make that change before merging anything.
> > > >=20
> > > > > >=20
> > > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > > Tested-by: Jeff Layton <jlayton@kernel.org>
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > ---
> > > > > >  Documentation/netlink/specs/nfsd.yaml |  37 +++++++
> > > > > >  fs/nfsd/netlink.c                     |  24 +++++
> > > > > >  fs/nfsd/netlink.h                     |   5 +
> > > > > >  fs/nfsd/netns.h                       |   1 +
> > > > > >  fs/nfsd/nfsctl.c                      | 150 ++++++++++++++++++=
++++++++
> > > > > >  fs/nfsd/nfssvc.c                      |   3 +-
> > > > > >  include/uapi/linux/nfsd_netlink.h     |  18 ++++
> > > > > >  7 files changed, 236 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentat=
ion/netlink/specs/nfsd.yaml
> > > > > > index cbe6c5fd6c4d..0396e8b3ea1f 100644
> > > > > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > > > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > > > > @@ -74,6 +74,26 @@ attribute-sets:
> > > > > >        -
> > > > > >          name: leasetime
> > > > > >          type: u32
> > > > > > +  -
> > > > > > +    name: version
> > > > > > +    attributes:
> > > > > > +      -
> > > > > > +        name: major
> > > > > > +        type: u32
> > > > > > +      -
> > > > > > +        name: minor
> > > > > > +        type: u32
> > > > > > +      -
> > > > > > +        name: enabled
> > > > > > +        type: flag
> > > > > > +  -
> > > > > > +    name: server-proto
> > > > > > +    attributes:
> > > > > > +      -
> > > > > > +        name: version
> > > > > > +        type: nest
> > > > > > +        nested-attributes: version
> > > > > > +        multi-attr: true
> > > > > > =20
> > > > > >  operations:
> > > > > >    list:
> > > > > > @@ -120,3 +140,20 @@ operations:
> > > > > >              - threads
> > > > > >              - gracetime
> > > > > >              - leasetime
> > > > > > +    -
> > > > > > +      name: version-set
> > > > > > +      doc: set nfs enabled versions
> > > > > > +      attribute-set: server-proto
> > > > > > +      flags: [ admin-perm ]
> > > > > > +      do:
> > > > > > +        request:
> > > > > > +          attributes:
> > > > > > +            - version
> > > > > > +    -
> > > > > > +      name: version-get
> > > > > > +      doc: get nfs enabled versions
> > > > > > +      attribute-set: server-proto
> > > > > > +      do:
> > > > > > +        reply:
> > > > > > +          attributes:
> > > > > > +            - version
> > > > > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > > > > index 20a646af0324..bf5df9597288 100644
> > > > > > --- a/fs/nfsd/netlink.c
> > > > > > +++ b/fs/nfsd/netlink.c
> > > > > > @@ -10,6 +10,13 @@
> > > > > > =20
> > > > > >  #include <uapi/linux/nfsd_netlink.h>
> > > > > > =20
> > > > > > +/* Common nested types */
> > > > > > +const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_=
ENABLED + 1] =3D {
> > > > > > +	[NFSD_A_VERSION_MAJOR] =3D { .type =3D NLA_U32, },
> > > > > > +	[NFSD_A_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> > > > > > +	[NFSD_A_VERSION_ENABLED] =3D { .type =3D NLA_FLAG, },
> > > > > > +};
> > > > > > +
> > > > > >  /* NFSD_CMD_THREADS_SET - do */
> > > > > >  static const struct nla_policy nfsd_threads_set_nl_policy[NFSD=
_A_SERVER_WORKER_LEASETIME + 1] =3D {
> > > > > >  	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > > > > > @@ -17,6 +24,11 @@ static const struct nla_policy nfsd_threads_=
set_nl_policy[NFSD_A_SERVER_WORKER_L
> > > > > >  	[NFSD_A_SERVER_WORKER_LEASETIME] =3D { .type =3D NLA_U32, },
> > > > > >  };
> > > > > > =20
> > > > > > +/* NFSD_CMD_VERSION_SET - do */
> > > > > > +static const struct nla_policy nfsd_version_set_nl_policy[NFSD=
_A_SERVER_PROTO_VERSION + 1] =3D {
> > > > > > +	[NFSD_A_SERVER_PROTO_VERSION] =3D NLA_POLICY_NESTED(nfsd_vers=
ion_nl_policy),
> > > > > > +};
> > > > > > +
> > > > > >  /* Ops table for nfsd */
> > > > > >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > > > > >  	{
> > > > > > @@ -38,6 +50,18 @@ static const struct genl_split_ops nfsd_nl_o=
ps[] =3D {
> > > > > >  		.doit	=3D nfsd_nl_threads_get_doit,
> > > > > >  		.flags	=3D GENL_CMD_CAP_DO,
> > > > > >  	},
> > > > > > +	{
> > > > > > +		.cmd		=3D NFSD_CMD_VERSION_SET,
> > > > > > +		.doit		=3D nfsd_nl_version_set_doit,
> > > > > > +		.policy		=3D nfsd_version_set_nl_policy,
> > > > > > +		.maxattr	=3D NFSD_A_SERVER_PROTO_VERSION,
> > > > > > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > > > +	},
> > > > > > +	{
> > > > > > +		.cmd	=3D NFSD_CMD_VERSION_GET,
> > > > > > +		.doit	=3D nfsd_nl_version_get_doit,
> > > > > > +		.flags	=3D GENL_CMD_CAP_DO,
> > > > > > +	},
> > > > > >  };
> > > > > > =20
> > > > > >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > > > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > > > > index 4137fac477e4..c7c0da275481 100644
> > > > > > --- a/fs/nfsd/netlink.h
> > > > > > +++ b/fs/nfsd/netlink.h
> > > > > > @@ -11,6 +11,9 @@
> > > > > > =20
> > > > > >  #include <uapi/linux/nfsd_netlink.h>
> > > > > > =20
> > > > > > +/* Common nested types */
> > > > > > +extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_V=
ERSION_ENABLED + 1];
> > > > > > +
> > > > > >  int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> > > > > >  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> > > > > > =20
> > > > > > @@ -18,6 +21,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_b=
uff *skb,
> > > > > >  				  struct netlink_callback *cb);
> > > > > >  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_=
info *info);
> > > > > >  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_=
info *info);
> > > > > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_=
info *info);
> > > > > > +int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_=
info *info);
> > > > > > =20
> > > > > >  extern struct genl_family nfsd_nl_family;
> > > > > > =20
> > > > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > > > index d4be519b5734..14ec15656320 100644
> > > > > > --- a/fs/nfsd/netns.h
> > > > > > +++ b/fs/nfsd/netns.h
> > > > > > @@ -218,6 +218,7 @@ struct nfsd_net {
> > > > > >  /* Simple check to find out if a given net was properly initia=
lized */
> > > > > >  #define nfsd_netns_ready(nn) ((nn)->sessionid_hashtbl)
> > > > > > =20
> > > > > > +extern bool nfsd_support_version(int vers);
> > > > > >  extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> > > > > > =20
> > > > > >  extern unsigned int nfsd_net_id;
> > > > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > > > index 38a5df03981b..2c8929ef79e9 100644
> > > > > > --- a/fs/nfsd/nfsctl.c
> > > > > > +++ b/fs/nfsd/nfsctl.c
> > > > > > @@ -1757,6 +1757,156 @@ int nfsd_nl_threads_get_doit(struct sk_=
buff *skb, struct genl_info *info)
> > > > > >  	return err;
> > > > > >  }
> > > > > > =20
> > > > > > +/**
> > > > > > + * nfsd_nl_version_set_doit - set the nfs enabled versions
> > > > > > + * @skb: reply buffer
> > > > > > + * @info: netlink metadata and command arguments
> > > > > > + *
> > > > > > + * Return 0 on success or a negative errno.
> > > > > > + */
> > > > > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_=
info *info)
> > > > > > +{
> > > > > > +	const struct nlattr *attr;
> > > > > > +	struct nfsd_net *nn;
> > > > > > +	int i, rem;
> > > > > > +
> > > > > > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	mutex_lock(&nfsd_mutex);
> > > > > > +
> > > > > > +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > > > > > +	if (nn->nfsd_serv) {
> > > > > > +		mutex_unlock(&nfsd_mutex);
> > > > > > +		return -EBUSY;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* clear current supported versions. */
> > > > > > +	nfsd_vers(nn, 2, NFSD_CLEAR);
> > > > > > +	nfsd_vers(nn, 3, NFSD_CLEAR);
> > > > > > +	for (i =3D 0; i <=3D NFSD_SUPPORTED_MINOR_VERSION; i++)
> > > > > > +		nfsd_minorversion(nn, i, NFSD_CLEAR);
> > > > > > +
> > > > > > +	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > > > > > +		struct nlattr *tb[NFSD_A_VERSION_MAX + 1];
> > > > > > +		u32 major, minor =3D 0;
> > > > > > +		bool enabled;
> > > > > > +
> > > > > > +		if (nla_type(attr) !=3D NFSD_A_SERVER_PROTO_VERSION)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		if (nla_parse_nested(tb, NFSD_A_VERSION_MAX, attr,
> > > > > > +				     nfsd_version_nl_policy, info->extack) < 0)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		if (!tb[NFSD_A_VERSION_MAJOR])
> > > > > > +			continue;
> > > > > > +
> > > > > > +		major =3D nla_get_u32(tb[NFSD_A_VERSION_MAJOR]);
> > > > > > +		if (tb[NFSD_A_VERSION_MINOR])
> > > > > > +			minor =3D nla_get_u32(tb[NFSD_A_VERSION_MINOR]);
> > > > > > +
> > > > > > +		enabled =3D nla_get_flag(tb[NFSD_A_VERSION_ENABLED]);
> > > > > > +
> > > > > > +		switch (major) {
> > > > > > +		case 4:
> > > > > > +			nfsd_minorversion(nn, minor, enabled ? NFSD_SET : NFSD_CLEA=
R);
> > > > > > +			break;
> > > > > > +		case 3:
> > > > > > +		case 2:
> > > > > > +			if (!minor)
> > > > > > +				nfsd_vers(nn, major, enabled ? NFSD_SET : NFSD_CLEAR);
> > > > > > +			break;
> > > > > > +		default:
> > > > > > +			break;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	mutex_unlock(&nfsd_mutex);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * nfsd_nl_version_get_doit - get the nfs enabled versions
> > > > > > + * @skb: reply buffer
> > > > > > + * @info: netlink metadata and command arguments
> > > > > > + *
> > > > > > + * Return 0 on success or a negative errno.
> > > > > > + */
> > > > > > +int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_=
info *info)
> > > > > > +{
> > > > > > +	struct nfsd_net *nn;
> > > > > > +	int i, err;
> > > > > > +	void *hdr;
> > > > > > +
> > > > > > +	skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > > > > > +	if (!skb)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	hdr =3D genlmsg_iput(skb, info);
> > > > > > +	if (!hdr) {
> > > > > > +		err =3D -EMSGSIZE;
> > > > > > +		goto err_free_msg;
> > > > > > +	}
> > > > > > +
> > > > > > +	mutex_lock(&nfsd_mutex);
> > > > > > +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > > > > > +
> > > > > > +	for (i =3D 2; i <=3D 4; i++) {
> > > > > > +		int j;
> > > > > > +
> > > > > > +		for (j =3D 0; j <=3D NFSD_SUPPORTED_MINOR_VERSION; j++) {
> > > > > > +			struct nlattr *attr;
> > > > > > +
> > > > > > +			/* Don't record any versions the kernel doesn't have
> > > > > > +			 * compiled in
> > > > > > +			 */
> > > > > > +			if (!nfsd_support_version(i))
> > > > > > +				continue;
> > > > > > +
> > > > > > +			/* NFSv{2,3} does not support minor numbers */
> > > > > > +			if (i < 4 && j)
> > > > > > +				continue;
> > > > > > +
> > > > > > +			attr =3D nla_nest_start(skb,
> > > > > > +					      NFSD_A_SERVER_PROTO_VERSION);
> > > > > > +			if (!attr) {
> > > > > > +				err =3D -EINVAL;
> > > > > > +				goto err_nfsd_unlock;
> > > > > > +			}
> > > > > > +
> > > > > > +			if (nla_put_u32(skb, NFSD_A_VERSION_MAJOR, i) ||
> > > > > > +			    nla_put_u32(skb, NFSD_A_VERSION_MINOR, j)) {
> > > > > > +				err =3D -EINVAL;
> > > > > > +				goto err_nfsd_unlock;
> > > > > > +			}
> > > > > > +
> > > > > > +			/* Set the enabled flag if the version is enabled */
> > > > > > +			if (nfsd_vers(nn, i, NFSD_TEST) &&
> > > > > > +			    (i < 4 || nfsd_minorversion(nn, j, NFSD_TEST)) &&
> > > > > > +			    nla_put_flag(skb, NFSD_A_VERSION_ENABLED)) {
> > > > > > +				err =3D -EINVAL;
> > > > > > +				goto err_nfsd_unlock;
> > > > > > +			}
> > > > > > +
> > > > > > +			nla_nest_end(skb, attr);
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	mutex_unlock(&nfsd_mutex);
> > > > > > +	genlmsg_end(skb, hdr);
> > > > > > +
> > > > > > +	return genlmsg_reply(skb, info);
> > > > > > +
> > > > > > +err_nfsd_unlock:
> > > > > > +	mutex_unlock(&nfsd_mutex);
> > > > > > +err_free_msg:
> > > > > > +	nlmsg_free(skb);
> > > > > > +
> > > > > > +	return err;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * nfsd_net_init - Prepare the nfsd_net portion of a new net n=
amespace
> > > > > >   * @net: a freshly-created network namespace
> > > > > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > > > > index ca193f7ff0e1..4fc91f50138a 100644
> > > > > > --- a/fs/nfsd/nfssvc.c
> > > > > > +++ b/fs/nfsd/nfssvc.c
> > > > > > @@ -133,8 +133,7 @@ struct svc_program		nfsd_program =3D {
> > > > > >  	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
> > > > > >  };
> > > > > > =20
> > > > > > -static bool
> > > > > > -nfsd_support_version(int vers)
> > > > > > +bool nfsd_support_version(int vers)
> > > > > >  {
> > > > > >  	if (vers >=3D NFSD_MINVERS && vers < NFSD_NRVERS)
> > > > > >  		return nfsd_version[vers] !=3D NULL;
> > > > > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/l=
inux/nfsd_netlink.h
> > > > > > index ccc78a5ee650..8a0a2b344923 100644
> > > > > > --- a/include/uapi/linux/nfsd_netlink.h
> > > > > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > > > > @@ -38,10 +38,28 @@ enum {
> > > > > >  	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> > > > > >  };
> > > > > > =20
> > > > > > +enum {
> > > > > > +	NFSD_A_VERSION_MAJOR =3D 1,
> > > > > > +	NFSD_A_VERSION_MINOR,
> > > > > > +	NFSD_A_VERSION_ENABLED,
> > > > > > +
> > > > > > +	__NFSD_A_VERSION_MAX,
> > > > > > +	NFSD_A_VERSION_MAX =3D (__NFSD_A_VERSION_MAX - 1)
> > > > > > +};
> > > > > > +
> > > > > > +enum {
> > > > > > +	NFSD_A_SERVER_PROTO_VERSION =3D 1,
> > > > > > +
> > > > > > +	__NFSD_A_SERVER_PROTO_MAX,
> > > > > > +	NFSD_A_SERVER_PROTO_MAX =3D (__NFSD_A_SERVER_PROTO_MAX - 1)
> > > > > > +};
> > > > > > +
> > > > > >  enum {
> > > > > >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > > > >  	NFSD_CMD_THREADS_SET,
> > > > > >  	NFSD_CMD_THREADS_GET,
> > > > > > +	NFSD_CMD_VERSION_SET,
> > > > > > +	NFSD_CMD_VERSION_GET,
> > > > > > =20
> > > > > >  	__NFSD_CMD_MAX,
> > > > > >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > > > > > --=20
> > > > > > 2.44.0
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > >=20
> > > > --=20
> > > > Jeff Layton <jlayton@kernel.org>
> > > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

