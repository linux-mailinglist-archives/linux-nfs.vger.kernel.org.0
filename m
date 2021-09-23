Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B896F4167BA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Sep 2021 23:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbhIWVwa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 17:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhIWVw3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 17:52:29 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43782C061574;
        Thu, 23 Sep 2021 14:50:57 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 61CDD7032; Thu, 23 Sep 2021 17:50:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 61CDD7032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632433856;
        bh=HgXWJ7fIQX5xe6k9zJTR4Q+wC4ChKqdBmSU4vMwSHng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuYX+PcuPjqAU4mDvuK8uynAwSAkU9CmvVt35brl+H7Az5+6BQUSkcitNb5nXc8Tw
         3L6BRY31CCUORfIN4GjU+etkoDJ/dBie3Z2rkQS59Z7G478P8wu6bpjQMurE/v3+wq
         9SQeN9mhOws/txfi1EPaiJKmKowYUpZPGbCbiYHM=
Date:   Thu, 23 Sep 2021 17:50:56 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Locking issue between NFSv4 and SMB client
Message-ID: <20210923215056.GH18334@fieldses.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 15, 2021 at 04:45:22PM -0700, dai.ngo@oracle.com wrote:
> Hi Bruce,

Oops, sorry for neglecting this.

> I'm doing some locking testing between NFSv4 and SMB client and
> think there are some issues on the server that allows both clients
> to lock the same file at the same time.

It's not too surprising to me that getting consistent locks between the
two would be hard.

Did you get any review from a Samba expert?  I seem to recall it having
a lot of options, and I wonder if it's configured correctly for this
case.

It sounds like Samba may be giving out oplocks without getting a lease
from the kernel.

--b.

> Here is what I did:
> 
> NOTE: lck is a simple program that use lockf(3) to lock a file from
> offset 0 to the length specified by '-l'.
> 
> On NFSv4 client
> ---------------
> 
> [root@nfsvmd07 ~]# nfsstat -m
> /tmp/mnt from nfsvmf24:/root/smb_share
> Flags:	rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,
>        proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.80.62.47,
>        local_lock=none,addr=10.80.111.94
> [root@nfsvmd07 ~]#
> 
> 
> [root@nfsvmd07 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
> Lck/file: 1, Maxlocks: 10000000
> Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing F_LOCK..
> LOCKED...
> 
> Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
> 
> [NFS client successfully locks the file]
> 
> On SMB client
> -------------
> 
> [root@nfsvme24 ~]# mount |grep cifs
> //nfsvmf24/smb_share on /tmp/mnt type cifs (rw,relatime,vers=3.1.1,cache=strict,username=root,uid=0,noforceuid,gid=0,noforcegid,addr=10.80.111.94,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)
> [root@nfsvme24 ~]#
> 
> [root@nfsvme24 ~]# smbclient -L nfsvmf24
> Enter SAMBA\root's password:
> 
> 	Sharename       Type      Comment
> 	---------       ----      -------
> 	print$          Disk      Printer Drivers
> 	smb_share       Disk      Test Samba Share       <<===== share to mount
> 	IPC$            IPC       IPC Service (Samba 4.10.16)
> 	root            Disk      Home Directories
> Reconnecting with SMB1 for workgroup listing.
> 
> 	Server               Comment
> 	---------            -------
> 
> 	Workgroup            Master
> 	---------            -------
> [root@nfsvme24 ~]#
> 
> [root@nfsvme24 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
> Lck/file: 1, Maxlocks: 10000000
> Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing F_LOCK..
> LOCKED...
> 
> Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
> 
> [SMB client successfully locks the file]
> 
> The same issue happens when either client locks the file first.
> I think this is what has happened:
> 
> 1. NFSv4 client opens and locks the file first
> 
>     . NFSv4 client send OPEN and LOCK to server, server replies
>       OK on both requests.
> 
>     . SMB client sends create request with Oplock==Lease for
>       the same file.
> 
>     . server holds off on replying to SMB client's create request,
>       recalls delegation from NFSv4 client, waits for NFSv4 client
>       to return the delegation then replies success to SMB client's
>       create request with lease granted (Oplock==Lease).
> 
>       NOTE: I think SMB server should replies the create request
>       with Oplock==None to force the SMB client to sends the
>       lock request.
>
>     . Once SMB client receives the reply of the create with
>       'Oplock==Lease', it assumes it has full control of the file
>       therefor it does not need to send the lock request.
> 
>     . both NFSv4 and SMB client now think they have locked the file.
> 
> pcap:  nfs_lock_smb_lock.pcap
> 
> 2. SMB client creates the file with 'Oplock==Lease' first
> 
>     . SMB sends create request with 'Oplock==Lease' to server,
>       server replies OK with 'Oplock==Lease'. SMB client skips
>       sending lock request since it assumes it has full control
>       of the file with the lease.
> 
>     . NFSv4 client sends OPEN to server, server replies OK with
>       delagation is none. NFSv4 client sends LOCK request, since
>       no lock was created in the kernel for the SMB client, the
>       lock was granted to the NFSv4 client.
> 
>      NOTE: I think the SMB server should send lease break
>      notification to the SMB client, wait for the lease break
>      acknowledgment from SMB client before replying to the
>      OPEN of the NFSv4 client. This will force the SMB client
>      to send the lock request to the server.
> 
>     . both NFSv4 and SMB client now think they have locked the file.
> 
> Your thought?
> 
> Thanks,
> 
> -Dai
