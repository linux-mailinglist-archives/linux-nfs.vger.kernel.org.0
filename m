Return-Path: <linux-nfs+bounces-15828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A9C232A5
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA8534E3AC9
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0A028E5;
	Fri, 31 Oct 2025 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="On8HoaBs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDLQwn8n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B66259CAF
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881160; cv=none; b=ZcwJqxQfxBXxXVggSVeA5TfGNj2aNV0KZfOmibLHbiwNymOs7MTad+Pd/KJWjpFj9StX8ZwzcTFA6Vhwp//GMNQhyYJzmVtos0+uLqjEqxlMMRfbLuEtp6QgyS9HjVnoIDzcqZLM3ors7j+B6CXir6NbJa1ypvF8sals0BMmO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881160; c=relaxed/simple;
	bh=l3SOeE3gqCIoaflWWEXdMpLN7P8RWPIfYqgPeCKJr3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeD9POJBhCVtNSfcc7Yk9E5grGEQbrkyN4bG9qp8I702Hv6S2YAKHKjQNPhrhGFqFZhT6wV6obQRtm7wCkrE8e5/IhWVhk1hzbCh3cQVnYeD5ehgIs6NWk51lhxIWVHkjHeqxMKOQ/Rm6oKzAhezQweK3IoJLdjDhPQvZsPjKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=On8HoaBs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDLQwn8n; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E8BE27A0162;
	Thu, 30 Oct 2025 23:25:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 23:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881157;
	 x=1761967557; bh=4oTKqg3dJSTJb+iqQwGoiKLTmiiFIr8lvr60QZWhM1Y=; b=
	On8HoaBs294EaGAh7fzTk5byJbXDMgba9OXSQwaUA6rrhjSPf11j2MvWAU9X5Ehh
	vHQXBdI3mvg4zT8mQ304JlbvPYCt5kdha7+tyttaJRKnBsOjtKf3oEcwJynOiwM/
	f89RXiJHTFsv3sA/YaS12sXNH2OwRWttLCgVIfKiw8dlsLPklkWKOfZY/IQBXi9C
	WgVylwnfVmk7k/uc2VzKtP/FbgCZ0OZLnCRk/7peKO7D3BZwNtf9tN51KGuXCJAs
	jDAkFnuNxbLE02g1Qa/jJUPNHUJ7Yk97/6ZRmwWZB6/fUf3vyWQKW5FqN/7538CX
	6cyPnm9cot7NfB9lLuBwlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881157; x=1761967557; bh=4
	oTKqg3dJSTJb+iqQwGoiKLTmiiFIr8lvr60QZWhM1Y=; b=EDLQwn8nNLIAIvr/X
	ejcSFQEpiJvyB0qlx9/WHshDIsbH54R1l4Ew357I8x1Spwndt0YbcGUkEOWgg6Qu
	xzuRAOeb4QoXzqRFGIWK/90q7T5SMu8LKw/v2qzwO6DNqQe6W/j8iTfNscT0ewZJ
	Fkx/3gcZqYD5XaAQ4uoYQMDF6LOv0unQ/IsztfVwXK6Ar/OXD7J+snzz6E5UgmIU
	/t+atp3f0A7Axd0GVnBzz9NVgSbdFvh/x6VfESayTHBEPLyAxI2yEqFm/ZAuQEXF
	JKKisD/n09H+kOv3B6iJQo59pi2OKQV7s0OUY9vzXxzmHgdgx+RcOgW3z2OJXv3E
	zANIA==
X-ME-Sender: <xms:RSwEaeHXXTDQClrFhMUAq3GK801i6vQehGhLy9tqjFn7hdJouQXruA>
    <xme:RSwEaTBSxgCIOEU_dCbFJ6yuBupuqMRN-2PVarpZwz7DK1laCVEJHc6GCKXxq0O24
    YlwVUYM700kG5EH6nortehZXAafbSY-gKypSdfOde2dobKTME8>
X-ME-Received: <xmr:RSwEaR95Sy83Twfx8fpnhsZ8KBHLoiNxzI4LQq2pbJSN8UHbJs2m0ohCA3VcPARb0Z3CKdml2g52FEIKRo7I7NyTSEh6yMzdu6Nq-Dv2O2PW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RSwEafDbdWDxDXZvsFJPrqS2jGZyQG86ne2_mK8nOfsqLKwCsRypdA>
    <xmx:RSwEaWQUfj1icfQY1q38l7RrSrvd9FEvAsbxobxEgx4MLTBYXGf0DA>
    <xmx:RSwEaWulYIjG2z9adOA24CvJUYfGoahI5fXGryYxmTMuimwrIDcVyQ>
    <xmx:RSwEaS0HcTwC34WjF9ZY1H2FMnFiOm1NfZGnNmP9XWgEmixe4g62Ug>
    <xmx:RSwEaTnsDLjAaRXpLD1XLWyg7lGxBoFP-Y2YA0eVFRilIi_xXJOl8yg2>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:25:55 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 04/10] nfsd: clear fh_foreign in fh_put().
Date: Fri, 31 Oct 2025 14:16:11 +1100
Message-ID: <20251031032524.2141840-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251031032524.2141840-1-neilb@ownmail.net>
References: <20251031032524.2141840-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Nothing currently clears fh_foreign, so a PUTFH which sets it followed
by a PUTFH which doesn't set it will leave it set.

As we always call fh_put() before installing a new fh, use that function
to reliably clear fh_foreign.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfsfh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 16182936828f..41de882ba839 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -805,6 +805,7 @@ fh_put(struct svc_fh *fhp)
 		fhp->fh_export = NULL;
 	}
 	fhp->fh_no_wcc = false;
+	fhp->fh_foreign = false;
 	return;
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


