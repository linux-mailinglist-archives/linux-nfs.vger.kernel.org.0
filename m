Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D4790F53
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 02:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbjIDACZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 20:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjIDACZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 20:02:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1519C4
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 17:02:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6347621833;
        Mon,  4 Sep 2023 00:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693785739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gibym/xlmBiFp4TYvijc/jb5bHVA2EQRD2RX1mszCcM=;
        b=TRDUP/7pOcZ1TYdEOLA63I7jUJ/n1vzzgn5Orl3p0u1iRsXfCL5k/sZZh4upgN90yDlu1z
        FDtmRkuap77QgSuevDaXzn1Bsv+6T+CozaOZvy+uwYJsuxPemFrYufS24HcN0N4i8FgTj7
        cOOQvz5v2fLjqU0Mq++rVdZR3jBSakU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693785739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gibym/xlmBiFp4TYvijc/jb5bHVA2EQRD2RX1mszCcM=;
        b=aWhwWLB/PatX6dmTKGRDSPByX2yIyz5Jk46JnbhKjt61IH6FEkzfyqoH0p2EQBKs3+e7q0
        ntwPfovicyRLwyBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24C7A134B2;
        Mon,  4 Sep 2023 00:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RuXUDoke9WRMMQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 04 Sep 2023 00:02:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 05/10] lib: add light-weight queuing mechanism.
In-reply-to: <ZO9oOPno/Z8Is5Jc@tissot.1015granger.net>
References: <20230830025755.21292-1-neilb@suse.de>,
 <20230830025755.21292-6-neilb@suse.de>,
 <ZO9oOPno/Z8Is5Jc@tissot.1015granger.net>
