Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D4775C4A8
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGUK1y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGUK1x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 06:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704FCB4;
        Fri, 21 Jul 2023 03:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1AE60B9B;
        Fri, 21 Jul 2023 10:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394E1C433C8;
        Fri, 21 Jul 2023 10:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689935271;
        bh=trc8rDm0x4iapbsu60Wv2djk+UWxWUQYIN5XQ8NON6U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XqnCpI6HAWSgf1Z5tkn45HPZO7yXqWSUSDteeF6T7u9zqrD5nlGgSk/+9+8t9bVuq
         0Nzx0z79GR6T6/ziEWJWM/IZr4nEl0V96VTJp+RqzV3mmuLdsCzS2rEFoIAOELkS0J
         B+TR6BJOuEtiJfLkx0tWQfvXPwRCZr5wRtbuoebkPlEwgaLiEBQ41jIJehw9IuzmDl
         3JM6CHNrdqyN8MJGCYspWNB7MdbGSqw/zSr6bQM6Y45qxc60ZAAoydOzZaDkPj2NYv
         TISao+zj7ppSgEqGx1hZsMzR/vMUnjeqo8eFNGnktjmwSPqBHMkxwjTAriILySqyFI
         IRneC7QZovUrg==
Message-ID: <b6b4b7888cf0a82ee7332be0f434aa749d029f92.camel@kernel.org>
Subject: Re: [PATCH] nfsd: add a MODULE_DESCRIPTION
From:   Jeff Layton <jlayton@kernel.org>
To:     Tom Talpey <tom@talpey.com>, Chuck Lever <cel@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Jul 2023 06:27:49 -0400
In-Reply-To: <f188db26-fb30-4f4b-8bf9-f975bd718605@talpey.com>
References: <20230720133454.38695-1-jlayton@kernel.org>
         <168989083691.11078.1519785551812636491@noble.neil.brown.name>
         <ZLnDRd0iiU1z3Y+y@manet.1015granger.net>
         <f188db26-fb30-4f4b-8bf9-f975bd718605@talpey.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-07-20 at 20:00 -0400, Tom Talpey wrote:
> Personally I like Jeff's text. There's zero need to overthink this.
>=20

It's like this patch was tailor-made for bikeshedding. ;)

Personally, I'm fine with any reasonable string here. My main concern
was just to silence the warning.

> Jul 20, 2023 7:30:34 PM Chuck Lever <cel@kernel.org>:
>=20
> > On Fri, Jul 21, 2023 at 08:07:16AM +1000, NeilBrown wrote:
> > > On Thu, 20 Jul 2023, Jeff Layton wrote:
> > > > I got this today from modpost:
> > > >=20
> > > > =A0=A0=A0 WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfsd=
/nfsd.o
> > > >=20
> > > > Add a module description.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > fs/nfsd/nfsctl.c | 1 +
> > > > 1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > index 1b8b1aab9a15..7070969a38b5 100644
> > > > --- a/fs/nfsd/nfsctl.c
> > > > +++ b/fs/nfsd/nfsctl.c
> > > > @@ -1626,6 +1626,7 @@ static void __exit exit_nfsd(void)
> > > > }
> > > >=20
> > > > MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> > > > +MODULE_DESCRIPTION("The Linux kernel NFS server");
> > >=20
> > > Of 9176 MODULE_DESCRIPTIONs in Linux, 21 start with "The ".
> > > Does having that word add anything useful?
> > > Amusingly 129 end with a period.=A0 I wonder what Jon Corbet would pr=
efer
> > > :-)
> >=20
> > The Ohio State University has set a bad precedent.
> >=20
> > I think we can drop "The".
> >=20
> >=20
> > > A few tell us what the module does.
> > > "Measures" "Provides"....
> > > Do we want "Implements" ??
> >=20
> > I don't find "Implements" to be either conventional or illuminating.
> >=20
> >=20
> > > 232 start "Driver " and 214 are "Driver for"....
> > > Should we have "Server for" ??
> > >=20
> > > 26 start "Linux" ... which seems a bit redundant
> > > =A0 12 contain "for Linux".=A0 67 mention linux in some way.
> > > 28 contain the word "kernel" - also redundant.
> > > Only three (others) mention "Linux kernel"
> >=20
> > One of which is the new in-kernel SMB server, interestingly.
> >=20
> > I don't think "Linux kernel" or even "in-kernel" is needed here.
> > Both should be obvious from the context.
> >=20
> >=20
> > > drivers/pcmcia/cs.c:MODULE_DESCRIPTION("Linux Kernel Card Services");
> > > fs/ksmbd/server.c:MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
> > > fs/orangefs/orangefs-mod.c:MODULE_DESCRIPTION("The Linux Kernel VFS i=
nterface to ORANGEFS");
> > >=20
> > > hmmm..=A0 192 contain the word "module".=A0 Fortunately none say
> > > =A0 "Linux kernel module for ..."
> > > I would have found that to be a step too far.
> > >=20
> > > I'd like to suggest
> > >=20
> > > =A0 "Implements Server for NFS - v2, 3, v4.{0,1,2}"
> > >=20
> > > But that would require excessive #ifdef magic to get right.
> >=20
> > "Network File System server" works for me.
> >=20
> >=20
> > > A small part of me wants to suggest:
> > >=20
> > > =A0=A0 "nfsd"
> > >=20
> > > but maybe I'm just in a whimsical mood today.
> >=20
> > I'm resisting the urge to add "RFCs 1813, 7530, 8881, et al."
> > Whimsy, indeed. ;-)
> >=20
> >=20
> > > NeilBrown
> > >=20
> > >=20
> > > > MODULE_LICENSE("GPL");
> > > > module_init(init_nfsd)
> > > > module_exit(exit_nfsd)
> > > > --=20
> > > > 2.41.0
> > > >=20
> > > >=20
> > >=20

--=20
Jeff Layton <jlayton@kernel.org>
