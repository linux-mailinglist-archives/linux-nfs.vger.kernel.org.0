Return-Path: <linux-nfs+bounces-8910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E8A01595
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F87A1C76
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8941C2457;
	Sat,  4 Jan 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIWGzxqk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEA1C1F23
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jan 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005231; cv=none; b=dq4B9OcXJ7wznbNX9CJqvkoPBgbnKHyeEod/3Q7Ll6zQnXOGX0W6TeCtnDm6FUjMwt3ozsiF+IPY4qc6T6p5KHNFXR9ivcynueZ6WKclveyTvENJnlHdQgtphP1EGoHc/jMfW2kHrZilDQzsZtOrfrWxnSfc2F324JsCSMFuIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005231; c=relaxed/simple;
	bh=HQhLE0R+d0a4V/uXtqY0cf9+mxtJdZ1AHtbVDbRkYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7N9Mfe10vDIjjeiRJfTqbanUpleVqPbUMiq22mzYW7+nM8R0TrrdGk01LafUavQXPEiBHi0fwTtpbCLMvzaCMe0+YclO+/m6P8cePCxCWmnJnpzslnL0SjdXNLdsOjXsogLRpPtIeIoIUKHtLwWLhTPLenbVrorm9l5OPCfqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIWGzxqk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736005228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TyhmIoxLoICMttcQA+SZnU0cJUL/WWvraze/8V2lqDc=;
	b=AIWGzxqk2/KvbwfjV/G9uM0bdJdvxfpxfMUFU/Uv/aX4Es266+9tSE5Q/NRiYwNOQ8QwPK
	1olOhjTHMIR0iODJuNkgFngwGOT/T+bF4yGjwa7WPnwE7i3haBmn4L+6fYANglZPA5i4AC
	EFgctGOCmKEhUOA6MqBcNS0HiJzsiMk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-k5OIYIZMP1moIjPVsR0IDg-1; Sat,
 04 Jan 2025 10:40:25 -0500
X-MC-Unique: k5OIYIZMP1moIjPVsR0IDg-1
X-Mimecast-MFC-AGG-ID: k5OIYIZMP1moIjPVsR0IDg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7913195609E;
	Sat,  4 Jan 2025 15:40:23 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FE483000197;
	Sat,  4 Jan 2025 15:40:23 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Linux NFSv4.1/4.2 client source code structure?
Date: Sat, 04 Jan 2025 10:40:21 -0500
Message-ID: <D1DFB17F-4EC6-4DE2-8E5B-93264BAC9B72@redhat.com>
In-Reply-To: <CALWcw=Fh+YsQ94tG62qTU4Lv2367YajzvmgAjTfdJcbTr=hE2A@mail.gmail.com>
References: <CALWcw=HDd06aQi5TXZjVgYDD7+fiheErCqDt2_6cd_c5iieCZw@mail.gmail.com>
 <5A440646-9BA0-4EE1-9AF3-D9C7DDAA1DA4@redhat.com>
 <CALWcw=Fh+YsQ94tG62qTU4Lv2367YajzvmgAjTfdJcbTr=hE2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 3 Jan 2025, at 18:07, Takeshi Nishimura wrote:

> On Thu, Jan 2, 2025 at 4:38 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 26 Dec 2024, at 19:45, Takeshi Nishimura wrote:
>>
>>> Dear list,
>>>
>>> Is there a document which explains the structure of the Linux
>>> NFSv4.1/4.2 client source code?
>>
>> No, I don't believe there is any such document.
>>
>>> And where can I find the code which negotiates between NFSv4.1 and
>>> NFSv4.2 versions, and a potential NFSv4.3?
>>
>> For the client, that code is in the nfs-utils tree in the mount.nfs binary,
>> source in utils/mount/stropts.c - look for "nfs_autonegotiate()".  If the
>> mount command does not specify exactly the minor version, then a mount is
>> tried with decreasing minor versions.
>
> So mount.nfs adds vers=4.2, if that fails it retries with vers=4.1, vers=4.0?
>
> Where in the kernel is the minor version from the parsed vers=4.2 option used?

Start looking around in fs/nfs/fs_context.c for "minorversion"..

Ben


