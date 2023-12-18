Return-Path: <linux-nfs+bounces-696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCE6817CB3
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 22:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F233C1C21A3A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03F11DA3A;
	Mon, 18 Dec 2023 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ctm+njDw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62E6FB6
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702935803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHVJ5zrpR55h/f4c4+uxF5tJhuYM/8xsXcdIalJ9mlk=;
	b=Ctm+njDwCfShF4O1T1hwOIM/0gkIBbZ21nj5Q/FZsdur+2nOqFn/p6k5rGXJ9bb+fjdQ3g
	iR5VXnqnm9fxVQAKlISqiiJwP/Rt46vqoyyhrzUnoY1iGdUu+sP2EecgCfMt0hK2u8lQnT
	Thxs31Tz5g+O7RfjTyZh6VRWK9Q2hjw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-31nYh-qXMb-EsHPc7G-_oA-1; Mon,
 18 Dec 2023 16:43:19 -0500
X-MC-Unique: 31nYh-qXMb-EsHPc7G-_oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AC753806702;
	Mon, 18 Dec 2023 21:43:19 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 22274C15968;
	Mon, 18 Dec 2023 21:43:18 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: umount.nfs: /mnt: block devices not permitted on fs
Date: Mon, 18 Dec 2023 16:43:17 -0500
Message-ID: <F17FB28B-0A94-4595-AEC6-0C1A53BAC8B2@redhat.com>
In-Reply-To: <CANH4o6NcrFz6EKDcfq1daaSpmOuCebYA-A3u3Bk_+kPtJWBLYA@mail.gmail.com>
References: <CANH4o6OdF=hjLtZ1_jbqPjexuenYn6cSvxFrJ+BUUDQv86DRzA@mail.gmail.com>
 <CANH4o6Mu8kDvZTrssVc_Tr1CKkWaUFnZxzdjQNw7-2tmYTTOzw@mail.gmail.com>
 <7849E95F-603B-49B8-B251-73CAB4811E48@redhat.com>
 <CANH4o6NcrFz6EKDcfq1daaSpmOuCebYA-A3u3Bk_+kPtJWBLYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 18 Dec 2023, at 3:37, Martin Wege wrote:

> On Thu, Nov 30, 2023 at 1:26 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 29 Nov 2023, at 22:45, Martin Wege wrote:
>>
>>> ?
>>>
>>> On Fri, Nov 24, 2023 at 9:57 AM Martin Wege <martin.l.wege@gmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> We get a umount.nfs: /mnt: block devices not permitted on fs in a snap
>>>> container on Ubuntu.
>>>>
>>>> Can anyone explain what is going wrong?
>>
>> Something in umount is calling umount_error() with -EACCES.  I admit that
>> error message makes no sense, it seems to be cruft.
>
> Can this be fixed, please?

Probably, have to figure out the problem first.

>> Maybe you can run the umount in gdb with a breakpoint on umount_error() and
>> send along the stack.
>
> This is much more difficult than I expected - the target system is a
> Ubuntu Core system, which uses SNAPs, and debugging there is a
> disaster.

Hm, I don't know what SNAPs are..

> Does umount have an extended debug output?

Not really, maybe try with "strace" and we can see what the kernel's
returning?  From there, it might look like flipping on some debugging (check
out the dprintk's in fs/nfs and net/sunrpc and the `rpcdebug` userspace
tool), or maybe some tracepoints would help.

Ben


