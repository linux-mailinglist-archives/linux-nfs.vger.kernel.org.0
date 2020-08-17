Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31519247A5A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Aug 2020 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgHQWUh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 18:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgHQWUg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 18:20:36 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DAAC061342
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 15:20:36 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9AF69BC6; Mon, 17 Aug 2020 18:20:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9AF69BC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597702834;
        bh=4TSg28WsHIaowTE0E0BvK0rOhJqFyIMmcB3bKBPxQZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFsNGp2jUHPhweSevJ1uqp3R5TivLQXsdySrFfgfAa1Ch/PVC5ylz6VPFhoVT2z6x
         JTOGDwdbuz1jYt4xiT/DhKcxK+lXQUeatTUUxZgOStzvM/OXj/1o7ZzWmj4CXehrrE
         ZXHCcFfEP52MHMOgUTVaEU8OCyLoBXU6YoNJllGk=
Date:   Mon, 17 Aug 2020 18:20:34 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
Message-ID: <20200817222034.GA6390@fieldses.org>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org>
 <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
 <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
 <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Aug 16, 2020 at 04:46:00PM -0400, Chuck Lever wrote:
> Hi Bruce-
> 
> > On Aug 11, 2020, at 9:31 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> > 
> >> On Aug 10, 2020, at 4:10 PM, Bruce Fields <bfields@fieldses.org> wrote:
> >> 
> >> On Mon, Aug 10, 2020 at 04:01:00PM -0400, Chuck Lever wrote:
> >>> Roughly the same result with this patch as with the first one. The
> >>> first one is a little better. Plus, I think the Solaris NFS server
> >>> hands out write delegations on v4.0, and I haven't heard of a
> >>> significant issue there. It's heuristics may be different, though.
> >>> 
> >>> So, it might be that NFSv4.0 has always run significantly slower. I
> >>> will have to try a v5.4 or older server to see.
> >> 
> >> Oh, OK, I was assuming this was a regression.
> > 
> > Me too. Looks like it is: NFSv4.0 always runs slower, but I see
> > it get significantly worse between v5.4 and 5.5. I will post more
> > quantified results soon.
> 
> It took me a while to get plausible bisection results. The problem
> appears in the midst of the NFSD filecache patches merged in v5.4.

Well, that's interesting.

> In order of application:
> 
> 5920afa3c85f ("nfsd: hook nfsd_commit up to the nfsd_file cache")
> 961.68user 5252.40system 20:12.30elapsed 512%CPU, 2541 DELAY errors
> These results are similar to v5.3.
> 
> fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use nfsd_files")
> Does not build
> 
> eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields to nfsd_file")
> 966.92user 5425.47system 33:52.79elapsed 314%CPU, 1330 DELAY errors
> 
> Can you take a look and see if there's anything obvious?

Unfortunately nothing about the file cache code is very obvious to me.
I'm looking at it....

It adds some new nfserr_jukebox returns in nfsd_file_acquire.  Those
mostly look like kmalloc failures, the one I'm not sure about is the
NFSD_FILE_HASHED check.

Or maybe it's the lease break there.

--b.
