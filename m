Return-Path: <linux-nfs+bounces-199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB67FEF18
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AA81C20BB9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF24776B;
	Thu, 30 Nov 2023 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF2ixhV9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8807810DB
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701347205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8tEhpp6179rqqcTcAZ+nOKXUtgfEYtRgYCZ9Fv9kcU=;
	b=LF2ixhV9+KYZHfsdRkdNyUJ0yrJfGN3503HpTWnAM3+orICt1pt7w6mO1f5mYzI6yWpazA
	V6nFuOySZ/HuLv62zDIX9L7lKidmeRHwBP/fkj1jNC44DGwZUDBE+QoIzDsgCifOmV4Vry
	23TVTmSynQ0crGD5HaNWHEmk9cx6Q6M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-kep8ImsCPJeJK0YSQ6CZ7A-1; Thu,
 30 Nov 2023 07:26:43 -0500
X-MC-Unique: kep8ImsCPJeJK0YSQ6CZ7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 384621C0690F;
	Thu, 30 Nov 2023 12:26:43 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B465A112130A;
	Thu, 30 Nov 2023 12:26:42 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: umount.nfs: /mnt: block devices not permitted on fs
Date: Thu, 30 Nov 2023 07:23:41 -0500
Message-ID: <7849E95F-603B-49B8-B251-73CAB4811E48@redhat.com>
In-Reply-To: <CANH4o6Mu8kDvZTrssVc_Tr1CKkWaUFnZxzdjQNw7-2tmYTTOzw@mail.gmail.com>
References: <CANH4o6OdF=hjLtZ1_jbqPjexuenYn6cSvxFrJ+BUUDQv86DRzA@mail.gmail.com>
 <CANH4o6Mu8kDvZTrssVc_Tr1CKkWaUFnZxzdjQNw7-2tmYTTOzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 29 Nov 2023, at 22:45, Martin Wege wrote:

> ?
>
> On Fri, Nov 24, 2023 at 9:57 AM Martin Wege <martin.l.wege@gmail.com> wrote:
>>
>> Hello,
>>
>> We get a umount.nfs: /mnt: block devices not permitted on fs in a snap
>> container on Ubuntu.
>>
>> Can anyone explain what is going wrong?

Something in umount is calling umount_error() with -EACCES.  I admit that
error message makes no sense, it seems to be cruft.

Maybe you can run the umount in gdb with a breakpoint on umount_error() and
send along the stack.

Ben


