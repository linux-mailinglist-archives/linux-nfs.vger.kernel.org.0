Return-Path: <linux-nfs+bounces-10010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCAA2EFAB
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 15:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1C93A40B8
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56A2528EC;
	Mon, 10 Feb 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjZ5jA/j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7E2528FD
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197508; cv=none; b=oRvBmU5eu6z/oq4082bg+BnmcT7wpGun2rrAgo5qyhvTxOdKe+VpogT3YUGdfBdICRWS0KtJ2zDxx94rCjLa6Fv2tpR3zEyAKT1uJA85esCaVkbiEW0GtETApoBrXxLl3QSLYXb2Vt8j8YA4+vq6GHSIZ/L/PW+RtLbmReJYrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197508; c=relaxed/simple;
	bh=Orf9vxD+JhqjBxcWCy+oi1DkLhTGFjm119nBBGfBWgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lI8Xx3sQpbaKz5fIaaD5CQLbglE7UGYF22gIuGe0W94kHGXVFrYQ4QFlKj+OxfOs4QI37vwBs932HgfF7hMO45VGB3KncSzU/sShLYAaUn/sqo2lBFHVg6Zd9+SQhEbspgnvNRw0zhXiZJIi5cR5Sq6N0Ztnb99N3nntroJCqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjZ5jA/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79147C4CED1;
	Mon, 10 Feb 2025 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739197508;
	bh=Orf9vxD+JhqjBxcWCy+oi1DkLhTGFjm119nBBGfBWgE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FjZ5jA/jAVHlYOU1DL+weR4EWgFCKBm3vsfYOKZdz8fEKch35lIN4nSOXJoMVpoYy
	 NrvE//fK1gUyIwHOADe0qzkhUt9tACCUqKgdAhNjxpTaT6lAaxwE2iK3vpfCQKorJr
	 zltogT8eNr+JrtmqV0KpQLHdoMSuRVZlZC8eiE9ygPG0XuinJqFar3jiuJFCwWOdbU
	 hP4A7O1PjvCUshqaojYJHgOSn+aK9ju2W+HCe8jSgig2xrl873hVCxlaeSKs3wu1Yu
	 3RS8yNIvDgoWq+Qm3X4nf0HsM2mG5Nyq3FadsMssMQOWAbFN5aJdPGnOqKDAFMXMNa
	 EATiapf1gHqEA==
Message-ID: <861990916fdd98170abb7b15188dc360566a8937.camel@kernel.org>
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Dave Chinner	
 <david@fromorbit.com>
Date: Mon, 10 Feb 2025 09:25:06 -0500
In-Reply-To: <173915469913.22054.2038589010660243237@noble.neil.brown.name>
References: <>, <0efc7c87-25ad-4859-99db-0a33037e5bfd@oracle.com>
	 <173915469913.22054.2038589010660243237@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 13:31 +1100, NeilBrown wrote:
> On Mon, 10 Feb 2025, Chuck Lever wrote:
> > On 2/9/25 6:23 PM, NeilBrown wrote:
> > > On Sat, 08 Feb 2025, Chuck Lever wrote:
> > > > On 2/7/25 12:15 AM, NeilBrown wrote:
> > > > > The filecache lru is walked in 2 circumstances for 2 different re=
asons.
> > > > >=20
> > > > > 1/ When called from the shrinker we want to discard the first few
> > > > >    entries on the list, ignoring any with NFSD_FILE_REFERENCED se=
t
> > > > >    because they should really be at the end of the LRU as they ha=
ve been
> > > > >    referenced recently.  So those ones are ROTATED.
> > > > >=20
> > > > > 2/ When called from the nfsd_file_gc() timer function we want to =
discard
> > > > >    anything that hasn't been used since before the previous call,=
 and
> > > > >    mark everything else as unused at this point in time.
> > > > >=20
> > > > > Using the same flag for both of these can result in some unexpect=
ed
> > > > > outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED t=
hen the
> > > > > nfsd_file_gc() will think the file hasn't been used in a while, w=
hile
> > > > > really it has.
> > > > >=20
> > > > > I think it is easier to reason about the behaviour if we instead =
have
> > > > > two flags.
> > > > >=20
> > > > >  NFSD_FILE_REFERENCED means "this should be at the end of the LRU=
, please
> > > > >      put it there when convenient"
> > > > >  NFSD_FILE_RECENT means "this has been used recently - since the =
last
> > > > >      run of nfsd_file_gc()
> > > > >=20
> > > > > When either caller finds an NFSD_FILE_REFERENCED entry, that entr=
y
> > > > > should be moved to the end of the LRU and the flag cleared.  This=
 can
> > > > > safely happen at any time.  The actual order on the lru might not=
 be
