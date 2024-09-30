Return-Path: <linux-nfs+bounces-6715-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6FE98A383
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D34E281942
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E638318E756;
	Mon, 30 Sep 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epu4p+Yk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2C18FC91
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700740; cv=none; b=KkXpBs1P61b300knGpGJ6gDV6zY6ng3iEtayHLc7nUkpjFgVcfaN7O3JzujNkEZo8AmYNVgY5irASLiU5CEUN22crFpStnJiYxcUc4a6pyGNEUxAXo3Bo7SrPWOQzgKYGypSdVJ974cTSyhfSYo4qtyxh3N9DS9i21qsrf+2wc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700740; c=relaxed/simple;
	bh=I3XAswTbM6b/JGrNsCLhXccVrlOMtrETAjtdN/rctYU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YssVmN2NukcsUUbYahf+XgGFmTtLh0qB2Dq2tzIqHgHi1Qv6DzRBvF6gSWwtrFMr48sekI5+IkSCmkjnDuP/YYAlZMaL44L/P4jhhYgoZ16YSlJd51PhBjIdOd/b6XdfTTwzokBJP0Ac6l+GlYei/led+MuRNsLwIPs2QHe0wGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epu4p+Yk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727700738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iheTQuAAGoNV0Ml7YHfX3/4X0Beg93WMcxdOLm415Rw=;
	b=epu4p+YkanmkxlxcAmHZA1kzZBHvMT/51jXdrJNtixMGbZDlaqbGafyBYfNlDQRAdpV5QZ
	Mat2dmq8qQlJ9r57zFzwRYZ1HH4H2hp8mcPA7dSCnU4kLwCIBLEbie7nncepmZoeGllLFe
	/peaMUefN595qK+JsR/6IMy0a5pRrz0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-yIEMnkANOcKlKeIOv07qjw-1; Mon,
 30 Sep 2024 08:52:17 -0400
X-MC-Unique: yIEMnkANOcKlKeIOv07qjw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E827197730E;
	Mon, 30 Sep 2024 12:52:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28F8519541A0;
	Mon, 30 Sep 2024 12:51:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2968940.1727700270@warthog.procyon.org.uk>
References: <2968940.1727700270@warthog.procyon.org.uk> <20240925103118.GE967758@unreal> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <1279816.1727220013@warthog.procyon.org.uk> <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: dhowells@redhat.com, Eduard Zingerman <eddyz87@gmail.com>,
    Christian Brauner <brauner@kernel.org>,
    Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
    ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
    hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
    smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
    v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2969659.1727700717.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 13:51:57 +0100
Message-ID: <2969660.1727700717@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

David Howells <dhowells@redhat.com> wrote:

> Okay, let's try something a little more drastic.  See if we can at least=
 get
> it booting to the point we can read the tracelog.  If you can apply the
> attached patch?

It's also on my branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

along with another one that clears the folio pointer after unlocking.

David


