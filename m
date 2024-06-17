Return-Path: <linux-nfs+bounces-3899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B840690B21A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC0328861B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2DD19B5B5;
	Mon, 17 Jun 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIjeiUcF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BB194C6B
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632188; cv=none; b=hO2madp5sT0HyyLekIgIVj9AKTsHOAM4ATFNf28nKUkt3fCjWHQpKS12CiHkSeuBU6u0DQIU36Adl7bmWD58KaDc1/BnoGo3VquwM4KvM6l9IadgOIVMx9TQ96WfQ8Y91TznEFgmJkHcpAGw5VwG8oqdnD97WBJGj3qG3/1vuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632188; c=relaxed/simple;
	bh=Cta9FEZW2jKUMp1ni7LEVw6pwDqm8iS07zPeeRzgmm4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIbhTVdDHhCqwlhijBcmORQGuB9+GgTM83VhhpDhhT8B+dcczK8zWR4wZfYK5tuyZ24ifz+ymHYwsOZ1PUyijTr6c0swbHNrEKFOpp6fN+aV1VvtU+F9nSsy7aB+MH1K1FWop4aMwjYEnwB1MCW232itGHNp4cd7brjpvXnxIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIjeiUcF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718632186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cta9FEZW2jKUMp1ni7LEVw6pwDqm8iS07zPeeRzgmm4=;
	b=DIjeiUcFWzfOgI799obrrhKOlAZ8U9b2V0kfsltbIkMhbOTYkAEGYYeHtdwADU9zbtgN0t
	dhXL8J9HMxknpl99UhOXg/vdfdGhGP8d2j0ZNSaIpPQrPvrw3+fiH0AjYVMUFc9mJ/oN9U
	1JcGtoGEKNj/QabtNqQa9D4kj7umXa4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-KjdOjSSSOZq0tusy-DzQPA-1; Mon,
 17 Jun 2024 09:49:44 -0400
X-MC-Unique: KjdOjSSSOZq0tusy-DzQPA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26F3819560B3
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:49:44 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40FD31956048
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:49:43 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: knfsd svcauth_gss_ oops on 6.10-rc2
Date: Mon, 17 Jun 2024 09:49:40 -0400
Message-ID: <721C0350-F45A-4923-AAF6-2CAC430F3940@redhat.com>
In-Reply-To: <F5C621C3-EE32-4D4D-8ABE-E2A337651E59@redhat.com>
References: <F5C621C3-EE32-4D4D-8ABE-E2A337651E59@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 17 Jun 2024, at 9:46, Benjamin Coddington wrote:

> My aarch64 system just popped this on a krb5i mount.. I will investigat=
e, but maybe looks familiar:

Nevermind, gah - Chuck's already fixed it (4a77c3dead97339478c7422eb07bf4=
bf63577008), and I reviewed it.. sorry for the noise.

Coffee.


