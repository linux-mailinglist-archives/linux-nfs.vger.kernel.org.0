Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26729297A4E
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Oct 2020 04:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758782AbgJXCJF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Oct 2020 22:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758754AbgJXCJE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Oct 2020 22:09:04 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F9C0613CE;
        Fri, 23 Oct 2020 19:09:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8EFBB6EF1; Fri, 23 Oct 2020 22:09:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8EFBB6EF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603505343;
        bh=oTkEZ0FtoBONxlpTmAUkZC3Y2Ho8JGEOJH4m6h9xLVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NeRpsQW+u12z6TGaV4YnehdFjxUJJYJumHYj6Qoi5RhgE8T3y/G6gZBaZVu/LZwpz
         AjHGiErn84B9BtCl6F9820YI/LfTRfeR3KIeHzVgxG67ltjUJ2s3WbWEtXtuW7TmNT
         yDWWTiduPjui2/MslgN2k3gWICth4oDttut9Rouo=
Date:   Fri, 23 Oct 2020 22:09:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: raise kernel RPC channel buffer size
Message-ID: <20201024020903.GC31481@fieldses.org>
References: <20201019093356.7395-1-rbergant@redhat.com>
 <20201019132000.GA32403@fieldses.org>
 <alpine.DEB.2.21.2010231141460.29805@ramsan.of.borg>
 <20201024000434.GA31481@fieldses.org>
 <CACWnjLw_EJBnz9ywkg=-7HVScJT1gKRmYRda1MWUrPYTWkHXzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACWnjLw_EJBnz9ywkg=-7HVScJT1gKRmYRda1MWUrPYTWkHXzw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 24, 2020 at 03:29:25AM +0200, Roberto Bergantinos Corpas wrote:
> Good point Geert !
> 
> > How about making it a kvmalloc?
> 
> I can post a new patch using kvmalloc, Bruce looks we can also
> prescind of queue_io_mutex, what do you think ?

And revert da77005f0d64, I think. 

Maybe there's something I'm missing, but I don't think we need all that
complexity.

--b.
