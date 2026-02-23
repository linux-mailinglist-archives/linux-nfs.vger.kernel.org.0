Return-Path: <linux-nfs+bounces-19132-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QESEJERfnGkUFQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19132-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:08:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CC177C1A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9083630240AB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A371EFF8D;
	Mon, 23 Feb 2026 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm9Hwgrv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0F265CA8;
	Mon, 23 Feb 2026 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855680; cv=none; b=t3jAXKMJP0/FhEMAQI+bh9SEfn+Yt9BCR7Iva59O5cRwD0eUTkKB27repXGTrLB6GpLDIn60hIK86lds2Z9Yvc8XtSoETLGwkjlmePN1ZbC0FH9Ras1HFjBdeG80eNM8BeUj6l6HjfPPcvcKmmby0jf9X49D/CmOkOYasWn1k7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855680; c=relaxed/simple;
	bh=bv8lV1tBBamMooMxuJCMIIvYP6KOjS4M95exjaU20bA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sjfrC1g69LaU9hO+YXhIk07epnazgjenaDyRAdPUZds2tSQejm/FGhkhxdW12RTuXaBanddTgMgH2Wgj6Msbl7hyQrgO48IOKQNylmXLs+mr5mUvwZRxtRiCFCqRmnZJwSOJDzjZBUw2k5JKQ3GQnzVY+GaUNlCbXCwvZT6tmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm9Hwgrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15860C116D0;
	Mon, 23 Feb 2026 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771855680;
	bh=bv8lV1tBBamMooMxuJCMIIvYP6KOjS4M95exjaU20bA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fm9Hwgrv80Hh8lX4rdbsgcEpwcLQGO/Cqu7vjIEzLZSldPgw7OsjcnKGxNEDH/aNX
	 7Hm9ffbhF86x97dgkpJJU5jutpqpc0re89eUD7/90oeKBmnYCgwDVKPdgUjLt/MhkK
	 pYb0wdZe0GZT/HAIzTxH9rns9uAEbNCli1C0PYDU3thOQ68YbhbsLGTS5AVrRZjQGF
	 7Lpc+IRxjBPqx9ahqG/nl2bJMGM8kAcj44glFZXV09BsPa2AsQK+KDZOdjJM3l/d9/
	 KFHVSDC80UQMt8aINuZYEDaTGiyABoQvJtsHqC7C3n5lse4aGPXsu/YDFU/mdszZ+E
	 p0EPOjzhMZrdA==
Message-ID: <7c0e019cbf7371bdf47bd7a7c48df132fc5b87fd.camel@kernel.org>
Subject: Re: [PATCH 3/3] sunrpc: split cache_detail queue into request and
 reader lists
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 23 Feb 2026 09:07:57 -0500
In-Reply-To: <177171367423.8396.10176251932730619714@noble.neil.brown.name>
References: <20260220-sunrpc-cache-v1-0-47d04014c245@kernel.org>
	, <20260220-sunrpc-cache-v1-3-47d04014c245@kernel.org>
	 <177171367423.8396.10176251932730619714@noble.neil.brown.name>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19132-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 377CC177C1A
X-Rspamd-Action: no action

