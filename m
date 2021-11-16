Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E644534B4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhKPO44 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhKPO4z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 09:56:55 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D04C061570
        for <linux-nfs@vger.kernel.org>; Tue, 16 Nov 2021 06:53:58 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 46F9F6814; Tue, 16 Nov 2021 09:53:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 46F9F6814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637074437;
        bh=CmgPx2oplHwUZY93uNfDK2F+blEytRAfxW2UWPR2Kk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+0O7/Itey5BwmvVD6aIiCEVp6IrQB9qxdn+UBwWS6Zk45yHOFidtHM0fxTaI57v5
         7GKnLbow+cokGW8/jXApcgfikgKv5rbhvyzl5udV1+mVRU4B3+KHCTSIIOcogO2npo
         /nn3LbV/T0ThKi/L40AHNGimbbDySBe2yew0Czxc=
Date:   Tue, 16 Nov 2021 09:53:57 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     An Long <lan@suse.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] README: Fix typo of install guide
Message-ID: <20211116145357.GC8695@fieldses.org>
References: <20211116095632.21811-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116095632.21811-1-lan@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, both applied.--b.

On Tue, Nov 16, 2021 at 05:56:31PM +0800, An Long wrote:
> Signed-off-by: An Long <lan@suse.com>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index fe2eae3..b8b4e77 100644
> --- a/README
> +++ b/README
> @@ -12,7 +12,7 @@ Install dependent modules:
>  	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
>  
>  * openSUSE
> -	zypper in install krb5-devel python3-devel swig python3-gssapi python3-ply
> +	zypper install krb5-devel python3-devel swig python3-gssapi python3-ply
>  
>  You can prepare both for use with
>  	./setup.py build
> -- 
> 2.31.1