Date:   Mon, 04 Sep 2023 10:02:14 +1000
Message-id: <169378573435.27865.16745813785169393744@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 31 Aug 2023, Chuck Lever wrote:
> On Wed, Aug 30, 2023 at 12:54:48PM +1000, NeilBrown wrote:
> > lwq is a FIFO single-linked queue that only requires a spinlock
> > for dequeueing, which happens in process context.  Enqueueing is atomic
> > with no spinlock and can happen in any context.
> >=20
> > Include a unit test for basic functionality - runs at boot time.  Does
> > not use kunit framework.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/lwq.h | 120 +++++++++++++++++++++++++++++++++++
> >  lib/Kconfig         |   5 ++
> >  lib/Makefile        |   2 +-
> >  lib/lwq.c           | 149 ++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 275 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/lwq.h
> >  create mode 100644 lib/lwq.c
> >=20
> > diff --git a/include/linux/lwq.h b/include/linux/lwq.h
> > new file mode 100644
> > index 000000000000..52b9c81b493a
> > --- /dev/null
> > +++ b/include/linux/lwq.h
> > @@ -0,0 +1,120 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef LWQ_H
> > +#define LWQ_H
> > +/*
> > + * light-weight single-linked queue built from llist
> > + *
> > + * Entries can be enqueued from any context with no locking.
> > + * Entries can be dequeued from process context with integrated locking.
> > + */
> > +#include <linux/container_of.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/llist.h>
> > +
> > +struct lwq_node {
> > +	struct llist_node node;
> > +};
> > +
> > +struct lwq {
> > +	spinlock_t		lock;
> > +	struct llist_node	*ready;		/* entries to be dequeued */
> > +	struct llist_head	new;		/* entries being enqueued */
> > +};
> > +
> > +/**
> > + * lwq_init - initialise a lwq
> > + * @q:	the lwq object
> > + */
> > +static inline void lwq_init(struct lwq *q)
> > +{
> > +	spin_lock_init(&q->lock);
> > +	q->ready =3D NULL;
> > +	init_llist_head(&q->new);
> > +}
> > +
> > +/**
> > + * lwq_empty - test if lwq contains any entry
> > + * @q:	the lwq object
> > + *
> > + * This empty test contains an acquire barrier so that if a wakeup
> > + * is sent when lwq_dequeue returns true, it is safe to go to sleep after
> > + * a test on lwq_empty().
> > + */
> > +static inline bool lwq_empty(struct lwq *q)
> > +{
> > +	/* acquire ensures ordering wrt lwq_enqueue() */
> > +	return smp_load_acquire(&q->ready) =3D=3D NULL && llist_empty(&q->new);
> > +}
> > +
> > +struct llist_node *__lwq_dequeue(struct lwq *q);
> > +/**
> > + * lwq_dequeue - dequeue first (oldest) entry from lwq
> > + * @q:		the queue to dequeue from
> > + * @type:	the type of object to return
> > + * @member:	them member in returned object which is an lwq_node.
> > + *
> > + * Remove a single object from the lwq and return it.  This will take
> > + * a spinlock and so must always be called in the same context, typcially
> > + * process contet.
> > + */
> > +#define lwq_dequeue(q, type, member)					\
> > +	({ struct llist_node *_n =3D __lwq_dequeue(q);			\
> > +	  _n ? container_of(_n, type, member.node) : NULL; })
> > +
> > +struct llist_node *lwq_dequeue_all(struct lwq *q);
> > +
> > +/**
> > + * lwq_for_each_safe - iterate over detached queue allowing deletion
> > + * @_n:		iterator variable
> > + * @_t1:	temporary struct llist_node **
> > + * @_t2:	temporary struct llist_node *
> > + * @_l:		address of llist_node pointer from lwq_dequeue_all()
> > + * @_member:	member in _n where lwq_node is found.
> > + *
> > + * Iterate over members in a dequeued list.  If the iterator variable
> > + * is set to NULL, the iterator removes that entry from the queue.
> > + */
> > +#define lwq_for_each_safe(_n, _t1, _t2, _l, _member)			\
> > +	for (_t1 =3D (_l);						\
> > +	     *(_t1) ? (_n =3D container_of(*(_t1), typeof(*(_n)), _member.node)=
,\
> > +		       _t2 =3D ((*_t1)->next),				\
> > +		       true)						\
> > +	     : false;							\
> > +	     (_n) ? (_t1 =3D &(_n)->_member.node.next, 0)			\
> > +	     : ((*(_t1) =3D (_t2)),  0))
> > +
> > +/**
> > + * lwq_enqueue - add a new item to the end of the queue
> > + * @n	- the lwq_node embedded in the item to be added
> > + * @q	- the lwq to append to.
> > + *
> > + * No locking is needed to append to the queue so this can
> > + * be called from any context.
> > + * Return %true is the list may have previously been empty.
> > + */
> > +static inline bool lwq_enqueue(struct lwq_node *n, struct lwq *q)
> > +{
> > +	/* acquire enqures ordering wrt lwq_dequeue */
> > +	return llist_add(&n->node, &q->new) &&
> > +		smp_load_acquire(&q->ready) =3D=3D NULL;
> > +}
> > +
> > +/**
> > + * lwq_enqueue_batch - add a list of new items to the end of the queue
> > + * @n	- the lwq_node embedded in the first item to be added
> > + * @q	- the lwq to append to.
> > + *
> > + * No locking is needed to append to the queue so this can
> > + * be called from any context.
> > + * Return %true is the list may have previously been empty.
> > + */
> > +static inline bool lwq_enqueue_batch(struct llist_node *n, struct lwq *q)
> > +{
> > +	struct llist_node *e =3D n;
> > +
> > +	/* acquire enqures ordering wrt lwq_dequeue */
> > +	return llist_add_batch(llist_reverse_order(n), e, &q->new) &&
> > +		smp_load_acquire(&q->ready) =3D=3D NULL;
> > +}
> > +#endif /* LWQ_H */
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 5c2da561c516..6620bdba4f94 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -763,3 +763,8 @@ config ASN1_ENCODER
> > =20
> >  config POLYNOMIAL
> >         tristate
> > +
> > +config LWQ_TEST
> > +	bool "RPC: enable boot-time test for lwq queuing"
> > +	help
> > +          Enable boot-time test of lwq functionality.
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 1ffae65bb7ee..4b67c2d6af62 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -45,7 +45,7 @@ obj-y	+=3D lockref.o
> >  obj-y +=3D bcd.o sort.o parser.o debug_locks.o random32.o \
> >  	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
> >  	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
> > -	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
> > +	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
> >  	 percpu-refcount.o rhashtable.o base64.o \
> >  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
> >  	 generic-radix-tree.o
> > diff --git a/lib/lwq.c b/lib/lwq.c
> > new file mode 100644
> > index 000000000000..d6be6dda3867
> > --- /dev/null
> > +++ b/lib/lwq.c
> > @@ -0,0 +1,149 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Light weight single-linked queue.
> > + *
> > + * Entries are enqueued to the head of an llist, with no blocking.
> > + * This can happen in any context.
> > + *
> > + * Entries are dequeued using a spinlock to protect against
> > + * multiple access.  The llist is staged in reverse order, and refreshed
> > + * from the llist when it exhausts.
> > + */
> > +#include <linux/rcupdate.h>
> > +#include <linux/lwq.h>
> > +
> > +struct llist_node *__lwq_dequeue(struct lwq *q)
> > +{
> > +	struct llist_node *this;
> > +
> > +	if (lwq_empty(q))
> > +		return NULL;
> > +	spin_lock(&q->lock);
> > +	this =3D q->ready;
> > +	if (!this && !llist_empty(&q->new)) {
> > +		/* ensure queue doesn't appear transiently lwq_empty */
> > +		smp_store_release(&q->ready, (void *)1);
> > +		this =3D llist_reverse_order(llist_del_all(&q->new));
> > +		if (!this)
> > +			q->ready =3D NULL;
> > +	}
> > +	if (this)
> > +		q->ready =3D llist_next(this);
> > +	spin_unlock(&q->lock);
> > +	return this;
> > +}
> > +
> > +/**
> > + * lwq_dequeue_all - dequeue all currently enqueued objects
> > + * @q:	the queue to dequeue from
> > + *
> > + * Remove and return a linked list of llist_nodes of all the objects tha=
t were
> > + * in the queue. The first on the list will be the object that was least
> > + * recently enqueued.
> > + */
> > +struct llist_node *lwq_dequeue_all(struct lwq *q)
> > +{
> > +	struct llist_node *r, *t, **ep;
> > +
> > +	if (lwq_empty(q))
> > +		return NULL;
> > +
> > +	spin_lock(&q->lock);
> > +	r =3D q->ready;
> > +	q->ready =3D NULL;
> > +	t =3D llist_del_all(&q->new);
> > +	spin_unlock(&q->lock);
> > +	ep =3D &r;
> > +	while (*ep)
> > +		ep =3D &(*ep)->next;
> > +	*ep =3D llist_reverse_order(t);
> > +	return r;
> > +}
>=20
> ERROR: modpost: "lwq_dequeue_all" [net/sunrpc/sunrpc.ko] undefined!
> ERROR: modpost: "__lwq_dequeue" [net/sunrpc/sunrpc.ko] undefined!
> make[3]: *** [/home/cel/src/linux/even-releases/scripts/Makefile.modpost:14=
4: Module.symvers] Error 1
> make[2]: *** [/home/cel/src/linux/even-releases/Makefile:1984: modpost] Err=
or 2
> make[1]: *** [/home/cel/src/linux/even-releases/Makefile:234: __sub-make] E=
rror 2
> make: *** [Makefile:234: __sub-make] Error 2
>=20
> You might need an EXPORT_SYMBOL_GPL or two now.

:-)  It seems something else did turn up..

Yes,
+EXPORT_SYMBOL_GPL(__lwq_dequeue);
...
+EXPORT_SYMBOL_GPL(lwq_dequeue_all);

should be enough.

Thanks,
NeilBrown
