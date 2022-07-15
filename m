Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6406A57627B
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiGONFx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 09:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiGONFx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 09:05:53 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E222A4A806
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 06:05:51 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id vR5o2700b4C55Sk06R5oDe; Fri, 15 Jul 2022 15:05:48 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oCL0u-003gTx-Br; Fri, 15 Jul 2022 15:05:48 +0200
Date:   Fri, 15 Jul 2022 15:05:48 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     Dai Ngo <dai.ngo@oracle.com>
cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH v2 2/2] NFSD: limit the number of v4 clients to 1024 per
 1GB of system memory
In-Reply-To: <1657815462-14069-3-git-send-email-dai.ngo@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2207151502420.878233@ramsan.of.borg>
References: <1657815462-14069-1-git-send-email-dai.ngo@oracle.com> <1657815462-14069-3-git-send-email-dai.ngo@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

 	Hi Dai,

On Thu, 14 Jul 2022, Dai Ngo wrote:
> Currently there is no limit on how many v4 clients are supported
> by the system. This can be a problem in systems with small memory
> configuration to function properly when a very large number of
> clients exist that creates memory shortage conditions.
>
> This patch enforces a limit of 1024 NFSv4 clients, including courtesy
> clients, per 1GB of system memory.  When the number of the clients
> reaches the limit, requests that create new clients are returned
> with NFS4ERR_DELAY and the laundromat is kicked start to trim old
> clients. Due to the overhead of the upcall to remove the client
> record, the maximun number of clients the laundromat removes on
> each run is limited to 128. This is done to ensure the laundromat
> can still process the other tasks in a timely manner.
>
> Since there is now a limit of the number of clients, the 24-hr
> idle time limit of courtesy client is no longer needed and was
> removed.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Thanks for your patch, which is now commit 05eaba9bd8c06580 ("NFSD:
limit the number of v4 clients to 1024 per 1GB of system memory")
in next-20220715.

noreply@ellerman.id.au reports:

     fs/nfsd/nfsctl.c:1504:24: error: 'NFS4_CLIENTS_PER_GB' undeclared (first use in this function)

> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1463,6 +1463,8 @@ static __net_init int nfsd_init_net(struct net *net)
> {
> 	int retval;
> 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	u64 max_clients;
> +	struct sysinfo si;
>
> 	retval = nfsd_export_init(net);
> 	if (retval)
> @@ -1488,6 +1490,10 @@ static __net_init int nfsd_init_net(struct net *net)

Not protected by #ifdef CONFIG_NFSD_V4:

> 	seqlock_init(&nn->writeverf_lock);
>
> 	atomic_set(&nn->nfs4_client_count, 0);
> +	si_meminfo(&si);
> +	max_clients = (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
> +	max_clients *= NFS4_CLIENTS_PER_GB;
> +	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>
> 	return 0;
>
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 847b482155ae..bbada18225b1 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -341,6 +341,8 @@ void		nfsd_lockd_shutdown(void);

Protected by #ifdef CONFIG_NFSD_V4:

>
> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
> #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> +#define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
> +#define	NFS4_CLIENTS_PER_GB		1024
>
> /*
>  * The following attributes are currently not supported by the NFSv4 server:
> -- 
> 2.9.5

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
