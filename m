Return-Path: <linux-nfs+bounces-8488-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11679EA406
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 02:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD6E166E91
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 01:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28609134B0;
	Tue, 10 Dec 2024 01:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rhUJCTiS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CC22092;
	Tue, 10 Dec 2024 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792570; cv=none; b=CiIkTvqvt5Jqd5k4h5/6FebWcmEt5KbksIMIk1eAal7gGAgeRiLB71DR46Gh8PayI851sy0Mr8qS0dYG9BWg9dOyDpw0zi1s1nI9CZl6iqibhGyWgTuk0sZ7dMxRmdhf3PLUQm++GPjBu28L7luWyZB0YX/iUxpfDRzqakw8r4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792570; c=relaxed/simple;
	bh=p/5AWqZaj024rsVYdJI1Q2n9RpO+c+9BlKdB4PUzAp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmaKOyQA8XfOXArIsncA+x6myDRBr5ua8mR29mbpVcDbdIDXH9iZFxLMMh8vaQ3OCRv59uxKG6TxQuegw+T17kl8RUsYh31pWEKR2QL1isTkD5gLOv7b33Hi7FmD71u0ttClo+oaXYD3s7UK/n6dyPd0TKoPCAJj+Eah2XVw0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rhUJCTiS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=fKfFzwBT2tq5xy+y0ceX0rFHUd9ACjHlyn2oZK5pcdE=; b=rhUJCTiSliPDE5vp
	cukzU+yic+BQ1GtmUQj1Ks4/tg+0S50ODaAO0nixZLMojmw7hH3s2SEVHyJHHz+kXubC3tFxob4Ra
	y4Q76z4TnZp3lllI0N6VCpIi1jUumztgrd0LAtS2o0ch8P2NwCyXDn3NWxmfVgAn07v+r/usSky3x
	Rn0SDo6yGyylzcDQ/Y65SR0zvRx6alGDFkW8Q3yHohTFbJpTqvC8pk41RmCCJgTyMxsEDI8W3Ly7D
	E665xiNv7U/LGLt/BIw2+rOpS8P0lOTl8b4ahtIZaqcBmFVXgdRaiBJo09RDDFhGz836RfBOIPSsC
	WdRcHqcHm4exgXN0Ng==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tKodw-004Oea-2Y;
	Tue, 10 Dec 2024 01:02:28 +0000
From: linux@treblig.org
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] sunrpc: Deadcoding
Date: Tue, 10 Dec 2024 01:02:22 +0000
Message-ID: <20241210010225.343017-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is a bunch of deadcoding around the sunrpc code.
This all removes whole functions/definitions/files
rather than changing any actual codepaths.

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dr. David Alan Gilbert (3):
  sunrpc: Remove unused xprt_iter_get_xprt
  sunrpc: Remove gss_generic_token deadcode
  sunrpc: Remove gss_{de,en}crypt_xdr_buf deadcode

 include/linux/sunrpc/gss_asn1.h         |  81 ---------
 include/linux/sunrpc/gss_krb5.h         |   1 -
 include/linux/sunrpc/xprtmultipath.h    |   1 -
 net/sunrpc/auth_gss/Makefile            |   2 +-
 net/sunrpc/auth_gss/gss_generic_token.c | 231 ------------------------
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |  55 ------
 net/sunrpc/auth_gss/gss_krb5_internal.h |   7 -
 net/sunrpc/auth_gss/gss_mech_switch.c   |   1 -
 net/sunrpc/xprtmultipath.c              |  17 --
 9 files changed, 1 insertion(+), 395 deletions(-)
 delete mode 100644 include/linux/sunrpc/gss_asn1.h
 delete mode 100644 net/sunrpc/auth_gss/gss_generic_token.c

-- 
2.47.1


