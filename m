Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D6C6658CA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 11:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjAKKRp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 05:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjAKKRE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 05:17:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F9C11807
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 02:15:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75CC8B819CA
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 10:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBA6C433D2;
        Wed, 11 Jan 2023 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673432120;
        bh=N64GMlE1oz9DG4A4D19SRzKH1fH6K2fJbaFVqjQx3uI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mx/4PbNLaujUmS3iI8hNNQL7Xinrtzo8bQq7CEogLRRCgiXbsZHgbCz2dpMEXfVVx
         yd9Lko541SmvZN/zKsBywNLMcKxLMHUg3zYyr0o0jAfTkQCj7Kf+IzKgybqwQQm9GL
         zsS9QAnnfqde7pfT/YSHW8oeihOwnkQziU0qEYTFyNM0Vr5E+mr7IPt4Ibi5Rs1TRN
         rTcLpQqnhAITITnkViUtRrOnHdtJOjvH86iNLElT8k0bKpQmwIWdvmHPgIOctNPOBk
         Ue2EqyQhklK2Q82FJIXXhU/I9VfjTKUuUocHMChHFaqcTJdr6uZUKeccVT5XilI7D5
         GJBmea4DNYUGQ==
Message-ID: <ce3724b88bb2987ac773057f523aa0ed2abacaed.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     Mike Galbraith <efault@gmx.de>, dai.ngo@oracle.com,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 05:15:18 -0500
In-Reply-To: <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
         <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
         <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
         <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
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

On Wed, 2023-01-11 at 03:34 +0100, Mike Galbraith wrote:
> On Tue, 2023-01-10 at 11:58 -0800, dai.ngo@oracle.com wrote:
> >=20
> > On 1/10/23 11:30 AM, Jeff Layton wrote:
> >=20
> > > >=20
> > > >=20
> > > Looking over the traces that Mike posted, I suspect this is the real
> > > bug, particularly if the server is being restarted during this test.
> >=20
> > Yes, I noticed the WARN_ON_ONCE(timer->function !=3D delayed_work_timer=
_fn)
> > too and this seems to indicate some kind of corruption. However, I'm no=
t
> > sure if Mike's test restarts the nfs-server service. This could be a bu=
g
> > in work queue module when it's under stress.
>=20
> My reproducer was to merely mount and traverse/md5sum, while that was
> going on, fire up LTP's min_free_kbytes testcase (memory hog from hell)
> on the server.  Systemthing may well be restarting the server service
> in response to oomkill.  In fact, the struct delayed_work in question
> at WARN_ON_ONCE() time didn't look the least bit ready for business.
>=20
> FWIW, I had noticed the missing cancel while eyeballing, and stuck one
> next to the existing one as a hail-mary, but that helped not at all.
>=20

Ok, thanks, that's good to know.

I still doubt that the problem is the race that Dai seems to think it
is. The workqueue infrastructure has been fairly stable for years. If
there were problems with concurrent tasks queueing the same work, the
kernel would be blowing up all over the place.

> crash> delayed_work ffff8881601fab48
> struct delayed_work {
>   work =3D {
>     data =3D {
>       counter =3D 1
>     },
>     entry =3D {
>       next =3D 0x0,
>       prev =3D 0x0
>     },
>     func =3D 0x0
>   },
>   timer =3D {
>     entry =3D {
>       next =3D 0x0,
>       pprev =3D 0x0
>     },
>     expires =3D 0,
>     function =3D 0x0,
>     flags =3D 0
>   },
>   wq =3D 0x0,
>   cpu =3D 0
> }

That looks more like a memory scribble or UAF. Merely having multiple
tasks calling queue_work at the same time wouldn't be enough to trigger
this, IMO. It's more likely that the extra locking is changing the
timing of your reproducer somehow.

It might be interesting to turn up KASAN if you're able.=20
--=20
Jeff Layton <jlayton@kernel.org>
