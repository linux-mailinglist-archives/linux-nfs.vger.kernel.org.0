Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4432B752
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbhCCK6E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:58:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349564AbhCBWe1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 17:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614724312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9qpvanEXquHxvS03LpEsxCAgPSPROkSDHj6p+/2Ct8=;
        b=F+PUAl56DbuC9VHArDpNLUTbh72tcu0x3ddFZ4QMX/Zmp5IdKedwBJF+9T7EFgBfKwk6o8
        B3VZR1qpedXcHQirerG7WQhtUYqFjgVlrlxGNNJ6bsbxe+Veqrrm3nVderhwWf3906VzxD
        o3ddMg49O4Tr5R/BLsIfangEnTSe6J0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-XobSyJG6OJC_gvSOCDnlOQ-1; Tue, 02 Mar 2021 17:31:38 -0500
X-MC-Unique: XobSyJG6OJC_gvSOCDnlOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57DEDC2A6;
        Tue,  2 Mar 2021 22:31:37 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE95162690;
        Tue,  2 Mar 2021 22:31:36 +0000 (UTC)
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
Date:   Tue, 2 Mar 2021 17:33:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210224203053.GF11591@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/24/21 3:30 PM, J. Bruce Fields wrote:
> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
>> The idea is to allow distros to build a v4 only package
>> which will have a much smaller footprint than the
>> entire nfs-utils package.
>>
>> exportd uses no RPC code, which means none of the 
>> code or arguments that deal with v3 was ported, 
>> this again, makes the footprint much smaller. 
> 
> How much smaller?
Will a bit smaller... but a number of daemons like nfsd[cld,clddb,cldnts]
need to also come a long. 
> 
>> The following options were ported:
>>     * multiple threads
>>     * state-directory-path option
>>     * junction support (not tested)
>>
>> The rest of the mountd options were v3 only options.
> 
> There's also --manage-gids.
Right... a patch was posted... 

> 
> If you want nfsv4-only at runtime, you can always run rpc.mountd with
> -N2 -N3 to turn off the MOUNT protocol support.
The end game is not to run mountd at all... 

> 
> If you don't even want v2/f3 code on your system, then you may have to
> do something like this, but why is that important?
Container friendly... Not bring in all the extra daemons v3
needs is a good thing... esp rpcbind. 

steved.

> 
> --b.
> 
>>
>> V2:
>>   * Added two systemd services: nfsv4-exportd and nfsv4-server
>>   * nfsv4-server starts rpc.nfsd -N 3, so nfs.conf mod not needed.
>>
>> V3: Changed the name from exportd to nfsv4.exportd
>>
>> V4: Added compile flag that will compile in the NFSv4 only server
>>
>> Steve Dickson (7):
>>   exportd: the initial shell of the v4 export support
>>   exportd: Moved cache upcalls routines into libexport.a
>>   exportd: multiple threads
>>   exportd/exportfs: Add the state-directory-path option
>>   exportd: Enabled junction support
>>   exportd: systemd unit files
>>   exportd: Added config variable to compile in the NFSv4 only server.
>>
>>  .gitignore                                |   1 +
>>  configure.ac                              |  14 ++
>>  nfs.conf                                  |   4 +
>>  support/export/Makefile.am                |   3 +-
>>  {utils/mountd => support/export}/auth.c   |   4 +-
>>  {utils/mountd => support/export}/cache.c  |  46 +++-
>>  support/export/export.h                   |  34 +++
>>  {utils/mountd => support/export}/fsloc.c  |   0
>>  {utils/mountd => support/export}/v4root.c |   0
>>  {utils/mountd => support/include}/fsloc.h |   0
>>  systemd/Makefile.am                       |   6 +
>>  systemd/nfs.conf.man                      |  10 +
>>  systemd/nfsv4-exportd.service             |  12 +
>>  systemd/nfsv4-server.service              |  31 +++
>>  utils/Makefile.am                         |   4 +
>>  utils/exportd/Makefile.am                 |  65 +++++
>>  utils/exportd/exportd.c                   | 276 ++++++++++++++++++++++
>>  utils/exportd/exportd.man                 |  81 +++++++
>>  utils/exportfs/exportfs.c                 |  21 +-
>>  utils/exportfs/exportfs.man               |   7 +-
>>  utils/mountd/Makefile.am                  |   5 +-
>>  21 files changed, 606 insertions(+), 18 deletions(-)
>>  rename {utils/mountd => support/export}/auth.c (99%)
>>  rename {utils/mountd => support/export}/cache.c (98%)
>>  create mode 100644 support/export/export.h
>>  rename {utils/mountd => support/export}/fsloc.c (100%)
>>  rename {utils/mountd => support/export}/v4root.c (100%)
>>  rename {utils/mountd => support/include}/fsloc.h (100%)
>>  create mode 100644 systemd/nfsv4-exportd.service
>>  create mode 100644 systemd/nfsv4-server.service
>>  create mode 100644 utils/exportd/Makefile.am
>>  create mode 100644 utils/exportd/exportd.c
>>  create mode 100644 utils/exportd/exportd.man
>>
>> -- 
>> 2.29.2
> 

