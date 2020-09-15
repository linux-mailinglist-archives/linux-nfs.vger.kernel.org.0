Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8622326AC03
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Sep 2020 20:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgIOSdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Sep 2020 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgIOSdO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Sep 2020 14:33:14 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC14C06174A;
        Tue, 15 Sep 2020 11:33:11 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 769F2425E; Tue, 15 Sep 2020 14:33:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 769F2425E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600194790;
        bh=Gzs0g7lW696ivl7ubWpdXh2/Wk4Ipx8dGRXKZd2l9RE=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=bW7m9iDz5Y4O1XoA29QxZDV1G6WuqJ1223x3/+QIHuVEkUK+HjpDUvjRsEeWAx5pF
         +ntKDBlKmaugVxJWU67WddvR3cPAZkbWrOvEK693RrimM9VtDtBEVyz08tfX1lJDDd
         /xaJAq3zWanpZFfuujis97ADehMctwrs5amDpNxw=
Date:   Tue, 15 Sep 2020 14:33:10 -0400
To:     Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: Fix security label length not being reset
Message-ID: <20200915183310.GB32632@fieldses.org>
References: <20200914154958.55451-1-jeffrey.mitchell@starlab.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914154958.55451-1-jeffrey.mitchell@starlab.io>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 14, 2020 at 10:49:57AM -0500, Jeffrey Mitchell wrote:
> nfs_readdir_page_filler() iterates over entries in a directory, reusing
> the same security label buffer, but does not reset the buffer's length.
> This causes decode_attr_security_label() to return -ERANGE if an entry's
> security label is longer than the previous one's. This error, in
> nfs4_decode_dirent(), only gets passed up as -EAGAIN, which causes another
> failed attempt to copy into the buffer. The second error is ignored and
> the remaining entries do not show up in ls, specifically the getdents64()
> syscall.
> 
> Reproduce by creating multiple files in NFS and giving one of the later
> files a longer security label. ls will not see that file nor any that are
> added afterwards, though they will exist on the backend.

Please include these paragraphs in the changelog.

--b.

> 
> - Jeffrey
> 
> Jeffrey Mitchell (1):
>   nfs: Fix security label length not being reset
> 
>  fs/nfs/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> -- 
> 2.25.1
