Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC970E836
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 23:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjEWV5g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjEWV5g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 17:57:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499E83;
        Tue, 23 May 2023 14:57:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2DDF1FD79;
        Tue, 23 May 2023 21:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684879053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nItumo/R75SjxUTXtdEgQf/IfdX5biUd4LbLAPiFOlU=;
        b=E0JoJBMUYzlRQO4jdFFEotz5psZfFEBWkMs1uDQNHlPtwO+lUawxV5duaW79ARiiNansLs
        vnX5sf83t5DB/UWAKaYRaCstFb+X+kBk5f/J3kmCFjCcWy0/6cLq6EoQIyF4byEhaMCiL/
        jXIUJvx+CROVliL5+qLcRhaEaB7LrlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684879053;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nItumo/R75SjxUTXtdEgQf/IfdX5biUd4LbLAPiFOlU=;
        b=Uc+JFBFtux4luCT+/81DsEqhg2/Gxis+Qyazkmsu1a99644X6OSZyUG9bMbQWJiYsk1mnH
        F+SIW331Jo5NYWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 201C313A10;
        Tue, 23 May 2023 21:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /as7Mco2bWSlEAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 May 2023 21:57:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Zhi Li" <yieli@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling notify_change
In-reply-to: <d07a0957040ebc3b5689f524e9d3c04cd166c42b.camel@kernel.org>
References: <20230517162645.254512-1-jlayton@kernel.org>,
 <168472353748.5298.2381558773846767023@noble.neil.brown.name>,
 <d07a0957040ebc3b5689f524e9d3c04cd166c42b.camel@kernel.org>
Date:   Wed, 24 May 2023 07:57:08 +1000
Message-id: <168487902833.21808.11785299927622002491@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 23 May 2023, Jeff Layton wrote:
> On Mon, 2023-05-22 at 12:45 +1000, NeilBrown wrote:
> > On Thu, 18 May 2023, Jeff Layton wrote:
> > > notify_change can modify the iattr structure. In particular it can can
> > > end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
> > > BUG() if the same iattr is passed to notify_change more than once.
> > >=20
> > > Make a copy of the struct iattr before calling notify_change.
> > >=20
> > > Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NF=
S4ERR_DELAY
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
> > > Reported-by: Zhi Li <yieli@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/vfs.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index c4ef24c5ffd0..ad0c5cd900b1 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> > > =20
> > >  	inode_lock(inode);
> > >  	for (retries =3D 1;;) {
> > > -		host_err =3D __nfsd_setattr(dentry, iap);
> > > +		struct iattr attrs =3D *iap;
> > > +
> > > +		host_err =3D __nfsd_setattr(dentry, &attrs);
> >=20
> > I think this needs something to ensure a well meaning by-passer doesn't
> > try to "optimise" it back to the way it was.
> > Maybe make "iap" const?  Or add a comment?  Or both?
> >=20
>=20
> We can't make iap const, as we have to call nfsd_sanitize_attrs on it,
> and that will change things in it. I think we'll probably have to settle
> for a comment. Chuck, can we fold the patch below in to this one?

Thanks :-)

NeilBrown


>=20
> --------------------8<------------------
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2a3687cdf926..817effd63730 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -538,6 +538,11 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fh=
p,
>  	for (retries =3D 1;;) {
>  		struct iattr attrs;
> =20
> +		/*
> +		 * notify_change can alter the iattr in ways that make it
> +		 * unsuitable for submission multiple times. Make a copy
> +		 * for every loop.
> +		 */
>  		attrs =3D *iap;
>  		host_err =3D __nfsd_setattr(dentry, &attrs);
>  		if (host_err !=3D -EAGAIN || !retries--)
>=20
>=20

