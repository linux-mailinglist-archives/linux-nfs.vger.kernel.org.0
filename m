Return-Path: <linux-nfs+bounces-11044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76990A81708
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 22:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A70B1BA05A1
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A72C241107;
	Tue,  8 Apr 2025 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFTWz1Qr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8F14AD2D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Apr 2025 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144857; cv=none; b=VLEtOZGms5ywsk7qFGj4wUOK9JPowUeTDbmEjeQXdBOnhiG4RZtP2KoLLSJ5CEjjTFpTq9/1IOuS89uGlbi3kVbYK/x7iR/xMvoip2YOaFpi++8njO1WHGvZ6wtl9lhJ2ycI07RZutJLLtM4fjY3NThYJU7rzB8XrW2/DZ2Zbpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144857; c=relaxed/simple;
	bh=cyCAPzlEjndEznfAv2ssUS5V30DJ6h4xsgL3iHIs2YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lm26IuRt8FVBxFx9h1t4mlqey0c1zP1tynDUyInPWv4u5sYE46Cc1rOkmvLWOaihYMW9Id8wo1xKJgxUr8EaudEsRkOjnzITfq8EGJDjNk+JOVfHGeuy+vyqZ1INB6VSynf9gGoxubz/Oh8/PhzplIQqXv/rzOjWfyiUld6fxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFTWz1Qr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744144854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/SSyL8Fw2lTGksU1m57SOW0NlXyQg/GmU/jpAJSemQM=;
	b=JFTWz1QrEXKfZK9/Np+XBzXTtk1uGKmdjIFjvZ2KDlsE9D3Xy+ZxhsDtDnHbvjpWH9/7YB
	UKRrbvxyAjXEXpB4CmwCA6oPTedURObzH6ErqGd2l637CgKoPSI2oZ1DUZKJcB71jaqvzB
	Rq/qLpZXCyDY8ngUxv/Wg8AJPwufaJ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-OKsV6HGlM6mEwmv2cnpCkw-1; Tue,
 08 Apr 2025 16:40:51 -0400
X-MC-Unique: OKsV6HGlM6mEwmv2cnpCkw-1
X-Mimecast-MFC-AGG-ID: OKsV6HGlM6mEwmv2cnpCkw_1744144849
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F111956055;
	Tue,  8 Apr 2025 20:40:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCE213001D0E;
	Tue,  8 Apr 2025 20:40:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Olga Kornievskaia <aglo@umich.edu>,
 Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in
 nfsd_permission
Date: Tue, 08 Apr 2025 16:40:45 -0400
Message-ID: <0A108901-1D6F-42FD-9C06-0849EC37933D@redhat.com>
In-Reply-To: <05336ea7be56be78db853a811bf740ff0d3ab1df.camel@kernel.org>
References: <>
 <CAN-5tyHKrbL9DuFxvH6hnL4uwHDZ-d49X8DFBVReCvdh+Qh0XQ@mail.gmail.com>
 <174319880848.9342.18353626790561074601@noble.neil.brown.name>
 <05336ea7be56be78db853a811bf740ff0d3ab1df.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7 Apr 2025, at 11:57, Jeff Layton wrote:

> Emulating flock locks over NFS locking is entirely a client-side
> endeavor. The server isn't aware of it. The job on the server side is
> to conform to the protocol.
>
> In this case, I think failing exclusive flock() locks when the client
> doesn't have the file open for write is the correct thing to do, as I
> think the protocol requires this.
>
> At one time, nfs_flock would reject those on the client, until this
> patch reverted that behavior:

That behavior existed for only a short time (6 months?) until the revert.

>     fcfa447062b2 NFS: Revert "NFS: Move the flock open mode check into nfs_flock()"
>
> I'm not sure that reverting that was the correct thing to do. NFS/NLM
> locking generally follows fcntl() semantics. ISTM that we shouldn't
> allow locks that fall outside of those semantics.

I don't remember the details other than we submitted that revert after
regression testing showed the original changed v3 behavior.

Is it possible that some existing v3 server would use flock semantics for
NLM?

Ben


