Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94278F036
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjHaPYg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346559AbjHaPYg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 11:24:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C8E64
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 08:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E63CFB82338
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 15:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B09C433CD;
        Thu, 31 Aug 2023 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693495456;
        bh=ABJe0LgB6c63oC0SlohD9psbv2Dul4MB3oKtWN8WXL8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BOot/aH7Bhu/KeYOD+uly1cP9KIJAWJaD5nbOAtTZejDvBjwLHwMxpf8p2F0zq3Ov
         LQTp+aSYeJOcgfVLJJjd7tbsBbsw5Cqpnhz2LAj5I2Tq0SS+T5Ny3x3ixGgWQiV5Cd
         N/8U+CEunF+nZGbapv7AZ48chi7sTL9gRVHUA8JjpKcJqWHs8/CVNdsj5xZM/C5Jkm
         qaoVORQZwFqtW25mC67hzuFgqxQE4YWPCzNdlSSrx648mszgZwiDlajp22FhYjZekY
         6Dss56Jma8PPvdWeQ9pZonETbu1sTcMbSDVV2oi/XwfHgGjOSkIyN+WZjfL5xhDitw
         agJV9kVD5kaxQ==
Message-ID: <21c3596d1ca9bbe6b73532d7b2e0c306871cf4ed.camel@kernel.org>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org,
        linux-nfs@vger.kernel.org
Date:   Thu, 31 Aug 2023 11:24:14 -0400
In-Reply-To: <6BE9526F-51FE-4CD9-AE95-EE69F7F0CAA6@redhat.com>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
         <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
         <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
         <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
         <6BE9526F-51FE-4CD9-AE95-EE69F7F0CAA6@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-08-31 at 11:17 -0400, Benjamin Coddington wrote:
> On 30 Aug 2023, at 17:14, Jeff Layton wrote:
>=20
> > On Wed, 2023-08-30 at 20:20 +0000, Trond Myklebust wrote:
> > > On Wed, 2023-08-30 at 16:10 -0400, Jeff Layton wrote:
> > > > On Wed, 2023-08-30 at 15:42 -0400, Benjamin Coddington wrote:
> > > > > Again we have claimed regressions for walking a directory tree,
> > > > > this time
> > > > > with the "find" utility which always tries to optimize away askin=
g
> > > > > for any
> > > > > attributes until it has a complete list of entries.=A0 This behav=
ior
> > > > > makes
> > > > > the readdir plus heuristic do the wrong thing, which causes a sto=
rm
> > > > > of
> > > > > GETATTRs to determine each entry's type in order to continue the
> > > > > walk.
> > > > >=20
> > > > > For v4 add the type attribute to each READDIR request to include =
it
> > > > > no
> > > > > matter the heuristic.=A0 This allows a simple `find` command to
> > > > > proceed
> > > > > quickly through a directory tree.
> > > > >=20
> > > >=20
> > > > The important bit here is that with v4, we can fill out d_type even
> > > > when
> > > > "plus" is false, at little cost. The downside is that non-plus
> > > > READDIR
> > > > replies will now be a bit larger on the wire. I think it's a
> > > > worthwhile
> > > > tradeoff though.
> > >=20
> > > The reason why we never did it before is that for many servers, it
> > > forces them to go to the inode in order to retrieve the information.
> > >=20
> > > IOW: You might as well just do readdirplus.
> > >=20
> >=20
> > That makes total sense, given how this code has evolved.
> >=20
> > FWIW, the Linux NFS server already calls vfs_getattr for every dentry i=
n
> > a v4 READDIR reply regardless of what the client requests. It has to in
> > order to detect junctions, so we're bringing in the inode no matter
> > what. Fetching the type is trivial, so I don't see this as costing
> > anything extra there.
> >=20
> > Mileage could vary on other servers with more synthetic filesystems, bu=
t
> > one would hope that most of them can also return the type cheaply.
>=20
> It occurred to me that we could let those other server folks ask for
> whatever attributes they wanted if we make it tunable at runtime:
>=20
> https://lore.kernel.org/linux-nfs/8f752f70daf73016e20c49508f825e8c2c94f5e=
7.1693494824.git.bcodding@redhat.com/T/#u
>=20

That's a possibility, but I probably wouldn't add tunables for this
until the need was more clear.
--=20
Jeff Layton <jlayton@kernel.org>
