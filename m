Return-Path: <linux-nfs+bounces-15088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB1BC933E
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2946E1A611D5
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3A2E6CB3;
	Thu,  9 Oct 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuPlbxBP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8E2E6CD4
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015318; cv=none; b=abXk32Yxcb7jsNFGrfKcZpuroXV1nDZAK3w1u4FzwqeuBVtpXNrsJEuFAQKYU/RQFcQ0f2BqHORbF9njldjwPrvC5oIFfoOQ5nSSxYpaF+OcZSOTQSoR9qXSjElN4ldF64WUiBMCLTMcoM7hDMTIZPNfX14jGx/8GFLWs/MLE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015318; c=relaxed/simple;
	bh=rUkS3yXKvfDwJdUzxCwWtkn8sd+Phy3S5Y9RNIHuL4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUDOorBho+wJwnya/+P7m+Qizo31plsrwoCv2aFeoyiNJnqD9cJTEEfCULspIHwXsg2dInIStFml6EWLV4Q9O5av8fB+W0WDUtT8c3L9ZquavV9Y//2D0qi3XjcW9jHxFw373loTgehXSAk2vOnMqJAOb/nbbSd/hbYmXqw5nwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuPlbxBP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760015315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUkS3yXKvfDwJdUzxCwWtkn8sd+Phy3S5Y9RNIHuL4A=;
	b=QuPlbxBPvlbY4MuP6d87mqODCU9TzDn86vzTQM3LON6POSMfO9G/J3fAYPrNdClgTpwU13
	TDb16vSPSUNlkY/+Gu/d42fJTmkipysYXp0Nfq5l7WkuchrawH6Bj8E+rnT6YQrT+wqSuz
	5Jf/QSO+ZsYXCqwke5WJxmsqRH91f3c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-qBtNHbKhOXW7bnhxxDOkjg-1; Thu,
 09 Oct 2025 09:08:33 -0400
X-MC-Unique: qBtNHbKhOXW7bnhxxDOkjg-1
X-Mimecast-MFC-AGG-ID: qBtNHbKhOXW7bnhxxDOkjg_1760015312
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4974E195609E;
	Thu,  9 Oct 2025 13:08:32 +0000 (UTC)
Received: from [10.22.65.202] (unknown [10.22.65.202])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEF31180035E;
	Thu,  9 Oct 2025 13:08:31 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1 filesystem
 client Windows driver binaries for Windows 10/11+WindowsServer 2019/2022 for
 testing, 2025-10-09 ...
Date: Thu, 09 Oct 2025 09:07:15 -0400
Message-ID: <C18594B1-E057-4A86-AC26-478A29EA5388@redhat.com>
In-Reply-To: <CANH4o6Nf8=THbEKsmfATJS5Mk=7iP31WoW8sDhfm==MqeaXx0w@mail.gmail.com>
References: <CAKAoaQnWu8pcvEtRahV+Tvr5XxWpsBEOgWCSjn4ppnsJWGNr0A@mail.gmail.com>
 <CANH4o6Nf8=THbEKsmfATJS5Mk=7iP31WoW8sDhfm==MqeaXx0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 9 Oct 2025, at 7:19, Martin Wege wrote:

> Hello,
>
> Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
> ARM64+AMD64+x86 and Windows Server 2019+2022/AMD64, but
> interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
> 6.6+ LTS and
> 6.17+ would be great.

Hey Martin, we're in the middle of bakeathon[1] this week, so there's a
bunch of server implementations online _right now_ that you can test
against, even remotely via our tailscale network.

Ben

[1]: http://www.nfsv4bat.org/Events/2025/Oct/BAT/index.html


