Return-Path: <linux-nfs+bounces-2207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE945871E1D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 12:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DBC287D0F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 11:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B2B56B8C;
	Tue,  5 Mar 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB5GHbRQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F658138
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638774; cv=none; b=HFy9DdF7lqECJe3TrVwKk0de0pQYxOqgR/Vam/knFacOnn2y4c0/IGahxldzd7jDrsavhGTEp0+0qX0eFb9XJ8TrcOURqR5be+Hp0dNrI3UmAEsrK63ftz+jPQQLQCFfldnpfiZF//KNkm0mgEmsUTb8/N9CxteO5kFHBpHABGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638774; c=relaxed/simple;
	bh=yGIHvaUSGtSh8SOfvZ4m5hJZFHMxJezWum2+AMtKBHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvZWHP8sYxiP3k/PiL7DnBzztbnq6CosIGoRTYOeM04v2sX3KSJf6aWBiOx9IffGjsyScYJ9yeus54NyNnH+cObCLHb0vPfm8CWXPphf6e4BjAIG00xIhR6uYK82TnRED8CKjf943ONQnhBpd0IWHpfoZ+PZV7HF1Ib1oiQ/JOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB5GHbRQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709638771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGIHvaUSGtSh8SOfvZ4m5hJZFHMxJezWum2+AMtKBHs=;
	b=KB5GHbRQLO8ir4CeTCWjB42/PT4gKE8FCQyFMm72rY1am5ch5mcqoPlt9z/60FMRlFFggf
	kEwNLvVvcMAwvAE+iOVujE5BiZChTxUoGpySvgtgrHMmYF9S3UVi118SAWj7Ywo4hVWQBk
	yNPWHA74UzYtQvCdib/KPTamQRfMKqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-J3WurOEcM4WfOcjwZVGixw-1; Tue, 05 Mar 2024 06:39:28 -0500
X-MC-Unique: J3WurOEcM4WfOcjwZVGixw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD8D6800264;
	Tue,  5 Mar 2024 11:39:27 +0000 (UTC)
Received: from [100.115.132.116] (ovpn-0-8.rdu2.redhat.com [10.22.0.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 75904404392A;
	Tue,  5 Mar 2024 11:39:26 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christian Theune <ct@flyingcircus.io>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 jlayton@kernel.org, linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 trondmy@hammerspace.com, anna@kernel.org
Subject: Re: nfs4_schedule_state_manager stuck in tight loop
Date: Tue, 05 Mar 2024 06:39:25 -0500
Message-ID: <9FB1C80C-CF8A-4650-8918-475A19F353EB@redhat.com>
In-Reply-To: <3404A3C2-31BE-4D39-A256-E3A1FB48ACFB@flyingcircus.io>
References: <8B04DA70-ABEF-44A4-BBA7-60968E6CFA10@flyingcircus.io>
 <ZdisssP88_9o0BXn@manet.1015granger.net>
 <3404A3C2-31BE-4D39-A256-E3A1FB48ACFB@flyingcircus.io>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 5 Mar 2024, at 1:09, Christian Theune wrote:

> Hi,
>
> not sure whether I may have missed a response that didn=E2=80=99t make =
it back to me or any of the lists.
>
> Just in case, because the CC didn=E2=80=99t include the original addend=
um I made to my report:
>
> Addendum:
>
> I=E2=80=99ve checked kernel changelogs since then but didn=E2=80=99t fi=
nd anything that I could relate to this aside from *maybe* dfda2a5eb66a68=
5aa6d0b81c0cef1cf8bfe0b3c4 (rename(): fix the locking of subdirectories) =
which mentions NFS but doesn=E2=80=99t describe the potential impact.
>
> We=E2=80=99re running 5.15.148 now and as it=E2=80=99s been another 2 m=
onths there might be the chance of another lockup in the near future ;)
>
> If anyone has ideas on how to debug/approach a reproducer I=E2=80=99d b=
e more than happy to help and try to provide more data.
>
> Cheers,
> Christian

When the problem occurs, use the

nfs4:nfs4_state_mgr
nfs4:nfs4_state_mgr_failed

tracepoints to see what the state manager might be doing.

Also a network capture might show what the state manager thread is up to =
if
it is sending operations.

Ben


