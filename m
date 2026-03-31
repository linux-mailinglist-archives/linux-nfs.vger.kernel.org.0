Return-Path: <linux-nfs+bounces-20576-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPDnNvRMzGksSQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20576-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 00:38:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5C372712
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 00:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FB6E301E3CC
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1B451071;
	Tue, 31 Mar 2026 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEqhgIb7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3E175A87;
	Tue, 31 Mar 2026 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996581; cv=none; b=GKRFYSfq83okPCU7Al8cAadhcnmg+IFXmG0QMHWfdTf0AouKuWrp/aq/xgdA6RPqwxSNlIsRyKOTo2gJHFFxZv6eRQZ1SNdWcpXOpFoImS2Ywu3Rr90nYHnFQhJnmi6q5+Cc+ircKMOwYLNkuR4G6O57VFLlP7RF+V6lZPvuHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996581; c=relaxed/simple;
	bh=txLie1dBJpGZKuGFVApr807kTjjCJJLrxpwywkBYP5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0TpTM395TbEuymBZC1EBh3+83bmpNczZ8TqI06dB+mvh15IGeCREqXcsNKl6OddHwZQJ5rC2VUI05pnnaMnIOGxBPUmcuCoqts1Ordbo0Ui/n7XSWyYpRRkcygK7jb3cSyZRGvJr3xgpzfZq02S+Hj4wgGqWOVdCPE0PNTd8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEqhgIb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF684C19423;
	Tue, 31 Mar 2026 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774996581;
	bh=txLie1dBJpGZKuGFVApr807kTjjCJJLrxpwywkBYP5Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OEqhgIb7utwOGYotQJlS/9S+3hXpUVmSG623GDRJ+a+sTMoT1VgxaR1nktmJgZ+BA
	 j8PYLlSjYSxQdFdNE5gWgUOaTXNpdSpVEQIWCMzoK86cMaQ0FsYfgdA4ghiSwcivjT
	 Ys4S1LlLSXlwILuw/FplQTuJCf/dVzGvBuHuiXGd9hpAJwMnjcYgHqXsBfMrJq94gF
	 GYi7q20dMb9KV0rBzMQs7MpjrzYrF+twnfPkUBwyQ8gCZBSm1ELkqDeGMV+1ZTHssz
	 d5l5aZHUVh3G5uk66AeGVrUt9tFXAaIUxC6w4l5v9Lvb1a2ilqLXzi+/QFzwIQLVbc
	 XjCzwcw1TOg8Q==
Message-ID: <2c9dc8067c77ae8cefecd5224eebee62cecb6781.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr
 operation
From: Jeff Layton <jlayton@kernel.org>
To: Thomas Haynes <loghyr@gmail.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, Trond Myklebust
 <trondmy@kernel.org>,  Anna Schumaker	 <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 31 Mar 2026 18:36:18 -0400
In-Reply-To: <acxGNz07W03ijzM2@mana>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
	 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
	 <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
	 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
	 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
	 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
	 <acbJsryTMYCMlE_o@mana>
	 <13f1fd90b75c73e8d5220dadb6eb9d9473bc96e8.camel@kernel.org>
	 <acwVE5ZoPPLFQCLT@mana>
	 <a23b715677db8553061da684fc047185e328121b.camel@kernel.org>
	 <acxGNz07W03ijzM2@mana>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20576-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41D5C372712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-31 at 15:16 -0700, Thomas Haynes wrote:
