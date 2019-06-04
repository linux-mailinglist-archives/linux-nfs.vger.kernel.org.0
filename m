Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24837344EF
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfFDK6m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 4 Jun 2019 06:58:42 -0400
Received: from 193-32-235-38.hosts.ezit.hu ([193.32.235.38]:55588 "EHLO
        zentai.name" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfFDK6l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 06:58:41 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 06:58:39 EDT
From:   Armin Zentai <armin@zentai.name>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Bug? nfs export on fuse, one more READDIR call after a finished
 directory read
Message-Id: <70E96C7E-8DBE-4196-AE06-FA44B0EC992F@zentai.name>
Date:   Tue, 4 Jun 2019 12:51:11 +0200
To:     linux-nfs@vger.kernel.org
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi everyone,


I'm developing a fuse software and it should be able to run _under_ an nfsd export.
Currently I've stripped everything out from the fuse software, and only using it as a mirrorfs. It's written in go and using this lib: https://github.com/hanwen/go-fuse.

My issue a bit complex, but I'll try to explain it as detailed as I can. I like to get some guidance or hint how to proceed with the debugging or a solution of course. 


NFS and kernel settings:
client+server: Debian 9.0 / kernel-5.2.0 (I compiled it with debug symbols)
export options: (rw,sync,no_subtree_check,all_squash,anonuid=505,anongid=20,fsid=4193281846142082570)
client mount options: type nfs4 (rw,noatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=6,sec=sys,clientaddr=10.135.105.205,local_lock=none,addr=10.135.101.174,_netdev)

NFSv3 is explicitly disabled on the server:
cat /proc/fs/nfsd/versions
-2 -3 +4 +4.1 +4.2



The error itself is non-deterministic, but reproducible within ~10 minutes.

Sometimes the client is calling one more READDIR after an empty READDIR reply. The extra READDIR is called with an increased cookie value.
This behaviour is causing an array out-of-bound read in the fuse lib.

This results in an EINVAL error in the go fuse library.
https://github.com/hanwen/go-fuse/blob/master/fuse/nodefs/dir.go#L42
https://github.com/hanwen/go-fuse/blob/master/fuse/nodefs/dir.go#L72
(also there is an open issue by me, https://github.com/hanwen/go-fuse/issues/297)

If this behaviour is totally accepted, then this EINVAL return value can be replaced with fuse.OK in the lib, but I'm a bit curious what is causing this.



The easiest way to reproduce it is using an npm install (without an existing node_modules folder) and in the end it may produce the error.
I haven't debugged the npm install process or reproduced it with a simpler code, but it's happening when removing a directory structure with files.
The npm install at the end removes the fsevents folder with its files. It is downloaded, but not supported on linux (only on OSX) and it removes the module.
So probably it's connected with some npm behaviour which is trying to remove multiple files with multiple async file delete calls.
rm -rf itself can't reproduce the issue.

If I'm running npm install && rm -rf node_modules in a loop, I can reproduce the error in every 2nd - 10th run (approx 2 - 15 minutes).



I've found these things while debugging:

The client is always using readdirplus functions to get directory entries.
If I get a plus=false, then it indicates an error.
Although the error can happen without plus=false too (approx 50/50 chance).


I've used this bpftrace to get it.

```
kprobe:nfs4_xdr_enc_readdir {
  $a = ((struct nfs4_readdir_arg *)arg2);
  if ($a->plus != 1) {
    time("%H:%M:%S\n");
    printf("nfs4_xdr_enc_readdir count=%u plus=%u cookie=%llu\n",
      $a->count, $a->plus, $a->cookie);
  }
}
```

Also there is a kstack, from nfs4_xdr_enc_readdir:
       
nfs4_xdr_enc_readdir count=262144 plus=0 cookie=24
nfs4_xdr_enc_readdir kstack

        nfs4_xdr_enc_readdir+1
        rpcauth_wrap_req_encode+35
        call_encode+357
        __rpc_execute+137
        rpc_run_task+268
        nfs4_call_sync_sequence+100
        _nfs4_proc_readdir+277
        nfs4_proc_readdir+141
        nfs_readdir_xdr_to_array+375
        nfs_readdir+613
        iterate_dir+320
        __x64_sys_getdents+169
        do_syscall_64+85
        entry_SYSCALL_64_after_hwframe+68


Also I found out the extra READDIR call, always (mostly?) has an increased (duplicated) dircount parameter.


From wireshark dump there is an example:

Packets from 1 to 4 are totally normal communication.
5-6 are the extra ones. 
In packet 3, the dircount is 65536 and in packet 5 it is 131072.


1. client -> server
Remote Procedure Call, Type:Call XID:0x04a37c12
Network File System, Ops(3): SEQUENCE, PUTFH, READDIR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
    minorversion: 2
    Operations (count: 3): SEQUENCE, PUTFH, READDIR
        Opcode: SEQUENCE (53)
            sessionid: a2fdea5cc954b1470300000000000000
            seqid: 0x0001e92f
            slot id: 25
            high slot id: 25
            cache this?: No
        Opcode: PUTFH (22)
            FileHandle
        Opcode: READDIR (26)
            cookie: 0
            cookie_verf: 0
            dircount: 65514
            maxcount: 262056
            Attr mask[0]: 0x0018091a (Type, Change, Size, FSID, RDAttr_Error, Filehandle, FileId)
            Attr mask[1]: 0x00b0a23a (Mode, NumLinks, Owner, Owner_Group, RawDev, Space_Used, Time_Access, Time_Metadata, Time_Modify, Mounted_on_FileId)
    [Main Opcode: READDIR (26)]

2. server -> client
Network File System, Ops(3): SEQUENCE PUTFH READDIR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4_OK (0)
    Tag: <EMPTY>
    Operations (count: 3)
        Opcode: SEQUENCE (53)
            Status: NFS4_OK (0)
            sessionid: a2fdea5cc954b1470300000000000000
            seqid: 0x0001e92f
            slot id: 25
            high slot id: 29
            target high slot id: 29
            status flags: 0x00000000
        Opcode: PUTFH (22)
            Status: NFS4_OK (0)
        Opcode: READDIR (26)
            Status: NFS4_OK (0)
            verifier: 0x0000000000000000
            Directory Listing
                Entry: node-pre-gyp
                Entry: needle
                Entry: iconv-lite
                Entry: readable-stream
                Value Follows: No
                EOF: Yes
    [Main Opcode: READDIR (26)]

3. client -> server
Remote Procedure Call, Type:Call XID:0x16a37c12
Network File System, Ops(3): SEQUENCE, PUTFH, READDIR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
    minorversion: 2
    Operations (count: 3): SEQUENCE, PUTFH, READDIR
        Opcode: SEQUENCE (53)
            sessionid: a2fdea5cc954b1470300000000000000
            seqid: 0x000cd063
            slot id: 15
            high slot id: 24
            cache this?: No
        Opcode: PUTFH (22)
            FileHandle
        Opcode: READDIR (26)
            cookie: 6
            cookie_verf: 0
            dircount: 65536
            maxcount: 262144
            Attr mask[0]: 0x0018091a (Type, Change, Size, FSID, RDAttr_Error, Filehandle, FileId)
            Attr mask[1]: 0x00b0a23a (Mode, NumLinks, Owner, Owner_Group, RawDev, Space_Used, Time_Access, Time_Metadata, Time_Modify, Mounted_on_FileId)
    [Main Opcode: READDIR (26)]

4. server -> client
Remote Procedure Call, Type:Reply XID:0x16a37c12
Network File System, Ops(3): SEQUENCE PUTFH READDIR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4_OK (0)
    Tag: <EMPTY>
    Operations (count: 3)
        Opcode: SEQUENCE (53)
            Status: NFS4_OK (0)
            sessionid: a2fdea5cc954b1470300000000000000
            seqid: 0x000cd063
            slot id: 15
            high slot id: 29
            target high slot id: 29
            status flags: 0x00000000
        Opcode: PUTFH (22)
            Status: NFS4_OK (0)
        Opcode: READDIR (26)
            Status: NFS4_OK (0)
            verifier: 0x0000000000000000
            Directory Listing
                Value Follows: No
                EOF: Yes
    [Main Opcode: READDIR (26)]

5. client -> server
Remote Procedure Call, Type:Call XID:0x32a37c12
Network File System, Ops(3): SEQUENCE, PUTFH, READDIR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
    minorversion: 2
    Operations (count: 3): SEQUENCE, PUTFH, READDIR
        Opcode: SEQUENCE (53)
            sessionid: a2fdea5cc954b1470300000000000000
            seqid: 0x0001585c
            slot id: 26
            high slot id: 26
            cache this?: No
        Opcode: PUTFH (22)
            FileHandle
        Opcode: READDIR (26)
            cookie: 7
            cookie_verf: 0
            dircount: 131072
            maxcount: 262144
            Attr mask[0]: 0x00000800 (RDAttr_Error)
            Attr mask[1]: 0x00800000 (Mounted_on_FileId)
    [Main Opcode: READDIR (26)]

6. server -> client
Remote Procedure Call, Type:Reply XID:0x32a37c12
Network File System, Ops(3): SEQUENCE PUTFH READDIR(NFS4ERR_INVAL)
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4ERR_INVAL (22)
    Tag: <EMPTY>
    Operations (count: 3)
        Opcode: SEQUENCE (53)
            Status: NFS4_OK (0)
            sessionid: a2fdea5cc954b1470300000000000000
            seqid: 0x0001585c
            slot id: 26
            high slot id: 29
            target high slot id: 29
            status flags: 0x00000000
        Opcode: PUTFH (22)
            Status: NFS4_OK (0)
        Opcode: READDIR (26)
            Status: NFS4ERR_INVAL (22)
    [Main Opcode: READDIR (26)]


Thanks,
Armin

