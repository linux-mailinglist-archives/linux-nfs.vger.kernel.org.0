Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43527324576
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 21:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhBXUu1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 15:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBXUu0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 15:50:26 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D79FC061574
        for <linux-nfs@vger.kernel.org>; Wed, 24 Feb 2021 12:49:46 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B096321DD; Wed, 24 Feb 2021 15:49:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B096321DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614199784;
        bh=zmW78dCzPCndNBi6GIzrgluaJ7+krpVi/9TaqVGcvLk=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=OFusuDKRTkujSpQpMd9gvIchoD260BQUuKj08IH6cguSEhHM3dyr+VEvHiD4IB1+W
         8YWEj3HvamPSNyg5ovOt0AQzJF3Equt1604F5/J4oBjZ2r8HUGaw8R0jCjEH7VuDEp
         2V/1jO4bNjVynRhwDCm1RnAec309lLwr/CPHxrv0=
Date:   Wed, 24 Feb 2021 15:49:44 -0500
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/7 V4]  The NFSv4 only mounting daemon.
Message-ID: <20210224204944.GG11591@fieldses.org>
References: <20210219200815.792667-1-steved@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219200815.792667-1-steved@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
> The idea is to allow distros to build a v4 only package
> which will have a much smaller footprint than the
> entire nfs-utils package.
> 
> exportd uses no RPC code, which means none of the 
> code or arguments that deal with v3 was ported, 
> this again, makes the footprint much smaller. 
> 
> The following options were ported:
>     * multiple threads
>     * state-directory-path option
>     * junction support (not tested)
> 
> The rest of the mountd options were v3 only options.
> 
> V2:
>   * Added two systemd services: nfsv4-exportd and nfsv4-server
>   * nfsv4-server starts rpc.nfsd -N 3, so nfs.conf mod not needed.

We really shouldn't make users change how they do things.

Whatever we do, "systemctl start nfs-server" should still be how they
start the NFS server.

--b.

> 
> V3: Changed the name from exportd to nfsv4.exportd
> 
> V4: Added compile flag that will compile in the NFSv4 only server
> 
> Steve Dickson (7):
>   exportd: the initial shell of the v4 export support
>   exportd: Moved cache upcalls routines into libexport.a
>   exportd: multiple threads
>   exportd/exportfs: Add the state-directory-path option
>   exportd: Enabled junction support
>   exportd: systemd unit files
>   exportd: Added config variable to compile in the NFSv4 only server.
> 
>  .gitignore                                |   1 +
>  configure.ac                              |  14 ++
>  nfs.conf                                  |   4 +
>  support/export/Makefile.am                |   3 +-
>  {utils/mountd => support/export}/auth.c   |   4 +-
>  {utils/mountd => support/export}/cache.c  |  46 +++-
>  support/export/export.h                   |  34 +++
>  {utils/mountd => support/export}/fsloc.c  |   0
>  {utils/mountd => support/export}/v4root.c |   0
>  {utils/mountd => support/include}/fsloc.h |   0
>  systemd/Makefile.am                       |   6 +
>  systemd/nfs.conf.man                      |  10 +
>  systemd/nfsv4-exportd.service             |  12 +
>  systemd/nfsv4-server.service              |  31 +++
>  utils/Makefile.am                         |   4 +
>  utils/exportd/Makefile.am                 |  65 +++++
>  utils/exportd/exportd.c                   | 276 ++++++++++++++++++++++
>  utils/exportd/exportd.man                 |  81 +++++++
>  utils/exportfs/exportfs.c                 |  21 +-
>  utils/exportfs/exportfs.man               |   7 +-
>  utils/mountd/Makefile.am                  |   5 +-
>  21 files changed, 606 insertions(+), 18 deletions(-)
>  rename {utils/mountd => support/export}/auth.c (99%)
>  rename {utils/mountd => support/export}/cache.c (98%)
>  create mode 100644 support/export/export.h
>  rename {utils/mountd => support/export}/fsloc.c (100%)
>  rename {utils/mountd => support/export}/v4root.c (100%)
>  rename {utils/mountd => support/include}/fsloc.h (100%)
>  create mode 100644 systemd/nfsv4-exportd.service
>  create mode 100644 systemd/nfsv4-server.service
>  create mode 100644 utils/exportd/Makefile.am
>  create mode 100644 utils/exportd/exportd.c
>  create mode 100644 utils/exportd/exportd.man
> 
> -- 
> 2.29.2