> On Tue, Mar 31, 2026 at 05:19:33PM -0800, Jeff Layton wrote:
> > On Tue, 2026-03-31 at 11:47 -0700, Thomas Haynes wrote:
> > > On Tue, Mar 31, 2026 at 07:42:56AM -0800, Jeff Layton wrote:
> > > > On Fri, 2026-03-27 at 11:22 -0700, Thomas Haynes wrote:
> > > > > On Fri, Mar 27, 2026 at 12:59:54PM -0800, Jeff Layton wrote:
> > > > > > On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> > > > > > > On Fri, Mar 27, 2026 at 11:50=E2=80=AFAM Jeff Layton <jlayton=
@kernel.org> wrote:
> > > > > > > >=20
> > > > > > > > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > > > > > > > On Tue, Mar 24, 2026 at 1:32=E2=80=AFPM Jeff Layton <jlay=
ton@kernel.org> wrote:
> > > > > > > > > >=20
> > > > > > > > > > xfstest generic/728 fails with delegated timestamps. Th=
e client does a
> > > > > > > > > > removexattr and then a stat to test the ctime, which do=
esn't change. The
> > > > > > > > > > stat() doesn't trigger a GETATTR because of the delegat=
ed timestamps, so
> > > > > > > > > > it relies on the cached ctime, which is wrong.
> > > > > > > > > >=20
> > > > > > > > > > The setxattr compound has a trailing GETATTR, which ens=
ures that its
> > > > > > > > > > ctime gets updated. Follow the same strategy with remov=
exattr.
> > > > > > > > >=20
> > > > > > > > > This approach relies on the fact that the server the serv=
es delegated
> > > > > > > > > attributes would update change_attr on operations which m=
ight now
> > > > > > > > > necessarily happen (ie, linux server does not update chan=
ge_attribute
> > > > > > > > > on writes or clone). I propose an alternative fix for the=
 failing
> > > > > > > > > generic/728.
> > > > > > > > >=20
> > > > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr=
(struct inode
> > > > > > > > > *inode, const char *name)
> > > > > > > > >             &res.seq_res, 1);
> > > > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > > >         if (!ret)
> > > > > > > > > -               nfs4_update_changeattr(inode, &res.cinfo,=
 timestamp, 0);
> > > > > > > > > +               if (nfs_have_delegated_attributes(inode))=
 {
> > > > > > > > > +                       nfs_update_delegated_mtime(inode)=
;
> > > > > > > > > +                       spin_lock(&inode->i_lock);
> > > > > > > > > +                       nfs_set_cache_invalid(inode, NFS_=
INO_INVALID_BLOCKS);
> > > > > > > > > +                       spin_unlock(&inode->i_lock);
> > > > > > > > > +               } else
> > > > > > > > > +                       nfs4_update_changeattr(inode, &re=
s.cinfo, timestamp, 0);
> > > > > > > > >=20
> > > > > > > > >         return ret;
> > > > > > > > >  }
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > What's the advantage of doing it this way?
> > > > > > > >=20
> > > > > > > > You just sent a REMOVEXATTR operation to the server that wi=
ll change
> > > > > > > > the mtime there. The server has the most up-to-date version=
 of the
> > > > > > > > mtime and ctime at that point.
> > > > > > >=20
> > > > > > > In presence of delegated attributes, Is the server required t=
o update
> > > > > > > its mtime/ctime on an operation? As I mentioned, the linux se=
rver does
> > > > > > > not update its ctime/mtime for WRITE, CLONE, COPY.
> > > > > > >=20
> > > > > > > Is possible that
> > > > > > > some implementations might be different and also do not updat=
e the
> > > > > > > ctime/mtime on REMOVEXATTR?
> > > > > > >=20
> > > > > > > Therefore I was suggesting that the patch
> > > > > > > relies on the fact that it would receive an updated value. Of=
 course
