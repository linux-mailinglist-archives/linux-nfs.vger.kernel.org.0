Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83600327675
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 04:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhCADor (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Feb 2021 22:44:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231614AbhCADoq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Feb 2021 22:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614570199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=69pCbVAtqmjLxde1g6xG0wG9+yBAtmml+sPObfAQLPA=;
        b=gd03CK9a5nm6E8X4PT7iH7sjKn5bh1m+2w1Tnh5mKH08Maz4WpEd6UM7xRJJw9SqxguUDE
        reGQ0ObliCc87+sgZj1Ig6VWnQfg3lZvv4S2hpOjVHQ61gubd5BxcKwzA2qHT0TyCsy3ii
        e/kO3qkyaBjhgv03jBpufV1XzqpjORQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-TOxz9zWbNQyGTMzoO5PCoA-1; Sun, 28 Feb 2021 22:43:18 -0500
X-MC-Unique: TOxz9zWbNQyGTMzoO5PCoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1578850740;
        Mon,  1 Mar 2021 03:43:17 +0000 (UTC)
Received: from yoyang-pc.usersys.redhat.com (unknown [10.66.61.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A52CF60636;
        Mon,  1 Mar 2021 03:43:15 +0000 (UTC)
Date:   Mon, 1 Mar 2021 11:43:12 +0800
From:   Yongcheng Yang <yoyang@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Message-ID: <20210301034312.GA12690@yoyang-pc.usersys.redhat.com>
References: <161456493684.22801.323431390819102360.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161456493684.22801.323431390819102360.stgit@noble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

Shall we further add these 2 options (cache-use-ipaddr & ttl) with
their default values to the file /etc/nfs.conf under section [mountd]?
By which the users can find it easier to configure them.

Also someone may check the mountd "Recognized values" from
nfs.conf(5), the file systemd/nfs.conf.man may also needs to be
updated mentioning "cache-use-ipaddr" and "ttl" IMHO. 

Thanks,
Yongcheng


On Mon, Mar 01, 2021 at 01:17:15PM +1100, NeilBrown wrote:
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
> NeilBrown (5):
>       mountd: reject unknown client IP when !use_ipaddr.
>       mountd: Don't proactively add export info when fh info is requested.
>       mountd: add logging for authentication results for accesses.
>       mountd: add --cache-use-ipaddr option to force use_ipaddr
>       mountd: make default ttl settable by option
> 
> 
>  support/export/auth.c      |  4 +++
>  support/export/cache.c     | 32 +++++++++++------
>  support/export/v4root.c    |  3 +-
>  support/include/exportfs.h |  3 +-
>  support/nfs/exports.c      |  4 ++-
>  utils/mountd/mountd.c      | 30 +++++++++++++++-
>  utils/mountd/mountd.man    | 70 ++++++++++++++++++++++++++++++++++++++
>  7 files changed, 131 insertions(+), 15 deletions(-)
> 
> --
> Signature
> 

