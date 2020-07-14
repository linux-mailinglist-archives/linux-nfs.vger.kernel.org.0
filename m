Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5521F998
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2020 20:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgGNSis (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jul 2020 14:38:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50855 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728836AbgGNSis (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jul 2020 14:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594751926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqJAsGMMhscFeAJzIBlk2OQWpQKe3A8cSq3TrB1WQ70=;
        b=XbTTpSjuz9Lypaot1/wzS/dVlOPeZyJ4DQ6eyyyJEAkMHUM4IcaRMGMBFESagXWZRItJe3
        /nWQM54vJVK3ynhivKUUhpF1cnObYkGdS6fkNNpBNz9DgGIaM3eQhnbJTMy+F5mSQgVWNK
        nhehvIFkD2B3CBdqvkGvZ9EVETEvQRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-0H63sBauMFKuimEZ29bK5w-1; Tue, 14 Jul 2020 14:38:21 -0400
X-MC-Unique: 0H63sBauMFKuimEZ29bK5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A5B800C64;
        Tue, 14 Jul 2020 18:38:20 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-217.phx2.redhat.com [10.3.112.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EE3A10013C1;
        Tue, 14 Jul 2020 18:38:20 +0000 (UTC)
Subject: Re: [PATCH 00/10] Misc fixes & cleanups for nfs-utils
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200701182803.14947-1-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c1b8566f-064e-c063-2a6d-94d4bd92709f@RedHat.com>
Date:   Tue, 14 Jul 2020 14:38:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701182803.14947-1-nazard@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Doug,

On 7/1/20 2:27 PM, Doug Nazar wrote:
> Most of this work centers around gssd, however a few items I did tree
> wide. It's been compile tested with both gcc & clang on x86_64 & arm32
> and runtime tested on x86_64.
> 
> 
> Doug Nazar (10):
>   gssd: Refcount struct clnt_info to protect multithread usage
>   Update to libevent 2.x apis.
>   gssd: Cleanup on exit to support valgrind.
>   gssd: gssd_k5_err_msg() returns a strdup'd msg. Use free() to release.
>   gssd: Fix locking for machine principal list
>   gssd: Add a few debug statements to help track client_info lifetimes.
>   gssd: Lookup local hostname when srchost is '*'
>   gssd: We never use the nocache param of gssd_check_if_cc_exists()
>   Fix various clang warnings.
I did commit all of the above... (tag: nfs-utils-2-5-2-rc1)

I did not commit the following 
   Cleanup printf format attribute handling and fix format strings

because 3 different version were posted 

Cleanup printf format attribute handling and fix various format strings
Cleanup printf format attribute handling and fix format strings
Consolidate printf format attribute handling and fix various format strings

I was not sure which one you wanted and I was wondering what exactly is
being cleaned up? What problems is this solving?

Finally, being this is a whole tree commit and I have a number
of patches in the queue.. I would like to hold off on this one.

A patch like this will cause all those patches in the queue 
not to apply... So once I drain the queue, hopefully you
would not mind rebasing... after we talk about what you 
are trying to do.

I do appreciate the hard work... esp with gssd... I did test
it every step of the way... and it seems to be fairly 
solid... nice work!

steved.
 
> 
>  aclocal/libevent.m4                |   6 +-
>  configure.ac                       |   6 +-
>  support/include/compiler.h         |  14 +
>  support/include/xcommon.h          |  12 +-
>  support/include/xlog.h             |  20 +-
>  support/nfs/xcommon.c              |   2 +
>  support/nfsidmap/gums.c            |   2 +
>  support/nfsidmap/libnfsidmap.c     |   8 +-
>  support/nfsidmap/nfsidmap.h        |  10 +-
>  support/nfsidmap/nfsidmap_common.c |   1 +
>  support/nfsidmap/nss.c             |   4 +-
>  support/nfsidmap/regex.c           |   6 +-
>  support/nfsidmap/static.c          |   1 +
>  support/nfsidmap/umich_ldap.c      |  10 +-
>  tools/locktest/testlk.c            |   6 +-
>  utils/exportfs/exportfs.c          |   5 +-
>  utils/gssd/err_util.h              |   4 +-
>  utils/gssd/gss_names.c             |   9 +-
>  utils/gssd/gss_util.c              |   2 +-
>  utils/gssd/gssd.c                  | 165 ++++++++---
>  utils/gssd/gssd.h                  |  10 +-
>  utils/gssd/gssd_proc.c             |  14 +-
>  utils/gssd/krb5_util.c             | 422 +++++++++++++++++------------
>  utils/gssd/krb5_util.h             |  16 +-
>  utils/gssd/svcgssd.c               |   4 +-
>  utils/gssd/svcgssd_proc.c          |   9 +-
>  utils/idmapd/idmapd.c              |  65 +++--
>  utils/mount/network.c              |   4 +-
>  utils/mount/stropts.c              |   2 -
>  utils/mountd/cache.c               |   2 +-
>  utils/nfsdcld/cld-internal.h       |   2 +-
>  utils/nfsdcld/nfsdcld.c            |  29 +-
>  utils/nfsdcld/sqlite.c             |   1 -
>  utils/nfsdcltrack/sqlite.c         |   2 +-
>  utils/nfsidmap/nfsidmap.c          |   3 +-
>  35 files changed, 536 insertions(+), 342 deletions(-)
>  create mode 100644 support/include/compiler.h
> 

