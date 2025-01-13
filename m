Return-Path: <linux-nfs+bounces-9174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68736A0BE07
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DB618838E5
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965BA190692;
	Mon, 13 Jan 2025 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9ezFnyo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057053A8D0
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787153; cv=none; b=IUahPNpitP6ehxbQRL/+ma0q5AsBwV30Lx6SQzBEhT6Kr4vv1xw97xe8Av5udrHKnwNJkWdgd3vg3wU6xFtUDAh9hkWXuMbSP4zhaqwrqXzUksKlkEM0+ajf1Py5JObSTXoRQAci7lbAxrWZVX82xRUnJqp8P/SIEf31f3/A/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787153; c=relaxed/simple;
	bh=Z8nf3HpsMSuQTrMAzRSVE/GOyLb/gnKT1p3/2H/G254=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAR3Ln+gGW5YrGZ735+A7JAz8WB+Y0wufWhzwx6RgBHGdtfJ4lgi4L+Huohj2gFLSCy+/EEVZG3EDc0H4XqsBXEGRJhnSud7zGIFkCBujIx/V6ENP9uD8ZPx3iilMfV6/C7+qfI1OPLusRIp5zV78qeTTnpVu8sMtXQc5YvTARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9ezFnyo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736787151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8nf3HpsMSuQTrMAzRSVE/GOyLb/gnKT1p3/2H/G254=;
	b=E9ezFnyocixgSdxzUA/Z4ofZfCvhDCHCh6RjX0INhNf8Spg5OjcYcdmd7YdWSmhHpbAfn/
	iAnMwl/QWuJ9QyubiSwRN/Sdz9xkaxPcx0Q8/fv5TYEYN/2pG4rFgpyGkcrMFfqLs86ZIg
	rD5C7Noq3CFQiCk5gwMxKlB3boVrdEk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-O6a7TfGgMBuAMjorIJRHRg-1; Mon,
 13 Jan 2025 11:52:27 -0500
X-MC-Unique: O6a7TfGgMBuAMjorIJRHRg-1
X-Mimecast-MFC-AGG-ID: O6a7TfGgMBuAMjorIJRHRg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46BDC1956083;
	Mon, 13 Jan 2025 16:52:26 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B52919560A3;
	Mon, 13 Jan 2025 16:52:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 0/7] Client-side OFFLOAD_STATUS implementation
Date: Mon, 13 Jan 2025 11:52:22 -0500
Message-ID: <C045AC7D-3285-4EA9-9EAF-74E7D4A0D0F6@redhat.com>
In-Reply-To: <20250113153235.48706-9-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 13 Jan 2025, at 10:32, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> SCSI implementation experience has shown that an interrupt-only
> COPY offload implementation is not reliable. There are too many
> common scenarios where the client can miss the completion interrupt
> (in our case, this is an NFSv4.2 CB_OFFLOAD callback).
>
> Therefore, a polling mechanism is needed. The NFSv4.2 protocol
> provides one in the form of the its OFFLOAD_STATUS operation. Linux
> NFSD implements OFFLOAD_STATUS already. This series adds a Linux NFS
> client implementation of the OFFLOAD_STATUS operation that can query
> the state of a background COPY on the server.
>
> These patches are also available here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3D=
fix-async-copy
>
> Reposting to restart the review process.
>
> Changes since v2:
> - Use an exponential backoff before posting OFFLOAD_STATUS

Looks good to me!

For this series:
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>


