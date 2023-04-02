Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE2C6D3AFF
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Apr 2023 01:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDBXxZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Apr 2023 19:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDBXxW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Apr 2023 19:53:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65239A25D
        for <linux-nfs@vger.kernel.org>; Sun,  2 Apr 2023 16:53:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 008AA1F383;
        Sun,  2 Apr 2023 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680479600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjsyuSiTuYez2c4wOAodUEwmsgIyfEqHigq4Z+IKE6Y=;
        b=NQ9Fix5PyhrAE+H67IvH3VrR+KLzgb/7BPeDE3b8r5Q/aYvSygUf+SaAIMk86FaZyarI/L
        mSfIzKeZkNxY3am6JmDX2Xs4vXNoj+fguMC1gJiekiyrE23otXMTEqCttfhCa3uwKiwoW7
        LVexZbn/YNyiL+x2zFIIGLrODYk+Ijc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680479600;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjsyuSiTuYez2c4wOAodUEwmsgIyfEqHigq4Z+IKE6Y=;
        b=0Fii5gbZjeJmi0TKjn2ojhjqlEsA62W34QErsvRQ/OwRhBAyaxFgl6MMpemLdXf94yCFXX
        ZFTRtCcn+epYPdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B475913443;
        Sun,  2 Apr 2023 23:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oRSyGW4VKmRTbwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 02 Apr 2023 23:53:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Dai Ngo" <dai.ngo@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: callback request does not use correct credential
 for AUTH_SYS
In-reply-to: <CF4DFCD5-332D-4147-AA8A-F81FAB96AFA4@oracle.com>
References: <1680380528-22306-1-git-send-email-dai.ngo@oracle.com>,
 <CF4DFCD5-332D-4147-AA8A-F81FAB96AFA4@oracle.com>
Date:   Mon, 03 Apr 2023 09:53:15 +1000
Message-id: <168047959550.14629.15820193625931684256@noble.neil.brown.name>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 03 Apr 2023, Chuck Lever III wrote:
>=20
> > On Apr 1, 2023, at 4:22 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >=20
> > Currently callback request does not use the credential specified in
> > CREATE_SESSION if the security flavor for the back channel is AUTH_SYS.
> >=20
> > Problem was discovered by pynfs 4.1 DELEG5 and DELEG7 test with error:
> > DELEG5   st_delegation.testCBSecParms     : FAILURE
> >           expected callback with uid, gid =3D=3D 17, 19, got 0, 0
> >=20
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>=20
> Does
>=20
> Fixes: 8276c902bbe9 ("SUNRPC: remove uid and gid from struct auth_cred")
>=20
> sound OK to everyone?

Yes, that looks right to me.  Thanks.

NeilBrown

>=20
>=20
> > ---
> > fs/nfsd/nfs4callback.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 2a815f5a52c4..4039ffcf90ba 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -946,8 +946,8 @@ static const struct cred *get_backchannel_cred(struct=
 nfs4_client *clp, struct r
> > if (!kcred)
> > return NULL;
> >=20
> > - kcred->uid =3D ses->se_cb_sec.uid;
> > - kcred->gid =3D ses->se_cb_sec.gid;
> > + kcred->fsuid =3D ses->se_cb_sec.uid;
> > + kcred->fsgid =3D ses->se_cb_sec.gid;
> > return kcred;
> > }
> > }
> > --=20
> > 2.9.5
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

