Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D55249F8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 12:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbiELKIJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 May 2022 06:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345766AbiELKII (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 May 2022 06:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B45553B41
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 03:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24D561B94
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 10:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B429EC34100;
        Thu, 12 May 2022 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652350083;
        bh=eAj6wE84IcEL+8ZeZUHsXs5vJSwy1gCcp/9Jn77ECWw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l9wVJdQVvnlcNtCyMAUEzQX3Gs80kQNOln5hTMiuQ5DnY1V9ByWaBIMpAU40XqTS3
         Y+FSol4ATAmFpDvrALSClc8hZpG+wB73ZTDT6WdDZdVCe/FcLypbiU9iNQIOfdGUHZ
         OKq7wMYCUbC8AlBB6xPuC11TgKXzjYMSJzhETrB2X71u8BttVt3eZWT6cjT21rVqhk
         V3kF0+qgoe+N62E2ZI4uaBZxy3A8pnwKhgDFAfOiuyFpjNmmeM4tE0Y03KH9T70TIo
         XB+VIK/Tet5t+dXBehizFa9IVJFgZCvS2g18s/gm9UnvTd9sCu3IJMVsdecDRO+Dio
         LJgz/dV4qaAaA==
Message-ID: <ddd64fbc1bfc6dc5ad7d0656dd38e686f556eae2.camel@kernel.org>
Subject: Re: [PATCH RFC 2/2] NFSD: nfsd_file_put() can sleep
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com, bfields@fieldses.org, dai.ngo@oracle.com
Date:   Thu, 12 May 2022 06:08:01 -0400
In-Reply-To: <165230597851.5906.18376771236120628748.stgit@klimt.1015granger.net>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
         <165230597851.5906.18376771236120628748.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-05-11 at 17:52 -0400, Chuck Lever wrote:
> Ensure the lockdep infrastructure can catch calls to nfsd_file_put()
> when spinlocks are held.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8f7ed5dbb003..60a5d82e59b3 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -301,6 +301,8 @@ nfsd_file_put_noref(struct nfsd_file *nf)
>  void
>  nfsd_file_put(struct nfsd_file *nf)
>  {
> +	might_sleep();
> +
>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>  	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0) {
>  		nfsd_file_flush(nf);
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
