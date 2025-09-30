Return-Path: <linux-nfs+bounces-14825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226DBBAE6AC
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FDF3AFB28
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511735940;
	Tue, 30 Sep 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anNgBkZi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E74C81
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259737; cv=none; b=aBFQPnQ+opOqXzfCeZdaNESBtKNqALaoKUnBKI09dbKqxCf1C3xaKXyAp9hpScIj+pX8GF+jLWefvZdS+MxfHIfrwS/5rvLwqY0TT2N1bEN5bvxilkVK+xb4h/cRiaJOp+X6g3jaXz8qytqNJeWIZkgXQYLygDt1alfggPxA+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259737; c=relaxed/simple;
	bh=jmwYCx4D2znpM/ZbXmfKmzxp9x7Avot9sMF0jxtI+V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMLY0pHdXLbY6eqkBudfE83wqZ1se89n/rZGh6iIkmPu5Wwoe05e+tvGWds+f2MM87p+X2miezQNFYeBdK//s7lDSnj7GX+mHoXtJboiWf1ee2TH9DZqzKhDMIKQyVlEzBTB6EhhFw1bxEQUDIan84yGEXJVtSaRucKkiNR1sTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anNgBkZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759259734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGW972IkPXx3ISwmYPHeoMj5udj0pJXSYNRbr9U5t5I=;
	b=anNgBkZiSxyuJfD8tOx1NfFWGa8xEdfkMrrnmJxd+fpmStDsEVlPV+V68G+XiS1sUU2nbO
	sfVQX7uN8j4xSr2L8iiiIu5uNqqoVn3cQ+xuiJB+CPSJZLh0FPWVUBOSKyNV23brPu0KLo
	6l1A2GTIkIaikIucu/hwY01shrskB1g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-lBdf3nCzPmC12LqIKjBkXw-1; Tue,
 30 Sep 2025 15:15:30 -0400
X-MC-Unique: lBdf3nCzPmC12LqIKjBkXw-1
X-Mimecast-MFC-AGG-ID: lBdf3nCzPmC12LqIKjBkXw_1759259729
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A52E619560AB;
	Tue, 30 Sep 2025 19:15:28 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B2D319560B4;
	Tue, 30 Sep 2025 19:15:25 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
Date: Tue, 30 Sep 2025 15:15:23 -0400
Message-ID: <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
In-Reply-To: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Dai,

On 30 Sep 2025, at 12:28, Dai Ngo wrote:

> When servicing the GETDEVICEINFO call from an NFS client, the NFS server
> creates a SCSI persistent reservation on the target device using the
> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restricts
> device access so that only hosts registered with a reservation key can
> perform read or write operations. Any unregistered initiator is completely
> blocked, including standard SCSI commands such as READCAPACITY.

SBC-4, table 13 shows that READ CAPACITY should be allowed from any I_T
nexus, no matter the state of the reservation on the LU.

Is it possible that your SCSI implementation might be out of the spec?  Also
possible that SBC-4 has been updated, I haven't been following the SCSI
specification updates..

Ben


