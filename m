Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4139286412
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgJGQak (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 12:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbgJGQaj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 12:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602088238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnhQBerWUQ4B1SJXlk0CfeVXcWu6CUN1xfdJTyciM6A=;
        b=bjsK0aDxcdUTEr2CWSmHkoxcoH89XZYHOgoLUSlVE6W7CB/2kfm83A2ZEWXtEC7Y8FpRVy
        wcTOpsXKqzdH/VgyL7egJJ+msarbMPuNZPCGqWaKVBlk7O0rLG6L8xzNw3oJPCNz+QhFNx
        rykLjjE5hnhPw+kc0i86GxtGa+ypA2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-rfEf73lmMKCcsCcKfhFZxw-1; Wed, 07 Oct 2020 12:30:36 -0400
X-MC-Unique: rfEf73lmMKCcsCcKfhFZxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 202328797F0;
        Wed,  7 Oct 2020 16:30:35 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 964515DA76;
        Wed,  7 Oct 2020 16:30:34 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Patrick Goetz" <pgoetz@math.utexas.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org
Subject: Re: unsharing tcp connections from different NFS mounts
Date:   Wed, 07 Oct 2020 12:30:33 -0400
Message-ID: <A9A6D668-D40B-48F9-A578-E1BE1DCF25C4@redhat.com>
In-Reply-To: <df7b7b26-c6a7-9e6f-edf6-e3c858623462@math.utexas.edu>
References: <20201006151335.GB28306@fieldses.org>
 <df7b7b26-c6a7-9e6f-edf6-e3c858623462@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7 Oct 2020, at 9:56, Patrick Goetz wrote:

> On 10/6/20 10:13 AM, J. Bruce Fields wrote:
>> NFSv4.1+ differs from earlier versions in that it always performs
>> trunking discovery that results in mounts to the same server sharing a
>> TCP connection.
>>
>> It turns out this results in performance regressions for some users;
>> apparently the workload on one mount interferes with performance of
>> another mount, and they were previously able to work around the problem
>> by using different server IP addresses for the different mounts.
>>
>> Am I overlooking some hack that would reenable the previous behavior?
>> Or would people be averse to an "-o noshareconn" option?
>>
>> --b.
>>
>
>
> I don't see how sharing a TCP connection can result in a performance
> regression (the performance degradation of *not* sharing a TCP connection
> is why HTTP 1.x is being replaced), or how using different IP addresses on
> the same interface resolves anything.  Does anyone have an explanation?

Well, I think the report we're getting may be using two different network
interfaces on the server-side.  The user was previously doing one mount each
to each ip address on each interface.

Even if you don't have this arrangement, it may still be possible/desirable
to have separate TCP connections if you want to prioritizes some NFS
traffic.  Multi-CPU systems with modern NICs have a number of different ways
to "steer" the traffic they receive to certain CPUs which may have a benefit
or detrimental effect on performance.  You can prioritize wake-ups from the
NIC based on throughput or latency, for example.

I don't know for sure which of these specific details are coming into play,
if any, though.

Ben

