Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CF226D20
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGTRcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 13:32:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728939AbgGTRcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 13:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595266323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G89lwT+FtkR2FETWIYkZT5O9jHSgPOzT5mGuCVXdcSQ=;
        b=atLqYd//Ut/zf4RKtf7RK00hJuGOQHR6AWstqEJWLEhyFINQ1pmhBA/cg7S4HeUz8i/0NI
        AtWKqgrQxvVq7wtAW1nyqOXYYfPrjPGqK6Jf1kxz2M8yZ/2CqleRueGE1QliW95KAuZVEe
        VMTCTtfQTP+8OUovBns22KF1hNeDfdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-gsZX07gRMy-QygHPUfzW4Q-1; Mon, 20 Jul 2020 13:31:52 -0400
X-MC-Unique: gsZX07gRMy-QygHPUfzW4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFDDD19200C0;
        Mon, 20 Jul 2020 17:31:51 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7027852C;
        Mon, 20 Jul 2020 17:31:51 +0000 (UTC)
Subject: Re: [PATCH 09/11] nfsidmap: Add support to cleanup resources on exit
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200718092421.31691-1-nazard@nazar.ca>
 <20200718092421.31691-10-nazard@nazar.ca>
 <84277cb9-03da-3065-1848-f8c1e2bee167@RedHat.com>
 <568e0535-e20c-80a9-a0c7-61b3656f997f@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <9481df67-109d-ede1-27d4-53cb66fbb528@RedHat.com>
Date:   Mon, 20 Jul 2020 13:31:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <568e0535-e20c-80a9-a0c7-61b3656f997f@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/20/20 11:58 AM, Doug Nazar wrote:
> On 2020-07-20 11:49, Steve Dickson wrote:
>>
>>> +__attribute__((destructor))
>>> +static int nss_plugin_term(void)
>>> +{
>>> +    free_local_realms();
>>> +    conf_cleanup();
>>> +    return 0;
>>> +}
>>> +
>> Just wondering... How is nss_plugin_term() called/used?
> 
> Automatically during dlclose(), see the 'Initialization and finalization functions' section of the man page. I'd originally thought to extend trans_func but didn't see an easy way to extend the api (no size or version field) without breaking any possible out of tree plugins (do they exist?).

Interesting... I think I'll add a comment explaining it... 

No..they do not exist.. The way you are going is fine... 
Less churn is good ;-) 

steved.

