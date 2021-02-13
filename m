Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B5331AC32
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 15:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhBMOTF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 09:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhBMOTD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Feb 2021 09:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613225856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzOJarhQDftcPdp05htHWLd6UtB0xQh3hGlhrHrXeWE=;
        b=Q3rt7egRw1ZwmtD7gLVhAn3zsutSMHpWmyjuv0jJE3w8QRnAvwrxO3vrxlixuoTv9hpptY
        I9iBUTIrGjJXIykFqDLFyaRI2Tm7VybecCSm698xG5clp4Rgl8y5+LvFXbpw5Ut0T2zvuu
        9kBDarC4pcwUT7pmTn41KX/jVYpf7Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-_FsAXktGPu2-lRs4rkoDiA-1; Sat, 13 Feb 2021 09:17:34 -0500
X-MC-Unique: _FsAXktGPu2-lRs4rkoDiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBA9B8015A1;
        Sat, 13 Feb 2021 14:17:32 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-253.phx2.redhat.com [10.3.114.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 870DA17B99;
        Sat, 13 Feb 2021 14:17:32 +0000 (UTC)
Subject: Re: [PATCH 0/3] Add a mount option to support eager writes
To:     trondmy@kernel.org, Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
References: <20210212214949.4408-1-trondmy@kernel.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <d6d6c503-cdae-db31-45d4-e05fe46f0a2a@RedHat.com>
Date:   Sat, 13 Feb 2021 09:19:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212214949.4408-1-trondmy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 2/12/21 4:49 PM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The following patch series sets up a new mount option
> 'writes=lazy/eager/wait'. The mount option basically controls how the
> write() system call works.
> - writes=lazy is the default, and keeps the current behaviour
> - writes=eager means we send off the write immediately as an unstable
>   write to the server.
> - writes=wait means we send off the write as an unstable write, and then
>   wait for the reply.
> 
> The main motivator for this behaviour is that some applications expect
> write() to return ENOSPC. Setting writes=wait should satisfy those
> applications without taking the full overhead of a synchronous write.
> 
> writes=eager, on the other hand, can be useful for applications such as
> re-exporting NFS, since it would allow knfsd on the proxying server to
> immediately forward the writes to the original server.
> 
> Trond Myklebust (3):
>   NFS: 'flags' field should be unsigned in struct nfs_server
>   NFS: Add support for eager writes
>   NFS: Add mount options supporting eager writes
> 
>  fs/nfs/file.c             | 19 +++++++++++++++++--
>  fs/nfs/fs_context.c       | 33 +++++++++++++++++++++++++++++++++
>  fs/nfs/write.c            | 17 ++++++++++++-----
>  include/linux/nfs_fs_sb.h |  4 +++-
>  4 files changed, 65 insertions(+), 8 deletions(-)
> 
Shouldn't something be added to the nfs(5) man page 
as well as blurb added to /etc/nfsmount.conf file?

steved. 

