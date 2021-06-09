Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF43A174B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhFIOds (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 10:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235435AbhFIOdr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 10:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623249112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHuG7E95MyKXVux4DDaQuTDADWW8PX7v3iVWe19V4UA=;
        b=RaL3xgEy7iAY2b5StWG72wAC+qHg5vre1XSMjIu314Bc+uLF1jXgyCMMPuQVLq4yZhYsi6
        UuGO5Bpp3m1OjvgvIaUf74TGap+bY5gm/CF4sE7zFBzl1FjXcKfPMif/GiOo9J2p9+PmdA
        g0mAYRmVuQOnBOaEuN6rUFqNxTrqAEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-D-uen-vpOtGPt2XdlGFfZA-1; Wed, 09 Jun 2021 10:31:38 -0400
X-MC-Unique: D-uen-vpOtGPt2XdlGFfZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29CBE9F92C;
        Wed,  9 Jun 2021 14:31:37 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6332B9CA0;
        Wed,  9 Jun 2021 14:31:36 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Michael Wakabayashi" <mwakabayashi@vmware.com>
Cc:     "Olga Kornievskaia" <aglo@umich.edu>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        linux-nfs@vger.kernel.org, SteveD@redhat.com
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Date:   Wed, 09 Jun 2021 10:31:34 -0400
Message-ID: <FCDAEE4A-33CB-4939-8001-DAAFD7BC8638@redhat.com>
In-Reply-To: <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
 <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
 <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
 <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
 <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Jun 2021, at 1:31, Michael Wakabayashi wrote:

> Hi Olga,
>
> There seems to be a discrepancy between what you're seeing and what 
> we're seeing.
>
> So we were wondering if you can you please run these commands in your 
> Linux environment and paste the output of the mount command below?
>     $ sudo mkdir -p /tmp/mnt.dead
>     $ time sudo mount -o vers=4 -vvv 2.2.2.2:/fake_path /tmp/mnt.dead
>
> We'd like the mount command to specifically use "2.2.2.2:/fake_path" 
> since we know it is unreachable and outside your subnet.
> We're hoping by mounting "2.2.2.2:/fake_path" you'll be able to 
> reproduce the same behavior that we're seeing.
>
> Also, if possible, a packet trace would be helpful:
>     $ sudo tcpdump -s 0 -w /tmp/nfsv4.pcap port 2049
>
> On my Ubuntu VirtualMachine, I see this output:
>     ubuntu@mikes-ubuntu-21-04:~$ time sudo mount -o vers=4 -vvv 
> 2.2.2.2:/fake_path /tmp/mnt.dead
>     mount.nfs: timeout set for Wed Jun  9 05:12:15 2021
>     mount.nfs: trying text-based options 
> 'vers=4,addr=2.2.2.2,clientaddr=10.162.132.231'
>     mount.nfs: mount(2): Connection timed out
>     mount.nfs: Connection timed out
>     real  3m1.257s
>     user  0m0.006s
>     sys 0m0.007s
>
> Thanks, Mike

It looks to me like you and Olga are seeing the same thing, a wait 
through SYN retries scaling up from initial RTO for the number of 
tcp_syn_retries.

It's not disputed that mounts waiting on the transport layer will block 
other mounts.

It might be able to be changed:  there's this torch:
https://lore.kernel.org/linux-nfs/87378omld4.fsf@notabene.neil.brown.name/

..or there may be another way we don't have to wait ..

.. or tune tcp_syn_retries.. or RTO.. or something else (eBPF?).

I think we're all strapped for time and problems like this usually get 
fixed by the folks feeling the most pain from them.

Ben

