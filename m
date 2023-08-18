Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C0678126A
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 19:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379167AbjHRR4J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjHRRzq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 13:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBA271B;
        Fri, 18 Aug 2023 10:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB37862952;
        Fri, 18 Aug 2023 17:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FBC433C8;
        Fri, 18 Aug 2023 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692381344;
        bh=KONQ3xcRnoS4lAb+HMyH7HyVsHgReeRIXjIT4SA1idM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LiCZSUBAW80WQNaU36+qdHOShmUA4NduLKvtU+3U3wolKrrnJP6VYMIT9f+aaMWhK
         rloZUyqzQ5lrxYiHlDnT6pwL4rsw4o2AQ1ydrgH8OW5l7WYjLE5HLxYprkfW0o+yUm
         9//vTI5ECw1kakPC+YBXBwCRn5iCMPWX/PY5QFs0=
Date:   Fri, 18 Aug 2023 10:55:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-Id: <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
In-Reply-To: <20230818041740.gonna.513-kees@kernel.org>
References: <20230818041740.gonna.513-kees@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:

> From: Elena Reshetova <elena.reshetova@intel.com>
> 
> atomic_t variables are currently used to implement reference counters
> with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
> 
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows and
> underflows. This is important since overflows and underflows can lead
> to use-after-free situation and be exploitable.

ie, if we have bugs which we have no reason to believe presently exist,
let's bloat and slow down the kernel just in case we add some in the
future?  Or something like that.  dangnabbit, that refcount_t.

x86_64 defconfig:

before:
   text	   data	    bss	    dec	    hex	filename
   3869	    552	      8	   4429	   114d	kernel/cred.o
   6140	    724	     16	   6880	   1ae0	net/sunrpc/auth.o

after:
   text	   data	    bss	    dec	    hex	filename
   4573	    552	      8	   5133	   140d	kernel/cred.o
   6236	    724	     16	   6976	   1b40	net/sunrpc/auth.o


Please explain, in a non handwavy and non cargoculty fashion why this
speed and space cost is justified.
