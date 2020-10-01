Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0072808D1
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 22:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgJAUvZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 16:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAUvU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 16:51:20 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644DDC0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 13:51:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A34211C79; Thu,  1 Oct 2020 16:51:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A34211C79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601585479;
        bh=aiLgju6YQmHFgqyJMByK1huL/q/OKDq79XtQBbowuZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOEFJPn8cexXCxxVKKV6XwJQRN1nohW+deDDj8mQG5yEtDEuX+6DMZAdW+yZzoNpK
         FylNWjVFwMtFIaXzlQVa/s39lc8DMa3+w9Cp7geWOKT7pw2SinSVJxhWt0+0/m/pde
         +RKZAafKZbeCSJWxoXuA9XPvRwXaawDQW4ppV5vc=
Date:   Thu, 1 Oct 2020 16:51:19 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
Message-ID: <20201001205119.GI1496@fieldses.org>
References: <20200923230606.63904-1-dai.ngo@oracle.com>
 <e7e738c6-f6e7-0d04-07fa-8017da469b8a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e738c6-f6e7-0d04-07fa-8017da469b8a@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 29, 2020 at 08:18:54PM -0700, Dai Ngo wrote:
> Have you had chance to review this patch and if it's ok would it be
> possible to include it in the 5.10 pull?

I don't think the op table approach would be that difficult, I'd really
rather see that.

Is this causing someone an immediate practical problem?

--b.

> 
> Thanks,
> 
> -Dai
> 
> On 9/23/20 4:06 PM, Dai Ngo wrote:
> >This patch provides a temporarily relief for inter copy to work with
> >some common configs.  For long term solution, I think Trond's suggestion
> >of using fs/nfs/nfs_common to store an op table that server can use to
> >access the client code is the way to go.
> >
> >  fs/nfsd/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> >Below are the results of my testing of upstream mainline without and with the fix.
> >
> >Upstream version used for testing:  5.9-rc5
> >
> >1. Upstream mainline (existing code: NFS_FS=y)
> >
> >
> >|----------------------------------------------------------------------------------------|
> >|  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
> >|----------------------------------------------------------------------------------------|
> >|   y    |    y     |    m     | Build errors: nfs42_ssc_open/close                      |
> >|----------------------------------------------------------------------------------------|
> >|   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
> >|        |          |          | See NOTE1.                                              |
> >|----------------------------------------------------------------------------------------|
> >|   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
> >|        |          |          | See NOTE2.                                              |
> >|----------------------------------------------------------------------------------------|
> >|   y    |    y     |    y     | Build OK, inter server copy OK                          |
> >|----------------------------------------------------------------------------------------|
> >
> >
> >|----------------------------------------------------------------------------------------|
> >|  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
> >|----------------------------------------------------------------------------------------|
> >|   m    |    y     |    m     | Build OK, inter server copy OK                          |
> >|----------------------------------------------------------------------------------------|
> >|   m    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
> >|----------------------------------------------------------------------------------------|
> >|   m    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
> >|----------------------------------------------------------------------------------------|
> >|   m    |    y     |    y     | Build OK, inter server copy OK                          |
> >|----------------------------------------------------------------------------------------|
> >
> >2. Upstream mainline (with the fix:  !(NFSD=y && (NFS_FS=m || NFS_V4=m))
> >
> >
> >|----------------------------------------------------------------------------------------|
> >|  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
> >|----------------------------------------------------------------------------------------|
> >|   m    |    y     |    m     | Build OK, inter server copy OK                          |
> >|----------------------------------------------------------------------------------------|
> >|   m    |    m     |    m     | Build OK, inter server copy OK                          |
> >|----------------------------------------------------------------------------------------|
> >|   m    |    m     |   y (m)  | Build OK, inter server copy OK                          |
> >|----------------------------------------------------------------------------------------|
> >|   m    |    y     |    y     | Build OK, inter server copy OK                          |
> >|----------------------------------------------------------------------------------------|
> >
> >
> >|----------------------------------------------------------------------------------------|
> >|  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
> >|----------------------------------------------------------------------------------------|
> >|   y    |    y     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
> >|----------------------------------------------------------------------------------------|
> >|   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
> >|----------------------------------------------------------------------------------------|
> >|   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
> >|----------------------------------------------------------------------------------------|
> >|   y    |    y     |    y     | Build OK, inter server copy OK                          |
> >|----------------------------------------------------------------------------------------|
> >
> >NOTE1:
> >BUG:  When inter server copy fails with NFS4ERR_STALE, it left the file
> >created with size of 0!
> >
> >NOTE2:
> >When NFS_V4=y and NFS_FS=m, the build process automatically builds with NFS_V4=m
> >and ignores the setting NFS_V4=y in the config file.
> >
> >This probably due to NFS_V4 in fs/nfs/Kconfig is configured to depend on NFS_FS.
> >
