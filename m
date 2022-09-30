Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB775F12C2
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiI3TfT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 15:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiI3Tez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 15:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FCF11FD0F
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 12:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D33F46248C
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 19:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7A3C433D7;
        Fri, 30 Sep 2022 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664566393;
        bh=U1Vp0p2cn/do7FmHBsfllOlEbVB9Lz7mnw/LUwp2W30=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sQSf8EmhvchrxcWbMiVQVks9LlfW6NgFSAi4ID6XIuz6WW26v2H9/niF8dC2Ei+e1
         ZTAGzxRUy0DCkFNqGA9rqy7ASOzLpJdTs3sjO/80F0fIN6SFbMGJbl1uwKRF23HnQD
         3V0TalYNeaiPxYySG19OAiTwN+a1RGyuuoPHgoPmlSud9IZlofiYNrS3NVONgB1RqA
         Si3fyMifo4UI7hOA002UCI/J6WzD2pk0ck7u2c509DSVnoQA3CGwxdk9dmhsGrTjiM
         JZZpu+rgsBxWkY34KBNIctVCYaGK5TkluqyeO7GqxNQlg73OiMKKQtWym7WJhMw0gy
         r3DsR93CMEB5Q==
Message-ID: <74afc012abb06df6d0648222cb4c01d22c40942f.camel@kernel.org>
Subject: Re: [PATCH 1/3] nfsd: nfsd_do_file_acquire should hold
 rcu_read_lock while getting refs
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 30 Sep 2022 15:33:11 -0400
In-Reply-To: <9D4FA4C1-2246-4CAE-BB8A-D152603E3A56@oracle.com>
References: <20220930191550.172087-1-jlayton@kernel.org>
         <20220930191550.172087-2-jlayton@kernel.org>
         <9D4FA4C1-2246-4CAE-BB8A-D152603E3A56@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-09-30 at 19:20 +0000, Chuck Lever III wrote:
>=20
> > On Sep 30, 2022, at 3:15 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > nfsd_file is RCU-freed, so it's possible that one could be found that's
> > in the process of being freed and the memory recycled. Ensure we hold
> > the rcu_read_lock while attempting to get a reference on the object.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> IIUC, the rcu_read_lock() is held when nfsd_file_obj_cmpfn() is
> invoked. So, couldn't we just call nfsd_file_get() on @nf in
> there if it returns a match?
>=20
>=20

Adding side effects to the comparison function seems kind of gross. Do
you know for sure that it will only be called once when you do a search?

Also, there are other places where we search the hashtable but don't
take references. We could just make those places put the reference, but
that gets messy.

I think this is cleaner.

> > ---
> > fs/nfsd/filecache.c | 9 ++++++++-
> > 1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index d5c57360b418..6237715bd23e 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1077,10 +1077,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> >=20
> > retry:
> > 	/* Avoid allocation if the item is already in cache */
> > +	rcu_read_lock();
> > 	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> > 				    nfsd_file_rhash_params);
> > 	if (nf)
> > 		nf =3D nfsd_file_get(nf);
> > +	rcu_read_unlock();
> > 	if (nf)
> > 		goto wait_for_construction;
> >=20
> > @@ -1090,16 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > 		goto out_status;
> > 	}
> >=20
> > +	rcu_read_lock();
> > 	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> > 					      &key, &new->nf_rhash,
> > 					      nfsd_file_rhash_params);
> > 	if (!nf) {
> > +		rcu_read_unlock();
> > 		nf =3D new;
> > 		goto open_file;
> > 	}
> > -	if (IS_ERR(nf))
> > +	if (IS_ERR(nf)) {
> > +		rcu_read_unlock();
> > 		goto insert_err;
> > +	}
> > 	nf =3D nfsd_file_get(nf);
> > +	rcu_read_unlock();
> > 	if (nf =3D=3D NULL) {
> > 		nf =3D new;
> > 		goto open_file;
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
