Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD16543FB
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 16:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLVPLm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 10:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiLVPLS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 10:11:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA5713FAC
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 07:10:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC8361C27
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 15:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BF8C433D2;
        Thu, 22 Dec 2022 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671721809;
        bh=kFokKpYHK5p4eNpyBgxQhNpG5w8jDGT8Ujr9tyMaQxw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Lv6k8/Gsxbrb5RaJaA2OxSTTLM1JdT2zqCsFkrPGwKRN91ukrbc593atKN0bPVins
         b/gQtga/uSfVRKlPb7Sy6mAO84KXS1nByXgOIFuprdxuAx0CtZGMA1w7D6FMJgVfs6
         geUgYaycizHNwrG7b4hoo00Q0S4rhkNYtJCHury0UViX/U60L848TRrKjES61P8ldD
         c+T0DstDISTheLMPqg97MOgjL8iuns4sbXL2YiGGxCNMJugI+ZKp1NPxGqTIymNVJD
         v/neO8wipSda4LbRDO/ZKCGd5Y72Yy7KFNSK5OgNn5eQzv+KluwlFsWFiHiiYDS8ua
         4RcLPPtSnXqvw==
Message-ID: <46416c9d66e5c64feb3093d3f1f6b6248d49467b.camel@kernel.org>
Subject: Re: [PATCH] nfsd: shut down the NFSv4 state objects before the
 filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Date:   Thu, 22 Dec 2022 10:10:08 -0500
In-Reply-To: <3858C5C1-342C-4599-A1B5-BF55953D0CBB@oracle.com>
References: <20221222145130.162341-1-jlayton@kernel.org>
         <3858C5C1-342C-4599-A1B5-BF55953D0CBB@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-12-22 at 14:55 +0000, Chuck Lever III wrote:
>=20
> > On Dec 22, 2022, at 9:51 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Currently, we shut down the filecache before trying to clean up the
> > stateids that depend on it. This leads to the kernel trying to free an
> > nfsd_file twice, and a refcount overput on the nf_mark.
> >=20
> > Change the shutdown procedure to tear down all of the stateids prior
> > to shutting down the filecache.
> >=20
> > Reported-and-Tested-by: Wang Yugui <wangyugui@e16-tech.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfssvc.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 56fba1cba3af..325d3d3f1211 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -453,8 +453,8 @@ static void nfsd_shutdown_net(struct net *net)
> > {
> > 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >=20
> > -	nfsd_file_cache_shutdown_net(net);
> > 	nfs4_state_shutdown_net(net);
> > +	nfsd_file_cache_shutdown_net(net);
> > 	if (nn->lockd_up) {
> > 		lockd_down(net);
> > 		nn->lockd_up =3D false;
> > --=20
> > 2.38.1
> >=20
>=20
> Hi Jeff, seems sensible. May I add:
>=20
> Fixes: 5e113224c17e ("nfsd: nfsd_file cache entries should be per net nam=
espace")
>=20

Yes, thanks.
--=20
Jeff Layton <jlayton@kernel.org>
