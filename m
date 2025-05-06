Return-Path: <linux-nfs+bounces-11482-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0699CAAC44E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DD41C40273
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E590264A94;
	Tue,  6 May 2025 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q+h8M64j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C124A064;
	Tue,  6 May 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534931; cv=none; b=Wu6F04T498ZBhbOHXkIk/Ji7wuO2btDWTi7JENorZack/lAImAaSk6e+dPdIrBDIakrPOrAJKJQDnhVb74ogugOm0tvYwOjPyB8b2imtw5Nqp95sQ6b5N5IPY0yFZzlK6enEUVI1gcgsQ5pdaFPrYWliToJdDLB7gRVbJg1Qt28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534931; c=relaxed/simple;
	bh=+fhwOP/3/B2wsnbOVQ1c4FIhhI42+6jd5j5i6FRtfqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju58W8oxaiwEZi6jVwojplQZnXXxKAhpG+4HfUsVn0eitNbo7eKpxiqB+u+7CHt3Zqhucf5dj3Xljw7ft+Nqd1rnCUGy55D6AhjJ/pQdT1QLsRbJdK1U8pSRz8nVw7Y7hgs6WYcaiD9ONXf3Jd/dbbOFpCpsYbSB4hzp69JLKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q+h8M64j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bOPiUlyrhnx8kdBc4QcgN2Kg8jvl0sf6Xkm8mhk+a6s=; b=Q+h8M64jqwdaeKk/O/6FV2IigZ
	346w80zwtwJLWCGGsy6ryxa4fZxTGUnyXLwibFKl5yKHW2qMYmDd9vldF2dBS4+nIFQCq5wlSKwuC
	UAT/RtrjffK6v5+9VBZJbDi0h//7ka+hbZuz6CrC7ccuQ/Vt9Vsabglm9VS5w5SoltJ1xPltETdZu
	rvpJdHzAildYkHSO9O34Lti398Y9d9LIIOTuoQULjm9iQODUGrxFgai8rBjC1JMqc5fqDoU+Zb/Gk
	Gn3t6ug3hpmArqktiNNrFVgXGB2kiIKL5E5HLCE2ipwSeX18Pmt5wmPJWJusAhdYNi5F54llmGSPc
	PHX4ls6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHWC-0000000BwJu-1g9F;
	Tue, 06 May 2025 12:35:28 +0000
Date: Tue, 6 May 2025 05:35:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBoCELZ_x-C4talt@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Chuck,

let me use this as a vehicle to rant^H^H^H^Hprovide constructive
feedback about configuration of the tls upcalls now that I finally
got around playing with both NVMe and TCP over TLS.

For modular systems configuations the amount of monolithic state
in tlshd.conf is a bit unfortunate.

For NVMe it isn't all that bad, but having to hardcode the .nvme
keyring still means that:

 - we need userspace configuration past just enabling tlshd to enable
   any kernel subsystem using TLS upcalls.
 - hard code the keyring used in the userspace configuration

Can't we ensure the upcall passes the keyring to use and avoid
this issue entirely?

For NFS hardcoding the keys and certs in tlshd.conf is even more anoying,
because it limits to a single client key and cert for the entire system.

I have a hacky little patch for the NFS client to pass keyids for the
client key and the certificate as mount options, which seems to work
nicely, but it still requires adding another keyring (see above) or
giving the user read permissions for the keys while it would prefer
that it would just work and we would not need to give any root login
session a way to read the keys.


