Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE06BF944
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Mar 2023 11:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCRKEI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Mar 2023 06:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCRKEH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Mar 2023 06:04:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB10126DE
        for <linux-nfs@vger.kernel.org>; Sat, 18 Mar 2023 03:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0DE7B81145
        for <linux-nfs@vger.kernel.org>; Sat, 18 Mar 2023 10:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101DAC433D2;
        Sat, 18 Mar 2023 10:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679133843;
        bh=ttMjnlZIAQKXS/k1Z55MYcnLaA+u1DVSwJaT/uNXbu8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RXiDX6Uf2sjLQtdRxP1uw1gkNRMDBu78SGDjVLrxINWNuP8Wrr7YKfylImY2AjP1E
         +sTzxZjecwWZELJ61sifwk5WXuq4NUWUlzvi7Q/6DgGG8iLf3vOMvlal4qYOIgDf4E
         7qnQpOryln6Sb/fVjd4JZ2/RZPrQi0J9qy7msn6f+daHq/a1mPWfZW35hd1MyJeHX5
         LzY4XL2eLw3tNP2FvrnQAVs2Iqc2hAD/Zb/NCLMVzYhAFezm2RgdnMARYzNhEMN6bZ
         /5kUGN+iZfeP56ykrMpVeveGQEBUNWV8rw/uo4pY3t0CoD7YchtRVslytIxL3ovWAy
         wdzCdU/rPMCzQ==
Message-ID: <cf2ad1349a19b472653c500cc7e287843a0cb8c7.camel@kernel.org>
Subject: Re: [PATCH v1 0/3] rq_pages bounds checking
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, dcritch@redhat.com, d.lesca@solinos.it
Date:   Sat, 18 Mar 2023 06:04:01 -0400
In-Reply-To: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
References: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-03-17 at 19:01 -0400, Chuck Lever wrote:
> A slightly modified take on Jeff's earlier patches, tested with
> both NFSv3 and NFSv4.1 via simple fault injection in
> svc_rqst_replace_page().
>=20
> In general I'm in favor of more rq_pages bounds checking by
> replacing direct modification of the rq_respages and rq_next_page
> fields with accessor functions.
>=20
> ---
>=20
> Chuck Lever (2):
>       SUNRPC: add bounds checking to svc_rqst_replace_page
>       NFSD: Watch for rq_pages bounds checking errors in nfsd_splice_acto=
r()
>=20
> Jeff Layton (1):
>       nfsd: don't replace page in rq_pages if it's a continuation of last=
 page
>=20
>=20
>  fs/nfsd/vfs.c                 | 15 +++++++++++++--
>  include/linux/sunrpc/svc.h    |  2 +-
>  include/trace/events/sunrpc.h | 25 +++++++++++++++++++++++++
>  net/sunrpc/svc.c              | 15 ++++++++++++++-
>  4 files changed, 53 insertions(+), 4 deletions(-)
>=20
> --
> Chuck Lever
>=20

Looks good, Chuck, thanks. You can add this to the last two:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
