Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C264DDC80
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Mar 2022 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbiCRPNL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Mar 2022 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiCRPNE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Mar 2022 11:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC5A15DA98
        for <linux-nfs@vger.kernel.org>; Fri, 18 Mar 2022 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647616304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Iqx9gM8PZJsV0JeocXjrzFPDXvAs2R4g2dzo2cRqZA=;
        b=EdiuHbdkO0srINSur4YQqnQ5ET4IeBS4YWY32ZGap7yM5eaYGxUg+bQsCFlALx1AC2uOj2
        tC3v1b6yjULYI0ldWCH43G7eezvGcPdt4fgOEK5Z2QN0GZr2IBO0MAtW6WMCrEOz78b4rH
        F2ZXSnCiDuurt34tiwnsX5inGCJIu7w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-TbvVBjWYNZ28xMMWhhKoaw-1; Fri, 18 Mar 2022 11:11:41 -0400
X-MC-Unique: TbvVBjWYNZ28xMMWhhKoaw-1
Received: by mail-ed1-f71.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso5070495edb.10
        for <linux-nfs@vger.kernel.org>; Fri, 18 Mar 2022 08:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Iqx9gM8PZJsV0JeocXjrzFPDXvAs2R4g2dzo2cRqZA=;
        b=ttYLW1QDgmBNFgkugjZptjn8a8bLqLtQ5qbidfiwaDuF2lr8h78+43NCs28JtV6Psz
         SFvdjIZr0aD8qc64f8UMSfs5GSoAEIESpzHztKTYVtYxtMzXKfMzuM7rXTyT1d2k3zkQ
         FNwEVLxxRaQPcVrYPQ5Yn8rZH+5MxxV2KdwbSU8XPUJrBYXbk0AtexeT9PPwq9yeEyW7
         vmcuO2ayP/G3/OjGOnBjfvrn2d6VHWcv+M+Yr5n480l1Fsczjk8mIPnpZXcfnvG4S1gw
         DWWQl1J5y230QEdDSRlaFk3gUfpPtWLRTZwShcIZ72N2vf8dJl2fBcGoZi8gLp3fRnrl
         Rmlw==
X-Gm-Message-State: AOAM531piK7ZDxuLF0C8CA82m5kHdnF63FzGb/T+4LdavIvr+rGRNS0J
        9yoknfWY4G6Jq7Aurs4iGSP5xuLq/pDz/3Tdjua+Jo4KGC4a1vSY8Xr6xXLRTJkuMbVhpcjqp6F
        dEZy+sln7pcXLfk9knhTkLRygdAQ6154gW16Q
X-Received: by 2002:a17:907:2cc3:b0:6da:e6cb:2efa with SMTP id hg3-20020a1709072cc300b006dae6cb2efamr9218742ejc.169.1647616299973;
        Fri, 18 Mar 2022 08:11:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyScdGTJcK1xM4kj/G8NVYBMuLgCVWzpbY7b9aVbxjxr93oEIQbnwpoUmi568WkHRq1OhPlpLZoTr9y7ewRwGM=
X-Received: by 2002:a17:907:2cc3:b0:6da:e6cb:2efa with SMTP id
 hg3-20020a1709072cc300b006dae6cb2efamr9218718ejc.169.1647616299753; Fri, 18
 Mar 2022 08:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220311190617.3294919-1-tbecker@redhat.com> <20220311190617.3294919-8-tbecker@redhat.com>
 <f3910fdd-d107-1f6c-8cfc-1b7f429f8024@redhat.com>
In-Reply-To: <f3910fdd-d107-1f6c-8cfc-1b7f429f8024@redhat.com>
From:   Thiago Becker <tbecker@redhat.com>
Date:   Fri, 18 Mar 2022 12:11:28 -0300
Message-ID: <CAD_rW4WUUSiV7FHaPRnEOYNRCiaH-rRr9j=pBDKO99RXQqzsYg@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 7/7] readahead: documentation
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the comments.


On Thu, Mar 17, 2022 at 12:37 PM Steve Dickson <steved@redhat.com> wrote:
> I think it might make sense to added some examples
> on how the command will be used.

Will do.

> Would it make sense to try added these to nfs.conf?
>
> I must admin I'm a bit impressed with your lex and
> yacc routines in patch 5, I have not seen those
> in a while.. but that does add more dependencies
> to nfs-utils and as well as yet another config file
> to manage.

I debated with a funko pop between writing the parser and using a parser
builder. Originally, the idea was to provide more possibilities, like
configuring the read ahead of other devices, but those BDIs don't
announce themselves when they are added like NFS does. I also don't know
how useful it would be. So this idea is scrapped for now.

Here are the debate conclusions:
  - writing the parser would add some complexity that lex/yacc handles
  - lex/yacc add build time dependencies and some bloat
  - error handling is painful with lex/yacc
  - lex/yacc are well known
  - using a parser combinator would be my preference, but I couldn't
    find any written in c that didn't add a new library to the systems

It seemed to me that using lex/yacc was the best choice taking into
account the needs of both limited storage systems and large servers.

I can still see some configurations that may be added in the future,
like setting the read ahead per server, network segment, but I believe
that the configurations we have cover most of the use cases.

I've added a new configuration because I planned to have a more fine
grained configuration for multiple file systems/designs, and that
would add a lot in nfs.conf (and tie the tool to nfs).

And, to be completely honest, I took what I've done in
https://github.com/trbecker/readahead-utils
and ported it to nfs-utils.

That's the history so far. I don't mind taking stuff out if it would
make the software more maintainable.


> steved.
>

thiago

