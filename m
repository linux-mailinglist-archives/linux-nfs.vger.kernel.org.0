Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB827DBA3B
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 14:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjJ3NDR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjJ3NDQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 09:03:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEBFC2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 06:03:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD2CC433C7;
        Mon, 30 Oct 2023 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698670994;
        bh=9Dizicebk3lKHNGfkP6T1KM+uaqihR4FYLlmeCPAik0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ofKFkNzT3l+243kgDc1pWc1nwJvLuVkgC9YnP5sStrW/cHYwZk9G3adPWWvW3j05u
         adrk4Wv+Yioj7WCdPB4YTYZr2+P2oAIfW4jMpoXgonOVVVPgEXKhW2Elu1x58HgusV
         bwRYlEXcvDevf+SJc0jjXCePVEydNHtA6f+yF5O6yojV3xrVG9HhkQnbV8jchrbzsE
         Y0DIwemSIKRQmnYZKwj1+XmZIVSlsQlNr/9ZEdvLoNcP44q3r+8gTheA6YMzoFNOde
         8nBbYVf66SGCv+V5FYKmFx5UBZMxKz9Cx8xEJ0fpSYTf3XK58SuZigesK+OaLZPgtr
         WII6jubwtnyCA==
Message-ID: <07df60cee15b8c206365613364d4979330c31407.camel@kernel.org>
Subject: Re: [PATCH 3/5] nfsd: hold nfsd_mutex across entire netlink
 operation
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Mon, 30 Oct 2023 09:03:12 -0400
In-Reply-To: <20231030011247.9794-4-neilb@suse.de>
References: <20231030011247.9794-1-neilb@suse.de>
         <20231030011247.9794-4-neilb@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-10-30 at 12:08 +1100, NeilBrown wrote:
> Rather than using svc_get() and svc_put() to hold a stable reference to
> the nfsd_svc for netlink lookups, simply hold the mutex for the entire
> time.
>=20
> The "entire" time isn't very long, and the mutex is not often contented.
>=20
> This makes way for use to remove the refcounts of svc, which is more
> confusing than useful.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsctl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d78ae4452946..8f644f1d157c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1515,11 +1515,10 @@ int nfsd_nl_rpc_status_get_start(struct netlink_c=
allback *cb)
>  	int ret =3D -ENODEV;
> =20
>  	mutex_lock(&nfsd_mutex);
> -	if (nn->nfsd_serv) {
> -		svc_get(nn->nfsd_serv);
> +	if (nn->nfsd_serv)
>  		ret =3D 0;
> -	}
> -	mutex_unlock(&nfsd_mutex);
> +	else
> +		mutex_unlock(&nfsd_mutex);
> =20
>  	return ret;
>  }
> @@ -1691,8 +1690,6 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
>   */
>  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
>  {
> -	mutex_lock(&nfsd_mutex);
> -	nfsd_put(sock_net(cb->skb->sk));
>  	mutex_unlock(&nfsd_mutex);
> =20
>  	return 0;

(cc'ing Lorenzo since he wrote this)

I think Lorenzo did it this way originally, and I convinced him to take
a reference instead. This should be fine though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
