Return-Path: <linux-nfs+bounces-11541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E498EAAD347
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 04:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492774684BF
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 02:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1091A18C937;
	Wed,  7 May 2025 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pdZ9LOUs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/8izlL2n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pdZ9LOUs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/8izlL2n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17FBA38
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584999; cv=none; b=HmqyNurA1MiYjkwVoEIlvbUihyCfHK26Gm77QHJo4hCYi4zjEH9+pLy10iER0yNVihkAtWq7+kjmclyZQMqI9owV0zj5eaCUN0+aqbfDfum8J2agVN6aqgvO0bHMnW7MR6evH40yIjXoOJDmZYn4Y1Ib6EjxX7wwN8/ZNfNGOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584999; c=relaxed/simple;
	bh=BrRcuO40glUvAhX4jcgqQRX6GitiKruYQ7GRmwQ1zEU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WweBLApK3ysa8qYU2ZrRwI8BCI0QC+IOC+K8mXC0932vg9Fe9KeeDSwPv6jBXFK3BC4iYR4sMgx2alHQtVJ6euZ4zNWHhwcPCo1yS2wT6Z69kSvXauTLASVpH1w7zzEfArQ1dwZV7JMPq9lmT6zbe8ETDjw0uLTGgvBeovg1hs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pdZ9LOUs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/8izlL2n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pdZ9LOUs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/8izlL2n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4C751F387;
	Wed,  7 May 2025 02:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746584993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3vI5uMsJbz3H3f0Gmr+IXo+nnTfSDBYtJcynhCv/d4=;
	b=pdZ9LOUsIC3YMz+0Ea902MtB7tnzPrzv+6TtOnqmahaUflC4jXK7D2TJCrQgXugcIDCOcV
	ulB7E51Si1LT3cZqzCFLWu4a09ZUO+hDY1k+YjkGX2lZwLFYI2/FG9SmzcwZcnBzZtpQFi
	dGneU+AjjbIxaCbADqLpLsoBa0lUJJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746584993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3vI5uMsJbz3H3f0Gmr+IXo+nnTfSDBYtJcynhCv/d4=;
	b=/8izlL2npPN+tPww20PF2/C23OSh83bpNgG1osxCSgjPFo+N7ZKEjh5ssA83XiKGOpiQHB
	fLgJ61QP+5Tc10Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pdZ9LOUs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/8izlL2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746584993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3vI5uMsJbz3H3f0Gmr+IXo+nnTfSDBYtJcynhCv/d4=;
	b=pdZ9LOUsIC3YMz+0Ea902MtB7tnzPrzv+6TtOnqmahaUflC4jXK7D2TJCrQgXugcIDCOcV
	ulB7E51Si1LT3cZqzCFLWu4a09ZUO+hDY1k+YjkGX2lZwLFYI2/FG9SmzcwZcnBzZtpQFi
	dGneU+AjjbIxaCbADqLpLsoBa0lUJJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746584993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3vI5uMsJbz3H3f0Gmr+IXo+nnTfSDBYtJcynhCv/d4=;
	b=/8izlL2npPN+tPww20PF2/C23OSh83bpNgG1osxCSgjPFo+N7ZKEjh5ssA83XiKGOpiQHB
	fLgJ61QP+5Tc10Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5FFF13680;
	Wed,  7 May 2025 02:29:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R0LvIJzFGmgJCQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 07 May 2025 02:29:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Cc: "Mike Snitzer" <snitzer@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Anna Schumaker" <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
 "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
