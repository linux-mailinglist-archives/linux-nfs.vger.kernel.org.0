Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF595FA891
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 01:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJJXSW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 19:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJJXSV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 19:18:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771945AC6B
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 16:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25EFEB810FD
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 23:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B8BC433D6;
        Mon, 10 Oct 2022 23:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665443897;
        bh=AkGkCzANeX0Aa3x4lPhHF8yIS/fELfU5g3DyJMawUis=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FpmvatKpr+dLqqYUSKfHYwVkOYS10ZjoTJfEuJF6O5PpfRMAHA/0BZcnJyy/FSYPv
         lFSyiXzxSAGsS9iZdqp2Ld1/w8qlDTqKlFMsGyo+4qG9F4+vCxOGl/FpTy9yE29fID
         egY/555gXYZjVW1yRwnzShEr9d40XiA+rMGBXQCGAYeNU4pIPy2MiSMoeJK3A/lxTU
         ndGca6HLi95cJ+rK7srQIJds3dxpoE85kVH2MNaKQeRdbzhnsd7YTYsylV0xNvuAuZ
         R/N3oExapwv8z+Tn2hy+e5dJ7Svd9cqcGGe69wpDczPdLwlzjlwaFXCXm52p/puijo
         pWxd91T1AIr9w==
Message-ID: <4df8175d03d013e2d394126621775db9ecff13f0.camel@kernel.org>
Subject: Re: [PATCH] NFSD: unregister shrinker when nfsd_init_net() fails
From:   Jeff Layton <jlayton@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Chuck Lever <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>
Cc:     syzbot <syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Date:   Mon, 10 Oct 2022 19:18:14 -0400
In-Reply-To: <66b0ff35-c468-1a5b-3327-7e2ffcc768ee@I-love.SAKURA.ne.jp>
References: <0000000000008c976e05ea9f491d@google.com>
         <66b0ff35-c468-1a5b-3327-7e2ffcc768ee@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-10 at 14:59 +0900, Tetsuo Handa wrote:
> syzbot is reporting UAF read at register_shrinker_prepared() [1], for
> commit 7746b32f467b3813 ("NFSD: add shrinker to reap courtesy clients on
> low memory condition") missed that nfsd4_leases_net_shutdown() from
> nfsd_exit_net() is called only when nfsd_init_net() succeeded.
> If nfsd_init_net() fails due to nfsd_reply_cache_init() failure,
> register_shrinker() from nfsd4_init_leases_net() has to be undone
> before nfsd_init_net() returns.
>=20
> Link: https://syzkaller.appspot.com/bug?extid=3Dff796f04613b4c84ad89 [1]
> Reported-by: syzbot <syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.co=
m>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 7746b32f467b3813 ("NFSD: add shrinker to reap courtesy clients on =
low memory condition")
> ---
>  fs/nfsd/nfsctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 6a29bcfc9390..dc74a947a440 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1458,12 +1458,14 @@ static __net_init int nfsd_init_net(struct net *n=
et)
>  		goto out_drc_error;
>  	retval =3D nfsd_reply_cache_init(nn);
>  	if (retval)
> -		goto out_drc_error;
> +		goto out_cache_error;
>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>  	seqlock_init(&nn->writeverf_lock);
> =20
>  	return 0;
> =20
> +out_cache_error:
> +	nfsd4_leases_net_shutdown(nn);
>  out_drc_error:
>  	nfsd_idmap_shutdown(net);
>  out_idmap_error:


Good catch!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
