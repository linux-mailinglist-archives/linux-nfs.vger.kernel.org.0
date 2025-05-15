Return-Path: <linux-nfs+bounces-11734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1519AB8535
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 13:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21533AC2FD
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC11298251;
	Thu, 15 May 2025 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tOmHxkRp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A27225414
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309758; cv=none; b=NS1F90RT4W6jM5ZAtt7NRR5QCetLqg3uZHmtn9vnoI6YiVmow8uCAwQnTch0ZfnYIRZiNFANj+WjzEcX+Y6qegQW3Nix4GD6/Zs7xNctyeFjSOZOIZGue3NO10JJ/2Zx8/lUZ+yH08w9cw/apYWEdXiyHgVH3Cz0zRxVQzcPCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309758; c=relaxed/simple;
	bh=N41Tgxp+xaot2g/R6pW1juFuPbNYkFELS4FJIKQ0Nl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScRhlo7yfU93kbkvNdHaoEWvvkFI/oFGUFOG50xlJgd+10WFctUJV7dvtzgbBP5zBIOXxrBJNs87A5BVQl4jjljsY5uNuK42bZDzkHJoJ+vNaArDDj4H4NuWnE3orkOU4E0/AFTMCkCi81nu40Y4pHrd7dVzARdPGPT1degJTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tOmHxkRp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PuBmwi7YArW0JeWN9hrB3ajVIxTttZGZi15MBm6LL0c=; b=tOmHxkRpig2zCnJb3z6VAhUoHe
	HcfmjFQIUsAAdoMCzo/OkztX4+73KLe1RIjNOAV5Hh03grecxgxGhXNnAavZmkw+Q7kDalgY7ChPF
	LPSl4dKsLbN7Ckw0GR2JTaRwnJ+xxDngw8mRb8JxDtcmpKhF2DZS24Yq0UnWMlJw+vrUHHKXtGGry
	YPjhEIl0YAVKvOUkzr/3ETXFMlGoZFM7jNj2ydsaPHDRR/ztz7zCReG5OJP13YzEmZdN5TOzgVZxm
	sXsvMNXgQMY9KHVFNEXjwKphLWIY7h5ZhUyxIDOikRomV7yPXxEcjrKtzptgJbQPfiL37w/Tm88PY
	i8k1tgSg==;
Received: from 2a02-8389-2341-5b80-81b5-a24e-41ab-85a6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:81b5:a24e:41ab:85a6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFX5K-00000000S5M-07tB;
	Thu, 15 May 2025 11:49:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: small sunrpc cleanups v2
Date: Thu, 15 May 2025 13:48:44 +0200
Message-ID: <20250515114906.32559-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

just a few small cleanups done while looking at the code.

Changes since v1:
 - invert polarity of a flag

Diffstat:
 fs/nfsd/nfs3proc.c         |    2 
 fs/nfsd/nfsproc.c          |    2 
 include/linux/sunrpc/xdr.h |    3 
 net/sunrpc/socklib.c       |  164 ++++++++++++++++-----------------------------
 net/sunrpc/xdr.c           |   11 +--
 5 files changed, 66 insertions(+), 116 deletions(-)

