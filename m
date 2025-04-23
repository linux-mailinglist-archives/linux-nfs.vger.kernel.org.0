Return-Path: <linux-nfs+bounces-11219-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488FFA97BB2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 02:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF9717F829
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B681EA7FD;
	Wed, 23 Apr 2025 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sm5zoA6z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qL/AUoTH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sm5zoA6z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qL/AUoTH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48766253F3F
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745368390; cv=none; b=PJaN82purm2RqYvvvTMC7xckj09wqO1rxWWaSllD207dVHXSljCo4G4ZXF+5j3Cssx2qq+s9tJc0pSeBQTMdIW+UT89jO2YOJS86Wg3ULDENl/JvhHY06tTHSa+jtZMOI6X3DIi+AJMnF73ANV2ziXXoW0Yt+fokeLbeTDiAX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745368390; c=relaxed/simple;
	bh=pcMlxXW4qRyOfKV0OTHd1U7Mb8eQ3cyGfJvitC4tQyg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SWIXLTLLoghYetJkEeBKGwr9uaOvj4vSRb0U7dy0AgcN0RLpX6Vn7WtwGdqKML5Cm9Hq1LO7Qy4KtcBpxMD4Go6zKlooLdyOglP65N2/+VmUe5TU242WiAcHiQVSDWtSXwlt06ThawiFmqd5GAMazJnSu30ANUoLZ6HFOTyx89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sm5zoA6z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qL/AUoTH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sm5zoA6z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qL/AUoTH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3672C1F38D;
	Wed, 23 Apr 2025 00:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745368386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9XLSCT4+yqNTQL95u0OTpVhHb+OCn5IsCUFGofNj+s=;
	b=sm5zoA6zLGxvKNxhmSqXkRKanZUUiVHR+mfks28j8BAo7l4/s86rcG/9F5pWUNy7D1dQxk
	bv8WIKZd3LM2ldJN3OuhJxlXFsipvOkxtZP5rEOPAbYy+HNk8vHqJElkg4Vh+nE4d3IpBa
	SfypjQTppMpOrnPqm/KffsZdxb2JAdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745368386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9XLSCT4+yqNTQL95u0OTpVhHb+OCn5IsCUFGofNj+s=;
	b=qL/AUoTH56R5AtgSxFvqQjnALgwhiFFJZMATl0kS5DZ24p9vY3HI/cL6Nz8rPvC1qJnY7K
	ZXUxY+MGyoHV9ICQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sm5zoA6z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qL/AUoTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745368386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9XLSCT4+yqNTQL95u0OTpVhHb+OCn5IsCUFGofNj+s=;
	b=sm5zoA6zLGxvKNxhmSqXkRKanZUUiVHR+mfks28j8BAo7l4/s86rcG/9F5pWUNy7D1dQxk
	bv8WIKZd3LM2ldJN3OuhJxlXFsipvOkxtZP5rEOPAbYy+HNk8vHqJElkg4Vh+nE4d3IpBa
	SfypjQTppMpOrnPqm/KffsZdxb2JAdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745368386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9XLSCT4+yqNTQL95u0OTpVhHb+OCn5IsCUFGofNj+s=;
	b=qL/AUoTH56R5AtgSxFvqQjnALgwhiFFJZMATl0kS5DZ24p9vY3HI/cL6Nz8rPvC1qJnY7K
	ZXUxY+MGyoHV9ICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5756137CF;
	Wed, 23 Apr 2025 00:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4xqlGj01CGhSdQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Apr 2025 00:33:01 +0000
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
In-reply-to: <20250422220200.otabh5q7efh63rjh@pali>
References: <>, <20250422220200.otabh5q7efh63rjh@pali>
Date: Wed, 23 Apr 2025 10:32:54 +1000
Message-id: <174536837419.500591.6789771877874461689@noble.neil.brown.name>
X-Rspamd-Queue-Id: 3672C1F38D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,hammerspace.com,wanadoo.fr,vger.kernel.org,oss.qualcomm.com,redhat.com,talpey.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 23 Apr 2025, Pali Roh=C3=A1r wrote:
> On Wednesday 23 April 2025 07:54:40 NeilBrown wrote:
> > On Wed, 23 Apr 2025, Pali Roh=C3=A1r wrote:
> > > On Sunday 20 April 2025 12:12:22 Mike Snitzer wrote:
> > > > On Sat, Apr 19, 2025 at 01:52:31PM -0400, Chuck Lever wrote:
> > > > > On 4/18/25 5:34 PM, Mike Snitzer wrote:
> > > > > > On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
> > > > > >> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
> > > > > >>> +CC: Neil Brown
> > > > > >>> +CC: Olga Kornievskaia
> > > > > >>> +CC: Dai Ngo
> > > > > >>> +CC: Tom Talpey
> > > > > >>> +CC: Trond Myklebust
> > > > > >>> +CC: Anna Schumaker
> > > > > >>>
> > > > > >>> (just to make sure that anyone listed in
> > > > > >>>
> > > > > >>>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
> > > > > >>>
> > > > > >>> get copied).
> > > > > >>>
> > > > > >>> Here is the link to the full thread:
> > > > > >>>
> > > > > >>>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
> > > > > >>>
> > > > > >>>
> > > > > >>> On 10/04/2025 at 11:09, Mike Snitzer:
> > > > > >>>> Add dummy definition for nfsd_file in both nfslocalio.c and lo=
calio.c
> > > > > >>>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. O=
therwise
> > > > > >>>> RCU code (rcu_dereference and rcu_access_pointer) will derefer=
ence
> > > > > >>>> what should just be an opaque pointer (by using typeof(*ptr)).
> > > > > >>>>
> > > > > >>>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s)=
 in client")
