Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5D5B1255
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 04:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIHCEx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 22:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHCEu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 22:04:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AE25592
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 19:04:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A42B20AFC;
        Thu,  8 Sep 2022 02:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662602685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQL1n2GQn2d3aBx9ku2/iyfDjfQHXFKG4inc0DpobyA=;
        b=hbQcp+2ljmCm+XApBpJfQgD1rqOdLTROzw686/mwtwQaYgfoWcCuMBxiJJnaB54FeOj3KP
        9z/gPO9op66lKiVXTfs/ovGLCOdUa7mCy0kwZDVsDSJbFV6vNrkaq3lHvGoq2JXsOrNlrW
        W7+3hlgE1qj8ZDQswkmpw6Ud7n9qxFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662602685;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQL1n2GQn2d3aBx9ku2/iyfDjfQHXFKG4inc0DpobyA=;
        b=cqvhNKkvr3tfMAlQ4lotnTxXKbK4pCtHAwnYP+g7f5lFPG5x9U1Bec0/LlvfqEgdhOIrEJ
        frGVzyhkQgnCj2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5C671322C;
        Thu,  8 Sep 2022 02:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gdctGrlNGWNdPwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 02:04:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: nfs/001 failing
In-reply-to: <75E3A557-67FB-437E-8350-D2ED82ABE4B9@oracle.com>
References: <BF47B6B7-CB52-4E14-94B0-E28FD5C52234@oracle.com>,
 <20220906122714.GA25323@fieldses.org>,
 <166250586898.30452.12563131953046174303@noble.neil.brown.name>,
 <75E3A557-67FB-437E-8350-D2ED82ABE4B9@oracle.com>
Date:   Thu, 08 Sep 2022 12:04:37 +1000
Message-id: <166260267746.30452.5250279610360481572@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 07 Sep 2022, Chuck Lever III wrote:
>=20
> > On Sep 6, 2022, at 7:11 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Tue, 06 Sep 2022, J. Bruce Fields wrote:
> >> On Mon, Sep 05, 2022 at 04:29:16PM +0000, Chuck Lever III wrote:
> >>> Bruce reminded me I'm not the only one seeing this failure
> >>> these days:
> >>>=20
> >>>> nfs/001 4s ... - output mismatch (see /root/xfstests-dev/results//nfs/=
001.out.bad)
> >>>>   --- tests/nfs/001.out	2019-12-20 17:34:10.569343364 -0500
> >>>>   +++ /root/xfstests-dev/results//nfs/001.out.bad	2022-09-04 20:01:35.=
502462323 -0400
> >>>>   @@ -1,2 +1,2 @@
> >>>>    QA output created by 001
> >>>>   -203
> >>>>   +3
> >>>>   ...
> >>>=20
> >>> I'm looking at about 5 other priority bugs at the moment. Can
> >>> someone else do a little triage?
> >>=20
> >> For what it's worth, a bisect lands on
> >> c0cbe70742f4a70893cd6e5f6b10b6e89b6db95b "NFSD: add posix ACLs to struct
> >> nfsd_attrs".
> >>=20
> >> Haven't really looked at nfs/001 except to note it does have something
> >> to do with ACLs, so that checks out....
> >=20
> > I see the problem.
> > acl setting was moved to nfsd_setattr().
> > But nfsd_setattr() contains the lines
> >=20
> > 	if (!iap->ia_valid)
> > 		return 0;
> >=20
> > In the setacl case, ia_valid is 0.
> >=20
> > Maybe something like:
> >=20
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 528afc3be7af..0582a5b16237 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -395,9 +395,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> > 	if (S_ISLNK(inode->i_mode))
> > 		iap->ia_valid &=3D ~ATTR_MODE;
> >=20
> > -	if (!iap->ia_valid)
> > -		return 0;
> > -
> > 	nfsd_sanitize_attrs(inode, iap);
> >=20
> > 	if (check_guard && guardtime !=3D inode->i_ctime.tv_sec)
> > @@ -448,8 +445,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> > 			goto out_unlock;
> > 	}
> >=20
> > -	iap->ia_valid |=3D ATTR_CTIME;
> > -	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> > +	if (iap->ia_valid) {
> > +		iap->ia_valid |=3D ATTR_CTIME;
> > +		host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> > +	}
>=20
> Unless I'm missing something, host_err might not be initialized
> in the !iap->ia_valid case.

Yes, of course.  Thanks.

I'll post a proper patch which I have now tested.

Thanks,
NeilBrown
