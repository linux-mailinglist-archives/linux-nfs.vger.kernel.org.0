Return-Path: <linux-nfs+bounces-717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4C819F72
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02277286CF3
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5A625544;
	Wed, 20 Dec 2023 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRxhx5/S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F92554B
	for <linux-nfs@vger.kernel.org>; Wed, 20 Dec 2023 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703077487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8m03+reH3MY36ki9E/rADaeYYpFqwQRe+B9QZgLXHZg=;
	b=QRxhx5/SqcMDrUPtaSY/5GWl3sb1g5CI5stvsN+GEcSasMeRDdIbO5Avuvs6+EvnTUcf4V
	56sVM/GnTRMpjVbdclste6YNx2ZSblCtmP3W/dnW0In1CU28ROZv1Mw5wcWuSooN7WvEiR
	myHH6nOT3N8wA/KifHOObOD5+B3CuSA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-tcNe33UmPsyJ0Tfi2BJR5w-1; Wed,
 20 Dec 2023 08:04:46 -0500
X-MC-Unique: tcNe33UmPsyJ0Tfi2BJR5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9929F3869147;
	Wed, 20 Dec 2023 13:04:45 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 999C240C6EB9;
	Wed, 20 Dec 2023 13:04:44 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>, linux-nfs@stwm.de
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Date: Wed, 20 Dec 2023 08:04:43 -0500
Message-ID: <217964D3-3808-48E4-A879-37E4D5E463C6@redhat.com>
In-Reply-To: <AD542840-D60F-4446-8669-13123FF00703@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
 <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
 <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
 <A958C4F7-7DA4-4BA2-BAA5-9552388F5498@oracle.com>
 <689A6114-B5B2-47DF-A0D6-6901D8F52CBE@redhat.com>
 <AD542840-D60F-4446-8669-13123FF00703@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 18 Dec 2023, at 10:05, Chuck Lever III wrote:

> If you have one or two bugs that are public I could look at,
> I would be really interested in what you find with this failure
> mode.

After a full-text search of bugzilla, I found only three bugs with this
printk -- and all three were cases of kernel memory corruption or a
crashed-then-restarted server.

It's probably safe to ignore my feelings on this one. :)

Ben


