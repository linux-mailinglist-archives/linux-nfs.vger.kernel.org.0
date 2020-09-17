Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB126E516
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 21:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIQTKK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Sep 2020 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgIQTKD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Sep 2020 15:10:03 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D39C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Sep 2020 12:09:37 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CBBA86196; Thu, 17 Sep 2020 15:09:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CBBA86196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600369771;
        bh=92ekXl9FnEULlC8FIfYrbodzh6YuqTXj8b4Q23bGaho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njcQJ9zNMcz5b/ds+a8bhSShifn8rPyXJ+sSywZJHNWS/FjqHoCrNIZ/FYKuBnRaf
         ZSKDdDK2Jp9RvX2FZ1NDJab43YEQEnlitAy7vJMH0CG2l01iUAG/Uz7tK2C6MGMJqc
         99wofdlTizyv2g8O+jUOkTmh9lXUsSC5aCfS7eT0=
Date:   Thu, 17 Sep 2020 15:09:31 -0400
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>,
        Frank van der Linden <fllinden@amazon.com>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20200917190931.GA6858@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <20200915172140.GA32632@fieldses.org>
 <2001715792.39705019.1600358470997.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2001715792.39705019.1600358470997.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 17, 2020 at 05:01:11PM +0100, Daire Byrne wrote:
> 
> ----- On 15 Sep, 2020, at 18:21, bfields bfields@fieldses.org wrote:
> 
> >> 4) With an NFSv4 re-export, lots of open/close requests (hundreds per
> >> second) quickly eat up the CPU on the re-export server and perf top
> >> shows we are mostly in native_queued_spin_lock_slowpath.
> > 
> > Any statistics on who's calling that function?
> 
> I've always struggled to reproduce this with a simple open/close simulation, so I suspect some other operations need to be mixed in too. But I have one production workload that I know has lots of opens & closes (buggy software) included in amongst the usual reads, writes etc.
> 
> With just 40 clients mounting the reexport server (v5.7.6) using NFSv4.2, we see the CPU of the nfsd threads increase rapidly and by the time we have 100 clients, we have maxed out the 32 cores of the server with most of that in native_queued_spin_lock_slowpath.

That sounds a lot like what Frank Van der Linden reported:

	https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com/

It looks like a bug in the filehandle caching code.

--b.

> 
> The perf top summary looks like this:
> 
> # Overhead  Command          Shared Object                 Symbol                                                 
> # ........  ...............  ............................  .......................................................
> #
>     82.91%  nfsd             [kernel.kallsyms]             [k] native_queued_spin_lock_slowpath
>      8.24%  swapper          [kernel.kallsyms]             [k] intel_idle
>      4.66%  nfsd             [kernel.kallsyms]             [k] __list_lru_walk_one
>      0.80%  nfsd             [kernel.kallsyms]             [k] nfsd_file_lru_cb
> 
> And the call graph (not sure how this will format):
> 
> - nfsd
>    - 89.34% svc_process
>       - 88.94% svc_process_common
>          - 88.87% nfsd_dispatch
>             - 88.82% nfsd4_proc_compound
>                - 53.97% nfsd4_open
>                   - 53.95% nfsd4_process_open2
>                      - 53.87% nfs4_get_vfs_file
>                         - 53.48% nfsd_file_acquire
>                            - 33.31% nfsd_file_lru_walk_list
>                               - 33.28% list_lru_walk_node                    
>                                  - 33.28% list_lru_walk_one                  
>                                     - 30.21% _raw_spin_lock
>                                        - 30.21% queued_spin_lock_slowpath
>                                             30.20% native_queued_spin_lock_slowpath
>                                       2.46% __list_lru_walk_one
>                            - 19.39% list_lru_add
>                               - 19.39% _raw_spin_lock
>                                  - 19.39% queued_spin_lock_slowpath
>                                       19.38% native_queued_spin_lock_slowpath
>                - 34.46% nfsd4_close
>                   - 34.45% nfs4_put_stid
>                      - 34.45% nfs4_free_ol_stateid
>                         - 34.45% release_all_access
>                            - 34.45% nfs4_file_put_access
>                               - 34.45% __nfs4_file_put_access.part.81
>                                  - 34.45% nfsd_file_put
>                                     - 34.44% nfsd_file_lru_walk_list
>                                        - 34.40% list_lru_walk_node
>                                           - 34.40% list_lru_walk_one
>                                              - 31.27% _raw_spin_lock
>                                                 - 31.27% queued_spin_lock_slowpath
>                                                      31.26% native_queued_spin_lock_slowpath
>                                                2.50% __list_lru_walk_one
>                                                0.50% nfsd_file_lru_cb
> 
> 
> The original NFS server is mounted by the reexport server using NFSv4.2. As soon as we switch the clients to mount the reexport server with NFSv3, the high CPU usage goes away and we start to see expected performance for this workload and server hardware.
> 
> I'm happy to share perf data or anything else that is useful and I can repeatedly run this production load as required.
> 
> Cheers,
> 
> Daire
