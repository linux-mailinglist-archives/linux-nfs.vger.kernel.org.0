Return-Path: <linux-nfs+bounces-10895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E4A7146C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 11:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D07166197
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBDE1B042E;
	Wed, 26 Mar 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFxYf0M8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE141A0BCA
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983636; cv=none; b=e2LOWXN4Rx6qJy5OCNUGoiCO0ahNbiEZeErksFF7Nd3z7trF0gwbcZ5eUwA+dP3m5H/uQM7NN4roU/sjZWwaBwalDD7MgZWAfbeBVq4aAO4pijR3EyIyDHp+9gTrQ6rpYWfiP49lCeGnZ6afwQ5/OWONuC9qITqjxOH3IhtcJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983636; c=relaxed/simple;
	bh=/VapL1+vIV+KxMPz0ZaWPdeFHH2Qq+MlYTeVxAkFGmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dd6tnKVqiHYemYfVFVdSEpIVGyc8s6STSxf/iVSaAKIJ6cf913ixSexO74G9Jdkk32acSgjw6zxM8j9iUQF91ffuwyaWFw3R9sUsonDIDf9urEuo+3k2/Z7jtXOZenJxsPBLIWPNGXWzClhVA9zlNZV842pcW9z88J2jQW3P/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFxYf0M8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742983633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0/nnBcdwLIGPloemFcmzQdIty3A+vmUU3khF4MqGUE=;
	b=FFxYf0M8yCvIb84zTc8sY4sDsBJRAUpsQC/8/QcLsIK9IufYTDMPzYDuPeRMUdEbxo31ga
	YHGaynboUgJQexNqAwMotWb8Jq1J9xJy250UecUxqVQevih/eyUkE3W33Z6pZJvA5H+/aC
	rmAx7C9akPBeFDXVbtIR0lvQwtWVgVk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-5A8puy1-P-KCnnAmjrCW_Q-1; Wed,
 26 Mar 2025 06:07:09 -0400
X-MC-Unique: 5A8puy1-P-KCnnAmjrCW_Q-1
X-Mimecast-MFC-AGG-ID: 5A8puy1-P-KCnnAmjrCW_Q_1742983628
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90D9F1801A12;
	Wed, 26 Mar 2025 10:07:08 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80C91180B489;
	Wed, 26 Mar 2025 10:07:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 3/6] NFS: Shut down the nfs_client only after all the
 superblocks
Date: Wed, 26 Mar 2025 06:07:05 -0400
Message-ID: <A16C8187-BA57-4F61-B95F-1A06EE5485D3@redhat.com>
In-Reply-To: <0a100472e4413afe3de584ee384591c5dabe56bb.camel@kernel.org>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
 <1cefd7cbadf0eaec5bae66e0870cdb89c7120070.1742941932.git.trond.myklebust@hammerspace.com>
 <ecccbc8fca9b057d018bb68acedfb47a6cf76550.camel@kernel.org>
 <0a100472e4413afe3de584ee384591c5dabe56bb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 25 Mar 2025, at 20:37, Trond Myklebust wrote:

> On Tue, 2025-03-25 at 20:15 -0400, Jeff Layton wrote:
>> On Tue, 2025-03-25 at 18:35 -0400, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> The nfs_client manages state for all the superblocks in the
>>> "cl_superblocks" list, so it must not be shut down until all of
>>> them are
>>> gone.
>>>
>>> Fixes: 7d3e26a054c8 ("NFS: Cancel all existing RPC tasks when
>>> shutdown")
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>>  fs/nfs/sysfs.c | 22 +++++++++++++++++++++-
>>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
>>> index b30401b2c939..37cb2b776435 100644
>>> --- a/fs/nfs/sysfs.c
>>> +++ b/fs/nfs/sysfs.c
>>> @@ -14,6 +14,7 @@
>>>  #include <linux/rcupdate.h>
>>>  #include <linux/lockd/lockd.h>
>>>  
>>> +#include "internal.h"
>>>  #include "nfs4_fs.h"
>>>  #include "netns.h"
>>>  #include "sysfs.h"
>>> @@ -228,6 +229,25 @@ static void shutdown_client(struct rpc_clnt
>>> *clnt)
>>>  	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
>>>  }
>>>  
>>> +/*
>>> + * Shut down the nfs_client only once all the superblocks
>>> + * have been shut down.
>>> + */
>>> +static void shutdown_nfs_client(struct nfs_client *clp)
>>> +{
>>> +	struct nfs_server *server;
>>> +	rcu_read_lock();
>>> +	list_for_each_entry_rcu(server, &clp->cl_superblocks,
>>> client_link) {
>>> +		if (!(server->flags & NFS_MOUNT_SHUTDOWN)) {
>>> +			rcu_read_unlock();
>>> +			return;
>>> +		}
>>> +	}
>>> +	rcu_read_unlock();
>>> +	nfs_mark_client_ready(clp, -EIO);
>>> +	shutdown_client(clp->cl_rpcclient);
>>> +}
>>> +
>>
>> Isn't the upshot of this that a mount won't actually get shutdown
>> until
>> you shutdown all of the mounts to the same server? Personally, I find
>> that acceptable, but we should note that it is a change in behavior.
>
> It means that the other mounts to the same server won't inevitably and
> irrevocably lock up. I'm unhappy that I missed this bug when I applied
> the patch, but that's not a reason to not fix it.
>
> As I said in the above changelog, the nfs_client's RPC client is there
> to manage state for all mounts to the same server in the same network
> namespace. If you shut down that client while there are still mounts
> that depend on it, then not only have you shot yourself in the foot,
> but you're going to spend a lot of electrons to just loop madly when
> those other mounts need to recover state but can't because you've
> permanently shut down the only way for recovery threads to communicate
> with the server.

The only use for shutdown so far had been when the server is permanently
unavailable, so breaking mounts to the same server didn't matter.  I agree
this fix is the right thing to do now.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


