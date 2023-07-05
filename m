Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF78747ADA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jul 2023 03:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGEBIl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jul 2023 21:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEBIl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jul 2023 21:08:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF4210DD
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 18:08:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 776DC1F8D9;
        Wed,  5 Jul 2023 01:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688519318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8g/P+lz2J9H9FHAfC3uIcGSPWcazDIR8ftztqEUCOrw=;
        b=JBYWfP6D9ruK6DBpyORnY68G0plFdmYaKIPLJxKlVlHfSzyZu7nIHXlmZTMLVrr9YdEYxX
        nLTkaT+kA6C5H9XpKdjGc8DcgQILdHkPT1KsBQGJbZzKv4EhczWcVn9n2ir0sKgBMlQ43f
        Zvpql0D1h9f168Qek9MRAJL6IcWfsmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688519318;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8g/P+lz2J9H9FHAfC3uIcGSPWcazDIR8ftztqEUCOrw=;
        b=831aMR7AaHqwKAKKf8yFkpKuAqPAXc2PYIarvTBkVXKHO2ieBbAn/L9WhJGl1GQQH5UHdN
        ETix3kc4tWrNpLDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 210EB133F7;
        Wed,  5 Jul 2023 01:08:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CxE0MZPCpGQ/FAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 05 Jul 2023 01:08:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 0/9] SUNRPC service thread scheduler optimizations
In-reply-to: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
Date:   Wed, 05 Jul 2023 11:08:32 +1000
Message-id: <168851931219.8939.14382911673248383020@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


I've been pondering this scheduling mechanism in sunrpc/svc some more,
and I wonder if rather than optimising the search, we should eliminate
it.

Instead we could have a linked list of idle threads using llist.h

svc_enqueue_xprt calls llist_del_first() and if the result is not NULL,
that thread is deemed busy (because it isn't on the list) and is woken.

choose_victim() could also use llist_del_first().  If nothing is there
it could set a flag which gets cleared by the next thread to go idle.
That thread exits ..  or something.  Some interlock would be needed but
it shouldn't be too hard.

svc_exit_thread would have difficulty removing itself from the idle
list, if it wasn't busy..  Possibly we could disallow that case (I think
sending a signal to a thread can make it exit while idle).
Alternately we could use llist_del_all() to clear the list, then wake
them all up so that they go back on the list if there is nothing to do
and if they aren't trying to exit.  That is fairly heavy handed, but
isn't a case that we need to optimise.

If you think that might be worth pursuing, I could have a go at writing
the patch - probably on top of all the cleanups in your series before
the xarray is added.

I also wonder if we should avoid waking too many threads up at once.
If multiple events happen in quick succession, we currently wake up
multiple threads and if there is any scheduling delay (which is expected
based on Commit 22700f3c6df5 ("SUNRPC: Improve ordering of transport processi=
ng"))
then by the time the threads wake up, there may no longer be work to do
as another thread might have gone idle and taken the work.

Instead we could have a limit on the number of threads waking up -
possibly 1 or 3.  If the counter is maxed out, don't do a wake up.
When a thread wakes up, it decrements the counter, dequeues some work,
and if there is more to do, then it queues another task.
I imagine the same basic protocol would be used for creating new threads
when load is high - start just one at a time, though maybe a new thread
would handle a first request before possibly starting another thread.

But this is a stretch goal - not the main focus.

Thanks,
NeilBrown
