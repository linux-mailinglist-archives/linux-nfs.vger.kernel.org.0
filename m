Return-Path: <linux-nfs+bounces-8496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93629EAFD1
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 12:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C3282ED5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42F3C30;
	Tue, 10 Dec 2024 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfPNjNHN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499923DE9E
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829978; cv=none; b=Z38arldP9HfM0P7SmNVyRjL3R4PkImsxi3uAkbL6Rp/URzothselI/m22mp0+4kpORld+V3bXYs6Kqe493tbSz75WahrvyvFtU68/SUmPUGk2DR6+Dnl+HSlSPTyjPuAEyFznP/p8NaHhavUKfM5GiJDtBXXlF6ZotjCxJE4DLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829978; c=relaxed/simple;
	bh=z0pUl8i5QevzZ8j7J0IB1K+/8RRSQal4hRVNCrHEZzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icr2r5OHmqaRzs7ykQDoQHo9WBtqJCetfY0JBXwzELW2jiNoxleqO8zVyMoi4CaK6t6pXPbnKJ5QAVn+5JPGDnRh0P1ra8h4A8wBTQPB7JUuk13To4YCYYxWtZmgjenBgbrR8vcdL8zVPj6CM86nE57oHAAL7nRDNgqDrfqtTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfPNjNHN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733829975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0pUl8i5QevzZ8j7J0IB1K+/8RRSQal4hRVNCrHEZzA=;
	b=dfPNjNHNe2GvYWtsS2YtHr+ZfdrQPF39mqNPG+CKhPOPNWBhsd2LINr3vFS8dcevSdpOwA
	0rqi0tWpFmgid8ZmO9RurXv9Qm40HaA+gQqLAa5DEZUvTKfENdmQn3isCJPx8d5Mwy4Gh9
	zkbOd60qGgMly0uEDFFIoaAY+uQ5h04=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-tcMMu2SsMou7pzquJywpXg-1; Tue,
 10 Dec 2024 06:26:12 -0500
X-MC-Unique: tcMMu2SsMou7pzquJywpXg-1
X-Mimecast-MFC-AGG-ID: tcMMu2SsMou7pzquJywpXg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD40219560AB;
	Tue, 10 Dec 2024 11:26:10 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9D741956089;
	Tue, 10 Dec 2024 11:26:08 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] NFSD: Clean up unused variable
Date: Tue, 10 Dec 2024 06:26:06 -0500
Message-ID: <F04B6A01-DAF3-4B10-AE67-8C832518381C@redhat.com>
In-Reply-To: <20241206213633.405299-1-cel@kernel.org>
References: <20241206213633.405299-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 6 Dec 2024, at 16:36, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> @sb should have been removed by commit 7e64c5bc497c ("NLM/NFSD: Fix
> lock notifications for async-capable filesystems").
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

ah, yes thanks.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>


