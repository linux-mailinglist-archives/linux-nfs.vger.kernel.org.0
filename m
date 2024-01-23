Return-Path: <linux-nfs+bounces-1285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73BE837EED
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 02:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B9D1F2B875
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 01:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166AF604D2;
	Tue, 23 Jan 2024 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvjfgLrN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04E604CF
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 00:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970830; cv=none; b=ZJq0vuHXpI0D02HSr6rzZASJnThg8EWWoyYBMBwW3FOCOAgEyuPl4v5e3r0llUyel+HIS4Wtig4LX3qprHQVMAN4EGrIErtYl/wBEhIM8lQuMf066rRmeVLcMtilt1I6p9X0bTn9xxu20lcvw41KgeHvlgjZDlAysCEO6PZMBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970830; c=relaxed/simple;
	bh=r0x9oVHyYfQx6xZ52ktOx24MvQQeCqwGomRzxWAMYLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLRklrdTWrSnnU4bhxz0cAGIJ+VEsyDZBeyfLusDn3FWO/ann2JDykfMrjmy9DagXAr03P2e5pZPk07OLo6zmbNV9N1BHq/hJ8/khXCxwqQ9CX/0Xwmz5eN6XcIppaMzuCYwDsrvzH8ptifvXAULZijieRUyZsp0Hbk/pt852y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvjfgLrN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705970827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6z0dYc7+EGgdUZl8TRdZSe3kfy1nqLBE1f4qkCbRlo=;
	b=LvjfgLrNE8+A4fkflDHNHc7ZnHUY+9P4ikS+jGl33kTnem/oXVjzmKho2mO1PO/siTFLWi
	QXNLAqjzg2fpisaV66/2fqYDJ3WzhRq/oUSiEAfScBkkuv0pSZxIT+BPTAM+28oKhhFw4e
	KxHoPJCYDSIzCtA2rRd4H26O7x2NEHo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-ZZU344sdPieKij5WcSjw9Q-1; Mon,
 22 Jan 2024 19:47:03 -0500
X-MC-Unique: ZZU344sdPieKij5WcSjw9Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E777280FEC5;
	Tue, 23 Jan 2024 00:47:03 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F378B492BC6;
	Tue, 23 Jan 2024 00:47:02 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: samasth.norway.ananda@oracle.com
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [External] : Re: [PATCH 1/1] NFSv4.1: Assign retries to
 timeout.to_retries instead of timeout.to_initval
Date: Mon, 22 Jan 2024 19:47:01 -0500
Message-ID: <3AFA6113-0445-4EC0-83DC-96396C8FDAD7@redhat.com>
In-Reply-To: <324d4e4e-4685-4341-a7b7-c73de473c57e@oracle.com>
References: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
 <995F0BB9-C709-4C3A-92F3-5EB9710A47F5@redhat.com>
 <bdd760d9-9900-43ef-8000-0e9ce0aa8b3e@oracle.com>
 <8B835117-498D-484E-B1DE-912FBBBCC74E@redhat.com>
 <Za7x2aYNRqc3nIbl@tissot.1015granger.net>
 <8DCCEB9D-5504-4DD4-A042-61C99D22A462@redhat.com>
 <324d4e4e-4685-4341-a7b7-c73de473c57e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 22 Jan 2024, at 18:07, samasth.norway.ananda@oracle.com wrote:

> On 1/22/24 3:03 PM, Benjamin Coddington wrote:
>> On 22 Jan 2024, at 17:53, Chuck Lever wrote:
>>
>>> On Mon, Jan 22, 2024 at 05:46:56PM -0500, Benjamin Coddington wrote:
>>>> On 22 Jan 2024, at 17:44, samasth.norway.ananda@oracle.com wrote:
>>>>
>>>>> On 1/22/24 2:41 PM, Benjamin Coddington wrote:
>>>>>> On 22 Jan 2024, at 12:23, Samasth Norway Ananda wrote:
>>>>>>
>>>>>>> In the else block we are assigning the req->rq_xprt->timeout->to_=
retries
>>>>>>> value to timeout.to_initval, whereas it should have been assigned=
 to
>>>>>>> timeout.to_retries instead.
>>>>>>>
>>>>>>> Fixes: 57331a59ac0d (=E2=80=9CNFSv4.1: Use the nfs_client's rpc t=
imeouts for backchannel")
>>>>>>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracl=
e.com>
>>>>>>> ---
>>>>>>> Hi,
>>>>>>>
>>>>>>> I came across the patch 57331a59ac0d (=E2=80=9CNFSv4.1: Use the n=
fs_client's rpc
>>>>>>> timeouts for backchannel") which assigns value to same variable i=
n the
>>>>>>> else block.  Can I please get your input on the patch?
>>>>>>
>>>>>> Oh yes, this a good fix.  Usually the maintainers won't pick up a =
patch
>>>>>> that's only sent to the list, rather the patch should be addressed=
 to them
>>>>>> directly and copied to the list.  Can you re-send this patch to:
>>>>>>
>>>>>> Trond Myklebust <trond.myklebust@hammerspace.com>,Anna Schumaker <=
anna@kernel.org>
>>>>>>
>>>>>> and copy linux-nfs@vger.kernel.org?  You can also add my:
>>>>>>
>>>>>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>
>>>>> Sure, I will do that. Thanks for the review.
>>>>
>>>> Can you also fixup the block above the hunk you posted?  Its backwar=
ds there too!
>>>
>>> It's backwards in a different way.
>>
>> Its an artifact of my text editing..
>>
>>> And should you set to_maxval in both places as well?
>>
>> IIRC it does not need to be set there.
>
> Ah okay. So it should be like this right?

Yes!  Good catch.  Thank you!

Ben


