Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DDF32D7CD
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 17:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhCDQbs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 11:31:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237699AbhCDQbb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 11:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614875406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0cH0qlZyrINvH9ZjVrATSlhhGUCiQBfdluI8GVcNQLc=;
        b=OWp33X7iFJx/MoffTQ9e6SMsMX9nR8mk4eQUF9DaBOdloeHXE1PKgELBX7goL9xDqNbHlT
        ojmPCVajL8PYmDXx+kcGRIskLkuFX/EjujdoK4JTbz7YNxhG1JtZ5Gup+u3QC9nUdWr8S2
        MSPd8OuaR9kAZXjsKJuL8pEoEKQmSkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-a1ThhUwHNaSlOZBIIfkxZg-1; Thu, 04 Mar 2021 11:30:04 -0500
X-MC-Unique: a1ThhUwHNaSlOZBIIfkxZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E88657;
        Thu,  4 Mar 2021 16:30:03 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-51.phx2.redhat.com [10.3.114.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 057F839A71;
        Thu,  4 Mar 2021 16:30:02 +0000 (UTC)
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
 <d9e766cb-9af8-0c66-efb1-a3d0a291aa48@RedHat.com>
 <20210303221730.GH3949@fieldses.org>
 <80610f08-6f8d-1390-1875-068e63e744eb@RedHat.com>
 <20210304140617.GB17512@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <4204cd8e-f8c4-103e-bb69-a6bf720e65e9@RedHat.com>
Date:   Thu, 4 Mar 2021 11:31:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304140617.GB17512@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/4/21 9:06 AM, J. Bruce Fields wrote:
> On Thu, Mar 04, 2021 at 08:57:28AM -0500, Steve Dickson wrote:
>> Personally I see this is the first step away from V3... 
>>
>> So what we don't need is all that RPC code, all the different mounting
>> versions... no RPC code at all,  which also means no need for libtirpc... 
>> That is a lot of code that goes away, which I think is a good thing.
> 
> libtirpc is a shared library, it'll still be loaded as long as anyone
> needs it, and I'm not convinced we'll be able to get rid of all users.
> 
>> I never thought it was a good idea to have mountd process
>> the v4 upcalls... I always thought it should be a different
>> deamon... and now we have one.
>>
>> A simple daemon that only processes v4 upcalls.
> 
> I really do get the appeal, I've always liked the idea too.
> 
> I'm not sure it's bringing us a real practical advantage at this point,
> compared to rpc.mountd, which can act either as a daemon that only
> processes v4 upcalls or can do both, depending on how you start it.
Right with some configuration changes... But I do think there is 
value with have a package that will work right out of the box!

Boom! Install the package and you have a working v4 server
with no configure changes... I do think there is value there.

steved.

