Return-Path: <linux-nfs+bounces-12222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C2CAD28CA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 23:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445CA3AD1BA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214222332E;
	Mon,  9 Jun 2025 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOWitg3p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C04223300;
	Mon,  9 Jun 2025 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504534; cv=none; b=bw5NnSfDjvaZ0cFeIuvfkMPmApK5kA53KdBu4CaYVM+TolEVhTGALKEWi2YDcCcBgj+ehk+Yz2+MjBax/8MVaYYhXNBLTsR0z5g6uUSN0MxJDFdIls4pZW09MYXieaWVIoY1oCuqmWKjOlRMXFO7MiM9vAlJ1gxPRuevOGXPQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504534; c=relaxed/simple;
	bh=O27KiFF9LMcqVSxOS6yJXBb/3/ezbvbeFJW3zh3Ap/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iG6xEkLSITg98PlMbROiLD7CQZbbUov9g/arb6D0eqsS9cWEZnuygUfj971KgxFud5OuxeX/M7BPtdNt836x26byOcYNjpZUzk57heWIXXTBYwAHJxUgRuHkrdXpeT4ZFKgpKJ2Id7jJnTT2Yn2wYOktnZfIMrt6IyIyu6F2i9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOWitg3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61911C4CEEB;
	Mon,  9 Jun 2025 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749504533;
	bh=O27KiFF9LMcqVSxOS6yJXBb/3/ezbvbeFJW3zh3Ap/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tOWitg3pUVNC5SGUALbM1ZDgh2qq2z11/NbUJrl5u2Rh2TijljKfxrRhHcMkjug5s
	 J31VCqvHKYGzKLmymh4RFaZbQufqCWd/AhlgliF8REz9s5ldt8mxSwRFvC0Fro8rrI
	 e8zxr2T7VJjTX9ElN0qVBmbI/8FFRFpj6aEIVqeeS5s3jhIxVKWM1PtjWm40f8LY9Y
	 2O1jFY4nWLxmW8wmyUjDOaFz1Slbpn5YOirB2GoZP2OHxGoIyF2TkEFRmXOLJAhc9l
	 TQxCyU+JhSiid7W2fIwZgHjfPtRZX+pv/zB+P87x3i55BPzcaFgAVqVc3oOC9eSSk4
	 7MHMmAJpgoXUw==
Message-ID: <d34245cfc6c3dcf86969682e7c35a131c6100d47.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 David Howells <dhowells@redhat.com>,  linux-nfs@vger.kernel.org,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
Date: Tue, 10 Jun 2025 00:28:49 +0300
In-Reply-To: <20250609040143.GA26162@lst.de>
References: <20250515115107.33052-1-hch@lst.de>
	 <20250515115107.33052-3-hch@lst.de>
	 <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me>
	 <aCdv56ZcYEINRR0N@kernel.org>
	 <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me>
	 <20250602152525.GA27651@lst.de> <aEB3jDb3EK2CWqNi@kernel.org>
	 <20250605042802.GA834@lst.de> <aEMbvQ7EekwPHQ8c@kernel.org>
	 <20250609040143.GA26162@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-09 at 06:01 +0200, Christoph Hellwig wrote:
> On Fri, Jun 06, 2025 at 07:47:57PM +0300, Jarkko Sakkinen wrote:
> > Ah, ok this cleared it up, thanks! Just learning these subsystem,
> > appreciate the patience with this one :-)
>=20
> I'm also just learning the keyring, so double checking from that
> perspective is also always welcome..

After quickly studying tlshd, my understanding is that the ".nfs" is a
"vault for transient stuff" passed to "keyrings" configuration option.
After that serials within that vault are passed to mount-options
defined in 1/2.

Stating the obvious, just checking that I understand the user story...

BR, Jarkko


