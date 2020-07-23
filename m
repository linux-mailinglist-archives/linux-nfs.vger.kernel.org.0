Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59022B69B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jul 2020 21:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGWTQT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 15:16:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33539 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbgGWTQT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 15:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595531778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THt9ilJoYz20v5rZ7k/cVZYymF9hjGDHxFS2Sk4sUtU=;
        b=icvIF15s87SyCvWY4zkyupgej2yV9f9lhKUos8BqkGLRkpRRYNbEnFpiPAb+3f/IvyS7ns
        y8W2WxNRICWrbniNiiBxibBuQhcYj+6XDdxg7Npy1q46o6ZPTkdceyaWhYSkZpB/ijydh1
        YPUqEq0YIoL+yo8vj0WR5wIypTY9mII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-3R-Dk34LOz6dOJ0eaPt8OA-1; Thu, 23 Jul 2020 15:16:15 -0400
X-MC-Unique: 3R-Dk34LOz6dOJ0eaPt8OA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D455C100CCC2;
        Thu, 23 Jul 2020 19:16:13 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CE4D8BEDC;
        Thu, 23 Jul 2020 19:16:13 +0000 (UTC)
Subject: Re: [PATCH 2/4] idmapd: Add graceful exit and resource cleanup
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200722055354.28132-1-nazard@nazar.ca>
 <20200722055354.28132-3-nazard@nazar.ca>
 <c136e451-f10a-c3a2-7f50-12735463275f@RedHat.com>
 <5170afa5-9751-0ab6-5e93-f103857ee259@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <36cad163-448e-9018-78e8-fadb320de8a4@RedHat.com>
Date:   Thu, 23 Jul 2020 15:16:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5170afa5-9751-0ab6-5e93-f103857ee259@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/23/20 2:25 PM, Doug Nazar wrote:
> On 2020-07-23 13:56, Steve Dickson wrote:
>> @@ -290,6 +306,9 @@ main(int argc, char **argv)
>>>               serverstart = 0;
>>>       }
>>>   +    /* Not needed anymore */
>>> +    conf_cleanup();
>>> +
>> I'm a bit confused by this comment... If it is not needed why as the call added?
> 
> Sorry, I should have been a bit more verbose in the comment. I meant that we didn't need access to the config file anymore (we've already looked up everything) and can free those resources early.
> 
> Perhaps /* Config not needed anymore */ or something.
Ok.. got it... I'll make it work... 

steved.

> 
> Doug
> 

