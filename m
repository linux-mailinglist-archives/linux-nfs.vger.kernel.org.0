Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583721CB182
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2020 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEHONo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 10:13:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44295 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726922AbgEHONn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 May 2020 10:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588947222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBA261C913vRE4UHt7DdYgrPbxXhcHtOM5dwZvu//XA=;
        b=NZd5YqoCcwJrpHyeZ2KJb3WKObBfKsHa5vpmkTG/dhgHwnFMoaI8neflT4Pvk411V5hctC
        drm+bjB6bpBz3nbTcHR4jbjziGLXYYrfJnL1xABv6lUsB1q0d7pndjf5miWX0Ok+1tHYgm
        U2d/Bt0tCIEOwMdvPjpy//uBtidMV/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-CQIfzNELOCe4lt11Xrm8uw-1; Fri, 08 May 2020 10:13:19 -0400
X-MC-Unique: CQIfzNELOCe4lt11Xrm8uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EDDC100CCD8;
        Fri,  8 May 2020 14:13:18 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A8965C1B0;
        Fri,  8 May 2020 14:13:18 +0000 (UTC)
Subject: Re: [PATCH 0/7] nfs-utils fixes
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
References: <20200416221252.82102-1-trondmy@kernel.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <b471232f-686b-2ff5-904c-c8886956d6ff@RedHat.com>
Date:   Fri, 8 May 2020 10:13:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416221252.82102-1-trondmy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/16/20 6:12 PM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> This patchset fixes a couple of missed API changes in mountd to
> ensure that the [exports]rootdir root jail works correctly. It
> fixes up the 'same_path' function, as well as 'uuid_by_path'.
> It also improves the error handling, and tries to distinguish
> between bona fide path resolution problems, and other transient
> issues in order to avoid having knfsd return spurious ESTALE
> errors.
> 
> Trond Myklebust (7):
>   mountd: Add a helper nfsd_path_statfs64() for uuid_by_path()
>   nfsd: Support running nfsd_name_to_handle_at() in the root jail
>   mountd: Fix up path checking helper same_path()
>   Fix autoconf probe for 'struct nfs_filehandle'
>   mountd: Ensure dump_to_cache() sets errno appropriately
>   mountd: Ignore transient and non-fatal filesystem errors in nfsd_fh()
>   mountd: Check the stat() return values in match_fsid()
> 
>  configure.ac                |   7 +-
>  support/include/nfsd_path.h |   9 ++
>  support/misc/nfsd_path.c    | 109 ++++++++++++++++++++++
>  utils/mountd/cache.c        | 174 ++++++++++++++++++++++++------------
>  4 files changed, 242 insertions(+), 57 deletions(-)
> 
Committed the series (tag: nfs-utils-2-4-4-rc4)

steved.

