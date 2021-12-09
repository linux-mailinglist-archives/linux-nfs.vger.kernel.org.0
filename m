Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6137C46F61C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 22:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhLIVpP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 16:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLIVpO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 16:45:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BFEC061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 13:41:40 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7CA7B6EB4; Thu,  9 Dec 2021 16:41:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7CA7B6EB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639086099;
        bh=BGO1yhjcOAF8nLUWdiqVyxgsIz4EUuW1Ymd4DVUawow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdZWbYKr1hkzgHg/Q+9yFlKprvE1T38uQCBqTFCqQHuH2gpgCr584m8uDn2z8jsLF
         +Y2uYm3iDtF7wB/jBfafDfqXu2lrpmpd9/EFtgGifX3WmUHirva2cTV+bbxpiaskR9
         yLCpk9dIJfVqyrZgLb/Sebzfu3CCiBnFleKjisd4=
Date:   Thu, 9 Dec 2021 16:41:39 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        david <david@sigma-star.at>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: Improving NFS re-export
Message-ID: <20211209214139.GA23483@fieldses.org>
References: <1576494286.153679.1639083948872.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576494286.153679.1639083948872.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 09, 2021 at 10:05:48PM +0100, Richard Weinberger wrote:
> Hello NFS list,
> 
> I'd like to improve the NFS re-export feature, especially wrt. crossmounts.
> Currently a NFS client will face EIO when crossing a mount point on the re-exporting server.
> This was discussed here[0]. While in that discussion the assumption was that check_export()
> in fs/nfsd/export.c emits EIO I did further experiments and realized that EIO actually
> comes from the NFS client side of the re-exporting server.
> 
> nfs_encode_fh() in fs/nfs/export.c checks for IS_AUTOMOUNT(inode), if this is the case
> it refuses to create a new file handle.
> So while accessing /files/disk2 directly on the re-exporting server triggers an automount,
> accessing via nfsd the export function of the client side gives up.
> 
> AFAIU the suggested proxy-only-mode[1] will not address this problem, right?

That's how I was thinking of addressing the problem, actually.  I
haven't figured out how to make that proxy-only mode work, though.

> One workaround is manually adding an export for each volume on the re-exporting server.
> This kinda works but is tedious and error prone.
> 
> I have a crazy idea how to automate this:
> Since nfs_encode_fh() in the NFS client side of the re-exporting server can detect
> crossing mounts, we could install a new export on the sever side as soon the
> IS_AUTOMOUNT(inode) case arises. We could even use the same fsid.
> What do you think?

Something like that might work.

I'm not sure what you mean by the same fsid.  I think you'd need to make
up a new fsid each time you encounter a new filesystem.  And you'd also
want to persist it on disk if you want this to keep working across
reboots of the proxy.

I think you could patch rpc.mountd to do that.

> Another obstacle is file handle wrapping.
> When re-exporting, the NFS client side adds inode and file information to each file handle,
> the server side also adds information. In my test setup this enlarges a 16 bytes file handle
> to 40 bytes.
> The proxy-only-mode won't help us either here.

Part of my motivation for a proxy-only mode was to remove that wrapping.

Since you're dedicating the host to reexporting one single backend
server, in theory you don't need any of the information in the wrapper.
When you (the proxy) get a filehandle from a client, you know which
server that filehandle originally came from, so you can go ask that
server for whatever you need to know about the filehandle (like an
fsid).

> Did you consider using the opaque file handle from the server as
> lookup key in a (persisted) data structure?

A little, but I don't think it works.

If you do this, you do need to require that you only export one server.
Otherwise there may be collisions (two different servers could return
filehandles that happen to have the same value).

The database would store every filehandle the client has ever seen.
That could be a lot.  It may also include filehandles for since-deleted
files.  The only way to prune such entries would be to try using them
and see if the server gives you STALE errors.

--b.

> That way at least the client side of the re-exporting server no longer has to enlarge
> the file handle with inode and file type information.
> If the re-exporting server re-exports just one server (proxy-only-mode) we could also
> skip adding the fsid to the handle.
> What do you think?
> 
> I'm looking forward to hear your comments.
> 
> Thanks,
> //richard
> 
> [0] https://marc.info/?l=linux-nfs&m=161670807413876&w=2
> [1] https://linux-nfs.org/wiki/index.php/NFS_proxy-only_mode
