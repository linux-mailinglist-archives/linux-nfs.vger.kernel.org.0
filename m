Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DE653B64
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 05:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLVEod (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Dec 2022 23:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVEoc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Dec 2022 23:44:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAD21A204;
        Wed, 21 Dec 2022 20:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671684266; bh=mSeQo5HD6mm53XVJ7wzrrTx/ANQPLgJs/zlmqz1os+Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=iVh/hulKQDt9Y8D++LiH6897M99Dpxlct7q+sR+mjsJ24076OFXzC5tz8sh18dQrc
         r7SEHzb9gRskfMMdFVmkEo9lgJUgfUBPI2Vx4LH7qZ1GktT5/PTIPsBCfqAC5zd8xe
         COLHhiDxC+pqLQ9aISt5UCS0W2OM+4z/KuAL6tkbv8vA0IpqSXEUudeNv7a91Gmq8l
         wcCWmeiN42A3ZLsyluCEeJJfQblm+ZhO5y/tOTQoeWDGmFsBXFK3vCfD6kmP4Ig+U6
         ZbRr+MTwbtvjCOxJxeMT89M3KH3fUrDxZtx+TfxAtrVeFENrn06WQ8qpD7R8GaND8l
         fSTg/uBc7dSsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1ozfFl1Evf-00Ap3t; Thu, 22
 Dec 2022 05:44:26 +0100
Message-ID: <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 22 Dec 2022 05:44:25 +0100
In-Reply-To: <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
         <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
         <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
         <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
         <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zX4AtPJMSxHapawfaJ5LW8msY0KiDpItEQOIRMXxUMfoXTP0nSK
 XQ5SdLxZoQ0CyVjzsbcw5cAeqb5d7+/e07mqZOoofLMUwxq2WA/LqDPNwCbp06pF8RBMHZ+
 pPVCgUZa0A+1AGiKI79fTgBP5NVBDdGyxAj8VH3jVxCNaqvlx/aBmQcMBFTVcYr2YgoposP
 n4iIji/SxpjEkq/MF+Kag==
UI-OutboundReport: notjunk:1;M01:P0:DMZZOEW2BCo=;Y+DP8BZtE3rTL3IOMC4eI1f4v3i
 8fjzzmmSwvkNdHyuTFAGM5bL2D2V3mMB9zVEm/kNqpctkOLcKmHqad65IEU3F3xb59L1laMzB
 57z4+5ScgGaAoJ/fFi3RpI5uP1Nw1rwsDmDyHWR/Qz6rvFnRXLSOHn/m6eofiSofqWSwQZe0i
 5sZ2Fgx2Xyx2BcXiejQANzKAcnMUirgMjES3S0tBZTcy7j7BSzWJZqc5PJziwTNbHtKnOcId7
 Vy4wflcJY665cI5SMqmIUiQ6V5igOVFf1XhGLAyhEWARkjBxWccS6GfMKFfG+LV88T7moRQd7
 y23ug80Dd86nvEz4au/QnW83Q9edwn9Mw4PqBOzI1felBBRbpRHEt6dnghensldHhwb0KovsJ
 03IZ45zY6Tv4WQbGa7/yaxixVXq4bisaUk6fCrnTw5QFGzPuYfUP3n47vhKaOML69NWgCWYzE
 BtlVdJtYd7uRu2rFyibvOux/pu9CKjnZLPyzFkMmd1yWEVZMCtHPgoXd0nhAopJTzTr9c+PAl
 uaDtJj2S/iNEjuF+hRGrw7Sf30mCfpAqEqhAvnn6YHewZ7KYX6O1JYTpUuOnrKLgIBHTodioT
 m/FmtghyAWb4N8vL/F2JafwCmPpwpJEZoqRSAfjISaG/cNrWrBEXQGiT+n5y39jtc6v//BnJZ
 y6j1d2rmr9JTHv9ufYpFUzB2P32MYq4ihHjwtrLDMovCBsGRB7kCuGeSBAtTebvVPLPaxoWiN
 Ukf6dZbJrQww4fO6pqkLnJEmtavNRu6XiaYQ2tWZ1PNHq1MgAw+bzCm+yWhIlzoPsbroU/bDc
 PXBL0smyF2IbKAeGRZ4vjGEoH6kQ+Pouo45fF+BiwtFb0m+WzHn/YmFicJpK75rHmnpu8P/rJ
 9UaY/5TNe+vpSktrqR3uHoHFe+BsJummRBkQNBuFLjTxHJtUGuHg3aRYxshCb1C/OFkiqUNMZ
 pNgLqkbhuu+eV+qWY8prUNqgWLk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-12-22 at 04:28 +0000, Chuck Lever III wrote:
>
> Hi Mike-

Greetings,

> I'm guessing your client mounts with NFSv4.x.

Yes, mount says vers=3D4.2.

> We've been chasing a similar problem for a few months, but for
> lack of a solid reproducer, it has remained elusive.
>
> We believe the problem was introduced between 5.19 and 6.0. If
> you have a fairly reliable way to trigger the server hang, then
> maybe a bisect would be possible?

The 'solid' reproducer attribute is a bit of a problem, why I was
taking potshots at it.  I'll try to sneak up on it.

	-Mike
