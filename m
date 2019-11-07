Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4303F27EB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2019 08:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfKGHMO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Nov 2019 02:12:14 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:41489 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfKGHMO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Nov 2019 02:12:14 -0500
Received: by mail-io1-f50.google.com with SMTP id r144so1133509iod.8
        for <linux-nfs@vger.kernel.org>; Wed, 06 Nov 2019 23:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fjof70Q5BDDYr3u9yhKcASI0NWfEOpDeUrP//wejMLw=;
        b=lguBpA8VLD2v3d7oKXZFm/YgagRu3D+sZtFWFmpEEFGs8UTvfN3MlVdvuWdTiFvZAI
         SvaR5rqEeBuACyY2zdfL31HP4Ow4tjY3lBWWOc+cA4zHGIuQPxKjLFTUBIJdGZe1qyOn
         80bmMfV/f+ScKz4ur9cYwy8cIogdKOysIEZn90+OSURh29yQ7J+p3shn+xZ2JI3oTesr
         Nm/wS4+71YwHkJHzjBxvW+SSdwZSQ+UkgP5Owql+HmNBWg7jHZh9NgMqKYsVOEg6iz2y
         5h3jh6BBG6x0P3oEo68yKqm1QpfpuDXd7liwPCgvZ/h8ynSjZFJche9Ke0x91bn222MJ
         4ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fjof70Q5BDDYr3u9yhKcASI0NWfEOpDeUrP//wejMLw=;
        b=VwjAr0vahyVUBCV2YwDnR+6xaOpCiyJJFPRDyFcqXiahPTwXM/bYd+isP6JsreZGYO
         We9QB0NUTG+3e9737RQeckSLUdGxx94eWFprNKap3ARkbLgA0nHqLFKi/F5jQk/AjgAx
         NyWU6Sz1q/4t5daGtVS/gm1LSv4dvGe7B4av8sxum4ilngr32q+o6m23tyGZNkbINHq3
         LUWzFVevPMeLLRmprPJrFe9aaHAQA+wxmaSb/fsx7kAK9MhBtqVWMuqJTbqb56Lj+hkw
         if1caAtxBw1swSUZCPXjPtUh/3kvV61rjUyWbn/T3XadUzvtBjwkh69fyx361rmlMdDK
         WXZw==
X-Gm-Message-State: APjAAAW6O95u4Ig5TeAaBseuJtAx+mQV0qc10rDXVI7i6Hj3ER8q8w+A
        4zmge5z/g7gzNRcpchFT6PFgV9WFYrv7iCZrZdO74gyzVls=
X-Google-Smtp-Source: APXvYqyyxEHsZIhV4um2bsgLVVCTRDMJdNWswaeYtCDS+haWgOKliZ9eTzpegWRL9S6v6KjxwfiUaCSpvOHrnos8eFI=
X-Received: by 2002:a6b:b486:: with SMTP id d128mr1949789iof.47.1573110732507;
 Wed, 06 Nov 2019 23:12:12 -0800 (PST)
MIME-Version: 1.0
From:   Ashish Sangwan <ashishsangwan2@gmail.com>
Date:   Thu, 7 Nov 2019 12:42:01 +0530
Message-ID: <CAOiN93k1ixM4PZfgbe11qCa9RMuD-9RjPMXqDvkn4w=S4wCp6w@mail.gmail.com>
Subject: nfsv4 client sending getattr RPC with filehandle length 0 to wrong
 server node
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

client kernel version: Linux version 2.6.32-504.el6.x86_64 and CentOS
release 6.6 (Final)

The following command failed: df /mnt/share_mount/nfsexport_2 -BG with
bad handle error
The pseudo root of the v4 tree is mounted at
NewFs-bd7c39.child4.afs.minerva.com:/ on /mnt/share_mount type nfs
(rw,vers=4,addr=10.53.86.99,clientaddr=10.46.187.210)

