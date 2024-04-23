Return-Path: <linux-nfs+bounces-2945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD2C8AE683
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4C0B24A4D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0CC86257;
	Tue, 23 Apr 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULyPoRwm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9C86252;
	Tue, 23 Apr 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876181; cv=none; b=hme6BwjbsHc0NCTO4SmlTJzT3pzUmYXvvjpDaEaWOsBvAHQOC2aiO1zRlM3aRTemRiCXANkPcVMsexFdRe4oSFxIF+fSgGqq358DbgmSSjMR70BjpwkgfubawUzN6zHQirzOyiFZVSSEDLvmLRJ76bA2THqqbJqiYr5k9ZNdzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876181; c=relaxed/simple;
	bh=0THQMLKNGR7ITUu7UFYWeX6NOopSC2fmbfNbY91cP6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIK77IcdVPlKeHMdyjD9/U1LKFDLqgCvSiCwpFZAGx1xnWJYedkQNs019FMnUAXBs5GF7uSca8NJF9BlbGTADDYWdFi7n4JCUTHWa23r4hl69ERezLemrxWSWkNFUg0dq+6NXOX5jGLbcovENJzPFjgIQcdACd6Ti/GNFlfvKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULyPoRwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34756C116B1;
	Tue, 23 Apr 2024 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713876180;
	bh=0THQMLKNGR7ITUu7UFYWeX6NOopSC2fmbfNbY91cP6s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ULyPoRwmkCkBg5/ouJSYcDKsYk1JHlIcmCuGtW3NtYI27pkq9XjWo/f8CmtYkkheR
	 mt7lZmv3htZeS4mdl0RdYOehNqNGRfvQ+VZch49sH8TMQpv6PWgGSVB45irt92F7FR
	 e/cgXyiyyStM7VZhkHNkjtZ+4jnjJP6kmn/5Pio8vyztZDP+96u1cyyW6zM+sGs9RD
	 lioK43cfmQsAiMWYR4edZz7gNDNs2+sKhUng+dUxDwqNHADXbv2gUkagYG8NhBAYk1
	 pZGX27QwoRtzBMQcWPwAIlJamkzGi5r7aGapDB08Y+g3AJfnRyI6T5SyqirFOFkgFK
	 ZNEdpQaoDOC3g==
Message-ID: <4931ecd2e702c95a4da0e1f0c4d9e439f941a451.camel@kernel.org>
Subject: Re: [PATCH v8 3/6] NFSD: add write_version to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org, 
 lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
 netdev@vger.kernel.org,  kuba@kernel.org
Date: Tue, 23 Apr 2024 08:42:58 -0400
In-Reply-To: <171375700742.7600.2829467433799282531@noble.neil.brown.name>
References: <>, <71465d57edc1799978e85b1bcfd1bb68b1f174ef.camel@kernel.org>
	 <171375700742.7600.2829467433799282531@noble.neil.brown.name>
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

