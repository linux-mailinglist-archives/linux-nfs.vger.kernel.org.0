Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3863A185D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhFIPCV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 11:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238378AbhFIPCV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 11:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623250826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+Zwf+/c3B/K41AfhzwQXACQelqrDHkoWlCWo2Ylgyo=;
        b=eWb6hnCwMdzfeDXpF6sO1olbaqCVFUTnZCTq7MIKiGHabbhYckjy1/YSYd8P7uwf76fSQY
        wT7T5ayJctxNmhJF1owNRtXWiEqqfu6XQOsLUF5viYhqiTQ6JzIbKwuDiyZL6dd3v0OM1u
        5dm+U24UXJaASBjBAj7RgAbXtxIurN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-eJ6lviPIMnWCxcg8T7Wt7Q-1; Wed, 09 Jun 2021 11:00:24 -0400
X-MC-Unique: eJ6lviPIMnWCxcg8T7Wt7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7690919611B5;
        Wed,  9 Jun 2021 15:00:23 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDDD216558;
        Wed,  9 Jun 2021 15:00:22 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     mwakabayashi@vmware.com, linux-nfs@vger.kernel.org, aglo@umich.edu,
        SteveD@redhat.com
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Date:   Wed, 09 Jun 2021 11:00:21 -0400
Message-ID: <443A6C4D-28EC-4866-B464-6B04EAF1CF4D@redhat.com>
In-Reply-To: <752114495b47624b022bb7de366c6b1771d0599a.camel@hammerspace.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
 <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
 <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
 <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
 <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
 <FCDAEE4A-33CB-4939-8001-DAAFD7BC8638@redhat.com>
 <752114495b47624b022bb7de366c6b1771d0599a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Jun 2021, at 10:41, Trond Myklebust wrote:

> On Wed, 2021-06-09 at 10:31 -0400, Benjamin Coddington wrote:
>>
>> It's not disputed that mounts waiting on the transport layer will block
>> other mounts.
>>
>> It might be able to be changed:  there's this torch:
>> https://lore.kernel.org/linux-nfs/87378omld4.fsf@notabene.neil.brown.name/
>>
>
> No.
>
>> ..or there may be another way we don't have to wait ..
>>
>
> OK. So let's look at how we can solve the problem of the initial
> connection to the server timing out and causing hangs in
> nfs41_walk_client_list(), and leave aside any other corner case
> problems (such as the server going down while we're mounting).
>
> How about something like the following (compile tested only) patch?

It works as intended for this case, but I don't have my head wrapped around
the implications of the change yet.

Ben