while nfsexport_2 is submounted:
/mnt/share_mount/nfsexport_2 from
NewFs-bd7c39.child4.afs.minerva.com:/nfsexport_2/
 Flags: rw,relatime,vers=4,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=10.46.187.210,minorversion=0,local_lock=none,addr=10.53.86.94

Looking at the network traces, there's a getattr request which wrongly
went to addr 10.53.86.99 with filehandle length 0, while all the
previous calls to nfsexport_2 were correctly sent to 10.53.86.94 after
the referral had been established.

Frame 11457: 182 bytes on wire (1456 bits), 182 bytes captured (1456 bits)
Ethernet II, Src: Nutanix_dd:f9:f1 (50:6b:8d:dd:f9:f1), Dst:
BigSwitc_08:5d:59 (5c:16:c7:08:5d:59)
Internet Protocol Version 4, Src: 10.46.187.210, Dst: 10.53.86.99
Transmission Control Protocol, Src Port: 852, Dst Port: 2049, Seq:
4169, Ack: 2209, Len: 116
Remote Procedure Call, Type:Call XID:0x547d9fd7
Network File System, Ops(2): PUTFH, GETATTR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
    minorversion: 0
    Operations (count: 2): PUTFH, GETATTR
        Opcode: PUTFH (22)
            FileHandle
                length: 0
        Opcode: GETATTR (9)
            Attr mask[0]: 0x00e00000 (Files_Avail, Files_Free, Files_Total)
            Attr mask[1]: 0x00001c00 (Space_Avail, Space_Free, Space_Total)
    [Main Opcode: GETATTR (9)]


Looking at the nfs client side debug logs, it changed the xprt *just*
for doing the STATFS call.
In the last successful call (18768) we can see the xprt as
ffff88007ce98800 which is connected to 94 while the call which hit
error has xprt ffff88007a74c800 which is connected to 99

