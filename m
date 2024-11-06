Return-Path: <linux-nfs+bounces-7683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC909BDDF0
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 05:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141EFB22539
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 04:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E1126C17;
	Wed,  6 Nov 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L5hFjrXj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iThjYM/C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="re+NDZU6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nSqpJTlF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5476035
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 04:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730867467; cv=none; b=YvbWQNpKEYb74nwvVax0BkhpvnJ/TVtOZHmBB/jivTs5CbSczXoCEvKWAYQyWb4fFOZDgwfwupRWTydM+WtgCGutdTiQb6elxnR+Ya57TKiffkBnzTbhYmnT5vQh6VRUEfbc7+kolqfn/KSrnAN2rAYHZET6cj2i9qV8NzcRUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730867467; c=relaxed/simple;
	bh=Oo3pAy505KIa+I0ihV3cG5FBBcAypQ3ymb6a5I1N0b8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LJIw7MuJgNNNlT4PnuyMrdIrMYEMe4q9zCx3Nf2fGbousLWF+323wO6Yk2gehdtqNR5WahH/g0JcG15pmdE8sEITTSD3yCLgbbwu5APLpB0CotwKqo4vZgdCeuM/OplrW1yvvEfNLsduFJU+WPj5fS0cu+BJVPTQ1tM6oKQUSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L5hFjrXj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iThjYM/C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=re+NDZU6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nSqpJTlF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF5AD21E12;
	Wed,  6 Nov 2024 04:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730867461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42HYDbwQqW3ybyFp45eM4ihmc561rHUob+sRT6dHJB4=;
	b=L5hFjrXjAyeG/QhCfA2IGY/sVHjoFJWl2+zNAF+e3lFhPnP8CCV9SymX+RGm0PTAfLmA3R
	6pUKj9bo0Aq8fD0vW1fpBA2966BlZbLzYroDfiX2cZ7GwU71BRVRQpDbmui9xXUSBJ6/Gg
	buuSBSgi5ZF03SHnNtr2WXYPouhr8WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730867461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42HYDbwQqW3ybyFp45eM4ihmc561rHUob+sRT6dHJB4=;
	b=iThjYM/Ck3L5vTvkqrR6YDf8qTiHGk0gck1xesttAFVaPh+bzjQveZMxrIA6fr9f9Xknxo
	ptUGZ6vDEyCUqpBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=re+NDZU6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nSqpJTlF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730867460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42HYDbwQqW3ybyFp45eM4ihmc561rHUob+sRT6dHJB4=;
	b=re+NDZU6s4IkJxZPepjzidEdExx/xch4Ra9khGM6IBWS5tKfJHEVbZtkG5sp+4XyOotHTU
	emigkto4rnu8DfS0jzOtwfFuxkzEF2vL7aRPzXbW8SZfqpeGgFi5LZuKiuBzWK8xUHxNoZ
	C+RTVwcB2gjKZpH5dXVpYVpoYersiVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730867460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42HYDbwQqW3ybyFp45eM4ihmc561rHUob+sRT6dHJB4=;
	b=nSqpJTlFES3JTogQNKyQjXIcPd+IHHAh+7sp4uCKSvDHbqB4d3ntT+r+tV6hmK3D71dNcR
	dyQZwMddtjnZoKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 959DE13736;
	Wed,  6 Nov 2024 04:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDscEwLxKmcPAgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 06 Nov 2024 04:30:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
In-reply-to:
 <CAN-5tyF+FbsxSDEb79FQucM7fRDqw1wa7iegx9t=RvSLgr2nHQ@mail.gmail.com>
References:
 <>, <CAN-5tyF+FbsxSDEb79FQucM7fRDqw1wa7iegx9t=RvSLgr2nHQ@mail.gmail.com>
Date: Wed, 06 Nov 2024 15:30:54 +1100
Message-id: <173086745413.1734440.10027857057542708378@noble.neil.brown.name>
X-Rspamd-Queue-Id: EF5AD21E12
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 06 Nov 2024, Olga Kornievskaia wrote:
> On Tue, Nov 5, 2024 at 4:06=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Wed, 06 Nov 2024, Chuck Lever wrote:
> > >
> > > Having nfsd threads handle this workload again invites a DoS vector.
> >
> > Any more so that having nfsd thread handling a WRITE workload?
>=20
> Isn't a difference between a COPY and a WRITE the fact that the server
> has the ability to restrict the TCP window of the client sending the
> bytes. And for simplicity's sake, if we assume client/server has a
> single TCP stream when the window size is limited then other WRITEs
> are also prevented from sending more data. But a COPY operation
> doesn't require much to be sent and preventing the client from sending
> another COPY can't be achieved thru TCP window size.

I think you are saying that the WRITE requests are naturally throttled.=20
However that isn't necessarily the case.  If the network is
significantly faster than the storage path, and if a client (or several
clients) send enough concurrent WRITE requests, then all nfsd threads
could get stuck in writeback throttling code - which could be seen as a
denial of service as no other requests could be serviced until
congestion eases.

