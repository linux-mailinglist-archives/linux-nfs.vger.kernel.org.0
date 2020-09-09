Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32A262C11
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Sep 2020 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIIJhB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Sep 2020 05:37:01 -0400
Received: from etc.inittab.org ([51.254.149.154]:48330 "EHLO etc.inittab.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgIIJgy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Sep 2020 05:36:54 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2020 05:36:50 EDT
Received: from var.inittab.org (249.171.116.91.static.reverse-mundo-r.com [91.116.171.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: smtp_auth_agi@correo-e.org)
        by etc.inittab.org (Postfix) with ESMTPSA id 57A90A009E;
        Wed,  9 Sep 2020 11:29:02 +0200 (CEST)
Received: by var.inittab.org (Postfix, from userid 1000)
        id 03E3E404F0; Wed,  9 Sep 2020 11:29:00 +0200 (CEST)
Date:   Wed, 9 Sep 2020 11:29:00 +0200
From:   Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Subject: Re: Random IO errors on nfs clients running linux > 4.20
Message-ID: <20200909092900.GO189595@var.inittab.org>
References: <20200429171527.GG2531021@var.inittab.org>
 <20200430173200.GE29491@fieldses.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430173200.GE29491@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 30, 2020 at 01:32:00PM -0400, J. Bruce Fields wrote:
> On Wed, Apr 29, 2020 at 07:15:27PM +0200, Alberto Gonzalez Iniesta wrote:
> > I'm sorry for reporting this (a little bit) late, but it took us (Miguel
> > in Cc:) some time to track this issue to an exact kernel update.
> > 
> > We're running a +200 clients NFS server with Ubuntu 16.04 and 18.04
> > clients. The server runs Debian 8.11 (jessie) with Linux 3.16.0 and
> > nfs-kernel-server 1:1.2.8-9+deb8u1. It has been working some years now
> > without issues.
> > 
> > But since we started moving clients from Ubuntu 16.04 to Ubuntu 18.04
> > some of them started experiencing failures while working on NFS mounts.
> > The failures are arbitrary and sometimes it may take more than 20 minutes
> > to come out (which made finding out which kernel version introduced
> > this a pain). We are almost sure that some directories are more prone to
> > suffer from this than others (maybe related to path length/chars?).
> > 
> > The error is also not very "verbose", from an strace:
> > 
> > execve("/bin/ls", ["ls", "-lR", "Becas y ayudas/"], 0x7ffccb7f5b20 /* 16 vars */) = 0
> > [lots of uninteresting output]
> > openat(AT_FDCWD, "Becas y ayudas/", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
> > fstat(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> > fstat(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> > fstat(1, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
> > ioctl(1, TCGETS, 0x7ffd8b725c80)        = -1 ENOTTY (Inappropriate ioctl for device)
> > getdents(3, /* 35 entries */, 32768)    = 1936
> > [lots of lstats)
> > lstat("Becas y ayudas/Convocatorias", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> > getdents(3, 0x561af78de890, 32768)      = -1 EIO (Input/output error)
> 
> Ideas off the top of my head....
> 
> It'd be really useful to get a network trace--something like tcpdump -s0
> -wtmp.pcap -i<interface>, then reproduce the problem, then look through
> it to see if you can find the READDIR or STAT or whatever that results
> in the unexpected EIO.  But if takes a while to reproduce, that may be
> difficult.
> 
> Is there anything in the logs?
> 
> It might be worth turning on some more debug logging--see the "rpcdebug"
> command.

Hi, Bruce et at.

I'm sorry this reply took so long, but with debugging enabled the error
was harder to reproduce.

I'm attaching 3 log files (2 with just "nfs" debugging and one with
"nfs" and "rpc" debugging modules enabled).

I'm also attaching a pcap file, don't know if it would be useful since
we run "sec=krb5p".

Let me know if there's anything else I can test/provide.
These tests were done with Ubuntu's 5.3.0-53-generic.

Thanks,

Alberto

> > (I can send you the full output if you need it)
> > 
> > We can run the previous "ls -lR" 20 times and get no error, or get
> > this "ls: leyendo el directorio 'Becas y ayudas/': Error de entrada/salida"
> > (ls: reading directorio 'Becas y ayudas/': Input/Output Error") every
> > now and then.
> > 
> > The error happens (obviously?) with ls, rsync and the users's GUI tools.
> > 
> > There's nothing in dmesg (or elsewhere).
> > These are the kernels with tried:
> > 4.18.0-25   -> Can't reproduce
> > 4.19.0      -> Can't reproduce
> > 4.20.17     -> Happening (hard to reproduce)
> > 5.0.0-15    -> Happening (hard to reproduce)
> > 5.3.0-45    -> Happening (more frequently)
> > 5.6.0-rc7   -> Reproduced a couple of times after boot, then nothing
> > 
> > We did long (as in daylong) testing trying to reproduce this with all
> > those kernel versions, so we are pretty sure 4.18 and 4.19 don't
> > experience this and our Ubuntu 16.04 clients don't have any issue.
> > 
> > I know we aren't providing much info but we are really looking forward
> > to doing all the testing required (we already spent lots of time in it).
> > 
> > Thanks for your work.
> > 
> > Regards,
> > 
> > Alberto
> > 
> > -- 
> > Alberto González Iniesta             | Universidad a Distancia
> > alberto.gonzalez@udima.es            | de Madrid

-- 
Alberto González Iniesta             | Universidad a Distancia
alberto.gonzalez@udima.es            | de Madrid

--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="err3.txt"
Content-Transfer-Encoding: 8bit

Sep  8 16:03:23 portatil264 kernel: [15032.854134] RPC:  3283 call_decode result 0
Sep  8 16:03:23 portatil264 kernel: [15032.854140] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=31
Sep  8 16:03:23 portatil264 kernel: [15032.854142] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
Sep  8 16:03:23 portatil264 kernel: [15032.854145] RPC:       wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
Sep  8 16:03:23 portatil264 kernel: [15032.854147] nfs4_free_slot: slotid 1 highest_used_slotid 0
Sep  8 16:03:23 portatil264 kernel: [15032.854148] nfs41_sequence_process: Error 0 free the slot 
Sep  8 16:03:23 portatil264 kernel: [15032.854150] RPC:       wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
Sep  8 16:03:23 portatil264 kernel: [15032.854152] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 16:03:23 portatil264 kernel: [15032.854154] RPC:  3283 return 0, status 0
Sep  8 16:03:23 portatil264 kernel: [15032.854155] RPC:  3283 release task
Sep  8 16:03:23 portatil264 kernel: [15032.854159] RPC:       freeing buffer of size 4584 at 00000000a3649daf
Sep  8 16:03:23 portatil264 kernel: [15032.854162] RPC:  3283 release request 0000000079df89b2
Sep  8 16:03:23 portatil264 kernel: [15032.854164] RPC:       wake_up_first(00000000c5ee49ee "xprt_backlog")
Sep  8 16:03:23 portatil264 kernel: [15032.854166] RPC:       rpc_release_client(00000000b930c343)
Sep  8 16:03:23 portatil264 kernel: [15032.854169] RPC:  3283 freeing task
Sep  8 16:03:23 portatil264 kernel: [15032.854179] NFS: nfs_update_inode(0:53/31982477 fh_crc=0x47b6a915 ct=1 info=0x427e7f)
Sep  8 16:03:23 portatil264 kernel: [15032.854183] NFS: (0:53/31982477) revalidation complete
Sep  8 16:03:23 portatil264 kernel: [15032.854186] NFS: dentry_delete(innovacion/Proyectos de investigación, 28080c)
Sep  8 16:03:23 portatil264 kernel: [15032.854240] NFS: readdir(departamentos/innovacion) starting at cookie 19
Sep  8 16:03:23 portatil264 kernel: [15032.854259] _nfs4_proc_readdir: dentry = departamentos/innovacion, cookie = 0
Sep  8 16:03:23 portatil264 kernel: [15032.854262] RPC:       new task initialized, procpid 26029
Sep  8 16:03:23 portatil264 kernel: [15032.854263] RPC:       allocated task 00000000493c7c0e
Sep  8 16:03:23 portatil264 kernel: [15032.854267] RPC:  3284 __rpc_execute flags=0x4080
Sep  8 16:03:23 portatil264 kernel: [15032.854269] --> nfs41_call_sync_prepare data->seq_server 00000000eb43854e
Sep  8 16:03:23 portatil264 kernel: [15032.854271] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 16:03:23 portatil264 kernel: [15032.854273] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 16:03:23 portatil264 kernel: [15032.854276] RPC:  3284 call_start nfs4 proc READDIR (sync)
Sep  8 16:03:23 portatil264 kernel: [15032.854278] RPC:  3284 call_reserve (status 0)
Sep  8 16:03:23 portatil264 kernel: [15032.854281] RPC:  3284 reserved req 0000000079df89b2 xid 5dfa3876
Sep  8 16:03:23 portatil264 kernel: [15032.854282] RPC:  3284 call_reserveresult (status 0)
Sep  8 16:03:23 portatil264 kernel: [15032.854284] RPC:  3284 call_refresh (status 0)
Sep  8 16:03:23 portatil264 kernel: [15032.854287] RPC:  3284 call_refreshresult (status 0)
Sep  8 16:03:23 portatil264 kernel: [15032.854289] RPC:  3284 call_allocate (status 0)
Sep  8 16:03:23 portatil264 kernel: [15032.854292] RPC:  3284 allocated buffer of size 4144 at 00000000a3649daf
Sep  8 16:03:23 portatil264 kernel: [15032.854297] RPC:  3284 call_encode (status 0)
Sep  8 16:03:23 portatil264 kernel: [15032.854301] RPC:       gss_get_mic_v2
Sep  8 16:03:23 portatil264 kernel: [15032.854319] encode_sequence: sessionid=1582481124:15749:9224:0 seqid=195 slotid=0 max_slotid=0 cache_this=0
Sep  8 16:03:23 portatil264 kernel: [15032.854323] encode_readdir: cookie = 0, verifier = 00000000:00000000, bitmap = 0018091a:00b0a23a:00000000
Sep  8 16:03:23 portatil264 kernel: [15032.854325] RPC:       gss_wrap_kerberos_v2
Sep  8 16:03:23 portatil264 kernel: [15032.854350] RPC:  3284 call_transmit (status 0)
Sep  8 16:03:23 portatil264 kernel: [15032.854352] RPC:  3284 xprt_prepare_transmit
Sep  8 16:03:23 portatil264 kernel: [15032.854389] RPC:       xs_tcp_send_request(272) = 0
Sep  8 16:03:23 portatil264 kernel: [15032.854392] RPC:       wake_up_first(000000001bb91292 "xprt_sending")
Sep  8 16:03:23 portatil264 kernel: [15032.854395] RPC:  3284 sleep_on(queue "xprt_pending" time 4298650492)
Sep  8 16:03:23 portatil264 kernel: [15032.854397] RPC:  3284 added to queue 00000000a9a9ecc7 "xprt_pending"
Sep  8 16:03:23 portatil264 kernel: [15032.854398] RPC:  3284 setting alarm for 60000 ms
Sep  8 16:03:23 portatil264 kernel: [15032.854401] RPC:  3284 sync task going to sleep
Sep  8 16:03:23 portatil264 kernel: [15032.935579] RPC:       xs_data_ready...
Sep  8 16:03:23 portatil264 kernel: [15032.939135] RPC:       xs_data_ready...
Sep  8 16:03:23 portatil264 kernel: [15032.941013] decode_attr_owner: uid=138184
Sep  8 16:03:23 portatil264 kernel: [15033.016025] RPC:       xs_data_ready...
Sep  8 16:03:23 portatil264 kernel: [15033.016117] RPC:       xs_data_ready...
Sep  8 16:03:23 portatil264 kernel: [15033.016124] RPC:  3284 xid 5dfa3876 complete (4064 bytes received)
Sep  8 16:03:23 portatil264 kernel: [15033.016129] RPC:  3284 __rpc_wake_up_task (now 4298650533)
Sep  8 16:03:23 portatil264 kernel: [15033.016131] RPC:  3284 disabling timer
Sep  8 16:03:23 portatil264 kernel: [15033.016136] RPC:  3284 removed from queue 00000000a9a9ecc7 "xprt_pending"
Sep  8 16:03:23 portatil264 kernel: [15033.016149] RPC:       __rpc_wake_up_task done
Sep  8 16:03:23 portatil264 kernel: [15033.016231] RPC:  3284 sync task resuming
Sep  8 16:03:23 portatil264 kernel: [15033.016234] RPC:  3284 call_status (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016235] RPC:  3284 call_decode (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016240] RPC:       gss_verify_mic_v2
Sep  8 16:03:23 portatil264 kernel: [15033.016276] RPC:  3284 call_decode result -5
Sep  8 16:03:23 portatil264 kernel: [15033.016281] nfs41_sequence_process: Error 1 free the slot 
Sep  8 16:03:23 portatil264 kernel: [15033.016286] RPC:       wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
Sep  8 16:03:23 portatil264 kernel: [15033.016288] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 16:03:23 portatil264 kernel: [15033.016290] RPC:  3284 return 0, status -5
Sep  8 16:03:23 portatil264 kernel: [15033.016291] RPC:  3284 release task
Sep  8 16:03:23 portatil264 kernel: [15033.016295] RPC:       freeing buffer of size 4144 at 00000000a3649daf
Sep  8 16:03:23 portatil264 kernel: [15033.016298] RPC:  3284 release request 0000000079df89b2
Sep  8 16:03:23 portatil264 kernel: [15033.016300] RPC:       wake_up_first(00000000c5ee49ee "xprt_backlog")
Sep  8 16:03:23 portatil264 kernel: [15033.016302] RPC:       rpc_release_client(00000000b930c343)
Sep  8 16:03:23 portatil264 kernel: [15033.016304] RPC:  3284 freeing task
Sep  8 16:03:23 portatil264 kernel: [15033.016309] _nfs4_proc_readdir: returns -5
Sep  8 16:03:23 portatil264 kernel: [15033.016318] NFS: readdir(departamentos/innovacion) returns -5
Sep  8 16:03:23 portatil264 kernel: [15033.016788] NFS: permission(0:53/28049412), mask=0x81, res=0
Sep  8 16:03:23 portatil264 kernel: [15033.016793] NFS: nfs_lookup_revalidate_done(publico/departamentos) is valid
Sep  8 16:03:23 portatil264 kernel: [15033.016797] NFS: permission(0:53/28051004), mask=0x81, res=0
Sep  8 16:03:23 portatil264 kernel: [15033.016801] NFS: revalidating (0:53/30801922)
Sep  8 16:03:23 portatil264 kernel: [15033.016808] RPC:       new task initialized, procpid 26029
Sep  8 16:03:23 portatil264 kernel: [15033.016810] RPC:       allocated task 000000005afe768d
Sep  8 16:03:23 portatil264 kernel: [15033.016814] RPC:  3285 __rpc_execute flags=0x4080
Sep  8 16:03:23 portatil264 kernel: [15033.016817] --> nfs41_call_sync_prepare data->seq_server 00000000eb43854e
Sep  8 16:03:23 portatil264 kernel: [15033.016820] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 16:03:23 portatil264 kernel: [15033.016823] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 16:03:23 portatil264 kernel: [15033.016826] RPC:  3285 call_start nfs4 proc GETATTR (sync)
Sep  8 16:03:23 portatil264 kernel: [15033.016829] RPC:  3285 call_reserve (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016832] RPC:  3285 reserved req 0000000079df89b2 xid 5efa3876
Sep  8 16:03:23 portatil264 kernel: [15033.016834] RPC:  3285 call_reserveresult (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016836] RPC:  3285 call_refresh (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016840] RPC:  3285 call_refreshresult (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016844] RPC:  3285 call_allocate (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016848] RPC:  3285 allocated buffer of size 4584 at 000000007624e941
Sep  8 16:03:23 portatil264 kernel: [15033.016850] RPC:  3285 call_encode (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016857] RPC:       gss_get_mic_v2
Sep  8 16:03:23 portatil264 kernel: [15033.016876] encode_sequence: sessionid=1582481124:15749:9224:0 seqid=196 slotid=0 max_slotid=0 cache_this=0
Sep  8 16:03:23 portatil264 kernel: [15033.016879] RPC:       gss_wrap_kerberos_v2
Sep  8 16:03:23 portatil264 kernel: [15033.016907] RPC:  3285 call_transmit (status 0)
Sep  8 16:03:23 portatil264 kernel: [15033.016908] RPC:  3285 xprt_prepare_transmit
Sep  8 16:03:23 portatil264 kernel: [15033.016941] RPC:       xs_tcp_send_request(248) = 0
Sep  8 16:03:23 portatil264 kernel: [15033.016944] RPC:       wake_up_first(000000001bb91292 "xprt_sending")
Sep  8 16:03:23 portatil264 kernel: [15033.016947] RPC:  3285 sleep_on(queue "xprt_pending" time 4298650533)
Sep  8 16:03:23 portatil264 kernel: [15033.016948] RPC:  3285 added to queue 00000000a9a9ecc7 "xprt_pending"
Sep  8 16:03:23 portatil264 kernel: [15033.016949] RPC:  3285 setting alarm for 60000 ms
Sep  8 16:03:23 portatil264 kernel: [15033.016952] RPC:  3285 sync task going to sleep

--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="err2.txt"

Sep  8 11:03:08 portatil264 kernel: [  294.429356] NFS: permission(0:53/28049412), mask=0x81, res=0
Sep  8 11:03:08 portatil264 kernel: [  294.429365] NFS: nfs_lookup_revalidate_done(publico/departamentos) is valid
Sep  8 11:03:08 portatil264 kernel: [  294.429369] NFS: permission(0:53/28051004), mask=0x81, res=0
Sep  8 11:03:08 portatil264 kernel: [  294.429372] NFS: nfs_lookup_revalidate_done(departamentos/innovacion) is valid
Sep  8 11:03:08 portatil264 kernel: [  294.429377] NFS: revalidating (0:53/30801924)
Sep  8 11:03:08 portatil264 kernel: [  294.429392] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:03:08 portatil264 kernel: [  294.429396] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:03:08 portatil264 kernel: [  294.429399] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:03:08 portatil264 kernel: [  294.429456] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=50 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:03:09 portatil264 kernel: [  294.480184] decode_attr_type: type=040000
Sep  8 11:03:09 portatil264 kernel: [  294.480187] decode_attr_change: change attribute=6810276040818143508
Sep  8 11:03:09 portatil264 kernel: [  294.480189] decode_attr_size: file size=4096
Sep  8 11:03:09 portatil264 kernel: [  294.480190] decode_attr_fsid: fsid=(0x0/0x0)
Sep  8 11:03:09 portatil264 kernel: [  294.480192] decode_attr_fileid: fileid=30801924
Sep  8 11:03:09 portatil264 kernel: [  294.480193] decode_attr_fs_locations: fs_locations done, error = 0
Sep  8 11:03:09 portatil264 kernel: [  294.480194] decode_attr_mode: file mode=02770
Sep  8 11:03:09 portatil264 kernel: [  294.480196] decode_attr_nlink: nlink=19
Sep  8 11:03:09 portatil264 kernel: [  294.480208] decode_attr_owner: uid=0
Sep  8 11:03:09 portatil264 kernel: [  294.480212] decode_attr_group: gid=709
Sep  8 11:03:09 portatil264 kernel: [  294.480213] decode_attr_rdev: rdev=(0x0:0x0)
Sep  8 11:03:09 portatil264 kernel: [  294.480215] decode_attr_space_used: space used=4096
Sep  8 11:03:09 portatil264 kernel: [  294.480216] decode_attr_time_access: atime=1599472206
Sep  8 11:03:09 portatil264 kernel: [  294.480217] decode_attr_time_metadata: ctime=1585640954
Sep  8 11:03:09 portatil264 kernel: [  294.480218] decode_attr_time_modify: mtime=1585640954
Sep  8 11:03:09 portatil264 kernel: [  294.480220] decode_attr_mounted_on_fileid: fileid=30801924
Sep  8 11:03:09 portatil264 kernel: [  294.480221] decode_getfattr_attrs: xdr returned 0
Sep  8 11:03:09 portatil264 kernel: [  294.480223] decode_getfattr_generic: xdr returned 0
Sep  8 11:03:09 portatil264 kernel: [  294.480228] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=31
Sep  8 11:03:09 portatil264 kernel: [  294.480230] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
Sep  8 11:03:09 portatil264 kernel: [  294.480232] nfs4_free_slot: slotid 1 highest_used_slotid 0
Sep  8 11:03:09 portatil264 kernel: [  294.480233] nfs41_sequence_process: Error 0 free the slot 
Sep  8 11:03:09 portatil264 kernel: [  294.480234] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:03:09 portatil264 kernel: [  294.480246] NFS: nfs_update_inode(0:53/30801924 fh_crc=0x21ccf1a0 ct=1 info=0x427e7f)
Sep  8 11:03:09 portatil264 kernel: [  294.480249] NFS: (0:53/30801924) revalidation complete
Sep  8 11:03:09 portatil264 kernel: [  294.480252] NFS: dentry_delete(departamentos/innovacion, 28084c)
Sep  8 11:03:09 portatil264 kernel: [  294.480271] NFS: permission(0:53/28049412), mask=0x81, res=0
Sep  8 11:03:09 portatil264 kernel: [  294.480273] NFS: nfs_lookup_revalidate_done(publico/departamentos) is valid
Sep  8 11:03:09 portatil264 kernel: [  294.480275] NFS: permission(0:53/28051004), mask=0x81, res=0
Sep  8 11:03:09 portatil264 kernel: [  294.480277] NFS: revalidating (0:53/30801924)
Sep  8 11:03:09 portatil264 kernel: [  294.480282] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:03:09 portatil264 kernel: [  294.480284] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:03:09 portatil264 kernel: [  294.480285] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:03:09 portatil264 kernel: [  294.480306] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=51 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:03:09 portatil264 kernel: [  294.562935] decode_attr_type: type=040000
Sep  8 11:03:09 portatil264 kernel: [  294.562937] decode_attr_change: change attribute=6810276040818143508
Sep  8 11:03:09 portatil264 kernel: [  294.562939] decode_attr_size: file size=4096
Sep  8 11:03:09 portatil264 kernel: [  294.562940] decode_attr_fsid: fsid=(0x0/0x0)
Sep  8 11:03:09 portatil264 kernel: [  294.562941] decode_attr_fileid: fileid=30801924
Sep  8 11:03:09 portatil264 kernel: [  294.562942] decode_attr_fs_locations: fs_locations done, error = 0
Sep  8 11:03:09 portatil264 kernel: [  294.562943] decode_attr_mode: file mode=02770
Sep  8 11:03:09 portatil264 kernel: [  294.562944] decode_attr_nlink: nlink=19
Sep  8 11:03:09 portatil264 kernel: [  294.562950] decode_attr_owner: uid=0
Sep  8 11:03:09 portatil264 kernel: [  294.562954] decode_attr_group: gid=709
Sep  8 11:03:09 portatil264 kernel: [  294.562955] decode_attr_rdev: rdev=(0x0:0x0)
Sep  8 11:03:09 portatil264 kernel: [  294.562956] decode_attr_space_used: space used=4096
Sep  8 11:03:09 portatil264 kernel: [  294.562957] decode_attr_time_access: atime=1599472206
Sep  8 11:03:09 portatil264 kernel: [  294.562958] decode_attr_time_metadata: ctime=1585640954
Sep  8 11:03:09 portatil264 kernel: [  294.562961] decode_attr_time_modify: mtime=1585640954
Sep  8 11:03:09 portatil264 kernel: [  294.562962] decode_attr_mounted_on_fileid: fileid=30801924
Sep  8 11:03:09 portatil264 kernel: [  294.562963] decode_getfattr_attrs: xdr returned 0
Sep  8 11:03:09 portatil264 kernel: [  294.562964] decode_getfattr_generic: xdr returned 0
Sep  8 11:03:09 portatil264 kernel: [  294.562968] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=31
Sep  8 11:03:09 portatil264 kernel: [  294.562970] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
Sep  8 11:03:09 portatil264 kernel: [  294.562971] nfs4_free_slot: slotid 1 highest_used_slotid 0
Sep  8 11:03:09 portatil264 kernel: [  294.562973] nfs41_sequence_process: Error 0 free the slot 
Sep  8 11:03:09 portatil264 kernel: [  294.562974] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:03:09 portatil264 kernel: [  294.562982] NFS: nfs_update_inode(0:53/30801924 fh_crc=0x21ccf1a0 ct=1 info=0x427e7f)
Sep  8 11:03:09 portatil264 kernel: [  294.562984] NFS: (0:53/30801924) revalidation complete
Sep  8 11:03:09 portatil264 kernel: [  294.562987] NFS: nfs_lookup_revalidate_done(departamentos/innovacion) is valid
Sep  8 11:03:09 portatil264 kernel: [  294.562991] NFS: permission(0:53/30801924), mask=0x24, res=0
Sep  8 11:03:09 portatil264 kernel: [  294.562995] NFS: open dir(departamentos/innovacion)
Sep  8 11:03:09 portatil264 kernel: [  294.563017] NFS: readdir(departamentos/innovacion) starting at cookie 0
Sep  8 11:03:09 portatil264 kernel: [  294.563029] _nfs4_proc_readdir: dentry = departamentos/innovacion, cookie = 0
Sep  8 11:03:09 portatil264 kernel: [  294.563034] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:03:09 portatil264 kernel: [  294.563036] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:03:09 portatil264 kernel: [  294.563037] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:03:09 portatil264 kernel: [  294.563057] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=52 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:03:09 portatil264 kernel: [  294.563060] encode_readdir: cookie = 0, verifier = 00000000:00000000, bitmap = 0018091a:00b0a23a:00000000
Sep  8 11:03:09 portatil264 kernel: [  294.643573] nfs41_sequence_process: Error 1 free the slot 
Sep  8 11:03:09 portatil264 kernel: [  294.643576] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:03:09 portatil264 kernel: [  294.643583] _nfs4_proc_readdir: returns -5
Sep  8 11:03:09 portatil264 kernel: [  294.643589] NFS: readdir(departamentos/innovacion) returns -5
Sep  8 11:03:09 portatil264 kernel: [  294.644109] NFS: dentry_delete(departamentos/innovacion, 28084c)
Sep  8 11:03:10 portatil264 kernel: [  296.012504] nfs4_renew_state: start
Sep  8 11:03:10 portatil264 kernel: [  296.012510] nfs4_schedule_state_renewal: requeueing work. Lease period = 59
Sep  8 11:03:10 portatil264 kernel: [  296.012513] nfs4_renew_state: done

--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="err1.txt"

Sep  8 11:02:03 portatil264 kernel: [  229.334583] FS-Cache: Loaded
Sep  8 11:02:03 portatil264 kernel: [  229.374147] FS-Cache: Netfs 'nfs' registered for caching
Sep  8 11:02:04 portatil264 kernel: [  229.528716] NFS: Registering the id_resolver key type
Sep  8 11:02:04 portatil264 kernel: [  229.528731] Key type id_resolver registered
Sep  8 11:02:04 portatil264 kernel: [  229.528732] Key type id_legacy registered
Sep  8 11:02:52 portatil264 kernel: [  278.316243] NFS: permission(0:53/28049412), mask=0x81, res=-10
Sep  8 11:02:52 portatil264 kernel: [  278.316247] NFS: revalidating (0:53/28049412)
Sep  8 11:02:52 portatil264 kernel: [  278.316260] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:02:52 portatil264 kernel: [  278.316263] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:02:52 portatil264 kernel: [  278.316265] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:02:52 portatil264 kernel: [  278.316309] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=44 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:02:52 portatil264 kernel: [  278.373736] decode_attr_type: type=040000
Sep  8 11:02:52 portatil264 kernel: [  278.373738] decode_attr_change: change attribute=6769953312283491654
Sep  8 11:02:52 portatil264 kernel: [  278.373739] decode_attr_size: file size=4096
Sep  8 11:02:52 portatil264 kernel: [  278.373741] decode_attr_fsid: fsid=(0x0/0x0)
Sep  8 11:02:52 portatil264 kernel: [  278.373742] decode_attr_fileid: fileid=28049412
Sep  8 11:02:52 portatil264 kernel: [  278.373743] decode_attr_fs_locations: fs_locations done, error = 0
Sep  8 11:02:52 portatil264 kernel: [  278.373745] decode_attr_mode: file mode=0755
Sep  8 11:02:52 portatil264 kernel: [  278.373746] decode_attr_nlink: nlink=6
Sep  8 11:02:52 portatil264 kernel: [  278.373757] decode_attr_owner: uid=0
Sep  8 11:02:52 portatil264 kernel: [  278.373761] decode_attr_group: gid=0
Sep  8 11:02:52 portatil264 kernel: [  278.373763] decode_attr_rdev: rdev=(0x0:0x0)
Sep  8 11:02:52 portatil264 kernel: [  278.373764] decode_attr_space_used: space used=4096
Sep  8 11:02:52 portatil264 kernel: [  278.373765] decode_attr_time_access: atime=1599538321
Sep  8 11:02:52 portatil264 kernel: [  278.373766] decode_attr_time_metadata: ctime=1576252587
Sep  8 11:02:52 portatil264 kernel: [  278.373767] decode_attr_time_modify: mtime=1576252587
Sep  8 11:02:52 portatil264 kernel: [  278.373768] decode_attr_mounted_on_fileid: fileid=28049412
Sep  8 11:02:52 portatil264 kernel: [  278.373770] decode_getfattr_attrs: xdr returned 0
Sep  8 11:02:52 portatil264 kernel: [  278.373771] decode_getfattr_generic: xdr returned 0
Sep  8 11:02:52 portatil264 kernel: [  278.373776] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=31
Sep  8 11:02:52 portatil264 kernel: [  278.373778] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
Sep  8 11:02:52 portatil264 kernel: [  278.373780] nfs4_free_slot: slotid 1 highest_used_slotid 0
Sep  8 11:02:52 portatil264 kernel: [  278.373781] nfs41_sequence_process: Error 0 free the slot 
Sep  8 11:02:52 portatil264 kernel: [  278.373782] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:02:52 portatil264 kernel: [  278.373794] NFS: nfs_update_inode(0:53/28049412 fh_crc=0xc875a563 ct=2 info=0x427e7f)
Sep  8 11:02:52 portatil264 kernel: [  278.373797] NFS: (0:53/28049412) revalidation complete
Sep  8 11:02:52 portatil264 kernel: [  278.373800] NFS: permission(0:53/28049412), mask=0x1, res=0
Sep  8 11:02:52 portatil264 kernel: [  278.373806] NFS: nfs_lookup_revalidate_done(publico/departamentos) is valid
Sep  8 11:02:52 portatil264 kernel: [  278.373812] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:02:52 portatil264 kernel: [  278.373814] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:02:52 portatil264 kernel: [  278.373815] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:02:52 portatil264 kernel: [  278.373834] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=45 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:02:52 portatil264 kernel: [  278.430991] decode_attr_type: type=00
Sep  8 11:02:52 portatil264 kernel: [  278.430994] decode_attr_change: change attribute=6792489597889629835
Sep  8 11:02:52 portatil264 kernel: [  278.430995] decode_attr_size: file size=4096
Sep  8 11:02:52 portatil264 kernel: [  278.430996] decode_attr_fsid: fsid=(0x0/0x0)
Sep  8 11:02:52 portatil264 kernel: [  278.430997] decode_attr_fileid: fileid=0
Sep  8 11:02:52 portatil264 kernel: [  278.430998] decode_attr_fs_locations: fs_locations done, error = 0
Sep  8 11:02:52 portatil264 kernel: [  278.430999] decode_attr_mode: file mode=00
Sep  8 11:02:52 portatil264 kernel: [  278.431000] decode_attr_nlink: nlink=1
Sep  8 11:02:52 portatil264 kernel: [  278.431001] decode_attr_rdev: rdev=(0x0:0x0)
Sep  8 11:02:52 portatil264 kernel: [  278.431002] decode_attr_space_used: space used=0
Sep  8 11:02:52 portatil264 kernel: [  278.431003] decode_attr_time_access: atime=0
Sep  8 11:02:52 portatil264 kernel: [  278.431004] decode_attr_time_metadata: ctime=1581499725
Sep  8 11:02:52 portatil264 kernel: [  278.431005] decode_attr_time_modify: mtime=1581499725
Sep  8 11:02:52 portatil264 kernel: [  278.431006] decode_attr_mounted_on_fileid: fileid=0
Sep  8 11:02:52 portatil264 kernel: [  278.431007] decode_getfattr_attrs: xdr returned 0
Sep  8 11:02:52 portatil264 kernel: [  278.431008] decode_getfattr_generic: xdr returned 0
Sep  8 11:02:52 portatil264 kernel: [  278.431012] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=31
Sep  8 11:02:52 portatil264 kernel: [  278.431014] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
Sep  8 11:02:52 portatil264 kernel: [  278.431016] nfs4_free_slot: slotid 1 highest_used_slotid 0
Sep  8 11:02:52 portatil264 kernel: [  278.431017] nfs41_sequence_process: Error 0 free the slot 
Sep  8 11:02:52 portatil264 kernel: [  278.431018] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:02:52 portatil264 kernel: [  278.431026] NFS: nfs_update_inode(0:53/28051004 fh_crc=0x3843eff0 ct=1 info=0x26040)
Sep  8 11:02:52 portatil264 kernel: [  278.431033] NFS: permission(0:53/28051004), mask=0x1, res=0
Sep  8 11:02:52 portatil264 kernel: [  278.431037] NFS: lookup(departamentos/innovacion)
Sep  8 11:02:52 portatil264 kernel: [  278.431039] NFS call  lookup innovacion
Sep  8 11:02:52 portatil264 kernel: [  278.431043] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:02:52 portatil264 kernel: [  278.431045] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:02:52 portatil264 kernel: [  278.431047] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:02:52 portatil264 kernel: [  278.431066] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=46 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:02:53 portatil264 kernel: [  278.585742] decode_attr_type: type=040000
Sep  8 11:02:53 portatil264 kernel: [  278.585745] decode_attr_change: change attribute=6810276040818143508
Sep  8 11:02:53 portatil264 kernel: [  278.585746] decode_attr_size: file size=4096
Sep  8 11:02:53 portatil264 kernel: [  278.585747] decode_attr_fsid: fsid=(0x0/0x0)
Sep  8 11:02:53 portatil264 kernel: [  278.585748] decode_attr_fileid: fileid=30801924
Sep  8 11:02:53 portatil264 kernel: [  278.585749] decode_attr_fs_locations: fs_locations done, error = 0
Sep  8 11:02:53 portatil264 kernel: [  278.585750] decode_attr_mode: file mode=02770
Sep  8 11:02:53 portatil264 kernel: [  278.585751] decode_attr_nlink: nlink=19
Sep  8 11:02:53 portatil264 kernel: [  278.585758] decode_attr_owner: uid=0
Sep  8 11:02:53 portatil264 kernel: [  278.898245] decode_attr_group: gid=709
Sep  8 11:02:53 portatil264 kernel: [  278.898249] decode_attr_rdev: rdev=(0x0:0x0)
Sep  8 11:02:53 portatil264 kernel: [  278.898250] decode_attr_space_used: space used=4096
Sep  8 11:02:53 portatil264 kernel: [  278.898251] decode_attr_time_access: atime=1599472206
Sep  8 11:02:53 portatil264 kernel: [  278.898252] decode_attr_time_metadata: ctime=1585640954
Sep  8 11:02:53 portatil264 kernel: [  278.898253] decode_attr_time_modify: mtime=1585640954
Sep  8 11:02:53 portatil264 kernel: [  278.898255] decode_attr_mounted_on_fileid: fileid=30801924
Sep  8 11:02:53 portatil264 kernel: [  278.898256] decode_getfattr_attrs: xdr returned 0
Sep  8 11:02:53 portatil264 kernel: [  278.898258] decode_getfattr_generic: xdr returned 0
Sep  8 11:02:53 portatil264 kernel: [  278.898266] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=31
Sep  8 11:02:53 portatil264 kernel: [  278.898268] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
Sep  8 11:02:53 portatil264 kernel: [  278.898270] nfs4_free_slot: slotid 1 highest_used_slotid 0
Sep  8 11:02:53 portatil264 kernel: [  278.898271] nfs41_sequence_process: Error 0 free the slot 
Sep  8 11:02:53 portatil264 kernel: [  278.898273] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:02:53 portatil264 kernel: [  278.898281] NFS reply lookup: 0
Sep  8 11:02:53 portatil264 kernel: [  278.898292] NFS: nfs_fhget(0:53/30801924 fh_crc=0x21ccf1a0 ct=1)
Sep  8 11:02:53 portatil264 kernel: [  278.898302] NFS: dentry_delete(departamentos/innovacion, 20080c)
Sep  8 11:02:53 portatil264 kernel: [  278.898330] NFS: permission(0:53/28049412), mask=0x81, res=0
Sep  8 11:02:53 portatil264 kernel: [  278.898334] NFS: nfs_lookup_revalidate_done(publico/departamentos) is valid
Sep  8 11:02:53 portatil264 kernel: [  278.898336] NFS: permission(0:53/28051004), mask=0x81, res=0
Sep  8 11:02:53 portatil264 kernel: [  278.898338] NFS: revalidating (0:53/30801924)
Sep  8 11:02:53 portatil264 kernel: [  278.898349] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:02:53 portatil264 kernel: [  278.898351] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:02:53 portatil264 kernel: [  278.898352] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:02:53 portatil264 kernel: [  278.898393] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=47 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:02:53 portatil264 kernel: [  278.984901] decode_attr_type: type=040000
Sep  8 11:02:53 portatil264 kernel: [  278.984904] decode_attr_change: change attribute=6810276040818143508
Sep  8 11:02:53 portatil264 kernel: [  278.984905] decode_attr_size: file size=4096
Sep  8 11:02:53 portatil264 kernel: [  278.984906] decode_attr_fsid: fsid=(0x0/0x0)
Sep  8 11:02:53 portatil264 kernel: [  278.984907] decode_attr_fileid: fileid=30801924
Sep  8 11:02:53 portatil264 kernel: [  278.984909] decode_attr_fs_locations: fs_locations done, error = 0
Sep  8 11:02:53 portatil264 kernel: [  278.984910] decode_attr_mode: file mode=02770
Sep  8 11:02:53 portatil264 kernel: [  278.984911] decode_attr_nlink: nlink=19
Sep  8 11:02:53 portatil264 kernel: [  278.984919] decode_attr_owner: uid=0
Sep  8 11:02:53 portatil264 kernel: [  278.984922] decode_attr_group: gid=709
Sep  8 11:02:53 portatil264 kernel: [  278.984923] decode_attr_rdev: rdev=(0x0:0x0)
Sep  8 11:02:53 portatil264 kernel: [  278.984924] decode_attr_space_used: space used=4096
Sep  8 11:02:53 portatil264 kernel: [  278.984926] decode_attr_time_access: atime=1599472206
Sep  8 11:02:53 portatil264 kernel: [  278.984927] decode_attr_time_metadata: ctime=1585640954
Sep  8 11:02:53 portatil264 kernel: [  278.984928] decode_attr_time_modify: mtime=1585640954
Sep  8 11:02:53 portatil264 kernel: [  278.984929] decode_attr_mounted_on_fileid: fileid=30801924
Sep  8 11:02:53 portatil264 kernel: [  278.984930] decode_getfattr_attrs: xdr returned 0
Sep  8 11:02:53 portatil264 kernel: [  278.984931] decode_getfattr_generic: xdr returned 0
Sep  8 11:02:53 portatil264 kernel: [  278.984935] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=31
Sep  8 11:02:53 portatil264 kernel: [  278.984937] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
Sep  8 11:02:53 portatil264 kernel: [  278.984939] nfs4_free_slot: slotid 1 highest_used_slotid 0
Sep  8 11:02:53 portatil264 kernel: [  278.984940] nfs41_sequence_process: Error 0 free the slot 
Sep  8 11:02:53 portatil264 kernel: [  278.984941] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:02:53 portatil264 kernel: [  278.984951] NFS: nfs_update_inode(0:53/30801924 fh_crc=0x21ccf1a0 ct=1 info=0x427e7f)
Sep  8 11:02:53 portatil264 kernel: [  278.984954] NFS: (0:53/30801924) revalidation complete
Sep  8 11:02:53 portatil264 kernel: [  278.984957] NFS: nfs_lookup_revalidate_done(departamentos/innovacion) is valid
Sep  8 11:02:53 portatil264 kernel: [  278.984964] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:02:53 portatil264 kernel: [  278.984966] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:02:53 portatil264 kernel: [  278.984968] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:02:53 portatil264 kernel: [  278.984989] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=48 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:02:53 portatil264 kernel: [  279.083208] decode_attr_type: type=00
Sep  8 11:02:53 portatil264 kernel: [  279.083210] decode_attr_change: change attribute=6810276040818143508
Sep  8 11:02:53 portatil264 kernel: [  279.083211] decode_attr_size: file size=4096
Sep  8 11:02:53 portatil264 kernel: [  279.083212] decode_attr_fsid: fsid=(0x0/0x0)
Sep  8 11:02:53 portatil264 kernel: [  279.083213] decode_attr_fileid: fileid=0
Sep  8 11:02:53 portatil264 kernel: [  279.083215] decode_attr_fs_locations: fs_locations done, error = 0
Sep  8 11:02:53 portatil264 kernel: [  279.083216] decode_attr_mode: file mode=00
Sep  8 11:02:53 portatil264 kernel: [  279.083217] decode_attr_nlink: nlink=1
Sep  8 11:02:53 portatil264 kernel: [  279.083218] decode_attr_rdev: rdev=(0x0:0x0)
Sep  8 11:02:53 portatil264 kernel: [  279.083219] decode_attr_space_used: space used=0
Sep  8 11:02:53 portatil264 kernel: [  279.083220] decode_attr_time_access: atime=0
Sep  8 11:02:53 portatil264 kernel: [  279.083221] decode_attr_time_metadata: ctime=1585640954
Sep  8 11:02:53 portatil264 kernel: [  279.083222] decode_attr_time_modify: mtime=1585640954
Sep  8 11:02:53 portatil264 kernel: [  279.083223] decode_attr_mounted_on_fileid: fileid=0
Sep  8 11:02:53 portatil264 kernel: [  279.083224] decode_getfattr_attrs: xdr returned 0
Sep  8 11:02:53 portatil264 kernel: [  279.083225] decode_getfattr_generic: xdr returned 0
Sep  8 11:02:53 portatil264 kernel: [  279.083230] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=31
Sep  8 11:02:53 portatil264 kernel: [  279.083232] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
Sep  8 11:02:53 portatil264 kernel: [  279.083233] nfs4_free_slot: slotid 1 highest_used_slotid 0
Sep  8 11:02:53 portatil264 kernel: [  279.083234] nfs41_sequence_process: Error 0 free the slot 
Sep  8 11:02:53 portatil264 kernel: [  279.083236] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:02:53 portatil264 kernel: [  279.083244] NFS: nfs_update_inode(0:53/30801924 fh_crc=0x21ccf1a0 ct=1 info=0x26040)
Sep  8 11:02:53 portatil264 kernel: [  279.083249] NFS: permission(0:53/30801924), mask=0x24, res=0
Sep  8 11:02:53 portatil264 kernel: [  279.083253] NFS: open dir(departamentos/innovacion)
Sep  8 11:02:53 portatil264 kernel: [  279.083278] NFS: readdir(departamentos/innovacion) starting at cookie 0
Sep  8 11:02:53 portatil264 kernel: [  279.083293] _nfs4_proc_readdir: dentry = departamentos/innovacion, cookie = 0
Sep  8 11:02:53 portatil264 kernel: [  279.083298] --> nfs41_call_sync_prepare data->seq_server 00000000368715a5
Sep  8 11:02:53 portatil264 kernel: [  279.083300] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=31
Sep  8 11:02:53 portatil264 kernel: [  279.083302] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
Sep  8 11:02:53 portatil264 kernel: [  279.083326] encode_sequence: sessionid=1582481124:15703:9206:0 seqid=49 slotid=0 max_slotid=0 cache_this=0
Sep  8 11:02:53 portatil264 kernel: [  279.083329] encode_readdir: cookie = 0, verifier = 00000000:00000000, bitmap = 0018091a:00b0a23a:00000000
Sep  8 11:02:53 portatil264 kernel: [  279.188491] nfs41_sequence_process: Error 1 free the slot 
Sep  8 11:02:53 portatil264 kernel: [  279.188494] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
Sep  8 11:02:53 portatil264 kernel: [  279.188501] _nfs4_proc_readdir: returns -5
Sep  8 11:02:53 portatil264 kernel: [  279.188507] NFS: readdir(departamentos/innovacion) returns -5
Sep  8 11:02:53 portatil264 kernel: [  279.189204] NFS: dentry_delete(departamentos/innovacion, 28080c)

--VMt1DrMGOVs3KQwf
Content-Type: application/vnd.tcpdump.pcap
Content-Disposition: attachment; filename="nfs_error.pcap"
Content-Transfer-Encoding: base64

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
jp8AAAEBCAr0NwlxDanApA==

--VMt1DrMGOVs3KQwf--
