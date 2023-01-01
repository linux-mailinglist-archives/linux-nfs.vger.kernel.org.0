Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1665ABA4
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Jan 2023 22:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAAVQJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Jan 2023 16:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAAVQI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Jan 2023 16:16:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992AD85
        for <linux-nfs@vger.kernel.org>; Sun,  1 Jan 2023 13:16:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBDDE60E2C
        for <linux-nfs@vger.kernel.org>; Sun,  1 Jan 2023 21:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC21C433D2;
        Sun,  1 Jan 2023 21:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672607764;
        bh=uXp2//v/WaPHWSDehXuyWi1nIgFIfZthNkTay1R1Rko=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=URZOUqGD+3n/zUsQqLOefqI+KEVHzMCkMW03QaSpx21+pKdEVxwgjKEKLparulixU
         TOdlOfQKqLa/Ir5sU26r5Wo43brBRGbCOOovAxGHOliI5eEK50XG8wjgrgful62GW3
         tBl8pjVrorr6z6j801YFMBMiuVjJd1J4LmWhAT0si5NB6Sx9V5Kdkr5Eer5XrDwtca
         nF5fGvpJElg1Q7/vyon+shGL9WACuGjRKLImiazWkrFGpu/2Ha/VgNkcVXBCDeN4to
         I8NeMwk9HlEqlguHaEGwasOpxrLEoj8pR72d9pCFY7hIepoDJ5eKu/fBLatuM7m/IA
         BdQxeDOwaz6ow==
Message-ID: <4fbce57518a3870e82411b31e026ffdd8ea1c98d.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount
 upcall timeout
From:   Jeff Layton <jlayton@kernel.org>
To:     Ian Kent <raven@themaw.net>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>,
        Richard Weinberger <richard@nod.at>
Date:   Sun, 01 Jan 2023 16:16:02 -0500
In-Reply-To: <b2593a91-0957-5203-b556-f93bdd2dc0dd@themaw.net>
References: <20221213180826.216690-1-jlayton@kernel.org>
         <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
         <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
         <81f891ef-b498-24b0-12e3-4ddda8062dc0@themaw.net>
         <0d6deecbe0dff95ebbe061914ddb00ca04d1f3c1.camel@kernel.org>
         <b2593a91-0957-5203-b556-f93bdd2dc0dd@themaw.net>
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

On Wed, 2022-12-14 at 13:37 +0800, Ian Kent wrote:
> On 14/12/22 08:39, Jeff Layton wrote:
> > On Wed, 2022-12-14 at 07:14 +0800, Ian Kent wrote:
> > > On 14/12/22 04:02, Jeff Layton wrote:
> > > > On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
> > > > > > On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> w=
rote:
> > > > > >=20
> > > > > > If v4 READDIR operation hits a mountpoint and gets back an erro=
r,
> > > > > > then it will include that entry in the reply and set RDATTR_ERR=
OR for it
> > > > > > to the error.
> > > > > >=20
> > > > > > That's fine for "normal" exported filesystems, but on the v4roo=
t, we
> > > > > > need to be more careful to only expose the existence of dentrie=
s that
> > > > > > lead to exports.
> > > > > >=20
> > > > > > If the mountd upcall times out while checking to see whether a
> > > > > > mountpoint on the v4root is exported, then we have no recourse =
other
> > > > > > than to fail the whole operation.
> > > > > Thank you for chasing this down!
> > > > >=20
> > > > > Failing the whole READDIR when mountd times out might be a bad id=
ea.
> > > > > If the mountd upcall times out every time, the client can't make
> > > > > any progress and will continue to emit the failing READDIR reques=
t.
> > > > >=20
> > > > > Would it be better to skip the unresolvable entry instead and let
> > > > > the READDIR succeed without that entry?
> > > > >=20
> > > > Mounting doesn't usually require working READDIR. In that situation=
, a
> > > > readdir() might hang (until the client kills), but a lookup of othe=
r
> > > > dentries that aren't perpetually stalled should be ok in this situa=
tion.
> > > >=20
> > > > If mountd is that hosed then I think it's unlikely that any progres=
s
> > > > will be possible anyway.
> > > The READDIR shouldn't trigger a mount yes, but if it's a valid automo=
unt
> > >=20
> > > point (basically a valid dentry in this case I think) it should be li=
sted.
> > >=20
> > > It certainly shouldn't hold up the READDIR, passing into it is when a
> > >=20
> > > mount should occur.
> > >=20
> > >=20
> > > That's usually the behavior we want for automounts, we don't want mou=
nt
> > >=20
> > > storms on directories full of automount points.
> > >=20
> >=20
> > We only want to display it if it's a valid _exported_ mountpoint.
> >=20
> > The idea here is to only reveal the parts of the namespace that are
> > exported in the nfsv4 pseudoroot. The "normal" contents are not shown -=
-
> > only exported mountpoints and ancestor directories of those mountpoints=
.
> >=20
> > We don't want mountd triggering automounts, in general. If the
> > underlying filesystem was exported, then it should also already be
> > mounted, since nfsd doesn't currently trigger automounts in
> > follow_down().
>=20
> Umm ... must they already be mounted?
>=20
>=20
> Can't it be a valid mount point either not yet mounted or timed out
>=20
> and umounted. In that case shouldn't it be listed, I know that's
>=20
> not the that good an outcome because its stat info will change when
>=20
> it gets walked into but it's usually the only sane choice.
>=20

Yes, it does need to already be mounted.

The proposed kernel patches from Richard only trigger an automount if
the parent mount is exported with -o crossmnt. I think this is necessary
to avoid nfs client activity triggering automounts of filesystems that
are not exported.

>=20
> >=20
> > There is also a separate patchset by Richard Weinberger to allow nfsd t=
o
> > trigger automounts if the parent filesystem is exported with -o
> > crossmnt. That should be ok with this patch, since the automount will b=
e
> > triggered before the upcall to mountd. That should ensure that it's
> > already mounted by the time we get to upcalling for its export.
>=20

--=20
Jeff Layton <jlayton@kernel.org>
