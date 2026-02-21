Return-Path: <linux-nfs+bounces-19081-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KjLSH5U0mmmgZgMAu9opvQ
	(envelope-from <linux-nfs+bounces-19081-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 23:41:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB716E257
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 23:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F7473024149
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 22:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6C2F531F;
	Sat, 21 Feb 2026 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MrTYm4Ou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Spc9dloY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6E286881;
	Sat, 21 Feb 2026 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771713682; cv=none; b=mb5KDNaVTq6nrMCvz4ikCPUqZdTfaGgq94Reg99E07hTvmuwGrvi1ZpxexOOuW+mSwt7OWe67VG/dhR0WL6E/otG6ZTUBznmJBGKYoiwpmwfcrrOWPQqgFgOcdWM99REACAGtLjUGrWHYQpL/prMWkdjEKHhe7RAIW4bQnvt8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771713682; c=relaxed/simple;
	bh=S7fJCq9EAvhBIjwF2Hmo/3gR2cXZce20N15+iKlwQjo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=efI6ww1XRELzR7uIRnhwHXpHhnsucpvuKkEcVxBPrPtNPHeE4FesluPVnCaJilIHIX5DjtYpq8bWPYV9PRj/GhUPIjK1N7S8jJxnGzBKhKTrznZdZQPk3PKe4uA3ZmSzBJ3cdvJSvG0RTQL61lkok+vIIxqrtEeTU4VrRJ77QOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MrTYm4Ou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Spc9dloY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACC667A007C;
	Sat, 21 Feb 2026 17:41:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sat, 21 Feb 2026 17:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771713679; x=1771800079; bh=ArnoJo5wpYS+6UtfZprQ5QlRZMZB75x2wAo
	w+8OMNZY=; b=MrTYm4Ou0i0Bun4A0g12NXprL0oR01uwvIvVWokpywogEOn0cS6
	U14DXpbPKOUSMGX8hFsxJFWOTpPPNJhSprOnOZTi7HKM5Od1AvAq1iN9sZhczvoB
	vyudPziYDhaW7BtDVsPTDujxAnyHbWXtl0bmR5d4WANJ1yOuVEuqnQ6RTTN/vzmE
	Xd09LoIyjam57P1sOJyJRIq2j4id/3XjieD3rUmMjJW2N7nP9GRALHHHlCP4a1nt
	pK0X4mlKKzct2JvGHDGljh4A7kz4/UizIAQ5BmqJdkmLZPVd2POpW4oKPVGfo6ni
	ftbY4++jnl2mB/CE0WEw8l49aVp9aeeQrYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771713679; x=
	1771800079; bh=ArnoJo5wpYS+6UtfZprQ5QlRZMZB75x2wAow+8OMNZY=; b=S
	pc9dloY3/0euDPcOEfsqRFTGEvWgTFs01xvz13drGQBJoa0JZa6mXioG3dRSGlbc
	oGWJPs3VkAVlJ9Vazvtp2cgPBr9y3aoZMNzVndW2X7Fmks3JqGa1QvY5yunHUzLV
	3vC6pjovk67vf+aWr53bYHUWDl/TTAlvH7Nqvh8aUOUXs6NLlUM/a9+NBTqqZp2H
	CoC+9o8ZPqTxSfqEXmO8DD6fGmE8JXLayTZJYHYoVtzet/l7U8iKkig+nmZ7k+88
	ct4N6wo2Ny+OEyKNiNsUqweZ9oNapdcoUgW+9I6grNWi17LXBdG98rtpm2BPu8Vb
	Gk7TjESSdZBKzoCVjh1Ew==
X-ME-Sender: <xms:jzSaaScdCd3rkBIz3qbhVZc6amPoY0wVATsO5_rZmbJ6Ib20B1Utkw>
    <xme:jzSaaRIpkwxmvvGDZ43PABlBwwcFsudfQKIcOR2P8gCTkwEwWBF6VXhN7zwbZnDRb
    msyk-I-HyW-rTMt0jDAryCiV1qOP6O9T5d90gaCVtE2vU2d>
X-ME-Received: <xmr:jzSaaXzYposTIMWMJVs9nqZ3aeS_su9w-ED4-qvo-E35Z8R9eJse6jCqtai6nRQX0P8sCma-crGjZupjG9aGIjr4TiqL_p1I-ltkrZ3okX1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    eptdehkeffudekueejgfekgfegjefftdduiefgheetueekvdefvddutefhteffhffgnecu
    ffhomhgrihhnpehlihhsthdrnhgvgihtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlph
    gvhidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    epuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepthhrohhnughmhies
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jzSaaftKe4i65fOINk9kAx7g80h72fMhR_fQM20u9Mbr-5zxMJG3FA>
    <xmx:jzSaaSBrR3QpuegjHEclB6wN0TODYuEq7oZIqCZAUuqZwYKUk2MPvA>
    <xmx:jzSaaZFD86VLEmPFDEKFH29zdDd0PDtZtRyJ8DuYxfdytSo6Gk_OwA>
    <xmx:jzSaaaBDmrIW-vM97pVYBkAk7J4gwCzPC-Nt6eX-VQa3KRCMjM_hAQ>
    <xmx:jzSaaUMgd-PYTPmfbaFVzWRvyxe_AHJPKVfbaEvJdGjd0oiUsysUJ6Vx>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 17:41:16 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 3/3] sunrpc: split cache_detail queue into request and
 reader lists
