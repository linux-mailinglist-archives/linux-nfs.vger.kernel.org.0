Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17839327F
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhE0Pf3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 11:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236083AbhE0Pf3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 11:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622129635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNBropPhQuRfOFrUpZKcbDIjah61wJb8ro7FWpiaGbY=;
        b=PMSNCIjs/An8n1UetscK/nsatJ8MVlAR1g4+I4/6vyab5mVq5MnB77owDGInn+vuWVixNF
        QkpaeuB07y6jUtKXFhk6n/Zsn95MZrzkBjsasenFfYufOx5b6ztzH8GsL2DbPHhHvY8UDB
        WgN05dIUdDoIb+45N3jN0H6TJhKUTl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-DERMI5MZPKuVkLSs7E7rmw-1; Thu, 27 May 2021 11:33:54 -0400
X-MC-Unique: DERMI5MZPKuVkLSs7E7rmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DBB3801AEB
        for <linux-nfs@vger.kernel.org>; Thu, 27 May 2021 15:33:53 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-214.phx2.redhat.com [10.3.112.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF52718B15;
        Thu, 27 May 2021 15:33:52 +0000 (UTC)
Subject: Re: [nfs-utils RFC PATCH 2/2] gssd: add timeout for upcall threads
From:   Steve Dickson <SteveD@RedHat.com>
To:     Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org
References: <20210525180033.200404-1-smayhew@redhat.com>
 <20210525180033.200404-3-smayhew@redhat.com>
 <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
Message-ID: <64b6f93a-e81c-fd8a-8db5-44e69004294d@RedHat.com>
Date:   Thu, 27 May 2021 11:36:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

Off-list... 

On 5/26/21 1:08 PM, Steve Dickson wrote:
>> +		free(tinfo);
>> +		return ret;
>> +	}
>> +	printerr(1, "created thread id 0x%lx\n", th);
> This will be removed... 
It turns out this tid is useful since the 
tid is used in the do_downcall() db statement. 

In general I've try to always used the function name
in the db statement so it is know where it is.
So maybe something like this:

pthread_t tid = pthread_self();

printerr(2, "start_upcall_thread(0x%lx): created thread id 0x%lx\n", tid, th);

steved.

P.S. After your final version, I'm going to follow up with a debug clean up
patch... So I can take care of it there... if you like.

