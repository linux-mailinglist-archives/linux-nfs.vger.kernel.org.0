Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737FD531D8C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiEWVQ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 17:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiEWVQB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 17:16:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBDD63BA
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 14:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DE18B8162F
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 21:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CD5C385AA;
        Mon, 23 May 2022 21:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653340557;
        bh=TYuQ4D99n0wp34u9KogOnbairlXFOr2wKFW0BS03Og8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GtIYd7Euludu53MDYJvzeeUWiZ2UlpU+fF4QH5WZ4knZWJmA9wdS3dO9Fasym75b0
         4QYfFwWdm1i6zS1om/GNF3+JLEbLHP90TOgAAjt5WjXlXWwLffVJVUe9ALhfMLF9oo
         Cyk24L+ybu9ge7K3p5xCs2GNvYEwzu7a92Ri1uTV+/84IZN/MzIGdh6Jf/EbzB2EF3
         v51jzV0I6yDoQ84aHLu3+e/wIq7VTZqnvGv6ZlsEM1bDoVoxG2hDdCXrAWy6l6ISGY
         n1RsaddEIYvZDWMfLgzoT3espDPLfWIGgHEJMslaYvz6noL9hMUQklzcjlLBXEzdDD
         Z2k7KJECYz1Lg==
Message-ID: <d2b1b7e58ff93b3bedaaf62a8fd3390faba3080e.camel@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 23 May 2022 17:15:55 -0400
In-Reply-To: <20220523202938.GJ24163@fieldses.org>
References: <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
         <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
         <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
         <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
         <93d11e12532f5a10153d3702100271f70373bce6.camel@hammerspace.com>
         <a719ae7e8fb8b46f84b00b27d800330712486f40.camel@kernel.org>
         <5dfbc622c9ab70af5e4a664f9ae03b7ed659e8ac.camel@hammerspace.com>
         <f12bf8be7c8fe6cf1a9e6a440277a3eb8edd543a.camel@kernel.org>
         <A67AA343-E399-44AB-AFE5-02B82B38E79E@oracle.com>
         <17007994486027de807d80dfde1a716c3d127de1.camel@kernel.org>
         <20220523202938.GJ24163@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-05-23 at 16:29 -0400, J. Bruce Fields wrote:
> On Mon, May 23, 2022 at 03:36:27PM -0400, Jeff Layton wrote:
> > The other lockowner _is_ involved. It's the one holding the conflicting
> > lock. nfs4_set_lock_denied copies info from the conflicting lockowner
> > into the LOCK/LOCKT response. That's safe now because it holds a
> > reference to the owner. At one point it wasn't (see commit aef9583b234a=
4
> > "NFSD: Get reference of lockowner when coping file_lock", which fixed
> > that).
>=20
> I doubt that commit fixed the whole problem, for what it's worth.  What
> if the client holding the conflicting lock expires before we get to
> nfs4_set_lock_denied?
>=20

Good point -- stateowners can't hold a client reference.

clientid_t is 64 bits, so one thing we could do is just keep a copy of
that in the lockowner. That way we wouldn't need to dereference
so_client in nfs4_set_lock_denied.

Maybe there are better ways to fix it though.
--=20
Jeff Layton <jlayton@kernel.org>
