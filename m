Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6816E3334
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDOSkW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 14:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDOSkV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 14:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D81540E9
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 11:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 378D760ACA
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 18:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAF6C433EF;
        Sat, 15 Apr 2023 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681584019;
        bh=t0d3Jtqi7qC7gOrYaTD21h/Lsg8jSHo4v7B/bWWXS8w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H61BKNPUNW7dyUNLaTZFeZs1GXTsCNm+q3OVuDOtOBo/mQ+GzKECkNS61/pBOxj2L
         pMoQSR3u4Lq9Vl0kW2xywa+Ri2+4WUCjkTOOrbZVbxcQWTzvkbyLOLVpy731h0/dJi
         aN+gAWIKzYalXunnK83aCI/FVbwHraeKKbsM6Hlz4Yxvy08pPaoOHm9Be8ZWTFj5Bk
         5QzxCVz0qrPvzMGsY+DvmmR5ENREwIIcE995+cqAZHOZx4el0HLLP9LTIGnguDonbf
         XBmmMsBe+D8QkoppwUZ9idvH98EIDjhFkRDBaSH+tB+Ywf7gMKt/UuAfB0JuxHHrbB
         I0+BJtxJn2joA==
Message-ID: <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
From:   Jeff Layton <jlayton@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Sat, 15 Apr 2023 14:40:17 -0400
In-Reply-To: <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
         <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
         <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
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

On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
> On 2023/04/16 1:13, Chuck Lever III wrote:
> > > On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.SAKU=
RA.ne.jp> wrote:
> > >=20
> > > Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP_=
NOFS
> > > does not make sense. Drop __GFP_FS flag in order to avoid deadlock.
> >=20
> > The server side threads run in process context. GFP_KERNEL
> > is safe to use here -- as Jeff said, this code is not in
> > the server's reclaim path. Plenty of other call sites in
> > the NFS server code use GFP_KERNEL.
>=20
> GFP_KERNEL memory allocation calls filesystem's shrinker functions
> because of __GFP_FS flag. My understanding is
>=20
>   Whether this code is in memory reclaim path or not is irrelevant.
>   Whether memory reclaim path might hold lock or not is relevant.
>=20
> . Therefore, question is, does nfsd hold i_rwsem during memory reclaim pa=
th?
>=20

No. At the time of these allocations, the i_rwsem is not held.

> >=20
> > But I agree that the flag combination doesn't make sense.
> > Maybe drop GFP_NOFS instead and call it only a clean-up?
>=20

Yeah, I think that's the right thing to do here.

--=20
Jeff Layton <jlayton@kernel.org>
