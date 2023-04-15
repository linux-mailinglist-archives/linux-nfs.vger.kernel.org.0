Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58C6E3310
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDOSMi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDOSMi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 14:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D47D3ABC
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681582313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nqnJLhKAgaGlF47SHqaR0Iva/0J4xviAc/5kpOd/jY=;
        b=DlcCG+oZJSML9Ub/CX6gA4JAY1vmvTO7GqKMmtLTAKp3bjHpOJJRVxCkUHI3s9IcgnvIQq
        TAyF4ya3+zF7DY0LuXEnPfi7rjbkIXE216icDRtHbaA+msZQJP+2kLjyzzelX2QWrwJc9l
        NAiMojll5GTpyBQs0UAcUtVmuhrZqLM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-CNQMlK4QOtaTk1QGbc97Ug-1; Sat, 15 Apr 2023 14:11:52 -0400
X-MC-Unique: CNQMlK4QOtaTk1QGbc97Ug-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74acb477be6so40004985a.1
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 11:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681582311; x=1684174311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nqnJLhKAgaGlF47SHqaR0Iva/0J4xviAc/5kpOd/jY=;
        b=A8Mdeql5a4Zd+MrUQswtvJyg8AeNLu1v91qakBnlhSxBjWJ95avCuG/g+pa2LaCtqh
         Di/aXkUiL34ILJztZyTyNfD3nHAAUzOFRkk15z+R5BZn86y83dR5C0QlhZ7YmyVsz+mk
         Z0TfhX3hvCSFfHq0zSYxXdJKgzRDq8U7+W6mVutUOR6KORzBC9EwwnWf2QocIuK2pcLn
         LE0ux7/6VWGKmf6T6uGRENN925NizajiOIgncbPVIoKdA03jPaMS6GZWqb6n1I9JdbnH
         R+a3hq/kLnbsuZlIJ2KqzYTSVQslEe7AelFSUQi5+4O+PlmWnooJqZssTKFymoiTPcTf
         1C6Q==
X-Gm-Message-State: AAQBX9djIR9jVIDN3K/sK9VILNfN1VnnzhZ12FRQBD47mj82qVSv+1kP
        MXeeCe4gIurnwf5VqTm/XvPuQK4Cl+Zmod1DgHbhirdjrj1WWU318ZehJ32VVwcDl9YaOvjNLz7
        c61CdrhG91Ce+3oytaT+C
X-Received: by 2002:a05:6214:5298:b0:5df:55b5:b1a with SMTP id kj24-20020a056214529800b005df55b50b1amr9128092qvb.4.1681582311661;
        Sat, 15 Apr 2023 11:11:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350YKDAbXZG+dBQEelcffq6jSIgeWgFqh8LU87tMJUacPajxkGgAu4GZxqOr86zaGSEJT5gSbww==
X-Received: by 2002:a05:6214:5298:b0:5df:55b5:b1a with SMTP id kj24-20020a056214529800b005df55b50b1amr9128069qvb.4.1681582311352;
        Sat, 15 Apr 2023 11:11:51 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.80])
        by smtp.gmail.com with ESMTPSA id nw1-20020a0562143a0100b005eec576e4d2sm1906281qvb.87.2023.04.15.11.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 11:11:50 -0700 (PDT)
Message-ID: <c43a2268-3a12-2eeb-9cb2-6b01f5a225ef@redhat.com>
Date:   Sat, 15 Apr 2023 14:11:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2 v2 RESEND] nfs-utils: Improving NFS re-export wrt.
 crossmnt
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>, linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chris.chilvers@appsbroker.com
References: <20230404111308.23465-1-richard@nod.at>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230404111308.23465-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/4/23 7:13 AM, Richard Weinberger wrote:
> [Resending this series because I got to git add two header files.]
My apologies for taking so long to get to this!
And Thank you for this work... But there is a
few issues ;-)
> 
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
>      	/nfs *(rw,no_root_squash,no_subtree_check,crossmnt,reexport=auto-fsidnum)
> reexport=auto-fsidnum will automatically assign an fsid= to /nfs and all
> uncovered subvolumes.
> 
> Changes since v1, https://lore.kernel.org/linux-nfs/20220502085045.13038-1-richard@nod.at/
> 	- Factor out Sqlite and put it into a daemon
> 	- Add fsidd
> 	- Basically re-implemented the patch series
> 	- Lot's of fixes (e.g. nfs v4 root export)
> 
> 
> Richard Weinberger (2):
>    export: Add reexport= option
>    Implement fsidd
> 
>   configure.ac                        |   1 +
>   support/Makefile.am                 |   2 +-
>   support/export/Makefile.am          |   2 +
>   support/export/cache.c              |  74 ++++++-
>   support/export/export.c             |  27 ++-
>   support/include/nfslib.h            |   1 +
>   support/nfs/Makefile.am             |   1 +
>   support/nfs/exports.c               |  62 ++++++
>   support/reexport/Makefile.am        |  18 ++
>   support/reexport/backend_sqlite.c   | 267 +++++++++++++++++++++++
>   support/reexport/fsidd.c            | 198 +++++++++++++++++
>   support/reexport/reexport.c         | 327 ++++++++++++++++++++++++++++
>   support/reexport/reexport.h         |  18 ++
>   support/reexport/reexport_backend.h |  47 ++++
>   systemd/Makefile.am                 |   2 +
>   systemd/fsidd.service               |   9 +
>   utils/exportd/Makefile.am           |   6 +-
>   utils/exportd/exportd.c             |   5 +
>   utils/exportfs/Makefile.am          |   3 +
>   utils/exportfs/exportfs.c           |  11 +
>   utils/exportfs/exports.man          |  31 +++
>   utils/mount/Makefile.am             |   3 +-
>   utils/mountd/Makefile.am            |   2 +
>   23 files changed, 1106 insertions(+), 11 deletions(-)
>   create mode 100644 support/reexport/Makefile.am
>   create mode 100644 support/reexport/backend_sqlite.c
>   create mode 100644 support/reexport/fsidd.c
>   create mode 100644 support/reexport/reexport.c
>   create mode 100644 support/reexport/reexport.h
>   create mode 100644 support/reexport/reexport_backend.h
>   create mode 100644 systemd/fsidd.service
> 
These patch does not apply cleanly on Chuck's TLS patches,
not something you could have voided and the fix
is minor...  But!

Then the first patch does not compile without
the second patch due to a missing header file.

When the second patch is applied the compile
breaks in exportd code:
    make[2]: *** No rule to make target 
'../support/reexport/libreexport.a', needed by 'exportd'.  Stop.

The first patch is way to big for debugging and reading... IMO.

Maybe the exportd, exportfs, and mount changes be put
in their own patches and maybe the reexport command
can be separated out from the rest of support/ changes
although that might be more difficult.

Not clear how you can break up the second patch other
than moving reexport_backend.h into the first patch
so it compiles...

I just committed Chuck's TLS patch (tag: nfs-utils-2-6-3-rc8)
So if you could rebase your patches to the head of my repo
that would great, with the above changes.

I'll be very motivate get these changes in for the
upcoming virtual bakeathon starting a week from
Monday (Apr 24). The detail are here [1]...

I'm hopeful you will be attending and setting a server
for us to test against.

Thanks again for all this work!!

steved.

[1] http://www.nfsv4bat.org/Events/2023/Apr/BAT/index.html