On Mon, 2024-04-22 at 13:36 +1000, NeilBrown wrote:
> On Wed, 17 Apr 2024, Jeff Layton wrote:
> > On Wed, 2024-04-17 at 10:43 +1000, NeilBrown wrote:
> > > On Wed, 17 Apr 2024, Jeff Layton wrote:
> > > > On Wed, 2024-04-17 at 09:05 +1000, NeilBrown wrote:
> > > > > On Wed, 17 Apr 2024, Jeff Layton wrote:
> > > > > > On Wed, 2024-04-17 at 07:48 +1000, NeilBrown wrote:
> > > > > > > On Tue, 16 Apr 2024, Jeff Layton wrote:
> > > > > > > > On Tue, 2024-04-16 at 13:16 +1000, NeilBrown wrote:
> > > > > > > > > On Tue, 16 Apr 2024, Lorenzo Bianconi wrote:
> > > > > > > > > > Introduce write_version netlink command through a "decl=
arative" interface.
> > > > > > > > > > This patch introduces a change in behavior since for ve=
rsion-set userspace
> > > > > > > > > > is expected to provide a NFS major/minor version list i=
t wants to enable
> > > > > > > > > > while all the other ones will be disabled. (procfs writ=
e_version
> > > > > > > > > > command implements imperative interface where the admin=
 writes +3/-3 to
> > > > > > > > > > enable/disable a single version.
> > > > > > > > >=20
> > > > > > > > > It seems a little weird to me that the interface always d=
isables all
> > > > > > > > > version, but then also allows individual versions to be d=
isabled.
> > > > > > > > >=20
> > > > > > > > > Would it be reasonable to simply ignore the "enabled" fla=
g when setting
> > > > > > > > > version, and just enable all versions listed??
> > > > > > > > >=20
> > > > > > > > > Or maybe only enable those with the flag, and don't disab=
le those
> > > > > > > > > without the flag?
> > > > > > > > >=20
> > > > > > > > > Those don't necessarily seem much better - but the curren=
t behaviour
> > > > > > > > > still seems odd.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I think it makes sense.
> > > > > > > >=20
> > > > > > > > We disable all versions, and enable any that have the "enab=
led" flag set
> > > > > > > > in the call from userland. Userland technically needn't sen=
d down the
> > > > > > > > versions that are disabled in the call, but the current use=
rland program
> > > > > > > > does.
> > > > > > > >=20
> > > > > > > > I worry about imperative interfaces that might only say -- =
"enable v4.1,
> > > > > > > > but disable v3" and leave the others in their current state=
. That
> > > > > > > > requires that both the kernel and userland keep state about=
 what
> > > > > > > > versions are currently enabled and disabled, and it's possi=
ble to get
> > > > > > > > that wrong.
> > > > > > >=20
> > > > > > > I understand and support your aversion for imperative interfa=
ces.
> > > > > > > But this interface, as currently implemented, looks somewhat =
imperative.
> > > > > > > The message sent to the kernel could enable some interfaces a=
nd then
> > > > > > > disable them.  I know that isn't the intent, but it is what t=
he code
> > > > > > > supports.  Hence "weird".
> > > > > > >=20
> > > > > > > We could add code to make that sort of thing impossible, but =
there isn't
> > > > > > > much point.  Better to make it syntactically impossible.
> > > > > > >=20
> > > > > > > Realistically there will never be NFSv4.3 as there is no need=
 - new
> > > > > > > features can be added incrementally.=A0
> > > > > > >=20
> > > > > >=20
> > > > > > There is no need _so_far_. Who knows what the future will bring=
? Maybe
> > > > > > we'll need v4.3 in order to add some needed feature?
> > > > > >=20
> > > > > > >  So we could just pass an array of
> > > > > > > 5 active flags: 2,3,4.0,4.1,4.2.  I suspect you wouldn't like=
 that and
> > > > > > > I'm not sure that I do either.  A "read" would return the sam=
e array
> > > > > > > with 3 possible states: unavailable, disabled, enabled.  (May=
be the
> > > > > > > array could be variable length so 5.0 could be added one day.=
..).
> > > > > > >=20
> > > > > >=20
> > > > > > A set of flags is basically what this interface is. They just h=
appen to
> > > > > > also be labeled with the major and minorversion. I think that's=
 a good
> > > > > > thing.
> > > > >=20
> > > > > Good for whom?  Labelling allows for labelling inconsistencies.
> > > > >=20
> > > >=20
> > > > Now you're just being silly. You wanted a variable length array, bu=
t
> > > > what if the next slot is not v4.3 but 5.0? A positional interpretat=
ion
> > > > of a slot in an array is just as just as subject to problems.
> > >=20
> > > I don't think it could look like a imperative interface, which the
> > > current one does a bit.
> > >=20
> > > >=20
> > > > > Maybe the kernel should be able to provide an ordered list of lab=
els,
> > > > > and separately an array of which labels are enabled/disabled.
> > > > > Userspace could send down a new set of enabled/disabled flags bas=
ed on
> > > > > the agreed set of labels.
> > > > >=20
> > > >=20
> > > > How is this better than what's been proposed? One strength of netli=
nk is
> > > > that the data is structured. The already proposed interface takes
> > > > advantage of that.
> > > >=20
> > > > > Here is a question that is a bit of a diversion, but might help u=
s
> > > > > understand the context more fully:
> > > > >=20
> > > > >   Why would anyone disable v4.2 separately from v4.1 ??
> > > > >=20
> > > >=20
> > > > Furthermore, what does it mean to disable v4.1 but leave v4.2 enabl=
ed?
> > >=20
> > > Indeed!
> > >=20
> > > >=20
> > > > > I understand that v2, v3, v4.0, v4.1 are effectively different pr=
otocols
> > > > > and you might want to ensure that only the approved/tested protoc=
ol is
> > > > > used.  But v4.2 is just a few enhancements on v4.1.  Why would yo=
u want
> > > > > to disable it?
> > > > >=20
> > > > > The answer I can think of that there might be bugs (perish the
> > > > > thought!!) in some of those features so you might want to avoid u=
sing
> > > > > them.
> > > > > But in that case, it is really the features that you want to supp=
ress,
> > > > > not the protocol version.
> > > > >=20
> > > > > Maybe I might want to disable delegation - to just write delegati=
on.
> > > > > Can I do that?  What if I just want to disable server-side copy, =
but
> > > > > keep fallocate and umask support?
> > > > >=20
> > > > > i.e.  is a list of versions really the granularity that we want t=
o use
> > > > > for this interface?
> > > > >=20
> > > >=20
> > > > Our current goal is to replace rpc.nfsd with a new program that wor=
ks
> > > > via netlink. An important bit of what rpc.nfsd does is start the NF=
S
> > > > server with the settings in /etc/nfs.conf. Some of those settings a=
re
> > > > vers3=3D, vers4.0=3D, etc. that govern how /proc/fs/nfsd/versions i=
s set.
> > > > We have an immediate need to deal with those settings today, and
> > > > probably will for quite some time.
> > > >=20
> > > > I'm not opposed to augmenting that with something more granular, bu=
t I
> > > > don't think we should block this interface and wait on that. We can
> > > > extend the interface at some point in the future to take a new feat=
ure
> > > > bitmask or something, and just declare that (e.g.) declaring vers4.=
2=3Dn
> > > > disables some subset of those features.
> > >=20
> > > I agree that we don't want to block "good" while we wait for "perfect=
".  I
> > > just want to be sure that what we have is "good".
> > >=20
> > > The current /proc interface uses strings like "v3" and "v4.1".
> > > The proposed netlink interface uses pairs on u32s - "major" and "mino=
r".
> > > So we lose some easy paths for extensibility.  Are we comfortable wit=
h
> > > that?
> > >=20
> > > This isn't a big deal - certainly not a blocked.  I just don't feel
> > > entirely comfortable about the current interface and I'm exploring to
> > > see if there might be something better.
> > >=20
> > >=20
> >=20
> > Ok, I'm not convinced that anything you've proposed so far is better
> > than what we have, but I'm open-minded.
>=20
> Thanks.  I admit that I don't think anything I've come up with is better
> either.
>=20
> >=20
> > At this point we have these to-dos:
> >=20
> > 1) make the threads interface accept an array of integers rather than a
> > singleton. This is needed when sunrpc.pool_mode is not global.
> >=20
>=20
> While this I think probably still makes sense, I'm feeling less
> enthusiastic about it and probably wouldn't complain if it didn't
> happen.
>=20

