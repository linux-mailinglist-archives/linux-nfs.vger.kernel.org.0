Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15B34C2A65
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 12:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiBXLHo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 06:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiBXLHn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 06:07:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641C1201BF
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 03:07:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10EA1B824F6
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 11:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C95C340E9;
        Thu, 24 Feb 2022 11:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645700830;
        bh=qEcHo5NBHcANTwFkfRQ7OXoo2fRYlrb+O8fpcnSzfjw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AhPpO4Bqd7SwaAl7thBBLm9tkczPyVwEsEIFLJnFoqaPOiBOnGh86/pFBqLn14z2k
         pbkQxrKvyC42wTx4qU3uy2gF4VPAi2zGmge36qoiUsf5hXX62V9piJRrjySo59IYuT
         FXVX1grix9u178PTzgwf7VeqSxA8PKs479KgcleH2vllMla21Qb4Gx5ewDLMsT3xl4
         dGcUbOL7haO0TBevkhjjd4O8odtujbblgG44IWG3YFawvHygkF5OLog3Ah7NmhDP+E
         z++d8r0YTQioMw7EJfiXoR23dFZBwjDlHLt88IRtL1P74Mc6bc923gl7crHkvdMZTY
         54mUJXspmtc+w==
Message-ID: <e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org>
Subject: Re: nfsd: unable to allocate nfsd_file_hashtbl
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 24 Feb 2022 06:07:08 -0500
In-Reply-To: <CAOQ4uxhYsci9-ADNTH6RZmnzBQoxy0ek4+Hgi9sK8HpF2ftrow@mail.gmail.com>
References: <CAOQ4uxhYsci9-ADNTH6RZmnzBQoxy0ek4+Hgi9sK8HpF2ftrow@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-02-24 at 12:13 +0200, Amir Goldstein wrote:
> Hi Jeff,
> 
> I got some reports from customers about failure to allocate the
> nfsd_file_hashtbl on nfs server restart on a long running system,
> probably due to memory fragmentation.
> 
> A search in Google for this error message yields several results of
> similar reports [1][2].
> 
> My question is, does nfsd_file_cache_init() have to be done on server
> startup?
> 
> Doesn't it make more sense to allocate all the memory pools and
> hash table on init_nfsd()?
> 
> Thanks,
> Amir.
> 
> [1] https://unix.stackexchange.com/questions/640534/nfs-cannot-allocate-memory
> [2] https://askubuntu.com/questions/1365821/nfs-crashing-on-ubuntu-server-20-04

That is a big allocation. On my box, nfsd_fcache_bucket is 80 bytes, so
we end up needing 80 contiguous pages to allocate the whole table. It
doesn't surprise me that it fails sometimes.

We could just allocate it on init_nfsd, but that happens when the module
is plugged in and we'll lose 80 pages when people plug it in (or build
it in) and don't actually use nfsd.

The other option might be to just use kvcalloc? It's not a frequent
allocation, so I don't think performance would be an issue. We had
similar reports several years ago with nfsd_reply_cache_init, and using
kvzalloc ended up taking care of it.

-- 
Jeff Layton <jlayton@kernel.org>