> > > > > >>>> Cc: stable@vger.kernel.org
> > > > > >>>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> > > > > >>>> Tested-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > >>>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > > > >>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > >>>
> > > > > >>> Hi everyone,
> > > > > >>>
> > > > > >>> The build has been broken for several weeks already. Does anyon=
e have
> > > > > >>> intention to pick-up this patch?
> > > > > >>>
> > > > > >>> (please ignore if someone already picked it up and if it is alr=
eady on
> > > > > >>> its way to Linus's tree).
> > > > > >>
> > > > > >> I assumed that, like all LOCALIO-related changes, this fix would=
 go
> > > > > >> in through the NFS client tree. Let me know if it needs to go vi=
a NFSD.
> > > > > >=20
> > > > > > Since we haven't heard from Trond or Anna about it, I think you'd=
 be
> > > > > > perfectly fine to pick it up.  It is a compiler fixup associated =
with
> > > > > > nfd_file being kept opaque to the client -- but given it is "stru=
ct
> > > > > > nfsd_file" that gives you full license to grab it (IMO).
> > > > > >=20
> > > > > > I'm also unaware of any conflicting changes in the NFS client tre=
e.
> > > > >=20
> > > > > Hi Mike -
> > > > >=20
> > > > > I just looked at this one again. The patch's diffstat is:
> > > > >=20
> > > > >  fs/nfs/localio.c           | 8 ++++++++
> > > > >  fs/nfs_common/nfslocalio.c | 8 ++++++++
> > > > >=20
> > > > > Although fs/nfs_common/ is part of both trees, fs/nfs/localio.c is
> > > > > definitely a client file. I'm still happy to pick it up, but techni=
cally
> > > > > I would need an Acked-by: from one of the NFS client maintainers.
> > > > >=20
> > > > > My impression is that Trond is managing the NFS client pulls for v6=
.15.
> > > >=20
> > > > Sure, that's my understanding too.  Feel free to offer your Acked-by
> > > > (for fs/nfs_common/) and hopefully it'll get picked up.  I can
> > > > followup with Trond later this coming week if/as needed.
> > > >=20
> > > > Thanks,
> > > > Mike
> > >=20
> > > Can we move forward here? The compilation of kernel is broken for at
> > > least 2 months. Also I have tried to contact Trond for more months but
> > > has not responded to my emails.
> > >=20
> > > Could be this change picked with a slightly higher priority than just
> > > waiting another two months? Note that nobody objected this particular
> > > fix and there are 3+ Tested-by lines. And it is not a good image if some
> > > kernel component does not compile...
> > >=20
> >=20
> > Actually I do object to this fix (though I've been busy and hadn't had
> > much change to look at it properly).
> > The fix is ugly.  At the very least it should be wrapping in an=20
> >    #if  GCC_VERSION  < whatever
>=20
> The problem is that this compile issue happens also with some builds of
> gcc 13.3.0 as was discussed in the email thread.
>=20
> So is not clear what is that "whatever". For me it looks like that it
> would be more than the version, probably also some build characteristics
> of gcc. But I have not been investigating it deeper.

Fair enough - let's skip that idea then.

I'm finding a few different races in this code.  They are subtle and
unlikely but should be fixed.  So I'd really rather it did continue to
fail to compile until the various problems are fixed.

For example nfs_close_local_fh() can be called either from
nfs_uuid_put() or from a couple of places in nfs code such=20
as __put_nfs_open_context().  These can race.  We really need the files
to be closed before either completes, but there is no interlock to
ensure this.  So e.g. nfs_uuid_put() could module_put(nfs_mod) while
the other caller is still inside nfsd code trying to put the file.

Also nfs_uuid_put() moves the list of files onto a private list which is
no protected by any spinlock, and nfs_close_local_fh() could remove it
from that list asynchronously (thinking it is removing it from the
original lock-protected list) which could cause list corruption.

So thanks for reporting this problem!!

NeilBrown

