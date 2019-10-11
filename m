Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06213D45B1
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 18:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfJKQrX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 12:47:23 -0400
Received: from fieldses.org ([173.255.197.46]:59044 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKQrX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Oct 2019 12:47:23 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CD21A1C97; Fri, 11 Oct 2019 12:47:22 -0400 (EDT)
Date:   Fri, 11 Oct 2019 12:47:22 -0400
To:     Alkis Georgopoulos <alkisg@gmail.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: bindfs over NFS shows the underlying file system
Message-ID: <20191011164722.GB19318@fieldses.org>
References: <ae761918-245e-e25c-7aab-dd465f7c2461@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae761918-245e-e25c-7aab-dd465f7c2461@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 11, 2019 at 08:24:14AM +0300, Alkis Georgopoulos wrote:
> I'm not sure if this is an NFS issue, or a bindfs issue, or if I'm
> not using the appropriate NFS options.
> 
> I export my /home via NFS with:
> 
>     /home *(rw,async,crossmnt,no_subtree_check,no_root_squash,insecure)
> 
> Inside my /home I'm providing a shared folder with a bindfs mount:
> 
>     bindfs -u 1000 --create-for-user=1000 -g 100
> --create-for-group=100 -p 770,af-x /home/share /home/share
> 
> I.e. this just sets fixed permissions for anything under /home/share.
> 
> And finally I mount /home on some NFS client (or on localhost):
> 
>     mount -t nfs server:/home /home
> 
> The problem is that /home/share on the client doesn't show the
> bindfs permissions, but it shows the underlying file system of the
> server's /home/share.
> The crossmnt NFS option follows submounts with other file systems,
> but not with bindfs.
> 
> On the other hand, if the bindfs source is on a different file
> system than the bindfs target directory, everything works fine (i.e.
> bindfs /other/filesystem/share /home/share).

Huh.  I wonder if nfsd is for some reason determining the existence of a
mountpoint by comparing some kind of filesystem id and not seeing a
change.  Looking at the code to remind myself how this works....

nfsd_mountpoint() is using d_mountpoint() and follow_down(), which
should be right.  Then it's making an upcall to mountd.  That's handled
by nfs-utils/mountd/cache.c:nfsd_export().

The is_mountpoint() check there is indeed going to return false in your
case because it's just comparing inode and device numbers....  But I
think that case is only for the "mountpoint" export option.

So I think all that matters is that export_matches() does the right
thing, and it certainly looks like it does--it should succeed as long as
there's a parent directory that's exported with crossmnt.

There's some debugging you could try by looking at
net/sunrpc/nfsd.*/content or using strace to watch rpc.mountd's reads
and writes of net/sunrpc/nfsd.*/channel.

What version of nfs-utils are you on?

--b.

> 
> Is there any way to configure either NFS or bindfs, so that this
> works when I only have one partition, i.e. when the share is on the
> same file system as /home?
> 
> If anyone answers, please Cc me as I'm not in the list.
> 
> Thank you very much,
> Alkis Georgopoulos
> LTSP developer
