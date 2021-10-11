Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3210B42946B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Oct 2021 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhJKQXu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Oct 2021 12:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhJKQXt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Oct 2021 12:23:49 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9E1C061745;
        Mon, 11 Oct 2021 09:21:49 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B88861BE2; Mon, 11 Oct 2021 12:21:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B88861BE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633969308;
        bh=9wd9N1FjnZD3ZNUJ+Db+3dc6yc9Uo9h/s6C/qBTTuEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rU9LOLkYM2k8bWqwO7RLOpxSR4sxjjmIapeCLqsA80owMdh8MCF77uwQmZ8wbTVdz
         l+YkcQQFOf7B0293YJ0uG2iTD55HjZBGUfoPfutWz6ryhIqKXTki7C62K/NHCYVtzl
         kAJt0d+LwAIELe3oX8EY7JckBykNnpX77BbWuNmI=
Date:   Mon, 11 Oct 2021 12:21:48 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Locking issue between NFSv4 and SMB client
Message-ID: <20211011162148.GE22387@fieldses.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <90a8f89b-e8ac-2187-2926-d723ebbcb839@oracle.com>
 <4c98a686-3be9-6f95-ea1a-8f03fbf3ea0c@oracle.com>
 <adb4f18d-1b2a-1cf6-3209-f34cdc95d4f0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adb4f18d-1b2a-1cf6-3209-f34cdc95d4f0@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 07, 2021 at 10:38:45AM -0700, dai.ngo@oracle.com wrote:
> 
> On 10/7/21 10:03 AM, dai.ngo@oracle.com wrote:
> >
> >On 9/23/21 3:39 PM, dai.ngo@oracle.com wrote:
> >>
> >>On 9/23/21 2:50 PM, Bruce Fields wrote:
> >>>On Thu, Jul 15, 2021 at 04:45:22PM -0700, dai.ngo@oracle.com wrote:
> >>>>Hi Bruce,
> >>>Oops, sorry for neglecting this.
> >>>
> >>>>I'm doing some locking testing between NFSv4 and SMB client and
> >>>>think there are some issues on the server that allows both clients
> >>>>to lock the same file at the same time.
> >>>It's not too surprising to me that getting consistent locks between the
> >>>two would be hard.
> >>>
> >>>Did you get any review from a Samba expert?  I seem to recall it having
> >>>a lot of options, and I wonder if it's configured correctly for this
> >>>case.
> >>
> >>No, I have not heard from any Samba expert.
> >>
> >>>
> >>>It sounds like Samba may be giving out oplocks without getting a lease
> >>>from the kernel.
> >>
> >>I will have to circle back to this when we're done with the 1st
> >>phase of courteous server.
> >
> >I disabled oplock for the SMB share and locking between NFSv4 and SMB
> >client works as expected. It appears that smbd does not set the VFS
> >lease on the file after granting oplock to smb client.
> 
> Enabling kernel oplocks has the same effect, smbd does not grant oplock
> to client forcing it to send lock request.

OK, good, so that's working as expected.

I understand that there are still some deficiencies in the kernel lease
implementation, but I'm not sure how to hit those cases with this kind
of testing.

--b.

