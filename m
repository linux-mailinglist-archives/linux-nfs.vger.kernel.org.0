Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56756B83EA
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 22:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjCMVYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCMVYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 17:24:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA2A233CE
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 14:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC442B81058
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 21:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A28C433D2;
        Mon, 13 Mar 2023 21:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678742641;
        bh=YLCHUieSoikWXf5X/h60Tv/XGHogQeY7TMAgBIxDtWA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dbNDK8d2c4oc97fQ15uEebskml8UwdIGkBWAM3MeeNeCrTzJ5TOZMG3/Yi1LwB1n2
         IgPdP+d72shEML/mGFMC/1ql//Gq/2D8+hfr0FKFwmKjHCbepRF4t4HMsDR/gkEckE
         BRYXtEe/90mo1Yx+j0M+vizoZI50NCMY37auJSREH1ryNxAs3NiSjUrdi0pObIo4GA
         XTJkDDRh++CUjFj4KFSAy0J8tVcpjEtlGsP2iX/8gCi9+CAQ5cfJKFswloYHK6zqwm
         UQVU2Ew2RixuCIfkc8QWNnbYaG1wJBRXsz4jpErdR5QIybt5pp4ce/bj3fnwOVdExg
         wCGi/xgYND3fQ==
Message-ID: <3bf141fa2d0be0725f61cafdfe23b21bb13791da.camel@kernel.org>
Subject: Re: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock
 request
From:   Jeff Layton <jlayton@kernel.org>
To:     Frank Filz <ffilzlnx@mindspring.com>, calum.mackay@oracle.com
Cc:     bfields@fieldses.org, linux-nfs@vger.kernel.org,
        'Frank Filz' <ffilz@redhat.com>
Date:   Mon, 13 Mar 2023 17:23:59 -0400
In-Reply-To: <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>
References: <20230313112401.20488-1-jlayton@kernel.org>
         <20230313112401.20488-6-jlayton@kernel.org>
         <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for testing it, Frank.

FWIW, if the unmodified test still passes on ganesha then that's
probably an indicator that it's not doing adequate vetting of the lock
seqid with v4.0.

Cheers,
Jeff

On Mon, 2023-03-13 at 11:51 -0700, Frank Filz wrote:
> Looks good to me, tested against Ganesha and the updated patch passes.
>=20
> Frank
>=20
> > -----Original Message-----
> > From: Jeff Layton [mailto:jlayton@kernel.org]
> > Sent: Monday, March 13, 2023 4:24 AM
> > To: calum.mackay@oracle.com
> > Cc: bfields@fieldses.org; ffilzlnx@mindspring.com;
> linux-nfs@vger.kernel.org;
> > Frank Filz <ffilz@redhat.com>
> > Subject: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock
> request
> >=20
> > This test currently fails against Linux nfsd, but I think it's the test
> that's wrong. It
> > basically does:
> >=20
> > open for read
> > read lock
> > unlock
> > open upgrade
> > write lock
> >=20
> > The write lock above is sent with a lock_seqid of 0, which is wrong.
> > RFC7530/16.10.5 says:
> >=20
> >    o  In the case in which the state has been created and the [new
> >       lockowner] boolean is true, the server rejects the request with t=
he
> >       error NFS4ERR_BAD_SEQID.  The only exception is where there is a
> >       retransmission of a previous request in which the boolean was
> >       true.  In this case, the lock_seqid will match the original
> >       request, and the response will reflect the final case, below.
> >=20
> > Since the above is not a retransmission, knfsd is correct to reject thi=
s
> call. This
> > patch fixes the open_sequence object to track the lock seqid and set it
> correctly
> > in the LOCK request.
> >=20
> > With this, LOCK24 passes against knfsd.
> >=20
> > Cc: Frank Filz <ffilz@redhat.com>
> > Fixes: 4299316fb357 (Add LOCK24 test case to test open uprgade/downgrad=
e
> > scenario)
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  nfs4.0/servertests/st_lock.py | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/nfs4.0/servertests/st_lock.py b/nfs4.0/servertests/st_lock=
.py
> index
> > 468672403ffe..9d650ab017b9 100644
> > --- a/nfs4.0/servertests/st_lock.py
> > +++ b/nfs4.0/servertests/st_lock.py
> > @@ -886,6 +886,7 @@ class open_sequence:
> >          self.client =3D client
> >          self.owner =3D owner
> >          self.lockowner =3D lockowner
> > +        self.lockseqid =3D 0
> >      def open(self, access):
> >          self.fh, self.stateid =3D self.client.create_confirm(self.owne=
r,
> >  						access=3Daccess,
> > @@ -900,14 +901,17 @@ class open_sequence:
> >          self.client.close_file(self.owner, self.fh, self.stateid)
> >      def lock(self, type):
> >          res =3D self.client.lock_file(self.owner, self.fh, self.statei=
d,
> > -                    type=3Dtype, lockowner=3Dself.lockowner)
> > +                                    type=3Dtype, lockowner=3Dself.lock=
owner,
> > +                                    lockseqid=3Dself.lockseqid)
> >          check(res)
> >          if res.status =3D=3D NFS4_OK:
> >              self.lockstateid =3D res.lockid
> > +            self.lockseqid +=3D 1
> >      def unlock(self):
> >          res =3D self.client.unlock_file(1, self.fh, self.lockstateid)
> >          if res.status =3D=3D NFS4_OK:
> >              self.lockstateid =3D res.lockid
> > +            self.lockseqid +=3D 1
> >=20
> >  def testOpenUpgradeLock(t, env):
> >      """Try open, lock, open, downgrade, close
> > --
> > 2.39.2
>=20

--=20
Jeff Layton <jlayton@kernel.org>
