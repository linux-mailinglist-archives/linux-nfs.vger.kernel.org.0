Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FC6C3FB8
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 20:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfJASV1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 14:21:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3743 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfJASV1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Oct 2019 14:21:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1190130A04E3;
        Tue,  1 Oct 2019 18:21:27 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 907AC5D6D0;
        Tue,  1 Oct 2019 18:21:26 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "James Harvey" <jamespharvey20@gmail.com>,
        "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: 5.3.0 Regression: rpc.nfsd v4 uninterruptible sleep for 5+
 minutes w/o rpc-statd/etc
Date:   Tue, 01 Oct 2019 14:21:26 -0400
Message-ID: <720574D9-90C7-4A79-8DA6-9A683CFD98CB@redhat.com>
In-Reply-To: <CA+X5Wn60sGi+za48Lj-y1fcHHw7kdzEUsw8nj+Xc0U90mONz5w@mail.gmail.com>
References: <CA+X5Wn60sGi+za48Lj-y1fcHHw7kdzEUsw8nj+Xc0U90mONz5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 01 Oct 2019 18:21:27 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 19 Sep 2019, at 9:00, James Harvey wrote:

> For a really long time (years?) if you forced NFS v4 only, you could
> mask a lot of unnecessary services.
>
> In /etc/nfs.conf, in "[nfsd] I've been able to set "vers3=n", and then
> mask the following services:
> * gssproxy
> * nfs-blkmap
> * rpc-statd
> * rpcbind (service & socket)
>
> Upgrading from 5.2.14 to 5.3.0, nfs-server.service (rpc.nfsd) has
> exactly a 5 minute delay, and sometimes longer.

A bisect ends on:
4f8943f80883 SUNRPC: Replace direct task wakeups from softirq context

That commit changed the way we pull the error from the socket, previously
we'd wake the task with whatever error is in sk_err from xs_error_report(),
but now we use SO_ERROR - but that's only after possibly running through
xs_wake_disconnect which forces a closure which can change sk_err.

So, I think xs_error_report sees ECONNREFUSED, but we wake tasks with
ENOTCONN, and the client machine spins us back around again to reconnect, we
do this until things time out.

I'll send a patch to revert to the previous behavior of waking tasks with
the error as it was in xs_error_report by copying it over to the sock_xprt
struct and waking the tasks with that value.

There's another subtle change here besides that race: SO_ERROR can return
the socket's soft error, not just what's in sk_err.  That can be fun things
like EINVAL if routing lookups fail..

Ben
