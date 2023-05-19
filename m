Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42492709481
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjESKKO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjESKKJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 06:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2BE5A;
        Fri, 19 May 2023 03:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D3861B47;
        Fri, 19 May 2023 10:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A23EC433EF;
        Fri, 19 May 2023 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684491002;
        bh=SH3Ai0VIsZ5Tro1m/lUwyde5P3oV+8XIW0LuSqw/h3Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u6ErOHLWzIPaOsxk0ez6lwUx1hQa61M6PBaSMEA+rrC8v0EZKh/abMt0tfqHkZcsW
         +I1A6daUGRlOKPBRgr3c6MmbP/2nOmh9yemPsu5YGOGe5no4fvYfH1qjoEGSqkAXlN
         ysUui50ICNt7jCIiT64aMSUif+aPaySt6M6urvZ+zyBtwKkknMShxDdn/ZFVw5W9H/
         rbWMCWEJuOmWuehgWUNHxy73TF0Q62Plgofd9CRF0F86RUpTTP/eA+K/ZiS3YIuJBy
         atf5zlAqhuCmhNpgN5kfBDQPQIDoDMQURmrXzFjoW8t5pqeiccKbyILRuXkPqZClS5
         hwiNtPfvt5PRw==
Message-ID: <f281d4b831d71ebe86e48c0f45b82b05276bc655.camel@kernel.org>
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 May 2023 06:10:01 -0400
In-Reply-To: <20230517162645.254512-1-jlayton@kernel.org>
References: <20230517162645.254512-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
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

On Wed, 2023-05-17 at 12:26 -0400, Jeff Layton wrote:
> notify_change can modify the iattr structure. In particular it can can
> end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
> BUG() if the same iattr is passed to notify_change more than once.
>=20
> Make a copy of the struct iattr before calling notify_change.
>=20
> Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NFS4=
ERR_DELAY
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c4ef24c5ffd0..ad0c5cd900b1 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> =20
>  	inode_lock(inode);
>  	for (retries =3D 1;;) {
> -		host_err =3D __nfsd_setattr(dentry, iap);
> +		struct iattr attrs =3D *iap;
> +
> +		host_err =3D __nfsd_setattr(dentry, &attrs);
>  		if (host_err !=3D -EAGAIN || !retries--)
>  			break;
>  		if (!nfsd_wait_for_delegreturn(rqstp, inode))

Zhi Li tested the test kernel for this today and this seems to have
fixed the issue. I think you can add:

Tested-by: Zhi Li <yieli@redhat.com>

Cheers,
Jeff
