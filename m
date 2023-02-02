Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9B6888ED
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Feb 2023 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjBBVWu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Feb 2023 16:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBBVWu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Feb 2023 16:22:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5C6A331;
        Thu,  2 Feb 2023 13:22:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A598B826B4;
        Thu,  2 Feb 2023 21:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9214C433EF;
        Thu,  2 Feb 2023 21:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675372966;
        bh=DMBzSDwPxDgAMg6vL3XOtJEZFFB+1JnCiCLBzaVACBs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xu8Ky/MyzhuD0RUSRlyaMmkJwto2MXNKqJ5jTxwrTNSyTnT+PRz4Gq1NMZDyqHKL7
         Uo0ZT7t2DKOxAe+KKyO3duJSjW+x5sIX5wpTZX6WydQJbZFGW4ofE1zA8GWEEBrrjz
         lMN7y2Uxz/lBDZelGtpexF1FiX10e28B8+Tc6QG9dZdDlTBxL8MPBHFePqIIXJ+4zy
         VXRmePei+pgoawrxDcmwW7z2Bt7Z77C3/57KJe2HdRNsg0SybXH9WN2xpR2X4hrPDP
         jlmQdXvQmntqgr3PPtc33RCiey2+oz7Tvk650gB6C9n7Vpx27/qCDOfJSve9ZraKsJ
         F1IA0boFT49Gw==
Message-ID: <7b7edc8bacb863915d00673f9e03d38798341a69.camel@kernel.org>
Subject: Re: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     Pumpkin <cc85nod@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Feb 2023 16:22:44 -0500
In-Reply-To: <CBAFB3E5-5737-47A7-8234-3A771E908C4F@oracle.com>
References: <20230202073611.13106-1-cc85nod@gmail.com>
         <CBAFB3E5-5737-47A7-8234-3A771E908C4F@oracle.com>
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

On Thu, 2023-02-02 at 19:41 +0000, Chuck Lever III wrote:
>=20
> > On Feb 2, 2023, at 2:36 AM, Pumpkin <cc85nod@gmail.com> wrote:
> >=20
> > If the upgrading deny mode is invalid or conflicts with other client, w=
e
> > should try to resolve it, but the if-condition makes those error handli=
ng
> > cannot be executed.
> >=20
> > Signed-off-by: Pumpkin <cc85nod@gmail.com>
> > ---
> > fs/nfsd/nfs4state.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 4ef529379..ebdfaf0f9 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5298,7 +5298,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct =
nfs4_file *fp,
> > 	/* test and set deny mode */
> > 	spin_lock(&fp->fi_lock);
> > 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> > -	if (status =3D=3D nfs_ok) {
> > +	if (status !=3D nfs_ok) {
> > 		if (status !=3D nfserr_share_denied) {
>=20
> if status =3D=3D nfs_ok then status will definitely not equal
> share_denied. So this check is a bit nonsensical as it stands.
>=20
> Usually I prefer "switch (status)" in situations like this
> because that avoids this kind of issue and I find it easier
> to read quickly.
>=20
> Jeff, you are the original author of this function, and
> Dai, your commit is the last one to touch this area. Can
> you guys have a look? The one-liner looks correct, but I
> might be missing something.
>=20

Yeah, that code is clearly broken and it looks like it was done in
3d69427151806 (NFSD: add support for share reservation conflict to
courteous server).

I don't believe that one-liner is correct though. If the result is
nfs_ok, then we want to set the deny mode here and that won't happen.

Something like this maybe? (completely untested):

---------------8<-------------------

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c39e43742dd6..af22dfdc6fcc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5282,16 +5282,17 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nf=
s4_file *fp,
        /* test and set deny mode */
        spin_lock(&fp->fi_lock);
        status =3D nfs4_file_check_deny(fp, open->op_share_deny);
-       if (status =3D=3D nfs_ok) {
-               if (status !=3D nfserr_share_denied) {
-                       set_deny(open->op_share_deny, stp);
-                       fp->fi_share_deny |=3D
-                               (open->op_share_deny & NFS4_SHARE_DENY_BOTH=
);
-               } else {
-                       if (nfs4_resolve_deny_conflicts_locked(fp, false,
-                                       stp, open->op_share_deny, false))
-                               status =3D nfserr_jukebox;
-               }
+       switch (status) {
+       case nfs_ok:
+               set_deny(open->op_share_deny, stp);
+               fp->fi_share_deny |=3D
+                       (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
+               break;
+       case nfserr_share_denied:
+               if (nfs4_resolve_deny_conflicts_locked(fp, false,
+                               stp, open->op_share_deny, false))
+                       status =3D nfserr_jukebox;
+               break;
        }
        spin_unlock(&fp->fi_lock);

--=20
Jeff Layton <jlayton@kernel.org>
