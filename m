Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F296610158
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 21:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiJ0TQH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 27 Oct 2022 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiJ0TQG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 15:16:06 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52AE5756F
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 12:16:05 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id x16so1661327ilm.5
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 12:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puH3WQXM1tpFBJQ6m4h8TSh1q45MWnD3/cfqkRxA6Ms=;
        b=5q8j8SX9HuUk4Cd1MlLPauFnAYBMzjJNlOoZ5Dei+9vUa45fEYYiJc4uBGgDrbahfK
         V/J4GA7MoyIlHZo87+m0Vu50oyTEv2gQ4WWCLTvYqKZw6XNewQrJML4m8N/GFj8Q61dV
         1mXK+pocup2DT5k/ELy5Zr6fSWhN9lQAYIjLQlw2KxoqBXvtIJofXMhJHdQyiOjG+22f
         RmnkPiMSBEL6QfpUBB+TryKsZNz6lB1BMjOS8yt+ehl77EB/9T3ZUU+iidRcK/yJMbom
         IL4xVX4GbKyCyuaeSz9ZvRxTMcoonW+xedoqv8b7xfm8Gq9l2WHr+ADpV1+o5cjAobfS
         gKnQ==
X-Gm-Message-State: ACrzQf2O13jqHDc6Y55J/Vjw09zIM01g0E8AdXUrfy1EN2E0GFPTO1Pk
        xGmC6rPO/sZi35rbz1kvlw==
X-Google-Smtp-Source: AMsMyM6V9MRlBqEVAwKOwN+1vWoFZigoYRHEkhAtsaf/E+m4OmsJr/1TbCxQz5b04McfMBefhI7AOw==
X-Received: by 2002:a05:6e02:1561:b0:300:3d37:6296 with SMTP id k1-20020a056e02156100b003003d376296mr9566542ilu.233.1666898164756;
        Thu, 27 Oct 2022 12:16:04 -0700 (PDT)
Received: from [192.168.75.138] (50-36-85-28.alma.mi.frontiernet.net. [50.36.85.28])
        by smtp.gmail.com with ESMTPSA id p13-20020a92da4d000000b002eb5eb4f8f9sm816570ilq.77.2022.10.27.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:16:04 -0700 (PDT)
Message-ID: <870684b35a45b94c426554a62b63f80f421dbb08.camel@kernel.org>
Subject: Re: [PATCH v9 3/5] NFS: Convert buffered read paths to use netfs
 when fscache is enabled
From:   Trond Myklebust <trondmy@kernel.org>
To:     Dave Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Date:   Thu, 27 Oct 2022 15:16:03 -0400
In-Reply-To: <20221017105212.77588-4-dwysocha@redhat.com>
References: <20221017105212.77588-1-dwysocha@redhat.com>
         <20221017105212.77588-4-dwysocha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-17 at 06:52 -0400, Dave Wysochanski wrote:
> Convert the NFS buffered read code paths to corresponding netfs APIs,
> but only when fscache is configured and enabled.
> 
> The netfs API defines struct netfs_request_ops which must be filled
> in by the network filesystem.  For NFS, we only need to define 5 of
> the functions, the main one being the issue_read() function.
> The issue_read() function is called by the netfs layer when a read
> cannot be fulfilled locally, and must be sent to the server (either
> the cache is not active, or it is active but the data is not
> available).
> Once the read from the server is complete, netfs requires a call to
> netfs_subreq_terminated() which conveys either how many bytes were
> read
> successfully, or an error.  Note that issue_read() is called with a
> structure, netfs_io_subrequest, which defines the IO requested, and
> contains a start and a length (both in bytes), and assumes the
> underlying
> netfs will return a either an error on the whole region, or the
> number
> of bytes successfully read.
> 
> The NFS IO path is page based and the main APIs are the pgio APIs
> defined
> in pagelist.c.  For the pgio APIs, there is no way for the caller to
> know how many RPCs will be sent and how the pages will be broken up
> into underlying RPCs, each of which will have their own completion
> and
> return code.  In contrast, netfs is subrequest based, a single
> subrequest may contain multiple pages, and a single subrequest is
> initiated with issue_read() and terminated with
> netfs_subreq_terminated().
> Thus, to utilze the netfs APIs, NFS needs some way to accommodate
> the netfs API requirement on the single response to the whole
> subrequest, while also minimizing disruptive changes to the NFS
> pgio layer.
> 
> The approach taken with this patch is to allocate a small structure
> for each nfs_netfs_issue_read() call, store the final error and
> number
> of bytes successfully transferred in the structure, and update these
> values
> as each RPC completes.  The refcount on the structure is used as a
> marker
> for the last RPC completion, is incremented in
> nfs_netfs_read_initiate(),
> and decremented inside nfs_netfs_read_completion(), when a
> nfs_pgio_header
> contains a valid pointer to the data.  On the final put (which
> signals
> the final outstanding RPC is complete) in
> nfs_netfs_read_completion(),
> call netfs_subreq_terminated() with either the final error value (if
> one or more READs complete with an error) or the number of bytes
> successfully transferred (if all RPCs complete successfully).  Note
> that when all RPCs complete successfully, the number of bytes
> transferred
> is capped to the length of the subrequest.  Capping the transferred
> length
> to the subrequest length prevents "Subreq overread" warnings from
> netfs.
> This is due to the "aligned_len" in nfs_pageio_add_page(), and the
> corner case where NFS requests a full page at the end of the file,
> even when i_size reflects only a partial page (NFS overread).
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


This is not doing what I asked for, which was to separate out the
fscache functionality, so that we can call that if and when it is
available.

Instead, it is just wrapping the NFS requests inside netfs requests. As
it stands, that means it is just duplicating information, and adding
unnecessary overhead to the standard I/O path (extra allocations, extra
indirect calls, and extra bloat to the inode).

My expectation is that the standard I/O path should have minimal
overhead, and should certainly not increase the overhead that we
already have. Will this be addressed in future iterations of these
patches?

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


