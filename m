Return-Path: <linux-nfs+bounces-8931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB6EA02694
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 14:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE463A165E
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3011DDC1A;
	Mon,  6 Jan 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCGOsoPj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBD1DB943
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170266; cv=none; b=ST8bV+GLwsyUxvq/krLAQYyn0soiqvb7UO7Im7M3bl0YzHb3YxIrgy0aCXEnqh97GfuD8Do1fFbxZdYBBodWaYY//k21ijgTkndA+MceINrKj9Liv/fZvd4JUmfnrUzYWsvAIsfBvdoMWOaMvIcAXyeLnOwdKLugQwccNw035RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170266; c=relaxed/simple;
	bh=M9MVerKpNmh5TNN/+BnCUpMHl/dM2pj6t9q+9j5PXa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwSoEEtwe3FV0VqEVQ6rgiAfltPohIhSB041v+l8b1rzxV7G11zxfHsZ/uM1ed/Fn9P7zUdLJQU288wOnq3/PjwoTXv0VSg5uB73VcC5K7JDuodHqVoJ6q+oTpWpqTk3TL6T4SgwpGZO09Y7Y/Hbh63jp2D5aVqR01y1nl3EJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCGOsoPj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736170260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwk5s0QCWqhXRrhhoSbBz+EmqwTlYFV07b3ew6OZfSg=;
	b=dCGOsoPjNzohCJmXZVBa1HJ88vzfYoUvtBq4GFH/IxlRfYfTMiVwWJz/QsL+oL+xljs5h3
	vk4TCq+Box2Mx7utvOSMo7FkX0+9A1A4uhekSMGeVpYSLudd58GWG86UmDeXe1U0j9RPvW
	mu3LwUOxWTssMgnbT7P9RHMB6O9rvVw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-jn3psj_lP12y6E9V60KCqg-1; Mon,
 06 Jan 2025 08:30:57 -0500
X-MC-Unique: jn3psj_lP12y6E9V60KCqg-1
X-Mimecast-MFC-AGG-ID: jn3psj_lP12y6E9V60KCqg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2143819560AB;
	Mon,  6 Jan 2025 13:30:56 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BC3C195605F;
	Mon,  6 Jan 2025 13:30:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Linux NFSv4.1/4.2 client source code structure?
Date: Mon, 06 Jan 2025 08:30:53 -0500
Message-ID: <3889A3EE-4E56-40D9-B3D5-4D6BCE3CD406@redhat.com>
In-Reply-To: <CALWcw=HxURVr7=kYM3XyrxQJ82wNfurWb4i_hJ77jpydd6D2oQ@mail.gmail.com>
References: <CALWcw=HDd06aQi5TXZjVgYDD7+fiheErCqDt2_6cd_c5iieCZw@mail.gmail.com>
 <5A440646-9BA0-4EE1-9AF3-D9C7DDAA1DA4@redhat.com>
 <CALWcw=Fh+YsQ94tG62qTU4Lv2367YajzvmgAjTfdJcbTr=hE2A@mail.gmail.com>
 <D1DFB17F-4EC6-4DE2-8E5B-93264BAC9B72@redhat.com>
 <CALWcw=HxURVr7=kYM3XyrxQJ82wNfurWb4i_hJ77jpydd6D2oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 4 Jan 2025, at 13:15, Takeshi Nishimura wrote:

> On Sat, Jan 4, 2025 at 4:40 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 3 Jan 2025, at 18:07, Takeshi Nishimura wrote:
>>
>>> On Thu, Jan 2, 2025 at 4:38 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>>>
>>>> On 26 Dec 2024, at 19:45, Takeshi Nishimura wrote:
>>>>
>>>>> Dear list,
>>>>>
>>>>> Is there a document which explains the structure of the Linux
>>>>> NFSv4.1/4.2 client source code?
>>>>
>>>> No, I don't believe there is any such document.
>>>>
>>>>> And where can I find the code which negotiates between NFSv4.1 and
>>>>> NFSv4.2 versions, and a potential NFSv4.3?
>>>>
>>>> For the client, that code is in the nfs-utils tree in the mount.nfs binary,
>>>> source in utils/mount/stropts.c - look for "nfs_autonegotiate()".  If the
>>>> mount command does not specify exactly the minor version, then a mount is
>>>> tried with decreasing minor versions.
>>>
>>> So mount.nfs adds vers=4.2, if that fails it retries with vers=4.1, vers=4.0?
>>>
>>> Where in the kernel is the minor version from the parsed vers=4.2 option used?
>>
>> Start looking around in fs/nfs/fs_context.c for "minorversion"..
>
> Thanks
>
> Another question about NFS 4.1 / 4.2 client implementation: Is the
> NFSv4. minor version per session? Could a NFS client implemenation
> send both NFSv4.1 and NFSv4.2 compound requests, if they are in
> different NFS sessions?

I think this question is less about the linux implementation, and more about
the protocol.

The minor version is actually part of the COMPOUND arguements (See
RFC-8881).  I do think a client could mix minor version COMPOUNDs on the
same session, but I'm pretty sure the linux client doesn't do that (it
doesn't change the minorversion depending on what it sends in the COMPOUND).
I am often wrong, however - don't be surprised if someone corrects me here.
:)

In these matters of how the protocol works, often the best place to ask
clarifying questions (if the RFCs are unclear) is the nfsv4.ietf.org mailing
list.

Ben


