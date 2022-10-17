Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9530600F9A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiJQMzj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiJQMzi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 08:55:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470D42E65
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 05:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FB52B8167E
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 12:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E7CC433C1;
        Mon, 17 Oct 2022 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666011334;
        bh=6jYfa+aWoAwoOHiEOCdQ1jS5Q92cPK2kehIivy86RGU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Xt7vOZfZWNwkSgnEGbrZ02nFAA/ow56w1w4ZPDnWC1u0ICsZewIK/VY6I4j4731SX
         WGzhQk8y1CjjILqVU1Aw5oskWpal4ul7HjMFsztDEevtqABD2LMimp+rVXnpzwGSJq
         8Uj2pwLbPaxsLj5GFsZCZ8zx+SHe9P8gZweEVOrXzcsqs49tuHtCxvg1906WF66PXQ
         ewFb83PyHathJ8cpqmF1ENSL1WUTZFB6jalXHlVv3RkTaBOSLmY8YEc6nbEZZmExVE
         PySNO/V1201BciyrWo0WzBjfwbX4/pUNTTeKtCqWMfY3GtiqKd+Salx5H2nFm7lDcn
         bs3rKvYThnZuw==
Message-ID: <355a0d843130bad8fc743b19fec2b829aed6b326.camel@kernel.org>
Subject: Re: [PATCH 1 1/3] SUNRPC: Remove unused svc_rqst::rq_lock field
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 17 Oct 2022 08:55:33 -0400
In-Reply-To: <166593521604.1710.10648202421284171508.stgit@klimt.1015granger.net>
References: <166593521604.1710.10648202421284171508.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-10-16 at 11:46 -0400, Chuck Lever wrote:
> Clean up after commit 22700f3c6df5 ("SUNRPC: Improve ordering of
> transport processing").
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h |    1 -
>  net/sunrpc/svc.c           |    1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index daecb009c05b..3b59eb9cf884 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -311,7 +311,6 @@ struct svc_rqst {
>  	struct auth_domain *	rq_gssclient;	/* "gss/"-style peer info */
>  	struct svc_cacherep *	rq_cacherep;	/* cache info */
>  	struct task_struct	*rq_task;	/* service thread */
> -	spinlock_t		rq_lock;	/* per-request lock */
>  	struct net		*rq_bc_net;	/* pointer to backchannel's
>  						 * net namespace
>  						 */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 7c9a0d0b1230..d2bb1d04c524 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -638,7 +638,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool=
 *pool, int node)
>  		return rqstp;
> =20
>  	__set_bit(RQ_BUSY, &rqstp->rq_flags);
> -	spin_lock_init(&rqstp->rq_lock);
>  	rqstp->rq_server =3D serv;
>  	rqstp->rq_pool =3D pool;
> =20
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
