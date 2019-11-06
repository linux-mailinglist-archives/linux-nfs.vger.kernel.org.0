Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98684F1B8E
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2019 17:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfKFQrJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Nov 2019 11:47:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20729 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728448AbfKFQrJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Nov 2019 11:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573058827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kd2AUtz6Mw6wE88H7EYscF3AnJiRbzza3MKq+TdwsrY=;
        b=VJbt28mphGJQUkAwDCVcEmSLsJBPa+jxu2IzmKE0XT3Zkdvn5MePS9/7eCwNt0lH0IOWhg
        mCJ3D4R1HEG8/qQFSif/LNb5dDXfmenAVKtcqidTCgIUmSmD+IoIHs/9DTgt/yNZNIhb0x
        dC0dllrNpjcM8U4DH6aQsDHuAvuVmNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-mfFfu0brPZWUjuDtPxrx4Q-1; Wed, 06 Nov 2019 11:47:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69EB48017DD;
        Wed,  6 Nov 2019 16:47:04 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC36B5D726;
        Wed,  6 Nov 2019 16:47:03 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS4: Fix v4.0 client state corruption when mount
Date:   Wed, 06 Nov 2019 11:47:02 -0500
Message-ID: <21D6F3D9-C1B6-4F5C-98A0-87B067C6E198@redhat.com>
In-Reply-To: <1557115023-86769-1-git-send-email-zhangxiaoxu5@huawei.com>
References: <1557115023-86769-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mfFfu0brPZWUjuDtPxrx4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; format=flowed; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi ZhangXiaoxu,

I'm having a bit of trouble with this fix (which went upstream in
f02f3755dbd14fb935d24b14650fff9ba92243b8).

Since this change, my client calls SETCLIENTID/SETCLIENTID_CONFIRM twice=20
in
quick succession on mount, and the second SETCLIENTID_CONFIRM sent by=20
the state
manager can sometimes have the same verifier sent back by the first
SETCLIENTID's response.  I think we're missing a memory barrier=20
somewhere..

But, I do not understand how the client was able to corrupt the state=20
before
this patch, and I don't understand how the patch fixes state corruption.

Can anyone enlighten me as to how we were corrupting state here?

Ben

On 5 May 2019, at 23:57, ZhangXiaoxu wrote:

> stat command with soft mount never return after server is stopped.
>
> When alloc a new client, the state of the client will be set to
> NFS4CLNT_LEASE_EXPIRED.
>
> When the server is stopped, the state manager will work, and accord
> the state to recover. But the state is NFS4CLNT_LEASE_EXPIRED, it
> will drain the slot table and lead other task to wait queue, until
> the client recovered. Then the stat command is hung.
>
> When discover server trunking, the client will renew the lease,
> but check the client state, it lead the client state corruption.
>
> So, we need to call state manager to recover it when detect server
> ip trunking.
>
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  fs/nfs/nfs4state.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 3de3647..f502f1c 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -159,6 +159,10 @@ int nfs40_discover_server_trunking(struct=20
> nfs_client *clp,
>  =09=09/* Sustain the lease, even if it's empty.  If the clientid4
>  =09=09 * goes stale it's of no use for trunking discovery. */
>  =09=09nfs4_schedule_state_renewal(*result);
> +
> +=09=09/* If the client state need to recover, do it. */
> +=09=09if (clp->cl_state)
> +=09=09=09nfs4_schedule_state_manager(clp);
>  =09}
>  out:
>  =09return status;
> --=20
> 2.7.4

