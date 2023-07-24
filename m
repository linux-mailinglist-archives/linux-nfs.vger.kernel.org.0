Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789B175EAB8
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 07:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGXFJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 01:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGXFJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 01:09:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B733DB;
        Sun, 23 Jul 2023 22:09:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3CCE2048B;
        Mon, 24 Jul 2023 05:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690175345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fytMvTwmPjgGSNd8fUaW0uPfvA4FOVLSKyY6fXWrTds=;
        b=nZaS5uf28SPRU4eQoC5q6uPXgpduVpt7qqNfMvFSEc2biFCt8kCxm8cxQOj2r8HZKYFKbt
        jkehVqXEJCg2idssg5DefeLfz7Q4rX4ortoJdVrbzMQ9cghUue19403cvugupzgI91IQ2w
        8fCafT7EWiwMHLuIxz4fdBKnoVSmMrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690175345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fytMvTwmPjgGSNd8fUaW0uPfvA4FOVLSKyY6fXWrTds=;
        b=uWDfMDPo300lo9JyO+jgzkI0qaLoli4boYygrzKP71E4YLARAOnSl2dCT/MdmGB3l2bfGo
        yxr9gknx7NnY5ZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A9E713476;
        Mon, 24 Jul 2023 05:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2+pMO20HvmSrIgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jul 2023 05:09:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "YueHaibing" <yuehaibing@huawei.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        yuehaibing@huawei.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sunrpc: Remove unused extern declarations
In-reply-to: <20230722033116.17988-1-yuehaibing@huawei.com>
References: <20230722033116.17988-1-yuehaibing@huawei.com>
Date:   Mon, 24 Jul 2023 15:08:59 +1000
Message-id: <169017533908.11078.1160756498004010060@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 22 Jul 2023, YueHaibing wrote:
> Since commit 49b28684fdba ("nfsd: Remove deprecated nfsctl system call and =
related code.")
> these declarations are unused, so can remove it.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks.
Could you remove the declaration of auth_unix_lookup too?
It was removed in that commit, but the declaration is still with us.

Thanks!
NeilBrown

> ---
>  include/linux/sunrpc/svcauth.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
> index 6d9cc9080aca..2402b7ca5d1a 100644
> --- a/include/linux/sunrpc/svcauth.h
> +++ b/include/linux/sunrpc/svcauth.h
> @@ -157,11 +157,9 @@ extern void	svc_auth_unregister(rpc_authflavor_t flavo=
r);
> =20
>  extern struct auth_domain *unix_domain_find(char *name);
>  extern void auth_domain_put(struct auth_domain *item);
> -extern int auth_unix_add_addr(struct net *net, struct in6_addr *addr, stru=
ct auth_domain *dom);
>  extern struct auth_domain *auth_domain_lookup(char *name, struct auth_doma=
in *new);
>  extern struct auth_domain *auth_domain_find(char *name);
>  extern struct auth_domain *auth_unix_lookup(struct net *net, struct in6_ad=
dr *addr);
> -extern int auth_unix_forget_old(struct auth_domain *dom);
>  extern void svcauth_unix_purge(struct net *net);
>  extern void svcauth_unix_info_release(struct svc_xprt *xpt);
>  extern int svcauth_unix_set_client(struct svc_rqst *rqstp);
> --=20
> 2.34.1
>=20
>=20