In-reply-to: <20250504090757.zk5rgb4lg4cgqenf@pali>
References: <>, <20250504090757.zk5rgb4lg4cgqenf@pali>
Date: Wed, 07 May 2025 12:29:44 +1000
Message-id: <174658498476.3924073.575374680003176730@noble.neil.brown.name>
X-Rspamd-Queue-Id: A4C751F387
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,hammerspace.com,wanadoo.fr,vger.kernel.org,oss.qualcomm.com,redhat.com,talpey.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 04 May 2025, Pali Roh=C3=A1r wrote:
> On Wednesday 23 April 2025 00:02:00 Pali Roh=C3=A1r wrote:
> > On Wednesday 23 April 2025 07:54:40 NeilBrown wrote:
> > > On Wed, 23 Apr 2025, Pali Roh=C3=A1r wrote:
> > > > On Sunday 20 April 2025 12:12:22 Mike Snitzer wrote:
> > > > > On Sat, Apr 19, 2025 at 01:52:31PM -0400, Chuck Lever wrote:
> > > > > > On 4/18/25 5:34 PM, Mike Snitzer wrote:
> > > > > > > On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
> > > > > > >> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
> > > > > > >>> +CC: Neil Brown
> > > > > > >>> +CC: Olga Kornievskaia
> > > > > > >>> +CC: Dai Ngo
> > > > > > >>> +CC: Tom Talpey
> > > > > > >>> +CC: Trond Myklebust
> > > > > > >>> +CC: Anna Schumaker
> > > > > > >>>
> > > > > > >>> (just to make sure that anyone listed in
> > > > > > >>>
> > > > > > >>>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
> > > > > > >>>
> > > > > > >>> get copied).
> > > > > > >>>
> > > > > > >>> Here is the link to the full thread:
> > > > > > >>>
> > > > > > >>>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
> > > > > > >>>
> > > > > > >>>
> > > > > > >>> On 10/04/2025 at 11:09, Mike Snitzer:
> > > > > > >>>> Add dummy definition for nfsd_file in both nfslocalio.c and =
localio.c
> > > > > > >>>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used.=
 Otherwise
