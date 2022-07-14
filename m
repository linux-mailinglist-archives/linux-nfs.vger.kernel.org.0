Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6D5753C9
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiGNRMM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbiGNRML (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 13:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD54BD28
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 10:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4208F60ED8
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D070C3411C;
        Thu, 14 Jul 2022 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657818729;
        bh=/XDrlvqWoivhow/w83LmkkNzWW5MxReQJ6MN2IZq6sY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tP2fqBRHRqRYMu7ThRGaK04aOaPJDw4zMr3nzodhRfpc8Er0lKn5v5kN+CkhTnQDO
         EP/yq7VQ/v4ZH/b3XWBV9x9R/RmvnF8533KWe1YEWyJPdNWXtEh33XLmCPCwa5/XAG
         O8APGTDRcmRrU7GD0VOg9TezYJoUSWiYwPOOsv+W2u2RTCJ4ZPy87MU4yqI+WQGKI8
         goadeNrh68+ChotIygcstmsJOAF8ph59ZdLFLlzqvfBewKOw21GvWL9fHV4nlFbjLv
         g2GbUyjIR7aFQkXS3SYZ23DapTNZdiiWlaQa6+ixNSbr9xlQsMrIITeUTogUsdjRRd
         bgAADsLCh7+xQ==
Message-ID: <476892362c94debad589af79ff7d6766f5ca8c85.camel@kernel.org>
Subject: Re: [RFC PATCH 2/3] nfsd: rework arguments to nfs4_set_delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 14 Jul 2022 13:12:08 -0400
In-Reply-To: <CDD9B96C-3CFC-4BA5-A71C-6C2BFAC2B227@oracle.com>
References: <20220714152819.128276-1-jlayton@kernel.org>
         <20220714152819.128276-3-jlayton@kernel.org>
         <CDD9B96C-3CFC-4BA5-A71C-6C2BFAC2B227@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-07-14 at 16:47 +0000, Chuck Lever III wrote:
>=20
> > On Jul 14, 2022, at 11:28 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > We'll need the nfs4_open to vet the filename. Change nfs4_set_delegatio=
n
> > to take the same arguments are nfs4_open_delegation.
>=20
> ^are^as
>=20
> Nit: Considering that in the next patch you change the synopsis of
> nfs4_open_delegation again but not nfs4_set_delegation, this
> description causes a little whiplash.
>=20
>=20

Yeah, I should have squashed a couple of those together. I _did_ say it
was an RFC. I can resend a cleaned-up version later if you want to take
this in.

> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfs4state.c | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 4f81c0bbd27b..347794028c98 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5260,10 +5260,12 @@ static int nfsd4_check_conflicting_opens(struct=
 nfs4_client *clp,
> > }
> >=20
> > static struct nfs4_delegation *
> > -nfs4_set_delegation(struct nfs4_client *clp,
> > -		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
> > +nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *s=
tp)
> > {
> > 	int status =3D 0;
> > +	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> > +	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> > +	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
> > 	struct nfs4_delegation *dp;
> > 	struct nfsd_file *nf;
> > 	struct file_lock *fl;
> > @@ -5405,7 +5407,7 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp)
> > 		default:
> > 			goto out_no_deleg;
> > 	}
> > -	dp =3D nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_od=
state);
> > +	dp =3D nfs4_set_delegation(open, stp);
> > 	if (IS_ERR(dp))
> > 		goto out_no_deleg;
> >=20
> > --=20
> > 2.36.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
