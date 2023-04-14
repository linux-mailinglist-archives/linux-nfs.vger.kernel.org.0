Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707256E2A61
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 21:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjDNTBt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 15:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNTBs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 15:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D54900B
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 12:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF1C164A01
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 19:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04272C433EF;
        Fri, 14 Apr 2023 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681498906;
        bh=kMr4a+m5n4USTjTsatU2JxzAs08Y8CfeNpLy+UU70hk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lcOBveiP8YwrP4JclIYI9NCVuhd4oyYreMUjeqDAua2jL6r0OkgqAQoeUG7aSWALz
         Mo9KWdXJhpto+f8Mpueui2qMrtW5jeeaPubr9YO0J4IlpENadVqM5qN02TcuXZawJj
         w20yN/pnMx+SOea72JeudD+Jwjr3l1NpSCGgT4C6o5k3lC3nYrzA9MN7wg7nEVUQLy
         Z90Ms4de+pn93D6nlIwLyuTKw5q1eXoRYstygrILFmfoKQpbznSKcy1vyXtD75fXnf
         54qny4Od4ItSkKdxEdNTp5UviTDEvfpEu6mN4u4FycE6LSE54Mdjquxo4zA4P/AYaf
         rvsOcq/ArXKqQ==
Message-ID: <3353149c8e7965e44807f2a7ed5055df51d6c856.camel@kernel.org>
Subject: Re: [PATCH 3/6] nfsd: simplify the delayed disposal list code
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 14 Apr 2023 15:01:44 -0400
In-Reply-To: <7810C14C-DC16-48DF-8A14-1A1E7B9A2CD8@oracle.com>
References: <20230118173139.71846-1-jlayton@kernel.org>
         <20230118173139.71846-4-jlayton@kernel.org>
         <7810C14C-DC16-48DF-8A14-1A1E7B9A2CD8@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-04-14 at 18:20 +0000, Chuck Lever III wrote:
> > On Jan 18, 2023, at 12:31 PM, Jeff Layton <jlayton@kernel.org>
> > wrote:
> >=20
> > When queueing a dispose list to the appropriate "freeme" lists, it
> > pointlessly queues the objects one at a time to an intermediate
> > list.
> >=20
> > Remove a few helpers and just open code a list_move to make it more
> > clear and efficient. Better document the resulting functions with
> > kerneldoc comments.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 63 +++++++++++++++----------------------------
> > --
> > 1 file changed, 21 insertions(+), 42 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 58ac93e7e680..a2bc4bd90b9a 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -513,49 +513,25 @@ nfsd_file_dispose_list(struct list_head
> > *dispose)
> > }
> > }
> >=20
> > -static void
> > -nfsd_file_list_remove_disposal(struct list_head *dst,
> > - struct nfsd_fcache_disposal *l)
> > -{
> > - spin_lock(&l->lock);
> > - list_splice_init(&l->freeme, dst);
> > - spin_unlock(&l->lock);
> > -}
> > -
> > -static void
> > -nfsd_file_list_add_disposal(struct list_head *files, struct net
> > *net)
> > -{
> > - struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > - struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > -
> > - spin_lock(&l->lock);
> > - list_splice_tail_init(files, &l->freeme);
> > - spin_unlock(&l->lock);
> > - queue_work(nfsd_filecache_wq, &l->work);
> > -}
> > -
> > -static void
> > -nfsd_file_list_add_pernet(struct list_head *dst, struct list_head
> > *src,
> > - struct net *net)
> > -{
> > - struct nfsd_file *nf, *tmp;
> > -
> > - list_for_each_entry_safe(nf, tmp, src, nf_lru) {
> > - if (nf->nf_net =3D=3D net)
> > - list_move_tail(&nf->nf_lru, dst);
> > - }
> > -}
> > -
> > +/**
> > + * nfsd_file_dispose_list_delayed - move list of dead files to
> > net's freeme list
> > + * @dispose: list of nfsd_files to be disposed
> > + *
> > + * Transfers each file to the "freeme" list for its nfsd_net, to
> > eventually
> > + * be disposed of by the per-net garbage collector.
> > + */
> > static void
> > nfsd_file_dispose_list_delayed(struct list_head *dispose)
> > {
> > - LIST_HEAD(list);
> > - struct nfsd_file *nf;
> > -
> > while(!list_empty(dispose)) {
> > - nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> > - nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
> > - nfsd_file_list_add_disposal(&list, nf->nf_net);
> > + struct nfsd_file *nf =3D list_first_entry(dispose,
> > + struct nfsd_file, nf_lru);
> > + struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> > + struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > +
> > + spin_lock(&l->lock);
> > + list_move_tail(&nf->nf_lru, &l->freeme);
> > + spin_unlock(&l->lock);
> > }
> > }
> >=20
> > @@ -765,8 +741,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
> > =A0* nfsd_file_delayed_close - close unused nfsd_files
> > =A0* @work: dummy
> > =A0*
> > - * Walk the LRU list and destroy any entries that have not been
> > used since
> > - * the last scan.
> > + * Scrape the freeme list for this nfsd_net, and then dispose of
> > them
> > + * all.
> > =A0*/
> > static void
> > nfsd_file_delayed_close(struct work_struct *work)
> > @@ -775,7 +751,10 @@ nfsd_file_delayed_close(struct work_struct
> > *work)
> > struct nfsd_fcache_disposal *l =3D container_of(work,
> > struct nfsd_fcache_disposal, work);
> >=20
> > - nfsd_file_list_remove_disposal(&head, l);
> > + spin_lock(&l->lock);
> > + list_splice_init(&l->freeme, &head);
> > + spin_unlock(&l->lock);
> > +
> > nfsd_file_dispose_list(&head);
> > }
>=20
> Hey Jeff -
>=20
> After applying this one, tmpfs exports appear to leak space,
> even after all files and directories are deleted. Eventually
> the filesystem is "full" -- modifying operations return ENOSPC
> but removing files doesn't recover the used space.
>=20
> Can you have a look at this?
>=20

Hrm, ok. Do you have a reproducer?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
