Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4D7704DC
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 17:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHDPeF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHDPeA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 11:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5654C0E
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 08:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF72862056
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 15:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DC8C433C7;
        Fri,  4 Aug 2023 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163233;
        bh=j0RAmJR6ruIOyFTrxY2IKpBOEE0J8IoyJzli8g9rfwE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pl31AtQM4u4zelZokL3MybMrCOo8ZRTocg4tN+VR2UZsf3Xt+EJeLQki6SILkEXku
         QP3/YltXEkuNtekyeMXgiifZnL9ikHHqdj62f2thnMYhBuxKs0YZTDUMfPbBiqAnFu
         1xWkdnOYNZ7YEhCSe7w5WAKy2rjdg3DpLLObgYZwdPLsHiKyHA9klTLClLbJ7pd+O7
         JTITfujlpjfZy/wxeE8Ta4Jc58cF6djWmHDjb8fuiOIQYuGn5Uew252Sav2FxUZIM0
         GLv6dVbCqECauDP06aEgr2yAH6SHr75dnRc4WUm8gBEuwaljUUbc2AwjxiljiKHFsH
         xfK6dGpGi0LMQ==
Message-ID: <7e6053d48b2e4d62c7875e76653ecbc7557ec8d4.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Fix race to FREE_STATEID and cl_revoked
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 04 Aug 2023 11:33:51 -0400
In-Reply-To: <ZM0TF/rOFOxlaA+p@tissot.1015granger.net>
References: <c0fe2b35900938943048340ef70fc12282fe1af8.1691160604.git.bcodding@redhat.com>
         <ZM0TF/rOFOxlaA+p@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-08-04 at 11:02 -0400, Chuck Lever wrote:
> On Fri, Aug 04, 2023 at 10:52:20AM -0400, Benjamin Coddington wrote:
> > We have some reports of linux NFS clients that cannot satisfy a linux k=
nfsd
> > server that always sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED even thoug=
h
> > those clients repeatedly walk all their known state using TEST_STATEID =
and
> > receive NFS4_OK for all.
> >=20
> > Its possible for revoke_delegation() to set NFS4_REVOKED_DELEG_STID, th=
en
> > nfsd4_free_stateid() finds the delegation and returns NFS4_OK to
> > FREE_STATEID.  Afterward, revoke_delegation() moves the same delegation=
 to
> > cl_revoked.  This would produce the observed client/server effect.
> >=20
> > Fix this by ensuring that the setting of sc_type to NFS4_REVOKED_DELEG_=
STID
> > and move to cl_revoked happens within the same cl_lock.  This will allo=
w
> > nfsd4_free_stateid() to properly remove the delegation from cl_revoked.
> >=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2217103
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2176575
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>=20
> Hi Ben, does this fix deserve:
>=20
> Cc: stable@vger.kernel.org # v4.17+
>=20
> ??
>=20

What's special about v4.17? Is there a patch that broke it that went
into that release?

> > ---
> >  fs/nfsd/nfs4state.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 3aefbad4cc09..daf305daa751 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1354,9 +1354,9 @@ static void revoke_delegation(struct nfs4_delegat=
ion *dp)
> >  	trace_nfsd_stid_revoke(&dp->dl_stid);
> > =20
> >  	if (clp->cl_minorversion) {
> > +		spin_lock(&clp->cl_lock);
> >  		dp->dl_stid.sc_type =3D NFS4_REVOKED_DELEG_STID;
> >  		refcount_inc(&dp->dl_stid.sc_count);
> > -		spin_lock(&clp->cl_lock);
> >  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> >  		spin_unlock(&clp->cl_lock);
> >  	}
> > --=20
> > 2.40.1
> >=20
>=20

The fix looks correct though. You can also add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
