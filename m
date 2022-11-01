Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6113614842
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 12:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiKALNW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiKALNV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 07:13:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D669E
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 04:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3CD1615C2
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 11:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1F9C433D6;
        Tue,  1 Nov 2022 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667301199;
        bh=ymj0Qs9IBZHSdUQbeyiFUX2D0nkU20lz89nRxmYe84w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YLGmkltRA7/DNiYnPHCcQ5MPwBOhOS7HnoQNeRjahDGG5vFFsVKmsH6XwQWHhFPfo
         cDXuyL2XIASIchiWyQKiaXIEuvqGCdGYzKW764JH1/1711BV+Ov1bC1jZLQTFVEVBs
         DhkuOWy35NDlkc06H+gEbZ0XTBF4pioibvEPkZiVcPczQ+Xl1ivLkCYNaP7D4SZPmP
         gT+cmyPxcqsjkGHNCCJLGA3aAtdMsGcv7idfAfSrl3LLbBhnUbeDUnKD05zBf5ZKS+
         wl2W0Bdqm+/TVkvh6kPVQYPno9dWWZxizZVuwNRVpP1DWjQotS1BulJPbwu9FBz+t/
         RZfDvyJegUOjg==
Message-ID: <1f12f3c991bb11006571a36f292e7f5239a47b91.camel@kernel.org>
Subject: Re: [PATCH v4 5/5] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 01 Nov 2022 07:13:17 -0400
In-Reply-To: <3A83C32A-B851-49A5-8C6D-7CFB67B97136@oracle.com>
References: <20221031113742.26480-1-jlayton@kernel.org>
         <20221031113742.26480-6-jlayton@kernel.org>
         <3A83C32A-B851-49A5-8C6D-7CFB67B97136@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-31 at 21:00 +0000, Chuck Lever III wrote:
>=20
> > On Oct 31, 2022, at 7:37 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> > so that we can be ready to close it when the time comes. This should
> > help minimize delays when freeing objects reaped from the LRU.
>=20
> Tested against a btrfs export.
>=20
> So, the current code does indeed do a synchronous fsync when
> garbage collecting files (via nfsd_file_delayed_close()).
> That indicates that it's at least safe to do, and 3/5 isn't
> changing the safety of the filecache by moving the vfs_fsync()
> call into nfsd_file_free(). These calls take between 10 and
> 20 milliseconds each.
>=20
> But I see the filemap_flush() call added here taking dozens of
> milliseconds on my system for large files. This is done before
> the WRITE reply is sent to the client, so it adds significant
> latency to large UNSTABLE WRITEs. In the current code, the
> vfs_fsync() in nfsd_file_put() does not seem to fire except in
> very rare circumstances, so it doesn't seem to have much if any
> impact.
>=20
> My scalability concerns therefore are with code that pre-dates
> this patch series. I can deal with that later in a separate
> series. Do we need to keep this one?
>=20

In the interest of getting the fixes in this series merged, let's just
drop this one for now. We can debate how to best handle this in a
follow-on series.

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 23 +++++++++++++++++++++--
> > 1 file changed, 21 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 47cdc6129a7b..c43b6cff03e2 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -325,6 +325,20 @@ nfsd_file_fsync(struct nfsd_file *nf)
> > 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > }
> >=20
> > +static void
> > +nfsd_file_flush(struct nfsd_file *nf)
> > +{
> > +	struct file *file =3D nf->nf_file;
> > +	struct address_space *mapping;
> > +
> > +	if (!file || !(file->f_mode & FMODE_WRITE))
> > +		return;
> > +
> > +	mapping =3D file->f_mapping;
> > +	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> > +		filemap_flush(mapping);
> > +}
> > +
> > static int
> > nfsd_file_check_write_error(struct nfsd_file *nf)
> > {
> > @@ -484,9 +498,14 @@ nfsd_file_put(struct nfsd_file *nf)
> >=20
> > 		/* Try to add it to the LRU.  If that fails, decrement. */
> > 		if (nfsd_file_lru_add(nf)) {
> > -			/* If it's still hashed, we're done */
> > -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > +			/*
> > +			 * If it's still hashed, we can just return now,
> > +			 * after kicking off SYNC_NONE writeback.
> > +			 */
> > +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > +				nfsd_file_flush(nf);
> > 				return;
> > +			}
> >=20
> > 			/*
> > 			 * We're racing with unhashing, so try to remove it from
> > --=20
> > 2.38.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
