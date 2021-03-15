Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A05F33C6EB
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 20:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhCOTiB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 15:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232186AbhCOThs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Mar 2021 15:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615837067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ult/IJFOZfT14hoYiAJXeKXOaU0V0jFA3eEq1RkzJgY=;
        b=NzMpqIqOy/vgFbMmNmkbyj2pAUGxF5cyctdn31W+kWvMDK0tTQfFb+aeEwRlH89qYm2fBg
        BIlW5F7XOTMwJN7R4yKUeHPHXX43WsROBEJZ6NX5RRJNPc3+U79kBAeQ1lVjSOlJa1A4am
        lYAR7ZL60yHLEG6N+7wYPimk1R6qUg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-BYfYePChN5Sl77fp1GLTpQ-1; Mon, 15 Mar 2021 15:37:45 -0400
X-MC-Unique: BYfYePChN5Sl77fp1GLTpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9125F87A840;
        Mon, 15 Mar 2021 19:37:44 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-124.phx2.redhat.com [10.3.113.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A6685D705;
        Mon, 15 Mar 2021 19:37:44 +0000 (UTC)
Subject: Re: [PATCH 0/7 v2] nfs-utils: provide audit-logging of NFSv4 access
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <161490464823.15291.13358214486203434566.stgit@noble>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <9e504f91-9f0a-d29b-12e1-b8c3aca908b2@RedHat.com>
Date:   Mon, 15 Mar 2021 15:39:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <161490464823.15291.13358214486203434566.stgit@noble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/4/21 7:43 PM, NeilBrown wrote:
> This version improves the man-pages, usage messages, etc and
> adds a new feature: logging client attach/detach based on
> /proc/fs/nfsd/clients/
> That feature is in patch 7 and should be considered RFC at this point.
> i.e. patches 1-6 are ready to apply, patch 7 isn't.
> 
> A problem with patch7 is double-reporting due to the extra transient
> entries in the clients directory.  I'm wondering if we could add a
> "Confirmed: Y" line for confirmed clients, so that the code could
> ignore any clients which are not confirmed.
> Maybe those clients should just not appear, but I'd like something
> that will not produce noise on old kernels, and I'm happy if it
> doesn't produce any log messages without a backport of a small
> kernel patch.
> 
> Comments?
Thank you for going the extra mile! 

Series Committed... (tag: nfs-utils-2-5-4-rc1)

steved.

> 
> V2 series comment:
> 
> V1 of this series didn't update the usage() message for mountd,
> and omited the required ':' after the 'T' sort-option.  This
> series fixes those two omissions.
> 
> Original series comment:
> 
> When NFSv3 is used mountd provides logs of successful and failed mount
> attempts which can be used for auditing.
> When NFSv4 is used there are no such logs as NFSv4 does not have a
> distinct "mount" request.
> 
> However mountd still knows about which filesysytems are being accessed
> from which clients, and can actually provide more reliable logs than it
> currently does, though they must be more verbose - with periodic "is
> being accessed" message replacing a single "was mounted" message.
> 
> This series adds support for that logging, and adds some related
> improvements to make the logs as useful as possible.
> 
> NeilBrown
> 
> ---
> 
> NeilBrown (7):
>       mountd: reject unknown client IP when !use_ipaddr.
>       mountd: Don't proactively add export info when fh info is requested.
>       mountd/exports: update man page
>       mountd: add logging for authentication results for accesses.
>       mountd: add --cache-use-ipaddr option to force use_ipaddr
>       mountd: make default ttl settable by option
>       mountd: add logging of NFSv4 clients attaching and detaching.
> 
> 
>  nfs.conf                   |   4 +
>  support/export/Makefile.am |   3 +-
>  support/export/auth.c      |   4 +
>  support/export/cache.c     |  41 +++++----
>  support/export/export.h    |   9 +-
>  support/export/v4clients.c | 177 +++++++++++++++++++++++++++++++++++++
>  support/export/v4root.c    |   3 +-
>  support/include/exportfs.h |   3 +-
>  support/nfs/exports.c      |   4 +-
>  systemd/nfs.conf.man       |  20 +++++
>  utils/exportd/exportd.c    |  42 +++++++--
>  utils/exportd/exportd.man  |  94 ++++++++++++++------
>  utils/mountd/mountd.c      |  32 ++++++-
>  utils/mountd/mountd.h      |   5 --
>  utils/mountd/mountd.man    |  98 ++++++++++++++++----
>  utils/mountd/svc_run.c     |   5 +-
>  16 files changed, 464 insertions(+), 80 deletions(-)
>  create mode 100644 support/export/v4clients.c
> 
> --
> Signature
> 

