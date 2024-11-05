Return-Path: <linux-nfs+bounces-7662-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861B29BC20A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 01:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158AF1F22788
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D7AD51;
	Tue,  5 Nov 2024 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3Tb264u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlCmbsV/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3Tb264u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlCmbsV/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA2AD39
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766792; cv=none; b=i/tqgHDwvb2ALsUSOE3kQd61c8/2spVYgIvHGv10EqdABWGTBnJsCYhoh1hzG7FWavdwqT+euZRELNq1CGMov3usW2LWk4EbPxuxWkF43FhDovL/C2gLNcB1gE9Kp1FF4l4XtCSh2NMtdQ6yOXaiGKCb+N0Dxv2n2qAdlIaU5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766792; c=relaxed/simple;
	bh=X8OdkSedHoEKbSInQ3X+efokhw5XtNIEBkcRNwQ6vZ4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=t40+dvnzi2FpHm6HZo6hBF6jHX3UL/CqU30HyVyzAUWHunrwux31IVoJpZcjWxhd0K4jqKRhRj3EQsG62VwxGE6/3xKQEJ/Jr7NqgaTNGWEJCpTC/uc0qxA2xhhgMbn7F/nujwkFgpeXma+inBBPVj4iu7q+/xhzqTCpoJoBSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3Tb264u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlCmbsV/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3Tb264u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlCmbsV/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E8431FBA3;
	Tue,  5 Nov 2024 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730766783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGwBDySvxvwxRlBiFvW1vC5ad5yZRoyVbRIv1PQpt9M=;
	b=B3Tb264ui1VuHxdo01sclnlWzc2Evg9Na+aG/QUZLFTfXIMfSyIsA1rGWANqXMDM4NFFSx
	onQB5XRrh19IiNvcP5tkO5Ysg/Bh1jYwQDqHJfbF/BAANNrsBAeZ4u59LcdM2axEcx8rJW
	n6fXRBBcabiu71e6sD2U3WuBTpkJR80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730766783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGwBDySvxvwxRlBiFvW1vC5ad5yZRoyVbRIv1PQpt9M=;
	b=wlCmbsV/Z/+Jxjqta/4ViqIWdWwGH7cnJlq7aY/t6De/P0mCEFtgmzd7gunsv5Nv3RHEvt
	NlqeXXphgLKXjiDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730766783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGwBDySvxvwxRlBiFvW1vC5ad5yZRoyVbRIv1PQpt9M=;
	b=B3Tb264ui1VuHxdo01sclnlWzc2Evg9Na+aG/QUZLFTfXIMfSyIsA1rGWANqXMDM4NFFSx
	onQB5XRrh19IiNvcP5tkO5Ysg/Bh1jYwQDqHJfbF/BAANNrsBAeZ4u59LcdM2axEcx8rJW
	n6fXRBBcabiu71e6sD2U3WuBTpkJR80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730766783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGwBDySvxvwxRlBiFvW1vC5ad5yZRoyVbRIv1PQpt9M=;
	b=wlCmbsV/Z/+Jxjqta/4ViqIWdWwGH7cnJlq7aY/t6De/P0mCEFtgmzd7gunsv5Nv3RHEvt
	NlqeXXphgLKXjiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29DBE137FE;
	Tue,  5 Nov 2024 00:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m0Z+M7xnKWfULwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 05 Nov 2024 00:33:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
In-reply-to: <Zykz8j7kTJd/CuF6@tissot.1015granger.net>
References: <>, <Zykz8j7kTJd/CuF6@tissot.1015granger.net>
Date: Tue, 05 Nov 2024 11:32:48 +1100
Message-id: <173076676896.81717.10653275466233824521@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 05 Nov 2024, Chuck Lever wrote:
> On Tue, Nov 05, 2024 at 07:30:03AM +1100, NeilBrown wrote:
> > On Tue, 05 Nov 2024, Chuck Lever wrote:
> > > On Mon, Nov 04, 2024 at 03:47:42PM +1100, NeilBrown wrote:
> > > >=20
> > > > An NFSv4.2 COPY request can explicitly request a synchronous copy.  If
> > > > that is not requested then the server is free to perform the copy
> > > > synchronously or asynchronously.
> > > >=20
> > > > In the Linux implementation an async copy requires more resources tha=
n a
> > > > sync copy.  If nfsd cannot allocate these resources, the best response
> > > > is to simply perform the copy (or the first 4MB of it) synchronously.
> > > >=20
> > > > This choice may be debatable if the unavailable resource was due to
> > > > memory allocation failure - when memalloc fails it might be best to
> > > > simply give up as the server is clearly under load.  However in the c=
ase
> > > > that policy prevents another kthread being created there is no benefit
> > > > and much cost is failing with NFS4ERR_DELAY.  In that case it seems
> > > > reasonable to avoid that error in all circumstances.
> > > >=20
> > > > So change the out_err case to retry as a sync copy.
> > > >=20
> > > > Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY=
 operations")
> > >=20
> > > Hi Neil,
> > >=20
> > > Why is a Fixes: tag necessary?
> > >=20
> > > And why that commit? async copies can fail due to lack of resources
> > > on kernels that don't have aadc3bbea163, AFAICT.
> >=20
> > I had hoped my commit message would have explained that, though I accept
> > it was not as explicit as it could be.
>=20
> The problem might be that you and I have different understandings of
> what exactly aadc3bbea163 does.

