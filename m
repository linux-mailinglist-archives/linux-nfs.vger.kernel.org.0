Return-Path: <linux-nfs+bounces-9082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C2A088F0
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 08:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17863A8EB4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C8714A08E;
	Fri, 10 Jan 2025 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQ2LA5hF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DCC2C6
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494465; cv=none; b=u8lzjJU+dNleHK8mqUam502Q6WgYe327JuCiT7HpQDnmQ41O2qyvf8NV6tH6IUKIEWz9fOtVjW/UdRzYR9wW8eApxJGJADpj9Mn1Qct8ZDQHT/0yiQaqcsswY3aBzGPStnYKYM6hKE6CxzCsvbyN366grHH69jC39a7c85Tr3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494465; c=relaxed/simple;
	bh=sTJ+hZN2LcR24cVozieVOxjojgy6K2eGueL0rS8Bu1s=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=DbrAEg/2WHGx395+sz0Bslz10BW3j/lFTS95E+cNS1pF/JuvOOvuE/TVhu7wMktHSbwMOuWRc+QTNEHLrKyD2Hsc0upA4SsvvaLiUZ2FqTEmqggm29NEDqIKmcMieFgnOE7kcwPQJO63Xq7SxsgfJJqsZYBh9mfhaLvz8dqY7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQ2LA5hF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736494462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9HOM+mW+PNbdvdR9YUqOCML6H4X28NFg2Df5cgsARQ=;
	b=FQ2LA5hFFBNLEDVZt9GNYcwHclkJJKq/5uBr090psfJnpvEyUoPzAiEvch7m3VW/yUywI0
	ylNpA54giz2xBPdh0aeORq5WXs3eO7/vM2V/2GFZK6/Ohs2s4Bhkxqx4W3i8JWq0xmHpio
	onVg9eKowYymlI/VWkk3sbY4xpejd8s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-WEchz7qiOY65-SCNEzlT7A-1; Fri,
 10 Jan 2025 02:34:19 -0500
X-MC-Unique: WEchz7qiOY65-SCNEzlT7A-1
X-Mimecast-MFC-AGG-ID: WEchz7qiOY65-SCNEzlT7A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3134D195606B;
	Fri, 10 Jan 2025 07:34:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 440E81955BE3;
	Fri, 10 Jan 2025 07:34:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250110024303.4157645-4-viro@zeniv.linux.org.uk>
References: <20250110024303.4157645-4-viro@zeniv.linux.org.uk> <20250110023854.GS1977892@ZenIV> <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    agruenba@redhat.com, amir73il@gmail.com, brauner@kernel.org,
    ceph-devel@vger.kernel.org, hubcap@omnibond.com, jack@suse.cz,
    krisman@kernel.org, linux-nfs@vger.kernel.org, miklos@szeredi.hu,
    torvalds@linux-foundation.org
Subject: Re: [PATCH 04/20] dissolve external_name.u into separate members
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1479432.1736494451.1@warthog.procyon.org.uk>
Date: Fri, 10 Jan 2025 07:34:11 +0000
Message-ID: <1479433.1736494451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Al Viro <viro@zeniv.linux.org.uk> wrote:

>  struct external_name {
> -	struct {
> -		atomic_t count;		// ->count and ->head can't be combined
> -		struct rcu_head head;	// see take_dentry_name_snapshot()
> -	} u;
> +	atomic_t count;		// ->count and ->head can't be combined
> +	struct rcu_head head;	// see take_dentry_name_snapshot()
>  	unsigned char name[];
>  };

This gets you a 4-byte hole between count and head on a 64-bit system.  Did
you want to flip the order of count and head?

David


