Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA1790F4D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbjICX7k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 19:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbjICX7j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 19:59:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B10C4
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 16:59:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A020E1F37E;
        Sun,  3 Sep 2023 23:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693785574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AOnjKCa8/HpspZ+oMTGihS4QqucSQGqSVD597Wj2MI=;
        b=CirkhNnHbw2XeY/XD6fXAjQEw/MrERjvUwKsW2AU1L8ae3fMMrzkQPFbB/i/ZciAZiPo6p
        yHg6eEVW/4HP52dcselTYrC9yq0LKiCZgfYo/D1aaKSGGnkVoEhIZ9ApXNRjm1f7kkW6nV
        Z+XXHTycWVgZb7O7CwKVGjKlvERymdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693785574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AOnjKCa8/HpspZ+oMTGihS4QqucSQGqSVD597Wj2MI=;
        b=ofoOV9BV4M5mER/r/iQrE0a8HTwCIjEKbBVhjIW8UgwufUltXxxSk0PnoFLSgVe3bcM1rp
        2QhHe8z39387tAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60CBE13413;
        Sun,  3 Sep 2023 23:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wehxBeUd9WQlMAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 03 Sep 2023 23:59:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 05/10] lib: add light-weight queuing mechanism.
In-reply-to: <ZO9htrRySAB+phNL@tissot.1015granger.net>
References: <20230830025755.21292-1-neilb@suse.de>,
 <20230830025755.21292-6-neilb@suse.de>,
 <ZO9htrRySAB+phNL@tissot.1015granger.net>
Date:   Mon, 04 Sep 2023 09:59:30 +1000
Message-id: <169378557012.27865.1484446534280511321@noble.neil.brown.name>
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
> > 
> > Include a unit test for basic functionality - runs at boot time.  Does
> > not use kunit framework.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/lwq.h | 120 +++++++++++++++++++++++++++++++++++
> >  lib/Kconfig         |   5 ++
> >  lib/Makefile        |   2 +-
> >  lib/lwq.c           | 149 ++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 275 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/lwq.h
> >  create mode 100644 lib/lwq.c
> > 
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
> > +	q->ready = NULL;
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
> > +	return smp_load_acquire(&q->ready) == NULL && llist_empty(&q->new);
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
> > +	({ struct llist_node *_n = __lwq_dequeue(q);			\
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
> > +	for (_t1 = (_l);						\
> > +	     *(_t1) ? (_n = container_of(*(_t1), typeof(*(_n)), _member.node),\
> > +		       _t2 = ((*_t1)->next),				\
> > +		       true)						\
> > +	     : false;							\
> > +	     (_n) ? (_t1 = &(_n)->_member.node.next, 0)			\
> > +	     : ((*(_t1) = (_t2)),  0))
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
> > +		smp_load_acquire(&q->ready) == NULL;
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
> > +	struct llist_node *e = n;
> > +
> > +	/* acquire enqures ordering wrt lwq_dequeue */
> > +	return llist_add_batch(llist_reverse_order(n), e, &q->new) &&
> > +		smp_load_acquire(&q->ready) == NULL;
> > +}
> > +#endif /* LWQ_H */
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 5c2da561c516..6620bdba4f94 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -763,3 +763,8 @@ config ASN1_ENCODER
> >  
> >  config POLYNOMIAL
> >         tristate
> > +
> > +config LWQ_TEST
> > +	bool "RPC: enable boot-time test for lwq queuing"
> 
> Since LWQ is no longer RPC specific, you can drop the "RPC: " from
> the option's short description.

Thanks.  I changed "RPC" to "lib" locally.  If I need to resend that
will be included, or you could just make the change if nothing else
turns up.

NeilBrown
