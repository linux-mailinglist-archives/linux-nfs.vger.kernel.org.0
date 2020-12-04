Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052882CF10F
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgLDPsY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Dec 2020 10:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgLDPsX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Dec 2020 10:48:23 -0500
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [IPv6:2001:638:700:1038::1:9c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFCFC0613D1
        for <linux-nfs@vger.kernel.org>; Fri,  4 Dec 2020 07:47:43 -0800 (PST)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [131.169.56.166])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 08919605F2
        for <linux-nfs@vger.kernel.org>; Fri,  4 Dec 2020 16:47:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 08919605F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1607096861; bh=aqzmUh4G4rpZKvraXeOWJt8h9/sU6iT7tillscM2ujk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=T0i8nogVN4U51vs4krhpERXic+fQ3t3rg3oGefZTgGi2V6LpZnV8qIJadvQZKHC9E
         FW1qhUGoQ9SeqpnZ0YLPfL12nKNy316pSnwgeXZ6b7VowgOOb5Z3Gi4g5HdXC4OuWW
         MUXX/0L7BnIJluFWXCHhAMzciL9xul+kUAyh9LRQ=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [IPv6:2001:638:700:1038::1:83])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 0202FA0586;
        Fri,  4 Dec 2020 16:47:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id D01DA80067;
        Fri,  4 Dec 2020 16:47:40 +0100 (CET)
Date:   Fri, 4 Dec 2020 16:47:40 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     schumaker anna <schumaker.anna@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Message-ID: <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de>
In-Reply-To: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Mac)/8.8.15_GA_3980)
Thread-Topic: Disable READ_PLUS by default
Thread-Index: 9Q3FB8a67UESU3XJJaQGA1xWvDXZFA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

I see problems with gedeviceinfo and bisected it to c567552612ece787b178e3b147b5854ad422a836.
The commit itself doesn't look that can break it, but might
be can help you find the problem.

What I see, that after xdr_read_pages call the xdr stream points
to a some random point (or wrong page)

Regards,
   Tigran.


----- Original Message -----
> From: "schumaker anna" <schumaker.anna@gmail.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Cc: "Anna Schumaker" <Anna.Schumaker@Netapp.com>
> Sent: Thursday, 3 December, 2020 21:18:38
> Subject: [PATCH 0/3] NFS: Disable READ_PLUS by default

> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> I've been scratching my head about what's going on with xfstests generic/091
> and generic/263, but I'm not sure what else to look at at this point.
> This patchset disables READ_PLUS by default by marking it as a
> developer-only kconfig option.
> 
> I also included a couple of patches fixing some other issues that were
> noticed while inspecting the code. These patches don't help the tests
> pass, but they do fail later on after applying so it does feel like
> progress.
> 
> I'm hopeful the remaning issues can be worked out in the future.
> 
> Thanks,
> Anna
> 
> 
> Anna Schumaker (3):
>  NFS: Disable READ_PLUS by default
>  NFS: Allocate a scratch page for READ_PLUS
>  SUNRPC: Keep buf->len in sync with xdr->nwords when expanding holes
> 
> fs/nfs/Kconfig          |  9 +++++++++
> fs/nfs/nfs42xdr.c       |  2 ++
> fs/nfs/nfs4proc.c       |  2 +-
> fs/nfs/read.c           | 13 +++++++++++--
> include/linux/nfs_xdr.h |  1 +
> net/sunrpc/xdr.c        |  3 ++-
> 6 files changed, 26 insertions(+), 4 deletions(-)
> 
> --
> 2.29.2
