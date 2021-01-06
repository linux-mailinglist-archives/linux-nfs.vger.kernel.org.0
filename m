Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CFA2EC55D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jan 2021 21:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbhAFUvA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jan 2021 15:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbhAFUu7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jan 2021 15:50:59 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5BEC061575
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jan 2021 12:50:19 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9356A6191; Wed,  6 Jan 2021 15:50:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9356A6191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1609966217;
        bh=pf+CAEQq59CbISnqHZ7qjfGChKriNCccNgZvmRVHRKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kPdnkXTSSMegTmgJKN4Nt6t40ekaYZJ9r9YmvJL9UvVLjqxQjUzxmb2qlvt+8gaJe
         qRl3tVqqyPYtu4eGpT8p944nmN1oRYqElSQY8BkX9htym71DVyKwS/aJCc2MtsYPIt
         BHxSeHnh6uMZNj1S7e4FTOuG/UVy0MIbgFNRGD54=
Date:   Wed, 6 Jan 2021 15:50:17 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nfsd: protect concurrent access to nfsd stats
 counters
Message-ID: <20210106205017.GG13116@fieldses.org>
References: <20210106075236.4184-1-amir73il@gmail.com>
 <20210106075236.4184-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106075236.4184-3-amir73il@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These three patches seem fine.  To bikeshed just a bit more:

On Wed, Jan 06, 2021 at 09:52:35AM +0200, Amir Goldstein wrote:
>  	/* We found a matching entry which is either in progress or done. */
> -	nfsdstats.rchits++;
> +	nfsd_stats_rc_hits_inc();

Maybe make that something like

	nfsd_stats_inc(NFSD_STATS_RC_HITS);

and then we could avoid boilerplate like the below?

--b.

> +static inline void nfsd_stats_rc_hits_inc(void)
> +{
> +	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_HITS]);
> +}
> +
> +static inline void nfsd_stats_rc_misses_inc(void)
> +{
> +	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_MISSES]);
> +}
> +
> +static inline void nfsd_stats_rc_nocache_inc(void)
> +{
> +	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]);
> +}
> +
> +static inline void nfsd_stats_fh_stale_inc(void)
> +{
> +	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
> +}
> +
> +static inline void nfsd_stats_io_read_add(s64 amount)
> +{
> +	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
> +}
> +
> +static inline void nfsd_stats_io_write_add(s64 amount)
> +{
> +	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
> +}
> +
> +static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
> +{
> +	percpu_counter_inc(&nn->counter[NFSD_NET_PAYLOAD_MISSES]);
> +}
> +
> +static inline void nfsd_stats_drc_mem_usage_add(struct nfsd_net *nn, s64 amount)
> +{
> +	percpu_counter_add(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
> +}
> +
> +static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
> +{
> +	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
> +}
