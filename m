Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCE65C0E1
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jan 2023 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbjACNbl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 08:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbjACNbd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 08:31:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AF12A2
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 05:31:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B19CB80EC3
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 13:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6635AC433EF;
        Tue,  3 Jan 2023 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672752690;
        bh=SpKCGMhhzBnSJnB7cHugi+CzSfWdfz6Ury/zuxHgNsc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ko5oSoKJmcEEgwbiN/+6b/C+Nknoz9r+0bkxmp2kmsIz/xx1xf0uksAy4/twlTcMR
         y0xJnHVRNxskwlgS2nbpOYcylPIQk1SWYGLH/go9xLy6sFM8kDurH88Z8VASl/Deub
         /PxiL7Cif1mra95WMQeAbb/D2CDPlpDFMowms4bJu7mrzVywvCOnBz50kdYX2+72g7
         XxgdKN+Y30EOcMJZnhjXTtuiFmP1CwrRD3dTwywtU5pQ0FRFTROl0hc6GRjauu/xg5
         Kfk9wLIeIgeggO+15aRJnPMltWIIeUWLDm9kFabA+HRsM8ECdGTrMT3UE/DmozEjcT
         gxGMAC072smTg==
Message-ID: <6f869549199e7c2a4a9aa239e0091cd9c7733ab7.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount
 upcall timeout
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Ian Kent <raven@themaw.net>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>,
        Richard Weinberger <richard@nod.at>
Date:   Tue, 03 Jan 2023 08:31:28 -0500
In-Reply-To: <5248B584-8A4A-47D2-A7D0-8EFDC2B97F63@oracle.com>
References: <20221213180826.216690-1-jlayton@kernel.org>
         <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
         <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
         <81f891ef-b498-24b0-12e3-4ddda8062dc0@themaw.net>
         <0d6deecbe0dff95ebbe061914ddb00ca04d1f3c1.camel@kernel.org>
         <b2593a91-0957-5203-b556-f93bdd2dc0dd@themaw.net>
         <940934D4-7896-4C0D-93F1-26170C49CBE4@oracle.com>
         <5248B584-8A4A-47D2-A7D0-8EFDC2B97F63@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-01-01 at 18:18 +0000, Chuck Lever III wrote:
>=20
> > On Jan 1, 2023, at 1:09 PM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
> >=20
> >=20
> >=20
> > > On Dec 14, 2022, at 12:37 AM, Ian Kent <raven@themaw.net> wrote:
> > >=20
> > > On 14/12/22 08:39, Jeff Layton wrote:
> > > > On Wed, 2022-12-14 at 07:14 +0800, Ian Kent wrote:
> > > > > On 14/12/22 04:02, Jeff Layton wrote:
> > > > > > On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
> > > > > > > > On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > > > > > >=20
> > > > > > > > If v4 READDIR operation hits a mountpoint and gets back an =
error,
> > > > > > > > then it will include that entry in the reply and set RDATTR=
_ERROR for it
> > > > > > > > to the error.
> > > > > > > >=20
> > > > > > > > That's fine for "normal" exported filesystems, but on the v=
4root, we
> > > > > > > > need to be more careful to only expose the existence of den=
tries that
> > > > > > > > lead to exports.
> > > > > > > >=20
> > > > > > > > If the mountd upcall times out while checking to see whethe=
r a
> > > > > > > > mountpoint on the v4root is exported, then we have no recou=
rse other
> > > > > > > > than to fail the whole operation.
> > > > > > > Thank you for chasing this down!
> > > > > > >=20
> > > > > > > Failing the whole READDIR when mountd times out might be a ba=
d idea.
> > > > > > > If the mountd upcall times out every time, the client can't m=
ake
> > > > > > > any progress and will continue to emit the failing READDIR re=
quest.
> > > > > > >=20
> > > > > > > Would it be better to skip the unresolvable entry instead and=
 let
> > > > > > > the READDIR succeed without that entry?
> > > > > > >=20
> > > > > > Mounting doesn't usually require working READDIR. In that situa=
tion, a
> > > > > > readdir() might hang (until the client kills), but a lookup of =
other
> > > > > > dentries that aren't perpetually stalled should be ok in this s=
ituation.
> > > > > >=20
> > > > > > If mountd is that hosed then I think it's unlikely that any pro=
gress
> > > > > > will be possible anyway.
> > > > > The READDIR shouldn't trigger a mount yes, but if it's a valid au=
tomount
> > > > >=20
> > > > > point (basically a valid dentry in this case I think) it should b=
e listed.
> > > > >=20
> > > > > It certainly shouldn't hold up the READDIR, passing into it is wh=
en a
> > > > >=20
> > > > > mount should occur.
> > > > >=20
> > > > >=20
> > > > > That's usually the behavior we want for automounts, we don't want=
 mount
> > > > >=20
> > > > > storms on directories full of automount points.
> > > > >=20
> > > >=20
> > > > We only want to display it if it's a valid _exported_ mountpoint.
> > > >=20
> > > > The idea here is to only reveal the parts of the namespace that are
> > > > exported in the nfsv4 pseudoroot. The "normal" contents are not sho=
wn --
> > > > only exported mountpoints and ancestor directories of those mountpo=
ints.
> > > >=20
> > > > We don't want mountd triggering automounts, in general. If the
> > > > underlying filesystem was exported, then it should also already be
> > > > mounted, since nfsd doesn't currently trigger automounts in
> > > > follow_down().
> > >=20
> > > Umm ... must they already be mounted?
> > >=20
> > >=20
> > > Can't it be a valid mount point either not yet mounted or timed out
> > >=20
> > > and umounted. In that case shouldn't it be listed, I know that's
> > >=20
> > > not the that good an outcome because its stat info will change when
> > >=20
> > > it gets walked into but it's usually the only sane choice.
> > >=20
> > >=20
> > > >=20
> > > > There is also a separate patchset by Richard Weinberger to allow nf=
sd to
> > > > trigger automounts if the parent filesystem is exported with -o
> > > > crossmnt. That should be ok with this patch, since the automount wi=
ll be
> > > > triggered before the upcall to mountd. That should ensure that it's
> > > > already mounted by the time we get to upcalling for its export.
> > >=20
> > > Yep, saw that, ;)
> >=20
> > I'm not sure if there is consensus on this patch.
> >=20
> > It's been pushed to nfsd's for-rc branch for wider testing, but if
> > there's a strong objection I can pull it out before the next -rc PR.
>=20
> Also, do we agree that it should get a "Cc: stable" tag?
>=20

Yes, I think so. This potentially exposes some info to clients that they
really shouldn't have.
--=20
Jeff Layton <jlayton@kernel.org>
