Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0935489816
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 12:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbiAJLxz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 06:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbiAJLwc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 06:52:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B6C061245
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jan 2022 03:52:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m4so10985164edb.10
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jan 2022 03:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZjgw8dNYz+IuIPHh62asjXeqka/jIRSHm/Gv196S1g=;
        b=UhgojjQSFhnWV3ovNC4gDPJbyTnVrEWFuk4ma8zoGEM8bzubBAjZitYdLTedzKjvfx
         hJbmS+xF2yDXX5It1jRe5EtqBtjt8wB+RQhZPoHgVsZscgfa5gcFINtQVKFqHhZD5UOd
         Lb3+MfyZwbxm23qpBb5iSQ0Atiwbnh14LYMgkKcSiBaKVj8d246xRmjkqMtZa1YPWrbM
         ugACVcmSQu1V/0/ZUza3R97wmijkjczH6CRn8/IfPidkP/ZiDDCC2odttEmMhSCeTplq
         4pEDr1uKeN7L2v0T4Ac5dvFNcolSJ6trLBx5+eHlmYL7dMq/ypso0ndcyVsK8TS7AIVd
         QoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZjgw8dNYz+IuIPHh62asjXeqka/jIRSHm/Gv196S1g=;
        b=FtYzX6WerfzjExN2eUMuyJgmBvY/7KDinb7gtUMHUY+wNR29g9ASapabDBmciUddFW
         jZ1FieFj9jY7gChZyGMb1WlMbH/eGm0be1VmXtH2KTTDdauGIlmAzM5ywEq8AtV3O0UV
         Qnm9k+vOzQd7oSRAeW0i9h209MyYqGBWoC+1HTyvag+/Ap2sy3EjEkM687KeD3QQFFFP
         4nYzTgYdhXi+nuy6twSXoKf3mGwkdd144itGUSk65Ylj8x4R2X+VozBNAT4elEO4q/vE
         G8vlDzOsOXIxgE8C3NLBAWHLwNlWTC/NLohrgoN8nBC1E6PDQURG8qa00ex7u8xbjXYe
         vdMg==
X-Gm-Message-State: AOAM531Ssmko91PHkRj6IOVELDJPA33TC1hb+SKyp9GXeq4Nb+Eryh8q
        z+63IHCnuIGRZi5KBqVBGwy1XAmTr5ZvuF6+W7ULcA==
X-Google-Smtp-Source: ABdhPJwZ9oxJoUEpzejwoVPTMjuryy43ggbQjrZPgP0wqIocQqkRl8Zoc2HuZnLb8F8WHDRduantAe4kZfDfeiBwjAs=
X-Received: by 2002:a50:d710:: with SMTP id t16mr74631953edi.50.1641815550234;
 Mon, 10 Jan 2022 03:52:30 -0800 (PST)
MIME-Version: 1.0
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 10 Jan 2022 11:51:54 +0000
Message-ID: <CAPt2mGNt0shT7xmvCKb-G+gpza_eTrVqPhcVGx_7+smtGOHECw@mail.gmail.com>
Subject: Re: [PATCH v4 00/68] fscache, cachefiles: Rewrite
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 22 Dec 2021 at 23:13, David Howells <dhowells@redhat.com> wrote:
> These patches can be found also on:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-rewrite

I have run this through our production workloads without issue. There
were no recorded performance or stability differences between this and
the old fscache/cachefiles.

Our workload comprises mounting ~20 remote servers with "-o fsc" over
the WAN and then re-exporting those to 500 local client instances.
This production workload churns the fscache backing filesystem (EXT4)
pretty well (hundreds of MB/s) across all of the mount points
simultaneously.

I tested with both NFSv4.2 and NFSv3 mounts. Previously written cache
data was correctly reused between reboots and remounts.

Tested-by: Daire Byrne <daire@dneg.com>

Cheers,

Daire
