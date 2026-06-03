Return-Path: <linux-nfs+bounces-22229-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ZdHKMS8H2rmpAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22229-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:33:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F099F6344D3
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:33:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Mq4kZ+Uv;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22229-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22229-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD483018769
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 05:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529825487C;
	Wed,  3 Jun 2026 05:33:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A33126DA
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 05:33:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464834; cv=none; b=JBIqHd1tLDzhUnSsoZdYjH17sFqAeWe54d4G4V9g7nHxAC7A9unND9FwjL6+dBTRSsj61LgDcqP8/Sb+m9hEpDNJZtZLMg+8GQWZ3tWN5gfvrX/PlYbcj7UxXZnLui/PgDZDxbvKTrMgGkqVUw+eoigQ7EAlU2xSKX6WFIwtOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464834; c=relaxed/simple;
	bh=sCUzPV9KTkFmhoJbqvS1MO+q4dB7AqJu4UxrdXNLjO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uhh78VU7jGA4rzQePmkHR/mhLj56BqLzc27br4+Ojtuk8nuzAc1+F8bAjwGpUwUFNzLgdjP9igz/VVk55bxTxGzG8ewWHrlTV7qCMIOMYoi42Isf3bjTsqpMX5lXUsZAMBJmVvV+jNSHfj8E87mo5GfvldJ74GbQ1zh0EXxXl1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mq4kZ+Uv; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf22c18ad3so46845ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jun 2026 22:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780464832; x=1781069632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVY3kbzSTSbY8HqoGi5UsE1UhNwJeV6E6So4ExjoX4M=;
        b=Mq4kZ+Uv0Bw+HR3eLMsHKjndKtazmvyCVRMQic7o+IW2fqsn3qgKltbRCibCOfnvMD
         Fz//ry3hmoN2q6b9a6rmKdf4r+PDhB3Zlh0Kf5XXOLvBpYhwTxjzxM0efIRLk59pDpEB
         GhiHFdadq7tDdF0ASV4ux3qwB98AB0KT3P19f16A2W5d1iX7sXvAX/ziw9HllL5hyZ8V
         aAJK/9nZlDBrczlmB/1J2O0Yz68IAoYS7axCJsOtlAU5BOQXG1Zrim8jyAP+rVzLoWKE
         x2VZ4RXjXZeo3rO/e+k93PwpwLVkZXGu+nuuDKm/ULkAP+XEnhlwuPPwMyvHB1rVrKNU
         NyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464832; x=1781069632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVY3kbzSTSbY8HqoGi5UsE1UhNwJeV6E6So4ExjoX4M=;
        b=ZcmNvfIEbdmmb6iaSFw8OGPNmiGvhv3Qjz/IqJiwcejc23LKHQQ43pb4UPt3QvEKZx
         6PQ4mMrjkMSB+yqQQvAWhYIWOsTaAd0td4+IpP6bjmShLix0pdAntumsksHqe3zQpFox
         eCGkuuOzTJEBunogmR6NydREmTT80cJUR7CE1Ydr/QI0+b5VKMN1N5Ox0RJG9wt4bVBK
         Bfo9JGUcJobkXTs2uqvw1JU+I4IiqtzDf1KzmBQ2vTGd/y5dcsI1uIXHsIbRJvX7341r
         GZVP69LhfkNvmQ01Q0pkzHKRSMWW8DFtI6uq3VxkK1fmYyzMNX5tbiyVGG9YpYVBF2FC
         IrZQ==
X-Gm-Message-State: AOJu0Yy8JvCuUF3mzLWH2/2a1VO5fjj5PFfc+8A2A+c+wic2C+epq86c
	eu0h+HW0usGsOCuiBwA0YLeBcyqPIE1g/Ox6Gl+SDtHyovbyYf747Zh4rQSwH56qCltgkFvReeG
	JX/47oQ==
X-Gm-Gg: Acq92OEV5NBmtqX/wbU7QGoxeNI6XDV9TZTbca1kh+/qkX4fsp+wsI8yvnbDEcmM1Ss
	5qeJO8NqThEu7FPc+8d/CyxSQHa7ADjxm2d3vUrdjMRUtbfLYiHI5c5nFYluSBF8Lbd9z+V3lGt
	Mnwh6SnnPamnMup9uPowWyOJVeVDNuvoAwxAFzKwDdJOM51iyYK7b6iLyUNG9qMaASYPC6vhjl2
	0vGUUW/VN+4743IisSMq1kMMBqL4QfG9gkvTzmyCiVf6lzzCDZz1E8guZE/TseNPr0NE9X2UMxB
	HmVKT05Pg1Y+EYUhblHj9EArVHBrXJVzZgf5evr0P/vKFlP0Kh1rOQbk/A4UBTGCw/vyCnsdNbe
	Zt4/nYIZywzViYFlNGJNDsBZU4y63L/iscrXaUxevtol9/+X6LhSL/2p3FoNaaZGrvGnAvGTg+e
	bMQRVzJah+YtY3kc6g9AeWC8b3khHcMXzzpQ/xRcmA8Hnepd5PaTnmEjzem1ylJYTu4cEUhO5Rq
	AY5Un/Kbg==
X-Received: by 2002:a17:902:ef43:b0:2bd:6dad:3df9 with SMTP id d9443c01a7336-2c16fb58110mr488775ad.23.1780464831745;
        Tue, 02 Jun 2026 22:33:51 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221c3e4sm1704780b3a.5.2026.06.02.22.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 22:33:50 -0700 (PDT)
Date: Wed, 3 Jun 2026 05:33:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v1 0/7] nfs: Modernize Direct I/O path
Message-ID: <ah-8udk7G6DT0T2s@google.com>
References: <20260603053033.3300318-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603053033.3300318-1-praan@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22229-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F099F6344D3

On Wed, Jun 03, 2026 at 05:30:26AM +0000, Pranjal Shrivastava wrote:
> Modernize the NFS Direct I/O path as a preparatory step to enable PCI
> Peer-to-Peer DMA (P2PDMA) support. Following feedback on the initial
> RFC [1], the modernization and architectural changes are split into
> this standalone series.
> 

My bad, I missed appending the link for the RFC. Here's the link:

[1] https://lore.kernel.org/all/20260401194501.2269200-1-praan@google.com/

Thanks,
Praan

