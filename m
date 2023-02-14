Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68F46967C4
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 16:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjBNPQg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 10:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBNPQf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 10:16:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3931A4AF
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 07:16:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F65FB81DDC
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 15:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735A9C433D2;
        Tue, 14 Feb 2023 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676387788;
        bh=RLckFPuIZK4vAV1z8WJi4N8GmiFMqq79ZLoo687y9Iw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=noudX3p7cewxLMxllMhgivoZgxQ64zMIAI6xtf9UJriO7chy0Vu4R3CkX0PoS2ebc
         sWpm3foiM6a/uKQsatAwfnsRq1Jr/zRIsVc1qiFMNbdmaWA2OQ++x0nyheFtpfDtin
         j2tDkEnL1yCX0oUJWvfQEc0DVXNWBjWMSauApFg1iMXAYQOaf7+z4PjmNUZoofGyHX
         X4IsnIWpcZdO+IrmPz/ihBEve0XFSE6bMV2h64CYPE+u2dmO8xz+d0l73D+BY9yu+P
         /DeNE3UEZuIgBd/tVA7Om3rHT+vdHC5EKCVDFXI+Z+IYTjI2Hxtn69EQbgh4ZWc+67
         JJKDDiEkadosg==
Message-ID: <e8f5b07200f197a2972beb0628df55ec92b627b5.camel@kernel.org>
Subject: Re: [PATCH] nfsd: allow reaping files that are still under writeback
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 14 Feb 2023 10:16:27 -0500
In-Reply-To: <d7eea987852cffb5fc719310ed01f771390d60d2.camel@kernel.org>
References: <20230213202346.291008-1-jlayton@kernel.org>
         <E1A055FD-45C3-47A0-A6CB-296C84985D43@oracle.com>
         <d7eea987852cffb5fc719310ed01f771390d60d2.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-14 at 10:00 -0500, Trond Myklebust wrote:
> On Tue, 2023-02-14 at 14:48 +0000, Chuck Lever III wrote:
> >=20
> >=20
> > > On Feb 13, 2023, at 3:23 PM, Jeff Layton <jlayton@kernel.org>
> > > wrote:
> > >=20
> > > There's no reason to delay reaping an nfsd_file just because its
> > > underlying inode is still under writeback. nfsd just relies on
> > > client
> > > activity or the local flusher threads to do writeback.
> > >=20
> > > Holding the file open does nothing to facilitate that, nor does it
> > > help
> > > with tracking errors. Just allow it to close and let the kernel do
> > > writeback as it normally would.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > Thanks! Applied to topic-filecache-cleanups.
> >=20
> >=20
> > > ---
> > > fs/nfsd/filecache.c | 22 ----------------------
> > > 1 file changed, 22 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index e6617431df7c..3b9a10378c83 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -296,19 +296,6 @@ nfsd_file_free(struct nfsd_file *nf)
> > > =A0=A0=A0=A0=A0=A0=A0=A0call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > > }
> > >=20
> > > -static bool
> > > -nfsd_file_check_writeback(struct nfsd_file *nf)
> > > -{
> > > -=A0=A0=A0=A0=A0=A0=A0struct file *file =3D nf->nf_file;
> > > -=A0=A0=A0=A0=A0=A0=A0struct address_space *mapping;
> > > -
> > > -=A0=A0=A0=A0=A0=A0=A0if (!file || !(file->f_mode & FMODE_WRITE))
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return false;
> > > -=A0=A0=A0=A0=A0=A0=A0mapping =3D file->f_mapping;
> > > -=A0=A0=A0=A0=A0=A0=A0return mapping_tagged(mapping, PAGECACHE_TAG_DI=
RTY) ||
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mapping_tagged(mapping,=
 PAGECACHE_TAG_WRITEBACK);
> > > -}
> > > -
> > > static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > > {
> > > =A0=A0=A0=A0=A0=A0=A0=A0set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > @@ -438,15 +425,6 @@ nfsd_file_lru_cb(struct list_head *item,
> > > struct list_lru_one *lru,
> > > =A0=A0=A0=A0=A0=A0=A0=A0/* We should only be dealing with GC entries =
here */
> > > =A0=A0=A0=A0=A0=A0=A0=A0WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_=
flags));
> > >=20
> > > -=A0=A0=A0=A0=A0=A0=A0/*
> > > -=A0=A0=A0=A0=A0=A0=A0 * Don't throw out files that are still undergo=
ing I/O or
> > > -=A0=A0=A0=A0=A0=A0=A0 * that have uncleared errors pending.
> > > -=A0=A0=A0=A0=A0=A0=A0 */
> > > -=A0=A0=A0=A0=A0=A0=A0if (nfsd_file_check_writeback(nf)) {
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0trace_nfsd_file_gc_writ=
eback(nf);
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return LRU_SKIP;
> > > -=A0=A0=A0=A0=A0=A0=A0}
> > > -
> > > =A0=A0=A0=A0=A0=A0=A0=A0/* If it was recently added to the list, skip=
 it */
> > > =A0=A0=A0=A0=A0=A0=A0=A0if (test_and_clear_bit(NFSD_FILE_REFERENCED, =
&nf-
> > > > nf_flags)) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0trace_nfsd_file_gc_re=
ferenced(nf);
> > > --=20
> > > 2.39.1
> > >=20
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
> >=20
>=20
> Wait... There is a good reason for wanting to do this in the case of
> NFS re-exports, since close() is a very expensive operation if the file
> has dirty data.
>=20

Fair enough. What if we added a new EXPORT_OP_FLUSH_ON_CLOSE flag that
filesystems could set in the export_operations? Then we could make this
behavior conditional on that being set?
--=20
Jeff Layton <jlayton@kernel.org>
