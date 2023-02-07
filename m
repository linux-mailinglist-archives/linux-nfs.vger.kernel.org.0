Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3B68DCB0
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjBGPPT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 10:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjBGPPS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 10:15:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34CD9
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 07:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 410F4B819B7
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 15:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2A1C433D2;
        Tue,  7 Feb 2023 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675782913;
        bh=MD8VcnrnmppgDt9fAZIJPSo8CKOXOIcwhQ0OigJ2K5g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pxi/a9qjZcZ1AGSuVuAim39HxMWRljOgVLQLawp3wMkUk+zsHN+DtPXUP4HAAgtQ4
         KDMn6xfAU0rREPn3eSGlF1B/NyUChriLPR/qfA5j6Z6ibDBCmhc9kaFDBLA7WSpjlQ
         kuvGujim/3lmNj5VxvIS+VU5JtnruOq+KQlcBCgesH+TxPCx3wOW3F3nkU5kaSA4Oa
         D+q1z2qYo/T5iee2O9r1jg1klj3S/UGXEIAwZ+nuvOt3NrKuNRpyj+xi4V0/K/j8N0
         tCuwDxQ3V6qmpYwhAo83gYmB/OSEbNwifJ8Doy38mZS6Bef1Hoi5k2vfg8ZyUR5StJ
         mcnooA2LHQ/UA==
Message-ID: <9137413986ba9c2e83c030513fa9ae3358f30a85.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't fsync nfsd_files on last close
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Pierguido Lambri <plambri@redhat.com>
Date:   Tue, 07 Feb 2023 10:15:12 -0500
In-Reply-To: <90CCAB9B-935F-4450-8AE8-7F3C902A5402@oracle.com>
References: <20230207145030.90123-1-jlayton@kernel.org>
         <90CCAB9B-935F-4450-8AE8-7F3C902A5402@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-07 at 15:01 +0000, Chuck Lever III wrote:
>=20
> > On Feb 7, 2023, at 9:50 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Most of the time, NFSv4 clients issue a COMMIT before the final CLOSE o=
f
> > an open stateid, so with NFSv4, the fsync in the nfsd_file_free path is
> > usually a no-op and doesn't block.
> >=20
> > We have a customer running knfsd over very slow storage (XFS over Ceph
> > RBD). They were using the "async" export option because performance was
> > more important than data integrity for this application. That export
> > option turns NFSv4 COMMIT calls into no-ops. Due to the fsync in this
> > codepath however, their final CLOSE calls would still stall (since a
> > CLOSE effectively became a COMMIT).
> >=20
> > I think this fsync is not strictly necessary. We only use that result t=
o
> > reset the write verifier. Instead of fsync'ing all of the data when we
> > free an nfsd_file, we can just check for writeback errors when one is
> > acquired and when it is freed.
> >=20
> > If the client never comes back, then it'll never see the error anyway
> > and there is no point in resetting it. If an error occurs after the
> > nfsd_file is removed from the cache but before the inode is evicted,
> > then it will reset the write verifier on the next nfsd_file_acquire,
> > (since there will be an unseen error).
> >=20
> > The only exception here is if something else opens and fsyncs the file
> > during that window. Given that local applications work with this
> > limitation today, I don't see that as an issue.
> >=20
> > Reported-and-Tested-by: Pierguido Lambri <plambri@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Seems sensible and clean.
>=20
> I would like to queue this in the filecache topic branch, but
> that means it won't get merged until v6.4 at the earliest. Is
> that OK?
>=20
>=20

Thanks! v6.4 would be a little late. Can we get it in for v6.3?

Exporting with -o async is (unfortunately) quite common. I suspect we're
going to see other bug reports due to this. Waiting out a whole cycle
means wading through a bunch of those (and telling those folks to use
older kernels until we can get it in).


