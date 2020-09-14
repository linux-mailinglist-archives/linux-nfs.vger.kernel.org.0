Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4D2694E7
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Sep 2020 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgINSbq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Sep 2020 14:31:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44361 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgINSbn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Sep 2020 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600108301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pIFnuPDlG5hszC4H8lhN5Q+Zuo/8/QCGJAcqf/vsv2U=;
        b=Xd8F8PoJMXgYMiDOlUaVMoS3FwxVoJqN12lEzuTJpy0hKr7EpujvV5IbTcjPBVyz037cuN
        kpAbkMSyQoG0UBv7I/uVpm1jUigHrpkEbKYuXwBXX22A6RaJncF23rRzst/Ng7vEhNYQi3
        IcdxQ8IPpkRPikCMcb2fLDi4RyP6uYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-yipqUDPKPnGwqI7Oz7NTsQ-1; Mon, 14 Sep 2020 14:31:39 -0400
X-MC-Unique: yipqUDPKPnGwqI7Oz7NTsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C190EA1C9;
        Mon, 14 Sep 2020 18:30:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-247.phx2.redhat.com [10.3.112.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A879827BCC;
        Mon, 14 Sep 2020 18:30:35 +0000 (UTC)
Subject: Re: mount.nfs4 and logging
To:     Chris Hall <linux-nfs@gmch.uk>, linux-nfs@vger.kernel.org
References: <S1725851AbgIKKt5/20200911104957Z+185@vger.kernel.org>
 <a38a1249-c570-9069-a498-5e17d85a418a@gmch.uk>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <f06f86ef-08bd-3974-3d92-1fbda700cc11@RedHat.com>
Date:   Mon, 14 Sep 2020 14:30:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a38a1249-c570-9069-a498-5e17d85a418a@gmch.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 9/11/20 7:45 AM, Chris Hall wrote:
> 
> I have a client and server configured for nfs4 only.
Would you mind sharing this configuration? Privately if
that works better... 

I'm thinking that is a good direction to go towards
so maybe we make this configuration the default?? 

> 
> The configuration used to work.
> 
> I have just upgraded from Fedora 31 to 32 on the client.  I now get:
> 
>   # mount /foo
>   mount.nfs4: Protocol not supported
I've been trying to keep the versions the same... hopefully 
nothing has broken in f31... ;-( 

> 
> Wireshark does not detect any attempt by the client to talk to the server.
> 
> I get the same result if I do mount.nfs4 directly.
> 
> Can I wind up the logging for mount.nfs4 ?  
What server are you using?

> Or otherwise find a way to discover why the "Protocol not supported" message is being issued ?
Does rpcdebug -m nfs -s mount and mount -vvv show anything?

steved.

