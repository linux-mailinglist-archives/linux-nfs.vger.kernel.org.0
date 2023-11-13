Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22A7EA0D4
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjKMQC3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 11:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKMQC2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 11:02:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE82319E
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699891300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1xMVnAPm5C2gcGs1AgScVbypv0LUVfpMmF4aWu6HkM=;
        b=Wpw6K/sZePdqGNtMuVa/OIAJ0nUWqXS7WoYZE61oneO4+wCC1kPWXodnhCp1hR7ebKWP1l
        Ws5x3nH9z2V69uJMhT7d1WdnVs4L4RgamUKFTJ47jxBqdoPnV/2SwH+O2r+LtTZ//Hnkmt
        amc5ZRb168xhkgp2YiOMFUMqIeLcAWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-jq-36HHGMjOBJkGCjodTEg-1; Mon, 13 Nov 2023 11:01:36 -0500
X-MC-Unique: jq-36HHGMjOBJkGCjodTEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80410101A529;
        Mon, 13 Nov 2023 16:01:36 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC240492BFE;
        Mon, 13 Nov 2023 16:01:35 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: nfs4_renew_state hogged CPU ... consider switching to WQ_UNBOUND
Date:   Mon, 13 Nov 2023 11:01:34 -0500
Message-ID: <27218491-34C4-4241-832A-ECC7F37C4CAE@redhat.com>
In-Reply-To: <CAK-6q+iiPxnBwWGhHPqPoNQ2Gahc2QvNFLDw7siEtVjKo98g6g@mail.gmail.com>
References: <CAK-6q+iiPxnBwWGhHPqPoNQ2Gahc2QvNFLDw7siEtVjKo98g6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Nov 2023, at 9:52, Alexander Aring wrote:

> Hi nfs people,
>
> I use in my "fragile" kernel hacking development setup a nfsroot
> setup. I accidently turned on the kernel config
> CONFIG_WQ_CPU_INTENSIVE_REPORT. Now, sometimes I get:
>
> workqueue: nfs4_renew_state hogged CPU for >10000us 16 times, consider
> switching to WQ_UNBOUND
>
> and I just want to drop this mail so that nfs people are aware of
> this. I am not sure if nfs4_renew_state can be easily switched to
> WQ_UNBOUND and it really makes sense to do it.
>
> I also don't do any specific workload on nfs, as I mentioned I use it
> for nfsroot and I get several of those messages over time. I used nfs
> version 4.0 and those messages showed up. Jeff told me to switch to
> 4.2 and try it again, but I still get those messages.
>
> So here is my mail to start some kind of discussion about it. :)

This is the lease-maintenance function for v4.0.  By the way, v4.0 has
problems that are easily fixed by using v4.1.  Maybe we can start by trying
to figure out where nfs4_renew_state() is taking so much time.  You can do
that with the function_grapher:

# echo nfs4_renew_state > /sys/kernel/debug/tracing/set_graph_function
# echo 3 > /sys/kernel/debug/tracing/max_graph_depth
# echo function_graph > /sys/kernel/debug/tracing/current_tracer

Wait one lease period (the default is 90 seconds), then

cat /sys/kernel/debug/tracing/trace

...

Cleanup those settings like this:

# echo nop > /sys/kernel/debug/tracing/current_tracer
# > /sys/kernel/debug/tracing/set_graph_function
# echo 0 > /sys/kernel/debug/tracing/max_graph_depth

My nfs4_renew_state() takes about 180us:

    # tracer: function_graph
    #
    # CPU  DURATION                  FUNCTION CALLS
    # |     |   |                     |   |   |   |
     1) ! 135.125 us  |  nfs4_renew_state [nfsv4]();
     4)               |  /* xprt_lookup_rqst: peer=[::1]:2049 xid=0x12cde0fc status=0 */
     ------------------------------------------
     4) kworker-176058 => kworker-176218
     ------------------------------------------

     4)               |  nfs4_renew_state [nfsv4]() {
     4)               |    nfs_delegations_present [nfsv4]() {
     4)   0.792 us    |      __rcu_read_lock();
     4)   0.500 us    |      __rcu_read_unlock();
     4)   5.834 us    |    }
     4)               |    nfs4_get_renew_cred [nfsv4]() {
     4)   3.709 us    |      nfs4_get_machine_cred [nfsv4]();
     4)   5.000 us    |    }
     4)               |    nfs4_proc_async_renew [nfsv4]() {
     4) + 27.167 us   |      kmalloc_trace();
     4) + 97.167 us   |      rpc_call_async [sunrpc]();
     4) ! 151.375 us  |    }
     4)               |    nfs_expire_unreferenced_delegations [nfsv4]() {
     4)   0.458 us    |      __rcu_read_lock();
     4)   0.542 us    |      __rcu_read_unlock();
     4)   2.541 us    |    }
     4) ! 178.792 us  |  }
     ------------------------------------------
     4) kworker-176218 => kworker-175836
     ------------------------------------------

Ben