So maybe some threads should be reserved for non-IO requests and so
would avoid dequeuing WRITE and READ and COPY requests - and would not
be involved in async COPY.

So I'm still not convinced that COPY in any way introduced a new DoS
problem - providing the limit of async-copy threads is in place.

I wonder if we could use request deferral to delay IO requests until an
IO thread is available...

>=20
> > > The 4MB chunk limit is there precisely to prevent synchronous COPY
> > > operations from tying up nfsd threads for too long. On a slow export,
> > > this is still not going to work, so I'd rather see a timer for this
> > > protection; say, 30ms, rather than a byte count. If more than 4MB
> > > can be handled quickly, that will be good for throughput.
> >
> > That sounds like a good goal.  Ideally we would need a way to negotiate
> > a window with write-back throttling so that we don't bother reading
> > until we know that writing to the page-cache won't block.  Certainly
> > worth exploring.
> >
> > >
> > > Note that we still want to limit the number of background copy
> > > operations going on. I don't want a mechanism where a client can
> > > start an unbounded amount of work on the server.
> >
> > This isn't obvious to me.  The server makes no promise concerning the
> > throughput it will provide.  Having a list of COPY requests that add up
> > to many terabytes isn't intrinsically a problem.  Having millions of
> > COPY requests in the list *might* be a little bit of a burden.  Using
> > __GFP_NORETRY might help put a natural limit on that.
> >
> > >
> > >
> > > > > > This came up because CVE-2024-49974 was created so I had to do so=
mething
> > > > > > about the theoretical DoS vector in SLE kernels.  I didn't like t=
he
> > > > > > patch so I backported
> > > > > >
> > > > > > Commit 8d915bbf3926 ("NFSD: Force all NFSv4.2 COPY requests to be=
 synchronous")
>=20
> I'm doing the same for RHEL. But the fact that CVE was created seems
> like a flaw of the CVE creation process in this case. It should have
> never been made a CVE.

I think everyone agrees that the CVE process is flawed.  Fixing it is
not so easy :-(
I'm glad you are doing the same.  I'm a little concerned that this
disabled inter-server copies too.  I guess the answer to that is to help
resolve the problems with async copy so that it can be re-enabled.

>=20
> > > > > >
> > > > > > instead (and wondered why it hadn't gone to stable).
> > > > >
> > > > > I was conservative about requesting a backport here. However, if a
> > > > > CVE has been filed, and if there is no automation behind that
> > > > > process, you can explicitly request aadc3bbea163 be backported.
> > > > >
> > > > > The problem, to me, was less about server resource depletion and
> > > > > more about client hangs.
> > > >
> > > > And yet the patch that dealt with the less important server resource
> > > > depletion was marked for stable, and the patch that dealt with client
> > > > hangs wasn't??
> > > >
> > > > The CVE was for that less important patch, probably because it contai=
ned
> > > > the magic word "DoS".
> > >
> > > Quite likely. I wasn't consulted before the CVE was opened, nor was
> > > I notified that it had been created.
> > >
> > > Note that distributions are encouraged to evaluate whether a CVE is
> > > serious enough to address, rather than simply backporting the fixes
> > > automatically. But I know some customers want every CVE handled, so
> > > that is sometimes difficult.
> >
> > Yes, it needs to be handled.  Declaring it invalid is certainly an
> > option for handling it.  I didn't quite feel I could justify that in
> > this case.
> >
> > >
> > >
> > > > I think 8d915bbf3926 should go to stable but I would like to understa=
nd
> > > > why you felt the need to be conservative.
> > >
> > > First, I'm told that LTS generally avoids taking backports that
> > > overtly change user-visible behavior like disabling server-to-server
> > > copy (which requires async COPY to work). That was the main reason
> > > for my hesitance.
> >
> > Why does server-to-server require async COPY?
> > RFC 7862 section 4.5.  Inter-Server Copy says
> >   The destination server may perform the copy synchronously or
> >   asynchronously.
> > but I see that nfsd4_copy() returns nfs4err_notsupp if the inter-server
> > copy_is_sync(), but it isn't immediately obvious to me why.  The patch
> > which landed this functionality doesn't explain the restriction.
>=20
> The choice (my choice) for not implementing a synchronous inter-server
> copy was from my understanding that such operation would be taking too
> much time and tie up a knfsd thread.

I guess either mount or the read could add indefinite delays... Thanks.

>=20
> > I guess that with multiple 4MB sync COPY requests the server would need
> > to repeatedly mount and unmount the source server which could be
> > unnecessary work - or would need to cache the mount and know when to
> > unmount it....
>=20
> The implementation caches the (source server) mount for a period of
> time. But needing to issue multiple COPY can eventually impact
> performance.

True, but I think that is the goal.  If there are two many async COPYs,
force the rest to by sync so as the slow down the client and limit the
impact on the server.


Thanks,
NeilBrown

