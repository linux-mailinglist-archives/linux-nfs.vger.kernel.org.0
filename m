Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ABE64C16F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Dec 2022 01:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiLNAlk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 19:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiLNAlN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 19:41:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E726AD1
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 16:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D9AF5CE17D2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Dec 2022 00:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51903C433D2;
        Wed, 14 Dec 2022 00:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670978372;
        bh=YsJbhfq77hTzpL4psBx5tw4aPeBl4nbJ2mOEXjFY+FE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N44frqq710M5260erOX47e0bmhZpjPFFK7cOSk9rW8jPdapZG7Wnu+Tq8wlH8OwRF
         6qlRKeybHlT33LnnWnH1EuehoSKY+JhHEbcjuxUY0zfsvlPl+HNdmlTQj9aM+Jn3Ne
         Nu2mNd++p4yY8QP+6+IYuT21/C1VNUIPYDDku9HMJcbB38lFUMAo+0fHg5VH21lKhL
         lSlnQcchlHKVlEbhf3t8nTbfxR0lZyIT0Y67OdX9Pt8aZfyIlAAkvYb3Tg/s8uStMi
         bi0BR6WEjibl99Jo35sxihQhdl0kWsDTRX3SZS2A/4XXv0CtksJNrvZMWqqkBNaOpf
         JTutUJMgYLBEA==
Message-ID: <0d6deecbe0dff95ebbe061914ddb00ca04d1f3c1.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount
 upcall timeout
From:   Jeff Layton <jlayton@kernel.org>
To:     Ian Kent <raven@themaw.net>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>,
        Richard Weinberger <richard@nod.at>
Date:   Tue, 13 Dec 2022 19:39:29 -0500
In-Reply-To: <81f891ef-b498-24b0-12e3-4ddda8062dc0@themaw.net>
References: <20221213180826.216690-1-jlayton@kernel.org>
         <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
         <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
         <81f891ef-b498-24b0-12e3-4ddda8062dc0@themaw.net>
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

On Wed, 2022-12-14 at 07:14 +0800, Ian Kent wrote:
> On 14/12/22 04:02, Jeff Layton wrote:
> > On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
> > > > On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > If v4 READDIR operation hits a mountpoint and gets back an error,
> > > > then it will include that entry in the reply and set RDATTR_ERROR f=
or it
> > > > to the error.
> > > >=20
> > > > That's fine for "normal" exported filesystems, but on the v4root, w=
e
> > > > need to be more careful to only expose the existence of dentries th=
at
> > > > lead to exports.
> > > >=20
> > > > If the mountd upcall times out while checking to see whether a
> > > > mountpoint on the v4root is exported, then we have no recourse othe=
r
> > > > than to fail the whole operation.
> > > Thank you for chasing this down!
> > >=20
> > > Failing the whole READDIR when mountd times out might be a bad idea.
> > > If the mountd upcall times out every time, the client can't make
> > > any progress and will continue to emit the failing READDIR request.
> > >=20
> > > Would it be better to skip the unresolvable entry instead and let
> > > the READDIR succeed without that entry?
> > >=20
> > Mounting doesn't usually require working READDIR. In that situation, a
> > readdir() might hang (until the client kills), but a lookup of other
> > dentries that aren't perpetually stalled should be ok in this situation=
.
> >=20
> > If mountd is that hosed then I think it's unlikely that any progress
> > will be possible anyway.
>=20
> The READDIR shouldn't trigger a mount yes, but if it's a valid automount
>=20
> point (basically a valid dentry in this case I think) it should be listed=
.
>=20
> It certainly shouldn't hold up the READDIR, passing into it is when a
>=20
> mount should occur.
>=20
>=20
> That's usually the behavior we want for automounts, we don't want mount
>=20
> storms on directories full of automount points.
>=20


We only want to display it if it's a valid _exported_ mountpoint.

The idea here is to only reveal the parts of the namespace that are
exported in the nfsv4 pseudoroot. The "normal" contents are not shown --
only exported mountpoints and ancestor directories of those mountpoints.

We don't want mountd triggering automounts, in general. If the
underlying filesystem was exported, then it should also already be
mounted, since nfsd doesn't currently trigger automounts in
follow_down().

There is also a separate patchset by Richard Weinberger to allow nfsd to
trigger automounts if the parent filesystem is exported with -o
crossmnt. That should be ok with this patch, since the automount will be
triggered before the upcall to mountd. That should ensure that it's
already mounted by the time we get to upcalling for its export.
--=20
Jeff Layton <jlayton@kernel.org>
