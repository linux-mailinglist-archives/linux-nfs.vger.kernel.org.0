Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2E65DF92
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfGCISS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 04:18:18 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:26565
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727045AbfGCISS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Jul 2019 04:18:18 -0400
X-IronPort-AV: E=Sophos;i="5.63,446,1557180000"; 
   d="scan'208";a="312254589"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 10:18:16 +0200
Date:   Wed, 3 Jul 2019 10:18:15 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] NFS: Less function calls in show_pnfs()
In-Reply-To: <d2f73c3e-a55f-5fb7-a8f8-0dc3ce8ff8a5@web.de>
Message-ID: <alpine.DEB.2.20.1907031018000.4456@hadrien>
References: <d2f73c3e-a55f-5fb7-a8f8-0dc3ce8ff8a5@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On Tue, 2 Jul 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jul 2019 16:30:53 +0200
>
> Reduce function calls for data output into a sequence.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/nfs/super.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index f88ddac2dcdf..c301cd585b3b 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -749,11 +749,10 @@ static void show_sessions(struct seq_file *m, struct nfs_server *server) {}
>  #ifdef CONFIG_NFS_V4_1
>  static void show_pnfs(struct seq_file *m, struct nfs_server *server)
>  {
> -	seq_printf(m, ",pnfs=");
> -	if (server->pnfs_curr_ld)
> -		seq_printf(m, "%s", server->pnfs_curr_ld->name);
> -	else
> -		seq_printf(m, "not configured");
> +	seq_printf(m, ",pnfs=%s",
> +		   server->pnfs_curr_ld
> +		   ? server->pnfs_curr_ld->name
> +		   : "not configured");

Unreadable.

julia

>  }
>
>  static void show_implementation_id(struct seq_file *m, struct nfs_server *nfss)
> --
> 2.22.0
>
>
