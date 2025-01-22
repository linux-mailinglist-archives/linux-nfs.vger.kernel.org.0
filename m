Return-Path: <linux-nfs+bounces-9445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69572A1896F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E256168393
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCDA76034;
	Wed, 22 Jan 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D27X8t7j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ww97wG1h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SFP1C1/1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bMnhTAGK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D982954670;
	Wed, 22 Jan 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737508545; cv=none; b=bH8j1IfsQf/4HxDKjgMaxlaj3qdfE+M4R44Etbj/a6l88LGj41XzKV6iSXay3qZxghI9XmCkJjQrhJlNzOzuEfygn6ts1/yXNdTaxoQD48ip7pv6wpVLjmFx6kUBMjWZEskpuQjfGdyVIKfAd3MwVVsZO5ABESLBb0EjGQ+mcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737508545; c=relaxed/simple;
	bh=a5HBxBv4QzyARLICrVYwvh61RFE3Mhc9Cgwo29C8udU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Q+jOEJgXGSx42j2KtnUyPlaa27zcmVFErrX2dkwDAXAmNtnXSz6jDvULmLw5tXx8WsjPqallwsM9/wTwP10irqn8t+mengrYe52FfEl/w9m9Ove27yp5VnkeNQyPZ0EiM3qQw4rb/UyMHi96jvlaaIkSr1bRuxleSi9NaGJfmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D27X8t7j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ww97wG1h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SFP1C1/1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bMnhTAGK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC0991F785;
	Wed, 22 Jan 2025 01:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737508542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AO9w+3yc0+vK5qayIASvBeFYqf6Vo8yRLv+APWAUgkE=;
	b=D27X8t7j66xCXUjTod6SRNKcVJqUIJ1mIaO//eaNvnUm3qzsn5svxrPrOWPrH3v0+pxW5M
	e/SX9G85NnU2x1nIIRwmZh/zQmFXTlOop2Zp9SFTdLPbxfXkd5PiPq9uQMC8L5JWpNFkFY
	H2tR+SQAnvGB3NmCERVfxiv5xqyc9bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737508542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AO9w+3yc0+vK5qayIASvBeFYqf6Vo8yRLv+APWAUgkE=;
	b=ww97wG1h9rVPEug4NED96CTGZU8+vT4JGyWV5Q6vHPXodgw5gl8p4hrd6CiWHUt/JJ7823
	odDvZhkSnXL/meCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737508541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AO9w+3yc0+vK5qayIASvBeFYqf6Vo8yRLv+APWAUgkE=;
	b=SFP1C1/1Ln6EMQH8J76o9MAmameDfbvN2h0wb0Dv7/W20bmYSs/6ItylJ8cdAqkCLe5/ED
	4hJLsWQqZuvPf4wQf2ousCpYaqzs92Zpjf/6drnT2HYjifovK58CS6ReTUVjRqC6ABf/ZK
	zKTzOf8fVUvKHMqmv6tejNWlNzTnUVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737508541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AO9w+3yc0+vK5qayIASvBeFYqf6Vo8yRLv+APWAUgkE=;
	b=bMnhTAGKpb2BS70J/1iQppJjJnAlgn9/vrTmRWJ9oZVYrgO/pqeP1eSy34zjTstsbJq+gc
	tEWfSdMF6ZWy1fBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96F351387C;
	Wed, 22 Jan 2025 01:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hC0nErlGkGffKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 01:15:37 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Li Lingfeng" <lilingfeng3@huawei.com>, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
In-reply-to: <6fb21e60487273864136b4912951b5a4fb5b3ae0.camel@kernel.org>
References: <>, <6fb21e60487273864136b4912951b5a4fb5b3ae0.camel@kernel.org>
Date: Wed, 22 Jan 2025 12:15:34 +1100
Message-id: <173750853452.22054.17347206263008180503@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 22 Jan 2025, Jeff Layton wrote:
> On Wed, 2025-01-15 at 10:03 -0500, Chuck Lever wrote:
> > On 1/14/25 2:39 PM, Jeff Layton wrote:
> > > On Tue, 2025-01-14 at 14:27 -0500, Jeff Layton wrote:
> > > > On Mon, 2025-01-13 at 10:59 +0800, Li Lingfeng wrote:
> > > > > In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_=
lru
> > > > > list, gc may be triggered in another thread and immediately release=
 this
