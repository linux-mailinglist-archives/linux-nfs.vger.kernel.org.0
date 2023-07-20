Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB97975BA44
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGTWHc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 18:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGTWHb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 18:07:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20119B3;
        Thu, 20 Jul 2023 15:07:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A62D21DC2;
        Thu, 20 Jul 2023 22:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689890843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH0mag0dNrA3/nZZ/acE5Q2iSsRcVegnYHZodYGffs4=;
        b=prWEn9xRvLEtC+MfBzb6XEqwAzK57atOyC9LvVU07n9nSKxOPNyLFcwT/HMAwKwGwBOZzS
        gVwOrx0pLpzboQRaZBFDqkaCDM65AIhPs/UBmcwmPFJYv8OuQixMXCfzTVk6YB6+HhZRlE
        9WgmSe3NSZgdufrlyE4qmWWMzLzaFVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689890843;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH0mag0dNrA3/nZZ/acE5Q2iSsRcVegnYHZodYGffs4=;
        b=Z89wmJkUCylKd7agLmssa8NIJPa5g26qp7dQiKwGh8YGmZf5C3cOn9aE/DgtaWdrDjBGFR
        6wTfIgLdHhHXNqCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B9B5138EC;
        Thu, 20 Jul 2023 22:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GEMiBxiwuWSfSQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 20 Jul 2023 22:07:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: add a MODULE_DESCRIPTION
In-reply-to: <20230720133454.38695-1-jlayton@kernel.org>
References: <20230720133454.38695-1-jlayton@kernel.org>
Date:   Fri, 21 Jul 2023 08:07:16 +1000
Message-id: <168989083691.11078.1519785551812636491@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 20 Jul 2023, Jeff Layton wrote:
> I got this today from modpost:
>=20
>     WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfsd/nfsd.o
>=20
> Add a module description.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfsctl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1b8b1aab9a15..7070969a38b5 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1626,6 +1626,7 @@ static void __exit exit_nfsd(void)
>  }
> =20
>  MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> +MODULE_DESCRIPTION("The Linux kernel NFS server");

Of 9176 MODULE_DESCRIPTIONs in Linux, 21 start with "The ".
Does having that word add anything useful?
Amusingly 129 end with a period.  I wonder what Jon Corbet would prefer
:-)=20

A few tell us what the module does.
"Measures" "Provides"....
Do we want "Implements" ??

232 start "Driver " and 214 are "Driver for"....
Should we have "Server for" ??

26 start "Linux" ... which seems a bit redundant
  12 contain "for Linux".  67 mention linux in some way.
28 contain the word "kernel" - also redundant.
Only three (others) mention "Linux kernel"

drivers/pcmcia/cs.c:MODULE_DESCRIPTION("Linux Kernel Card Services");
fs/ksmbd/server.c:MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
fs/orangefs/orangefs-mod.c:MODULE_DESCRIPTION("The Linux Kernel VFS interface=
 to ORANGEFS");

hmmm..  192 contain the word "module".  Fortunately none say=20
  "Linux kernel module for ..."
I would have found that to be a step too far.

I'd like to suggest

  "Implements Server for NFS - v2, 3, v4.{0,1,2}"

But that would require excessive #ifdef magic to get right.

A small part of me wants to suggest:

   "nfsd"

but maybe I'm just in a whimsical mood today.

NeilBrown


>  MODULE_LICENSE("GPL");
>  module_init(init_nfsd)
>  module_exit(exit_nfsd)
> --=20
> 2.41.0
>=20
>=20

