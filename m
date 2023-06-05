Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B1D722745
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jun 2023 15:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjFENWt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjFENWr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 09:22:47 -0400
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 06:22:37 PDT
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5360A6
        for <linux-nfs@vger.kernel.org>; Mon,  5 Jun 2023 06:22:37 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 08E627167; Mon,  5 Jun 2023 09:15:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 08E627167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1685970938;
        bh=ijHctTfUlZwAYhetQ28VVCBo5dyq1Hp/SvjV2n6S2wQ=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=HAFZvhZIIKPQoz/vF+fAaqQ0rQfqCKwh6uGHa+Q4RR4aeF1aHiZ3K1WJDPn32r3O9
         KHZe/coKJ/EwLV5mK+QFxlNMmqGLN0+IHTjRfudWLDo45qFium9lH/6cZUI18aItca
         NnzBb1qLjvG6P4X5Zi07NekKZPpnFTDxwWSJ5+IM=
Date:   Mon, 5 Jun 2023 09:15:38 -0400
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/2] mailmap: Add Bruce Fields' latest e-mail addresses
Message-ID: <20230605131538.GB2984@fieldses.org>
References: <168597075880.7827.6268299078653725756.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168597075880.7827.6268299078653725756.stgit@manet.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 05, 2023 at 09:12:38AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Ensure that Bruce's old e-mail addresses map to his current one so
> he doesn't miss out on all the fun.

OK with me.--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  .mailmap |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index bf076bbc36b1..0f2458442ea2 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -181,6 +181,8 @@ Henrik Rydberg <rydberg@bitmath.org>
>  Herbert Xu <herbert@gondor.apana.org.au>
>  Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
>  Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
> +J. Bruce Fields <bfields@fieldses.org> <bfields@redhat.com>
> +J. Bruce Fields <bfields@fieldses.org> <bfields@citi.umich.edu>
>  Jacob Shin <Jacob.Shin@amd.com>
>  Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
>  Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
> 