> > > > > > >>>> RCU code (rcu_dereference and rcu_access_pointer) will deref=
erence
> > > > > > >>>> what should just be an opaque pointer (by using typeof(*ptr)=
).
> > > > > > >>>>
> > > > > > >>>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(=
s) in client")
> > > > > > >>>> Cc: stable@vger.kernel.org
> > > > > > >>>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> > > > > > >>>> Tested-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > > >>>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > > > > >>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > > >>>
> > > > > > >>> Hi everyone,
> > > > > > >>>
> > > > > > >>> The build has been broken for several weeks already. Does any=
one have
> > > > > > >>> intention to pick-up this patch?
> > > > > > >>>
> > > > > > >>> (please ignore if someone already picked it up and if it is a=
lready on
> > > > > > >>> its way to Linus's tree).
> > > > > > >>
> > > > > > >> I assumed that, like all LOCALIO-related changes, this fix wou=
ld go
> > > > > > >> in through the NFS client tree. Let me know if it needs to go =
via NFSD.
> > > > > > >=20
> > > > > > > Since we haven't heard from Trond or Anna about it, I think you=
'd be
> > > > > > > perfectly fine to pick it up.  It is a compiler fixup associate=
d with
> > > > > > > nfd_file being kept opaque to the client -- but given it is "st=
ruct
> > > > > > > nfsd_file" that gives you full license to grab it (IMO).
> > > > > > >=20
> > > > > > > I'm also unaware of any conflicting changes in the NFS client t=
ree.
> > > > > >=20
> > > > > > Hi Mike -
> > > > > >=20
> > > > > > I just looked at this one again. The patch's diffstat is:
> > > > > >=20
> > > > > >  fs/nfs/localio.c           | 8 ++++++++
> > > > > >  fs/nfs_common/nfslocalio.c | 8 ++++++++
> > > > > >=20
> > > > > > Although fs/nfs_common/ is part of both trees, fs/nfs/localio.c is
> > > > > > definitely a client file. I'm still happy to pick it up, but tech=
nically
> > > > > > I would need an Acked-by: from one of the NFS client maintainers.
> > > > > >=20
> > > > > > My impression is that Trond is managing the NFS client pulls for =
v6.15.
> > > > >=20
> > > > > Sure, that's my understanding too.  Feel free to offer your Acked-by
> > > > > (for fs/nfs_common/) and hopefully it'll get picked up.  I can
> > > > > followup with Trond later this coming week if/as needed.
> > > > >=20
> > > > > Thanks,
> > > > > Mike
> > > >=20
> > > > Can we move forward here? The compilation of kernel is broken for at
> > > > least 2 months. Also I have tried to contact Trond for more months but
> > > > has not responded to my emails.
> > > >=20
> > > > Could be this change picked with a slightly higher priority than just
> > > > waiting another two months? Note that nobody objected this particular
> > > > fix and there are 3+ Tested-by lines. And it is not a good image if s=
ome
> > > > kernel component does not compile...
> > > >=20
> > >=20
> > > Actually I do object to this fix (though I've been busy and hadn't had
> > > much change to look at it properly).
> > > The fix is ugly.  At the very least it should be wrapping in an=20
> > >    #if  GCC_VERSION  < whatever
> >=20
> > The problem is that this compile issue happens also with some builds of
> > gcc 13.3.0 as was discussed in the email thread.
> >=20
> > So is not clear what is that "whatever". For me it looks like that it
> > would be more than the version, probably also some build characteristics
> > of gcc. But I have not been investigating it deeper.
>=20
> Neil, thank you for taking care about this. I will retest your next
> patches later.
>=20
> > > to make the purpose more clear.  But I'd rather a deeper fix.
> > >=20
> > > GCC is complaining that rcu_dereference is being called on a point to a
> > > structure that it doesn't know the content of.
> > > So the code is says "I'm going to dereference this pointer even that
> > > that is actually impossible as I don't know what any of the fields are".
> > >=20
> > > I'd rather it didn't do that.  I've been playing with the code and I
> > > think it can be made quite a bit cleaner by moving the rcu_dereference()
> > > call into the nfsd side of the code.  Hopefully I'll have a patch in a
> > > day or so to demonstrate what I mean.
> > >=20
> > > I understand your desire for some action - but the reality is that you
> > > have the full source code of the kernel and you can do whatever you want
> > > to the kernel that you are working on.  You don't need us.
> > > Getting code upstream is certainly good and we should continue to work
> > > on doing that, but if you *need* something to be upstream then you might
> > > want to consider whether your processes are really serving you.
>=20
> I need to comment this. I read more times that kernel developers are
> complaining about vendors who do not provide accurate kernel support for
> their hardware, like not sending changes to mainline kernel and instead
> just publishing their own SDK (=3Dcopy of kernel with own changes) or not
> providing nothing at all, and that this is being repeated.
> And here you are saying that it OK and basically preferred, you have
> sources do that and do not care about mainline kernel.
> Then we have there developers who are saying that usage of non-mainline
> or patched kernel is not supported and would not take any bug report and
> instead redirect them to vendor portal. So at the end the result for
> some specific hardware is that you cannot use mainline kernel because of
> broken A, you have to use vendor kernel, but there is a broken thing B
> about which vendor do not care (and taking it from mainline) and you
> cannot report it to kernel developers because you are not using mainline.
> Which makes the situation really bad for (end) users...

Hi,
 thank you for caring about the status of the upstream kernel and for
 doing what you can to improve it.  That is appreciated.

 My point was not that you shouldn't do what you can.  It was more that
 your ability to influence upstream does have limits.

 I'm specifically responding to this:

> Can we move forward here? The compilation of kernel is broken for at
> least 2 months. Also I have tried to contact Trond for more months but
> has not responded to my emails.
>=20
> Could be this change picked with a slightly higher priority than just
> waiting another two months?

This sounds to me like nagging, complaining, and maybe a little bit of
guilt-tripping.  You probably didn't mean it that way, but that it how
it sounds to me.

It is really good that you reported the problem - thanks.
It is really good that you tested the proposed fix - thanks.
It is really good that you sent occasional reminders - thanks.

but ultimately you don't have control.  You cannot force the maintainer
to accept the patch, and the above is unlikely to be more effective than
occasional simple reminders.

Anything that you do to increase the chance of a fix must be helpful.
Complaining is rarely helpful.

>=20
> > > Trond does often seem slow to take patches, and often they simply appear
> > > in git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git without any
> > > reply to the emails, but he or Anna does usually get to stuff
> > > eventually.
> > >=20
> > > NeilBrown
>=20
> So how to contact those people if they do not react for year? I tried to
> remind changes more times, but no response. I was already told by more
> people that this is a private group which is not taking changes or
> (security) bug reports from outside, and my experience just proves it.
>=20

If you genuinely think any maintainer isn't doing their job properly, the
question to ask is "what can I do to help?".  Maybe there is nothing you
can do.  Maybe you can offer to be a co-maintainer (if you can
demonstrate ability).  Maybe you can fund someone else to be the
maintainer.  If you believe a maintainer is acting in a way that is not
just unhelpful but is actively harmful, you can always try to bring the
problem directly to Linus' attention.
(I don't think any of this applies to NFS - but you might see it differently).

In the case of a regression, as this is, you can always try involving
the "KERNEL REGRESSIONS" maintainer - see the maintainers file.  That
might result in the regression becoming visible to Linus and he might
choose to act in some way.

I agree that it is frustrating when you can see an opportunity to
improve the kernel (or any OSS project) but cannot get your voice heard.
Sometimes you just have to do your best, and move on.

Thanks,
NeilBrown

