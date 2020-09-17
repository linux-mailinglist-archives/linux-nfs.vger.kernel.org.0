Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6FD26E479
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIQSuR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Sep 2020 14:50:17 -0400
Received: from natter.dneg.com ([193.203.89.68]:38118 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbgIQQ1I (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Sep 2020 12:27:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 36BE1B0680B;
        Thu, 17 Sep 2020 17:01:38 +0100 (BST)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 3je4s6HGCzxe; Thu, 17 Sep 2020 17:01:38 +0100 (BST)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 191BBB06809;
        Thu, 17 Sep 2020 17:01:38 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 1780C80F1D81;
        Thu, 17 Sep 2020 17:01:37 +0100 (BST)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wsjrLT35cdiY; Thu, 17 Sep 2020 17:01:37 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id BB38280EDFB9;
        Thu, 17 Sep 2020 17:01:25 +0100 (BST)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ri5mXHdgaUYB; Thu, 17 Sep 2020 17:01:25 +0100 (BST)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 42A2F80EDFBF;
        Thu, 17 Sep 2020 17:01:10 +0100 (BST)
Date:   Thu, 17 Sep 2020 17:01:11 +0100 (BST)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Message-ID: <2001715792.39705019.1600358470997.JavaMail.zimbra@dneg.com>
In-Reply-To: <20200915172140.GA32632@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <20200915172140.GA32632@fieldses.org>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: dwTmffFxritSIvyCsoLtMhvw7aelKw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 15 Sep, 2020, at 18:21, bfields bfields@fieldses.org wrote:

>> 4) With an NFSv4 re-export, lots of open/close requests (hundreds per
>> second) quickly eat up the CPU on the re-export server and perf top
>> shows we are mostly in native_queued_spin_lock_slowpath.
> 
> Any statistics on who's calling that function?

I've always struggled to reproduce this with a simple open/close simulation, so I suspect some other operations need to be mixed in too. But I have one production workload that I know has lots of opens & closes (buggy software) included in amongst the usual reads, writes etc.

With just 40 clients mounting the reexport server (v5.7.6) using NFSv4.2, we see the CPU of the nfsd threads increase rapidly and by the time we have 100 clients, we have maxed out the 32 cores of the server with most of that in native_queued_spin_lock_slowpath.

The perf top summary looks like this:

# Overhead  Command          Shared Object                 Symbol                                                 
# ........  ...............  ............................  .......................................................
#
    82.91%  nfsd             [kernel.kallsyms]             [k] native_queued_spin_lock_slowpath
     8.24%  swapper          [kernel.kallsyms]             [k] intel_idle
     4.66%  nfsd             [kernel.kallsyms]             [k] __list_lru_walk_one
     0.80%  nfsd             [kernel.kallsyms]             [k] nfsd_file_lru_cb

And the call graph (not sure how this will format):

- nfsd
   - 89.34% svc_process
      - 88.94% svc_process_common
         - 88.87% nfsd_dispatch
            - 88.82% nfsd4_proc_compound
               - 53.97% nfsd4_open
                  - 53.95% nfsd4_process_open2
                     - 53.87% nfs4_get_vfs_file
                        - 53.48% nfsd_file_acquire
                           - 33.31% nfsd_file_lru_walk_list
                              - 33.28% list_lru_walk_node                    
                                 - 33.28% list_lru_walk_one                  
                                    - 30.21% _raw_spin_lock
                                       - 30.21% queued_spin_lock_slowpath
                                            30.20% native_queued_spin_lock_slowpath
                                      2.46% __list_lru_walk_one
                           - 19.39% list_lru_add
                              - 19.39% _raw_spin_lock
                                 - 19.39% queued_spin_lock_slowpath
                                      19.38% native_queued_spin_lock_slowpath
               - 34.46% nfsd4_close
                  - 34.45% nfs4_put_stid
                     - 34.45% nfs4_free_ol_stateid
                        - 34.45% release_all_access
                           - 34.45% nfs4_file_put_access
                              - 34.45% __nfs4_file_put_access.part.81
                                 - 34.45% nfsd_file_put
                                    - 34.44% nfsd_file_lru_walk_list
                                       - 34.40% list_lru_walk_node
                                          - 34.40% list_lru_walk_one
                                             - 31.27% _raw_spin_lock
                                                - 31.27% queued_spin_lock_slowpath
                                                     31.26% native_queued_spin_lock_slowpath
                                               2.50% __list_lru_walk_one
                                               0.50% nfsd_file_lru_cb


The original NFS server is mounted by the reexport server using NFSv4.2. As soon as we switch the clients to mount the reexport server with NFSv3, the high CPU usage goes away and we start to see expected performance for this workload and server hardware.

I'm happy to share perf data or anything else that is useful and I can repeatedly run this production load as required.

Cheers,

Daire
