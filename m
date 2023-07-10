Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8874D742
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGJNTF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 09:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGJNTE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 09:19:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E10D7
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 06:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 218AC60FC6
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 13:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F24C433C7;
        Mon, 10 Jul 2023 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688995142;
        bh=FjcS3PI8JK3Qt8ZmXpHlHpkgfX582bwfnIoamCm2iJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LQxX8rNQnmrClKykBqxs4EAWi6f19nr9Xr4Ksz3UGVrEIAyT1+om4K+cUrsO02rj/
         KTbztyojn4mA7YNJrNRC07NGma4Q6p0RwdTFuzWG2GjCvk0toeO4vizImAMzRw6wiX
         +eL8sBOLkrA4mC+VqhWJO57ZNh4NqP7lUvsGS8jbor1PmrnXFUfftffZmvRsDRDIMf
         BEAJd6VXTZ4PAMOJv91Ny+w5U3sDOFOsUmCJVORYu9bnKfmbVksAbXMaQy9Z5U8YTW
         faQ/fMs4UvJHqkWBVIBp9OkzFBJp1900zvtDMUi4iPXFbjev/1q2wH/sGt9iLBour0
         Qymk4Yl3Hey6A==
Message-ID: <771c1753a11e6a31927d2bfabab67127b6d1b7ba.camel@kernel.org>
Subject: Re: [PATCH v1 0/6] Fix some lock contention in the NFS server's DRC
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 10 Jul 2023 09:19:01 -0400
In-Reply-To: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
References: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
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

On Sun, 2023-07-09 at 11:45 -0400, Chuck Lever wrote:
> This series optimizes DRC scalability by freeing cache objects only
> once the hash bucket lock is no longer held. There are a couple of
> related clean-ups to go along with this optimization.
>=20
> ---
>=20
> Chuck Lever (6):
>       NFSD: Refactor nfsd_reply_cache_free_locked()
>       NFSD: Rename nfsd_reply_cache_alloc()
>       NFSD: Replace nfsd_prune_bucket()
>       NFSD: Refactor the duplicate reply cache shrinker
>       NFSD: Remove svc_rqst::rq_cacherep
>       NFSD: Rename struct svc_cacherep
>=20
>=20
>  fs/nfsd/cache.h            |   8 +-
>  fs/nfsd/nfscache.c         | 203 ++++++++++++++++++++++++-------------
>  fs/nfsd/nfssvc.c           |  10 +-
>  fs/nfsd/trace.h            |  26 ++++-
>  include/linux/sunrpc/svc.h |   1 -
>  5 files changed, 165 insertions(+), 83 deletions(-)
>=20
> --
> Chuck Lever
>=20

This all looks like reasonable cleanup to me, regardless of whether it's
produces measurable optimization.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