> 
> -Dai
> 
> >
> >-Dai
> >
> >>-Dai
> >>
> >>>
> >>>--b.
> >>>
> >>>>Here is what I did:
> >>>>
> >>>>NOTE: lck is a simple program that use lockf(3) to lock a file from
> >>>>offset 0 to the length specified by '-l'.
> >>>>
> >>>>On NFSv4 client
> >>>>---------------
> >>>>
> >>>>[root@nfsvmd07 ~]# nfsstat -m
> >>>>/tmp/mnt from nfsvmf24:/root/smb_share
> >>>>Flags:
> >>>>rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,
> >>>>proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.80.62.47,
> >>>>        local_lock=none,addr=10.80.111.94
> >>>>[root@nfsvmd07 ~]#
> >>>>
> >>>>
> >>>>[root@nfsvmd07 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
> >>>>Lck/file: 1, Maxlocks: 10000000
> >>>>Locking[/tmp/mnt/messages] Offset[0] Len[100000000]
> >>>>N[0]...doing F_LOCK..
> >>>>LOCKED...
> >>>>
> >>>>Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
> >>>>
> >>>>[NFS client successfully locks the file]
> >>>>
> >>>>On SMB client
> >>>>-------------
> >>>>
> >>>>[root@nfsvme24 ~]# mount |grep cifs
> >>>>//nfsvmf24/smb_share on /tmp/mnt type cifs (rw,relatime,vers=3.1.1,cache=strict,username=root,uid=0,noforceuid,gid=0,noforcegid,addr=10.80.111.94,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)
> >>>>[root@nfsvme24 ~]#
> >>>>
> >>>>[root@nfsvme24 ~]# smbclient -L nfsvmf24
> >>>>Enter SAMBA\root's password:
> >>>>
> >>>>    Sharename       Type      Comment
> >>>>    ---------       ----      -------
> >>>>    print$          Disk      Printer Drivers
> >>>>    smb_share       Disk      Test Samba Share <<===== share to mount
> >>>>    IPC$            IPC       IPC Service (Samba 4.10.16)
> >>>>    root            Disk      Home Directories
> >>>>Reconnecting with SMB1 for workgroup listing.
> >>>>
> >>>>    Server               Comment
> >>>>    ---------            -------
> >>>>
> >>>>    Workgroup            Master
> >>>>    ---------            -------
> >>>>[root@nfsvme24 ~]#
> >>>>
> >>>>[root@nfsvme24 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
> >>>>Lck/file: 1, Maxlocks: 10000000
> >>>>Locking[/tmp/mnt/messages] Offset[0] Len[100000000]
> >>>>N[0]...doing F_LOCK..
> >>>>LOCKED...
> >>>>
> >>>>Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
> >>>>
> >>>>[SMB client successfully locks the file]
> >>>>
> >>>>The same issue happens when either client locks the file first.
> >>>>I think this is what has happened:
> >>>>
> >>>>1. NFSv4 client opens and locks the file first
> >>>>
> >>>>     . NFSv4 client send OPEN and LOCK to server, server replies
> >>>>       OK on both requests.
> >>>>
> >>>>     . SMB client sends create request with Oplock==Lease for
> >>>>       the same file.
> >>>>
> >>>>     . server holds off on replying to SMB client's create request,
> >>>>       recalls delegation from NFSv4 client, waits for NFSv4 client
> >>>>       to return the delegation then replies success to SMB client's
> >>>>       create request with lease granted (Oplock==Lease).
> >>>>
> >>>>       NOTE: I think SMB server should replies the create request
> >>>>       with Oplock==None to force the SMB client to sends the
> >>>>       lock request.
> >>>>
> >>>>     . Once SMB client receives the reply of the create with
> >>>>       'Oplock==Lease', it assumes it has full control of the file
> >>>>       therefor it does not need to send the lock request.
> >>>>
> >>>>     . both NFSv4 and SMB client now think they have locked the file.
> >>>>
> >>>>pcap:  nfs_lock_smb_lock.pcap
> >>>>
> >>>>2. SMB client creates the file with 'Oplock==Lease' first
> >>>>
> >>>>     . SMB sends create request with 'Oplock==Lease' to server,
> >>>>       server replies OK with 'Oplock==Lease'. SMB client skips
> >>>>       sending lock request since it assumes it has full control
> >>>>       of the file with the lease.
> >>>>
> >>>>     . NFSv4 client sends OPEN to server, server replies OK with
> >>>>       delagation is none. NFSv4 client sends LOCK request, since
> >>>>       no lock was created in the kernel for the SMB client, the
> >>>>       lock was granted to the NFSv4 client.
> >>>>
> >>>>      NOTE: I think the SMB server should send lease break
> >>>>      notification to the SMB client, wait for the lease break
> >>>>      acknowledgment from SMB client before replying to the
> >>>>      OPEN of the NFSv4 client. This will force the SMB client
> >>>>      to send the lock request to the server.
> >>>>
> >>>>     . both NFSv4 and SMB client now think they have locked the file.
> >>>>
> >>>>Your thought?
> >>>>
> >>>>Thanks,
> >>>>
> >>>>-Dai
