Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB8950BB79
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Apr 2022 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiDVPS5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Apr 2022 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449354AbiDVPSd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Apr 2022 11:18:33 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ACE5DA1B
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 08:15:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 25A5A612C; Fri, 22 Apr 2022 11:15:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 25A5A612C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650640534;
        bh=hgssieI0olAMA7NuJFllGkkf+k0MdasxgwknfNGibkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbA0wuSdlFU00/0Si38SuvvfcRb4m33N+8lvouI4QI2HNkD4nhbdgCufkX+5xpHP4
         UhoSy4xVtz3hYBijkpJsmEJXgOFkf1RJ0viEsjYcqqWhGnyf4grwnZFkJXU+ENFky7
         a6GBGr9lN1pJspJkWnVf/czGzMB7rBKBVlkGPY74=
Date:   Fri, 22 Apr 2022 11:15:34 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi
Message-ID: <20220422151534.GA29913@fieldses.org>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org>
 <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 21, 2022 at 11:52:32PM +0000, Rick Macklem wrote:
> J. Bruce Fields <bfields@fieldses.org> wrote:
> [stuff snipped]
> > On Thu, Apr 21, 2022 at 12:40:49PM -0400, bfields wrote:
> > >
> > >
> > > Stale filehandles aren't normal, and suggest some bug or
> > > misconfiguration on the server side, either in NFS or the exported
> > > filesystem.
> > 
> > Actually, I should take that back: if one client removes files while a
> > second client is using them, it'd be normal for applications on that
> > second client to see ESTALE.
> I took a look at crispyduck's packet trace and here's what I saw:
> Packet#
> 48 Lookup of test-ovf.vmx
> 49 NFS_OK FH is 0x7c9ce14b (the hash)
> ...
> 51 Open Claim_FH fo 0x7c9ce14b
> 52 NFS_OK Open Stateid 0x35be
> ...
> 138 Rename test-ovf.vmx~ to test-ovf.vmx
> 139 NFS_OK
> ...
> 141 Close with PutFH 0x7c9ce14b
> 142 NFS4ERR_STALE for the PutFH
> 
> So, it seems that the Rename will delete the file (names another file to the
> same name "test-ovf.vmx".  Then the subsequent Close's PutFH fails,
> because the file for the FH has been deleted.

Actually (sorry I'm slow to understand this)--why would our 4.1 server
ever be returning STALE on a close?  We normally hold a reference to the
file.

Oh, wait, is subtree_check set on the export?  You don't want to do
that.  (The freebsd server probably doesn't even give that as an
option?)

--b.

> 
> Looks like yet another ESXi client bug to me?
> (I've seen assorted other ones, but not this one. I have no idea how this
>  might work on a FreeBSD server. I can only assume the RPC sequence
>  ends up different for FreeBSD for some reason? Maybe the Close gets
>  processed before the Rename? I didn't look at the Sequence args for
>  these RPCs to see if they use different slots.)
> 
> 
> > So it might be interesting to know what actually happens when VM
> > templates are imported.
> If you look at the packet trace, somewhat weird, like most things for this
> client. It does a Lookup of the same file name over and over again, for
> example.
> 
> > I suppose you could also try NFSv4.0 or try varying kernel versions to
> > try to narrow down the problem.
> I think it only does NFSv4.1.
> I've tried to contact the VMware engineers, but never had any luck.
> I wish they'd show up at a bakeathon, but...
> 
> > No easy ideas off the top of my head, sorry.
> I once posted a list of problems I had found with ESXi 6.5 to a FreeBSD
> mailing list and someone who worked for VMware cut/pasted it into their
> problem database.  They responded to him with "might be fixed in a future
> release" and, indeed, they were fixed in ESXi 6.7, so if you can get this to
> them, they might fix it?
> 
> rick
> 
> --b.
> 
> > Figuring out more than that would require more
> > investigation.
> >
> > --b.
> >
> > >
> > > Br,
> > > Andi
> > >
> > >
> > >
> > >
> > >
> > >
> > > Von: Chuck Lever III <chuck.lever@oracle.com>
> > > Gesendet: Donnerstag, 21. April 2022 16:58
> > > An: Andreas Nagy <crispyduck@outlook.at>
> > > Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> > > Betreff: Re: Problems with NFS4.1 on ESXi
> > >
> > > Hi Andreas-
> > >
> > > > On Apr 21, 2022, at 12:55 AM, Andreas Nagy <crispyduck@outlook.at> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I hope this mailing list is the right place to discuss some problems with nfs4.1.
> > >
> > > Well, yes and no. This is an upstream developer mailing list,
> > > not really for user support.
> > >
> > > You seem to be asking about products that are currently supported,
> > > and I'm not sure if the Debian kernel is stock upstream 5.13 or
> > > something else. ZFS is not an upstream Linux filesystem and the
> > > ESXi NFS client is something we have little to no experience with.
> > >
> > > I recommend contacting the support desk for your products. If
> > > they find a specific problem with the Linux NFS server's
> > > implementation of the NFSv4.1 protocol, then come back here.
> > >
> > >
> > > > Switching from FreeBSD host as NFS server to a Proxmox environment also serving NFS I see some strange issues in combination with VMWare ESXi.
> > > >
> > > > After first thinking it works fine, I started to realize that there are problems with ESXi datastores on NFS4.1 when trying to import VMs (OVF).
> > > >
> > > > Importing ESXi OVF VM Templates fails nearly every time with a ESXi error message "postNFCData failed: Not Found". With NFS3 it is working fine.
> > > >
> > > > NFS server is running on a Proxmox host:
> > > >
> > > >  root@sepp-sto-01:~# hostnamectl
> > > >  Static hostname: sepp-sto-01
> > > >  Icon name: computer-server
> > > >  Chassis: server
> > > >  Machine ID: 028da2386e514db19a3793d876fadf12
> > > >  Boot ID: c5130c8524c64bc38994f6cdd170d9fd
> > > >  Operating System: Debian GNU/Linux 11 (bullseye)
> > > >  Kernel: Linux 5.13.19-4-pve
> > > >  Architecture: x86-64
> > > >
> > > >
> > > > File system is ZFS, but also tried it with others and it is the same behaivour.
> > > >
> > > >
> > > > ESXi version 7.2U3
> > > >
> > > > ESXi vmkernel.log:
> > > > 2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortCompliance:209: [nsx@6876 comp="nsx-esx" subcomp="vswitch"]client vmk1 requested promiscuous mode on port 0x4000010, disallowed by vswitch policy
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)World: 12075: VC opID esxui-d6ab-f678 maps to vmkernel opID 936118c3
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 failed: Stale file handle
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> > > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed: Stale file handle
> > > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> > > > 2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for VPD page 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported
> > > > 2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path evaluation for device mpx.vmhba32:C0:T0:L0
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)World: 12075: VC opID esxui-6787-f694 maps to vmkernel opID 9529ace7
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > >
> > > > tcpdump taken on the esxi with filter on the nfs server ip is attached here:
> > > > https://easyupload.io/xvtpt1
> > > >
> > > > I tried to analyze, but have no idea what exactly the problem is. Maybe it is some issue with the VMWare implementation?
> > > > Would be nice if someone with better NFS knowledge could have a look on the traces.
> > > >
> > > > Best regards,
> > > > cd
> > >
> > > --
> > > Chuck Lever
> > >
