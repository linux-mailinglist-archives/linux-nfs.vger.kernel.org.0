Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6362E74D6DC
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjGJNEc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGJNEM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 09:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F910C1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 06:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B72160DED
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 13:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C004C433C9;
        Mon, 10 Jul 2023 13:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688994187;
        bh=C7eEP8rJWSik+WcGWTwbTFtFikSjteQ+b+zppmeyZCc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iWvRuhgYwK4rBJ593pxehwCNx/W2EjJcJCvHiCIYzh3PcS56hc/g7nt4YRnCswOyz
         gdxyjbHplsuBC4bGO9NmorlDRyb6ZEaiOS0vkLNKxId/wGmxkDBgSk46k20pTBdaSE
         p6hs0ylkBs2w69nyEMR1pUxLvl9l2h86LXQlmv0xEHHLTQf4VoSg+fk8Cu2uqiy1o4
         5ZzM/NFHRuPp04J9JoA07o66Ie0Ma+ULoW22lcpKe+7SZ3a+WL2hXrL14MnY/jzBp8
         +mGIS3Q8i6EyhDwsaBg3Hw180U3qTSlDdVgPsRQHbH9gZwC7yawZ7Vc5sq5OzL92DZ
         Kmu9KG4uO5ivw==
Message-ID: <35ca6665f3cbedb60b904bfe4e74ca37c32af985.camel@kernel.org>
Subject: Re: [PATCH v1 0/6] Fix some lock contention in the NFS server's DRC
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 10 Jul 2023 09:03:06 -0400
In-Reply-To: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
References: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
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

On Sun, 2023-07-09 at 11:45 -0400, Chuck Lever wrote:
> This series optimizes DRC scalability by freeing cache objects only
> once the hash bucket lock is no longer held. There are a couple of
> related clean-ups to go along with this optimization.
>=20


The conventional wisdom that I've always heard is that a kfree under
spinlock is generally no big deal. It can't block and is usually quite
fast. Are you able to measure any performance delta from this set?



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

--=20
Jeff Layton <jlayton@kernel.org>