> > > > > strictly least-recently-used, but that is normal for linux lrus.
> > > > >=20
> > > > > The shrinker callback can ignore the "recent" flag.  If it ends u=
p
> > > > > freeing something that is "recent" that simply means that memory
> > > > > pressure is sufficient to limit the acceptable cache age to less =
than
> > > > > the nfsd_file_gc frequency.
> > > > >=20
> > > > > The gc caller should primarily focus on NFSD_FILE_RECENT.  It sho=
uld
> > > > > free everything that doesn't have this flag set, and should clear=
 the
> > > > > flag on everything else.  When it clears the flag it is convenien=
t to
> > > > > clear the "REFERENCED" flag and move to the end of the LRU too.
> > > > >=20
> > > > > With this, calls from the shrinker do not prematurely age files. =
 It
> > > > > will focus only on freeing those that are least recently used.
> > > > >=20
> > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > ---
> > > > >  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
> > > > >  fs/nfsd/filecache.h |  1 +
> > > > >  fs/nfsd/trace.h     |  3 +++
> > > > >  3 files changed, 23 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > index 04588c03bdfe..9faf469354a5 100644
> > > > > --- a/fs/nfsd/filecache.c
> > > > > +++ b/fs/nfsd/filecache.c
> > > > > @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file =
*nf)
> > > > >  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> > > > >  }
> > > > > =20
> > > > > -
> > > > >  static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > > > >  {
> > > > >  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > > +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
> > > > >  	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> > > > >  		trace_nfsd_file_lru_add(nf);
> > > > >  		return true;
> > > > > @@ -528,6 +528,23 @@ nfsd_file_lru_cb(struct list_head *item, str=
uct list_lru_one *lru,
> > > > >  	return LRU_REMOVED;
> > > > >  }
> > > > > =20
> > > > > +static enum lru_status
> > > > > +nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru=
,
> > > > > +		 void *arg)
> > > > > +{
> > > > > +	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_=
lru);
> > > > > +
> > > > > +	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
> > > > > +		/* "REFERENCED" really means "should be at the end of the LRU.
> > > > > +		 * As we are putting it there we can clear the flag
> > > > > +		 */
> > > > > +		clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > > +		trace_nfsd_file_gc_aged(nf);
> > > > > +		return LRU_ROTATE;
> > > > > +	}
> > > > > +	return nfsd_file_lru_cb(item, lru, arg);
> > > > > +}
> > > > > +
> > > > >  static void
> > > > >  nfsd_file_gc(void)
> > > > >  {
> > > > > @@ -537,7 +554,7 @@ nfsd_file_gc(void)
> > > > > =20
> > > > >  	for_each_node_state(nid, N_NORMAL_MEMORY) {
> > > > >  		unsigned long nr =3D list_lru_count_node(&nfsd_file_lru, nid);
> > > > > -		ret +=3D list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru=
_cb,
> > > > > +		ret +=3D list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_=
cb,
> > > > >  					  &dispose, &nr);
> > > > >  	}
> > > > >  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru))=
;
> > > > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > > > index d5db6b34ba30..de5b8aa7fcb0 100644
> > > > > --- a/fs/nfsd/filecache.h
> > > > > +++ b/fs/nfsd/filecache.h
> > > > > @@ -38,6 +38,7 @@ struct nfsd_file {
> > > > >  #define NFSD_FILE_PENDING	(1)
> > > > >  #define NFSD_FILE_REFERENCED	(2)
> > > > >  #define NFSD_FILE_GC		(3)
> > > > > +#define NFSD_FILE_RECENT	(4)
> > > > >  	unsigned long		nf_flags;
> > > > >  	refcount_t		nf_ref;
> > > > >  	unsigned char		nf_may;
> > > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > > index ad2c0c432d08..9af723eeb2b0 100644
> > > > > --- a/fs/nfsd/trace.h
> > > > > +++ b/fs/nfsd/trace.h
> > > > > @@ -1039,6 +1039,7 @@ DEFINE_CLID_EVENT(confirmed_r);
> > > > >  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
> > > > >  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> > > > >  		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
> > > > > +		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
> > > > >  		{ 1 << NFSD_FILE_GC,		"GC" })
> > > > > =20
> > > > >  DECLARE_EVENT_CLASS(nfsd_file_class,
> > > > > @@ -1317,6 +1318,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del=
_disposed);
> > > > >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
> > > > >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
> > > > >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
> > > > > +DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
> > > > >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
> > > > > =20
> > > > >  DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
> > > > > @@ -1346,6 +1348,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,=
				\
