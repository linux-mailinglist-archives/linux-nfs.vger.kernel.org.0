Return-Path: <linux-nfs+bounces-8040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F39D157B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD6B1F2366A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC01C07FC;
	Mon, 18 Nov 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAYvSFxp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C51BF80C
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947979; cv=none; b=bnaLCWtg4SrmVl/qxCJczfPgeKIu/SRHSN6AfyuzJheyoD8OJ/R7ZG4KIhrjE3tLcLgAHrBQU15sZYUg1MZfJ4IzN4E+4Q06JUXqYZIJp7XNF05Qz3byCdUjv8PNWxrjPKa19b/cXXtI3PIRUjGu9WCGOzz35fVbDiTuA62Ur9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947979; c=relaxed/simple;
	bh=4VLAsz3gLkTJFtFpCPDvTF204CR43uOYtq/o7M5cR6I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FY2IjrkLvNEQOvj8epqWP9semVx/LAZAjd/+noqq58kvmVbKwY7nf4tW2DtwnbO5dlT9uaRrcUlvLny9t6DzsEA3IyPwZP30sc4+VODYhp0uZVS6MQyof8YXWXpatAeGeSPocGuLOv2k6LZ+moGVm97Q0mRa4An+KEQQbWCMvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAYvSFxp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731947976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TBgXpcOkE91KJWIrvCU0ksBJeSHSjTfC1vv3ct4vww=;
	b=FAYvSFxpk4Tl7m9G+xpiVJYP820uAbRAfMzL4D613zvhwZfnkzxBryKzW8bkGv4xzg1oes
	k4NWXshA2Dfj8zRWL49zEisZ/SpHsARW9dAfwsa05NOv+IK5tEnViyb9uR2cFAMF4CzTo9
	3DzVtBsMDA5lNyLO6zEKNMrdOvz4734=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-r1Nbp_NqPiyaaS_1Yh73TA-1; Mon,
 18 Nov 2024 11:39:32 -0500
X-MC-Unique: r1Nbp_NqPiyaaS_1Yh73TA-1
X-Mimecast-MFC-AGG-ID: r1Nbp_NqPiyaaS_1Yh73TA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6604A19560BA;
	Mon, 18 Nov 2024 16:39:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E035195607C;
	Mon, 18 Nov 2024 16:39:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b7135da8-a04f-48ec-957f-09542178b861@ijzerbout.nl>
References: <b7135da8-a04f-48ec-957f-09542178b861@ijzerbout.nl> <20241108173236.1382366-1-dhowells@redhat.com> <20241108173236.1382366-8-dhowells@redhat.com>
To: Kees Bakker <kees@ijzerbout.nl>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/33] netfs: Abstract out a rolling folio buffer implementation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <941711.1731947960.1@warthog.procyon.org.uk>
Date: Mon, 18 Nov 2024 16:39:20 +0000
Message-ID: <941712.1731947960@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Kees Bakker <kees@ijzerbout.nl> wrote:

> > +		wreq->buffer.iter = wreq->buffer.iter;
> Is this correct, an assignment to itself?

That should just be removed.  Both branches of the preceding if-statement set
it.

David


