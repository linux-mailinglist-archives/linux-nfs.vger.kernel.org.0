Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBF380DAE
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhENP7n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 11:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231485AbhENP7m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 11:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621007908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36gOo3eX0E8dN0idvkT3iKZaKYtLseymasMxycOJSdA=;
        b=R2nrIN0ZQJp4lYyUAKLWOAYJrrR/pgsDfOOshO3iRvJmFw77emNK9HJwpZVJ7o/sYQ1/ZU
        TF9OxNnq1goF4xiExeJsS8rmrbD0ZQMV8wYRp7iQCw82Af7zQpbqP1nB3O3JuWF8wVdaTW
        czfuRAsRNd0zgjF1c/8Nl4+HlWEmgpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-BIN5oyoqMh6Qj6fpYEXe_g-1; Fri, 14 May 2021 11:58:26 -0400
X-MC-Unique: BIN5oyoqMh6Qj6fpYEXe_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BFBD106BB29;
        Fri, 14 May 2021 15:58:25 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D5AA61156;
        Fri, 14 May 2021 15:58:24 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Olga Kornievskaia" <olga.kornievskaia@gmail.com>
Cc:     "Dan Aloni" <dan@kernelim.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Date:   Fri, 14 May 2021 11:58:22 -0400
Message-ID: <3E3B831C-BCC3-462D-84D7-6D09E8EEDFDF@redhat.com>
In-Reply-To: <CAN-5tyF_x+6vtyEtfkUNTj1-MWqTg0RoRJvofh5nbRq-miot8g@mail.gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com>
 <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
 <CAN-5tyGe32FEeK0+bnMU16zu5Y6RkVqEey4G3VocEtx8vSQwiw@mail.gmail.com>
 <E841CE1C-041E-4E9A-B14F-925CC0A08581@redhat.com>
 <CAN-5tyF_x+6vtyEtfkUNTj1-MWqTg0RoRJvofh5nbRq-miot8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 14 May 2021, at 10:16, Olga Kornievskaia wrote:
> On Fri, May 14, 2021 at 6:17 AM Benjamin Coddington 
> <bcodding@redhat.com> wrote:
>> The information isn't lost, as the symlink points to the specific 
>> switch.
>> Not using a number in the symlink name informs that there will only 
>> be one
>> switch for each client and makes it more deterministic for users and
>> software to navigate.
>
> What will be lost is that when you look at the xprt_switches directory
> and see switch-1... switch-10 subdirectory, there is no way to tell
> which rpc client uses which switch. Because each client-1 directory
> will only have an entry saying "switch".
>
> Anyway, I submitted the new version but I think it's not as good as
> the original.

Hmm, ok - will we ever need to traverse objects in that direction 
though?
I'm thinking that operations on xprts/rpcs will always start from a 
mount
perspective from the admin, but really the root object is struct 
nfs_server,
or bdi.  I'm thinking of something like:

     /sys/fs/nfs/<bdi>/rpc_clnt -> ../../net/sunrpc/clnt-0
     /sys/fs/nfs/<bdi>/volumes
     ...

I suppose though you could have something monitoring the xprts, and upon
finding a particular state would want to navigate back up to see what 
client
is affected.  At that point you'd have to read all the symlinks for all 
the
rpc_clients.

Ben