Ok. I think making it an array is fine. For now, it will just error out
when you send down more than one value, but I think we can make it work
the way you'd expect. Regardlness, cleaning up and unifying the pooled
vs. non-pooled server handling seems like a good thing to do. The
existing one is a long-standing kludge.

> I don't like that fact that we need to configure a number of threads.  I
> would much rather it grow/shrink dynamically.  I've got more patches
> that are heading in this direction but they aren't ready yet.
>=20
> If we do land these and they prove to be effective, then configuring
> per-pool threads would become extremely uninteresting.  The demand on
> each pool would adjust each pool separately.
>=20
> So if use an array here turns out to be problematic for some reason, I
> won't complain.
>=20

+1 on making the thread pool sizing dynamic. I had started looking at
what heuristics we should use, but I haven't gotten very far yet.

Some general thoughts:

nfsd threads spend most of their time waiting. They are only very rarely
cpu-bound, so the max size of the thread pools should mostly scale with
the amount of memory in the host.

I have a patch that adds a new percpu counter to count how often we go
to wake a thread and don't find one, and have to queue it. It clearly
hits a lot more when there are fewer running nfsd threads.

I don't think that's sufficient to know when to spawn a new thread
though. For that, we probably ought to be looking at how long RPCs are
sitting and waiting for a thread to pick them up. When that starts
growing then we probably need to bring in more threads.

Conversely, when a thread is sitting idle for a long time (10s? 60s?),
we can probably spin it down. Maybe we can have a new LRU for the
threads and have a periodic thread reaper job that checks for those.


> > 2) have the interface pass down the scope string in the THREADS_SET
> > instead of making userland change the UTS namespace before starting
> > threads. This should just mean adding a new optional string attribute t=
o
> > the threads interfaces.
> >=20
> > ...anything else we're missing that needs doing here? We'd really like
> > to see this in -next soon, so we can possibly make v6.10 with this.
>=20
> I haven't yet found any obvious gaps.  I agree that we can and should
> move forward promptly.
>=20

Great. I think Lorenzo is planning to send another set soon that should
hopefully be reasonable for merge.

>=20
> >=20
> > Thanks,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

