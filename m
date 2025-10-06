Return-Path: <linux-nfs+bounces-14997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1738BBF02D
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA5A3BB414
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D402D9498;
	Mon,  6 Oct 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAnCluax"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC02DEA7E
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776306; cv=none; b=eULKD4aqq0Fg/2lJXgIBi9OqhV61pk+G0mW9lkkfVeugkrtSLnEUavFAMB0bAY9+Rt7bnEI9oepoPxkUxBmVOVzES9y9qPw3Z+e/NWWZJ59U/TrIxT+oxPrF+YoCKFfk8RruVezGH5NrUYhdY27llJkkLH6/VMwyh5yjMKIeaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776306; c=relaxed/simple;
	bh=9GWjNONHRTaDmsmptE+lC18+L+/pjHighzEprVeZDaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAgZANfN/ANnvAKaOOk5XIBTI4oXvlHSUyEM+ifgJ3k1l2WzlsNQ4Alxbq9I/8JrOhDsIE75fCD2DlGIN2zZHaUhqPwiJ4PxcXklW5Up/acVU2HcFVHoeZKkR2w+1yoUWdUjVw0hahRQHoQSDSt1VhJm2xF4/Cy2tR2UhqvzaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAnCluax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4CDC4CEF5;
	Mon,  6 Oct 2025 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776305;
	bh=9GWjNONHRTaDmsmptE+lC18+L+/pjHighzEprVeZDaA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZAnCluaxMstmVhY8Dq+6lRDmqWCjGXkOEByKvmrd2/s4eFGs3A5+mhxRWSDdWdgB5
	 mnJAQLaMbfEaEsWF+1kA7qwFy+kHB+oFeFaYWxtrn9T00xqCDhbNncgrWKtUd6+ybg
	 uZrS5Lfzy/LAqXdGkdZ6/d08wwSei+LnUZ13h4AxSH4obz15qi0peb8QROj8T9T3Jw
	 OLGgiyLlz+j+m2k0OUywie5PAJJEbaQX0UIJ70uevMJpeeLd2YAegTCSVZQ2xhC8AK
	 o/90pR8jvMPAdZ29ZZACvBAPm/T/Zmoc/dZ/rqblz20+I4MN4pf5BlPi8s/d12vfbs
	 RprBeo1yucwgg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/2] Fix unwanted memory overwrites
Date: Mon,  6 Oct 2025 14:45:00 -0400
Message-ID: <20251006184502.1414-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

<rtm@csail.mit.edu> reported some memory overwrites that can be
triggered by NFS client input. I was able to observe overwrites
by enabling KASAN and running his reproducer [1].

NFSD caches COMPOUNDs containing only a single SEQUENCE operation
whether the client requests it to or not, in order to work around a
deficiency in the NFSv4.1 protocol. However, the predicate that
identifies solo SEQUENCE operations was incorrect.

(Based on my reading of RFC 8881, I'm not sure NFSD should cache
solo SEQUENCE operations that fail, but that is perhaps for a
different day).

Chuck Lever (2):
  NFSD: Do not cache failed SEQUENCE operations
  NFSD: Skip close replay processing if XDR encoding fails

 fs/nfsd/nfs4xdr.c | 3 +--
 fs/nfsd/xdr4.h    | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.51.0

[1] http://www.rtmrtm.org/rtm/nfsd185f.c

