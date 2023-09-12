Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CD79D469
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjILPIK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjILPIA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 11:08:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC52CCD
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 08:07:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D3CC433C7;
        Tue, 12 Sep 2023 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694531275;
        bh=NRangzw3TzRKp9nbKHBdApjr4HkV2c3nCyfcogKlbUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNma68IHmoCH8q0wU2pAt42Hu9HLzKelsY6JRUe7jwa1JR/T2ZxUAZTKTWdgHMulS
         j71T4FO4QPHdHMibcjR9tAkVJzXwFxgnGbDm5CSp00iLmFPgWsIQHuBVScaMziVLId
         hLUp095sbZ7+wLcP5ONyg8zaWa5bPcgWm3QwYAZPR5bY3QVo4G0PqllnuZuxrbr75p
         b7Lr1/NSvB/Wi4vLdHRxpFYlJHEKkagPFrMUv7wj5bosflQw2YhSGieiBpdcTg3sEg
         Rf+qIZ8CoTt2uuWHpOQj5yZ6/kBWIKyx1LJ/2+FmA70R02v1ZjjLpPuIoKY7kuEhs7
         zZV3pgsKyPFQA==
Date:   Tue, 12 Sep 2023 17:07:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        netdev@vger.kernel.org
Subject: Re: [PATCH v8 2/3] NFSD: introduce netlink rpc_status stubs
Message-ID: <20230912150751.GG401982@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 11, 2023 at 02:49:45PM +0200, Lorenzo Bianconi wrote:
> Generate empty netlink stubs and uAPI through nfsd_server.yaml specs:
> 
> $./tools/net/ynl/ynl-gen-c.py --mode uapi \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --header -o include/uapi/linux/nfsd_server.h
> $./tools/net/ynl/ynl-gen-c.py --mode kernel \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --header -o fs/nfsd/nfs_netlink_gen.h
> $./tools/net/ynl/ynl-gen-c.py --mode kernel \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --source -o fs/nfsd/nfs_netlink_gen.c
> 
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 33f80d289d63..1be66088849c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1495,6 +1495,22 @@ static int create_proc_exports_entry(void)
>  
>  unsigned int nfsd_net_id;
>  
> +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> +					 struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +

Hi Lorenzo,

W=1 build for gcc-13 and clang-16, and Smatch, complain that
there is no prototype for the above functions.

Perhaps nfs_netlink_gen.h should be included in this file?

>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace

...
