Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6267362D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 11:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjASK5E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 05:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjASK4n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 05:56:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE371798
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 02:56:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B920461AC8
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 10:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA15DC433D2;
        Thu, 19 Jan 2023 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674125799;
        bh=/clkFB8QSk19CyLmez/J3GCkM9GEjdS2q+Kx/cuwZ9E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OxKDh+jDjnyig+kAxKDC7F8vTwY6RaC1VlYTzR9hMChfF9uHYugzYN0SwgjFxUAFI
         BvOoMIMEIVqfSjhNOLHQ33Svh5o5/JXc1CJh2nLJMun76ml/yGJLjO32XOcGIIQRj2
         pF2mTD2KbxR0ai/9l4L1U4/z/54/bm9A1ZNtUN19TcIYIl3+d8EUGL/H5RHnjIavux
         7Ek5HIeBk45+OCQ6j3jJQNihNL/jj2b+HT5DaB8NkKNtB5IBQ7ErCJrRennpVdkf8N
         fsoWhqh3KzrKsgFakqZt7olJQyopgDE6InOh9m86cO7dCV1X6mXzMdjfM7OkwSv+t1
         eVkxje43i0IuA==
Message-ID: <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks
 in COPY codepath
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, aglo@umich.edu
Date:   Thu, 19 Jan 2023 05:56:37 -0500
In-Reply-To: <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
         <20230117193831.75201-3-jlayton@kernel.org>
         <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
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

On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
> On 1/17/23 11:38 AM, Jeff Layton wrote:
> > There are two different flavors of the nfsd4_copy struct. One is
> > embedded in the compound and is used directly in synchronous copies. Th=
e
> > other is dynamically allocated, refcounted and tracked in the client
> > struture. For the embedded one, the cleanup just involves releasing any
> > nfsd_files held on its behalf. For the async one, the cleanup is a bit
> > more involved, and we need to dequeue it from lists, unhash it, etc.
> >=20
> > There is at least one potential refcount leak in this code now. If the
> > kthread_create call fails, then both the src and dst nfsd_files in the
> > original nfsd4_copy object are leaked.
> >=20
> > The cleanup in this codepath is also sort of weird. In the async copy
> > case, we'll have up to four nfsd_file references (src and dst for both
> > flavors of copy structure). They are both put at the end of
> > nfsd4_do_async_copy, even though the ones held on behalf of the embedde=
d
> > one outlive that structure.
> >=20
> > Change it so that we always clean up the nfsd_file refs held by the
> > embedded copy structure before nfsd4_copy returns. Rework
> > cleanup_async_copy to handle both inter and intra copies. Eliminate
> > nfsd4_cleanup_intra_ssc since it now becomes a no-op.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> >   1 file changed, 10 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 37a9cc8ae7ae..62b9d6c1b18b 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_i=
tem *nsui, struct file *filp,
> >   	long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> >  =20
> >   	nfs42_ssc_close(filp);
> > -	nfsd_file_put(dst);
>=20
> I think we still need this, in addition to release_copy_files called
> from cleanup_async_copy. For async inter-copy, there are 2 reference
> count added to the destination file, one from nfsd4_setup_inter_ssc
> and the other one from dup_copy_fields. The above nfsd_file_put is for
> the count added by dup_copy_fields.
>=20

With this patch, the references held by the original copy structure are
put by the call to release_copy_files at the end of nfsd4_copy. That
means that the kthread task is only responsible for putting the
references held by the (kmalloc'ed) async_copy structure. So, I think
this gets the nfsd_file refcounting right.


> >   	fput(filp);
> >  =20
> >   	spin_lock(&nn->nfsd_ssc_lock);
> > @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
> >   				 &copy->nf_dst);
> >   }
> >  =20
> > -static void
> > -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
> > -{
> > -	nfsd_file_put(src);
> > -	nfsd_file_put(dst);
> > -}
> > -
> >   static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
> >   {
> >   	struct nfsd4_cb_offload *cbo =3D
> > @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *=
src, struct nfsd4_copy *dst)
> >   	dst->ss_nsui =3D src->ss_nsui;
> >   }
> >  =20
> > +static void release_copy_files(struct nfsd4_copy *copy)
> > +{
> > +	if (copy->nf_src)
> > +		nfsd_file_put(copy->nf_src);
> > +	if (copy->nf_dst)
> > +		nfsd_file_put(copy->nf_dst);
> > +}
> > +
> >   static void cleanup_async_copy(struct nfsd4_copy *copy)
> >   {
> >   	nfs4_free_copy_state(copy);
> > -	nfsd_file_put(copy->nf_dst);
> > -	if (!nfsd4_ssc_is_inter(copy))
> > -		nfsd_file_put(copy->nf_src);
> > +	release_copy_files(copy);
> >   	spin_lock(&copy->cp_clp->async_lock);
> >   	list_del(&copy->copies);
> >   	spin_unlock(&copy->cp_clp->async_lock);
> > @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
> >   	} else {
> >   		nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >   				       copy->nf_dst->nf_file, false);
> > -		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> >   	}
> >  =20
> >   do_callback:
> > @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >   	} else {
> >   		status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >   				       copy->nf_dst->nf_file, true);
> > -		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> >   	}
> >   out:
> > +	release_copy_files(copy);
> >   	return status;
> >   out_err:
>=20
> This is unrelated to the reference count issue.
>=20
> Here if this is an inter-copy then we need to decrement the reference
> count of the nfsd4_ssc_umount_item so that the vfsmount can be unmounted
> later.
>=20


Oh, I think I see what you mean. Maybe something like the (untested)
patch below on top of the original patch would fix that?

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c9057462b973..7475c593553c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item=
 *nsui, struct file *filp,
        struct nfsd_net *nn =3D net_generic(dst->nf_net, nfsd_net_id);
        long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout);
=20
-       nfs42_ssc_close(filp);
-       fput(filp);
+       if (filp) {
+               nfs42_ssc_close(filp);
+               fput(filp);
+       }
=20
        spin_lock(&nn->nfsd_ssc_lo
        list_del(&nsui->nsui_list);
@@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
        release_copy_files(copy);
        return status;
 out_err:
-       if (async_copy)
+       if (async_copy) {
                cleanup_async_copy(async_copy);
+               if (nfsd4_ssc_is_inter(async_copy))
+                       nfsd4_cleanup_inter_ssc(copy->ss_nsui, NULL,
+                                               copy->nf_dst);
+
+       }
        status =3D nfserrno(-ENOMEM);
        /*
         * source's vfsmount of inter-copy will be unmounted

--=20
Jeff Layton <jlayton@kernel.org>
