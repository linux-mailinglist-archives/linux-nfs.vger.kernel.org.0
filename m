Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96B645DAF9
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 03:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfGCBgC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jul 2019 21:36:02 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51903 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbfGCBgB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jul 2019 21:36:01 -0400
Received: from [192.168.0.3] (ip5f5bf2d3.dynamic.kabel-deutschland.de [95.91.242.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E667F2067CFE0;
        Tue,  2 Jul 2019 23:59:48 +0200 (CEST)
Subject: Regression caused by commit c54f24e3 (nfsd: fix performance-limiting
 session calculation)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20190702165107.93C8A2067CFDD@mx.molgen.mpg.de>
 <8c3e0249-b17f-4bd2-4a46-afd4d35f4763@molgen.mpg.de>
Cc:     Chris Tracy <ctracy@engr.scu.edu>, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-nfs@molgen.mpg.de
Message-ID: <0b5fdd56-d570-c787-cd56-7e6d0ba65225@molgen.mpg.de>
Date:   Tue, 2 Jul 2019 23:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8c3e0249-b17f-4bd2-4a46-afd4d35f4763@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear Bruce,


Could it be that commit c54f24e3 (nfsd: fix performance-limiting session 
calculation) causes a regression on big memory machines (1 TB)?

> From c54f24e338ed2a35218f117a4a1afb5f9e2b4e64 Mon Sep 17 00:00:00 2001
> From: "J. Bruce Fields" <bfields@redhat.com>
> Date: Thu, 21 Feb 2019 10:47:00 -0500
> Subject: [PATCH] nfsd: fix performance-limiting session calculation
> 
> We're unintentionally limiting the number of slots per nfsv4.1 session
> to 10.  Often more than 10 simultaneous RPCs are needed for the best
> performance.
> 
> This calculation was meant to prevent any one client from using up more
> than a third of the limit we set for total memory use across all clients
> and sessions.  Instead, it's limiting the client to a third of the
> maximum for a single session.
> 
> Fix this.
> 
> Reported-by: Chris Tracy <ctracy@engr.scu.edu>
> Cc: stable@vger.kernel.org
> Fixes: de766e570413 "nfsd: give out fewer session slots as limit approaches"
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fb3c9844c82a..6a45fb00c5fc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1544,16 +1544,16 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>  {
>  	u32 slotsize = slot_bytes(ca);
>  	u32 num = ca->maxreqs;
> -	int avail;
> +	unsigned long avail, total_avail;
>  
>  	spin_lock(&nfsd_drc_lock);
> -	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION,
> -		    nfsd_drc_max_mem - nfsd_drc_mem_used);
> +	total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> +	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>  	/*
>  	 * Never use more than a third of the remaining memory,
>  	 * unless it's the only way to give this client a slot:
>  	 */
> -	avail = clamp_t(int, avail, slotsize, avail/3);
> +	avail = clamp_t(int, avail, slotsize, total_avail/3);
>  	num = min_t(int, num, avail / slotsize);
>  	nfsd_drc_mem_used += num * slotsize;
>  	spin_unlock(&nfsd_drc_lock);

Booting a 80 threads, 1 TB server with Linux 4.19.56 and Linux 5.2-rc7 
causes connections problems for the clients. The problems do not happen 
on servers with just 96 GB memory for example. Bisecting points to the 
two commits below (and I can only continue tomorrow).

c54f24e338ed2a35218f117a4a1afb5f9e2b4e64 (nfsd: fix performance-limiting 
session calculation)
8127d82705998568b52ac724e28e00941538083d (NFS: Don't recoalesce on error 
in nfs_pageio_complete_mirror())

If you have things I could do to verify this besides reverting it
tomorrow, please tell. It’d be great if it could be fixed before Linux
5.2 is released.


Kind regards,

Paul
