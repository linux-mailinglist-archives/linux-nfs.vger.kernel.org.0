Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3014067A3AA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjAXUOd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 15:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAXUOc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 15:14:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF2483EE
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 12:14:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0330B81628
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 20:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3264FC433EF;
        Tue, 24 Jan 2023 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674591268;
        bh=PjbXLkstaJVPKT+gv9/Ojh12y/EYHFbqGcsAvnU4ut4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NuuFJ7/ABogFzBnlkeDlWHY8XX9jfXmw6QG0uLXEGBsfX5ucrZOlc5sJMbsVMu3iE
         HbaBIXTB5IBnWSRbbGm4gLe+mLGMoCzwJ4PZgSX126UOwqNOrxaZ709vfMr6V8ivI6
         CH4XYrM2S9ml7U/GLFS30ZZaYd39Ge0AU4Exun+OdZsC0sgR1ncyHL9PZ4OCSHK4HV
         a6ePk5DNnpbg6sUd+237301YML2P+GQGtcYOb+18arRNORf8ZwO2f9cdO+7NlKK1aW
         iwqZmu0VWYmI+QR7bBxwZtGgZhKmLd0Uc41QTuZqL+TLPzEUjz6Y5h4c1ymRtLWOFi
         z4Ers0UDwcSJA==
Message-ID: <44ed909d5662ca3d2399f8bba05481e17f2c69ae.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix problems with cleanup on errors in
 nfsd4_copy
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Date:   Tue, 24 Jan 2023 15:14:26 -0500
In-Reply-To: <67b6d713-cd2e-252e-f702-7be722dcfee4@oracle.com>
References: <1674538340-12882-1-git-send-email-dai.ngo@oracle.com>
         <a6a220ae0645601eefc0d52ab852ebe37d6dff1c.camel@kernel.org>
         <67b6d713-cd2e-252e-f702-7be722dcfee4@oracle.com>
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

On Tue, 2023-01-24 at 12:10 -0800, dai.ngo@oracle.com wrote:
> On 1/24/23 3:45 AM, Jeff Layton wrote:
> > On Mon, 2023-01-23 at 21:32 -0800, Dai Ngo wrote:
> > > When nfsd4_copy fails to allocate memory for async_copy->cp_src, or
> > > nfs4_init_copy_state fails, it calls cleanup_async_copy to do the
> > > cleanup for the async_copy which causes page fault since async_copy
> > > is not yet initialized.
> > >=20
> > > This patche sets async_copy to NULL to skip cleanup_async_copy
> > > if async_copy is not yet initialized.
> > >=20
> > > Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> > > Fixes: 87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4proc.c | 13 ++++++++++---
> > >   1 file changed, 10 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 3b73e4d342bf..b4e7e18e1761 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -1688,7 +1688,8 @@ static void cleanup_async_copy(struct nfsd4_cop=
y *copy)
> > >   	if (!nfsd4_ssc_is_inter(copy))
> > >   		nfsd_file_put(copy->nf_src);
> > >   	spin_lock(&copy->cp_clp->async_lock);
> > > -	list_del(&copy->copies);
> > > +	if (!list_empty(&copy->copies))
> > > +		list_del(&copy->copies);
> > >   	spin_unlock(&copy->cp_clp->async_lock);
> > >   	nfs4_put_copy(copy);
> > >   }
> > > @@ -1789,9 +1790,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> > >   			goto out_err;
> > >   		async_copy->cp_src =3D kmalloc(sizeof(*async_copy->cp_src), GFP_K=
ERNEL);
> > >   		if (!async_copy->cp_src)
> > > +			goto no_mem;
> > > +		if (!nfs4_init_copy_state(nn, copy)) {
> > > +			kfree(async_copy->cp_src);
> > > +no_mem:
> > > +			kfree(async_copy);
> > > +			async_copy =3D NULL;
> > This seems pretty fragile and the result begins to resemble spaghetti. =
I
> > think it'd be cleaner to initialize the list_head and refcount before
> > you do the allocation of cp_src. Then you can just call
> > cleanup_async_copy no matter where it fails.
>=20
> If we initialize the list_head and refcount before doing the allocation
> of cp_src, we still can not call cleanup_async_copy if the allocation of
> cp_src fails or nfs4_init_copy_state fails since:
>=20
> . dst->cp_stateid is not initialized
> . dst->nf_dst has not been incremented
> . dst->ss_nsui is not set
>=20
> The fields above are initialized by dup_copy_fields and we can not call
> dup_copy_fields if allocation of cp_src fails or nfs4_init_copy_state
> fails.
>=20
>=20

That's what I meant by "fragile". It would be nice if the structure were
properly initialized after allocation, so we didn't have to call *just*
the right teardown procedure. It's slightly more work to do it that way,
but I doubt that would show up in any benchmarks.

I worry that later changes to this code might introduce subtle bugs
because of these fields not being fully initialized. This code is very
complex, and I think some defensive coding is warranted here.


> >=20
> > Bear in mind that these are failure codepaths, so we don't need to
> > optimize for performance here.
> >=20
> >=20
> >=20
> > >   			goto out_err;
> > > -		if (!nfs4_init_copy_state(nn, copy))
> > > -			goto out_err;
> > > +		}
> > > +		INIT_LIST_HEAD(&async_copy->copies);
> > >   		refcount_set(&async_copy->refcount, 1);
> > >   		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
> > >   			sizeof(copy->cp_res.cb_stateid));

--=20
Jeff Layton <jlayton@kernel.org>
