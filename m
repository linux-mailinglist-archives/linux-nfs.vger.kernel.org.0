Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853D317B0D3
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2020 22:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCEVlT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Mar 2020 16:41:19 -0500
Received: from fieldses.org ([173.255.197.46]:40770 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgCEVlT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Mar 2020 16:41:19 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 765AB1C22; Thu,  5 Mar 2020 16:41:18 -0500 (EST)
Date:   Thu, 5 Mar 2020 16:41:18 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: v5.7 NFSD merge candidate
Message-ID: <20200305214118.GC18184@fieldses.org>
References: <C95270DC-21FD-4655-9298-35F431A33DE0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C95270DC-21FD-4655-9298-35F431A33DE0@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

By the way, I'm moving this weekend and may be particularly unresponsive
for several days while we pack, unpack, clean the old place, etc., etc.

(And I'm therefore particularly grateful that Chuck's handling nfsd
patches for 5.7.  Please make sure you're including Chuck on any nfsd
patches.)

--b.

On Thu, Mar 05, 2020 at 12:55:03PM -0500, Chuck Lever wrote:
> Hey-
> 
> I've collected NFSD-related patches for the v5.7 merge window in this topic branch:
> 
> https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/nfsd-5.7-testing
> 
> The only remaining items are Trond's change to the server to drop requests,
> and a possible change to the SSC CONFIG dependency to disable it when NFS_FS=m.
> 
> There was one minor merge conflict, between:
> 
> "fs: nfsd: nfs4state.c: Use built-in RCU list checking"
> 
>    and
> 
> "SUNRPC/cache: Allow garbage collection of invalid cache entries"
> 
> Trond, please confirm that I resolved the conflict correctly. Thanks!
> 
> --
> Chuck Lever
> 