In-reply-to: <20260220-sunrpc-cache-v1-3-47d04014c245@kernel.org>
References: <20260220-sunrpc-cache-v1-0-47d04014c245@kernel.org>,
 <20260220-sunrpc-cache-v1-3-47d04014c245@kernel.org>
Date: Sun, 22 Feb 2026 09:41:14 +1100
Message-id: <177171367423.8396.10176251932730619714@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19081-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,brown.name:replyto,noble.neil.brown.name:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: CAFB716E257
X-Rspamd-Action: no action

On Fri, 20 Feb 2026, Jeff Layton wrote:
> Replace the single interleaved queue (which mixed cache_request and
> cache_reader entries distinguished by a ->reader flag) with two
> dedicated lists: cd->requests for upcall requests and cd->readers
> for open file handles.
>=20
> Readers now track their position via a monotonically increasing
> sequence number (next_seqno) rather than by their position in the
> shared list. Each cache_request is assigned a seqno when enqueued,
> and a new cache_next_request() helper finds the next request at or
> after a given seqno.
>=20
> This eliminates the cache_queue wrapper struct entirely, simplifies
> the reader-skipping loops in cache_read/cache_poll/cache_ioctl/
> cache_release, and makes the data flow easier to reason about.
>=20
> Also, remove an obsolete comment. CACHE_UPCALLING hasn't existed
> since before the git era started.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/sunrpc/cache.h |   4 +-
>  net/sunrpc/cache.c           | 125 ++++++++++++++++++---------------------=
----
>  2 files changed, 56 insertions(+), 73 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> index 031379efba24d40f64ce346cf1032261d4b98d05..b1e595c2615bd4be4d9ad19f71a=
8f4d08bd74a9b 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -113,9 +113,11 @@ struct cache_detail {
>  	int			entries;
> =20
>  	/* fields for communication over channel */
> -	struct list_head	queue;
> +	struct list_head	requests;
> +	struct list_head	readers;
>  	spinlock_t		queue_lock;
>  	wait_queue_head_t	queue_wait;
> +	u64			next_seqno;
> =20
>  	atomic_t		writers;		/* how many time is /channel open */
>  	time64_t		last_close;		/* if no writers, when did last close */
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index aef2607b3d7ffb61a42b9ea2ec17947465c026dc..09389ce8b961fe0cb5a472bcf2d=
3dd0b3faa13a6 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -399,9 +399,11 @@ static struct delayed_work cache_cleaner;
>  void sunrpc_init_cache_detail(struct cache_detail *cd)
>  {
>  	spin_lock_init(&cd->hash_lock);
> -	INIT_LIST_HEAD(&cd->queue);
> +	INIT_LIST_HEAD(&cd->requests);
> +	INIT_LIST_HEAD(&cd->readers);
>  	spin_lock_init(&cd->queue_lock);
>  	init_waitqueue_head(&cd->queue_wait);
> +	cd->next_seqno =3D 0;
>  	spin_lock(&cache_list_lock);
>  	cd->nextcheck =3D 0;
>  	cd->entries =3D 0;
> @@ -796,29 +798,20 @@ void cache_clean_deferred(void *owner)
>   * On read, you get a full request, or block.
>   * On write, an update request is processed.
>   * Poll works if anything to read, and always allows write.
> - *
> - * Implemented by linked list of requests.  Each open file has
> - * a ->private that also exists in this list.  New requests are added
> - * to the end and may wakeup and preceding readers.
> - * New readers are added to the head.  If, on read, an item is found with
> - * CACHE_UPCALLING clear, we free it from the list.
> - *
>   */
> =20
> -struct cache_queue {
> -	struct list_head	list;
> -	int			reader;	/* if 0, then request */
> -};
>  struct cache_request {
> -	struct cache_queue	q;
> +	struct list_head	list;
>  	struct cache_head	*item;
> -	char			* buf;
> +	char			*buf;
>  	int			len;
>  	int			readers;
> +	u64			seqno;
>  };
>  struct cache_reader {
> -	struct cache_queue	q;
> +	struct list_head	list;
>  	int			offset;	/* if non-0, we have a refcnt on next request */
> +	u64			next_seqno;
>  };
> =20
>  static int cache_request(struct cache_detail *detail,
> @@ -833,6 +826,17 @@ static int cache_request(struct cache_detail *detail,
>  	return PAGE_SIZE - len;
>  }
> =20
> +static struct cache_request *
> +cache_next_request(struct cache_detail *cd, u64 seqno)
> +{
> +	struct cache_request *rq;
> +
> +	list_for_each_entry(rq, &cd->requests, list)
> +		if (rq->seqno >=3D seqno)
> +			return rq;
> +	return NULL;
> +}
> +
>  static ssize_t cache_read(struct file *filp, char __user *buf, size_t coun=
t,
>  			  loff_t *ppos, struct cache_detail *cd)
>  {
> @@ -849,20 +853,13 @@ static ssize_t cache_read(struct file *filp, char __u=
ser *buf, size_t count,
>   again:
>  	spin_lock(&cd->queue_lock);
>  	/* need to find next request */
> -	while (rp->q.list.next !=3D &cd->queue &&
> -	       list_entry(rp->q.list.next, struct cache_queue, list)
> -	       ->reader) {
> -		struct list_head *next =3D rp->q.list.next;
> -		list_move(&rp->q.list, next);
> -	}
> -	if (rp->q.list.next =3D=3D &cd->queue) {
> +	rq =3D cache_next_request(cd, rp->next_seqno);
> +	if (!rq) {
>  		spin_unlock(&cd->queue_lock);
>  		inode_unlock(inode);
>  		WARN_ON_ONCE(rp->offset);
>  		return 0;
>  	}
> -	rq =3D container_of(rp->q.list.next, struct cache_request, q.list);
> -	WARN_ON_ONCE(rq->q.reader);
>  	if (rp->offset =3D=3D 0)
>  		rq->readers++;
>  	spin_unlock(&cd->queue_lock);
> @@ -877,7 +874,7 @@ static ssize_t cache_read(struct file *filp, char __use=
r *buf, size_t count,
>  	if (rp->offset =3D=3D 0 && !test_bit(CACHE_PENDING, &rq->item->flags)) {
>  		err =3D -EAGAIN;
>  		spin_lock(&cd->queue_lock);
> -		list_move(&rp->q.list, &rq->q.list);
> +		rp->next_seqno =3D rq->seqno + 1;
>  		spin_unlock(&cd->queue_lock);

I don't think we need the spin_lock here any more.


>  	} else {
>  		if (rp->offset + count > rq->len)
> @@ -889,7 +886,7 @@ static ssize_t cache_read(struct file *filp, char __use=
r *buf, size_t count,
>  		if (rp->offset >=3D rq->len) {
>  			rp->offset =3D 0;
>  			spin_lock(&cd->queue_lock);
> -			list_move(&rp->q.list, &rq->q.list);
> +			rp->next_seqno =3D rq->seqno + 1;
>  			spin_unlock(&cd->queue_lock);

Nor here.


>  		}
>  		err =3D 0;
> @@ -901,7 +898,7 @@ static ssize_t cache_read(struct file *filp, char __use=
r *buf, size_t count,
>  		rq->readers--;
>  		if (rq->readers =3D=3D 0 &&
>  		    !test_bit(CACHE_PENDING, &rq->item->flags)) {
> -			list_del(&rq->q.list);
> +			list_del(&rq->list);
>  			spin_unlock(&cd->queue_lock);
>  			cache_put(rq->item, cd);
>  			kfree(rq->buf);
> @@ -976,7 +973,6 @@ static __poll_t cache_poll(struct file *filp, poll_tabl=
e *wait,
>  {
>  	__poll_t mask;
>  	struct cache_reader *rp =3D filp->private_data;
> -	struct cache_queue *cq;
> =20
>  	poll_wait(filp, &cd->queue_wait, wait);
> =20
> @@ -988,12 +984,8 @@ static __poll_t cache_poll(struct file *filp, poll_tab=
le *wait,
> =20
>  	spin_lock(&cd->queue_lock);
> =20
> -	for (cq=3D &rp->q; &cq->list !=3D &cd->queue;
> -	     cq =3D list_entry(cq->list.next, struct cache_queue, list))
> -		if (!cq->reader) {
> -			mask |=3D EPOLLIN | EPOLLRDNORM;
> -			break;
> -		}
> +	if (cache_next_request(cd, rp->next_seqno))
> +		mask |=3D EPOLLIN | EPOLLRDNORM;
>  	spin_unlock(&cd->queue_lock);
>  	return mask;
>  }
> @@ -1004,7 +996,7 @@ static int cache_ioctl(struct inode *ino, struct file =
*filp,
>  {
>  	int len =3D 0;
>  	struct cache_reader *rp =3D filp->private_data;
> -	struct cache_queue *cq;
> +	struct cache_request *rq;
> =20
>  	if (cmd !=3D FIONREAD || !rp)
>  		return -EINVAL;
> @@ -1014,14 +1006,9 @@ static int cache_ioctl(struct inode *ino, struct fil=
e *filp,
>  	/* only find the length remaining in current request,
>  	 * or the length of the next request
>  	 */
> -	for (cq=3D &rp->q; &cq->list !=3D &cd->queue;
> -	     cq =3D list_entry(cq->list.next, struct cache_queue, list))
> -		if (!cq->reader) {
> -			struct cache_request *cr =3D
> -				container_of(cq, struct cache_request, q);
> -			len =3D cr->len - rp->offset;
> -			break;
> -		}
> +	rq =3D cache_next_request(cd, rp->next_seqno);
> +	if (rq)
> +		len =3D rq->len - rp->offset;
>  	spin_unlock(&cd->queue_lock);
> =20
>  	return put_user(len, (int __user *)arg);
> @@ -1042,10 +1029,10 @@ static int cache_open(struct inode *inode, struct f=
ile *filp,
>  			return -ENOMEM;
>  		}
>  		rp->offset =3D 0;
> -		rp->q.reader =3D 1;
> +		rp->next_seqno =3D 0;
> =20
>  		spin_lock(&cd->queue_lock);
> -		list_add(&rp->q.list, &cd->queue);
> +		list_add(&rp->list, &cd->readers);
>  		spin_unlock(&cd->queue_lock);
>  	}
>  	if (filp->f_mode & FMODE_WRITE)
> @@ -1062,17 +1049,14 @@ static int cache_release(struct inode *inode, struc=
t file *filp,
>  	if (rp) {
>  		spin_lock(&cd->queue_lock);
>  		if (rp->offset) {
> -			struct cache_queue *cq;
> -			for (cq=3D &rp->q; &cq->list !=3D &cd->queue;
> -			     cq =3D list_entry(cq->list.next, struct cache_queue, list))
> -				if (!cq->reader) {
> -					container_of(cq, struct cache_request, q)
> -						->readers--;
> -					break;
> -				}
> +			struct cache_request *rq;
> +
> +			rq =3D cache_next_request(cd, rp->next_seqno);
> +			if (rq)
> +				rq->readers--;

Hmm..  The other place where we decrement ->readers we then check if it
is zero and if CACHE_PENDING is clear - and do something.
I suspect we should do that here.
This bug (if I'm right and it is a bug) if there before you patch, but
now might be a good time to fix it?

Thanks.  Nice cleanups.

NeilBrown


>  			rp->offset =3D 0;
>  		}
> -		list_del(&rp->q.list);
> +		list_del(&rp->list);
>  		spin_unlock(&cd->queue_lock);
> =20
>  		filp->private_data =3D NULL;
> @@ -1091,27 +1075,24 @@ static int cache_release(struct inode *inode, struc=
t file *filp,
> =20
>  static void cache_dequeue(struct cache_detail *detail, struct cache_head *=
ch)
>  {
> -	struct cache_queue *cq, *tmp;
> -	struct cache_request *cr;
> +	struct cache_request *cr, *tmp;
>  	LIST_HEAD(dequeued);
> =20
>  	spin_lock(&detail->queue_lock);
> -	list_for_each_entry_safe(cq, tmp, &detail->queue, list)
> -		if (!cq->reader) {
> -			cr =3D container_of(cq, struct cache_request, q);
> -			if (cr->item !=3D ch)
> -				continue;
> -			if (test_bit(CACHE_PENDING, &ch->flags))
> -				/* Lost a race and it is pending again */
> -				break;
> -			if (cr->readers !=3D 0)
> -				continue;
> -			list_move(&cr->q.list, &dequeued);
> -		}
> +	list_for_each_entry_safe(cr, tmp, &detail->requests, list) {
> +		if (cr->item !=3D ch)
> +			continue;
> +		if (test_bit(CACHE_PENDING, &ch->flags))
> +			/* Lost a race and it is pending again */
> +			break;
> +		if (cr->readers !=3D 0)
> +			continue;
> +		list_move(&cr->list, &dequeued);
> +	}
>  	spin_unlock(&detail->queue_lock);
>  	while (!list_empty(&dequeued)) {
> -		cr =3D list_entry(dequeued.next, struct cache_request, q.list);
> -		list_del(&cr->q.list);
> +		cr =3D list_entry(dequeued.next, struct cache_request, list);
> +		list_del(&cr->list);
>  		cache_put(cr->item, detail);
>  		kfree(cr->buf);
>  		kfree(cr);
> @@ -1229,14 +1210,14 @@ static int cache_pipe_upcall(struct cache_detail *d=
etail, struct cache_head *h)
>  		return -EAGAIN;
>  	}
> =20
> -	crq->q.reader =3D 0;
>  	crq->buf =3D buf;
>  	crq->len =3D 0;
>  	crq->readers =3D 0;
>  	spin_lock(&detail->queue_lock);
>  	if (test_bit(CACHE_PENDING, &h->flags)) {
>  		crq->item =3D cache_get(h);
> -		list_add_tail(&crq->q.list, &detail->queue);
> +		crq->seqno =3D detail->next_seqno++;
> +		list_add_tail(&crq->list, &detail->requests);
>  		trace_cache_entry_upcall(detail, h);
>  	} else
>  		/* Lost a race, no longer PENDING, so don't enqueue */
>=20
> --=20
> 2.53.0
>=20
>=20