On Sun, 2026-02-22 at 09:41 +1100, NeilBrown wrote:
> On Fri, 20 Feb 2026, Jeff Layton wrote:
> > Replace the single interleaved queue (which mixed cache_request and
> > cache_reader entries distinguished by a ->reader flag) with two
> > dedicated lists: cd->requests for upcall requests and cd->readers
> > for open file handles.
> >=20
> > Readers now track their position via a monotonically increasing
> > sequence number (next_seqno) rather than by their position in the
> > shared list. Each cache_request is assigned a seqno when enqueued,
> > and a new cache_next_request() helper finds the next request at or
> > after a given seqno.
> >=20
> > This eliminates the cache_queue wrapper struct entirely, simplifies
> > the reader-skipping loops in cache_read/cache_poll/cache_ioctl/
> > cache_release, and makes the data flow easier to reason about.
> >=20
> > Also, remove an obsolete comment. CACHE_UPCALLING hasn't existed
> > since before the git era started.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/sunrpc/cache.h |   4 +-
> >  net/sunrpc/cache.c           | 125 ++++++++++++++++++-----------------=
--------
> >  2 files changed, 56 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.=
h
> > index 031379efba24d40f64ce346cf1032261d4b98d05..b1e595c2615bd4be4d9ad19=
f71a8f4d08bd74a9b 100644
> > --- a/include/linux/sunrpc/cache.h
> > +++ b/include/linux/sunrpc/cache.h
> > @@ -113,9 +113,11 @@ struct cache_detail {
> >  	int			entries;
> > =20
> >  	/* fields for communication over channel */
> > -	struct list_head	queue;
> > +	struct list_head	requests;
> > +	struct list_head	readers;
> >  	spinlock_t		queue_lock;
> >  	wait_queue_head_t	queue_wait;
> > +	u64			next_seqno;
> > =20
> >  	atomic_t		writers;		/* how many time is /channel open */
> >  	time64_t		last_close;		/* if no writers, when did last close */
> > diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> > index aef2607b3d7ffb61a42b9ea2ec17947465c026dc..09389ce8b961fe0cb5a472b=
cf2d3dd0b3faa13a6 100644
> > --- a/net/sunrpc/cache.c
> > +++ b/net/sunrpc/cache.c
> > @@ -399,9 +399,11 @@ static struct delayed_work cache_cleaner;
> >  void sunrpc_init_cache_detail(struct cache_detail *cd)
> >  {
> >  	spin_lock_init(&cd->hash_lock);
> > -	INIT_LIST_HEAD(&cd->queue);
> > +	INIT_LIST_HEAD(&cd->requests);
> > +	INIT_LIST_HEAD(&cd->readers);
> >  	spin_lock_init(&cd->queue_lock);
> >  	init_waitqueue_head(&cd->queue_wait);
> > +	cd->next_seqno =3D 0;
> >  	spin_lock(&cache_list_lock);
> >  	cd->nextcheck =3D 0;
> >  	cd->entries =3D 0;
> > @@ -796,29 +798,20 @@ void cache_clean_deferred(void *owner)
> >   * On read, you get a full request, or block.
> >   * On write, an update request is processed.
> >   * Poll works if anything to read, and always allows write.
> > - *
> > - * Implemented by linked list of requests.  Each open file has
> > - * a ->private that also exists in this list.  New requests are added
> > - * to the end and may wakeup and preceding readers.
> > - * New readers are added to the head.  If, on read, an item is found w=
ith
> > - * CACHE_UPCALLING clear, we free it from the list.
> > - *
> >   */
> > =20
> > -struct cache_queue {
> > -	struct list_head	list;
> > -	int			reader;	/* if 0, then request */
> > -};
> >  struct cache_request {
> > -	struct cache_queue	q;
> > +	struct list_head	list;
> >  	struct cache_head	*item;
> > -	char			* buf;
> > +	char			*buf;
> >  	int			len;
> >  	int			readers;
> > +	u64			seqno;
> >  };
> >  struct cache_reader {
> > -	struct cache_queue	q;
> > +	struct list_head	list;
> >  	int			offset;	/* if non-0, we have a refcnt on next request */
> > +	u64			next_seqno;
> >  };
> > =20
> >  static int cache_request(struct cache_detail *detail,
> > @@ -833,6 +826,17 @@ static int cache_request(struct cache_detail *deta=
il,
> >  	return PAGE_SIZE - len;
> >  }
> > =20
> > +static struct cache_request *
> > +cache_next_request(struct cache_detail *cd, u64 seqno)
> > +{
> > +	struct cache_request *rq;
> > +
> > +	list_for_each_entry(rq, &cd->requests, list)
> > +		if (rq->seqno >=3D seqno)
> > +			return rq;
> > +	return NULL;
> > +}
> > +
> >  static ssize_t cache_read(struct file *filp, char __user *buf, size_t =
count,
> >  			  loff_t *ppos, struct cache_detail *cd)
> >  {
> > @@ -849,20 +853,13 @@ static ssize_t cache_read(struct file *filp, char=
 __user *buf, size_t count,
> >   again:
> >  	spin_lock(&cd->queue_lock);
> >  	/* need to find next request */
> > -	while (rp->q.list.next !=3D &cd->queue &&
> > -	       list_entry(rp->q.list.next, struct cache_queue, list)
> > -	       ->reader) {
> > -		struct list_head *next =3D rp->q.list.next;
> > -		list_move(&rp->q.list, next);
> > -	}
> > -	if (rp->q.list.next =3D=3D &cd->queue) {
> > +	rq =3D cache_next_request(cd, rp->next_seqno);
> > +	if (!rq) {
> >  		spin_unlock(&cd->queue_lock);
> >  		inode_unlock(inode);
> >  		WARN_ON_ONCE(rp->offset);
> >  		return 0;
> >  	}
> > -	rq =3D container_of(rp->q.list.next, struct cache_request, q.list);
> > -	WARN_ON_ONCE(rq->q.reader);
> >  	if (rp->offset =3D=3D 0)
> >  		rq->readers++;
> >  	spin_unlock(&cd->queue_lock);
> > @@ -877,7 +874,7 @@ static ssize_t cache_read(struct file *filp, char _=
_user *buf, size_t count,
> >  	if (rp->offset =3D=3D 0 && !test_bit(CACHE_PENDING, &rq->item->flags)=
) {
> >  		err =3D -EAGAIN;
> >  		spin_lock(&cd->queue_lock);
> > -		list_move(&rp->q.list, &rq->q.list);
> > +		rp->next_seqno =3D rq->seqno + 1;
> >  		spin_unlock(&cd->queue_lock);
>=20
> I don't think we need the spin_lock here any more.
>=20

Good point in both places.

>=20
> >  	} else {
> >  		if (rp->offset + count > rq->len)
> > @@ -889,7 +886,7 @@ static ssize_t cache_read(struct file *filp, char _=
_user *buf, size_t count,
> >  		if (rp->offset >=3D rq->len) {
> >  			rp->offset =3D 0;
> >  			spin_lock(&cd->queue_lock);
> > -			list_move(&rp->q.list, &rq->q.list);
> > +			rp->next_seqno =3D rq->seqno + 1;
> >  			spin_unlock(&cd->queue_lock);
>=20
> Nor here.
>=20
>=20
> >  		}
> >  		err =3D 0;
> > @@ -901,7 +898,7 @@ static ssize_t cache_read(struct file *filp, char _=
_user *buf, size_t count,
> >  		rq->readers--;
> >  		if (rq->readers =3D=3D 0 &&
> >  		    !test_bit(CACHE_PENDING, &rq->item->flags)) {
> > -			list_del(&rq->q.list);
> > +			list_del(&rq->list);
> >  			spin_unlock(&cd->queue_lock);
> >  			cache_put(rq->item, cd);
> >  			kfree(rq->buf);
> > @@ -976,7 +973,6 @@ static __poll_t cache_poll(struct file *filp, poll_=
table *wait,
> >  {
> >  	__poll_t mask;
> >  	struct cache_reader *rp =3D filp->private_data;
> > -	struct cache_queue *cq;
> > =20
> >  	poll_wait(filp, &cd->queue_wait, wait);
> > =20
> > @@ -988,12 +984,8 @@ static __poll_t cache_poll(struct file *filp, poll=
_table *wait,
> > =20
> >  	spin_lock(&cd->queue_lock);
> > =20
> > -	for (cq=3D &rp->q; &cq->list !=3D &cd->queue;
> > -	     cq =3D list_entry(cq->list.next, struct cache_queue, list))
> > -		if (!cq->reader) {
> > -			mask |=3D EPOLLIN | EPOLLRDNORM;
> > -			break;
> > -		}
> > +	if (cache_next_request(cd, rp->next_seqno))
> > +		mask |=3D EPOLLIN | EPOLLRDNORM;
> >  	spin_unlock(&cd->queue_lock);
> >  	return mask;
> >  }
> > @@ -1004,7 +996,7 @@ static int cache_ioctl(struct inode *ino, struct f=
ile *filp,
> >  {
> >  	int len =3D 0;
> >  	struct cache_reader *rp =3D filp->private_data;
> > -	struct cache_queue *cq;
> > +	struct cache_request *rq;
> > =20
> >  	if (cmd !=3D FIONREAD || !rp)
> >  		return -EINVAL;
> > @@ -1014,14 +1006,9 @@ static int cache_ioctl(struct inode *ino, struct=
 file *filp,
> >  	/* only find the length remaining in current request,
> >  	 * or the length of the next request
> >  	 */
> > -	for (cq=3D &rp->q; &cq->list !=3D &cd->queue;
> > -	     cq =3D list_entry(cq->list.next, struct cache_queue, list))
> > -		if (!cq->reader) {
> > -			struct cache_request *cr =3D
> > -				container_of(cq, struct cache_request, q);
> > -			len =3D cr->len - rp->offset;
> > -			break;
> > -		}
> > +	rq =3D cache_next_request(cd, rp->next_seqno);
> > +	if (rq)
> > +		len =3D rq->len - rp->offset;
> >  	spin_unlock(&cd->queue_lock);
> > =20
> >  	return put_user(len, (int __user *)arg);
> > @@ -1042,10 +1029,10 @@ static int cache_open(struct inode *inode, stru=
ct file *filp,
> >  			return -ENOMEM;
> >  		}
> >  		rp->offset =3D 0;
> > -		rp->q.reader =3D 1;
> > +		rp->next_seqno =3D 0;
> > =20
> >  		spin_lock(&cd->queue_lock);
> > -		list_add(&rp->q.list, &cd->queue);
> > +		list_add(&rp->list, &cd->readers);
> >  		spin_unlock(&cd->queue_lock);
> >  	}
> >  	if (filp->f_mode & FMODE_WRITE)
> > @@ -1062,17 +1049,14 @@ static int cache_release(struct inode *inode, s=
truct file *filp,
> >  	if (rp) {
> >  		spin_lock(&cd->queue_lock);
> >  		if (rp->offset) {
> > -			struct cache_queue *cq;
> > -			for (cq=3D &rp->q; &cq->list !=3D &cd->queue;
> > -			     cq =3D list_entry(cq->list.next, struct cache_queue, list))
> > -				if (!cq->reader) {
> > -					container_of(cq, struct cache_request, q)
> > -						->readers--;
> > -					break;
> > -				}
> > +			struct cache_request *rq;
> > +
> > +			rq =3D cache_next_request(cd, rp->next_seqno);
> > +			if (rq)
> > +				rq->readers--;
>=20
> Hmm..  The other place where we decrement ->readers we then check if it
> is zero and if CACHE_PENDING is clear - and do something.
> I suspect we should do that here.
> This bug (if I'm right and it is a bug) if there before you patch, but
> now might be a good time to fix it?
>=20

Good catch. I'll add a patch to fix that preceding these patches, so it
can go to stable (if we think that's worthwhile).
=20
> Thanks.  Nice cleanups.
>=20


Thanks for the review! I'll send a v2 with the spinlock fixes and the
above bugfix.



> NeilBrown
>=20
>=20
> >  			rp->offset =3D 0;
> >  		}
> > -		list_del(&rp->q.list);
> > +		list_del(&rp->list);
> >  		spin_unlock(&cd->queue_lock);
> > =20
> >  		filp->private_data =3D NULL;
> > @@ -1091,27 +1075,24 @@ static int cache_release(struct inode *inode, s=
truct file *filp,
> > =20
> >  static void cache_dequeue(struct cache_detail *detail, struct cache_he=
ad *ch)
> >  {
> > -	struct cache_queue *cq, *tmp;
> > -	struct cache_request *cr;
> > +	struct cache_request *cr, *tmp;
> >  	LIST_HEAD(dequeued);
> > =20
> >  	spin_lock(&detail->queue_lock);
> > -	list_for_each_entry_safe(cq, tmp, &detail->queue, list)
> > -		if (!cq->reader) {
> > -			cr =3D container_of(cq, struct cache_request, q);
> > -			if (cr->item !=3D ch)
> > -				continue;
> > -			if (test_bit(CACHE_PENDING, &ch->flags))
> > -				/* Lost a race and it is pending again */
> > -				break;
> > -			if (cr->readers !=3D 0)
> > -				continue;
> > -			list_move(&cr->q.list, &dequeued);
> > -		}
> > +	list_for_each_entry_safe(cr, tmp, &detail->requests, list) {
> > +		if (cr->item !=3D ch)
> > +			continue;
> > +		if (test_bit(CACHE_PENDING, &ch->flags))
> > +			/* Lost a race and it is pending again */
> > +			break;
> > +		if (cr->readers !=3D 0)
> > +			continue;
> > +		list_move(&cr->list, &dequeued);
> > +	}
> >  	spin_unlock(&detail->queue_lock);
> >  	while (!list_empty(&dequeued)) {
> > -		cr =3D list_entry(dequeued.next, struct cache_request, q.list);
> > -		list_del(&cr->q.list);
> > +		cr =3D list_entry(dequeued.next, struct cache_request, list);
> > +		list_del(&cr->list);
> >  		cache_put(cr->item, detail);
> >  		kfree(cr->buf);
> >  		kfree(cr);
> > @@ -1229,14 +1210,14 @@ static int cache_pipe_upcall(struct cache_detai=
l *detail, struct cache_head *h)
> >  		return -EAGAIN;
> >  	}
> > =20
> > -	crq->q.reader =3D 0;
> >  	crq->buf =3D buf;
> >  	crq->len =3D 0;
> >  	crq->readers =3D 0;
> >  	spin_lock(&detail->queue_lock);
> >  	if (test_bit(CACHE_PENDING, &h->flags)) {
> >  		crq->item =3D cache_get(h);
> > -		list_add_tail(&crq->q.list, &detail->queue);
> > +		crq->seqno =3D detail->next_seqno++;
> > +		list_add_tail(&crq->list, &detail->requests);
> >  		trace_cache_entry_upcall(detail, h);
> >  	} else
> >  		/* Lost a race, no longer PENDING, so don't enqueue */
> >=20
> > --=20
> > 2.53.0
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

