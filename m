Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC047262BE
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjFGOZz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jun 2023 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjFGOZz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jun 2023 10:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627951AE
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 07:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2D4B63FCB
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 14:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F396CC433EF;
        Wed,  7 Jun 2023 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686147953;
        bh=41OI6P/XHQ1yHNJnYWeXhhwFG2qd4WwF82QPvok0Ve4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5enn6d2zWgzBguwjY79/bohj8wicksL0kZlmnX14hS7DlR4LdsmIYkXKbb7Rdnl4
         pO+1zKkbcYMddU1z9PT2QAAr4J2jYRq8uWIISiEbYkJt17CTjKcMJe1rDfuQ31b6A7
         XchGXJCGVOAGE1rYd7reIIBGBYJy4xCAFwYLcRRBuyWSRD9genupolA1eOfPXQAw1+
         sCG/3vfpZyPI7/Lt1SRGwo3Ehhh9O0SPn2hXawmX5j6UMI/1Jn+DJK0zO176OYU2DQ
         t1asAi4SJXmpwY/K0vmFqqhDh6jAlT9Gr0Thzcc72qsRfZQ2DnFsWJnzk7v2g22xQ6
         FGTWYP1ej/BRQ==
Date:   Wed, 7 Jun 2023 10:25:50 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: remove dead code in nfs4_open_delegation
Message-ID: <ZICTbiPEyk0OrlRS@manet.1015granger.net>
References: <1686094819-13044-1-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686094819-13044-1-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 06, 2023 at 04:40:19PM -0700, Dai Ngo wrote:
> The intention of this code is to tell the client to return the granted
> delegation immediately for whatever reason in the case of OPEN with
> NFS4_OPEN_CLAIM_PREVIOUS. However this was already handled above in the
> cases of switch(open->op_claim_type).
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6b75656d3e8f..58c78a23f90b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5632,11 +5632,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	return;
>  out_no_deleg:
>  	open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE;
> -	if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
> -	    open->op_delegate_type != NFS4_OPEN_DELEGATE_NONE) {
> -		dprintk("NFSD: WARNING: refusing delegation reclaim\n");
> -		open->op_recall = 1;
> -	}

This is dead code because it's broken. Look carefully at it: it sets
open->op_delegate_type to NONE, then prints a warning if it isn't
NONE. The warning will never occur, and neither will the recall.

This code came from 99c415156c49 ("nfsd4: clean up
nfs4_open_delegation"). Can you have a look at that old commit and
make sure nfs4_open_delegation is working as it was originally
intended before it was cleaned up by that commit?

Even if you decide not to change the diff, the patch description
is confusing. out_no_deleg: can be invoked /after/ the switch
statement, so I'm not seeing how the OPEN/CLAIM_PREVIOUS case
is handled in that instance. The description also needs to at
least mention that the removed code never worked properly.


>  	/* 4.1 client asking for a delegation? */
>  	if (open->op_deleg_want)
> -- 
> 2.9.5
> 
