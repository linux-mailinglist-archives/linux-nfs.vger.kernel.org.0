Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B60B0A4B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfILI12 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 04:27:28 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:38584 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfILI11 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Sep 2019 04:27:27 -0400
Received: by mail-pg1-f174.google.com with SMTP id d10so13070309pgo.5
        for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2019 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dug-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=v97YAH92ZzyQXE4C5D4QnSLgVRvEhr+IBZ2YvxfY4vY=;
        b=fcMriUYTTbZGCFjnp7qhLq0wO2FloJsABjOB9CzwREdvXYx8ynmQxZ6rKo3j6oHiR9
         DN2McdBDakaPn55SApqrubP+4WkZsXee3pOzMSgRF+Wl4qrweBFFfVKU8xvI56o7ZKTO
         WpSnslQq5OVQaHsW2cvyFMEYrVCG9vlgtOEXU4a73Vh+oBCmx7fF0inRj434dzbg7esN
         T1dIiMWmeILZsyNSSvuhYDvucTmA9MV+bctY3rHAIMLfFvilI4ovNHs1/Qc8W6gx2sF7
         E9tQjBujyNlka6yVmQWhreZhDtP/vqxO7kGg67RptKPuZkC9HfZYn/vL/621toDEm/f5
         4w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v97YAH92ZzyQXE4C5D4QnSLgVRvEhr+IBZ2YvxfY4vY=;
        b=YkoMyHNWfyjoe87P5bh78OjYQSFvK9t2djssN2qs+eYnfyCIgiAdTP+ADVOHOb7PMY
         qvP6iLlmAurOvWz9UVE35zdSZ2qsbMcGJWiVK3IWbVn71AIgiupEYfBv1ancu8W/T11t
         TWu+BaHl3WylYZvXqO2egMzpQmKwMDTH9MJ2NHA3lcRYhyyJITh0mEvn5MqYh5v1EIJp
         1C+ph6nwyihqECuRkQTAR0N6S31G0d9MRrgn7LqUT3mbFzc7X5pJY5vNrUXvEubbNlkL
         73gp2eZEc7+ilrW/Ji4u543pLPfXFbg+UsJyCWAOibMQ0dozAvbfNIM5SNrjJY4lZG8s
         Yevw==
X-Gm-Message-State: APjAAAWETjR2E2VJVY4fQGzF8xczRpKdYEAEhcND6tNMn50LIGZGs48n
        cjwJyDu18CFY1q6XzKrzGjNI5MJRkecKBuJcwgFRWAb9jWZn7Q==
X-Google-Smtp-Source: APXvYqyZoJH91PVYM7xkFd7XN7kLJR50xiqm2OPebZ7ZGA3GEKzQlB6L4e6O3vV+ahfg+9EqWG2KYHBKMd0vf4B/UjY=
X-Received: by 2002:a63:c304:: with SMTP id c4mr5507767pgd.126.1568276846849;
 Thu, 12 Sep 2019 01:27:26 -0700 (PDT)
MIME-Version: 1.0
From:   Leon Kyneur <leonk@dug.com>
Date:   Thu, 12 Sep 2019 16:27:15 +0800
Message-ID: <CAACwWuN6siyM9t+rCmzxYPCf777bvD_J1xQKwNb7ZzBdzvy42Q@mail.gmail.com>
Subject: troubleshooting LOCK FH and NFS4ERR_BAD_SEQID
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi

I'm experiencing an issue on NFS 4.0 + 4.1 where we cannot call fcntl
locks on any file on the share. The problem goes away if the share is
umount && mount (mount -o remount does not resolve the issue)

Client:
EL 7.4 3.10.0-693.5.2.el7.x86_64 nfs-utils-1.3.0-0.48.el7_4.x86_64

Server:
EL 7.4 3.10.0-693.5.2.el7.x86_64  nfs-utils-1.3.0-0.48.el7_4.x86_64

I can't figure this out but the client reports bad-sequence-id in
dupicate in the logs:
Sep 12 02:16:59 client kernel: NFS: v4 server returned a bad
sequence-id error on an unconfirmed sequence ffff881c52286220!
Sep 12 02:16:59 client kernel: NFS: v4 server returned a bad
sequence-id error on an unconfirmed sequence ffff881c52286220!
Sep 12 02:17:39 client kernel: NFS: v4 server returned a bad
sequence-id error on an unconfirmed sequence ffff8810889cb020!
Sep 12 02:17:39 client kernel: NFS: v4 server returned a bad
sequence-id error on an unconfirmed sequence ffff8810889cb020!
Sep 12 02:17:44 client kernel: NFS: v4 server returned a bad
sequence-id error on an unconfirmed sequence ffff881b414b2620!

wireshark capture shows only 1 BAD_SEQID reply from the server:
$ tshark -r client_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid -z
proto,colinfo,nfs.seqid,nfs.seqid -R 'rpc.xid == 0x9990c61d'
tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
141         93 172.27.30.129 -> 172.27.255.28 NFS 352 V4 Call LOCK FH:
0x80589398 Offset: 0 Length: <End of File>  nfs.seqid == 0x0000004e
nfs.seqid == 0x00000002  rpc.xid == 0x9990c61d
142         93 172.27.255.28 -> 172.27.30.129 NFS 124 V4 Reply (Call
In 141) LOCK Status: NFS4ERR_BAD_SEQID  rpc.xid == 0x9990c61d

system call I have identified as triggering it is:
fcntl(3, F_SETLK, {type=F_RDLCK, whence=SEEK_SET, start=1073741824,
len=1}) = -1 EIO (Input/output error)

The server filesystem is ZFS though NFS sharing is turned off via ZFS
options and it's exported using /etc/exports / nfsd...

The BAD_SEQID error seems to be fairly random, we have over 2000
machines connected to the share and it's experienced frequently but
randomly accross our clients.

It's worth mentioning that the majority of the clients are mounting
4.0 we did try 4.1 everywhere but hit this
https://access.redhat.com/solutions/3146191

mount options are:
server:/data on /d/data type nfs4
(rw,noatime,nodiratime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=172.27.10.45,local_lock=none,addr=172.27.255.28,_netdev)
or:
server:/data on /d/data type nfs4
(rw,noatime,nodiratime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=172.27.30.129,local_lock=none,addr=172.27.255.28,_netdev)

I'm at a bit off a loss as to where to look next, i've tried to
reproduce locking / unlocking threading but cannot seem to create a
test case that triggers it.

Thanks

Leon
