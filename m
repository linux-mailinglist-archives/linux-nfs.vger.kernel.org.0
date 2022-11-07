Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D560361FDD0
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiKGSqH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 13:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiKGSqH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 13:46:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F92613A
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 10:46:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52DD2B81614
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 18:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F54C433D7;
        Mon,  7 Nov 2022 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667846759;
        bh=9jRjcWUZ5tMAqCAzrCZ+AbHDtkvI5l4eo//A/nZi3G0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EGxHRiC9Jp7ZbUli+te5Gfwq2l2Hj5lvt7NHT+igWysbB8Q4VLUEwo2rGrh9eYrPq
         OFs7jOA5M98uyyScXmxlaaEY45wwhg5TnMp7elmkhg4CjjQhOaDeiCUEPL1MCuAixZ
         GqJ6nvi6NdwyVSf4n18/RAcIOiXcmrqI48M9VhwrHBcxYJmUo0IJBEWcE6BW0k+Mjg
         Gvfc3fkyXiMUCCe/DOzENeP16/sZd+mqNvHeCS+YOsGHWd1i2F9egjXnM+APMaHF5E
         /twkhAotsl/GaEdHBjWRY9aGQXqvwadvTBnScTR3dbDBX2CtiyJkMdEm0/SML5Voyq
         Jrpfd0mU+88yw==
Message-ID: <0dffb0a8508511229880545245948c3f512a374a.camel@kernel.org>
Subject: Re: [PATCH] nfsd: remove dedicated nfsd_filecache_wq
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 07 Nov 2022 13:45:58 -0500
In-Reply-To: <CDEA2A36-B0EC-426B-8489-2BB524C6266A@oracle.com>
References: <20221107171056.64564-1-jlayton@kernel.org>
         <61876142ab0115a7bf39556e5caebfd1a635f945.camel@kernel.org>
         <CDEA2A36-B0EC-426B-8489-2BB524C6266A@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-11-07 at 18:16 +0000, Chuck Lever III wrote:
>=20
> > On Nov 7, 2022, at 12:28 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2022-11-07 at 12:10 -0500, Jeff Layton wrote:
> > > There's no clear benefit to allocating our own over just using the
> > > system_wq. This also fixes a minor bug in nfsd_file_cache_init(). In =
the
> > > current code, if allocating the wq fails, then the nfsd_file_rhash_tb=
l
> > > is leaked.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > fs/nfsd/filecache.c | 13 +------------
> > > 1 file changed, 1 insertion(+), 12 deletions(-)
> > >=20
> >=20
> > I'm playing with this and it seems to be ok, but reading further into
> > the workqueue doc, it says this:
> >=20
> > * A wq serves as a domain for forward progress guarantee
> >  (``WQ_MEM_RECLAIM``, flush and work item attributes.  Work items
> >  which are not involved in memory reclaim and don't need to be
> >  flushed as a part of a group of work items, and don't require any
> >  special attribute, can use one of the system wq.  There is no
> >  difference in execution characteristics between using a dedicated wq
> >  and a system wq.
> >=20
> > These jobs are involved in mem reclaim however, due to the shrinker.
> > OTOH, the existing nfsd_filecache_wq doesn't set WQ_MEM_RECLAIM.
> >=20
> > In any case, we aren't flushing the work or anything as part of mem
> > reclaim, so maybe the above bullet point doesn't apply here?
>=20
> In the steady state, deferring writeback seems like the right
> thing to do, and I don't see the need for a special WQ for that
> case -- hence nfsd_file_schedule_laundrette() can use the
> system_wq.
>=20
> That might explain the dual WQ arrangement in the current code.
>=20

True. Looking through the changelog, the dedicated workqueue was added
by Trond in 9542e6a643fc ("nfsd: Containerise filecache laundrette"). I
assume he was concerned about reclaim.

Trond, if we keep the dedicated workqueue for the laundrette, does it
also need WQ_MEM_RECLAIM?


> But I'd feel better if the shrinker skipped files that require
> writeback to avoid a potential deadlock scenario for some
> filesystems.
>=20

It already does this via the nfsd_file_check_writeback call in
nfsd_file_lru_cb.


>=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 1e76b0d3b83a..59e06d68d20c 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -66,8 +66,6 @@ struct nfsd_fcache_disposal {
> > > 	struct list_head freeme;
> > > };
> > >=20
> > > -static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
> > > -
> > > static struct kmem_cache		*nfsd_file_slab;
> > > static struct kmem_cache		*nfsd_file_mark_slab;
> > > static struct list_lru			nfsd_file_lru;
> > > @@ -564,7 +562,7 @@ nfsd_file_list_add_disposal(struct list_head *fil=
es, struct net *net)
> > > 	spin_lock(&l->lock);
> > > 	list_splice_tail_init(files, &l->freeme);
> > > 	spin_unlock(&l->lock);
> > > -	queue_work(nfsd_filecache_wq, &l->work);
> > > +	queue_work(system_wq, &l->work);
> > > }
> > >=20
> > > static void
> > > @@ -855,11 +853,6 @@ nfsd_file_cache_init(void)
> > > 	if (ret)
> > > 		return ret;
> > >=20
> > > -	ret =3D -ENOMEM;
> > > -	nfsd_filecache_wq =3D alloc_workqueue("nfsd_filecache", 0, 0);
> > > -	if (!nfsd_filecache_wq)
> > > -		goto out;
> > > -
> > > 	nfsd_file_slab =3D kmem_cache_create("nfsd_file",
> > > 				sizeof(struct nfsd_file), 0, 0, NULL);
> > > 	if (!nfsd_file_slab) {
> > > @@ -917,8 +910,6 @@ nfsd_file_cache_init(void)
> > > 	nfsd_file_slab =3D NULL;
> > > 	kmem_cache_destroy(nfsd_file_mark_slab);
> > > 	nfsd_file_mark_slab =3D NULL;
> > > -	destroy_workqueue(nfsd_filecache_wq);
> > > -	nfsd_filecache_wq =3D NULL;
> > > 	rhashtable_destroy(&nfsd_file_rhash_tbl);
> > > 	goto out;
> > > }
> > > @@ -1034,8 +1025,6 @@ nfsd_file_cache_shutdown(void)
> > > 	fsnotify_wait_marks_destroyed();
> > > 	kmem_cache_destroy(nfsd_file_mark_slab);
> > > 	nfsd_file_mark_slab =3D NULL;
> > > -	destroy_workqueue(nfsd_filecache_wq);
> > > -	nfsd_filecache_wq =3D NULL;
> > > 	rhashtable_destroy(&nfsd_file_rhash_tbl);
> > >=20
> > > 	for_each_possible_cpu(i) {
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
