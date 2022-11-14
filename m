Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54821627C6C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 12:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiKNLfr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 06:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNLfq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 06:35:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45FE0C7
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 03:35:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51C2DCE0F42
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 11:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D393C433D6;
        Mon, 14 Nov 2022 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668425742;
        bh=iALigbJ4nQScfxMZYqXyC5R8/XIrwizEkKTGMI9c12w=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Thwm9ZR6dfvPp46NNhH/VeWu+z7Yrtxb7XkLMMbDhFGIzhKeSl3eL2W6YP1BvZG5w
         Ho0WSyoi3DVIFI6iI8soQxWENBMKO8tbCVFme++l0jYqOFu8nZVrzHOJFb8QNHEhcG
         w6o8V4eHwZPmJYfGwoXuDmGsuFmE79drRiatNlOTRG0uXoucVju3MoLfrI3tWsV2I5
         XFgU2mc7MXY+KXc3m605G5V0tCAru2seWzVoL42i7N8SjdXSJ/61jqvYXxw8SR1dJv
         lNXb6UqhUhLupY/n80SLe8/7csVVhUfYi9DDcKQGc32lYuX/JHFgNwbjZFxNMkuC1K
         QVfVo9qX8fY7g==
Message-ID: <a4019f0f9c8643a672a8df4858e85591725a2757.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Fix trace_nfsd_fh_verify_err() crasher
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 14 Nov 2022 06:35:40 -0500
In-Reply-To: <166828356768.42842.2412588018662481301.stgit@klimt.1015granger.net>
References: <166828356768.42842.2412588018662481301.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Sat, 2022-11-12 at 15:06 -0500, Chuck Lever wrote:
> Now that the nfsd_fh_verify_err() tracepoint is always called on
> error, it needs to handle cases where the filehandle is not yet
> fully formed.
>=20
> Fixes: 93c128e709ae ("nfsd: ensure we always call fh_verify_error tracepo=
int")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/trace.h |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index ef01ecd3eec6..331a33a8f1f8 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -254,7 +254,10 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
>  				  rqstp->rq_xprt->xpt_remotelen);
>  		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>  		__entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
> -		__entry->inode =3D d_inode(fhp->fh_dentry);
> +		if (fhp->fh_dentry)
> +			__entry->inode =3D d_inode(fhp->fh_dentry);
> +		else
> +			__entry->inode =3D NULL;
>  		__entry->type =3D type;
>  		__entry->access =3D access;
>  		__entry->error =3D be32_to_cpu(error);
>=20

Doh!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
