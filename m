Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5036E7D69
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjDSOsd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjDSOsc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 10:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD710D7
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681915658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juPkIRr91NTlW8Cr+XXthauwNuW2+Q8oOkMlqJZ7njs=;
        b=V7XTiR1ciNrFOX5xHQz5OdpRiQ/rgFOGYHIDTy1yi9eOSwK49erZnT/gJ3bByHRKLPtwzf
        eOKkdaKvSb2XIt7Q5CGP/xcFkfAsiHTk6f29Sv0i+1Otbxk/Qijm/pQUlWp3REFJDdwT3e
        wViYYDXhZU4K5f/4KU13Bds/oD4KhFk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-av9AdbQ8PCGtk1kBFX5SHQ-1; Wed, 19 Apr 2023 10:47:37 -0400
X-MC-Unique: av9AdbQ8PCGtk1kBFX5SHQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5ef5fbe2cfaso9027796d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 07:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915657; x=1684507657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juPkIRr91NTlW8Cr+XXthauwNuW2+Q8oOkMlqJZ7njs=;
        b=WbknGVwtG2GIDGJaB0dZYnTiTjH7x6cvYwFdod6d6zKSiKtXxMobNnhpdqxJaIHM0/
         nfhaO7O2uKjbKewNnv9uhMFHE1913Y/tZX1NQI+xONyT6cITn69vVJpex3VBSMgPyn7Y
         hOb2JUkqr5m/mQJp5FoibVpGgDWv8aKIstI2IaTEywWXFK23bPI2ufQ6AszJSUpvjOkT
         EKFUVhRQSZollpBOCm0m0GFbZYi+3gggpYlQWJ6Z0UIxcZxBvyVU0lYo0zkFiFMZrkTS
         io29j8cJD2Kb7tZzfoHFIl6oGhn/joetgbQXFayiAOFIgxMQ9gzL3jh5vTEoFQFHZr7D
         /P6g==
X-Gm-Message-State: AAQBX9ewBBgzUJBfZAeYpLGavISdG70RmsbbvUs8PzASHI9Wlfh3PFuJ
        PUFD3c8ZoC9WC11av3fjx8JcyZY8DHUQzgdVq8sy+x3ICpJmDh5f84Z5lhjhPn8/x7H1X0Ugp1j
        ZcK8HFOwnfKQa1uvCY17S
X-Received: by 2002:a05:6214:4114:b0:5a9:ab44:5fdf with SMTP id kc20-20020a056214411400b005a9ab445fdfmr26937954qvb.0.1681915657044;
        Wed, 19 Apr 2023 07:47:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350aWrfMb/Qe2XuME6a5Xe5oV21rFrAQOmpNhYkoilQ5waXB/6i9P8St3WnugHzqVJw9KArxx3Q==
X-Received: by 2002:a05:6214:4114:b0:5a9:ab44:5fdf with SMTP id kc20-20020a056214411400b005a9ab445fdfmr26937927qvb.0.1681915656774;
        Wed, 19 Apr 2023 07:47:36 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.248.80])
        by smtp.gmail.com with ESMTPSA id lu8-20020a0562145a0800b005eab96abc9esm4351624qvb.140.2023.04.19.07.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 07:47:36 -0700 (PDT)
