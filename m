Return-Path: <linux-nfs+bounces-11932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F773AC5E07
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 02:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57DB9E45BE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 00:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCEF8F6F;
	Wed, 28 May 2025 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blyGnUhz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE468F54
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390918; cv=none; b=sRrPdyLhZ1sTtTn5/MQm0Y2a3WF9ZtJFQpSYpDBnZIZ4WWlw4pq8HJW565SplL+tcL78AhTZ8sH7tlZo/yUQfv0MAZO8Zgx5inGgT2FIujhRUpRdSKCjm1U0pNenb2o2p3CrbXzXomzlDoJ5PcdveO/0LIi7CKlhWVDEBbi0Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390918; c=relaxed/simple;
	bh=j/0XsU6Q9cuIXUfcLmtRgtnjkAuyN3cdl5XIeJpdye0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGN0GGMa/eKbq0ijQ7AyytbAxv4d60v6iOjRJBDD7yIG7dTQMBt8DcGvp5AsaP99D9TD9BNLz6vuCqpE5V3mQkkwHVhlgfzhgGdqAGB1OQS+7Xcsql5zB0GKucoUwdRk1PQ/1hR07IvmI2kZMOU1gEBjSxSj4MyP4MFm4tAw+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blyGnUhz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748390915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUWplp8APHzL0C6wa7FjYaIkogUqyQ4mGEyhMRoLP9M=;
	b=blyGnUhzhwCWJ2H+gNPtf2Xgg9Gw+Fpy5Xk5hff53OVxcnTOvHQLvNRboPj4wqi0Ber54F
	HXoT5/etKzuFpXMW1YTyoeU8yJTrXpitbV95YNe/AmoevOLBlVt2eEXjmtDqDAQoePeLPL
	9XgMPmxhRKD7vU+KCKufrLscaJpVm5g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-13d66DEuNYWg897C5-J6rA-1; Tue,
 27 May 2025 20:08:31 -0400
X-MC-Unique: 13d66DEuNYWg897C5-J6rA-1
X-Mimecast-MFC-AGG-ID: 13d66DEuNYWg897C5-J6rA_1748390910
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88F871956087;
	Wed, 28 May 2025 00:08:30 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C625F180047F;
	Wed, 28 May 2025 00:08:29 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Support btime and other NFSv4 specific attributes
Date: Tue, 27 May 2025 20:08:27 -0400
Message-ID: <1C356965-867D-48B2-BAB1-C63FD6533CE0@redhat.com>
In-Reply-To: <cb113c0832d61ddddde7f01b3b78eb877a1f8cc5.camel@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
 <CFFDBCDF-F7E1-447C-ABB8-4777995906D2@redhat.com>
 <cb113c0832d61ddddde7f01b3b78eb877a1f8cc5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 27 May 2025, at 17:54, Trond Myklebust wrote:

> On Wed, 2025-05-14 at 09:15 -0400, Benjamin Coddington wrote:
>> Hey Trond and Anna - this series looked ready to go, but seems to
>> have never gotten upstream.  Was there a problem that needed work?
>>
>> I'd like to rebase these and submit them, but will hold off if its a
>> non-starter..
>>
>
> I believe the main issue raised at the time when we submitted all these
> attributes was that we had the ioctl() to retrieve and set them. The
> request from the community was that we use statx() to retrieve, and
> then add a new system call to set them.
>
> btime already has support in statx(), so there was relatively little
> work needed to convert these patches to use it.
>
> However for the other attributes (Windows Hidden, System, Archive
> attributes and the backup time) the main issue was adding the new
> system call to set them all. That work is yet to be done due to lack of
> developer time.
>
> If you have time to revive these patches and push the btime changes
> upstream, then that would be very welcome from our perspective. I'm
> happy to help in any capacity that I can.

Great news!  I did rebase and post just the btime portion, it needs a v2 so
I'll work on moving it along.

Ben


