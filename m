Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD978D833
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjH3S3U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbjH3Gxk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 02:53:40 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6C019A
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 23:53:36 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7a505727e7eso683729241.0
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693378415; x=1693983215; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIMufmcPljVq9B0zYCPDjqzphZzAERPBfQDoanecvZU=;
        b=mGNAjYyv6BdQS09mLGfq9VPcCMDdYFJOj5FvbtygSu4l1Y4xS/5nblLRfVVV6kJjA1
         UY2J5LwIdEV7ozQi+EhNBl7/onBHeaaa7coQOWFvEjVlSYgd8OxyWNzwfUxqdVIM5zZx
         nIFHXiY5JRUfHyw0RN4beuZ7qdN9ouQF23+xudAC1jvc2ahg7+fKPITJZRqCZcUp4vBe
         XjZNFJ+wZWqo1MGRehQQszV1RBCqZn88yh+QEZ0WmU9CG6pbYk5tEeMmRoB2ZtkCWDKn
         OAncvvAtO4582jKpKwaNo3sNSWeiX54W34Y88HOFKM7vs7jiqRIlcuxdIi0vj2upcHfi
         cquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693378415; x=1693983215;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIMufmcPljVq9B0zYCPDjqzphZzAERPBfQDoanecvZU=;
        b=BXsSMDCsQVIx0OjzOFkKm/Rv6Nhz+jCZbQheZNcWnQwqL8M6MvcCRo1sJuk5YaGof7
         KjIXwaLztcZEn9jSmJnABVkN1aQKZ+9JiAGzzfXNef0sOUqMnra33wuyalMJfv4j0Y1P
         9nClk4/Oakxr1YQzjCN5HAnDV7tj60GTURJ6qXlnKlJXma0yFZ9cqKZbGePKMuI5UF2u
         U+1QI2XCLZsuxJ+bgJgdYxh0GgaO5xLAujNmvMYSKI1WBgMRB0I36+D+LQk6x9QN4bZq
         njxj00Xhrtr8fkZvDdL49K57AAHduqXesfDTzrPDMDQNMWaN18IY/tKaX15o2b1xAiGX
         8laQ==
X-Gm-Message-State: AOJu0YxLoK2vE5vSgF6z8G6jNwen2oYDB9r0WIGlQDGNz9SqBUIg0d40
        vUrjlkJArd3dXD1Lr3xC3gat9jPkLmzlIR4IcwdzEtXCIiBOSg==
X-Google-Smtp-Source: AGHT+IEECV6rjlOeKnSVwNrCHgupOWD+W7wojg8CqvIR+FvRkVbnWT5LhNqLlV451Lk0W8TBOT6LxyeRSvtsLwDiqBk=
X-Received: by 2002:a05:6102:2f5:b0:44d:4a41:8941 with SMTP id
 j21-20020a05610202f500b0044d4a418941mr1357236vsj.1.1693378415328; Tue, 29 Aug
 2023 23:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <CABXB=RSMkjoyshFZy5eGbuvAQfoHhFyQvReYNtO_+5f+OM66cA@mail.gmail.com>
In-Reply-To: <CABXB=RSMkjoyshFZy5eGbuvAQfoHhFyQvReYNtO_+5f+OM66cA@mail.gmail.com>
From:   J David <j.david.lists@gmail.com>
Date:   Wed, 30 Aug 2023 02:53:23 -0400
Message-ID: <CABXB=RR=67b-sksfcrJotivc_9G0vTesP3qtz9T_8G3N3H-15A@mail.gmail.com>
Subject: Re: Question about different gid management between versions
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 30, 2023 at 2:17=E2=80=AFAM J David <j.david.lists@gmail.com> w=
rote:
> We have existing NFS servers based on Debian Bookworm that run
> nfs-kernel-server 1.3.4.  We have recently stood up some Debian
> Bullseye fileservers, which come with 2.6.2.

Of course I got those versions backwards. The old ones are Bullseye,
the new ones are Bookworm. :-P

Also, for giggles, I tried installing the Bullseye 1.3.4 packages on
Bookworm.  Somewhat surprisingly, that did work.  But it didn't affect
the issue at all. I guess that might imply that the change is
something to do with the bits of NFS built into the kernel, rather
than the nfs-kernel-server stuff? Operating at the outer limits of my
knowledge here!

FWIW, the kernel is 5.10.0-25-amd64 on the old machines and
6.1.0-11-amd64 on the new ones.

This does make me think I'm going to have to reinstall those Bookworm
servers with Bullseye, at least for now.  Unless maybe somebody here
who knows a lot more than me has a brilliant idea.
