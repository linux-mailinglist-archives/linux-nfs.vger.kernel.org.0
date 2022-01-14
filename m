Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D868048EC51
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 16:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiANPKY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 10:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiANPKX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 10:10:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28327C061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 07:10:23 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 10ECA72FB; Fri, 14 Jan 2022 10:10:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 10ECA72FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642173022;
        bh=FJcE37Wso4iNYs+zrkcrYh9bPFiGEB3Q7wWPx+X4qQQ=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=FC+QSdxxA14yIVu0frKCmGn4hv+3COfNqA/Pz6oz2/WmjDCmWMPPYmKBVXkQT4UNq
         y6L3wYLbP4xt14CtOPT2KYRkJgdwYtaEnvEbHHlU2OdCWDmBmR2ak4Tq9tmng2L9gb
         L0/Q3K4+GjrPHuNrGogogK0XWC1UgaCSObr8W7X4=
Date:   Fri, 14 Jan 2022 10:10:22 -0500
To:     Chris Chilvers <chilversc@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [bug report] Resolving symlinks ignores rootdir setting
Message-ID: <20220114151022.GA17563@fieldses.org>
References: <CAAmbk-f7B4jfmhe-aH26E0eRQnOxGGFPr3yHZMv0F4KQc6FVdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmbk-f7B4jfmhe-aH26E0eRQnOxGGFPr3yHZMv0F4KQc6FVdg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 14, 2022 at 12:36:23PM +0000, Chris Chilvers wrote:
> I was testing using the rootdir setting in nfs.config to allow using export
> paths that would normally conflict with local systems directories with NFS v3.
> 
> The idea was to support re-exporting a source NFS server such as NetApp that
> might exports arbitrary paths such as /home without overwriting the /home
> directory on the NFS server, and even support exporting a root directory similar
> to NFS v4.
> 
> While testing I ran into an issue where the NFS server would fail to start.
> During start up, the NFS server would log the error:
> 
>   $ systemctl status nfs-server.service
>   systemd[1]: Starting NFS server and services...
>   exportfs[2307]: exportfs: Failed to stat /srv/nfs/usr/bin: No such
> file or directory
>   systemd[1]: nfs-server.service: Control process exited, code=exited,
> status=1/FAILURE
> 
>   $ cat nfs.config
>   [exports]
>   rootdir=/srv/nfs
> 
>   $ cat /etc/exports
>   /         10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_check,sec=sys,secure,fsid=0,nohide)
>   /assets   10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_check,sec=sys,secure,fsid=10,nohide)
>   /bin      10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_check,sec=sys,secure,fsid=30,nohide)
>   /software 10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_check,sec=sys,secure,fsid=40,nohide)
> 
> If I create the directory /srv/nfs/usr/bin then the NFS server will start.
> Listing the actual exports shows that a different path was exported compared to
> the path from /etc/exports.
> 
>   $ exportfs -s
>   / 10.0.0.0/8(sync,wdelay,nohide,no_subtree_check,fsid=0,sec=sys,rw,secure,no_root_squash,no_all_squ>
>   /assets 10.0.0.0/8(sync,wdelay,nohide,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_>
>   /usr/bin 10.0.0.0/8(sync,wdelay,nohide,no_subtree_check,fsid=30,sec=sys,rw,secure,no_root_squash,no>
>   /software 10.0.0.0/8(sync,wdelay,nohide,no_subtree_check,fsid=40,sec=sys,rw,secure,no_root_squash,n>
> 
> To test this further I create a symlink from /software to /usr/lib. Once again
> the server failed to start because it could not find /srv/nfs/usr/lib.

I'm probably just reading too quickly, but I'm not seeing how this
explains the problems with your original configuration.

Is it that /sr/nfs/bin on you system is a symlink?  (And what exactly is
the content of that symlink?)

(Also, for what it's worth, we don't recommend using fsid=0 any more.
It should be unnecessary.)

--b.

> 
> Reading through the source, I think the issue is in the getexportent function in
> support/nfs/exports.c.
> 
>     /* resolve symlinks */
>     if (realpath(ee.e_path, rpath) != NULL) {
>         rpath[sizeof (rpath) - 1] = '\0';
>         strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
>         ee.e_path[sizeof (ee.e_path) - 1] = '\0';
>     }
> 
> It appears this function does not take into account the rootdir property when
> resolving e_path.
> 
> This was tested on Ubuntu 20.04 with the 5.11.8-051108-generic kernel. nfs-utils
> version is 2.5.3.
