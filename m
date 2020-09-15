Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6719126AA73
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Sep 2020 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgIORXk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Sep 2020 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgIORVn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Sep 2020 13:21:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288AC061788
        for <linux-nfs@vger.kernel.org>; Tue, 15 Sep 2020 10:21:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 915E67EC; Tue, 15 Sep 2020 13:21:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 915E67EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600190500;
        bh=64NKhEMy3G6Usr7RizKHUe0/PgW9C7nGVNj2fkaTP28=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=UYD180hna+1yW/yZyJep/WhJ6Gi4IGtxxHhO3LhTd8BLQjECBIlto3ACF6c60a+B1
         vptIpwzPBktwQyxCCKTbQ+AAxrkLI6FwLjdiQtXsHj30fo31WDwmbcum+WOmfXYVaj
         +hPbr60WwQy9bXwOAXrTVO3Xa2PtHJcUjfmK78aI=
Date:   Tue, 15 Sep 2020 13:21:40 -0400
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20200915172140.GA32632@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 07, 2020 at 06:31:00PM +0100, Daire Byrne wrote:
> 1) The kernel can drop entries out of the NFS client inode cache (under memory cache churn) when those filehandles are still being used by the knfsd's remote clients resulting in sporadic and random stale filehandles. This seems to be mostly for directories from what I've seen. Does the NFS client not know that knfsd is still using those files/dirs? The workaround is to never drop inode & dentry caches on the re-export servers (vfs_cache_pressure=1). This also helps to ensure that we actually make the most of our actimeo=3600,nocto mount options for the full specified time.

I thought reexport worked by embedding the original server's filehandles
in the filehandles given out by the reexporting server.

So, even if nothing's cached, when the reexporting server gets a
filehandle, it should be able to extract the original filehandle from it
and use that.

I wonder why that's not working?

> 4) With an NFSv4 re-export, lots of open/close requests (hundreds per
> second) quickly eat up the CPU on the re-export server and perf top
> shows we are mostly in native_queued_spin_lock_slowpath.

Any statistics on who's calling that function?

> Does NFSv4
> also need an open file cache like that added to NFSv3? Our workaround
> is to either fix the thing doing lots of repeated open/closes or use
> NFSv3 instead.

NFSv4 uses the same file cache.  It might be the file cache that's at
fault, in fact....

--b.
