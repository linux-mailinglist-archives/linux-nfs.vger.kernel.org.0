Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4983DBBD9
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jul 2021 17:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbhG3POl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jul 2021 11:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239644AbhG3POW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jul 2021 11:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627658056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJpr8/XojV1zqSiXmDYO5Or/xGCtDfUIWstm8qPm74A=;
        b=AkS/taDcsQ15zAiqcfAhTTVIehkaWQp3+u+s0Oq8B0uyhqYS69BVEYEY8NADbTxfmVoRAw
        hPTAmTnNBkinuAgQTs1N4lYOkEm+ZcQR0VXEFSJTl6+T4/QETiksQw7eopCXy+SeVnmLT7
        zthzZUOALtmxzu4JWXTPuoihQ41rSjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-oTealJ_6NKKH0lyXEjztCA-1; Fri, 30 Jul 2021 11:14:15 -0400
X-MC-Unique: oTealJ_6NKKH0lyXEjztCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 577A9107ACF5;
        Fri, 30 Jul 2021 15:14:14 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01EC6610AE;
        Fri, 30 Jul 2021 15:14:13 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, plambri@redhat.com
Subject: Re: cto changes for v4 atomic open
Date:   Fri, 30 Jul 2021 11:14:12 -0400
Message-ID: <FCDDE052-81CE-4ACC-ABA9-9A25312BC6EE@redhat.com>
In-Reply-To: <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 30 Jul 2021, at 10:48, Trond Myklebust wrote:

> On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington wrote:
>> I have some folks unhappy about behavior changes after: 479219218fbe
>> NFS:
>> Optimise away the close-to-open GETATTR when we have NFSv4 OPEN
>>
>> Before this change, a client holding a RO open would invalidate the
>> pagecache when doing a second RW open.
>>
>> Now the client doesn't invalidate the pagecache, though technically
>> it could
>> because we see a changeattr update on the RW OPEN response.
>>
>> I feel this is a grey area in CTO if we're already holding an open. 
>> Do we
>> know how the client ought to behave in this case?  Should the
>> client's open
>> upgrade to RW invalidate the pagecache?
>>
>
> It's not a "grey area in close-to-open" at all. It is very cut and
> dried.
>
> If you need to invalidate your page cache while the file is open, then
> by definition you are in a situation where there is a write by another
> client going on while you are reading. You're clearly not doing close-
> to-open.
>
> The people who are doing this should be using uncached I/O.

Thanks Trond, that corrects my ambiguity and yes - there's a much better
way.

Ben

