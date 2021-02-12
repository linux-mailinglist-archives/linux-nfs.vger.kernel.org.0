Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED8319D99
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 12:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBLLvi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 06:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhBLLvf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 06:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613130608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MRe9D2DvN9CRahuGfAz+865YI1MdnzxfHymN+Tpznf8=;
        b=KmXr8KSl6N8Frxa+k9YLZsxpPGR0tjQetc+y5BTsDYFEq1voFS1Kqfiz+uetzU0ckqlABV
        29WLeWkXaMY/Dv7MCHRaZT1yStghJIdBV0ivs1CT3bJR+XeK9UDciLjUNxsbAKb2OMoOss
        iCIH4iQqWKjWgQ+2zN4vKQEcsTph0Co=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-zRyjoQYONBSK62nc69tL4Q-1; Fri, 12 Feb 2021 06:50:06 -0500
X-MC-Unique: zRyjoQYONBSK62nc69tL4Q-1
Received: by mail-io1-f69.google.com with SMTP id o4so1482328ioh.14
        for <linux-nfs@vger.kernel.org>; Fri, 12 Feb 2021 03:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MRe9D2DvN9CRahuGfAz+865YI1MdnzxfHymN+Tpznf8=;
        b=tPceFY95AODLsrGQdzhG+ZpJr8etL1GCbJq/PmYSC698KRTr3qrlt/rfxxgaR8yCdP
         4VBOyLzpioukXfnZcQzb7jnwg3VtTn2aEMZzp6d4Nl4i8PDXcGH9B7adZ9l1UUSut3XN
         ZAbfVtF92FNrLwaJoukCePb2b47/2Jb/LMuCGXj8gdjxnZ6mSCN/tekf+AR3geRMdrL2
         NYKHULx30SzJ042jmJLzEVlLXptXUoeoSuaH1aCMUoIXOgSLBDUJf6AMT2LRAWmaahb2
         FK8VYjRV2KZEW30zYjgALHr5xdTJeb9/HR81Z76AwRnsDsYIndaWdZ54esW+VYnF+Ih+
         wPlg==
X-Gm-Message-State: AOAM531Stjng8S9xGQ+a7LWNlifPZfiiH54aUBfN4SPMwvMTT6wgPk24
        G0YY0Q5SdKBRASb041A7kBjrCz/Ld4tMlveqkSac3v6BZDJ07DXaG/X89UDBsVIjl1oDfkVOPuk
        mSl0mceOLbV6/vqB5gdHA4zSIZ9zLnlTXUVlx
X-Received: by 2002:a05:6638:152:: with SMTP id y18mr2317455jao.16.1613130605978;
        Fri, 12 Feb 2021 03:50:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhkfD85o8mnLM+99mc1sUuTTUPCH80XtUAtzKM0DdTWJ6iXmvfxZthV1huqYCCU/ZdEw2j9bQExJS+owq1zlI=
X-Received: by 2002:a05:6638:152:: with SMTP id y18mr2317434jao.16.1613130605648;
 Fri, 12 Feb 2021 03:50:05 -0800 (PST)
MIME-Version: 1.0
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Fri, 12 Feb 2021 12:49:54 +0100
Message-ID: <CACWnjLw2H7Ev6Tz_c=1AHDCxCGW5NZ_wzy6oHVMFD+GjJDjV2g@mail.gmail.com>
Subject: about nfs_wait_client_init_complete/concurrent mounts
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi All,

 Sorry for wide distribution, but i think it might be an interesting topic.

  There's this issue with concurrent mounts.nfs commands (NFS4.1) to
different NFS servers where if one or some of
servers are unreachable i.e a firewall blocks NFS server, other mounts
may wait on one of the consumers of
nfs_wait_client_init_complete : nfs_match_client, nfs4_match_client,
nfs41_discover_server_trunking...
since we need to check if we can reuse a client or not. Typically we
wait on nfs_match_client until client is marked
NFS_CS_READY or timeout.

  This happens even if mount requests are for different servers, IP,
NFS version etc...
depending on timing, a mount to a reachable server might wait for
other broken mount
to timeout. I tested on kernels 4.18 and 5.8.

 A more impacting version of this is i.e a rather big autofs map
contain some broken mounts that got triggered
from time to time, as a result other mounts i.e. users mounting remote
home were affected and can cause
user impact, delays etc...

  Of course once broken mounts are removed, issue is fixed but I was
wondering if there's a way on NFS client to skip
reusing some clients a priori without them to be necessary NFS_CS_READY.

  While doing some local patch testing to skip some candidates with
client-side information i could see we still get
a problem with trunking. As far as i could see, with trunking we need
a dialog with
NFS server to get session information in order to decide if we can
discard a client or reuse it, so we need to wait for that
to happen or timeout. That's my understanding of code, i can be wrong of course.

   If my premises are true, *looks* to me pretty hard to optimize the
"concurrent mounts with
broken servers" scenario with trunking "in the game" without some
major and careful change.

  What are your thoughts about the problem described above ? Any way
to optimize the above scenario where
some mount operation might wait for other broken mounts that have
nothing to do it ? Maybe some on-going
change on this topic ? (i did not found any)

rgds
roberto

