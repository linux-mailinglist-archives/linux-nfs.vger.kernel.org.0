Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2AE799A3F
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Sep 2023 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjIIRXo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Sep 2023 13:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbjIIRXo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Sep 2023 13:23:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD012C;
        Sat,  9 Sep 2023 10:23:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859DEC433C8;
        Sat,  9 Sep 2023 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694280220;
        bh=kN0GatOuGmn7M9j3OFHcavHbIN54N2TRb/KhektNcXs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aCXO55YqgBYlKACYYr8i/ZWNawwSmXuZF1u7JNrgsmVt2od/9SX80McinKwMqKIeI
         BCq5T9xbYwDyHPxwpSbGJ9wnD/jejwtpn04AXbwElwW1Eg2tmzfWDU3e0Fs85aIudf
         FkB8ceP8MHPRJ39aTKcobPDMGZtYR0VWs5RFbIr+T6RChv32l+l30F2rSVh/QdPtXB
         9e4tjV49nk/Rwp2w9uOqjDiFkxASn0zQ0GLzn6nFuW8ZdF+WZN1VBLdrAyR/5jY5Vh
         d70m9ejQwtXBLXTFztOl92b3q3HG3pivqv8NSH9XxBCLXSTLPsIHGVyW6FZisY69XI
         5EPEaCNfJLFzA==
Message-ID: <18563ba8226cdc28b3c9c91214dbb936b6ad7a01.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix change_info in NFSv4 RENAME replies
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Date:   Sat, 09 Sep 2023 13:23:38 -0400
In-Reply-To: <ZPyMyv1nNFV2whKP@tissot.1015granger.net>
References: <20230909-nfsd-fixes-v1-1-2ebc659c0cf4@kernel.org>
         <ZPyMyv1nNFV2whKP@tissot.1015granger.net>
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

On Sat, 2023-09-09 at 11:18 -0400, Chuck Lever wrote:
> On Sat, Sep 09, 2023 at 07:12:30AM -0400, Jeff Layton wrote:
> > nfsd sends the transposed directory change info in the RENAME reply. Th=
e
> > source directory is in save_fh and the target is in current_fh.
> >=20
> > Reported-by: Zhi Li <yieli@redhat.com>
> > Reported-by: Benjamin Coddington <bcodding@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This bug predates git, so I can't add a proper Fixes tag. I think this
> > is probably appropriate for stable series kernels though.
> >=20
> > This bug was largely papered over by the fact that we factored in the
> > ctime when generating a change attribute. Since this commit, however:
> >=20
> >     638e3e7d9493 nfsd: use the getattr operation to fetch i_version
> >=20
> > We stopped doing that for directory inodes and that caused this bug to
> > pop up.
>=20
> Applied to nfsd-fixes with a "Cc: stable" tag added.
>=20
> Is there a publicly-accessible bug report link that can be included?
>=20
>=20

Yes. I just made this one public:

    https://bugzilla.redhat.com/show_bug.cgi?id=3D2218844

It has Ben's reproducer script for this in it too.

> > ---
> >  fs/nfsd/nfs4proc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 5ca748309c26..4199ede0583c 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1058,8 +1058,8 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> >  			     rename->rn_tname, rename->rn_tnamelen);
> >  	if (status)
> >  		return status;
> > -	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
> > -	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
> > +	set_change_info(&rename->rn_sinfo, &cstate->save_fh);
> > +	set_change_info(&rename->rn_tinfo, &cstate->current_fh);
> >  	return nfs_ok;
> >  }
> > =20
> >=20
> > ---
> > base-commit: dd1386dd3c4f4bc55456c88180f9f39697bb95c0
> > change-id: 20230908-nfsd-fixes-f5bdb87e6035
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
