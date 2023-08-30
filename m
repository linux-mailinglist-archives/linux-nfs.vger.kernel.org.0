Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4F78D121
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 02:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjH3A15 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 20:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbjH3A1g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 20:27:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0CFEA
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 17:27:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 737702184B;
        Wed, 30 Aug 2023 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693355252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgMKWoooVRPO/np7OpR+6hCDYLJadBKmBVrguQfGlqo=;
        b=TNSEV82DUgX4lhWfyZkFWRA6ZNpVyi/RusxFJCut2Fp2wKshuIqBvuEVvlITkf+uEH5jR4
        Eaf/WtxoJDVoOtYR5PsZg1DY9I5cK1hLX0m5vBthZGrytcH91P9aO1NaljUQxds2S1lIuG
        YJOmNz/5fvHy/q58jHHjrbWsCJmSPAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693355252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgMKWoooVRPO/np7OpR+6hCDYLJadBKmBVrguQfGlqo=;
        b=NNMymkxXUfB7WAVgoLkHQPaEWa9ebuTWExfnT8QG1Cnd4ttr12WjqeDZsCIKXSv3siye11
        2z/Ql53O1Ysd/fCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3323013301;
        Wed, 30 Aug 2023 00:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mu68NfKM7mR3JgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 00:27:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: allow setting SEQ4_STATUS_RECALLABLE_STATE_REVOKED
In-reply-to: <ZO5Wd7BdgsNMOpfU@tissot.1015granger.net>
References: =?utf-8?q?=3Ccd03fb7419f886c8c79bb2ee4889dbc0768a1652=2E16933263?=
 =?utf-8?q?66=2Egit=2Ebcodding=40redhat=2Ecom=3E=2C?=
 <ZO5Wd7BdgsNMOpfU@tissot.1015granger.net>
Date:   Wed, 30 Aug 2023 10:27:27 +1000
Message-id: <169335524735.5133.6421976142558796202@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 30 Aug 2023, Chuck Lever wrote:
> On Tue, Aug 29, 2023 at 12:26:56PM -0400, Benjamin Coddington wrote:
> > This patch sets the SEQ4_STATUS_RECALLABLE_STATE_REVOKED bit for a single
> > SEQUENCE response after writing "revoke" to the client's ctl file in proc=
fs.
> > It has been generally useful to test various NFS client implementations, =
so
> > I'm sending it along for others to find and use.
>=20
> Intriguing!
>=20
> It looks to me like the client would probe its state and
> find nothing missing... fair enough.
>=20
> Would it be even more useful if the server administrator could
> actually revoke some state, rather than just pretending to?
> How difficult do you think that might be?

I have patches for revoking state.  I sent them some time ago and we
discussed them, but you wanted to wait for the courteous client code to
land (which was fair enough) and then I forgot to come back with them.

I'll try to make time to repost them.

NeilBrown


>=20
> Or, conversely, what exactly can you test with this mechanism?
>=20
>=20
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 19 +++++++++++++++----
> >  fs/nfsd/state.h     |  1 +
> >  2 files changed, 16 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index daf305daa751..f91e2857df65 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2830,18 +2830,28 @@ static ssize_t client_ctl_write(struct file *file=
, const char __user *buf,
> >  {
> >  	char *data;
> >  	struct nfs4_client *clp;
> > +	ssize_t rc =3D size;
> > =20
> >  	data =3D simple_transaction_get(file, buf, size);
> >  	if (IS_ERR(data))
> >  		return PTR_ERR(data);
> > -	if (size !=3D 7 || 0 !=3D memcmp(data, "expire\n", 7))
> > +
> > +	if (size !=3D 7)
> >  		return -EINVAL;
> > +
> >  	clp =3D get_nfsdfs_clp(file_inode(file));
> >  	if (!clp)
> >  		return -ENXIO;
> > -	force_expire_client(clp);
> > +
> > +	if (!memcmp(data, "revoke\n", 7))
> > +		set_bit(NFSD4_CLIENT_CL_REVOKED, &clp->cl_flags);
> > +	else if (!memcmp(data, "expire\n", 7))
> > +		force_expire_client(clp);
> > +	else
> > +		rc =3D -EINVAL;
> > +
> >  	drop_client(clp);
> > -	return 7;
> > +	return rc;
> >  }
> > =20
> >  static const struct file_operations client_ctl_fops =3D {
> > @@ -4042,7 +4052,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> >  	default:
> >  		seq->status_flags =3D 0;
> >  	}
> > -	if (!list_empty(&clp->cl_revoked))
> > +	if (!list_empty(&clp->cl_revoked) ||
> > +			test_and_clear_bit(NFSD4_CLIENT_CL_REVOKED, &clp->cl_flags))
> >  		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> >  out_no_session:
> >  	if (conn)
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index d49d3060ed4f..a9154b7da022 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -369,6 +369,7 @@ struct nfs4_client {
> >  #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> >  					 1 << NFSD4_CLIENT_CB_KILL)
> >  #define NFSD4_CLIENT_CB_RECALL_ANY	(6)
> > +#define NFSD4_CLIENT_CL_REVOKED (7)
> >  	unsigned long		cl_flags;
> >  	const struct cred	*cl_cb_cred;
> >  	struct rpc_clnt		*cl_cb_client;
> > --=20
> > 2.40.1
> >=20
>=20
> --=20
> Chuck Lever
>=20