It might be.
My understanding is that it limits the number of concurrent async
COPY requests to ->sp_nrthreads and once that limit in reached
any further COPY requests that don't explicitly request "synchronous"
are refused with NFS4ERR_DELAY.

>=20
>=20
> > kmalloc(GFP_KERNEL) allocation failures aren't interesting.  They never
> > happen for smallish sizes, and if they do then the server is so borked
> > that it hardly matter what we do.
> >=20
> > The fixed commit introduces a new failure mode that COULD easily be hit
> > in practice.  It causes the N+1st COPY to wait indefinitely until at
> > least one other copy completes which, as you observed in that commit,
> > could "run for a long time".  I don't think that behaviour is necessary
> > or appropriate.
>=20
> The waiting happens on the client. An async COPY operation always
> completes quickly on the server, in this case with NFS4ERR_DELAY. It
> does not tie up an nfsd thread.

Agreed that it doesn't tie up an nfsd thread.  It does tie up a separate
kthread for which there is a limit matching the number of nfsd threads
(in the pool).

Agreed that the waiting happens on the client, but why should there be
any waiting at all?  The client doesn't know what it is waiting for, so
will typically wait a few seconds.  In that time many megabytes of sync
COPY could have been processed.

>=20
> By the way, there are two fixes in this area that now appear in
> v6.12-rc6 that you should check out.

I'll try to schedule time to have a look - thanks.

>=20
>=20
> > Changing the handling for kmalloc failure was just an irrelevant
> > side-effect for changing the behaviour when then number of COPY requests
> > exceeded the number of configured threads.
>=20
> aadc3bbea163 checks the number of concurrent /async/ COPY requests,
> which do not tie up nfsd threads, and thus are not limited by the
> svc_thread count, as synchronous COPY operations are by definition.

They are PRECISELY limited by the svc_thread count.  ->sp_nrthreads.

+               if (atomic_inc_return(&nn->pending_async_copies) >
+                               (int)rqstp->rq_pool->sp_nrthreads) {

>=20
> I'm still thinking about the ramifications of converting an async
> COPY to a sync COPY in this case. We want to reduce the server
> workload in this case, rather than accommodate an aggressive client.

We are not "converting" an async COPY to a sync COPY.  There is no such
thing as an "async COPY" in terms of what the client requests.
The client can request "COPY" which there server may perform sync or
async, or the client can request "COPY synchronous" which the server
must perform synchronously, or refuse to perform.

By tying up a thread temporarily with a sync COPY we do reduce server
workload by potentially increasing latency to the client.  I don't
think that "aggressive" is a fair description of the client.
"opportunistic" might be reasonable.

My current thinking is that we should not start extra threads for
handling async copies.  We should create a queue of pending copies and
any nfsd thread can dequeue a copy and process 4MB each time through
"The main request loop" just like it calls nfsd_file_net_dispose() to do
a little bit of work.  That isn't needed now but I'll need something
like that before my dynamic thread pool work can land.

>=20
>=20
> > This came up because CVE-2024-49974 was created so I had to do something
> > about the theoretical DoS vector in SLE kernels.  I didn't like the
> > patch so I backported
> >=20
> > Commit 8d915bbf3926 ("NFSD: Force all NFSv4.2 COPY requests to be synchro=
nous")
> >=20
> > instead (and wondered why it hadn't gone to stable).
>=20
> I was conservative about requesting a backport here. However, if a
> CVE has been filed, and if there is no automation behind that
> process, you can explicitly request aadc3bbea163 be backported.
>=20
> The problem, to me, was less about server resource depletion and
> more about client hangs.

And yet the patch that dealt with the less important server resource
depletion was marked for stable, and the patch that dealt with client
hangs wasn't??

The CVE was for that less important patch, probably because it contained
the magic word "DoS".

I think 8d915bbf3926 should go to stable but I would like to understand
why you felt the need to be conservative.

Thanks,
NeilBrown


>=20
>=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> > >=20
> > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/nfsd/nfs4proc.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index fea171ffed62..06e0d9153ca9 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -1972,6 +1972,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> > > >  		wake_up_process(async_copy->copy_task);
> > > >  		status =3D nfs_ok;
> > > >  	} else {
> > > > +	retry_sync:
> > > >  		status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > > >  				       copy->nf_dst->nf_file, true);
> > > >  	}
> > > > @@ -1990,8 +1991,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> > > >  	}
> > > >  	if (async_copy)
> > > >  		cleanup_async_copy(async_copy);
> > > > -	status =3D nfserr_jukebox;
> > > > -	goto out;
> > > > +	goto retry_sync;
> > > >  }
> > > > =20
> > > >  static struct nfsd4_copy *
> > > >=20
> > > > base-commit: 26e6e693936986309c01e8bb80e318d63fda4a44
> > > > --=20
> > > > 2.47.0
> > > >=20
> > >=20
> > > --=20
> > > Chuck Lever
> > >=20
> >=20
>=20
> --=20
> Chuck Lever
>=20


