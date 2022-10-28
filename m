Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76B611B8C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 22:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ1Uan (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 16:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJ1Uam (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 16:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F7C7171B
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 13:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A6E2629FD
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 20:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A0C433C1;
        Fri, 28 Oct 2022 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666989037;
        bh=w7b2RcXw8f5oAPYu8SmswhbaQmqc5jrzg7vawoLgYaQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rOkTP1cgMuIxYPPOo6K3mSn7rkHqha6si3My3MUmnSDWnKy+gyRf0Xgv7zpmmnRHo
         rzMnsI9QX0dEHGtZbi6vc+HinJrCRboXLrDHg3+lZM/4ji7mchpue7D51oX5/61bjk
         S+kdcoWZrpGNGYpS5v0v58tXufPKdbBZKkVJrhi8UijjyF2sGrrj/SiyZBY8DAyyOg
         Xl1g1H2mK+DeX+K2BnO9P57MjL928X3TM7+LUOMueG50zBlQoe8Cea+d2IBsegGBkP
         deTG2gYV8HhjcW/f/Re/0ZJsvPICy280rUQaNoMAOLpcqI0WJQ7Bnz5W3OUjPOhkHW
         tqKOUSQ9mQpvw==
Message-ID: <d9079c1a165ed41b9ccc1d1434edc06624073338.camel@kernel.org>
Subject: Re: [PATCH v3 4/4] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Fri, 28 Oct 2022 16:30:35 -0400
In-Reply-To: <89288CA4-F679-482C-B9D1-68C583D7F5BA@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
         <20221028185712.79863-5-jlayton@kernel.org>
         <89288CA4-F679-482C-B9D1-68C583D7F5BA@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 19:50 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> > so that we can be ready to close it when the time comes. This should
> > help minimize delays when freeing objects reaped from the LRU.
> >=20
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
>=20
> nfsd_write() calls nfsd_file_put() after every nfsd_vfs_write(). In some
> cases, this new logic adds an async flush after every UNSTABLE NFSv3 WRIT=
E.
>=20
> I'll need to see performance measurements demonstrating no negative
> impact on throughput or latency of NFSv3 WRITEs with large payloads.
>=20
>=20

In your earlier mail, you mentioned that you wanted the writeback work
to be done in the context of nfsd threads. nfsd_file_put is how nfsd
threads put their references so this seems like the right place to do
it.

If you're concerned about calling filemap_flush too often because we
have an entry that's cycling onto and off of the LRU, then another
(maybe better) idea might be to kick off writeback when we clear the
REFERENCED flag. That would need to be done in the gc thread context,=20
however.

> > 			/*
> > 			 * We're racing with unhashing, so try to remove it from
> > --=20
> > 2.37.3
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
