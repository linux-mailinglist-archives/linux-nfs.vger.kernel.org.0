Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF86132DE
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJaJgN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJaJgM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 05:36:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F386353
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 02:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50AA7B810AF
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 09:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E1FC433D6;
        Mon, 31 Oct 2022 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667208969;
        bh=xKsblE1jmzNmmaMj/1tNdyeOXKxxdOAsxRtDmaHgAkM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i8gwTTXdQakPqPnXpBmQm+eBxPvpu4aHAPcqgnFlGGlOfw2HN7Q95BmUMhRQ4xbU8
         MraKPsEpsjqpiIt96y/lkbjPzX3dKtjj1nWdqUyoY4+m67Mqc/A87Q4iEOMa+KOjIT
         JQsLLVCf2s1PhNZq1ot4mfC7qVLFDmZgPSwjPvNLs2SJEUj9SR37llKit6ztEhb7Mx
         xxi8IASqXVRDyDEgCsRHp3FEeSh2yoRmnGmED1uQePsaJFvUg3HDNwEaYtHqMid4Ea
         l8BDCpuVtPpO7qXxGgY4dJ+eXnT0dm+yxZsz2QcfihzGwnHzK4jB5keOYSGdvbmkgw
         Tz/RIys8wgsKQ==
Message-ID: <f6f026dba473f3347024d9cb72bc808a59b8b5d6.camel@kernel.org>
Subject: Re: [PATCH v3 4/4] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Mon, 31 Oct 2022 05:36:07 -0400
In-Reply-To: <90233EDB-0366-4F66-9278-1FFF1AEF1C9B@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
         <20221028185712.79863-5-jlayton@kernel.org>
         <89288CA4-F679-482C-B9D1-68C583D7F5BA@oracle.com>
         <d9079c1a165ed41b9ccc1d1434edc06624073338.camel@kernel.org>
         <90233EDB-0366-4F66-9278-1FFF1AEF1C9B@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 20:57 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 4:30 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-10-28 at 19:50 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> > > > so that we can be ready to close it when the time comes. This shoul=
d
> > > > help minimize delays when freeing objects reaped from the LRU.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > fs/nfsd/filecache.c | 23 +++++++++++++++++++++--
> > > > 1 file changed, 21 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index 47cdc6129a7b..c43b6cff03e2 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -325,6 +325,20 @@ nfsd_file_fsync(struct nfsd_file *nf)
> > > > 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > > > }
> > > >=20
> > > > +static void
> > > > +nfsd_file_flush(struct nfsd_file *nf)
> > > > +{
> > > > +	struct file *file =3D nf->nf_file;
> > > > +	struct address_space *mapping;
> > > > +
> > > > +	if (!file || !(file->f_mode & FMODE_WRITE))
> > > > +		return;
> > > > +
> > > > +	mapping =3D file->f_mapping;
> > > > +	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> > > > +		filemap_flush(mapping);
> > > > +}
> > > > +
> > > > static int
> > > > nfsd_file_check_write_error(struct nfsd_file *nf)
> > > > {
> > > > @@ -484,9 +498,14 @@ nfsd_file_put(struct nfsd_file *nf)
> > > >=20
> > > > 		/* Try to add it to the LRU.  If that fails, decrement. */
> > > > 		if (nfsd_file_lru_add(nf)) {
> > > > -			/* If it's still hashed, we're done */
> > > > -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > > > +			/*
> > > > +			 * If it's still hashed, we can just return now,
> > > > +			 * after kicking off SYNC_NONE writeback.
> > > > +			 */
> > > > +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > > > +				nfsd_file_flush(nf);
> > > > 				return;
> > > > +			}
> > >=20
> > > nfsd_write() calls nfsd_file_put() after every nfsd_vfs_write(). In s=
ome
> > > cases, this new logic adds an async flush after every UNSTABLE NFSv3 =
WRITE.
> > >=20
> > > I'll need to see performance measurements demonstrating no negative
> > > impact on throughput or latency of NFSv3 WRITEs with large payloads.
> > >=20
> > >=20
> >=20
> > In your earlier mail, you mentioned that you wanted the writeback work
> > to be done in the context of nfsd threads. nfsd_file_put is how nfsd
> > threads put their references so this seems like the right place to do
> > it.
> >=20
> > If you're concerned about calling filemap_flush too often because we
> > have an entry that's cycling onto and off of the LRU, then another
> > (maybe better) idea might be to kick off writeback when we clear the
> > REFERENCED flag.
>=20
> I think we are doing just about that today by flushing in nfsd_file_put
> right when the REFERENCED bit is set. :-)
>=20
> But yes: that is essentially it. nfsd is a good place to do the flush,
> but we don't want to flush too often, because that will be noticeable.
>=20
>=20
> > That would need to be done in the gc thread context, however.
>=20
> Apparently it is already doing this via filp_close(), though it's
> not clear how often that call needs to wait for I/O. You could
> schedule a worker to complete the tear down if the open file has
> dirty pages.
>=20

Most filesystems do not flush data on close(). NFS is an exception here
due to CTO.

> To catch errors that might occur when the client is delaying its
> COMMITs for a long while, maybe don't evict nfsd_files that have
> dirty pages...?
>=20

We could do that, I suppose, but then I'd start worrying about memory
pressure. When we have dirty data, it eventually has to be written out.
Are we really helping performance by gaming which thread kicks off
writeback? I'm skeptical.

>=20
> > > > 			/*
> > > > 			 * We're racing with unhashing, so try to remove it from
> > > > --=20
> > > > 2.37.3
> > > >=20
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> > >=20
> > >=20
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
