Return-Path: <linux-nfs+bounces-973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DF82748C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0681F22510
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AB52F62;
	Mon,  8 Jan 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkdbQ8eJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1C52F63
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jan 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704729417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9JzvIKGyNBtfesWwF91J7COdO6JqIPIkp0SCul0YvI=;
	b=QkdbQ8eJDlFEDm7nyMFYrnY0o2y4c4FOqJgEvuGICNVrdWqiwk05OLJo13hYEaDoBp02Gb
	PjTnAYsBAQtzBuPmUGYR4tKkjCpHjT9BNvOloG2tkFWXqKLKFpDvylz8NONZkyjikMusg2
	xengRsku9kDF8UlJfIfs8FIGygK+wVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Xjkswe0fMKGLC7X71JU9rQ-1; Mon, 08 Jan 2024 10:56:51 -0500
X-MC-Unique: Xjkswe0fMKGLC7X71JU9rQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AE2D101044B;
	Mon,  8 Jan 2024 15:56:51 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B05985190;
	Mon,  8 Jan 2024 15:56:50 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 ms-nfs41-client-devel@lists.sourceforge.net
Subject: Re: What are nfs persistent sessions, and how to enable them in the
 server?
Date: Mon, 08 Jan 2024 10:56:49 -0500
Message-ID: <466B1C7F-A994-4108-8154-4BA392B99647@redhat.com>
In-Reply-To: <CAAvCNcAAE0x4wJ0mVJ0b-7keSv3g=cFQf5o0yEd6-pMq35AzGg@mail.gmail.com>
References: <CAAvCNcAAE0x4wJ0mVJ0b-7keSv3g=cFQf5o0yEd6-pMq35AzGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 7 Jan 2024, at 10:24, Dan Shelton wrote:

> Hello!
>
> The ms-nfs41-client brings up a message about "persistent session" -
> what is that?

Hi Dan,

See: https://www.rfc-editor.org/rfc/rfc8881.html#section-2.10.6.5

Ben


