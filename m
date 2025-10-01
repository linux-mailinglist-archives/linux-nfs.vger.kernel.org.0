Return-Path: <linux-nfs+bounces-14833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A8BB010E
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 12:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABADF3AC5E0
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E628640D;
	Wed,  1 Oct 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImexmNYo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3927D771
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316063; cv=none; b=mzW2J7Wgw9FR+ZxlNBROhNljs9sijt4NHK9D2ZxRuxTQqoFLmEdIb8AGd7hHbsKl+istqJLBxM4l9f9WY737BRI6VJGKO/TqyzJuOVf4jiUD6bISvv2hL1fWYB3C/VMegdimXECdXYYOZg1cfCVXSRvizKr9KD8QDSs4zAwYd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316063; c=relaxed/simple;
	bh=hWp8o6pMmAgx6TTXdgBdMzZIiAqBKJbCJxgFCuPswvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ug800zWeh0ELKVceHd/uzXlPwLP0TMOr7HqsNmNM/863W6Fmi/JGPBr3FGh0CCfNfi7sQICDTtejPSK6+iTrV4nuOp+KSNzEmpJpk3b0IVC5JHV5bpoTSre2u18KwrC2U5MwjYY0DYDTDfFrVW6LJMFRPLUsufArtpf8FjKHtC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImexmNYo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759316060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzYo3Q08WHbTLswh/paKCxets2/Ip4CffR2crleBNX8=;
	b=ImexmNYo+93iN5LS5m5D6dJ17KcBGrDTS6gJMsIXw8kzWcj/FQoZoK7v5nWZrvZpJwuTRP
	0FgpXLCdS6xhssIopOGXw6nWP1fe23PNcD1ywdtSQxDiOighuLpDrDGGL/zvgG3OJN9Dth
	IA0StOotm06lidjlTIknjXL4tHM1QoI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-Ndaybu2FMXG-NsGsmfnVzw-1; Wed,
 01 Oct 2025 06:54:17 -0400
X-MC-Unique: Ndaybu2FMXG-NsGsmfnVzw-1
X-Mimecast-MFC-AGG-ID: Ndaybu2FMXG-NsGsmfnVzw_1759316055
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59F05195609E;
	Wed,  1 Oct 2025 10:54:15 +0000 (UTC)
Received: from [10.0.1.177] (unknown [10.22.74.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF03830003BA;
	Wed,  1 Oct 2025 10:54:12 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
Date: Wed, 01 Oct 2025 06:54:10 -0400
Message-ID: <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
In-Reply-To: <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 30 Sep 2025, at 17:41, Dai Ngo wrote:

> Hi Ben,
>
> On 9/30/25 12:15 PM, Benjamin Coddington wrote:
>> Hi Dai,
>>
>> On 30 Sep 2025, at 12:28, Dai Ngo wrote:
>>
>>> When servicing the GETDEVICEINFO call from an NFS client, the NFS server
>>> creates a SCSI persistent reservation on the target device using the
>>> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restricts
>>> device access so that only hosts registered with a reservation key can
>>> perform read or write operations. Any unregistered initiator is completely
>>> blocked, including standard SCSI commands such as READCAPACITY.
>> SBC-4, table 13 shows that READ CAPACITY should be allowed from any I_T
>> nexus, no matter the state of the reservation on the LU.
>>
>> Is it possible that your SCSI implementation might be out of the spec?  Also
>> possible that SBC-4 has been updated, I haven't been following the SCSI
>> specification updates..
>>
>> Ben
>
> I don't have access to SBC-4 spec, t10.org does not allow guest access
> to their docs. Can you please share the content of table 13 here?

The document's licensing prohibits me from doing this, I'm sorry to report.
I have a single-user copy that prohibits me from copying or transmitting any
part or whole.  Looks like you can get SBC-5 from the ANSI webstore for $60:

https://webstore.ansi.org/standards/incits/incits5712025

The reason your patch caught my eye was because we'd previously fixed the
same problem in the SCSI LIO target.

Ben


