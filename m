Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09C22F2D3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jul 2020 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgG0Om1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jul 2020 10:42:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732988AbgG0Om0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jul 2020 10:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595860944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5E+TwlZNfMtr+pjkJHwdP3PCqruXLfooHt1n3r5Kfw=;
        b=K+cXwkzurm8JqVr0YEi2gZhMTBI3s7GtzWFBMi+58AWbantQ3L50y/RiWiPEZ4tPMgAQ5w
        qK1h1ewG+Tj7jzGnHZjjMgnkItWaQnrEIV0/s2erMrdeWszLyQnKYy3Hw1QzO3FHX+bTMI
        E6xkLXPgqUT1OAN9trhGXaKVzKJ0G1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-NW7gvkwsOTi5Ol2tkKUWdw-1; Mon, 27 Jul 2020 10:42:20 -0400
X-MC-Unique: NW7gvkwsOTi5Ol2tkKUWdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCA5A1DE1;
        Mon, 27 Jul 2020 14:42:18 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 751B671D0C;
        Mon, 27 Jul 2020 14:42:18 +0000 (UTC)
Subject: Re: [PATCH 00/11] nfs-utils: Misc cleanups & fixes
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200718092421.31691-1-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <97b56c7e-87fd-e045-3a89-6780ed9f0050@RedHat.com>
Date:   Mon, 27 Jul 2020 10:42:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200718092421.31691-1-nazard@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/18/20 5:24 AM, Doug Nazar wrote:
> Again, here are various cleanups and fixes. Nothing too major, although
> a couple valgrind finds.
> 
> I've left out the printf patch for now, pending further discussion.
> 
> Thanks,
> Doug
> 
> 
> Doug Nazar (11):
>   Add error handling to libevent allocations.
>   gssd: Fix cccache buffer size
>   gssd: Fix handling of failed allocations
>   gssd: srchost should never be *
>   xlog: Reorganize xlog_backend() to work around -Wmaybe-uninitialized
>   nfsdcld: Add graceful exit handling and resource cleanup
>   nfsdcld: Don't copy more data than exists in column
>   svcgssd: Convert to using libevent
>   nfsidmap: Add support to cleanup resources on exit
>   svcgssd: Cleanup global resources on exit
>   svcgssd: Wait for nullrpc channel if not available
Series committed... (tag: nfs-utils-2-5-2-rc3)

steved.
> 
>  support/nfs/xlog.c                  |  41 ++++----
>  support/nfsidmap/libnfsidmap.c      |  13 +++
>  support/nfsidmap/nfsidmap.h         |   1 +
>  support/nfsidmap/nfsidmap_common.c  |  11 ++-
>  support/nfsidmap/nfsidmap_private.h |   1 +
>  support/nfsidmap/nss.c              |   8 ++
>  utils/gssd/Makefile.am              |   2 +-
>  utils/gssd/gss_names.c              |   6 +-
>  utils/gssd/gss_util.c               |   6 ++
>  utils/gssd/gss_util.h               |   1 +
>  utils/gssd/gssd.c                   |  37 +++++--
>  utils/gssd/krb5_util.c              |  12 +--
>  utils/gssd/svcgssd.c                | 143 ++++++++++++++++++++++++++--
>  utils/gssd/svcgssd.h                |   3 +-
>  utils/gssd/svcgssd_krb5.c           |  21 ++--
>  utils/gssd/svcgssd_krb5.h           |   1 +
>  utils/gssd/svcgssd_main_loop.c      |  94 ------------------
>  utils/gssd/svcgssd_proc.c           |  15 +--
>  utils/idmapd/idmapd.c               |  32 +++++++
>  utils/nfsdcld/nfsdcld.c             |  50 +++++++++-
>  utils/nfsdcld/sqlite.c              |  33 +++++--
>  utils/nfsdcld/sqlite.h              |   1 +
>  22 files changed, 358 insertions(+), 174 deletions(-)
>  delete mode 100644 utils/gssd/svcgssd_main_loop.c
> 

