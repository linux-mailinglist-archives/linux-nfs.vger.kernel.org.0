Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE67E7FD4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjKJR7y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 12:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjKJR7S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 12:59:18 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4B83F1
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 23:21:28 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f48ad1700aso746801fac.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 Nov 2023 23:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699600887; x=1700205687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mR3q02LxseFLhJXARiuH5j3WDurBm5tz6pt9QxQNZ0Y=;
        b=m8+WdaBl4Dun5kKZ7oZyP0yg+gBj55aXSewy+y/2ATXX/eN7yBDVHd+f49o3Wo2UNm
         xQls/2cWhoFR6v1lwQOEOTT4o4B2hbAk3+t4RJInTbcXpd3QCGwskFzWXgPGmVEEz1/f
         tzMtx/az9mia36B+KRP6lkoX7e0DvMhrpMUZqdeceanP37T5yG6rEtzFfo3q72Bv1DJK
         Rl7JXMRqI/2WixGjzK2V8JLzZR42rzQjNamrgF3eSAgFHMfjDJ7Iaz7/HDvoZz4xnhh9
         nhD2CDsPtjNB+Rl+U/WPsLbHSzQS4zJocTZsqJwlHnJGOVXgNsjvkKbBbEviwXJ0BeoN
         XYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600887; x=1700205687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mR3q02LxseFLhJXARiuH5j3WDurBm5tz6pt9QxQNZ0Y=;
        b=W4MMzp2AIL4aep2LX5/3219yVvFh+8lyjoQve5jGVNzBjo5cawnScjzkaPITZIpehx
         N0Umn3Fi03he1MkyvY4JIdgMULSAq0+GGiym4k++NPnNW8y2hrhp5WNpTgw5NuIlZLUd
         wRqqjLDt9e7f6gzEUa8wNueKUox1BvdOsE5zy7VXOGU4Y87K4SnAlcVKplCxX+YE6tuh
         TJSlLq9JyyInbkjz1g+kmKahZJoiHP3/+1XC9+Bf3K9vUEmGcqDdt2hcb6Y7UW4BYLbG
         t4g9X5MjG00V2YgZhlgk7aEbi+Oej8ztg1nhxjnsU/oN1UmrTjS8uchM08NdM3waCF5X
         o6JA==
X-Gm-Message-State: AOJu0Ywg0LwbjCcFH4vLL8OJrB3tN1M/RApz+I72b10phyxrblvBHf53
        7DCIZ8a6sZ+rWAeeszcykSTHVN/pk5yaUyGFb39VoQnB
X-Google-Smtp-Source: AGHT+IEvEjvCJAcFqozFJdkQa8yAU/RaRBrweXjkLtEgJcVqKUzLNW3rqJzj2ykrFpQu1uTrbiOUyTMlejt+yELV0fw=
X-Received: by 2002:a05:6870:eca1:b0:1f0:3fd5:9d5a with SMTP id
 eo33-20020a056870eca100b001f03fd59d5amr963315oab.16.1699600887530; Thu, 09
 Nov 2023 23:21:27 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0Ucch734JB9piCUaTbCXwuuYSTmayvSin8RFYfcYcD+FmA@mail.gmail.com>
 <CALXu0UfzqBu-T9tZuchqnZBkvfuDUJaBmcDgTaWZfUC_yimGCA@mail.gmail.com>
In-Reply-To: <CALXu0UfzqBu-T9tZuchqnZBkvfuDUJaBmcDgTaWZfUC_yimGCA@mail.gmail.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Fri, 10 Nov 2023 08:20:00 +0100
Message-ID: <CANH4o6MBpoN2P6B5ri3hBrLJmFawjS0QLCYPAACjkdJkv76XSg@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] CITI ms-nfsv41 client: IOCTL_NFS41_WRITE
 failed with 31 xid=5481722 opcode=NFS41_FILE_QUERY?
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     Ms-nfs41-client-devel@lists.sourceforge.net,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 10, 2023 at 1:07=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Fri, 1 Sept 2023 at 05:53, Cedric Blancher <cedric.blancher@gmail.com>=
 wrote:
> >
> > Good morning!
> >
> > The CITI ms-nfsv41 client for Windows sometimes prints the following wa=
rnings:
> >
> > 1eac: IOCTL_NFS41_WRITE failed with 31 xid=3D5481722 opcode=3DNFS41_FIL=
E_QUERY
> >
> > Does anyone know what this means? Data loss?
>
> Roland Mainz fixed the bug in
> https://github.com/kofemann/ms-nfs41-client/commit/7824f2398170d07d2ad83b=
d23fac4dacd34cd47a
>
> So no data loss, but a Win32 syscall randomly failed.
>

Cool

So we finally get a working opensource Windows NFSv4 client? How far
away is the code from being production-ready?

Thanks,
Martin
