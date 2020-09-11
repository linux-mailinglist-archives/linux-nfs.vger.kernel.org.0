Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5857B266985
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Sep 2020 22:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgIKU1m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Sep 2020 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgIKU1k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Sep 2020 16:27:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02905C0613ED
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 13:18:54 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 874E432A8; Fri, 11 Sep 2020 16:18:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 874E432A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599855530;
        bh=BIof1MZbSqEBu9rH84zRk1ncbFNxcWMGiwEI6WRQ4QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNsCmTwmI5mn3sRzMZGJJJCN0MJcGWSQku1qAm+1MY7qrVTYrCdZLckielIFOVr7a
         oHKHdkfAkz55FXZHfWJ022jjq5vj/Ji3kvZ5sc6T3yJN7BNTH4Mgp2v1A3pSTHFlDW
         dOOvfguzW4RpSaoXmb1DT4w+t8rux+Yt+ZCcE9ZE=
Date:   Fri, 11 Sep 2020 16:18:50 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Address sparse warnings
Message-ID: <20200911201850.GF15078@fieldses.org>
References: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 11, 2020 at 02:47:43PM -0400, Chuck Lever wrote:
> Hi Bruce-
> 
> I was going to send a v5.9-rc PR for these, but they are not urgent.
> Would you take them for v5.10 ?

Yep, thanks--applied.

--b.

> 
> ---
> 
> Chuck Lever (3):
>       NFSD: Correct type annotations in user xattr helpers
>       NFSD: Correct type annotations in user xattr XDR functions
>       NFSD: Correct type annotations in COPY XDR functions
> 
> 
>  fs/nfsd/nfs4xdr.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --
> Chuck Lever
