Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5DF2F2E
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2019 14:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfKGN0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Nov 2019 08:26:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48989 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726754AbfKGN0B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Nov 2019 08:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ojnF5Wmtkjm38OqfrsEFh3j6VVI4cE/VWMO+lteVD4=;
        b=WG209RiB+nv9xqx1KvSL69k8h/y8vJCjhhACrfMzwmNtCe+c1sFKtAJlolLmcdJBxKIOMS
        SgOGo39YUP/u5okN/Tideq8paMNmEot6HOcryCX4Bt9EbQaf38+xiWx2hPTQx3xMfAdrvE
        Nm6o621GO1RVx+hlTClCDywtTnpSqDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-xN8GVx35NfCaQCYJd4e1-g-1; Thu, 07 Nov 2019 08:25:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10DBB1005500;
        Thu,  7 Nov 2019 13:25:55 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A52E60BFB;
        Thu,  7 Nov 2019 13:25:54 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     zhangxiaoxu <zhangxiaoxu5@huawei.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS4: Fix v4.0 client state corruption when mount
Date:   Thu, 07 Nov 2019 08:25:53 -0500
Message-ID: <5CD73EBD-7D20-4DC3-A496-B870BB95638B@redhat.com>
In-Reply-To: <6348ccfd-4a61-5e82-fd2a-03b2c18fe220@huawei.com>
References: <1557115023-86769-1-git-send-email-zhangxiaoxu5@huawei.com>
 <21D6F3D9-C1B6-4F5C-98A0-87B067C6E198@redhat.com>
 <6348ccfd-4a61-5e82-fd2a-03b2c18fe220@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xN8GVx35NfCaQCYJd4e1-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Nov 2019, at 21:34, zhangxiaoxu (A) wrote:

> =E5=9C=A8 2019/11/7 0:47, Benjamin Coddington =E5=86=99=E9=81=93:
>> Hi ZhangXiaoxu,
>>
>> I'm having a bit of trouble with this fix (which went upstream in
>> f02f3755dbd14fb935d24b14650fff9ba92243b8).
>>
>> Since this change, my client calls SETCLIENTID/SETCLIENTID_CONFIRM=20
>> twice in
>> quick succession on mount, and the second SETCLIENTID_CONFIRM sent by=20
>> the state
>> manager can sometimes have the same verifier sent back by the first
>> SETCLIENTID's response.=C2=A0 I think we're missing a memory barrier=20
>> somewhere..
>
> nfs40_discover_server_trunking
> =09nfs4_proc_setclientid # the first time
> =09
> after nfs4_schedule_state_manager, the state manager:
> nfs4_run_state_manager
>   nfs4_state_manager
>     # 'nfs4_alloc_client' init state to NFS4CLNT_LEASE_EXPIRED
>     nfs4_reclaim_lease
>       nfs4_establish_lease
>         nfs4_init_clientid
>           nfs4_proc_setclientid # the second time.
>
>>
>> But, I do not understand how the client was able to corrupt the state=20
>> before
>> this patch, and I don't understand how the patch fixes state=20
>> corruption.
>>
>> Can anyone enlighten me as to how we were corrupting state here?
> when 'nfs4_alloc_client', the client state initialized with=20
> 'NFS4CLNT_LEASE_EXPIRED',
> So, we should recover it when the client init.

Why?  The commit message asserts that if we don't, there will be=20
corruption
of the client's state.   How can the client's state be corrupted?

> After the first setclientid, maybe we should clear the=20
> 'NFS4CLNT_LEASE_EXPIRED', then
> the state manager won't be called it again.

What about just never setting it in nfs4_alloc_client?  It has been set=20
there
since 286d7d6a0cb, and that commit needed it because it changed the=20
paths so
that the only way to ever send a SETCLIENTID was through state recovery.

Today, we have two paths - the trunking discovery for new clients as=20
well as
state recovery, and all new clients will go through trunking discovery.

Removing the call to kick the state manager thread will fix the problem
that the update to cl_confirm happens after the state manager has=20
already
started doing its own SETCLIENTID dance.

Ben

