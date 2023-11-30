Return-Path: <linux-nfs+bounces-200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B17FEF6D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 13:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839F01C20B76
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85F4779B;
	Thu, 30 Nov 2023 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB+UsUdg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E53D50
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 04:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701348322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfOHqHrZHg6fuXwcB8+TtsQGiSGk/Jw3citxF2dQTww=;
	b=NB+UsUdgdCpPRNsXTOOOaoU3GX6ObWToGhQafh3I79HEpSoDJkoNGWP0/wgmMWsybDcsYZ
	KMHx2rftF6zqCwCBjjWI1MxMfk2HLIND81qynA9X8naGErFGSn4BBym7nLCPzy85y/J2g2
	hrlKtCPvDjIcIwXjUwWO9U71xHCZhNY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-D1pLCYxFO6yV6x_dC3JFUg-1; Thu,
 30 Nov 2023 07:45:21 -0500
X-MC-Unique: D1pLCYxFO6yV6x_dC3JFUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F013C3C02769;
	Thu, 30 Nov 2023 12:45:20 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 781D310E46;
	Thu, 30 Nov 2023 12:45:20 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.2: How to deallocate a range of bytes in a file, aka
 "punch a hole"?
Date: Thu, 30 Nov 2023 07:45:19 -0500
Message-ID: <2F13FCCD-8450-43DA-8C2D-0554BAA32037@redhat.com>
In-Reply-To: <CALXu0Uc9Q-i4TPVP4LQGfHcbpp-vwSL4a1xEzVuFxqDQwfbUCw@mail.gmail.com>
References: <CALXu0Uc9Q-i4TPVP4LQGfHcbpp-vwSL4a1xEzVuFxqDQwfbUCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 30 Nov 2023, at 5:18, Cedric Blancher wrote:

> Good morning!
>
> Linux has fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, ...)
> to punch a hole into a file, i.e. deallocate the blocks given and make
> the file a "sparse file".
>
> But how is this implemented on NFSv4.2 COMPOUND level? How does a
> NFSv4 compound look like to punch a hole say from position 30000 to
> position 35721?

Are you interested in the current linux client's implementation?  You could
look at a wire capture of the operation to find out.

Its going to be something like PUTFH, DEALLOCATE, GETATTR..

Ben


