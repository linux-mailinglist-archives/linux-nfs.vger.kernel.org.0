Return-Path: <linux-nfs+bounces-2225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4770B87498D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02835282307
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E323F63408;
	Thu,  7 Mar 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7M2n6+E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C663108
	for <linux-nfs@vger.kernel.org>; Thu,  7 Mar 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800011; cv=none; b=EdTTisxj5KL6nLDwfUa/quqau0HDqhNma2hvOj7i0K7rxcEWUsRiB8pH7tRueLuIcgK28kE+M2fS1PtOqcDYcG5LbBM448YlIlMtRQ1Cb/hnKaOIttyVwpwKLXCkABaSwHbZ44I2mVnVoEhnPIeh2WdwM3etecZL0ev/InrGST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800011; c=relaxed/simple;
	bh=GSLLGWd6A4v0+iH8U2RooYpIV7bjKBaVVn5koXyUZhs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=m9yFlRptqnTeA+vDfZxQZ0ImJbZzAkAYrW+Pp1Efh2GncwmdNhkmxHJxgfS2iOzi0AWvYk79NYqn7nO0vwlIPJmiMgpZ+QcdsPIXTmFhqnA6tebq3J7ZucOQ+CwUjYBIRO4EzG4Q2l1tmaY1q8acM6zP7Ln4OwqvLBkxzNCpPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7M2n6+E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709800008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNYFlX4GZ3sigkzX5bE6FkuPu9beg0e7HrY2SFlhQWw=;
	b=D7M2n6+ELIkA/LpEb6DVjp1eWj36HncEC6hLeIMsmQS0uvIrD0X0cTc6J34kd/qO4FoMKw
	1pSMTz0LgDii0RoL+RVGJpr69xKg4cWq/dGKB4lFPf7xtxCyvnXQumgp2DRB1insrDncOJ
	FFtvOtSOPaqFZT4GjsLTAETeCBKbOwQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-YCH9Z4zEMva3JJyiGTu8eQ-1; Thu,
 07 Mar 2024 03:26:45 -0500
X-MC-Unique: YCH9Z4zEMva3JJyiGTu8eQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A97D91C006AE;
	Thu,  7 Mar 2024 08:26:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 177F9C37A83;
	Thu,  7 Mar 2024 08:26:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZelGX3vVlGfEZm8H@casper.infradead.org>
References: <ZelGX3vVlGfEZm8H@casper.infradead.org> <1668172.1709764777@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1821329.1709800001.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 08:26:41 +0000
Message-ID: <1821330.1709800001@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Matthew Wilcox <willy@infradead.org> wrote:

> commit e3db7691e9f3dff3289f64e3d98583e28afe03db
> Author: Trond Myklebust <Trond.Myklebust@netapp.com>
> Date:   Wed Jan 10 23:15:39 2007 -0800
> =

>     [PATCH] NFS: Fix race in nfs_release_page()
>... =

>       invalidate_inode_pages2() may find the dirty bit has been set on a=
 page
>       owing to the fact that the page may still be mapped after it was l=
ocked.
>       Only after the call to unmap_mapping_range() are we sure that the =
page
>       can no longer be dirtied.

Is that last sentence even true?  It evicts folios from the TLB and/or
pagetables, but it doesn't actually trim any mmap made - in which case,
userspace is perfectly at liberty to regenerate and dirty the folio the mo=
ment
the folio is removed from the page tables.  Otherwise DIO-to/from-mmap wil=
l
deadlock.

> but my belief is that we should be able to get rid of it.

I think you're probably correct.  The best we can do, I think, is to prefa=
ce
any call to invalidate_inode_pages2() with a flush-and-wait over the same
range.

David


