Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD67920A677
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407043AbgFYUOW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407059AbgFYUOV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 16:14:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB02C08C5C1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2020 13:14:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A05F4799F; Thu, 25 Jun 2020 16:14:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A05F4799F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593116060;
        bh=uCXdgRU12aGE+GXJP2NzDT31gtz3Yf6jQn1i6vA7GDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwOBjiQg6e0y9scB8TaQOi1BkoU4FIQ7R29VREtlZwhHiYJIcgfGw5Uo6wfqg/z4K
         Pl9+3SDp88VVrHEdNFWZi79plh2uPgv0DaRy0E8FARxrqjn9phXKzzSY4MbUOpj0lv
         zES1cCso0h7F9b+4k8UJANBUt+z6yeKdJsdZhgVk=
Date:   Thu, 25 Jun 2020 16:14:20 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Strange segmentation violations of rpc.gssd in Debian Buster
Message-ID: <20200625201420.GC6605@fieldses.org>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
 <20200619220434.GB1594@fieldses.org>
 <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 25, 2020 at 05:43:53PM +0000, Kraus, Sebastian wrote:
> Dear Bruce,
> I got the following stack and back trace:
> 
> root@all:~# coredumpctl debug
>            PID: 6356 (rpc.gssd)
>            UID: 0 (root)
>            GID: 0 (root)
>         Signal: 11 (SEGV)
>      Timestamp: Thu 2020-06-25 11:46:08 CEST (3h 4min ago)
>   Command Line: /usr/sbin/rpc.gssd -vvvvvvv -rrrrrrr -t 3600 -T 10
>     Executable: /usr/sbin/rpc.gssd
>  Control Group: /system.slice/rpc-gssd.service
>           Unit: rpc-gssd.service
>          Slice: system.slice
>        Boot ID: XXXXXXXXXXXXXXXXXXXXXXXXXXX
>     Machine ID: YYYYYYYYYYYYYYYYYYYYYYYYYYYY
>       Hostname: XYZ
>        Storage: /var/lib/systemd/coredump/core.rpc\x2egssd.0.7f31136228274af0a1a855b91ad1e75c.6356.1593078368000000.lz4
>        Message: Process 6356 (rpc.gssd) of user 0 dumped core.
>                 
>                 Stack trace of thread 14174:
>                 #0  0x000056233fff038e n/a (rpc.gssd)
>                 #1  0x000056233fff09f8 n/a (rpc.gssd)
>                 #2  0x000056233fff0b92 n/a (rpc.gssd)
>                 #3  0x000056233fff13b3 n/a (rpc.gssd)
>                 #4  0x00007fb2eb8dbfa3 start_thread (libpthread.so.0)
>                 #5  0x00007fb2eb80c4cf __clone (libc.so.6)
>                 
>                 Stack trace of thread 6356:
>                 #0  0x00007fb2eb801819 __GI___poll (libc.so.6)
>                 #1  0x00007fb2eb6e7207 send_dg (libresolv.so.2)
>                 #2  0x00007fb2eb6e4c43 __GI___res_context_query (libresolv.so.2)
>                 #3  0x00007fb2eb6bf536 __GI__nss_dns_gethostbyaddr2_r (libnss_dns.so.2)
>                 #4  0x00007fb2eb6bf823 _nss_dns_gethostbyaddr_r (libnss_dns.so.2)
>                 #5  0x00007fb2eb81dee2 __gethostbyaddr_r (libc.so.6)
>                 #6  0x00007fb2eb8267d5 gni_host_inet_name (libc.so.6)
>                 #7  0x000056233ffef455 n/a (rpc.gssd)
>                 #8  0x000056233ffef82c n/a (rpc.gssd)
>                 #9  0x000056233fff01d0 n/a (rpc.gssd)
>                 #10 0x00007fb2ebab49ba n/a (libevent-2.1.so.6)
>                 #11 0x00007fb2ebab5537 event_base_loop (libevent-2.1.so.6)
>                 #12 0x000056233ffedeaa n/a (rpc.gssd)
>                 #13 0x00007fb2eb73709b __libc_start_main (libc.so.6)
>                 #14 0x000056233ffee03a n/a (rpc.gssd)
> 
> GNU gdb (Debian 8.2.1-2+b3) 8.2.1
> [...]
> Reading symbols from /usr/sbin/rpc.gssd...(no debugging symbols found)...done.
> [New LWP 14174]
> [New LWP 6356]
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> Core was generated by `/usr/sbin/rpc.gssd -vvvvvvv -rrrrrrr -t 3600 -T 10'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x000056233fff038e in ?? ()
> [Current thread is 1 (Thread 0x7fb2eaeba700 (LWP 14174))]
> (gdb) bt
> #0  0x000056233fff038e in ?? ()
> #1  0x000056233fff09f8 in ?? ()
> #2  0x000056233fff0b92 in ?? ()
> #3  0x000056233fff13b3 in ?? ()
> #4  0x00007fb2eb8dbfa3 in start_thread (arg=<optimized out>) at pthread_create.c:486
> #5  0x00007fb2eb80c4cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> (gdb) quit
> 
> 
> I am not an expert in analyzing stack and backtraces. Is there anything meaningful, you are able to extract from the trace?
> As far as I see, thread 14174 caused the segmentation violation just after its birth on clone. 
> Please correct me, if I am in error.
> Seems Debian Buster does not ship any dedicated package with debug symbols for the rpc.gssd executable. 

Have you reported a debian bug?  They might know how to get a good trace
out of it.

--b.

> So far, I was not able to find such a package.
> What's your opinon about the trace?
> 
> 
> Best and Thanks
> Sebastian
> 
> _____________________________
> Sebastian Kraus
> Team IT am Institut für Chemie
> Gebäude C, Straße des 17. Juni 115, Raum C7
> 
> Technische Universität Berlin
> Fakultät II
> Institut für Chemie
> Sekretariat C3
> Straße des 17. Juni 135
> 10623 Berlin
> 
> Email: sebastian.kraus@tu-berlin.de
> 
> ________________________________________
> From: linux-nfs-owner@vger.kernel.org <linux-nfs-owner@vger.kernel.org> on behalf of J. Bruce Fields <bfields@fieldses.org>
> Sent: Tuesday, June 23, 2020 00:36
> To: Kraus, Sebastian
> Cc: linux-nfs@vger.kernel.org
> Subject: Re: RPC Pipefs: Frequent parsing errors in client database
> 
> On Sat, Jun 20, 2020 at 09:08:55PM +0000, Kraus, Sebastian wrote:
> > Hi Bruce,
> >
> > >> But I think it'd be more useful to stay focused on the segfaults.
> >
> > is it a clever idea to analyze core dumps? Or are there other much better debugging techniques w.r.t. RPC daemons?
> 
> If we could at least get a backtrace out of the core dump that could be
> useful.
> 
> > I now do more tests while fiddling around with the time-out parameters "-T" and "-t" on the command line of rpc.gssd.
> >
> > There are several things I do not really understand about the trace shown below:
> >
> > 1) How can it be useful that the rpc.gssd daemon tries to parse the info file although it knows about its absence beforehand?
> 
> It doesn't know beforehand, in the scenarios I described.
> 
> > 2) Why are there two identifiers clnt36e and clnt36f being used for the same client?
> 
> This is actually happening on an NFS server, the rpc client in question
> is the callback client used to do things like send delegation recalls
> back to the NFS client.
> 
> I'm not sure why two different callback clients are being created here,
> but there's nothing inherently weird about that.
> 
> > 3) What does the <?> in "inotify event for clntdir (nfsd4_cb/clnt36e) - ev->wd (600) ev->name (<?>) ev->mask (0x00008000)" mean?
> 
> Off the top of my head, I don't know, we'd probably need to look through
> header files or inotify man pages for the definitions of those masks.
> 
> --b.
