Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE402331D9C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 04:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCIDdT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 8 Mar 2021 22:33:19 -0500
Received: from us-smtp-delivery-145.mimecast.com ([216.205.24.145]:21718 "EHLO
        us-smtp-delivery-145.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhCIDcx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 22:32:53 -0500
Received: from zmcc-3-mta-2.zmailcloud.com (zmcc-3-mta-2.zmailcloud.com
 [35.238.170.66]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-R9WV8VA3MB-XVk-U5d5t-Q-1; Mon, 08 Mar 2021 22:32:50 -0500
X-MC-Unique: R9WV8VA3MB-XVk-U5d5t-Q-1
Received: from zmcc-3-mta-2.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTPS id 4D610E2A79;
        Mon,  8 Mar 2021 21:32:50 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTP id 3E7DEE2A78;
        Mon,  8 Mar 2021 21:32:50 -0600 (CST)
X-Virus-Scanned: amavisd-new at zmcc-3-mta-2.zmailcloud.com
Received: from zmcc-3-mta-2.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-2.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xj9sBY9F8kO5; Mon,  8 Mar 2021 21:32:50 -0600 (CST)
Received: from jbreitman-mac.zxcvm.com (unknown [72.22.182.150])
        by zmcc-3-mta-2.zmailcloud.com (Postfix) with ESMTPSA id 0926CE2A62;
        Mon,  8 Mar 2021 21:32:50 -0600 (CST)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: NFS Mount Hangs
From:   Jason Breitman <jbreitman@tildenparkcapital.com>
In-Reply-To: <4ec6d34eb753bd2ba11886cdffbad1f25f4b6e78.camel@hammerspace.com>
Date:   Mon, 8 Mar 2021 22:32:49 -0500
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-Id: <94F7249D-20B1-437F-B383-D142B638DFAE@tildenparkcapital.com>
References: <C643BB9C-6B61-4DAC-8CF9-CE04EA7292D0@tildenparkcapital.com>
 <5E3B228F-5CFC-4EDF-B52E-1CDB947ADC00@tildenparkcapital.com>
 <2b13577bb30faf3b475d2d602be57aa135023a53.camel@hammerspace.com>
 <15CD7763-6DE5-4DBA-8FAE-859964AA90AC@tildenparkcapital.com>
 <4ec6d34eb753bd2ba11886cdffbad1f25f4b6e78.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA45A274 smtp.mailfrom=jbreitman@tildenparkcapital.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: tildenparkcapital.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The server is running FreeBSD 12.1-RELEASE-p5.

Jason Breitman

On Mar 8, 2021, at 8:52 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:

On Mon, 2021-03-08 at 17:22 -0500, Jason Breitman wrote:
> Thank you.
> Do you know which kernel version is fixed?
> If not, is there something I can look for in the source code that
> will indicate that the kernel is fixed.
> 

As I said, the problem here is that the server doesn't seem to be
closing the socket when the client does. You didn't actually tell us
which server you are using, so I don't know how to answer that
question.


> Jason Breitman
> 
> 
> On Mar 8, 2021, at 5:15 PM, Trond Myklebust <trondmy@hammerspace.com>
> wrote:
> 
> On Mon, 2021-03-08 at 13:16 -0500, Jason Breitman wrote:
> > Issue
> > NFSv4 mounts periodically hang on the NFS Client.
> > 
> > During this time, it is possible to manually mount from another NFS
> > Server on the NFS Client having issues.
> > Also, other NFS Clients are successfully mounting from the NFS
> > Server
> > in question.
> > Rebooting the NFS Client appears to be the only solution.
> > 
> > I believe this issue has been discussed in the past so I included
> > an
> > article that matched my symptoms.
> > I do not see a case statement for FIN_WAIT2 at
> > https://elixir.bootlin.com/linux/v4.19.171/source/net/sunrpc/xprtsock.c
> > .
> > 
> > NFS Client
> > OS:             Debian Buster 10.8
> > Kernel: 4.19.171-2
> > Protocol:       NFSv4 with Kerberos Security
> > Mount Options:  nfs-
> > server.domain.com:/data     /mnt/data       nfs4   
> > lookupcache=pos,n
> > oresvport,sec=krb5,hard,rsize=1048576,wsize=1048576    00
> > 
> > Output from the NFS Client when the issue occurs
> > # netstat -an | grep NFS.Server.IP.X
> > tcp        0      0 NFS.Client.IP.X:46896     
> > NFS.Server.IP.X:2049       FIN_WAIT2
> > 
> 
> Your client has closed the connection, and is waiting for the server
> to
> close the connection on its side.
> 
> I'd suggest using a newer kernel, or else getting someone in the
> Debian
> project to fix theirs.
> 

-- 
Trond Myklebust
CTO, Hammerspace Inc
4984 El Camino Real, Suite 208
Los Altos, CA 94022
​
www.hammer.space


