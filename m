Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4EB280838
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgJAUGE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 16:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAUGE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 16:06:04 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B5FC0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 13:06:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7B1251BE7; Thu,  1 Oct 2020 16:06:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7B1251BE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601582763;
        bh=DKlpskHl6ZIUeSQkATu92tnPQsx5t5B+z2h5eC57xGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jWpcS12CBY91RL0M5uf9ot5XVEXiS6qr6n69eSjMrFGjin6UMCg2IID7RhdL/G7Ls
         R7BsMkpjN0F53rE3cRKRtHkTdNzvRhv55bJuaJu3TE6auMsXRJRqKVz3SZhRpow+e2
         0DfDfrP/xn+fLZXKXowK0sEuAU/AqSQvbL44dWlc=
Date:   Thu, 1 Oct 2020 16:06:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: rpcbind redux
Message-ID: <20201001200603.GH1496@fieldses.org>
References: <6b0c5514-ebb1-fde7-abba-7f4130b3d59f@math.utexas.edu>
 <20201001183036.GD1496@fieldses.org>
 <f621c004-3402-09d0-b2d0-83d610525a7c@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f621c004-3402-09d0-b2d0-83d610525a7c@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 01, 2020 at 01:41:39PM -0500, Patrick Goetz wrote:
> Hi Bruce,
> 
> Thanks for the reply. See below.
> 
> On 10/1/20 1:30 PM, J. Bruce Fields wrote:
> >On Fri, Sep 25, 2020 at 09:40:16AM -0500, Patrick Goetz wrote:
> >>My University information security office does not like rpcbind and
> >>will automatically quarantine any system for which they detect a
> >>portmapper running on an exposed port.
> >>
> >>Since I exclusively use NFSv4 I was happy to "learn" that NFSv4
> >>doesn't require rpcbind any more.  For example, here's what it says
> >>in the current RHEL documentation:
> >>
> >>"NFS version 4 (NFSv4) works through firewalls and on the Internet,
> >>no longer requires an rpcbind service, supports Access Control Lists
> >>(ACLs), and utilizes stateful operations."
> >>
> >>https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_file_systems/exporting-nfs-shares_managing-file-systems#introduction-to-nfs_exporting-nfs-shares
> >>
> >>I'm using Ubuntu 20.04 rather than RHEL, but the nfs-server service
> >>absolutely will not start if it can't launch rpcbind as a precursor:
> >>
> >>-----------------------------
> >>root@helios:~# systemctl stop rpcbind
> >>Warning: Stopping rpcbind.service, but it can still be activated by:
> >>   rpcbind.socket
> >>root@helios:~# systemctl mask rpcbind
> >>Created symlink /etc/systemd/system/rpcbind.service → /dev/null.
> >>
> >>root@helios:~# systemctl restart nfs-server
> >>Job for nfs-server.service canceled.
> >>root@helios:~# systemctl status nfs-server
> >>● nfs-server.service - NFS server and services
> >>      Loaded: loaded (/lib/systemd/system/nfs-server.service;
> >>enabled; vendor preset: enabled)
> >>     Drop-In: /run/systemd/generator/nfs-server.service.d
> >>              └─order-with-mounts.conf
> >>      Active: failed (Result: exit-code) since Fri 2020-09-25
> >>14:21:46 UTC; 10s ago
> >>     Process: 3923 ExecStartPre=/usr/sbin/exportfs -r (code=exited,
> >>status=0/SUCCESS)
> >>     Process: 3925 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS
> >>(code=exited, status=1/FAILURE)
> >>     Process: 3931 ExecStopPost=/usr/sbin/exportfs -au (code=exited,
> >>status=0/SUCCESS)
> >>     Process: 3932 ExecStopPost=/usr/sbin/exportfs -f (code=exited,
> >>status=0/SUCCESS)
> >>    Main PID: 3925 (code=exited, status=1/FAILURE)
> >>
> >>Sep 25 14:21:46 helios systemd[1]: Starting NFS server and services...
> >>Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: writing fd to
> >>kernel failed: errno 111 (Connection refused)
> >>Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: unable to set any
> >>sockets for nfsd
> >>Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Main process
> >>exited, code=exited, status=1/FAILURE
> >>Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Failed with
> >>result 'exit-code'.
> >>Sep 25 14:21:46 helios systemd[1]: Stopped NFS server and services.
> >>-----------------------------
> >>
> >>So, now I'm confused.  Does NFSv4 need rpcbind to be running, does
> >>it just need it when it launches, or something else?  I made a local
> >>copy of the systemd service file and edited out the rpcbind
> >>dependency, so it's not that.
> >
> >Do you have v2 and v3 turned off in /etc/nfs.conf?
> 
> It's an Ubuntu system, hence doesn't use /etc/nfs.conf; however I do
> have these variables set in /etc/default/nfs-kernel-server :
> 
>   MOUNTD_NFS_V2="no"
>   MOUNTD_NFS_V3="no"
>   RPCMOUNTDOPTS="--manage-gids -N 2 -N 3"
> 
> maybe this isn't the correct way to disable NFSv2/3, but it's all I
> could find documented.

That should do it, but if you want to verify that it worked, you can
read /proc/fs/nfsd/versions.

> The linux kernel version is 5.4.0, and the nfs-kernel-server package
> version is 1:1.3.4-2.5ubuntu3.3 (so upstream 1.3.4), but I'm not
> sure this is relevant.

I can't reproduce the problem on my 5.9-ish server, but I also can't
recall any relevant changes here.

Looking back through the history....  Kinglong Mee fixed the server to
ignore rpbind failures in the v4-only case about 7 years ago, back in
4.13.

--b.
