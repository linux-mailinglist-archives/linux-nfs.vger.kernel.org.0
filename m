Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65C75BB29
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 01:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGTX3P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 19:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGTX3O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 19:29:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5CE42;
        Thu, 20 Jul 2023 16:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F030F61CBF;
        Thu, 20 Jul 2023 23:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E5EC433C7;
        Thu, 20 Jul 2023 23:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689895752;
        bh=FBRMNF5I6c7w2m0N0Qw0cnxF2xCKVBofbDpq3pMBudA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXteqS3LeqyAtr2qWkfVUyU6wBM0+vsAFXX8mGqSkRIY2DVyWtJMwMBQdf1nxLnvJ
         jzk/u8xf1aNmcna3ay0n23I/E+GT7nX+i251Yys+w12scnZXVk6JzJxRH9u2NHHSlH
         aQfw7LQbkJilGTUBLFpw0ZdqxLboLR4PlhutP2VmKU5RH8iiGb4D8uUR0TEeXBW8cL
         1qHrZNLBZVWfvlQXnKOTu1NlU6NsyU2BKSqE3X0kjUGedEOWZc2jydyNdAjAcLzhd9
         qGJwUW00KtOvm8A+PnmaU9aBFqNcKl3JpRcpPX8Ek+ZatTyTVFyH7ytDRIzkVk6NnK
         cj6MyASOM8jdw==
Date:   Thu, 20 Jul 2023 19:29:09 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: add a MODULE_DESCRIPTION
Message-ID: <ZLnDRd0iiU1z3Y+y@manet.1015granger.net>
References: <20230720133454.38695-1-jlayton@kernel.org>
 <168989083691.11078.1519785551812636491@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168989083691.11078.1519785551812636491@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 21, 2023 at 08:07:16AM +1000, NeilBrown wrote:
> On Thu, 20 Jul 2023, Jeff Layton wrote:
> > I got this today from modpost:
> > 
> >     WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfsd/nfsd.o
> > 
> > Add a module description.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfsctl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 1b8b1aab9a15..7070969a38b5 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1626,6 +1626,7 @@ static void __exit exit_nfsd(void)
> >  }
> >  
> >  MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> > +MODULE_DESCRIPTION("The Linux kernel NFS server");
> 
> Of 9176 MODULE_DESCRIPTIONs in Linux, 21 start with "The ".
> Does having that word add anything useful?
> Amusingly 129 end with a period.  I wonder what Jon Corbet would prefer
> :-) 

The Ohio State University has set a bad precedent.

I think we can drop "The".


> A few tell us what the module does.
> "Measures" "Provides"....
> Do we want "Implements" ??

I don't find "Implements" to be either conventional or illuminating.


> 232 start "Driver " and 214 are "Driver for"....
> Should we have "Server for" ??
> 
> 26 start "Linux" ... which seems a bit redundant
>   12 contain "for Linux".  67 mention linux in some way.
> 28 contain the word "kernel" - also redundant.
> Only three (others) mention "Linux kernel"

One of which is the new in-kernel SMB server, interestingly.

I don't think "Linux kernel" or even "in-kernel" is needed here.
Both should be obvious from the context.


> drivers/pcmcia/cs.c:MODULE_DESCRIPTION("Linux Kernel Card Services");
> fs/ksmbd/server.c:MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
> fs/orangefs/orangefs-mod.c:MODULE_DESCRIPTION("The Linux Kernel VFS interface to ORANGEFS");
> 
> hmmm..  192 contain the word "module".  Fortunately none say 
>   "Linux kernel module for ..."
> I would have found that to be a step too far.
> 
> I'd like to suggest
> 
>   "Implements Server for NFS - v2, 3, v4.{0,1,2}"
> 
> But that would require excessive #ifdef magic to get right.

"Network File System server" works for me.


> A small part of me wants to suggest:
> 
>    "nfsd"
> 
> but maybe I'm just in a whimsical mood today.

I'm resisting the urge to add "RFCs 1813, 7530, 8881, et al."
Whimsy, indeed. ;-)


> NeilBrown
> 
> 
> >  MODULE_LICENSE("GPL");
> >  module_init(init_nfsd)
> >  module_exit(exit_nfsd)
> > -- 
> > 2.41.0
> > 
> > 
> 
