Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE427477B
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIVRaW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 13:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIVRaW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 13:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600795821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vUNy1+JbyuIp4pBcoWjSZAvZLwpGS6IFjEDa4YCWSBY=;
        b=X7uRkghT8Tgpt7ErxKyfAfjZ6JrJW+l0ACCFoUFmFKX96XAvZ6Z4r6a1/CKK1QCT6bFiWH
        tQjGRt/xv5/3NPG7kvBHx/C+Ccv8v/LjyMDiPF04aEwuEU8ceVXPq5VF26dez1l/QagY81
        3FazcjeAWcDxcVxV76fDLnymSuOXZs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-U9xdydiCNFCp3RpED-MW2A-1; Tue, 22 Sep 2020 13:30:18 -0400
X-MC-Unique: U9xdydiCNFCp3RpED-MW2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6484810BBECB;
        Tue, 22 Sep 2020 17:30:17 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-247.phx2.redhat.com [10.3.112.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59D2019C4F;
        Tue, 22 Sep 2020 17:30:15 +0000 (UTC)
Subject: Re: Fwd: Re: mount.nfs4 and logging
To:     Chris Hall <chris.hall@gmch.uk>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
References: <20200919214707.GC22544@fieldses.org>
 <8c44e6ce-7810-bba1-8779-127938fed1ab@gmch.uk>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <1708addb-894b-8c74-b307-991f5f435aa1@RedHat.com>
Date:   Tue, 22 Sep 2020 13:30:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8c44e6ce-7810-bba1-8779-127938fed1ab@gmch.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/20/20 6:02 AM, Chris Hall wrote:
> 
> Steve,
> 
> Forwarded to you as suggested by Bruce Fields -- see below.
Thanks... I've been watching the discussion.

Would you mind reposting the patch in the proper format
and proper  Signed-off-by tag?

steved.
> 
> Chris
> 
> 
> -------- Forwarded Message --------
> 
> On Sat, Sep 19, 2020 at 06:49:40PM +0100, Chris Hall wrote:
>> On 19/09/2020 17:33, J. Bruce Fields wrote:
>> >On Tue, Sep 15, 2020 at 02:06:23PM +0100, Chris Hall wrote:
>> >>Also FWIW, I gather that this is configuration for the client-side
>> >>'mount' of nfs exports, *only*.  I suppose it should be obvious that
>> >>this has absolutely nothing to do with configuring (server-side)
>> >>'mountd'.  Speaking as a fully paid up moron-in-a-hurry, it has
>> >>taken me a while to work that out :-(  [I suggest that the comments
>> >>in the .conf files and the man-page could say that nfs.conf is
>> >>server-side and nfsmount.conf is client-side -- just a few words,
>> >>for the avoidance of doubt.]
>> >
>> >That sounds sensible.  If you're feeling industrious, you can
>> >
>> >    git clone git://linux-nfs.org/~steved/nfs-utils
>> >
>> >and patch those files and mail us a patch....
>>
>> Enclosed are suggested updates.
> 
> Oh, great, thanks.  Steve Dickson handles these, so send it to
> steved@redhat.com, cc: linux-nfs@vger.kernel.org, and he should pick it
> up.
> 
> --b.
> 
>> Chris
> 
> 

