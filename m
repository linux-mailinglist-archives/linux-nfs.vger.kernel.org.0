Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D7470746D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 23:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjEQVht (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 May 2023 17:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEQVht (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 May 2023 17:37:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB08212D;
        Wed, 17 May 2023 14:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCED863FAB;
        Wed, 17 May 2023 21:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC01EC4339B;
        Wed, 17 May 2023 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684359467;
        bh=TV4/kxOKU+fbQXJd3ShlPF6dx7uPw2IIBL22yq1npoA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TjHiyK44dVYxLKpCNxpH5kVLtoMxtT066E+b5o0BC9/xGiNlpUUI7WLkIc+isAVI6
         72vAczpNlqlU2a14ztdvz9eENlETai6u8bA3jySFLAw24vlN+WI8JA7sUtR+GUfyD3
         nfplm8p3OG8ysMPFAK+3WhujOn5pM4Tu7pXUyzCTqng0ekdu0sVTsM/HZ2FiYBnCiy
         ZGi3VKJ8usCtjgjhxOGSz6s6o1TogZj+/hyfA58Tknl031VKgqPql2m2EdUpwDD3/Z
         sD/STN7mayzb4Hx5XA/MEaw6HV6qAipADopGHrSFFxqITDVgo/zHFanE/XcmfQV8+V
         UDM8VMEEj1E6Q==
Message-ID: <76f29475b35cfe0102070acfd0299f0aae40d11d.camel@kernel.org>
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Zhi Li <yieli@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 17 May 2023 17:37:45 -0400
In-Reply-To: <D481F0ED-0C54-411F-9A72-8BC5E253AEB7@oracle.com>
References: <20230517162645.254512-1-jlayton@kernel.org>
         <74D303B1-08F8-4CDF-8732-9352FFDEC463@oracle.com>
         <a55a7bfc8be6210dfc7e7721825ac915795a48cf.camel@kernel.org>
         <D481F0ED-0C54-411F-9A72-8BC5E253AEB7@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-05-17 at 19:13 +0000, Chuck Lever III wrote:
>=20
> > On May 17, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Wed, 2023-05-17 at 17:47 +0000, Chuck Lever III wrote:
> > >=20
> > > > On May 17, 2023, at 12:26 PM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > notify_change can modify the iattr structure. In particular it can =
can
> > > > end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causin=
g a
> > > > BUG() if the same iattr is passed to notify_change more than once.
> > > >=20
> > > > Make a copy of the struct iattr before calling notify_change.
> > > >=20
> > > > Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returnin=
g NFS4ERR_DELAY
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
> > > > Reported-by: Zhi Li <yieli@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > fs/nfsd/vfs.c | 4 +++-
> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > index c4ef24c5ffd0..ad0c5cd900b1 100644
> > > > --- a/fs/nfsd/vfs.c
> > > > +++ b/fs/nfsd/vfs.c
> > > > @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> > > >=20
> > > > inode_lock(inode);
> > > > for (retries =3D 1;;) {
> > > > - host_err =3D __nfsd_setattr(dentry, iap);
> > > > + struct iattr attrs =3D *iap;
> > >=20
> > > This construct always makes me queazy. I'm never sure if an
> > > initializer inside a loop is "only once" or "every time". I
> > > fixed a bug like this once.
> > >=20
> > > But if you've tested it and it addresses the BUG, then let's
> > > go with this. I can apply it to nfsd-fixes.
> > >=20
> >=20
> >=20
> > I've done some light testing with this kernel, but this was found by Zh=
i
> > while testing with the lustre racer test, so it involves some raciness.
> > I've never hit this myself.
>=20
> Has Zhi tested this fix?
>=20

Not yet. I just cooked it up this morning. I built a test kernel but
testing it will take some time since it depends on load.

>=20
> > I'm pretty sure though that this has to be initialized every time. The
> > assignment is inside the loop, after all. I'm ok with moving the
> > assignment to a different line if you like though:
> >=20
> > struct iattr attrs;
> >=20
> > attrs =3D *iap;
> > ...
>=20
> Yeah I could do that. I find that easier to read when a loop is
> involved; it's unambiguous then what is going on.
>=20

Your call. I'm fairly certain that the patch does the right thing as-is,
but if you think it makes it more readable, then OK.
--=20
Jeff Layton <jlayton@kernel.org>
