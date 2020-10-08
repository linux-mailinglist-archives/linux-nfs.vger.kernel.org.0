Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B12287B49
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJHR6E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Oct 2020 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJHR6E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Oct 2020 13:58:04 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DE4C061755
        for <linux-nfs@vger.kernel.org>; Thu,  8 Oct 2020 10:58:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9555F6EF0; Thu,  8 Oct 2020 13:58:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9555F6EF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602179883;
        bh=kPpYtnUt4nRld0oIrX5N+NaYGso2dvbs9Al3BGLYPf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmHOFvQ1wAjJEqGddXxmD7GZoi2dftVytgO4x0/3WxGGk8xN15FXcc9vowEh53fVk
         YnRnZlesYY+H1yrBQNd3XvMqSqTdXxG5kNVi2Rf09xaDkKia3xqRIIYBLOMuhU3PkL
         PvkTz1dn618SXSYhh8opn1bHeSJKz36qOWZxzqec=
Date:   Thu, 8 Oct 2020 13:58:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
Message-ID: <20201008175803.GA18179@fieldses.org>
References: <20201008012513.89989-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008012513.89989-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 07, 2020 at 09:25:12PM -0400, Dai Ngo wrote:
> This cover email is intended for including my test results.
> 
> This patch adds the ops table in nfs_common for knfsd to access
> NFS client modules without calling these functions directly.
> 
> The client module registers their functions and deregisters them
> when the module is loaded and unloaded respectively.
> 
>  fs/nfs/nfs4file.c       |  44 ++++++++++++--
>  fs/nfs/nfs4super.c      |   6 ++
>  fs/nfs/super.c          |  20 +++++++
>  fs/nfs_common/Makefile  |   1 +
>  fs/nfs_common/nfs_ssc.c | 136 +++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/Kconfig         |   2 +-
>  fs/nfsd/nfs4proc.c      |   3 +-
>  include/linux/nfs_ssc.h |  77 ++++++++++++++++++++++++
>  8 files changed, 281 insertions(+), 8 deletions(-)
> 
> Test Results:
> 
> Upstream version used for testing:  5.9-rc5
> 
> |----------------------------------------------------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |       RESULTS             |
> |----------------------------------------------------------|
> |   m    |    y     |    m     | inter server copy OK      |
> |----------------------------------------------------------|
> |   m    |    m     |    m     | inter server copy OK      |
> |----------------------------------------------------------|
> |   m    |    m     |   y (m)  | inter server copy OK      |
> |----------------------------------------------------------|
> |   m    |    y     |    y     | inter server copy OK      |
> |----------------------------------------------------------|
> |   m    |    n     |    n     | NFS4ERR_STALE error       |
> |----------------------------------------------------------|

Why are there two?  And how are you getting that NFS4ERR_STALE case?
NFSD_V4_2_INTER_SSC depends on NFS_FS, so it shouldn't be possible to
build server-to-server-copy support without building the client.  And if
you don't build NFSD_V4_2_INTER_SSC at all, then I think it should be
returning NOTSUPP instead of STALE.

--b.

> |----------------------------------------------------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |        RESULTS            |
> |----------------------------------------------------------|
> |   y    |    y     |    m     | inter server copy OK      |
> |----------------------------------------------------------|
> |   y    |    m     |    m     | inter server copy OK      |
> |----------------------------------------------------------|
> |   y    |    m     |   y (m)  | inter server copy OK      |
> |----------------------------------------------------------|
> |   y    |    y     |    y     | inter server copy OK      |
> |----------------------------------------------------------|
> |   y    |    n     |    n     | NFS4ERR_STALE error       |
> |----------------------------------------------------------|
> 
> NOTE:
> When NFS_V4=y and NFS_FS=m, the build process automatically builds
> with NFS_V4=m and ignores the setting NFS_V4=y in the config file. 
> 
> This probably due to NFS_V4 in fs/nfs/Kconfig is configured to
> depend on NFS_FS.