> > > > >  	TP_ARGS(removed, remaining))
> > > > > =20
> > > > >  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
> > > > > +DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
> > > > >  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
> > > > > =20
> > > > >  TRACE_EVENT(nfsd_file_close,
> > > >=20
> > > > The other patches in this series look like solid improvements. This=
 one
> > > > could be as well, but it will take me some time to understand it.
> > > >=20
> > > > I am generally in favor of replacing the logic that removes and add=
s
> > > > these items with a single atomic bitop, and I'm happy to see NFSD s=
tick
> > > > with the use of an existing LRU facility while documenting its uniq=
ue
> > > > requirements ("nfsd_file_gc_aged" and so on).
> > > >=20
> > > > I would still prefer the backport to be lighter -- looks like the k=
ey
> > > > changes are 3/6 and 6/6. Is there any chance the series can be
> > > > reorganized to facilitate backporting? I have to ask, and the answe=
r
> > > > might be "no", I realize.
> > >=20
> > > I'm going with "no".
> > > To be honest, I was hoping that the complexity displayed here needed
> > > to work around the assumptions of list_lru what don't match our needs
> > > would be sufficient to convince you that list_lru isn't worth pursuin=
g.=20
> > > I see that didn't work.
> >=20
> > Fair enough.
> >=20
> >=20
> > > So I am no longer invested in this patch set.  You are welcome to use=
 it
> > > if you wish and to make any changes that you think are suitable, but =
I
> > > don't think it is a good direction to go and will not be offering any
> > > more code changes to support the use of list_lru here.
> >=20
> > If I may observe, you haven't offered a compelling explanation of why a=
n
> > imperfect fit between list_lru and the filecache adds more technical
> > debt than does the introduction of a bespoke LRU mechanism.
> >=20
> > I'm open to that argument, but I need stronger rationale (or performanc=
e
> > data) to back it up. So far I can agree that the defect rate in this
> > area is somewhat abnormal, but that seems to be because we don't
> > understand how to use the list_lru API to its best advantage.
> >=20
>=20
> I would characterise the cause of the defect rate differently.
> I would say it is because we are treating this as an lru-style problem
> when it isn't an lru-style problem.  list_lru is great for lrus.  That
> isn't what we have.
>=20
> What we have is a desire to keep files open between consecutive IO
> requests without any clear indication of when we have seen the last in a
> series of IO requests.  So we make a policy decision "keep files open
> until there have been no IOs for 2 seconds - then close them".
> This is a good and sensible policy that nothing to do with the "LRU"
> concept.=20
>=20
> We implement this policy by keeping all unused files on a list, set a
> flag every time the file is used, clearing the flag on a timer tick
> (every 2 seconds) and closing anything which still has the flag cleared
> 2 seconds later.
>=20
> Still nothing in this description that is at all related to LRU
> concepts.
>=20
> Now we decide that it would be good the add a shinker - fair enough as
> we don't *need* these to remain.  How should the shrinker choose files
> to close?  It probably doesn't matter beyond avoiding files that still
> have the not-timed-out flag set.
>=20
> But we try to also impose an LRU disciple over the list, and we use
> list_lru.
> The interfaces for list_lru() are well documented but the intent is
> not.  Most users of list_lru (gfs2/quota might be an exception) only
> explicitly delete things from the lru when it is time to discard them
> completely.  They rely on the shrinker to detect things that are in use
> again, and to remove them.  And possibly to detect things that have been
> referenced and to rotate them.  But if the shrinker doesn't run because
> there isn't much memory pressure they are just left alone.
>=20
> This is what list_lru is optimised for - for shrinker driven scanning
> which skips or removes or rotates things that can't or shouldn't
> be freed, and frees others.  You would expect to normally only scan a
> small fraction of the list, because realistically you want to keep most
> of them.
>=20
> For filecache we don't want to keep them very long.  So I think it
> matters a lot less what we choose for shrinking.  I'm tempted to suggest
> we don't bother with the shrinker.  Old files will be discarded soon
> anyway if they aren't used, and slowness in memory allocation (due to
> any memory pressure) will naturally slow down the addition of new files
> to the cache.  So the cache will shrink naturally.
>=20
> I'm not 100% certain of that, but I do think that the needs of the
> shrinker should not dominate the design as they currently do.
>=20
> Note that maybe we *don't* need to close files so quickly.  Maybe we
> could discard the whole timer thing, and then it would make sense to use
> list_lru().  What is the cost of keeping them open?
>=20
> All I can think of is that it affects unlink.  An unlinked file won't be
> removed while there is a reference to the inode.  Maybe we should
> address that by taking a lease on the file while it is in the
> filecache??  When the lease is broken, we discard the file from the
> cache.=20


It may also affect other applications trying to take out leases. The
filecache has the  nfsd_file_lease_notifier that tells it when someone
is trying to take out a lease on a file. That happens then it will try
to close the file first.

>
> If that could work (which might involve creating a new internal lease
> type that is only broken on unlink), then we could remove the timeout
> and leave files in the cache indefinitely.  Then it would make perfect
> sense to use list_lru() because the problem would start to look exactly
> like an LRU problem.  But I don't think that is what we have today.
>=20

The filecache already sets a fsnotify_mark on the inode to watch for
its i_nlink to go to 0, and then removes it from the cache when that
happens. I think we could keep these files open for quite a bit longer
if we chose to do so.

One thing that Chuck has brought up a few times is that maybe we should
consider making v4 not use the filecache at all. If that simplifies
things then that might be a good thing to consider as well.
--=20
Jeff Layton <jlayton@kernel.org>

