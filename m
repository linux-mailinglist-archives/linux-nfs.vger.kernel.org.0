Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F87578C9A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiGRVSY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiGRVSX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 17:18:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963328721
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 14:18:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A1FB661B1; Mon, 18 Jul 2022 17:18:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A1FB661B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1658179099;
        bh=7QTS44UbYQWSGRdKyrZ7DjzfJ2+7z/xXfRCHTxanoAU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=mh+CWxUC0wNvE6wvBiwsaWFBLIcwY0Vq4Ye9UVf+tWET/OnMR5ZJ2N24G/yy5Qoym
         bPx/X99AwovMjch54qCQLsmk2OfK5VX6XEPObA/TP57w6jDEvTidRiFHfVrKeC+WRv
         y2RWAZ70WvvedsN6tVMOwFJe2prXjQynWXCUbDi0=
Date:   Mon, 18 Jul 2022 17:18:19 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, neilb@suse.de, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] nfsd: close potential race between open and
 setting delegation
Message-ID: <20220718211819.GA28925@fieldses.org>
References: <20220714152819.128276-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714152819.128276-1-jlayton@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 14, 2022 at 11:28:16AM -0400, Jeff Layton wrote:
> Here's a first stab at a patchset to close a potential race when setting
> a delegation on a file. Between the point where we open the file and
> where we set the delegation, another task or client could unlink or
> rename the dentry. If that occurs, we shouldn't hand out a delegation
> in the open response, but we don't prevent that today.
> 
> The basic idea here is to re-do the lookup after setting the delegation.
> If the resulting dentry is not the one we have in the open, then we can
> reject handing out a delegation.

I have this distinct memory of actually doing that before.

But looking through the git history all I find is 4335723e8e9f "nfsd4:
fix delegation-unlink/rename race", from 2014, which claims to fix a
similar-sounding race in a different way.

How are you reproducing this?

--b.

> 
> Only lightly tested, so this is an RFC for now.
> 
> Jeff Layton (3): nfsd: drop fh argument from alloc_init_deleg nfsd:
> rework arguments to nfs4_set_delegation nfsd: vet the opened dentry
> after setting a delegation
> 
>  fs/nfsd/nfs4state.c | 65
>  ++++++++++++++++++++++++++++++++++++++------- 1 file changed, 55
>  insertions(+), 10 deletions(-)
> 
> -- 2.36.1
