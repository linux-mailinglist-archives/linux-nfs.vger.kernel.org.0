Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871042FBE82
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 19:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404487AbhASSDr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 13:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbhASSCp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jan 2021 13:02:45 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8641C061573
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jan 2021 10:02:05 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B836C6C0D; Tue, 19 Jan 2021 13:02:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B836C6C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611079324;
        bh=YTYenTieYD2gyH+6H87D0FmX5wOOOaBTYACSTUl1A68=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=M08QKkUpwv+hNmf0D3xvhU+/IEpZs9I8+XFHLvDM75Ys1mPHXWhXcSvE9mgy8vzno
         8/QYXgcCiB0/0d7TgxtrfkltgA0qAQ6T4JHdcaQCOiC+oRQ/i/2aVtA6/2UA08rpq+
         aVM8+k49zafXht8QGk28ssYvdrdZsZB6uO411NRY=
Date:   Tue, 19 Jan 2021 13:02:04 -0500
To:     Benjamin Maynard <benmaynard@google.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Linux 5.11 Kernel: NFS re-export errors with older nfs-utils
 package versions
Message-ID: <20210119180204.GA24213@fieldses.org>
References: <CA+QRt4vb=DjgcOqGLtfdfKiDaqKED825xNpNyQaaK-df5tCSRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QRt4vb=DjgcOqGLtfdfKiDaqKED825xNpNyQaaK-df5tCSRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 18, 2021 at 05:57:54PM +0000, Benjamin Maynard wrote:
> Hi,
> 
> I was recently experimenting with NFS re-exporting using the new patch
> set that is in the Linux 5.11 kernel
> (https://patchwork.kernel.org/project/linux-nfs/list/?series=393561).
> 
> After applying these patches, I consistently faced an error when
> trying to perform a previously working NFS re-export: "exportfs:
> /files does not support NFS export".
> 
> I (with help from some other interested parties) began troubleshooting
> and after stepping through each patch individually we identified that
> the error only occurred when the following patch was applied:
> https://patchwork.kernel.org/project/linux-nfs/patch/20201130220319.501064-3-trond.myklebust@hammerspace.com/.

That link isn't working for me for some reason.

Looks like we're talking about ba5e8187c555 "nfsd: allow filesystems to
opt out of subtree checking".

> This patch prevents re-exporting if subtree checking is enabled on the
> originating NFS server.

That's not correct.

I'm assuming there are two servers: a reexporting server, which mounts
the originating NFS server, which is mounting ext4 or xfs or some other
local filesystem.

It's hard for the reexporting server to even tell if the originating
server is using subtree checking, so I'm surprised that would make a
difference in behavior.

> The strange thing was that no_subtree_check
> export option was already set on the export from the originating NFS
> Filer, but the error message persisted.

So, this patch is only checks whether you've got no_subtree_check set on
the reexporting server.

> After lots of troubleshooting, eventually we tried updating NFS Utils
> from 1.3.4 to 2.5.2 and we were able to successfully perform
> re-export. It appears that the old version of the nfs-utils package
> was the cause of the issue.

I'm a little confused about what happened here.  Which server were you
applying the above patches on?  Which server did you upgrade NFS utils
on?

Could be that you're actually running into some filehandle size limit or
something.  (Subtree checking can make that problem worse.)  Hard to
tell.

--b.

> I appreciate that 1.3.4 is a very old version of nfs-utils, but it is
> the default version that ships with Ubuntu and Debian and the error
> message does not immediately point to the outdated version being the
> cause of the problem.
> 
> I was wondering if it was possible to detail the requirement for a
> more recent version of nfs-utils in the NFS Re-exporting section of
> the Wiki (http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export) to
> help others who may encounter this problem in the future?
