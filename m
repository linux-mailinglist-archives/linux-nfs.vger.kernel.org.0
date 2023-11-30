Return-Path: <linux-nfs+bounces-208-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A10F7FF1CB
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F9B2825FC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30251013;
	Thu, 30 Nov 2023 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB/Fi7lu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F14196
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701354655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eH1uAsr5gAnwGewp1TOhwVdbzJf7CgIkTtIcj/A2xpU=;
	b=VB/Fi7luZ8HbnQBgcSAinmQ/9IBByIMtqsiHAN4wnjmWY3BNu5U5eJWKcvt7XtO6KVNqHU
	85csosSaggFyLGsCOr1jvPyCXUtuNfASd8jMqzu/vnQxsDz5uraI3/wEOGoBC3ElNTXypP
	DAll3PxKiKbFPYmeIUmnCpJslPK4TmA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-AD48WHvFNquUIaEMxfI6tw-1; Thu,
 30 Nov 2023 09:30:54 -0500
X-MC-Unique: AD48WHvFNquUIaEMxfI6tw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03BDC29ABA04;
	Thu, 30 Nov 2023 14:30:54 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FFB7492BFE;
	Thu, 30 Nov 2023 14:30:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Date: Thu, 30 Nov 2023 09:30:52 -0500
Message-ID: <8FDECCA5-80E0-4CB4-B790-4039102916F0@redhat.com>
In-Reply-To: <20231129132034.lz3hag5xy2oaojwq@gmail.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
 <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
 <20231129132034.lz3hag5xy2oaojwq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 29 Nov 2023, at 8:20, Dan Aloni wrote:

> On 2023-11-07 08:46:54, Benjamin Coddington wrote:
>> Hi Dan,
>>
>> On 5 Nov 2023, at 10:48, Dan Aloni wrote:
>>
>>> Hi,
>>>
>>> On Linux v6.6-14500-g1c41041124bd, I added a sysfs file for debugging
>>> `/sys/kernel/debug/sunrpc/rpc_clnt/*/info`, and noticed that when
>>> passing the following mount options: `soft,timeo=50,retrans=16,vers=3`,
>>> NFSACL and NSM seem to take the defaults from somewhere else (xprt).
>>> Specifically, locking operation behave as if in a hard mount with
>>> these mount options.
>>>
>>> Is it intentional?
>>
>> Yes, it usually is intentional.  The various rpc clients that make parts of
>> NFS work don't all inherit the mount flags due to reasons about how the
>> system should behave as a whole.  I think that you can find usually find the
>> reasoning the git logs around "struct rpc_create_args".
>>
>> Are you getting a system hung up in a lock operation?
>
> Actually my concern is the NFSACL prog. With `cl_softrtrt == 1` and
> `to_initval == to_maxval`, does it mean retires will not happen
> regardless of `to_retries` and `to_increment`?

Possibly?  I'm not exactly certain of what should happen in that case.

> I encountered a situation where the NFSACL program did not retry but
> could have had, whereas NFS3 did successfully. Not sure regarding NSM,
> but it seems to me that it would make sense at least for NFSACL to
> behave the same as NFS3.

I agree, but I could be missing something -- maybe its a bug.  There's the
sunrpc:rpc_timeout_status tracepoint that might be helpful.  If you turn
that up can you see rpc_check_timeout() getting called from
call_transmit_status()?

Sorry, I know this isn't a lot of help so far.

Ben