Message-ID: <5252edc8-bf6e-a448-4887-e38c473eae97@redhat.com>
Date:   Wed, 19 Apr 2023 10:47:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/8 v3] nfs-utils: Improving NFS re-export wrt. crossmnt
To:     Richard Weinberger <richard@nod.at>, linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chris.chilvers@appsbroker.com
References: <20230418093350.4550-1-richard@nod.at>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230418093350.4550-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/18/23 5:33 AM, Richard Weinberger wrote:
> After a longer hiatus I'm sending the next iteration of my re-export
> improvement patch series. While the kernel side is upstream since v6.2,
> the nfs-utils parts are still missing.
> This patch series aims to solve this.
> 
> The core idea is adding new export option, reeport=
> Using reexport= it is possible to mark an export entry in the exports
> file explicitly as NFS re-export and select a strategy on how unique
> identifiers should be provided. This makes the crossmnt feature work
> in the re-export case.
> Currently two strategies are supported, "auto-fsidnum" and
> "predefined-fsidnum".
> 
> In my earlier series a sqlite database was mandatory to keep track of
> generated fsids.
> This series follows a different approach, instead of directly using
> sqlite in all nfs-utils components (linking libsqlite), a new deamon
> manages the database, fsidd.
> fsidd offers a simple (but stupid?) text based interface over a unix domain
> socket which can be queried by mountd, exportfs, etc. for fsidnums.
> The main idea behind fsidd is allowing users to implement their own
> fsidd which keeps global state across load balancers.
> I'm still not happy with fsidd, there is room for improvement but first
> I'd like to know whether you like or hate this approach.
> 
> A typical export entry on a re-exporting server looks like:
>          /nfs *(rw,no_root_squash,no_subtree_check,crossmnt,reexport=auto-fsidnum)
> reexport=auto-fsidnum will automatically assign an fsid= to /nfs and all
> uncovered subvolumes.
> 
> Changes since v2, https://lore.kernel.org/linux-nfs/20230404111308.23465-1-richard@nod.at/
> 	- Split patch series
> 	- Add improved fsidd system unit file
> 	- Rebased to nfs-utils master as of today
> 	- Dropped init code from exportd
> 
> Changes since v1, https://lore.kernel.org/linux-nfs/20220502085045.13038-1-richard@nod.at/
>          - Factor out Sqlite and put it into a daemon
>          - Add fsidd
>          - Basically re-implemented the patch series
>          - Lot's of fixes (e.g. nfs v4 root export)
> 
> 
> Richard Weinberger (8):
>    Add reexport helper library
>    Implement reexport= export option
>    export: Wireup reexport mechanism
>    export: Uncover NFS subvolume after reboot
>    exports.man: Document reexport= option
>    reexport: Add sqlite backend
>    export: Add fsidd
>    Add fsid systemd service file
> 
>   configure.ac                        |   1 +
>   support/Makefile.am                 |   2 +-
>   support/export/Makefile.am          |   2 +
>   support/export/cache.c              |  74 ++++++-
>   support/export/export.c             |  20 ++
>   support/include/nfslib.h            |   1 +
>   support/nfs/Makefile.am             |   1 +
>   support/nfs/exports.c               |  62 ++++++
>   support/reexport/Makefile.am        |  18 ++
>   support/reexport/backend_sqlite.c   | 267 +++++++++++++++++++++++
>   support/reexport/fsidd.c            | 198 +++++++++++++++++
>   support/reexport/reexport.c         | 326 ++++++++++++++++++++++++++++
>   support/reexport/reexport.h         |  18 ++
>   support/reexport/reexport_backend.h |  47 ++++
>   systemd/Makefile.am                 |   5 +-
>   systemd/fsidd.service               |  10 +
>   utils/exportd/Makefile.am           |   4 +-
>   utils/exportfs/Makefile.am          |   3 +
>   utils/exportfs/exportfs.c           |  11 +
>   utils/exportfs/exports.man          |  31 +++
>   utils/mount/Makefile.am             |   3 +-
>   utils/mountd/Makefile.am            |   2 +
>   22 files changed, 1096 insertions(+), 10 deletions(-)
>   create mode 100644 support/reexport/Makefile.am
>   create mode 100644 support/reexport/backend_sqlite.c
>   create mode 100644 support/reexport/fsidd.c
>   create mode 100644 support/reexport/reexport.c
>   create mode 100644 support/reexport/reexport.h
>   create mode 100644 support/reexport/reexport_backend.h
>   create mode 100644 systemd/fsidd.service
> 
Committed... (tag: nfs-utils-2-6-3-rc9)

Thank you!

steved.