> > > > > > > perhaps all implementations are done the same as the linux se=
rver and
> > > > > > > my point is moot. I didn't see anything in the spec that clar=
ifies
> > > > > > > what the server supposed to do (and client rely on).
> > > > > > >=20
> > > > > >=20
> > > > > > (cc'ing Tom)
> > > > > >=20
> > > > > > That is a very good point.
> > > > > >=20
> > > > > > My interpretation was that delegated timestamps generally cover=
ed
> > > > > > writes, but SETATTR style operations that do anything beyond on=
ly
> > > > > > changing the mtime can't be cached.
> > > > > >=20
> > > > > > We probably need some delstid spec clarification: for what oper=
ations
> > > > > > is the server required to disable timestamp updates when a writ=
e
> > > > > > delegation is outstanding?
> > > > > >=20
> > > > > > In the case of nfsd, we disable timestamp updates for WRITE/COP=
Y/CLONE
> > > > > > but not SETATTR/SETXATTR/REMOVEXATTR.
> > > > > >=20
> > > > > > How does the Hammerspace anvil behave? Does it disable c/mtime =
updates
> > > > > > for writes when there is an outstanding timestamp delegation li=
ke we're
> > > > > > doing in nfsd? If so, does it do the same for
> > > > > > SETATTR/SETXATTR/REMOVEXATTR operations as well?
> > > > >=20
> > > > > Jeff,
> > > > >=20
> > > > > I think the right way to look at this is closer to how size is
> > > > > handled under delegation in RFC8881, rather than as a per-op rule=
.
> > > > >=20
> > > > > In our implementation, because we are acting as an MDS and data I=
/O
> > > > > goes to DSes, we already treat size as effectively delegated when
> > > > > a write layout is outstanding. The MDS does not maintain authorit=
ative
> > > > > size locally in that case. We may refresh size/timestamps interna=
lly
> > > > > (e.g., on GETATTR by querying DSes), but we don=E2=80=99t treat t=
hat as
> > > > > overriding the delegated authority.
> > > > >=20
> > > > > For timestamps, our behavior is effectively the same model. When
> > > > > the client holds the relevant delegation, the server does not
> > > > > consider itself authoritative for ctime/mtime. If current values
> > > > > are needed, we can obtain them from the client (e.g., via CB_GETA=
TTR),
> > > > > and the client must present the delegation stateid to demonstrate
> > > > > that authority. So the authority follows the delegation, not the
> > > > > specific operation.
> > > > >=20
> > > > > That said, I don=E2=80=99t think we=E2=80=99ve fully resolved the=
 semantics for all
> > > > > metadata-style ops either. WRITE and SETATTR are clear in our mod=
el,
> > > > > but for things like CLONE/COPY/SETXATTR/REMOVEXATTR, we=E2=80=99v=
e likely
> > > > > been relying on assumptions rather than a fully consistent rule.
> > > > > I.e., CLONE and COPY we just pass through to the DS and we don't
> > > > > implement SETXATTR/REMOVEXATTR.
> > > > >=20
> > > > > So the spec question, as I see it, is not whether REMOVEXATTR (or
> > > > > any particular op) should update ctime/mtime, but whether delegat=
ed
> > > > > timestamps are meant to follow the same attribute-authority model
> > > > > as delegated size in RFC8881. If so, then we expect that the serv=
er
> > > > > should query the client via CB_GETATTR to return updated ctime/mt=
ime
> > > > > after such operations while the delegation is outstanding.
> > > > >=20
> > > >=20
> > > > The dilemma we have is: because we _do_ allow local processes to st=
at()
> > > > files that have an outstanding write delegation, we can never allow=
 the
> > > > ctime in particular to roll backward (modulo clock jumps).
> > >=20
> > > I agree we do not want visible ctime rollback, but I do not see how
> > > that can be guaranteed from delegated timestamps alone when the
> > > authoritative timestamp may be generated on a different node with
> > > a different clock and the object may change during the CB_GETATTR
> > > window. That seems to require either monotonic clamping of exposed
> > > ctime, or treating change_attr rather than ctime as the real
> > > serialization signal.
> > >=20

We basically disable c/mtime updates on the delegation when it's handed
out and record the current time (A). We then clamp the delegated
timestamp update to between A and "now" when the SETATTR is done.
That's enough to ensure that nothing rolls backward but we can still
respect the client's update assuming the clocks are close enough.

> > > >=20
> > > > If we're dealing with changes that have been cached in the client a=
nd
> > > > are being lazily flushed out, then we can't update the timestamp wh=
en
> > > > that operation occurs. The time of the RPC to flush the changes wil=
l
> > > > almost certainly be later than the cached timestamps on the client =
that
> > > > will eventually be set, so when the client comes back we'd end up
> > > > violating the rollback rule.
> > > >=20
> > > > Our only option is to freeze timestamp updates on anything that mig=
ht
> > > > represent such an operation. So far, we only do that on WRITE and C=
OPY
> > > > operations -- in general, operations that require an open file, sin=
ce
> > > > FMODE_NOCMTIME is attached to the file.
> > > >=20
> > > > Some SETATTRs that only update the mtime and atime can be cached on=
 the
> > > > client by virtue of the fact that it's authoritative for timestamps=
.
> > > > There are some exceptions though:
> > > >=20
> > > > - atime-only updates can't be cached since the ctime won't change w=
ith
> > > > a timestamp update if the mtime didn't change
> > > >=20
> > > > - if you set the mtime to a time that is later than the time you go=
t
> > > > the delegation from the server, but earlier than the current time, =
you
> > > > can't cache that. The ctime would be later than the mtime in that c=
ase,
> > > > and we don't have a mechanism to handle that in a delegated timesta=
mp
> > > > SETATTR.
> > > >=20
> > > > I don't see how you could reasonably buffer a SETXATTR or REMOVEXAT=
TR
> > > > operation to be sent later. These need to be done synchronously sin=
ce
> > > > they could always fail for some reason and we don't have a mechanis=
m at
> > > > the syscall layer to handle a deferred error. They also only update=
 the
> > > > ctime and not the mtime, and we have no mechanism to do that with
> > > > delegated timestamps.
> > > >=20
> > > > Based on that, I think the client and server both need to ignore th=
e
> > > > timestamp delegation on a SETXATTR or REMOVEXATTR. The server shoul=
d
> > > > update the ctime and the client needs to send a trailing GETATTR on=
 the
> > > > REMOVEXATTR compound in order to get it and the change attr.
> > >=20
> > > One concern I have with a per-op formulation is extensibility. If
> > > delegated timestamp behavior is defined by enumerating specific
> > > operations, then every new operation added to the protocol creates
> > > a fresh ambiguity until the spec is updated again. It seems better
> > > to define the behavior in terms of operation properties - e.g., wheth=
er
> > > the operation is synchronously visible, can be deferred/cached at
> > > the client, and whether it affects only ctime versus mtime/atime -
> > > so future operations can be classified without reopening the base
> > > rule.
> > >=20
> > > I.e., I can't tell if you want me to update the spec with
> > > guidance per-op or you are just documenting what you did.
> > >=20
> > >=20
> >=20
> > I think we probably need some guidance in the spec, and I think that
> > guidance comes down to: operations that don't have a way to report a
> > delayed error condition can't be buffered on the client and must
> > continue to be done synchronously even if a delegation is held.
> >=20
> > By way of example: if I do a write() on the client I can buffer that
> > because userland can eventually do an fsync() to see if it succeeded.
> > This is not true for syscalls like setxattr() or removexattr(), or most
> > syscalls that result in a SETATTR operation (chmod(), chown(), etc).
> >=20
> > They must be done synchronously because:
> >=20
> > 1/ there's no way to update only the ctime in a delegated timestamp
> > update
> >=20
> > ...and...
> >=20
> > 2/ these syscalls can fail, so we can't return from them until we know
> > the outcome.
> >=20
> > How best to phrase this guidance, I'm not sure...
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> One concern I have with the "ops that can report delayed error"
> formulation is that, in practice, any NFSv4 operation may encounter
> a temporary condition and return NFS4ERR_DELAY at execution time.
> Even a simple operation like GETFH may need to allocate reply
> resources and fail transiently. As such, the ability to convey delay
> is not a distinguishing property of a particular operation.
>=20
> I think the relevant distinction is instead whether the client may
> complete the syscall locally and defer authoritative execution
> and/or result until a later point without violating its semantics.
> Some operations fit that model, but others do not.
>=20
> Even WRITE is not inherently in the "may be deferred" category;
> that depends on the data path. For example, in a pNFS configuration
> where WRITE is routed synchronously to an MDS, completion semantics
> differ from a buffered writeback model. This suggests that the
> classification should not be tied to specific opcodes, but to the
> completion semantics of the operation in the context in which it
> is executed.
>=20

Yeah, I phrased that poorly. I didn't mean something that would return
NFS4ERR_DELAY, but rather operations like unstable WRITEs and
asynchronous COPY operations (and anything else that falls into that
model) that can fail after the server has returned from the initial
operation.

> Given that, it may be more useful for the spec to describe delegated
> timestamp behavior in terms of these semantics:
>=20
>    o Operations for which the client may lawfully acknowledge
>    completion before authoritative server execution has completed
>    may use delegated timestamp authority, subject to the constraints
>    of that deferred-completion model.
>=20
>    o Operations that require authoritative execution status before
>    completion of the user-visible request must be executed synchronously
>    and must not rely on deferred timestamp resolution.
>=20
> This avoids per-op enumeration and allows future operations to be
> classified based on their semantics rather than requiring explicit
> specification updates.

Ack. Sounds good to me.
--=20
Jeff Layton <jlayton@kernel.org>

