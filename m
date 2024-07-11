Return-Path: <linux-nfs+bounces-4823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967692EBED
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18741F248C6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409915FCEA;
	Thu, 11 Jul 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHwiAlUZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD38479
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712945; cv=none; b=rBm2QMl0UpdzYPbRBDjqU/LbeYyAgrAN3IZV0PUXZtLCA0If6TVTed7XNTzLkDpBZTOoHkHDoAkNPcRTAMYF+C1WvG+AiQJwqFqah1ZbnxEilZESZ7+7khjYnJPInlpcKtfJ3OJIuj5HrJuY6loQlgGYqgw7Q5uR3T3+FBI0HeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712945; c=relaxed/simple;
	bh=PgEQzDMdb7+UQponoMVcwupKhZY1ZTjXq7E/ESGylfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D37x2MI3xff41oPrm72MIA1aD/y+opET+8WrOCp6hJcWfng5WJ5re2elggg1gH1+LsCWZlc0dOXCqCT3BKB+TnGKOMnZEwvTXcXE/j+PQKPkv+Y60iG/0gW10eLjd/P6Ky4pA35eSIkOLXsLmo0smYm7O5DnLFbwttYt1SBk4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHwiAlUZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720712943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lo81TB1e9c3aqFmqb4SYDYiKTXD+9fUwRg29FIH0FMw=;
	b=VHwiAlUZAyIEKtdYV54ffprJSiUv8EDs2RF/r638VS7w/XEN5B+vMrubBTcZB1xv3FzQKG
	/QxxYERDs3L++akdXOPMcUP1LouOpdYz/DK91UA7uPSUP/ecgg1wjkcsTOOXY8Q/gkdITD
	T/3NY2vD1u7PpeG4+BWXnIIPDPzFRVU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587--I57n-_gNneEdEQ8_9MNXg-1; Thu,
 11 Jul 2024 11:49:01 -0400
X-MC-Unique: -I57n-_gNneEdEQ8_9MNXg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6103E1955F44;
	Thu, 11 Jul 2024 15:49:00 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CD5C19560AE;
	Thu, 11 Jul 2024 15:48:58 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Date: Thu, 11 Jul 2024 11:48:56 -0400
Message-ID: <C3887ED2-B331-4AC9-A73B-326D7DDAC5FD@redhat.com>
In-Reply-To: <Zo/6G7ANcWEWkd0l@tissot.1015granger.net>
References: <27526e921037d6217bdfc6a078c53d37ae9effab.1720711381.git.bcodding@redhat.com>
 <Zo/6G7ANcWEWkd0l@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11 Jul 2024, at 11:28, Chuck Lever wrote:

> On Thu, Jul 11, 2024 at 11:24:01AM -0400, Benjamin Coddington wrote:
>> The GSS routine errors are values, not flags.
>
> My reading of kernel and user space GSS code is that these are
> indeed flags and can be combined. The definitions are found in
> include/linux/sunrpc/gss_err.h:
>
> To wit:
>
> 116 /*
> 117  * Routine errors:
> 118  */
> 119 #define GSS_S_BAD_MECH (((OM_uint32) 1ul) << GSS_C_ROUTINE_ERROR_OFFSET)
> 120 #define GSS_S_BAD_NAME (((OM_uint32) 2ul) << GSS_C_ROUTINE_ERROR_OFFSET)

I read this as just values shifted left by a constant.

No where in-kernel are they bitwise combined.  I noticed this problem in practice
while reading the tracepoint output from corrupted GSS hash routines.

Ben


