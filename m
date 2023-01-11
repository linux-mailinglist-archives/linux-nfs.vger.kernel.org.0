Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC228665AF4
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 13:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjAKMEH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 07:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjAKMDN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 07:03:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F5521A8
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 04:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35165B81BDB
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 12:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CECC433F0;
        Wed, 11 Jan 2023 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673438420;
        bh=kjEsJtsTXCugmi29pjn3nMa9Nj7+FlpAr7rFJnxLKFk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kir/S369r9BJlyYcYPMNImGgSQcOfxclYP0bB6BDLEOgZeG9Eiy3lEP6rwGfeXxYS
         MsE2keR/0bqHgzPT6LrIWy/nwXKVWPl6LXL2kk8ogmoy+8du8egA04jeMr02wfgNxh
         Aagfy6ZAnEtbCZy6/YtfhOlFJVR0luxywvdgyTJ0oG6PqO3hPcZOs3d5hcQJIlt0Ae
         i+O3wwUZ7McUexb3ixhUhaBElON27ppeWgZhpYTGG7qSgu1jZA+Sn7ljJkDY2vLdyN
         XrmW3hj3eVvXXEQCtfShGH4Wu/8l4d1bSJOyvE8EAqrPiw8mLyvyiYHLIWi+o8E899
         0p+8jcarqc7RA==
Message-ID: <dcdf93ed67d3039c1686048a32626d03ea1f2fae.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     Mike Galbraith <efault@gmx.de>, dai.ngo@oracle.com,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 07:00:18 -0500
In-Reply-To: <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
         <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
         <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
         <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
         <ce3724b88bb2987ac773057f523aa0ed2abacaed.camel@kernel.org>
         <2067b4b4ce029ab5be982820b81241cd457ff475.camel@kernel.org>
         <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 12:19 +0100, Mike Galbraith wrote:
> On Wed, 2023-01-11 at 05:55 -0500, Jeff Layton wrote:
> > >=20
> > > > crash> delayed_work ffff8881601fab48
> > > > struct delayed_work {
> > > > =A0 work =3D {
> > > > =A0=A0=A0 data =3D {
> > > > =A0=A0=A0=A0=A0 counter =3D 1
> > > > =A0=A0=A0 },
> > > > =A0=A0=A0 entry =3D {
> > > > =A0=A0=A0=A0=A0 next =3D 0x0,
> > > > =A0=A0=A0=A0=A0 prev =3D 0x0
> > > > =A0=A0=A0 },
> > > > =A0=A0=A0 func =3D 0x0
> > > > =A0 },
> > > > =A0 timer =3D {
> > > > =A0=A0=A0 entry =3D {
> > > > =A0=A0=A0=A0=A0 next =3D 0x0,
> > > > =A0=A0=A0=A0=A0 pprev =3D 0x0
> > > > =A0=A0=A0 },
> > > > =A0=A0=A0 expires =3D 0,
> > > > =A0=A0=A0 function =3D 0x0,
> > > > =A0=A0=A0 flags =3D 0
> > > > =A0 },
> > > > =A0 wq =3D 0x0,
> > > > =A0 cpu =3D 0
> > > > }
> > >=20
> > > That looks more like a memory scribble or UAF. Merely having multiple
> > > tasks calling queue_work at the same time wouldn't be enough to trigg=
er
> > > this, IMO. It's more likely that the extra locking is changing the
> > > timing of your reproducer somehow.
> > >=20
> > > It might be interesting to turn up KASAN if you're able.
>=20
> I can try that.
>=20
> > If you still have this vmcore, it might be interesting to do the pointe=
r
> > math and find the nfsd_net structure that contains the above
> > delayed_work. Does the rest of it also seem to be corrupt? My guess is
> > that the corrupted structure extends beyond just the delayed_work above=
.
> >=20
> > Also, it might be helpful to do this:
> >=20
> > =A0=A0=A0=A0 kmem -s ffff8881601fab48
> >=20
> > ...which should tell us whether and what part of the slab this object i=
s
> > now a part of. That said, net-namespace object allocations are somewhat
> > weird, and I'm not 100% sure they come out of the slab.
>=20
> I tossed the vmcore, but can generate another.  I had done kmem sans -s
> previously, still have that.
>=20
> crash> kmem ffff8881601fab48
> CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
> kmem: kmalloc-1k: partial list slab: ffffea0005b20c08 invalid page.inuse:=
 -1
> ffff888100041840     1024       2329      2432     76    32k  kmalloc-1k
>   SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
>   ffffea0005807e00  ffff8881601f8000     0     32         32     0
>   FREE / [ALLOCATED]
>   [ffff8881601fa800]
>=20
>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
> ffffea0005807e80 1601fa000 dead000000000400        0  0 200000000000000
> crash
>=20

Thanks. The pernet allocations do come out of the slab. The allocation
is done in ops_init in net/core/namespace.c. This one is a 1k
allocation, which jives with the size of nfsd_net (which is 976 bytes).

So, this seems to be consistent with where an nfsd_net would have come
from. Maybe not a UAF, but I do think we have some sort of mem
corruption going on.
--=20
Jeff Layton <jlayton@kernel.org>
