Return-Path: <linux-nfs+bounces-6010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC7964D57
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 19:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175321C222F4
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5BC1B6545;
	Thu, 29 Aug 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8wwfXfn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F51B6543
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954276; cv=none; b=R8P7LNISbxbAwUf3VyeNq3wBV1VeQI0m16sqyaF3rjxJKBANMoq8IjMGJuTpiF6M4Te0rFgdccSPEyAEjCPWH51sf6yVmmddcycfEM7oLMmETuNd2S0N0+srZksylffX8++WbpU71+GNacmjhDHuaBsfWGwaK+/wQOhWA/b43f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954276; c=relaxed/simple;
	bh=iAgl1ts90WP3HJ81WzYypgRU6ozHsYEezZ52jar00iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gH4/naIZ1jwGOmMA6M7f7BchRZL+v5wsNLl/mmqu3UfTZmmJaUkjpiTGna+4MpPwXUWUXtRxKmCtJ7ZPq7AQRjByUHVx8rwaP/er8EeXfvdZbFoTftHmfKxWSvFUqQ1J2XOY60y4E1KrbAfuASH0vpx41tGT269xvHP/ytuEbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8wwfXfn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724954273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qmZzAtC0rt/b78KVkXwgO8Syenuk5Ts7wfD2eL6a6o=;
	b=Q8wwfXfnreZJgBOaFxCa4icOTfTAvYS3UD0TXlBp2FhPpqJBNTwExWBrWBIuLlaAjPe3+K
	jGQrqMoAftabCUamMu00W1LuFlyoGhrN939tL3fnX1hiTL4JgexqQqtzUfLJhCnd/s4tti
	6RC53YLQU6giFOKE0AphI7qbb1ikI8o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-93e2JAoDMRWcPbo-dwa2nQ-1; Thu,
 29 Aug 2024 13:57:51 -0400
X-MC-Unique: 93e2JAoDMRWcPbo-dwa2nQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9338719560B4;
	Thu, 29 Aug 2024 17:57:50 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D80C19560A3;
	Thu, 29 Aug 2024 17:57:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFS: Fix missing files in `ls` command output
Date: Thu, 29 Aug 2024 13:57:47 -0400
Message-ID: <6B62A228-6C9C-4CDD-8334-E26C11DB51A1@redhat.com>
In-Reply-To: <CALOAHbDuThEW=osQudcxGQtFQqePaHzbG3MJyzGi=fLGbUqmKg@mail.gmail.com>
References: <20240829091340.2043-1-laoar.shao@gmail.com>
 <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
 <CALOAHbDuThEW=osQudcxGQtFQqePaHzbG3MJyzGi=fLGbUqmKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 29 Aug 2024, at 8:54, Yafang Shao wrote:

> On Thu, Aug 29, 2024 at 8:44 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 29 Aug 2024, at 5:13, Yafang Shao wrote:
>>
>>> In our production environment, we noticed that some files are missing when
>>> running the ls command in an NFS directory. However, we can still
>>> successfully cd into the missing directories. This issue can be illustrated
>>> as follows:
>>>
>>>   $ cd nfs
>>>   $ ls
>>>   a b c e f            <<<< 'd' is missing
>>>   $ cd d               <<<< success
>>>
>>> I verified the issue with the latest upstream kernel, and it still
>>> persists. Further analysis reveals that files go missing when the dtsize is
>>> expanded. The default dtsize was reduced from 1MB to 4KB in commit
>>> 580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS readdir").
>>> After restoring the default size to 1MB, the issue disappears. I also tried
>>> setting the default size to 8KB, and the issue similarly disappears.
>>>
>>> Upon further analysis, it appears that there is a bad entry being decoded
>>> in nfs_readdir_entry_decode(). When a bad entry is encountered, the
>>> decoding process breaks without handling the error. We should revert the
>>> bad entry in such cases. After implementing this change, the issue is
>>> resolved.
>>
>> It seems like you're trying to handle a server bug of some sort.  Have you
>> been able to look at a wire capture to determine why there's a bad entry?
>
> I've used tcpdump to analyze the packets but didn't find anything
> suspicious. Do you have any suggestions?

I'd check to make sure the server isn't overrunning the READDIR request's
dircount and maxcount (they should be the same for the linux client).  If
the server isn't exceeding them, then there's a likely client bug.

Ben


