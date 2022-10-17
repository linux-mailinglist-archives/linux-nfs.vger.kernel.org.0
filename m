Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B391601D92
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 01:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJQXbW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 19:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJQXbV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 19:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F346D577
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 16:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55333612C9
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 23:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBEBC433B5;
        Mon, 17 Oct 2022 23:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666049479;
        bh=czCKdAmZPdeDKMzQZV36VvYe1RsZMl501z2FrM/Q7KQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a14+sGnu7B2cF40YghJ9CIP10kpCbywuLB1IUoOB8zXUVB/DFDsPl5MEbqYJis4b2
         C5McmS7cXUZnLG8VVwnZ75N1eGt5p0tmDL7j+a9DHUDgH5LMP2JXvPZ0iIRzR8iX/J
         c2nfMRQojyXVjD5ki96rInvjMLZ78HfUyz5Jkx1XIbAuc0oHBdx60psMQqMPu/aRc9
         7bOX+KeeV24QQcjXR0zwt2IlKc6AC3KySAwTjTYRi9vFZ/XnJNv5HRdWcjAFAlo327
         I8KXfYPIY7MsO5gWo+H95Y4zcp+pmb28i9CdDeaOuw1Ley73ub9bd2aZYYOfRM/06u
         5IuxC6i95iuqA==
Message-ID: <4e3af7be61b71fbfc98aab18faae0a0f9e268f56.camel@kernel.org>
Subject: Re: [PATCH] nfsd: remove weird compile-time conditional for EDQUOT
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Mon, 17 Oct 2022 19:31:17 -0400
In-Reply-To: <20221017204950.490306-1-jlayton@kernel.org>
References: <20221017204950.490306-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-17 at 16:49 -0400, Jeff Layton wrote:
> I don't see any other places in the kernel that test for this symbol
> before trying to use it. Remove the #ifdef.
>=20
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> This builds for me, but I'm on a "standard" arch (x86_64). I think we'll
> just have to put this in linux-next and see if any exotic arches or
> configurations barf on it.
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 27dd9ac992ee..bee6f4a32f3b 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -84,9 +84,7 @@ nfserrno (int errno)
>  		{ nfserr_mlink, -EMLINK },
>  		{ nfserr_nametoolong, -ENAMETOOLONG },
>  		{ nfserr_notempty, -ENOTEMPTY },
> -#ifdef EDQUOT
>  		{ nfserr_dquot, -EDQUOT },
> -#endif
>  		{ nfserr_stale, -ESTALE },
>  		{ nfserr_jukebox, -ETIMEDOUT },
>  		{ nfserr_jukebox, -ERESTARTSYS },

I did a bit more archaeology...

It looks like this #ifdef dates back to the original merge of nfsd into
the kernel in v2.1.32 (~Mar 10th 1997)!

I think we can safely dispense with it now that EDQUOT is a full-fledged
errno value and has been for ages.
--=20
Jeff Layton <jlayton@kernel.org>
