Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88D67E851E
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 22:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjKJVfM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 16:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKJVfM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 16:35:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ED6A9
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 13:35:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785DDC433C8;
        Fri, 10 Nov 2023 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699652109;
        bh=eIgyY82OwovJKI6Ex0q8dKMP9zAG9LHvHO3dS2BkpjE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tBaGtw4RYyXhWJ64BBl2bLDQG1rUFNGSaoxsiH+Fss825FaDzIiHByyFPulH3yA7A
         FZb2g7IuAESxCpvWOkGDz/Eovjh9MKtU4BayifqMnGgQmO4VB37PEN+f53ak3dNsbf
         TKZbSy3QA608uDW6bvVwrxGYGGilkF3xG3fmsp7V1Kbhq+zUEPsoYLq3QpdEa6exzR
         hX0HhJysN/yARtxvvGv1Ixv0zdGPHq6Fo6oCZVJT0ggZKskW2XrSJWrMnFvo7T7qnN
         fgo1Oegdvso1Em3pwJhisMkuNHIo7AWq9hmTRapcYjUTP79nLGz8l8PsT7ryMCMM4u
         R+CZzIVHAuhkw==
Message-ID: <22cdd93c7a083fc4b6e6a1a02eeba174bcb8ca24.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix file memleak on client_opens_relaese
From:   Jeff Layton <jlayton@kernel.org>
To:     Mahmoud Adam <mngyadam@amazon.com>, chuck.lever@oracle.com
Cc:     neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org
Date:   Fri, 10 Nov 2023 16:35:07 -0500
In-Reply-To: <20231110182104.23039-1-mngyadam@amazon.com>
References: <20231110182104.23039-1-mngyadam@amazon.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-11-10 at 19:21 +0100, Mahmoud Adam wrote:
> seq_release should be called to free the allocated seq_file
>=20
> Cc: stable@vger.kernel.org # v5.3+
> Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4045c852a450..40415929e2ae 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2804,7 +2804,7 @@ static int client_opens_release(struct inode *inode=
, struct file *file)
>=20
>  	/* XXX: alternatively, we could get/drop in seq start/stop */
>  	drop_client(clp);
> -	return 0;
> +	return seq_release(inode, file);
>  }
>=20
>  static const struct file_operations client_states_fops =3D {
> --
> 2.40.1

Reviewed-by: Jeff Layton <jlayton@kernel.org>
