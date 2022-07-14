Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29065752B3
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 18:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiGNQZK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGNQZK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 12:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 004AC5A45D
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657815907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C2KMz0HBp/YOodgQwMdsqXQ3AN3U25t782UBS+1TGYg=;
        b=OPATW5Pyp44j5FW+qL72rX3M6sk0E+W75oP9hazvukHacclgqtwdoAGjRkNq4jqmg8C9F+
        kOUs21l1+rk21/jShaBJR6zLXBMZUmDjOjlHmbwuWYACCefflqyXbctA3nwkb0idfo6ZPh
        mCQAxb89VEsYFieNv4y+gnrzj5qjz88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-m6V8fAjpPCmmhK3yAgi6gw-1; Thu, 14 Jul 2022 12:25:00 -0400
X-MC-Unique: m6V8fAjpPCmmhK3yAgi6gw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52DA018E5341;
        Thu, 14 Jul 2022 16:25:00 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D8D400EA8C;
        Thu, 14 Jul 2022 16:24:59 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        trondmy@hammerspace.com
Subject: Re: [PATCH v2 00/15] RPC-with-TLS client side
Date:   Thu, 14 Jul 2022 12:24:58 -0400
Message-ID: <93D09CB1-AAE2-46A1-B001-5859E6F74F12@redhat.com>
In-Reply-To: <F713FAF6-8910-4BA2-86C6-C5B09223AC0F@oracle.com>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <c9b6787ba9154d1f4c2bf25387a35453ad20badb.camel@kernel.org>
 <F713FAF6-8910-4BA2-86C6-C5B09223AC0F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12 Jul 2022, at 9:48, Chuck Lever III wrote:

>> On Jul 12, 2022, at 8:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Mon, 2022-06-06 at 10:50 -0400, Chuck Lever wrote:
>>> Now that the initial v5.19 merge window has closed, it's time for
>>> another round of review for RPC-with-TLS support in the Linux NFS
>>> client. This is just the RPC-specific portions. The full series is
>>> available in the "topic-rpc-with-tls-upcall" branch here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>
>>> I've taken two or three steps towards implementing the architecture
>>> Trond requested during the last review. There is now a two-stage
>>> connection establishment process so that the upper level can use
>>> XPRT_CONNECTED to determine when a TLS session is ready to use.
>>> There are probably additional changes and simplifications that can
>>> be made. Please review and provide feedback.
>>>
>>> I wanted to make more progress on client-side authentication (ie,
>>> passing an x.509 cert from the client to the server) but NFSD bugs
>>> have taken all my time for the past few weeks.
>>>
>>>
>>> Changes since v1:
>>> - Rebased on v5.18
>>> - Re-ordered so generic fixes come first
>>> - Addressed some of Trond's review comments
>>>
>>> ---
>>>
>>> Chuck Lever (15):
>>>      SUNRPC: Fail faster on bad verifier
>>>      SUNRPC: Widen rpc_task::tk_flags
>>>      SUNRPC: Replace dprintk() call site in xs_data_ready
>>>      NFS: Replace fs_context-related dprintk() call sites with 
>>> tracepoints
>>>      SUNRPC: Plumb an API for setting transport layer security
>>>      SUNRPC: Trace the rpc_create_args
>>>      SUNRPC: Refactor rpc_call_null_helper()
>>>      SUNRPC: Add RPC client support for the RPC_AUTH_TLS auth flavor
>>>      SUNRPC: Ignore data_ready callbacks during TLS handshakes
>>>      SUNRPC: Capture cmsg metadata on client-side receive
>>>      SUNRPC: Add a connect worker function for TLS
>>>      SUNRPC: Add RPC-with-TLS support to xprtsock.c
>>>      SUNRPC: Add RPC-with-TLS tracepoints
>>>      NFS: Have struct nfs_client carry a TLS policy field
>>>      NFS: Add an "xprtsec=" NFS mount option
>>>
>>>
>>> fs/nfs/client.c                 |  14 ++
>>> fs/nfs/fs_context.c             |  65 +++++--
>>> fs/nfs/internal.h               |   2 +
>>> fs/nfs/nfs3client.c             |   1 +
>>> fs/nfs/nfs4client.c             |  16 +-
>>> fs/nfs/nfstrace.h               |  77 ++++++++
>>> fs/nfs/super.c                  |   7 +
>>> include/linux/nfs_fs_sb.h       |   5 +-
>>> include/linux/sunrpc/auth.h     |   1 +
>>> include/linux/sunrpc/clnt.h     |  15 +-
>>> include/linux/sunrpc/sched.h    |  32 ++--
>>> include/linux/sunrpc/xprt.h     |   2 +
>>> include/linux/sunrpc/xprtsock.h |   4 +
>>> include/net/tls.h               |   2 +
>>> include/trace/events/sunrpc.h   | 157 ++++++++++++++--
>>> net/sunrpc/Makefile             |   2 +-
>>> net/sunrpc/auth.c               |   2 +-
>>> net/sunrpc/auth_tls.c           | 120 +++++++++++++
>>> net/sunrpc/clnt.c               |  34 ++--
>>> net/sunrpc/debugfs.c            |   2 +-
>>> net/sunrpc/xprtsock.c           | 310 
>>> +++++++++++++++++++++++++++++++-
>>> 21 files changed, 805 insertions(+), 65 deletions(-)
>>> create mode 100644 net/sunrpc/auth_tls.c
>>>
>>> --
>>> Chuck Lever
>>>
>>
>> Chuck,
>>
>> How have you been testing this series? It looks like nfsd support is 
>> not
>> fully in yet, so I was wondering if you had a 3rd party server. I'd 
>> like
>> to do a little testing with this, and was wondering what I needed to
>> cobble together a test rig.
>
> Ben Coddington has an ngnix module to support RPC-with-TLS that can
> front-end a stock Linux NFSD. Rick has a FreeBSD server implementation
> of RPC-with-TLS. Rick's probably taken his server down, but Ben's
> server is still up on the bake-a-thon VPN.

That server now has a proper certificate for CN=boson.nfsv4.dev signed 
by the bakeathon CA (thanks Chuck).

I've also (finally) put the nginx module code up on github if anyone 
else wants to throw it in front of a server:
https://github.com/bcodding/nginx-rpc-tls

Ben

