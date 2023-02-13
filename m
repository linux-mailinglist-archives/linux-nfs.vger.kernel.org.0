Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720B3694FFE
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 19:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjBMSyg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 13:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBMSyQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 13:54:16 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E931211DE
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 10:53:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id o8so12112314pls.11
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 10:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBh3q06ZS5SXm35/e7c32bxleythbEFsZcuj9li8Rps=;
        b=c9r4piR5AbhTXSm8eqjjuyEHFm1ir0sVope0sf8BeUeeJTewoVwIcwd7a+eLeREWgx
         Glw2sgjQbK0uiMArvh/4nPJ+WJm/uVmtxXkKO703qAsDJxLdqk/LMij4snODjvVnpI5f
         q1lmKvTRYjTsRXAwhR9bc4hQXEsHlGdQmlhP7331uTT+Xe3JdOToxwQsgSR8Xhv4HUhR
         VtiuVHvgtcwaQfuigbyExjgpOzCUpyM4GgaN8jvcxJfhYzQ3yYCZqDzdIAsZkSff70Yy
         n9X90A26GF0Y+mSTWakYtqmXXdcc5fX7JSdT27IUS+++yDzT/MRftokbX9N/F5RiqQM2
         Y7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBh3q06ZS5SXm35/e7c32bxleythbEFsZcuj9li8Rps=;
        b=eh3M34Xm3kCYrXgMaGcL5SgoUlGunNPOVfPah9ngkNUTkVv8pEQK7eyTFu1QRvcPR+
         GHrs3/veMGPtVS3Ztu613J412QOnZ97+97sW/u+/JBv00nhPAiLQQpOTwRDDvs9zATBx
         FL1VqC495QqhJCNAAVYsrMxIOR+uw6DfXSvdiqAbFaLV3j1X6OgOqe9JkAeAOKge2ys+
         skNMjdTn2fHno/f6px3yhbP8ZP6zSiJLL8GBodInIKUCmD7fie+SA69oRkpaQyrLoPgL
         Pv+RcLOF6jW80Y5Xa59hRthocUph4u7Qhz/tWkm6nwe/yzLZ8EQ/mzQjCtSvpIj/5zf7
         27Wg==
X-Gm-Message-State: AO0yUKV2nyqfX8jYXmBRFMT4Kn3WSz/ljtFx4hxaGB01q0aNy1n9Y0rt
        PrFGBPHFUo8auKYPXwjGjiRdzy9tyPDptNA+59A=
X-Google-Smtp-Source: AK7set+yVdP39k9iNJEIhwZsUDpxpYJcdOAvtWgzqbcpzKIeS7LzZy2oihn00263Kckn38m55LUE0cdS8lNtBvw0TLI=
X-Received: by 2002:a17:90a:541:b0:230:2231:e8bf with SMTP id
 h1-20020a17090a054100b002302231e8bfmr4782614pjf.142.1676314434241; Mon, 13
 Feb 2023 10:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20230212140148.4F0D.409509F4@e16-tech.com> <PH0PR14MB5493A75DC8E617230D426F09AADD9@PH0PR14MB5493.namprd14.prod.outlook.com>
In-Reply-To: <PH0PR14MB5493A75DC8E617230D426F09AADD9@PH0PR14MB5493.namprd14.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 13 Feb 2023 13:53:40 -0500
Message-ID: <CAN-5tyH45zKa+xcvwMoUzWPewUkwNZpJycNN+ZdHeea8Uj6tFQ@mail.gmail.com>
Subject: Re: question about the performance impact of sec=krb5
To:     Charles Hedrick <hedrick@rutgers.edu>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 13, 2023 at 1:02 PM Charles Hedrick <hedrick@rutgers.edu> wrote=
:
>
> those numbers seem implausible.
>
> I just tried my standard quick NFS test on the same file system with sec=
=3Dsys and sec=3Dkrb5. It untar's a file with 80,000 files in it, of a size=
 typical for our users.
>
> krb5: 1:38
> sys: 1:29
>
> I did the test only once. Since the server is in use, it should really be=
 tried multiple times.
>
> krb5i and krb5p have to work on all the contents. I haven't looked at the=
 protocol details, but krb5 with no suffix should only have to work on head=
ers. 3.2 msec increase in latency would be a disaster, which we would certa=
inly have noticed. (Almost all of our NFS activity uses krb5.)
>
> It is particularly implausible that latency would increase by 3.2 msec fo=
r krb5, 0.6 msec for krb5i and 1.6 for krb5p. krb5 encrypts only security i=
nfo. krb5p encrypts everything.  Perhaps they mean 0.32 msec? We'd even not=
ice that, but at least it would be consistent with krb5i and krb5p.

Actually they really did mean 3.2. Here's another reference that
produces similar numbers :
https://www.netapp.com/media/19384-tr-4616.pdf . Why krb5 perf gets
higher latency then the rest is bizarre and should have been looked at
before publication.

> From: Wang Yugui <wangyugui@e16-tech.com>
> Sent: Sunday, February 12, 2023 1:01 AM
> To: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> Subject: question about the performance impact of sec=3Dkrb5
>
> Hi,
>
> question about the performance of sec=3Dkrb5.
>
> https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-im=
pact-kerberos
> Performance impact of krb5:
>         Average IOPS decreased by 53%
>         Average throughput decreased by 53%
>         Average latency increased by 3.2 ms
>
> and then in 'man 5 nfs'
> sec=3Dkrb5  provides cryptographic proof of a user's identity in each RPC=
 request.
>
> Is there a option of better performance to check krb5 only when mount.nfs=
4,
> not when file acess?
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/02/12
>
