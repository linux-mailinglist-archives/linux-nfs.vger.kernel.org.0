Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228964BDB2
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiLMUCO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 15:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiLMUCN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 15:02:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1169224F31
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 12:02:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA43616ED
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 20:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95689C433EF;
        Tue, 13 Dec 2022 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670961732;
        bh=HML/uqsZV2H5EWiwb7gi1OuwZOf8sJOB6Rrt8RbrAGQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bHVPBc81R57ygAVVBY+1FzThLQoGWjIhKcC2XIFrAHLM0UiY5q+xVqQLHTFnUb7TY
         n0iHrvcYrtM7jFmW+XQfRb/D7BvyhStimDY8M6j5tsPJfRco7oUWGCskMk26y8JeOY
         Psl7q2SM5jAeULxM3bzielOZPa+6QqSOkzDP14EyG2IUZG4KgOKLU3JtTpa4e1D+fi
         Zpk6fhKxYIcuN1h2AwYcEzjuWpLuHarDw2KBxHTgVwVrQoDlAD4qoLybGSV7oMnSI3
         WPDHbHO1aJjsgm21pVmK9wyu8yM8MawTVvdNviyI3nyKukzrWsWSWM0Nmt0zZg4qAu
         ZO14H/dqaRiEQ==
Message-ID: <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount
 upcall timeout
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>
Date:   Tue, 13 Dec 2022 15:02:10 -0500
In-Reply-To: <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
References: <20221213180826.216690-1-jlayton@kernel.org>
         <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
>=20
> > On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > If v4 READDIR operation hits a mountpoint and gets back an error,
> > then it will include that entry in the reply and set RDATTR_ERROR for i=
t
> > to the error.
> >=20
> > That's fine for "normal" exported filesystems, but on the v4root, we
> > need to be more careful to only expose the existence of dentries that
> > lead to exports.
> >=20
> > If the mountd upcall times out while checking to see whether a
> > mountpoint on the v4root is exported, then we have no recourse other
> > than to fail the whole operation.
>=20
> Thank you for chasing this down!
>=20
> Failing the whole READDIR when mountd times out might be a bad idea.
> If the mountd upcall times out every time, the client can't make
> any progress and will continue to emit the failing READDIR request.
>=20
> Would it be better to skip the unresolvable entry instead and let
> the READDIR succeed without that entry?
>=20

Mounting doesn't usually require working READDIR. In that situation, a
readdir() might hang (until the client kills), but a lookup of other
dentries that aren't perpetually stalled should be ok in this situation.

If mountd is that hosed then I think it's unlikely that any progress
will be possible anyway.

>=20
> > Cc: Steve Dickson <steved@redhat.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216777
> > Reported-by:  JianHong Yin <yin-jianhong@163.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfs4xdr.c | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 2b4ae858c89b..984528ce8d68 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3588,6 +3588,7 @@ nfsd4_encode_dirent(void *ccdv, const char *name,=
 int namlen,
> > 	struct readdir_cd *ccd =3D ccdv;
> > 	struct nfsd4_readdir *cd =3D container_of(ccd, struct nfsd4_readdir, c=
ommon);
> > 	struct xdr_stream *xdr =3D cd->xdr;
> > +	struct svc_export *exp =3D cd->rd_fhp->fh_export;
> > 	int start_offset =3D xdr->buf->len;
> > 	int cookie_offset;
> > 	u32 name_and_cookie;
> > @@ -3629,6 +3630,17 @@ nfsd4_encode_dirent(void *ccdv, const char *name=
, int namlen,
> > 	case nfserr_noent:
> > 		xdr_truncate_encode(xdr, start_offset);
> > 		goto skip_entry;
> > +	case nfserr_jukebox:
> > +		/*
> > +		 * The pseudoroot should only display dentries that lead to
> > +		 * exports. If we get EJUKEBOX here, then we can't tell whether
> > +		 * this entry should be included. Just fail the whole READDIR
> > +		 * with NFS4ERR_DELAY in that case, and hope that the situation
> > +		 * will resolve itself by the client's next attempt.
> > +		 */
> > +		if (exp->ex_flags & NFSEXP_V4ROOT)
> > +			goto fail;
> > +		fallthrough;
> > 	default:
> > 		/*
> > 		 * If the client requested the RDATTR_ERROR attribute,
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