> > ---
> > fs/nfsd/filecache.c | 48 ++++++++++++++-------------------------------
> > fs/nfsd/trace.h     | 31 -----------------------------
> > 2 files changed, 15 insertions(+), 64 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 136e543ae44b..fcd16ffbf9ad 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -233,37 +233,27 @@ nfsd_file_alloc(struct net *net, struct inode *in=
ode, unsigned char need,
> > 	return nf;
> > }
> >=20
> > +/**
> > + * nfsd_file_check_write_error - check for writeback errors on a file
> > + * @nf: nfsd_file to check for writeback errors
> > + *
> > + * Check whether a nfsd_file has an unseen error. Reset the write
> > + * verifier if so.
> > + */
> > static void
> > -nfsd_file_fsync(struct nfsd_file *nf)
> > -{
> > -	struct file *file =3D nf->nf_file;
> > -	int ret;
> > -
> > -	if (!file || !(file->f_mode & FMODE_WRITE))
> > -		return;
> > -	ret =3D vfs_fsync(file, 1);
> > -	trace_nfsd_file_fsync(nf, ret);
> > -	if (ret)
> > -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > -}
> > -
> > -static int
> > nfsd_file_check_write_error(struct nfsd_file *nf)
> > {
> > 	struct file *file =3D nf->nf_file;
> >=20
> > -	if (!file || !(file->f_mode & FMODE_WRITE))
> > -		return 0;
> > -	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err=
));
> > +	if ((file->f_mode & FMODE_WRITE) &&
> > +	    filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err)))
> > +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > }
> >=20
> > static void
> > nfsd_file_hash_remove(struct nfsd_file *nf)
> > {
> > 	trace_nfsd_file_unhash(nf);
> > -
> > -	if (nfsd_file_check_write_error(nf))
> > -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > 	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
> > 			nfsd_file_rhash_params);
> > }
> > @@ -289,22 +279,13 @@ nfsd_file_free(struct nfsd_file *nf)
> > 	this_cpu_add(nfsd_file_total_age, age);
> >=20
> > 	nfsd_file_unhash(nf);
> > -
> > -	/*
> > -	 * We call fsync here in order to catch writeback errors. It's not
> > -	 * strictly required by the protocol, but an nfsd_file could get
> > -	 * evicted from the cache before a COMMIT comes in. If another
> > -	 * task were to open that file in the interim and scrape the error,
> > -	 * then the client may never see it. By calling fsync here, we ensure
> > -	 * that writeback happens before the entry is freed, and that any
> > -	 * errors reported result in the write verifier changing.
> > -	 */
> > -	nfsd_file_fsync(nf);
> > -
> > 	if (nf->nf_mark)
> > 		nfsd_file_mark_put(nf->nf_mark);
> > -	if (nf->nf_file)
> > +
> > +	if (nf->nf_file) {
> > +		nfsd_file_check_write_error(nf);
> > 		filp_close(nf->nf_file, NULL);
> > +	}
> >=20
> > 	/*
> > 	 * If this item is still linked via nf_lru, that's a bug.
> > @@ -1080,6 +1061,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> > out:
> > 	if (status =3D=3D nfs_ok) {
> > 		this_cpu_inc(nfsd_file_acquisitions);
> > +		nfsd_file_check_write_error(nf);
> > 		*pnf =3D nf;
> > 	}
> > 	put_cred(cred);
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 8f9c82d9e075..4183819ea082 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -1202,37 +1202,6 @@ TRACE_EVENT(nfsd_file_close,
> > 	)
> > );
> >=20
> > -TRACE_EVENT(nfsd_file_fsync,
> > -	TP_PROTO(
> > -		const struct nfsd_file *nf,
> > -		int ret
> > -	),
> > -	TP_ARGS(nf, ret),
> > -	TP_STRUCT__entry(
> > -		__field(void *, nf_inode)
> > -		__field(int, nf_ref)
> > -		__field(int, ret)
> > -		__field(unsigned long, nf_flags)
> > -		__field(unsigned char, nf_may)
> > -		__field(struct file *, nf_file)
> > -	),
> > -	TP_fast_assign(
> > -		__entry->nf_inode =3D nf->nf_inode;
> > -		__entry->nf_ref =3D refcount_read(&nf->nf_ref);
> > -		__entry->ret =3D ret;
> > -		__entry->nf_flags =3D nf->nf_flags;
> > -		__entry->nf_may =3D nf->nf_may;
> > -		__entry->nf_file =3D nf->nf_file;
> > -	),
> > -	TP_printk("inode=3D%p ref=3D%d flags=3D%s may=3D%s nf_file=3D%p ret=
=3D%d",
> > -		__entry->nf_inode,
> > -		__entry->nf_ref,
> > -		show_nf_flags(__entry->nf_flags),
> > -		show_nfsd_may_flags(__entry->nf_may),
> > -		__entry->nf_file, __entry->ret
> > -	)
> > -);
> > -
> > #include "cache.h"
> >=20
> > TRACE_DEFINE_ENUM(RC_DROPIT);
> > --=20
> > 2.39.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
