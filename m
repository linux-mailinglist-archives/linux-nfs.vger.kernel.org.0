Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3600778F2EB
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjHaSxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 14:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjHaSxR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 14:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0CE64
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 11:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 494FF628EE
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 18:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A84C433C7;
        Thu, 31 Aug 2023 18:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693507993;
        bh=1l0zumi4lUK+xbSa8VN8XSv+blcHwNObmzA4g4b49aY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=h68xsVPlt7uFfYtAlm4AOsefoZlwOATgIay8uQ7cDfMJ3gp59X+OCTE0bW/k3SiQV
         kjKXPehcKaxuN8zipFKA5sG9MpxlpzcfE8xl1B7AWt3q5vbLsAmlbJqcUpBLmZC4RF
         7niNDZg1K0brd+/BB0nswawE2ei9jcujNs2QZm+9WrROLg0hxkfrXRl4hyrxBGbGOF
         49NC9ZHOAlp1AaIeV1mKBJSbgNTJ2qiBlsD6Lbj+ez7JRrz0okZr+NNSjnBWQ5fznA
         Lh4SG8xTCKCzf9fD2r/g/CpWjSCPICnYW4fsoHiyn2h/F5FTwNE0ru2kF+VnpAr1yW
         G5cidvgqZssDw==
Message-ID: <a596dba822bba0733434fd234d335d01289bd567.camel@kernel.org>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
From:   Jeff Layton <jlayton@kernel.org>
To:     Cedric Blancher <cedric.blancher@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Thu, 31 Aug 2023 14:53:12 -0400
In-Reply-To: <CALXu0UekEaGhj6+CHEeq22K3sTxTxMJn=5fg9J0PjKmzB+WVrg@mail.gmail.com>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
         <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
         <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
         <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
         <CALXu0UekEaGhj6+CHEeq22K3sTxTxMJn=5fg9J0PjKmzB+WVrg@mail.gmail.com>
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

On Thu, 2023-08-31 at 20:41 +0200, Cedric Blancher wrote:
> On Thu, 31 Aug 2023 at 02:17, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Wed, 2023-08-30 at 20:20 +0000, Trond Myklebust wrote:
> > > On Wed, 2023-08-30 at 16:10 -0400, Jeff Layton wrote:
> > > > On Wed, 2023-08-30 at 15:42 -0400, Benjamin Coddington wrote:
> > > > > Again we have claimed regressions for walking a directory tree,
> > > > > this time
> > > > > with the "find" utility which always tries to optimize away askin=
g
> > > > > for any
> > > > > attributes until it has a complete list of entries.  This behavio=
r
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
> > > > > matter the heuristic.  This allows a simple `find` command to
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
> Do you have examples for such synthetic filesystems?
>=20

Synthetic is probably the wrong distinction here, actually.

If looking up the inode type info is expensive, then you'll feel it here
more with this change. That's true regardless of whether this is a
"normal" or "synthetic" fs.

I wouldn't expect a big performance hit from the Linux NFS server given
that we'll almost certainly have that info in-core, but other servers
(ganesha? some commercial servers?) could take a hit here.
--=20
Jeff Layton <jlayton@kernel.org>
