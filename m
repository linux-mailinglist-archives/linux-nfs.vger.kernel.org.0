Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A084A3A2001
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 00:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFIW3J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 18:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhFIW3J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 18:29:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16ACC061574
        for <linux-nfs@vger.kernel.org>; Wed,  9 Jun 2021 15:27:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g8so40819985ejx.1
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jviqe5IYvU8JHGz1ejdMFEY6n3hCvLN6L+GbnWYMMks=;
        b=cJ3+1Rm/SFG5z4gLqDa/lshls+YitVZBgqnWbuhKkB+onbkFvFiX801HWePqtBVFjC
         +DOP2jx9T9DZA1zHXohSU3GlRNmYEV7xA4HFbsbCFU6vtY8CTk0jQP1lySWQMzYUwlpa
         2gpzo5irNk05zxqnJWdP84W+u0bIHRsYzwTITS0HzookvhWABvPOdEbRPHXBNO+Tz7MH
         sG4w+PaIZDL/SzjXSA8VTmAEhPl4tjKyPc6lm+4KrnM4f2tSva29Lc1qu6MF+98RuX3D
         Wts17uaN2Vs/eY11IR3+gR06Ipbirn0ZbuHHIaNaJ6+/Lmw52xRPqhB3MuBfCDdeZj+S
         4C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jviqe5IYvU8JHGz1ejdMFEY6n3hCvLN6L+GbnWYMMks=;
        b=qLMo5c20Wjjb41xPMMx8Y8zRLPsPJQ1I8LsNXw+6yO+BMIN/qE6alEQTURfx3GU+Vx
         rC/m3dm0CXWu7EfYV5T1dEujoCMoVwb3N22/RwtiUg+XuB8aXfmvGuU1f/l/8ZTHq9wM
         sbYAoThzvOybqpj5kXRwnS5L8Su8ZmHlfy0bTwRM1QoMpJ1tspfBuT9/T6jwO2uLXZCH
         RSIMcGEUHO3UzPE81dkic4jVzuzV5mqRPYrfsUhsV82vS+rPi/m89R4koTx3BZNzSkz0
         LKA7JOhZpj0XFpZL2Ll3n26zCE7JV+YfOGQIiU/TWZbDYC4uUtnjG1Eb9WqV8Et1IYiy
         dy3g==
X-Gm-Message-State: AOAM533Kp6YKKcQ5IeVoDp2pNwMdV8uHT2F3BOmCCgDpkbAa7LCAYT9M
        eP5R1aDpNp49ukKyft6TE6VzjOEy3kI94P6KGJljlhBbzO8=
X-Google-Smtp-Source: ABdhPJz0IDF0j+xFHHQGQ1cgA+n2XvFiy2b1gcYxczVZgVl1jEZT/oUyvRPBcz7vWLSmBxBddo3/WnxVYTsBj5tSfX8=
X-Received: by 2002:a17:906:998c:: with SMTP id af12mr1789298ejc.510.1623277632302;
 Wed, 09 Jun 2021 15:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 9 Jun 2021 18:27:01 -0400
Message-ID: <CAN-5tyFc=Ybh0ufu76TipkinSRyFyVvOOOo3kH2i1gJc9J4PDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] don't collapse transports for the trunkable
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Apologizes, the title got corrupted. The title of the series should be
something like : "don't collapse trunkable transports"

On Wed, Jun 9, 2021 at 5:53 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> This patch series attempts to allow for new mounts that are to the
> same server (ie nfsv4.1+ session trunkable servers) but different
> network addresses to use connections associated with those mounts
> but still use the same client structure.
>
> A new mount options, "max_connect", controls how many extra transports
> can be added to an existing client, with maximum of 128 transports in
> total for either nconnect transports (which are multiple connections
> but to the same IP) or transports that are going to different network
> addresses.
>
> Olga Kornievskaia (3):
>   SUNRPC query xprt switch for number of active transports
>   NFSv4 introduce max_connect mount options
>   NFSv4.1+ add trunking when server trunking detected
>
>  fs/nfs/client.c             |  1 +
>  fs/nfs/fs_context.c         |  8 +++++++
>  fs/nfs/internal.h           |  2 ++
>  fs/nfs/nfs4client.c         | 43 +++++++++++++++++++++++++++++++++++--
>  fs/nfs/super.c              |  2 ++
>  include/linux/nfs_fs_sb.h   |  1 +
>  include/linux/sunrpc/clnt.h |  2 ++
>  net/sunrpc/clnt.c           | 13 +++++++++++
>  8 files changed, 70 insertions(+), 2 deletions(-)
>
> --
> 2.27.0
>
