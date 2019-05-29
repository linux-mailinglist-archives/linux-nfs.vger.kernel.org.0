Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16E32E303
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfE2RRc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 13:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2RRc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 13:17:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EA8230882BC;
        Wed, 29 May 2019 17:17:32 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04A6F7E301;
        Wed, 29 May 2019 17:17:30 +0000 (UTC)
Subject: Re: [PATCH v3 07/11] Add a helper to return the real path given an
 export entry
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
 <20190528203122.11401-8-trond.myklebust@hammerspace.com>
 <341a5328-ae6e-755d-6351-8e764d429e61@RedHat.com>
 <af2a0606934feb5313ef5e5bfe53a8e3e3c137dc.camel@hammerspace.com>
 <b207607b-2af0-c703-25d4-c85269b9db8a@RedHat.com>
 <68cc85df3db91024b97eb7564646630e7fee64f9.camel@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <790bea5a-0c0e-a2d4-cca6-4f6c4740405e@RedHat.com>
Date:   Wed, 29 May 2019 13:17:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <68cc85df3db91024b97eb7564646630e7fee64f9.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 29 May 2019 17:17:32 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/29/19 12:12 PM, Trond Myklebust wrote:
>>>> I'm not really sure why this is happening on this patch and how
>>>> I missed this in the first version.. but I'm getting the
>>>> following
>>>> linking error after applying this patch
>>>>
>>>> /usr/bin/ld: ../../support/misc/libmisc.a(workqueue.o): in
>>>> function
>>>> `xthread_workqueue_worker':
>>>> /home/src/up/nfs-utils/support/misc/workqueue.c:133: undefined
>>>> reference to `__pthread_register_cancel'
>>>> /usr/bin/ld: /home/src/up/nfs-utils/support/misc/workqueue.c:135:
>>>> undefined reference to `__pthread_unregister_cancel'
>>>> /usr/bin/ld: ../../support/misc/libmisc.a(workqueue.o): in
>>>> function
>>>> `xthread_workqueue_alloc':
>>>> /home/src/up/nfs-utils/support/misc/workqueue.c:149: undefined
>>>> reference to `pthread_create'
>>>> collect2: error: ld returned 1 exit status
>>>>
>>>> To get things to link I need this patch
>>>>
>>> Huh, that's weird... I've been compiling this over and over and
>>> have
>>> yet to see that compile error.
FYI... It turns out enabling systemd (aka --with-systemd) cause the
error... 

steved.
