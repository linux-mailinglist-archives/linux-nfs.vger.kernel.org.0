Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81814DAFF8
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 13:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbiCPMoc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 08:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355827AbiCPMob (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 08:44:31 -0400
X-Greylist: delayed 2283 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 05:43:14 PDT
Received: from smtpout-3.cvg.de (smtpout-3.cvg.de [IPv6:2003:49:a034:1067:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2002AC1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 05:43:13 -0700 (PDT)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
        by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 22GC5604258385
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 13:05:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
        s=v2012061000; t=1647432306;
        bh=OWThl9jEsgBbK5Cl0AD8eyxjcVEabLJ19i24HO27nRY=; l=2629;
        h=From:To:Subject:Date;
        b=NuxT56JF9Xxk4KnVZumFDnr/8lJ95MBdqe2hq/Ih6KLAN4K5AKy1FWlai0TGpTXUu
         +boR60xjQYtRs5IAAQRE//sgAE9ErJ9qBcPfjVjneJC6fo4nYW03/Y0C9cluq8PJiy
         Nz2OUa8xhJUeiWJK2gJo35H5nNlmjU/tM048ajKc=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
        by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 22GC54Fc342147
        for <linux-nfs@vger.kernel.org> from enrico.scholz@sigma-chemnitz.de; Wed, 16 Mar 2022 13:05:05 +0100
Received: from mail-msa-3.intern.sigma-chemnitz.de ( [192.168.12.73]) by reddoxx.intern.sigma-chemnitz.de
        (Reddoxx engine) with SMTP id 455F18AEB25; Wed, 16 Mar 2022 13:05:03 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
        by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 22GC53Ub257052
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <linux-nfs@vger.kernel.org> from ensc@sigma-chemnitz.de; Wed, 16 Mar 2022 13:05:03 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
        (envelope-from <ensc@sigma-chemnitz.de>)
        id 1nUSOk-0007el-5p
        for linux-nfs@vger.kernel.org; Wed, 16 Mar 2022 13:05:02 +0100
From:   Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To:     linux-nfs@vger.kernel.org
Subject: Random NFS client lockups
Date:   Wed, 16 Mar 2022 13:05:02 +0100
Message-ID: <lyr172gl1t.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I am experiencing random NFS client lockups after 1-2 days.  Kernel
reports

| nfs: server XXXXXXXXX not responding, timed out

processes are in D state and only a reboot helps.

The full log is available at https://pastebin.pl/view/7d0b345b


I can see one oddity there: shortly before the timeouts, log shows at
05:07:28:

| worker connecting xprt 0000000022aecad1 via tcp to XXXX:2001:1022:: (port 2049)
| 0000000022aecad1 connect status 0 connected 0 sock state 8

All other connects go in EINPROGRESS first

| 0000000022aecad1 connect status 115 connected 0 sock state 2
| ...
| state 8 conn 1 dead 0 zapped 1 sk_shutdown 1


After 'status 0', rpcdebug shows (around 05:07:43)

| --> nfs4_alloc_slot used_slots=03ff highest_used=9 max_slots=30
| <-- nfs4_alloc_slot used_slots=07ff highest_used=10 slotid=10
| ...
| <-- nfs4_alloc_slot used_slots=fffffff highest_used=27 slotid=27
| --> nfs4_alloc_slot used_slots=fffffff highest_used=27 max_slots=30
| ...
| --> nfs4_alloc_slot used_slots=3fffffff highest_used=29 max_slots=30
| <-- nfs4_alloc_slot used_slots=3fffffff highest_used=29 slotid=4294967295
| nfs41_sequence_process: Error 1 free the slot 

and nfs server times out then.


The server reports nearly at this time

| Mar 16 05:02:40 kernel: rpc-srv/tcp: nfsd: got error -32 when sending 112 bytes - shutting down socket

Similar message (with other sizes and sometime error -104) appear
frequently without a related client lockup.


How can I debug this further resp. solve it?


It happens (at least) with:

- a Fedora 35 client with kernel 5.16.7,
  kernel-5.17.0-0.rc7.20220310git3bf7edc84a9e.119.fc37.x86_64 and some
  other between them

- a Rocky Linux 8,5 server with kernel-4.18.0-348.12.2
  and kernel-4.18.0-348.2.1

Problem started after a power outage were whole infrastructure rebooted.
I ran the setup with kernel 5.16.7 on client and 4.18.0-348.2.1 on server
without problems before the outage.


Issue affects a /home directory mounted with

| XXXX:/home /home nfs4 rw,seclabel,nosuid,nodev,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,soft,posix,proto=tcp6,timeo=600,retrans=2,sec=krb5p,clientaddr=XXXX:2001:...,local_lock=none,addr=XXXX:2001:1022:: 0 0

Happens also without the "soft" option.

There are applications like firefox or chromium running which held locks
and access the filesystem frequently.


Logfile was created when rpcdebug enabled

| nfs        proc xdr root callback client mount pnfs pnfs_ld state
| rpc        xprt call debug nfs auth bind sched trans svcsock svcdsp misc cache




Enrico