kernel: NFS: nfs_update_inode(0:16/562949953421312 fh_crc=0xeab37a6a
ct=2 info=0x27e7f)
kernel: NFS: permission(0:16/562949953421312), mask=0x24, res=0
kernel: NFS: open dir(/)
kernel: RPC:       looking up Generic cred
kernel: NFS: revalidating (0:16/562949953421312)
kernel: RPC:       new task initialized, procpid 4056
kernel: RPC:       allocated task ffff88007b6aee80
kernel: RPC: 18768 __rpc_execute flags=0x80
kernel: RPC: 18768 call_start nfs4 proc GETATTR (sync)
kernel: RPC: 18768 call_reserve (status 0)
kernel: RPC: 18768 reserved req ffff88007a512a00 xid 87076d37
kernel: RPC:       wake_up_first(ffff88007ce98990 "xprt_sending")
kernel: RPC: 18768 call_reserveresult (status 0)
kernel: RPC: 18768 call_refresh (status 0)
kernel: RPC: 18768 looking up UNIX cred
kernel: RPC:       looking up UNIX cred
kernel: RPC: 18768 refreshing UNIX cred ffff880079e543c0
kernel: RPC: 18768 call_refreshresult (status 0)
kernel: RPC: 18768 call_allocate (status 0)
kernel: RPC: 18768 allocated buffer of size 1060 at ffff88007cb68800
kernel: RPC: 18768 call_bind (status 0)
kernel: RPC: 18768 call_connect xprt ffff88007ce98800 is connected
kernel: RPC: 18768 call_transmit (status 0)
kernel: RPC: 18768 xprt_prepare_transmit
kernel: RPC: 18768 rpc_xdr_encode (status 0)
kernel: RPC: 18768 marshaling UNIX cred ffff880079e543c0
kernel: RPC: 18768 using AUTH_UNIX cred ffff880079e543c0 to wrap rpc data
kernel: encode_compound: tag=
kernel: RPC: 18768 xprt_transmit(140)
kernel: RPC:       xs_tcp_send_request(140) = 140
kernel: RPC: 18768 xmit complete
kernel: RPC: 18768 sleep_on(queue "xprt_pending" time 4298144477)
kernel: RPC: 18768 added to queue ffff88007ce98a58 "xprt_pending"
kernel: RPC: 18768 setting alarm for 60000 ms
kernel: RPC:       wake_up_first(ffff88007ce98990 "xprt_sending")
kernel: RPC: 18768 sync task going to sleep
kernel: RPC:       xs_tcp_data_ready...
kernel: RPC:       xs_tcp_data_recv started
kernel: RPC:       reading TCP record fragment of length 188
kernel: RPC:       reading XID (4 bytes)
kernel: RPC:       reading reply for XID 87076d37
kernel: RPC:       reading CALL/REPLY flag (4 bytes)
kernel: RPC:       read reply XID 87076d37
kernel: RPC:       XID 87076d37 read 180 bytes
kernel: RPC:       xprt = ffff88007ce98800, tcp_copied = 188,
tcp_offset = 188, tcp_reclen = 188
kernel: RPC: 18768 xid 87076d37 complete (188 bytes received)
kernel: RPC: 18768 __rpc_wake_up_task (now 4298144478)
kernel: RPC: 18768 disabling timer
kernel: RPC: 18768 removed from queue ffff88007ce98a58 "xprt_pending"
kernel: RPC:       __rpc_wake_up_task done
kernel: RPC:       xs_tcp_data_recv done
kernel: RPC: 18768 sync task resuming
kernel: RPC: 18768 call_status (status 188)
kernel: RPC: 18768 call_decode (status 188)
kernel: RPC: 18768 validating UNIX cred ffff880079e543c0
kernel: RPC: 18768 using AUTH_UNIX cred ffff880079e543c0 to unwrap rpc data
kernel: decode_attr_type: type=040000
kernel: decode_attr_change: change attribute=1572863231723295000
kernel: decode_attr_size: file size=5
kernel: decode_attr_fsid: fsid=(0x564673e3cfd41261/0xe48e57b33609a6a7)
kernel: decode_attr_fileid: fileid=562949953421312
kernel: decode_attr_fs_locations: fs_locations done, error = 0
kernel: decode_attr_mode: file mode=01777
kernel: decode_attr_nlink: nlink=2
kernel: decode_attr_owner: uid=0
kernel: decode_attr_group: gid=0
kernel: decode_attr_rdev: rdev=(0x0:0x0)
kernel: decode_attr_space_used: space used=512
kernel: decode_attr_time_access: atime=1572862994
kernel: decode_attr_time_metadata: ctime=1572863231
kernel: decode_attr_time_modify: mtime=1572863231
kernel: decode_attr_mounted_on_fileid: fileid=0
kernel: decode_getfattr_attrs: xdr returned 0
kernel: decode_getfattr_generic: xdr returned 0
kernel: RPC: 18768 call_decode result 0
kernel: RPC: 18768 return 0, status 0
kernel: RPC: 18768 release task
kernel: RPC:       freeing buffer of size 1060 at ffff88007cb68800
kernel: RPC: 18768 release request ffff88007a512a00
kernel: RPC:       wake_up_first(ffff88007ce98b20 "xprt_backlog")
kernel: RPC:       rpc_release_client(ffff880079cfce00)
kernel: RPC: 18768 freeing task
kernel: NFS: nfs_update_inode(0:16/562949953421312 fh_crc=0xeab37a6a
ct=2 info=0x27e7f)
kernel: NFS: (0:16/562949953421312) revalidation complete
kernel: RPC:       looking up Generic cred
kernel: NFS: permission(0:14/0), mask=0x1, res=0
kernel: NFS: nfs_lookup_revalidate(/nfsexport_2) is valid
kernel: RPC:       new task initialized, procpid 4056
kernel: RPC:       allocated task ffff88007b6aee80
kernel: RPC: 18769 __rpc_execute flags=0x80
kernel: RPC: 18769 call_start nfs4 proc STATFS (sync)
kernel: RPC: 18769 call_reserve (status 0)
kernel: RPC: 18769 reserved req ffff88007ae15c00 xid 547d9fd7
kernel: RPC:       wake_up_first(ffff88007a74c990 "xprt_sending")
kernel: RPC: 18769 call_reserveresult (status 0)
kernel: RPC: 18769 call_refresh (status 0)
kernel: RPC: 18769 looking up UNIX cred
kernel: RPC:       looking up UNIX cred
kernel: RPC: 18769 refreshing UNIX cred ffff880079e543c0
kernel: RPC: 18769 call_refreshresult (status 0)
kernel: RPC: 18769 call_allocate (status 0)
kernel: RPC: 18769 allocated buffer of size 1060 at ffff88007cb68800
kernel: RPC: 18769 call_bind (status 0)
kernel: RPC: 18769 call_connect xprt ffff88007a74c800 is connected
kernel: RPC: 18769 call_transmit (status 0)
kernel: RPC: 18769 xprt_prepare_transmit
kernel: RPC: 18769 rpc_xdr_encode (status 0)
kernel: RPC: 18769 marshaling UNIX cred ffff880079e543c0
kernel: RPC: 18769 using AUTH_UNIX cred ffff880079e543c0 to wrap rpc data
kernel: encode_compound: tag=
kernel: RPC: 18769 xprt_transmit(116)
kernel: RPC:       xs_tcp_send_request(116) = 116
kernel: RPC: 18769 xmit complete
kernel: RPC: 18769 sleep_on(queue "xprt_pending" time 4298144478)
kernel: RPC: 18769 added to queue ffff88007a74ca58 "xprt_pending"
kernel: RPC: 18769 setting alarm for 60000 ms
kernel: RPC:       wake_up_first(ffff88007a74c990 "xprt_sending")
kernel: RPC: 18769 sync task going to sleep
kernel: RPC:       xs_tcp_data_ready...
kernel: RPC:       xs_tcp_data_recv started
kernel: RPC:       reading TCP record fragment of length 44
kernel: RPC:       reading XID (4 bytes)
kernel: RPC:       reading reply for XID 547d9fd7
kernel: RPC:       reading CALL/REPLY flag (4 bytes)
kernel: RPC:       read reply XID 547d9fd7
kernel: RPC:       XID 547d9fd7 read 36 bytes
kernel: RPC:       xprt = ffff88007a74c800, tcp_copied = 44,
tcp_offset = 44, tcp_reclen = 44
kernel: RPC: 18769 xid 547d9fd7 complete (44 bytes received)
kernel: RPC: 18769 __rpc_wake_up_task (now 4298144478)
kernel: RPC: 18769 disabling timer
kernel: RPC: 18769 removed from queue ffff88007a74ca58 "xprt_pending"
kernel: RPC:       __rpc_wake_up_task done
kernel: RPC:       xs_tcp_data_recv done
kernel: RPC: 18769 sync task resuming
kernel: RPC: 18769 call_status (status 44)
kernel: RPC: 18769 call_decode (status 44)
kernel: RPC: 18769 validating UNIX cred ffff880079e543c0
kernel: RPC: 18769 using AUTH_UNIX cred ffff880079e543c0 to unwrap rpc data
kernel: RPC: 18769 call_decode result -521
kernel: RPC: 18769 return 0, status -521
kernel: RPC: 18769 release task
kernel: RPC:       freeing buffer of size 1060 at ffff88007cb68800
kernel: RPC: 18769 release request ffff88007ae15c00
kernel: RPC:       wake_up_first(ffff88007a74cb20 "xprt_backlog")
kernel: RPC:       rpc_release_client(ffff88007c994a00)
kernel: RPC: 18769 freeing task
kernel: nfs_statfs: statfs error = 521

Any idea what could have went wrong here? Is this client issue which
might have been fixed in later versions?
BTW, this issue is not very frequent, we hit this randomly after few days.
Also, if any other logs are required, please let me know.

Thanks,
Ashish
