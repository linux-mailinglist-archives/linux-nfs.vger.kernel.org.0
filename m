Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB2707175
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEQTFu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 May 2023 15:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQTFt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 May 2023 15:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC340CF;
        Wed, 17 May 2023 12:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4063C648FC;
        Wed, 17 May 2023 19:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE76C433EF;
        Wed, 17 May 2023 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684350347;
        bh=PvhIcwG5owKyZJyFcH/6pJobQ3iaAEwWPonfwNpH3ew=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WXIh9IfHWKaFwsll0iIfzbT6bTMEcRHtrA/k6Bn0LQcTWKSEhE5eKWA6KsAIZMfUy
         zsndbrKHQnQI3U94pFQTsW/9RpWk/GVMdxYxHwFFeI73pohmxbQwTnhs3hvE3Iukwc
         HGKEOhoi79giKe3eADixMxoue3SMeDU/Qi3M1OIeyxOLB09KsZ8LlgTVDNMwtjsIBx
         qqLE6UqtcfGSPX/F0sRBNBUYPdCrWGW/Zmm6046p3T9SPqO1KagCcMv92mPNkj+jCm
         mZ+t7zxdYsj/Us4SzT2VCrlXS8V/OeK4g4CMWcLrjSSw6ESFVX+16np9/4HHURvIz6
         HOtDJaZT+me2A==
Message-ID: <a55a7bfc8be6210dfc7e7721825ac915795a48cf.camel@kernel.org>
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Zhi Li <yieli@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 17 May 2023 15:05:45 -0400
In-Reply-To: <74D303B1-08F8-4CDF-8732-9352FFDEC463@oracle.com>
References: <20230517162645.254512-1-jlayton@kernel.org>
         <74D303B1-08F8-4CDF-8732-9352FFDEC463@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-05-17 at 17:47 +0000, Chuck Lever III wrote:
>=20
> > On May 17, 2023, at 12:26 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > notify_change can modify the iattr structure. In particular it can can
> > end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
> > BUG() if the same iattr is passed to notify_change more than once.
> >=20
> > Make a copy of the struct iattr before calling notify_change.
> >=20
> > Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NF=
S4ERR_DELAY
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
> > Reported-by: Zhi Li <yieli@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/vfs.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index c4ef24c5ffd0..ad0c5cd900b1 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> >=20
> > inode_lock(inode);
> > for (retries =3D 1;;) {
> > - host_err =3D __nfsd_setattr(dentry, iap);
> > + struct iattr attrs =3D *iap;
>=20
> This construct always makes me queazy. I'm never sure if an
> initializer inside a loop is "only once" or "every time". I
> fixed a bug like this once.
>=20
> But if you've tested it and it addresses the BUG, then let's
> go with this. I can apply it to nfsd-fixes.
>=20


I've done some light testing with this kernel, but this was found by Zhi
while testing with the lustre racer test, so it involves some raciness.
I've never hit this myself.

I'm pretty sure though that this has to be initialized every time. The
assignment is inside the loop, after all. I'm ok with moving the
assignment to a different line if you like though:

	struct iattr attrs;

	attrs =3D *iap;
	...

> > +
> > + host_err =3D __nfsd_setattr(dentry, &attrs);
> > if (host_err !=3D -EAGAIN || !retries--)
> > break;
> > if (!nfsd_wait_for_delegreturn(rqstp, inode))
> > --=20
> > 2.40.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
