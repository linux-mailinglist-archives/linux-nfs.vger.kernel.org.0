Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D528CFC6
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Oct 2020 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgJMOEw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Oct 2020 10:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgJMOEw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Oct 2020 10:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602597890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wumQZIpN5hAuQeftAMThyDAcRGaSlO2INM6i5MXuFFw=;
        b=gv7fmtaTXaivITJ4tGufXNHblX4a4GBibjgw/Li0QKLo6bNyaFdBEAycibKRnZIoPCwkoc
        2y+mvQPwIiHBRAILn2JrAR9JHY5yhaoLsZLdijLcSIS4CFsCWbipwb3pLXyMP7qfN0w9CK
        aoi7F7r1QOqOAvOWhjyU2Rq1nbxkCvM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-W6qOqfy5PK2gDLn-yAuGdQ-1; Tue, 13 Oct 2020 10:04:48 -0400
X-MC-Unique: W6qOqfy5PK2gDLn-yAuGdQ-1
Received: by mail-wm1-f69.google.com with SMTP id 73so18985wma.5
        for <linux-nfs@vger.kernel.org>; Tue, 13 Oct 2020 07:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wumQZIpN5hAuQeftAMThyDAcRGaSlO2INM6i5MXuFFw=;
        b=JYSTwoOnAJV/upB4hvh5CZRBVvuRgsKrrOlCHJWVqnx4fhkxhGtmpu7ZN96fL3IvP6
         gXzm9j91XzShVidDRpaxEVS1wXOOboaEdF2VC7jcPvoa6bF+++kqxqqjrw3PVoCt82Oc
         tqsGN9xI1zNGAt/jJVCvwRD3aKKJiySTPfiLk74/QEZp3blPxcigMXZV0yOigQy0MbBI
         JxujT6vQnruNG3khc8lDBRhE3Zluyz3F979QGXOHiE1hHCinRileglj7RfCvjhI8fMyF
         YEyTUv0MU0Z6IlLaULWhcyQ+P9mMdPJFPH4pPUPRLPB8/AHN/B8mT/zYZ3ZeX0jOwWZh
         cFBg==
X-Gm-Message-State: AOAM530EiA3InEUXK3Wdahqkh++hOZ56yWSYODeb+jFotgngr0dcFLPy
        YnYmcdVIJhG5NevE6I/ppkM5Trg0LwjUBro0v/ASmbKPKSvqI83UmCn3GEgPiwv3zXf4dSCsSKD
        mMXsgmYwLffDC+AAWKFD3
X-Received: by 2002:a05:6000:8e:: with SMTP id m14mr35979282wrx.400.1602597885924;
        Tue, 13 Oct 2020 07:04:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5uwKCr+UiD6vszmHekVHuOE1ZVC4d5BVr7UgYtmusqMCItr9TN/hATWiAiwn9FTcLdocqOQ==
X-Received: by 2002:a05:6000:8e:: with SMTP id m14mr35979249wrx.400.1602597885656;
        Tue, 13 Oct 2020 07:04:45 -0700 (PDT)
Received: from [192.168.68.106] ([77.137.152.100])
        by smtp.gmail.com with ESMTPSA id f14sm19283wme.22.2020.10.13.07.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 07:04:44 -0700 (PDT)
Subject: Re: Help with config change for CIFS
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
References: <200195397.3817648.1602575184327.JavaMail.zimbra@redhat.com>
Cc:     Red Hat INTERNAL-ONLY kernel discussion list 
        <rhkernel-list@redhat.com>, linux-nfs <linux-nfs@vger.kernel.org>
From:   Kamal Heib <kheib@redhat.com>
Message-ID: <7b087315-7140-e988-c2d4-d3fd9077247e@redhat.com>
Date:   Tue, 13 Oct 2020 17:04:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <200195397.3817648.1602575184327.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/13/20 10:46 AM, Ronnie Sahlberg wrote:
> Hi List,
> 
> I have some issues with a config change can not find what else I need to do to fix this.
> 
> I tried to enable RDMA support in the cifs client, by simply doing :
> diff --git a/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT b/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
> index 849bffb38ecd..88e746ddab11 100644
> --- a/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
> +++ b/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
> @@ -1 +1 @@
> -# CONFIG_CIFS_SMB_DIRECT is not set
> +CONFIG_CIFS_SMB_DIRECT=y
> 
> 
> But this fails with the brew build with:
> Depmod failure
> + '[' -s depmod.out ']'
> + echo 'Depmod failure'
> + cat depmod.out
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_free_cq_user
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol __ib_alloc_pd
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_resolve_addr
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_dereg_mr_user
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_event_msg
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_disconnect
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_alloc_mr_user
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_resolve_route
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_create_qp
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_map_mr_sg
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol __ib_alloc_cq_any
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_destroy_qp
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_connect
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_destroy_id
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol __rdma_create_id
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_drain_qp
> depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_dealloc_pd_user
> + exit 1
> RPM build errors:
> 
> These symbols should be available already in the infiniband module, so I am a little at loss.
> Does anyone know what else I need to chang eto get this config change to compile in brew?
> 
> regards
> ronnie sahlberg
> 


Hi Ronnie,

Looks like you need to add "cifs" directory to the fs filtered directories under
"redhat/filter-modules.sh" script to let the cifs.ko know about the rdma symbols.

I have created [1] brew build with the following patch and looks like the issue
is gone.

commit aab32aec9fff2e0acd31885b7f696a582e7df42f
Author: Kamal Heib <kheib@redhat.com>
Date:   Tue Oct 13 10:59:24 2020 +0300

    redhat/configs: Update CONFIG_CIFS_SMB_DIRECT

    Upstream Status: RHEL only.

    Update redhat/configs for CONFIG_CIFS_SMB_DIRECT.

    Autogenerated & verified by editconfig.

diff --git a/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
b/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
index 849bffb38ecd..88e746ddab11 100644
--- a/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
+++ b/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
@@ -1 +1 @@
-# CONFIG_CIFS_SMB_DIRECT is not set
+CONFIG_CIFS_SMB_DIRECT=y
diff --git a/redhat/filter-modules.sh b/redhat/filter-modules.sh
index 66ff2ec80060..48cc8df145b6 100755
--- a/redhat/filter-modules.sh
+++ b/redhat/filter-modules.sh
@@ -28,7 +28,7 @@ scsidrvs="aacraid aic7xxx aic94xx be2iscsi bfa bnx2i bnx2fc
csiostor cxgbi esas2

 usbdrvs="atm image misc serial wusbcore"

-fsdrvs="affs befs coda cramfs ecryptfs hfs hfsplus jfs minix ncpfs nilfs2 ocfs2
reiserfs romfs squashfs sysv ubifs ufs"
+fsdrvs="affs befs coda cramfs ecryptfs hfs hfsplus jfs minix ncpfs nilfs2 ocfs2
reiserfs romfs squashfs sysv ubifs ufs cifs"

 netprots="6lowpan appletalk atm ax25 batman-adv bluetooth can dccp dsa
ieee802154 irda l2tp mac80211 mac802154 mpls netrom nfc rds rfkill rose sctp smc
wireless"


[1] - https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=31931687

Thanks,
Kamal

