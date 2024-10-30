Return-Path: <linux-nfs+bounces-7574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4789B6584
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 15:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A812823D0
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE592286A8;
	Wed, 30 Oct 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q527+oDR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC71EF0A2
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297962; cv=none; b=tcHLm0mJmD4BKlj7yzvfUJ6u9z1hDK/l/0QzoJi54tA91BNpenrDVw4XEXIU3h6o+M0b4lSEUSZefIj7TQChtDWVnlR6byELkrOTH0sgvFKDCDm/QXNhQXUR+MpFyJctYwffYKTn8M872X2f30Xt36ZJ4Sa5UuCHZD8RyF/lwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297962; c=relaxed/simple;
	bh=Dm7ynew1GVdwvoY08q2Ii5t6qd0Y2rvnVQlVsjBquvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iW3NEPv0EAiKIwuWp5nug3J1pQWKveWJ00NiIoLhhQewjQkKycNvkdxGZNPofGXG7gC7GEaxBnbZzqu+F6YTn3a231dWwGjfANoSjOdvL+QWCZ1TTzgi4L3nBSWfO/loW3rP+fUXlJofLbS0DVe7SCBHIS9S+89+Fcdped2/X1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q527+oDR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730297959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWy2w4g7aSxL5VJdllkpevHG7k0N9WQEDNpOzvH1luI=;
	b=Q527+oDR2F6JTNQWdgAEGNzDGHz7eskBSP2hXulRB1z5p6vrOgC0usbGn8znLH84VJhrHG
	oMr1tLxtwkL2WsczKBdSCCJrFJvrgmTDSVZlF1Tk0qajPfffSvUxGf2mEuDzY9uipEcmQp
	5YAxpLf1/YY9v6DcbT5y2YQzJomtSI0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-Ps3JfjhcMVGEDLE1BmTh0g-1; Wed,
 30 Oct 2024 10:19:16 -0400
X-MC-Unique: Ps3JfjhcMVGEDLE1BmTh0g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8947B19560B7;
	Wed, 30 Oct 2024 14:19:15 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.17])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 283FE1956086;
	Wed, 30 Oct 2024 14:19:13 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] dm: add support for get_unique_id
Date: Wed, 30 Oct 2024 10:19:11 -0400
Message-ID: <313BC47B-6069-4AB4-BD44-F71461726F8B@redhat.com>
In-Reply-To: <20241030140823.GA29475@lst.de>
References: <f3657efae72f9abb93d3169308052e77bf0dbad6.1730292757.git.bcodding@redhat.com>
 <20241030135214.GA28166@lst.de>
 <ABD563AE-C7F3-43C2-A698-479C7D5924BF@redhat.com>
 <20241030140823.GA29475@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 30 Oct 2024, at 10:08, Christoph Hellwig wrote:

> On Wed, Oct 30, 2024 at 10:05:03AM -0400, Benjamin Coddington wrote:
>> Match each other in a multipath device you mean?  No, this will just return
>> the first one where get_unique_id returns non-zero.  Can they actually be
>> different, and if so should we return an error?
>
> That's what I've been wondering.  IIRC you can in theory create a
> kernel mpath table for any devices you want.  multipathd only creates
> them when the ids match, but do we want to rely on that?  It might be
> perfectly fine to say if you break you keep the pieces, but then
> I'd expected a comment about it in the comment.

Comment is easier than comparing them all, I'm happy to add it.  Seems like
a mpath table with different devices would make little pieces of anything
you try to put on it, and you wouldn't even get to keep those pieces.

Maybe other dm experts can think of ways that might break things.. I'll wait
a day or so.

Ben


