Return-Path: <linux-nfs+bounces-8222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 260419D9912
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 15:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D99B296BD
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821311D5162;
	Tue, 26 Nov 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4+47ezH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D9B652
	for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629761; cv=none; b=sVlO8y4YpBBLmoH5MvHj0KBH4XIR0mRfmcq489SYXJ3rdbspekdPQAUZRglX7qYvD3X2ShomiUWfIdkfrw+Xbzj4/FD+UbGpvDX4qFBHMAuhNuoIMHU6LOUORrl/bB47PJOgvzmhF/mYOocfMLWSVpHBXIkbvK0s95gTYuTUz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629761; c=relaxed/simple;
	bh=vcLUTsoS6x1gnuzK7z2U4JPlc/p1QP0q6B+LguCDUw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8Qx3SPf+qcjCyRKCqogYWjezjzNTTCMKYR59asA+Hie39GBx3TzsQkQlyuvKr69I7qQZ0VLmRO5NPamjpU5XYI0EH0nYWdWo+ujcFnraOnd6soFvG9uVbHvzM+qW4haY1MFBQF9zXCE/nrVhG5NhiI97i4M2nvM8qNVvqLazVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4+47ezH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732629758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPuamv4uDo2oGygFZFBBRzgkUZYuSKNAaPkkFoyK+TY=;
	b=Q4+47ezHPUa0seVbhKVVxYekdeKwXOVj5b4v5+t+WitHSSs96k1xKaV3pUEnx5rKqz+WCc
	dbUeXa4hKHrU5Ir7vMFRi/N23h5Fje1ZYa+H2ntJTad30lA+sPAiPjm4pnMKgKiIo44mgk
	qW69XxFApK+YcJzMzi04YBgmdC8Q0vA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-ASaXOXpKOUu1ZcwVayfA_g-1; Tue,
 26 Nov 2024 09:02:34 -0500
X-MC-Unique: ASaXOXpKOUu1ZcwVayfA_g-1
X-Mimecast-MFC-AGG-ID: ASaXOXpKOUu1ZcwVayfA_g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB9221955F41;
	Tue, 26 Nov 2024 14:02:33 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 519EF1956054;
	Tue, 26 Nov 2024 14:02:33 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Mark Liam Brown <brownmarkliam@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: IPV6 localhost (::1) in /etc/exports?
Date: Tue, 26 Nov 2024 09:02:31 -0500
Message-ID: <0A2C275F-97CC-41BC-90D7-25340EA046B2@redhat.com>
In-Reply-To: <CAN0SSYw-eDXnG=QMuaJTsx5KXbusZ8SO3ER5Udg=5_ipi4A7Pg@mail.gmail.com>
References: <CAN0SSYyAf51Vdeg9yVGD7isZfT+PcvbC8RcUGzgkH9MUB1QjgQ@mail.gmail.com>
 <CAN0SSYxVUiiupuu-8DPq1tMRrOBuO49bwaLik0KmoQ3r2pqnxg@mail.gmail.com>
 <CAN0SSYw-eDXnG=QMuaJTsx5KXbusZ8SO3ER5Udg=5_ipi4A7Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 25 Nov 2024, at 12:21, Mark Liam Brown wrote:

> On Mon, Sep 30, 2024 at 4:58 PM Mark Liam Brown <brownmarkliam@gmail.com> wrote:
>>
>> On Tue, Sep 3, 2024 at 1:16 PM Mark Liam Brown <brownmarkliam@gmail.com> wrote:
>>>
>>> Greetings!
>>>
>>> How can I add IPV6 localhost to /etc/export, to access a nfs4 share
>>> via ssh? I tried, but in wireshark I get this error:
>>>     1 0.000000000          ::1 → ::1          NFS 278 V4 Call lookup
>>> LOOKUP test14
>>>    2 0.000076041          ::1 → ::1          NFS 214 V4 Reply (Call In
>>> 1) lookup PUTROOTFH | GETATTR Status: NFS4ERR_PERM
>>>
>>> for this entry in /etc/exports:
>>> /test14 ::1/64(rw,async,insecure,no_subtree_check,no_root_squash)
>>>
>>> The same mount attempt works if I replace the entry in /etc/exports with this:
>>> /test14 *(rw,async,insecure,no_subtree_check,no_root_squash)
>>
>> So far "::1/128", "::1/64", "::1" do not work, which makes me wonder
>> if there is a BUG in nfsd which prevents the use of ::1 at all.
>>
>> Also, our IT department made it clear that the "total
>> underdocumenation" of IPv6 in exports(5) is "literally worth a CVE",
>> as many people use IPv6 masks which make exports world-wide
>> accessible.
>
> So is this a bug, or not?

Hi Mark - this does look like a bug, probably in rpc.mountd somewhere, but I
can't reproduce it on my system with upstream nfs-utils.  Can you turn up
the debugging on rpc.mountd and see what's emitted?

I think your options might be to convince someone here to dig into it, or
file a bug report with your distro, or with upstream nfs-utils (if you can
verify this continues to be a problem with the most recent version of
nfs-utils).

Ben


