Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E2643FD81
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 15:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJ2NsE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 09:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJ2NsE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 09:48:04 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3301C061570
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 06:45:35 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 59EE76FFA; Fri, 29 Oct 2021 09:45:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 59EE76FFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635515134;
        bh=E7R3o4HyUtX07uiEQXgDnrNbkDv01+WYeuvwJS+b9Vo=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=rHXeh7wXUfQNOTwWV1Svodk+ZNvpABGS79XVX7ZGdcZBefpYpNKxQ3eW6GgEqA+M+
         RIEx7OTTdLsaiC+g0uxPR864CWS31jnr21/186HmpFxkIV6u7vuWt0J6QPKX22LDqT
         gW1eEP3ay4N1rjUP40A16o1/ttQNQiC7aSDse0EY=
Date:   Fri, 29 Oct 2021 09:45:34 -0400
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Message-ID: <20211029134534.GA19967@fieldses.org>
References: <20211028144851.644018-1-steved@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028144851.644018-1-steved@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 28, 2021 at 10:48:50AM -0400, Steve Dickson wrote:
> This kernel patch and an upcoming nfs-utils patch
> adds a new export option 's2sc' which will allow
> inter server to server copies.

They're already allowed by a module option.  Why is an export option
better?  And why should it be set on the destination server and not the
source server?

Really, first I think we should try to identify what the problem is that
we're trying to solve.

--b.

> 
> The option needs to be set on the destination server.
> 
> The idea behind the option is to allow admins the 
> ability to control which export can do these 
> types of copies.
> 
> Steve Dickson (1):
>   nfsd4_copy: Adds the ability to do inter server to server on an export
> 
>  fs/nfsd/nfs4proc.c               | 3 ++-
>  include/uapi/linux/nfsd/export.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> -- 
> 2.31.1
