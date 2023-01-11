Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9F6651EA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 03:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjAKCfT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 21:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjAKCez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 21:34:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0181A10B68
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 18:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673404442; bh=AB6tq5orjQhB85ZPUwhE3qneaW2atKxQ6x9Do7ARqq8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=s9xSSU2EJNCtzni0uREebKCpfvVqUNeg+bkb+PpaBzloRAH/n3Ortuu2ArbQ/flx6
         qk2WwskXDYqp5ock65cizQIR9AO6mkZL0vbsT8Zr98F+jN9J4fdt6Ba24n8Q0BtJqO
         Ee9T/09xR9OiDxP0nEuqbdpTss5c/M/vQJZ7T25zlFNBxCsWj56tYixpnycZzAm849
         lJoS080kHAlWPgd4WdujNEgv5i2cGXQP9pPL5wLvlE902f3OnSAa5VcIPrJ8gktIPJ
         iDebZ5dap5mB5jPokQoUjZnXU329V/YEA18Wr4CzdY3nL9+MF15n6FO0wnIzsIERSt
         bfw9DkpG4Mf2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4axq-1pDn2q258I-001fSi; Wed, 11
 Jan 2023 03:34:02 +0100
Message-ID: <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Mike Galbraith <efault@gmx.de>
To:     dai.ngo@oracle.com, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 03:34:01 +0100
In-Reply-To: <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
         <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
         <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gLandnX4wNzVUnGPujQYpdwWFNo8Z5ogdQNXiRpMIEaoQ5q6ALl
 F20CY8lkKLfXux3invazdGxR4UVLKN65GyQN3x7rcy7TH6rnlPZWdHvigdSeCU3r10Lq8ZL
 WaRihGYhXc2jGrCqclP1YZeDPslTKxiWrvBlAP4fR/TJ0NryLHC/x3dAGY9+6ZkkUXNZzb0
 WT/6vR9CykbKKGiJ05UQQ==
UI-OutboundReport: notjunk:1;M01:P0:qWyHOWdYr2s=;9UoFWjzluQTOxTdUUmQF8Ebokz+
 Zxf0MSqEaUWobMTzT1EcIKkI4mC5b5GruDH5qxTE36IiQqz3iVjVFx8fiGrs7eIo2jNBH4YWb
 hL7nxcuqmwJ5g8RNjfU2stDINfpet09qtFqNW0qReJ4x4XegJ5SfcpZk3iU7TnPNOR7iulKWa
 GrvOOjgL0awvoMKrrSF4wQgVWXmvVDA+HEB2G5h9WkxwnKH0vi2VlSVol2FNZgISg/XZa1X0H
 Mk1PiTXB5hKD6K+7zW7Cr3obypOzZtd6/psPoiiluSNkr+dTqOU5smqZTTas6t9B1WpplIaMG
 +FPLemb72aDKPYkk8TsWPC7hlO7jYdFw09MTjfWX91nb/KODOv2MamN0mAco9OHiUDyO0XofN
 0Lrop+C9dq5g6fR+364vHiFXbcXegvO3KnirUzDlZIp+me+khL3U2IWqmPtvC+S+Ok3upmgiL
 VjaP+wo/7Q6AxU1y7lO6VGTDrf8hHmzlhdJmxBi+xVT1/AEqSttTHgxi2d/7KtKmjtWG1y4sx
 bVot0zj1AbVaUpBQMHLS/hThPoPKOGfg9wngZjBT/YTf/c3LOYV3YqzVNlwvynPw6l/yg+Ayi
 fYJELMrMbCx2h4xiFln4g7180ESQgCfrBCRfN1vla+y0ePLSXn9kRNX4kU2ru08Ua/y949Wgl
 VME76caE7xKLUWKD/j+f+mXQEULI4D23YZw3Q03PfM9QleKOZSmU/LOT4AF++7wNAGEsHBY81
 Dojypl1/UmKM8RgvQ6fmW96BMw9zSd3gI03BsUKSjsJLfMNNx4AIozaIbS8F1g58XjDEtj1UT
 3AXHyxz+gvwBU54tpD8JGtguh3Nqvhz35WF5ff/6mM2W2yWEYyEbdtvhJ6oE432jSmaQG+gs1
 ALlPoRjap9NisCMjWrzxn6Ya7RPckKqdiRJd8W/TOCXjtd/ttJzYgpPiXoj+Wun2jdglD8F7e
 XywE90qSn04FLWLFTGnoH+iIRYo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-01-10 at 11:58 -0800, dai.ngo@oracle.com wrote:
>
> On 1/10/23 11:30 AM, Jeff Layton wrote:
>
> > >
> > >
> > Looking over the traces that Mike posted, I suspect this is the real
> > bug, particularly if the server is being restarted during this test.
>
> Yes, I noticed the WARN_ON_ONCE(timer->function !=3D delayed_work_timer_=
fn)
> too and this seems to indicate some kind of corruption. However, I'm not
> sure if Mike's test restarts the nfs-server service. This could be a bug
> in work queue module when it's under stress.

My reproducer was to merely mount and traverse/md5sum, while that was
going on, fire up LTP's min_free_kbytes testcase (memory hog from hell)
on the server.  Systemthing may well be restarting the server service
in response to oomkill.  In fact, the struct delayed_work in question
at WARN_ON_ONCE() time didn't look the least bit ready for business.

FWIW, I had noticed the missing cancel while eyeballing, and stuck one
next to the existing one as a hail-mary, but that helped not at all.

crash> delayed_work ffff8881601fab48
struct delayed_work {
  work =3D {
    data =3D {
      counter =3D 1
    },
    entry =3D {
      next =3D 0x0,
      prev =3D 0x0
    },
    func =3D 0x0
  },
  timer =3D {
    entry =3D {
      next =3D 0x0,
      pprev =3D 0x0
    },
    expires =3D 0,
    function =3D 0x0,
    flags =3D 0
  },
  wq =3D 0x0,
  cpu =3D 0
}
