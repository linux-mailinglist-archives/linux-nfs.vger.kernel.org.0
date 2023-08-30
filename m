Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0D78E240
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 00:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbjH3WVW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 18:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbjH3WVL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 18:21:11 -0400
X-Greylist: delayed 3544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 15:20:47 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71234CEC
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 15:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CDF7B81FB1
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 21:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FF7C433C9;
        Wed, 30 Aug 2023 21:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693430077;
        bh=NWm+iqazdq6J0gVimozaTYaP8WzA44yR7XF7B/Lt9R4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MuC75K495bEoYbE01sFC/2AfmeBk64z/lPQ3bCIFsYd85XjUii+yAskXqpuAqDOEe
         C+46BCkUtXAOQhgbBQIIuGFe+TrextO7W40bJt/Cf+HK9QvDVNWb965G5Db4WwSWTt
         ogtEjhOfcKUqNBX9Cc13PqHT9dTlFoFelI/JTdRyb1mmfP/JtdxP1gTXd+gGCbgODN
         5UjgneS5A7gRQGbAumnlNAKprjpt+4URMmea5hBFSNvLcDnUUOWtZ3+iSXCefFfqiH
         RAbT3D+54wP+I6lPDMuBI4Cu3nEsUCAZChcT/3Ka+qG2EO7k1IFz7z9O7rUS/F0NhQ
         DEhFIpTwV0D1A==
Message-ID: <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Wed, 30 Aug 2023 17:14:35 -0400
In-Reply-To: <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
         <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
         <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-08-30 at 20:20 +0000, Trond Myklebust wrote:
> On Wed, 2023-08-30 at 16:10 -0400, Jeff Layton wrote:
> > On Wed, 2023-08-30 at 15:42 -0400, Benjamin Coddington wrote:
> > > Again we have claimed regressions for walking a directory tree,
> > > this time
> > > with the "find" utility which always tries to optimize away asking
> > > for any
> > > attributes until it has a complete list of entries.=A0 This behavior
> > > makes
> > > the readdir plus heuristic do the wrong thing, which causes a storm
> > > of
> > > GETATTRs to determine each entry's type in order to continue the
> > > walk.
> > >=20
> > > For v4 add the type attribute to each READDIR request to include it
> > > no
> > > matter the heuristic.=A0 This allows a simple `find` command to
> > > proceed
> > > quickly through a directory tree.
> > >=20
> >=20
> > The important bit here is that with v4, we can fill out d_type even
> > when
> > "plus" is false, at little cost. The downside is that non-plus
> > READDIR
> > replies will now be a bit larger on the wire. I think it's a
> > worthwhile
> > tradeoff though.
>=20
> The reason why we never did it before is that for many servers, it
> forces them to go to the inode in order to retrieve the information.
>=20
> IOW: You might as well just do readdirplus.
>=20

That makes total sense, given how this code has evolved.

FWIW, the Linux NFS server already calls vfs_getattr for every dentry in
a v4 READDIR reply regardless of what the client requests. It has to in
order to detect junctions, so we're bringing in the inode no matter
what. Fetching the type is trivial, so I don't see this as costing
anything extra there.

Mileage could vary on other servers with more synthetic filesystems, but
one would hope that most of them can also return the type cheaply.
--=20
Jeff Layton <jlayton@kernel.org>
