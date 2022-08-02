Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EFE587F38
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Aug 2022 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiHBPsp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Aug 2022 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiHBPsP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Aug 2022 11:48:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B557521266
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 08:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76403B81990
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 15:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF14BC433C1;
        Tue,  2 Aug 2022 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659455244;
        bh=5itfV/Vi5AESD3RTA9BowcADBOd+18taufcnBre5JCQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UDEz3yRa7j3tKZjHHP/ahHG83r1eLRArTTVEVuCWyKFSG/zbEuMKhRdaCRyXVCSDX
         Ga/0I5WnDdcgwQdOZBRs76MX56hY0jOzndz3of64Z1LmKxqYvmamVV3bmh3LgQjsOu
         W/V+kVIT+izlnSzhIr5BPA5s4KlBSEV2y2wDY01e7Ys6MIP7M8//OAuaxuyeshcoxy
         9bO3LqytjJaPjBnHb4mhk+VKPH91RB4JQh0ghYB3Oh3Ex9VS/3t1MshLY+OsKn0YZ0
         7lN6qFNLGkSJqRn9hwi3t1Azs2Z/fdTG7CCAMwQ19rxtpHksCVCS4WKdf8X9yHwL3m
         +CoWn1UaMRLgg==
Message-ID: <643b9dc1976a24a65cb6160ce3e16c57afa59b84.camel@kernel.org>
Subject: Re: [PATCH v2] lockd: detect and reject lock arguments that overflow
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jan Kasiak <j.kasiak@gmail.com>
Date:   Tue, 02 Aug 2022 11:47:22 -0400
In-Reply-To: <D34C84D6-B1BA-4200-9879-B0AD6CE8AB00@oracle.com>
References: <20220801195726.154229-1-jlayton@kernel.org>
         <D34C84D6-B1BA-4200-9879-B0AD6CE8AB00@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-08-02 at 14:10 +0000, Chuck Lever III wrote:
>=20
> > On Aug 1, 2022, at 3:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > lockd doesn't currently vet the start and length in nlm4 requests like
> > it should, and can end up generating lock requests with arguments that
> > overflow when passed to the filesystem.
> >=20
> > The NLM4 protocol uses unsigned 64-bit arguments for both start and
> > length, whereas struct file_lock tracks the start and end as loff_t
> > values. By the time we get around to calling nlm4svc_retrieve_args,
> > we've lost the information that would allow us to determine if there wa=
s
> > an overflow.
> >=20
> > Start tracking the actual start and len for NLM4 requests in the
> > nlm_lock. In nlm4svc_retrieve_args, vet these values to ensure they
> > won't cause an overflow, and return NLM4_FBIG if they do.
> >=20
> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D392
> > Reported-by: Jan Kasiak <j.kasiak@gmail.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> I've applied this one to my private tree for testing.
> Thanks Jeff!
>=20
>=20

Thank you. We should probably also consider sending this to stable
kernels too. It's at least a DoS vector.

> > ---
> > fs/lockd/svc4proc.c       |  8 ++++++++
> > fs/lockd/xdr4.c           | 19 ++-----------------
> > include/linux/lockd/xdr.h |  2 ++
> > 3 files changed, 12 insertions(+), 17 deletions(-)
> >=20
> > v2: record args as u64s in nlm_lock and check them in
> >    nlm4svc_retrieve_args
> >=20
> > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > index 176b468a61c7..e5adb524a445 100644
> > --- a/fs/lockd/svc4proc.c
> > +++ b/fs/lockd/svc4proc.c
> > @@ -32,6 +32,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct=
 nlm_args *argp,
> > 	if (!nlmsvc_ops)
> > 		return nlm_lck_denied_nolocks;
> >=20
> > +	if (lock->lock_start > OFFSET_MAX ||
> > +	    (lock->lock_len && ((lock->lock_len - 1) > (OFFSET_MAX - lock->lo=
ck_start))))
> > +		return nlm4_fbig;
> > +
> > 	/* Obtain host handle */
> > 	if (!(host =3D nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
> > 	 || (argp->monitor && nsm_monitor(host) < 0))
> > @@ -50,6 +54,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct=
 nlm_args *argp,
> > 		/* Set up the missing parts of the file_lock structure */
> > 		lock->fl.fl_file  =3D file->f_file[mode];
> > 		lock->fl.fl_pid =3D current->tgid;
> > +		lock->fl.fl_start =3D (loff_t)lock->lock_start;
> > +		lock->fl.fl_end =3D lock->lock_len ?
> > +				   (loff_t)(lock->lock_start + lock->lock_len - 1) :
> > +				   OFFSET_MAX;
> > 		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
> > 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> > 		if (!lock->fl.fl_owner) {
> > diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> > index 856267c0864b..712fdfeb8ef0 100644
> > --- a/fs/lockd/xdr4.c
> > +++ b/fs/lockd/xdr4.c
> > @@ -20,13 +20,6 @@
> >=20
> > #include "svcxdr.h"
> >=20
> > -static inline loff_t
> > -s64_to_loff_t(__s64 offset)
> > -{
> > -	return (loff_t)offset;
> > -}
> > -
> > -
> > static inline s64
> > loff_t_to_s64(loff_t offset)
> > {
> > @@ -70,8 +63,6 @@ static bool
> > svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
> > {
> > 	struct file_lock *fl =3D &lock->fl;
> > -	u64 len, start;
> > -	s64 end;
> >=20
> > 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
> > 		return false;
> > @@ -81,20 +72,14 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct n=
lm_lock *lock)
> > 		return false;
> > 	if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
> > 		return false;
> > -	if (xdr_stream_decode_u64(xdr, &start) < 0)
> > +	if (xdr_stream_decode_u64(xdr, &lock->lock_start) < 0)
> > 		return false;
> > -	if (xdr_stream_decode_u64(xdr, &len) < 0)
> > +	if (xdr_stream_decode_u64(xdr, &lock->lock_len) < 0)
> > 		return false;
> >=20
> > 	locks_init_lock(fl);
> > 	fl->fl_flags =3D FL_POSIX;
> > 	fl->fl_type  =3D F_RDLCK;
> > -	end =3D start + len - 1;
> > -	fl->fl_start =3D s64_to_loff_t(start);
> > -	if (len =3D=3D 0 || end < 0)
> > -		fl->fl_end =3D OFFSET_MAX;
> > -	else
> > -		fl->fl_end =3D s64_to_loff_t(end);
> >=20
> > 	return true;
> > }
> > diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
> > index 398f70093cd3..67e4a2c5500b 100644
> > --- a/include/linux/lockd/xdr.h
> > +++ b/include/linux/lockd/xdr.h
> > @@ -41,6 +41,8 @@ struct nlm_lock {
> > 	struct nfs_fh		fh;
> > 	struct xdr_netobj	oh;
> > 	u32			svid;
> > +	u64			lock_start;
> > +	u64			lock_len;
> > 	struct file_lock	fl;
> > };
> >=20
> > --=20
> > 2.37.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
