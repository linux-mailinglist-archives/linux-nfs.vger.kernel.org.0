Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF37331A24
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCHWWP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 8 Mar 2021 17:22:15 -0500
Received: from us-smtp-delivery-145.mimecast.com ([216.205.24.145]:37280 "EHLO
        us-smtp-delivery-145.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231142AbhCHWWP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 17:22:15 -0500
X-Greylist: delayed 15603 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 17:22:15 EST
Received: from zmcc-3-mta-2.zmailcloud.com (zmcc-3-mta-2.zmailcloud.com
 [35.238.170.66]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-bgnMDN7vMKSKwykOgkGYIA-1; Mon, 08 Mar 2021 17:22:12 -0500
X-MC-Unique: bgnMDN7vMKSKwykOgkGYIA-1
Received: from zmcc-3-mta-2.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTPS id 3C465E294B;
        Mon,  8 Mar 2021 16:22:11 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTP id 2CFB5E2954;
        Mon,  8 Mar 2021 16:22:11 -0600 (CST)
X-Virus-Scanned: amavisd-new at zmcc-3-mta-2.zmailcloud.com
Received: from zmcc-3-mta-2.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-2.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LmM8cvtXC1ZZ; Mon,  8 Mar 2021 16:22:11 -0600 (CST)
Received: from jbreitman-mac.zxcvm.com (unknown [72.22.182.150])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTPSA id ED3BEE28C6;
        Mon,  8 Mar 2021 16:22:10 -0600 (CST)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: NFS Mount Hangs
From:   Jason Breitman <jbreitman@tildenparkcapital.com>
In-Reply-To: <2b13577bb30faf3b475d2d602be57aa135023a53.camel@hammerspace.com>
Date:   Mon, 8 Mar 2021 17:22:10 -0500
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-Id: <15CD7763-6DE5-4DBA-8FAE-859964AA90AC@tildenparkcapital.com>
References: <C643BB9C-6B61-4DAC-8CF9-CE04EA7292D0@tildenparkcapital.com>
 <5E3B228F-5CFC-4EDF-B52E-1CDB947ADC00@tildenparkcapital.com>
 <2b13577bb30faf3b475d2d602be57aa135023a53.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA45A274 smtp.mailfrom=jbreitman@tildenparkcapital.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: tildenparkcapital.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you.
Do you know which kernel version is fixed?
If not, is there something I can look for in the source code that will indicate that the kernel is fixed.

Jason Breitman


On Mar 8, 2021, at 5:15 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:

On Mon, 2021-03-08 at 13:16 -0500, Jason Breitman wrote:
> Issue
> NFSv4 mounts periodically hang on the NFS Client.
> 
> During this time, it is possible to manually mount from another NFS
> Server on the NFS Client having issues.
> Also, other NFS Clients are successfully mounting from the NFS Server
> in question.
> Rebooting the NFS Client appears to be the only solution.
> 
> I believe this issue has been discussed in the past so I included an
> article that matched my symptoms.
> I do not see a case statement for FIN_WAIT2 at
> https://elixir.bootlin.com/linux/v4.19.171/source/net/sunrpc/xprtsock.c
> .
> 
> NFS Client
> OS:             Debian Buster 10.8
> Kernel: 4.19.171-2
> Protocol:       NFSv4 with Kerberos Security
> Mount Options:  nfs-
> server.domain.com:/data     /mnt/data       nfs4    lookupcache=pos,n
> oresvport,sec=krb5,hard,rsize=1048576,wsize=1048576    00
> 
> Output from the NFS Client when the issue occurs
> # netstat -an | grep NFS.Server.IP.X
> tcp        0      0 NFS.Client.IP.X:46896     
> NFS.Server.IP.X:2049       FIN_WAIT2
> 

Your client has closed the connection, and is waiting for the server to
close the connection on its side.

I'd suggest using a newer kernel, or else getting someone in the Debian
project to fix theirs.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



