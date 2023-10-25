Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2937D7279
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 19:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJYRiS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 13:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjJYRiS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 13:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14348137
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698255454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCYXuE+ic68JHfPyC3JB6qdd9v4hyNArwD2Pmj+LJTw=;
        b=FlVnQX6CKsHYgfQ1hFwR44QYSMVuCf91FfjEBtIegpSdRvlWCaL//kfMH9Q28oUdzlz+Dl
        q1fAYSdqN/YF/QgQ0TCupVB/qwHX+55RIQATEsBDxT259mld5cKXWrrZjJakKBFfcNQYuF
        1efzqZIw9M/DzKvKQDhvJxu0+H2VsV8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-EovN-OqZOaCla4-UenA4oA-1; Wed, 25 Oct 2023 13:37:32 -0400
X-MC-Unique: EovN-OqZOaCla4-UenA4oA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-584102dd90bso12909eaf.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 10:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255452; x=1698860252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCYXuE+ic68JHfPyC3JB6qdd9v4hyNArwD2Pmj+LJTw=;
        b=kYrmPlZrCz+j24LJr7V28fYkwYUO7DHvcjHID3PMHtn2EyRMuEjT9MNXcZT7wDLLgC
         kq90PCs/S6YSee+dbyhlPMr1bPjXb/rFz6KjMp8fyxAttgJjyGfy7wGARRmyKrUBgRcs
         Khm58otBSbj9iYOEZepK0NtKh27T/UMopD59MHFFQu1WkN5FiIdzvWBeNA1AWYEC2YdG
         nIa+6gI0ACvZ1Mu0mZ0UnenRFdm4M9AKYCrsuQCmrgYjTv9JpIaHMpk5q7xZQk/rwMwn
         9rSq/3HlGt2K/GGRg4KpHtBU+XnScAvEMIdjD9/aUeSojSImymV77avF1FWQQODtN+rX
         3GTQ==
X-Gm-Message-State: AOJu0YzHe1Q+fsBAH0Xc7AKLF4pABPL5sXRYWPwR3XIg7x6WkB2+dtGv
        quKIGnz4Rfoa3NIweQgdVs8YJgA5wm6l/ZT9Y/dLJhT18FNjWItJv8UfBe5F8zLaT80dlFhmzN3
        U4k/LGHgqoZ1PzCwGWOJ/8pvolTXY
X-Received: by 2002:a05:6359:3209:b0:168:c1c5:2a8e with SMTP id rj9-20020a056359320900b00168c1c52a8emr10623042rwb.3.1698255451875;
        Wed, 25 Oct 2023 10:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF11cKHjbDyWrnHZLWesp+b8ALEq19SCvpEoRRvEmUuh01oXLYP3vDdgpvzOzwsrffO09c71g==
X-Received: by 2002:a05:6359:3209:b0:168:c1c5:2a8e with SMTP id rj9-20020a056359320900b00168c1c52a8emr10623032rwb.3.1698255451508;
        Wed, 25 Oct 2023 10:37:31 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:9455:9167:2a44:f7c6? (2603-6000-d605-db00-9455-9167-2a44-f7c6.res6.spectrum.com. [2603:6000:d605:db00:9455:9167:2a44:f7c6])
        by smtp.gmail.com with ESMTPSA id t16-20020a0cef10000000b0065afbb39b2dsm4548020qvr.47.2023.10.25.10.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 10:37:31 -0700 (PDT)
Message-ID: <055f76be-226f-4b15-8e7b-13f78dba10c5@redhat.com>
Date:   Wed, 25 Oct 2023 13:37:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6 nfs-utils v2] fixes for error handling in nfsd_fh
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
References: <20231023021052.5258-1-neilb@suse.de>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20231023021052.5258-1-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/22/23 9:58 PM, NeilBrown wrote:
> Hi,
>   this is a revised version of my previous series with the same name.
>   This first two patches are unchanged.
>   The third patch, which was an RFC, has been replaced with the last
>   patch which actually addresses the issue rather than skirting
>   around it.
> 
>   Patch 3 here is a revert of a change I noticed while exploring the
>   code.  cache_open() must be called BEFORE forking workers, as explained
>   in that patch.
>   Patches 4 and 5 factor our common code which makes the final patch
>   simpler.
> 
>   The core issue is that sometimes mountd (or exportd) cannot give a
>   definitey "yes" or "no" to a request to map an fsid to a path name.
>   In these cases the only safe option is to delay and try again.
> 
>   This only becomes relevant if a filesystem is mounted by a client, then
>   the server restarts (or the export cache is flushed) and the client
>   tries to use a filehandle that it already has, but that server cannot
>   find it and cannot be sure it doesn't exist.  This can happen when an
>   export is marked "mountpoint" or when a re-exported NFS filesystem
>   cannot contact the server and reports an ETIMEDOUT error.  In these
>   cases we want the client to continue waiting (which it does) and also
>   want mountd/exportd to periodically check if the target filesystem has
>   come back (which it currently does not).
>   With the current code, once this situation happens and the client is
>   waiting, the client will continue to wait indefintely even if the
>   target filesytem becomes available.  The client can only continue if
>   the NFS server is restarted or the export cache is flushed.  After the
>   ptsch, then within 2 minutes of the target filesystem becoming
>   available again, mountd will tell the kernel and when the client asks
>   again it will get be allowed to proceed.
> 
> NeilBrown
> 
> 
>   [PATCH 1/6] export: fix handling of error from match_fsid()
>   [PATCH 2/6] export: add EACCES to the list of known
>   [PATCH 3/6] export: move cache_open() before workers are forked.
>   [PATCH 4/6] Move fork_workers() and wait_for_workers() in cache.c
>   [PATCH 5/6] Share process_loop code between mountd and exportd.
>   [PATCH 6/6] cache: periodically retry requests that couldn't be
> 
Committed... (tag: nfs-utils-2-6-4-rc5)

steved.

