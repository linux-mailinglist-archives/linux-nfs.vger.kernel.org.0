Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F446438D
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 00:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhK3Xjn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Nov 2021 18:39:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43302 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345209AbhK3Xjl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Nov 2021 18:39:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 706C5212B9;
        Tue, 30 Nov 2021 23:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638315379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuFDZwrz6rfCvh8MSAFZWF9YhsNDb7zqLBQgBH3ZLn8=;
        b=ezElJ8zIdAUg+nZkgE4GaWbtAbw3kxklQ3/LaSz+ZVp9FPskhpeBHdLl0tHPc156I7drfB
        62ENjfKbOP4yt5hwj/PVuMYg3h0gPL9IVv0e4+hSTIvYeQMTqGvH8zKAbVOkZyRtucHWyF
        7KXGbOfM4MCXG4B9dZn2P09f49wbYNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638315379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuFDZwrz6rfCvh8MSAFZWF9YhsNDb7zqLBQgBH3ZLn8=;
        b=uqURaKHnb0DgC3j7a9DZZ1614xyeTJdNQLvImacie/zxDdS8rR7sffsuhFVo3OPLcPxQYc
        NCPigdAvawWznVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55F1013D6F;
        Tue, 30 Nov 2021 23:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id STUFBXK1pmG4FAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 30 Nov 2021 23:36:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     paulmck@kernel.org
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Fix RCU-related sparse splat
In-reply-to: <20211130225250.GC641268@paulmck-ThinkPad-P17-Gen-1>
References: <163821156142.90770.4019362941494014139.stgit@bazille.1015granger.net>,
 <20211130225250.GC641268@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 01 Dec 2021 10:36:15 +1100
Message-id: <163831537509.26075.12859361728901873347@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 01 Dec 2021, paulmck@kernel.org wrote:
> On Mon, Nov 29, 2021 at 01:46:07PM -0500, Chuck Lever wrote:
> > To address this error:
> >=20
> >   CC [M]  fs/nfsd/filecache.o
> >   CHECK   /home/cel/src/linux/linux/fs/nfsd/filecache.c
> > /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9: error: incompatible =
types in comparison expression (different address spaces):
> > /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net [noder=
ef] __rcu *
> > /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net *
> >=20
> > The "net" field in struct nfsd_fcache_disposal is not annotated as
> > requiring an RCU assignment, so replace the macro that includes an
> > invocation of rcu_check_sparse() with an equivalent that does not.
> >=20
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> From an RCU perspective:
>=20
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> But it would be good to get someone more familiar with the code to
> look at this.

There is a global list of 'struct nfsd_fcache_disposal', potentially one
for each network namespace.  Each contains a '*net' which is effectively
an opaque lookup key.  It is never dereferenced - only used to find the
nfsd_fcache_disposal which matches a given 'struct net *'.

The lookup happens under rcu_read_lock().  A 'struct net' is freed after
a grace period (see cleanup_net() in net_namespace.c) so to ensure the
lookup doesn't find a false positive - caused by a 'struct net' being
deallocated and reallocated, it is sufficient to clear the ->net pointer
while the the net is known to still be active.  At most, a write-barrier
might be justified.  i.e. smp_store_release(l->net, NULL);

However ... the list of nfsd_fcache_disposal seems unnecessary.
nfsd has a 'struct nfsd_net' which parallels any interesting 'struct
net' using the net_generic() framework.
If the nfs_fcache_disposal were linked from the nfsd_net, there would be
no need for the list, no need to record the ->net, and not need for the
code in question here.
The nfsd_fcache_disposal is destroyed (nfsd_file_cache_shutdown_new())
before the nfsd_net is destroyed, so there are no lifetime issues with
keeping the separate list.

So I think this patch is not the best fix for the problem highlighted by
the warning...  it's not wrong though.

NeilBrown
