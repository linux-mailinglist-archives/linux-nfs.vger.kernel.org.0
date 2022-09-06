Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3B5AEFE4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiIFQHX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 12:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiIFQHC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 12:07:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2962680F6A
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 08:30:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e17so8048681edc.5
        for <linux-nfs@vger.kernel.org>; Tue, 06 Sep 2022 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6pyOmieqdBXsmOyDs5+qMVDAkBPGF71QfYL2EpZXG5w=;
        b=iuAaMsS+h2k7sUE2GmJDUGFDPNhjSDsguoz/LuKQf4zYUqQkPk6VEPi91vKQP3O2VA
         yPmaMifx9AggJ53pyQZlREXd+MrF0qHGuaF8QR4B8Uf66tpSqHWd303mX/gqneMzdTlv
         +vOZdGt9oWV5TNzcHgwEhHY8WjQcmW/9sHhNo74fJyWiEW0uBuOe9gXx8TGISMQGc2X2
         A8PN4u0acAj+S9JLNgANUBRLfW5rOlbi42c4GEk/yAG5yfBZ3PwWNjlET9NMm9oliB7N
         EEvFIyA/YYW1OtJUGJP8MbXA8ddJT61/Bsk2sm/DvFMOAYKpKKPDkxAhM1nNw8b1jPgG
         GO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6pyOmieqdBXsmOyDs5+qMVDAkBPGF71QfYL2EpZXG5w=;
        b=E/Lr3lNrZ8rIiI5k3R4vPV5ba+Hvii6aL1k3VMFXxqxigoOltPYSwW6mWCzjof9ian
         mr+r9cKhFRi5x522vZFGianwikqHImxahTtig11XjzqCG/FIPGa0daXFCYqZ7TiCaQkJ
         aUFu+ymfsGQOLltdij/iLFRZ71+1PV+9rDxFRKhQERBSdR/Hu7FUEH+4Io1CpJjruWEk
         w5AHOQQ/L7hMs7cOnaeR861eUnVyAk2zhQUIXX5BndtbvYwl8Cf2KOdW43UuuxZ8DQYZ
         EsaDVOicsGaF0b+88P2JLAzuObmtn1BLT7r0FjWCmlI0zm6ns/+McHc8Zr+TydxXaUQ8
         rjzg==
X-Gm-Message-State: ACgBeo1dbgbU5Eqmcy7dMYZ4L/LuX9CSA4zPstchUIYzzjgIYaYahkc1
        cefRPW+oWKuQvKAIoJUl87/JsVP98P2P7iSrZFCcbeop
X-Google-Smtp-Source: AA6agR49/FoCJh37ckQ+MDLb88qRSTj3gUMsJIdrWuIDNlVkL9bokigbV6VHugL6Jedcu3LDDKy4aPfiRutQFTA51S0=
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id
 fj8-20020a0564022b8800b0043a6c586c64mr48823482edb.348.1662478211137; Tue, 06
 Sep 2022 08:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <BF47B6B7-CB52-4E14-94B0-E28FD5C52234@oracle.com>
In-Reply-To: <BF47B6B7-CB52-4E14-94B0-E28FD5C52234@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 6 Sep 2022 11:30:00 -0400
Message-ID: <CAN-5tyGxxp-TD-zjjkMoS-snPYyfy+PuCV4BR6eofdmFt=-7Dw@mail.gmail.com>
Subject: Re: nfs/001 failing
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 5, 2022 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi-
>
> Bruce reminded me I'm not the only one seeing this failure
> these days:
>
> > nfs/001 4s ... - output mismatch (see /root/xfstests-dev/results//nfs/001.out.bad)
> >    --- tests/nfs/001.out      2019-12-20 17:34:10.569343364 -0500
> >    +++ /root/xfstests-dev/results//nfs/001.out.bad    2022-09-04 20:01:35.502462323 -0400
> >    @@ -1,2 +1,2 @@
> >     QA output created by 001
> >    -203
> >    +3
> >    ...
>
>
> I'm looking at about 5 other priority bugs at the moment. Can
> someone else do a little triage?
>

Is there any more info about this (like exported file system or
something or a network trace)? I typically hit this issue when I get a
client and it doesn't have nfs4_getfacl command installed.

>
> --
> Chuck Lever
>
>
>
