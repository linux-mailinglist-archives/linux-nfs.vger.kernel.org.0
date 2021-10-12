Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070AB42A704
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJLOUA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbhJLOUA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 10:20:00 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90362C061570
        for <linux-nfs@vger.kernel.org>; Tue, 12 Oct 2021 07:17:58 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BC87741A2; Tue, 12 Oct 2021 10:17:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BC87741A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634048277;
        bh=JJWMEnbd1NP3JhFbdemzAVi/Txh+ZaSSqvzRndElr6A=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=WQeDMtqLDqc9r+1yk9GWyqKa1gIGDs+pbVXg67l26/Kkqig+Lv1/WJqbqtYWUQlvK
         +cAWF71fYtHCWwmhTtNI6uG/6AGIW0/FKg1SrLrFWsp1N2YiYZKXBkkRpPLv69gW9x
         rd/NoQvyWwXp8rUYH1cEDiP1skCArGA9WR0ZbdJI=
Date:   Tue, 12 Oct 2021 10:17:57 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Clean up svc scheduler
Message-ID: <20211012141757.GB6249@fieldses.org>
References: <163363775944.2295.17512762002999927909.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163363775944.2295.17512762002999927909.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 07, 2021 at 04:17:17PM -0400, Chuck Lever wrote:
> Hi Bruce. I forgot that these two go together. Sorry about that.
> 
> "SUNRPC: Simplify the SVC dispatch code path" is unchanged from
> its initial posting a few minutes ago.

Looks good to me, thanks; applied.--b.

> 
> ---
> 
> Chuck Lever (2):
>       SUNRPC: Simplify the SVC dispatch code path
>       SUNRPC: De-duplicate .pc_release() call sites
> 
> 
>  include/linux/sunrpc/svc.h |  5 +--
>  net/sunrpc/svc.c           | 69 ++++----------------------------------
>  2 files changed, 8 insertions(+), 66 deletions(-)
> 
> --
> Chuck Lever
