Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FFC4E3B7A
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 10:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiCVJMQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Mar 2022 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiCVJMP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Mar 2022 05:12:15 -0400
X-Greylist: delayed 528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 02:10:44 PDT
Received: from mail.essepidev.it (mail.essepidev.it [80.211.164.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32017E592
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 02:10:44 -0700 (PDT)
Message-ID: <1e533cc2-477b-de30-e347-582d83973390@essepidev.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=essepidev.it;
        s=dkim; t=1647939713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qdNrK1ddv3CJxg6bRRKawQ7lPwou6gr5cyfnCLwNr6M=;
        b=ehbg/PIIeWIm2T4ovRZ3uwMLDfN23BpxTNpcXbD9A0nA6Re34hwUTZB07uiDwVHkhgv6ZP
        P8lp5mNpOSUyK+/j5nlZPlmKTi2znF9IyAQE8i5Lw6UKUjEeYESkrW3vuTRb16+ZZQ3+2k
        rtS8I8rDpRWLYAYBd1FGin32UFvBpb8l0zuZ1ef383cYFe23Th+mtQQ2U9MfbTtGOyK1c1
        75ewL7qp9/t3YHLVjTTcHpS8drDH/of3/oC0iHSM272nzVq3QLpqD0O59PwCeCKV1a8lsj
        H8gUord2mwxy3URkqKwFiLulK2z7A7UMmKGkpKYULD6W4MT+AeyCba9B6ZWzhg==
Date:   Tue, 22 Mar 2022 10:00:47 +0100
MIME-Version: 1.0
Content-Language: en-GB
To:     linux-nfs@vger.kernel.org
From:   Sebastiano Pomata <seb@essepidev.it>
Subject: NFSv41 server delegations breaking ld?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.essepidev.it;
        auth=pass smtp.mailfrom=seb@essepidev.it
X-Spamd-Bar: /
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In the company I work for we just deployed a small cluster of Linux 
workstations, using FreeIPA/NFS/Kerberos and NFS-shared home 
directories. The NFS server runs on CentOS 7 while the clients are on 
Rocky Linux 8. As far as I can see from the mount command, v4.1 of the 
NFS protocol is being used.

During the first days of working with this new setup, we started 
observing errors on most client machines while working on a 
NFS-mounted directory: specifically, while compiling with gcc/ld, the 
ld linker often failed with a

“: final close failed: Input/output error”

This error could be consistently triggered once it appeared, however 
the conditions in order to reproduce it among different clients are 
not clear to us. The expected output of the compilation is a ~40 MB 
.so file.

Further investigations and a call with strace revealed that a close() 
function was failing with a “-1/EIO” error, thus causing the whole 
compilation to fail.

Enabling some extra debugging info via rpcdebug for the NFS client and 
server provided some useful insights and, by looking at these logs, 
somebody in the #centos IRC channel pointed to NFS 4.1 server 
delegations feature as a potential culprit (and suggested sending a 
message to this ML).

Effectively, after echoing a 0 to /proc/sys/fs/leases-enable on the 
NFS server and remounting the NFS volume on the client, the issue 
appears to be fixed.
Furthermore, on some clients where the NFS volume remount hasn’t yet 
been performed, the ld operation will still fail with the same error, 
again without a clear pattern for reproducibility.

I have collected a strace of the failing gcc/ld compilation and a 
tcpdump capture of the traffic between the NFS client and server 
during the failing compilation, hoping it could be useful for somebody 
to shine some light on the issue.

Versions involved:
NFS server: kernel version 5.4.175-1.el7.elrepo x86_64
NFS clients: kernel version 5.4.178-1.el8.elrepo x86_64, gcc 8.5.0 
20210514, ld 2.30-108.el8_5.1


Kind regards,
Sebastiano Pomata