> > > > > nfsd_file, which will lead to a UAF when accessing this nfsd_file a=
gain.
> > > > >=20
> > > > > All the places where unhash is done will also perform lru_remove, s=
o there
> > > > > is no need to do lru_remove separately here. After inserting the nf=
sd_file
> > > > > into the nfsd_file_lru list, it can be released by relying on gc.
> > > > >=20
> > > > > Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the filecache L=
RU")
> > > > > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > > > > ---
> > > > >   fs/nfsd/filecache.c | 12 ++----------
> > > > >   1 file changed, 2 insertions(+), 10 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > index a1cdba42c4fa..37b65cb1579a 100644
> > > > > --- a/fs/nfsd/filecache.c
> > > > > +++ b/fs/nfsd/filecache.c
> > > > > @@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
> > > > >   		/* Try to add it to the LRU.  If that fails, decrement. */
> > > > >   		if (nfsd_file_lru_add(nf)) {
> > > > >   			/* If it's still hashed, we're done */
> > > > > -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > > > > +			if (list_lru_count(&nfsd_file_lru))
> > > > >   				nfsd_file_schedule_laundrette();
> > > > > -				return;
> > > > > -			}
> > > > >  =20
> > > > > -			/*
> > > > > -			 * We're racing with unhashing, so try to remove it from
> > > > > -			 * the LRU. If removal fails, then someone else already
> > > > > -			 * has our reference.
> > > > > -			 */
> > > > > -			if (!nfsd_file_lru_remove(nf))
> > > > > -				return;
> > > > > +			return;
> > > > >   		}
> > > > >   	}
> > > > >   	if (refcount_dec_and_test(&nf->nf_ref))
> > > >=20
> > > > I think this looks OK. Filecache bugs are particularly nasty though, =
so
> > > > let's run this through a nice long testing cycle.
> > > >=20
> > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > >=20
> > > Actually, I take it back. This is problematic in another way.
> > >=20
> > > In this case, we're racing with another task that is unhashing the
> > > object, but we've put it on the LRU ourselves. What guarantee do we
> > > have that the unhashing and removal from the LRU didn't occur before
> > > this task called nfsd_file_lru_add()? That's why we attempt to remove
> > > it here -- we can't rely on the task that unhashed it to do so at that
> > > point.
> > >=20
> > > What might be best is to take and hold the rcu_read_lock() before doing
> > > the nfsd_file_lru_add, and just release it after we do these racy
> > > checks. That should make it safe to access the object.
> > >=20
> > > Thoughts?
> >=20
> > Holding the RCU read lock will keep the dereferences safe since
> > nfsd_file objects are freed only after an RCU grace period. But will the
> > logic in nfsd_file_put() work properly on totally dead nfsd_file
> > objects? I don't see a specific failure mode there, but I'm not very
> > imaginative.
> >=20
> > Overall, I think RCU would help.
> >=20
> >=20
>=20
> To be clear, I think we need to drop e57420be100ab from your nfsd-
> testing branch. The race I identified above is quite likely to occur
> and could lead to leaks.
>=20
> If Li Lingfeng doesn't propose a patch, I'll spin one up tomorrow. I
> think the RCU approach is safe.

I'm not convinced this is the right approach.
I cannot see how nfsd_file_put() can race with unhashing.  If it cannot
then we can simply unconditionally call nfsd_file_schedule_laundrette().

Can describe how the race can happen - if indeed it can.

Note that we also need rcu protection in nfsd_file_lru_add() so that the
nf doesn't get freed after it is added the the lru and before the trace
point.  If we don't end up needing rcu round the call, we will need it
in the call.

Thanks,
NeilBrown

