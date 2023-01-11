Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153E76659EB
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 12:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjAKLVK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 06:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjAKLU0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 06:20:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566A17051
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 03:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673435984; bh=dubC0wQ7DS4idEJ+dnNiASsilSxcDXaXpxb6WdBF8dk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=MBv4Mby+bpxfqOuFPaLwpCThKK9AKvCobIksHbTfrDRznbPCQie9EWfm2hBbBoglm
         uMAdmHdX/U+HFyHJN7xdiBfPlzt2LNgmWSVzI0UE7efWLT8NRzNTACdA9pbitkGRWd
         XC/qeFvzDww4ZoGz7u5R1i0EXSBk61isOGsGu5bDMGcgm5l3lAP2p81qvqefU0YRnM
         yNfWZj1Bg5sxuAQ+DMgW4yzREHNS/T9pthD6KNamA2Xyb5DOylzY+PCAH1FTiJw30r
         au27RxRf18OP+B9MwT+Rmop/cOcJb1sTWCDhcDBLW2mA12D7F93qH6yeXSoyFTNSb9
         rKf0QvKOb3fEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1oaic009MS-00ev7E; Wed, 11
 Jan 2023 12:19:44 +0100
Message-ID: <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Mike Galbraith <efault@gmx.de>
To:     Jeff Layton <jlayton@kernel.org>, dai.ngo@oracle.com,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 12:19:43 +0100
In-Reply-To: <2067b4b4ce029ab5be982820b81241cd457ff475.camel@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cnbduTp1j/tX412NbVc8ObxHtN9HvfwsrOsj8SrLkrgldRwKYB3
 trULjkHy04Nu6uUyK/iNWsuP+BYVjzPzUb0+aIIlj56ZtFSM9omppMh8sFpXoRcJau9c2uy
 flZHuUCbXGCnY7iHHKZu1HgYObRP6ZbvRnxvEdTalsDOcnxJ4LvomIsCJWrBzrEN7/t1sNi
 Zzwlauey7vfXg3UcQ4+EA==
UI-OutboundReport: notjunk:1;M01:P0:8p17egdBOlw=;HPn6JfCRaTM1TWuzvbu9/SJyezc
 +3ZkogOk93qFpmtEhMPIxi9h3yIHGVcr6bdUxL4IUcp2BtQvFNoUCRoST1to8BaB9ZPuAA7JW
 58lOYSyWfB/ChUPvnLNSZNsjogKEorg7PZd9hYkfQIjduijgAmugk4QXiP5iAfdHJxv7E1Rt0
 71K2iiyRW2cFjfxSHSerEynJGzHch8hAV24vbej9wuKrwBrakmRVyJgDoxO223SYwHlx4DeHe
 NoXejlwc6VAXL6NaCh+vOaGnnSrNzIphBEJeO1dGtsxSSvCfZr9zQt5DYqAnpjhao2G0Y1xpG
 qFbvf3Y7gU0HqtnMnT9hn1XAjHijzRAjWtOFs1T/bk9r/YSjyAtFCzm0BX1OoDOnmkadNnd4k
 I/DVPnCBriPbhafPVCC3wRIXh9lVUVwpA5NgO71I8+QjX4ndEIHBGPnAdUtDhZb+7RXq7tFEK
 /TzvAn3o7wTrudgBHw2tuZmmMd9evxhivbBQMWviR7W6EAzCxXWFuaBCVFsTdHrI1K0IwVb6R
 i0XUPdlJ46FMC+an1j2xmGnqO9d9pXje3svw81BmMZVi5XRo7C7ep8wJvmT5H0UQTNrlsRCtK
 edS1rAz5GuIvqc3QRLXF/ysq69b/ZITRo/XaiZScmkU+QTQ+bq7C277gCKB90lqwtJre8FHTc
 rPWa6n+6ov3rJZAS5GY3TYrfEDEqLf1ATo7t7NzoNjm4mPvfyCO6u47bRc4GeM7GcovHiev5D
 9gS8mWAJTk1PHHZe9z8rP8i4gx4cPB/V0rEnamezN+kZEIomRJv+bjM7KMb5mWM6TAqI2Aqm/
 w8zfASc+1zUeFgljbxPM4iNK9BdHV9v7WLmtQIeVPEjTbNW9y7tB7TFheeIi+1V+/F5CwXLAs
 2gOygSuz1h4HHzNmwCD9ZbPqgRHG+I82mHBo+M03vejsM+vNU5cSgdCRClQvL54XIK1lKdgzt
 UnChgNds2U8YwTOg5GHPgF3J7Z4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 05:55 -0500, Jeff Layton wrote:
> >
> > > crash> delayed_work ffff8881601fab48
> > > struct delayed_work {
> > > =C2=A0 work =3D {
> > > =C2=A0=C2=A0=C2=A0 data =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter =3D 1
> > > =C2=A0=C2=A0=C2=A0 },
> > > =C2=A0=C2=A0=C2=A0 entry =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D 0x0,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prev =3D 0x0
> > > =C2=A0=C2=A0=C2=A0 },
> > > =C2=A0=C2=A0=C2=A0 func =3D 0x0
> > > =C2=A0 },
> > > =C2=A0 timer =3D {
> > > =C2=A0=C2=A0=C2=A0 entry =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D 0x0,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pprev =3D 0x0
> > > =C2=A0=C2=A0=C2=A0 },
> > > =C2=A0=C2=A0=C2=A0 expires =3D 0,
> > > =C2=A0=C2=A0=C2=A0 function =3D 0x0,
> > > =C2=A0=C2=A0=C2=A0 flags =3D 0
> > > =C2=A0 },
> > > =C2=A0 wq =3D 0x0,
> > > =C2=A0 cpu =3D 0
> > > }
> >
> > That looks more like a memory scribble or UAF. Merely having multiple
> > tasks calling queue_work at the same time wouldn't be enough to trigge=
r
> > this, IMO. It's more likely that the extra locking is changing the
> > timing of your reproducer somehow.
> >
> > It might be interesting to turn up KASAN if you're able.

I can try that.

> If you still have this vmcore, it might be interesting to do the pointer
> math and find the nfsd_net structure that contains the above
> delayed_work. Does the rest of it also seem to be corrupt? My guess is
> that the corrupted structure extends beyond just the delayed_work above.
>
> Also, it might be helpful to do this:
>
> =C2=A0=C2=A0=C2=A0=C2=A0 kmem -s ffff8881601fab48
>
> ...which should tell us whether and what part of the slab this object is
> now a part of. That said, net-namespace object allocations are somewhat
> weird, and I'm not 100% sure they come out of the slab.

I tossed the vmcore, but can generate another.  I had done kmem sans -s
previously, still have that.

crash> kmem ffff8881601fab48
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
kmem: kmalloc-1k: partial list slab: ffffea0005b20c08 invalid page.inuse: =
-1
ffff888100041840     1024       2329      2432     76    32k  kmalloc-1k
  SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
  ffffea0005807e00  ffff8881601f8000     0     32         32     0
  FREE / [ALLOCATED]
  [ffff8881601fa800]

      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffea0005807e80 1601fa000 dead000000000400        0  0 200000000000000
crash

