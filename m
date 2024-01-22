Return-Path: <linux-nfs+bounces-1273-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0849F83767B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B291E1F27D37
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78693107A8;
	Mon, 22 Jan 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtuaASZT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A010785
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963625; cv=none; b=SM8XNesyX228wwJWvccLexmz4zp0dbAUDgq0L3s4eFznreGIGc5+40GBskfoEvkkG0mLhvS3iyi/EIbWjjFyJhF0p5OeBIcyaWzyFG5LLWK1wNCLDZ0yoASEIlRlsOKMnFsaDnxirRJ5uPPhQshn/QC8Wh88WDYFubKbwyD6c7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963625; c=relaxed/simple;
	bh=3+ADYAR/ARZG33fvr+uvI9u83p/seMrSHre6h9G9GEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vfz0qzglGzjvB0GE80TdvbAqzKOJkkH5T5WB3gHz/DlXhZO39/h/Mbg8HqQbJDvwAYNwC8r/XYC6nyZl+p0ew6Euqb+jirW3emgrbQAHiy3kNEmIPKaLDUn89FCFFq9VSVkPYRJ48rrjQRazW9wk1sq0AjTL+uzkSY0NCBeEwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtuaASZT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705963622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc78rJDba/U5cIDDX5jQeqhQyYeLeOnO9pBxHMtvMek=;
	b=DtuaASZTZnHpYs6mA2xPLqxKgn6MogN7eeDfK6cFN756jI5IvHQbmlqGwMobnJiH44TU7y
	EhBv7aeVBvO5XFlNrsxlE0iD3vj8cQ5aw+Z1fzQbeWAnMxJIbqIvgctOCVa7LdcLJFeUr5
	XXFjr+RX71lYzkqcGyos6mOYr7pN/s4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-rkTWsG0UPr6aBfgFWwnh9A-1; Mon,
 22 Jan 2024 17:46:58 -0500
X-MC-Unique: rkTWsG0UPr6aBfgFWwnh9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 732E038562C1;
	Mon, 22 Jan 2024 22:46:58 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E24782026D66;
	Mon, 22 Jan 2024 22:46:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: samasth.norway.ananda@oracle.com
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [External] : Re: [PATCH 1/1] NFSv4.1: Assign retries to
 timeout.to_retries instead of timeout.to_initval
Date: Mon, 22 Jan 2024 17:46:56 -0500
Message-ID: <8B835117-498D-484E-B1DE-912FBBBCC74E@redhat.com>
In-Reply-To: <bdd760d9-9900-43ef-8000-0e9ce0aa8b3e@oracle.com>
References: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
 <995F0BB9-C709-4C3A-92F3-5EB9710A47F5@redhat.com>
 <bdd760d9-9900-43ef-8000-0e9ce0aa8b3e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 22 Jan 2024, at 17:44, samasth.norway.ananda@oracle.com wrote:

> On 1/22/24 2:41 PM, Benjamin Coddington wrote:
>> On 22 Jan 2024, at 12:23, Samasth Norway Ananda wrote:
>>
>>> In the else block we are assigning the req->rq_xprt->timeout->to_retr=
ies
>>> value to timeout.to_initval, whereas it should have been assigned to
>>> timeout.to_retries instead.
>>>
>>> Fixes: 57331a59ac0d (=E2=80=9CNFSv4.1: Use the nfs_client's rpc timeo=
uts for backchannel")
>>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.co=
m>
>>> ---
>>> Hi,
>>>
>>> I came across the patch 57331a59ac0d (=E2=80=9CNFSv4.1: Use the nfs_c=
lient's rpc
>>> timeouts for backchannel") which assigns value to same variable in th=
e
>>> else block.  Can I please get your input on the patch?
>>
>> Oh yes, this a good fix.  Usually the maintainers won't pick up a patc=
h
>> that's only sent to the list, rather the patch should be addressed to =
them
>> directly and copied to the list.  Can you re-send this patch to:
>>
>> Trond Myklebust <trond.myklebust@hammerspace.com>,Anna Schumaker <anna=
@kernel.org>
>>
>> and copy linux-nfs@vger.kernel.org?  You can also add my:
>>
>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
> Sure, I will do that. Thanks for the review.

Can you also fixup the block above the hunk you posted?  Its backwards th=
ere too!


