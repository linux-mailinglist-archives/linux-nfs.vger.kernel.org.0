Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2586EB0B5
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjDURiE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjDURiE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:38:04 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3314112588
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:38:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3ef38bea86aso11454211cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098681; x=1684690681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XArwqo9xByKk+E1r98ALtxRloTa5ZsuFnsr/PGszOh8=;
        b=BpaOf/tlKrnfZa7nGjzi5SOEUtjnwwCS5CroqZ8X03NbDsYJqDkO4McJd4Mh828u6E
         9G/GRwUPKwzjl5Qe4uAt+j26gaYh09hf5x2L+O4YOowzVJ2tbr63VOKhzyKVNzbmwskL
         23a7swZl6i0jHXNJrpCgiH9C47vLFkpRiL1kpFhiwdjK0TuseXyONcRNbdzUUkxjuHXy
         oaQzxYpGsDPNSQ0SdSApxXPD62GVSb7tfYq6FovymD1y0SJ9MO5TbAaFCn8kscB7UfUu
         CAMdD7rMacr9DMQDwBCG9obgtBYK0VHmVKD7Ev6u1vtzYuX/jhpXg4I5dnvUQUj9JUsq
         G+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098681; x=1684690681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XArwqo9xByKk+E1r98ALtxRloTa5ZsuFnsr/PGszOh8=;
        b=Uspdjo2hjz0s0HUmY5yFCOCgH0rWA9eMAWXNE7L9jlDiVlzuSvm+Xz5R5m36UeXzod
         5AAX82IrTAC2woT0TiwDhjYHkggex2FkS06Gc5ZP1fwiHzbYF1e8cuqrNN3pkOF3/em7
         fBmbd3GVR7VqJixdfgJCwEqdzr9CUCnP1SfyF5NqvCQIETjpvJTByofT97dL9abb2Jnz
         0xwYh5ubzgJQqGffaC1QD47DF8AXS6d0CmWCxbjB4dUoQNvwv4IofdaD7EudDKZgFolQ
         WbwDtuyr2M3kLTRta+fT6Myf9Uc8DNW7sseHDXJdyOO7kKLEhgUOd7RIWIsvC6RdV2wH
         sMXg==
X-Gm-Message-State: AAQBX9d1FXLvEejNm2mjHjZ6azcUEiaCeEPhmZTWJ9qs+fylqxyxayS8
        4GfIfat7X0VYGLM6WUuP+8gG+cBdWRgvJW0c6EULXi0X
X-Google-Smtp-Source: AKy350ZuodJM16XeYbSBkU4NEJTn/0kjulHO+PLAYTAjhYWp+m5HObXPAFXU6KknXTw56+DszIYzN4QOsrxeo7iJa74=
X-Received: by 2002:ac8:4e45:0:b0:3a8:a84:7ffa with SMTP id
 e5-20020ac84e45000000b003a80a847ffamr8840143qtw.57.1682098681000; Fri, 21 Apr
 2023 10:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682096307.git.bcodding@redhat.com>
In-Reply-To: <cover.1682096307.git.bcodding@redhat.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 21 Apr 2023 13:37:45 -0400
Message-ID: <CAFX2JfnhRv53kSFs5s+QqwVmU2pQShWL_jQSTztMMFvv79=04A@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC v2] NFS sysfs scaffolding
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben,

On Fri, Apr 21, 2023 at 1:10=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> Here's another round of sysfs entries for each nfs_server, this time with=
 a
> single use-case: a "shutdown" toggle that causes the basic rpc_clnt(s) to
> immediately fail tasks with -EIO.  It works well for the non pNFS cases t=
o
> allow an unmount of a filesystem when the NFS server has gone away.
>
> I'm posting to gain potential NACKing, or to be redirected, or to serve a=
s
> fodder for discussion at LSF.
>
> I'm thinking I'd like to toggle v4.2 things like READ_PLUS in here next, =
or
> other module-level options that maybe would be useful per-mount.

I have a patch built on your v1 posting that implements this. I can
rebase on v2 (well, I guess it'll be v3 now) if you want to see it!

Anna

>
> Benjamin Coddington (9):
>   NFS: rename nfs_client_kset to nfs_kset
>   NFS: rename nfs_client_kobj to nfs_net_kobj
>   NFS: add superblock sysfs entries
>   NFS: Add sysfs links to sunrpc clients for nfs_clients
>   NFS: add a sysfs link to the lockd rpc_client
>   NFS: add a sysfs link to the acl rpc_client
>   NFS: add sysfs shutdown knob
>   NFS: Cleanup unused rpc_clnt variable
>   NFSv4: Clean up some shutdown loops
>
>  fs/lockd/clntlock.c         |   6 ++
>  fs/nfs/client.c             |  21 +++++
>  fs/nfs/nfs3client.c         |   4 +
>  fs/nfs/nfs4client.c         |   2 +
>  fs/nfs/nfs4proc.c           |   2 +-
>  fs/nfs/nfs4state.c          |   5 +-
>  fs/nfs/super.c              |   6 +-
>  fs/nfs/sysfs.c              | 148 +++++++++++++++++++++++++++++++++---
>  fs/nfs/sysfs.h              |   9 ++-
>  include/linux/lockd/bind.h  |   2 +
>  include/linux/nfs_fs_sb.h   |   3 +
>  include/linux/sunrpc/clnt.h |  11 ++-
>  net/sunrpc/clnt.c           |   5 ++
>  net/sunrpc/sysfs.h          |   7 --
>  14 files changed, 204 insertions(+), 27 deletions(-)
>
> --
> 2.39.2
>
