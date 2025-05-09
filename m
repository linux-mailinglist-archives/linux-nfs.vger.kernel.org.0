Return-Path: <linux-nfs+bounces-11611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB76AB0749
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 02:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6579916A561
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 00:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA38225D6;
	Fri,  9 May 2025 00:49:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A241F5EA
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751757; cv=none; b=kx+KTHy37hC+7nYIh7Kj0TcBVnfLsN5NYgd6cHEfAwjpPS39FcGDq0lnMmMMi3TTkiCH8sQ6+rAnARXFPGtsOySLaHBIGr96buZpVO4l2JOIAPkr+dbE1HvBPW56tH2mCsbZ0cTy/35AfzfthVjcnd2SnI2HkXEYdvmK/ogtw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751757; c=relaxed/simple;
	bh=gHMn0/pUv6G9Po9+jiWD2EzCK/mfENlEp+zVO6+gu+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CY2gIc39qx0e504GeUCBxdhLcV3BgwdvN+jfTkHw3bSejgirtlElu8DrSNFExPZNtyAk8Z14nyYpAKmF6hETxneXIRC/F1NTjq+H2P/QRNEQOnd8yIBFN1Q3XzityOGT5C3K0FCyrc8WM4G/L93XJ1me7QdnPrwDwlg84JDl8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uDBvG-00HQUZ-99;
	Fri, 09 May 2025 00:49:06 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from older compilers
Date: Fri,  9 May 2025 10:46:37 +1000
Message-ID: <20250509004852.3272120-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a revised version a the earlier series.  I've actually tested
this time and fixed a few issues including the one that Mike found.

Original description:
  Following the reports of older compilers complaining about the rcu
  annotations in nfs-localio I reviewed the relevant code and found some
  races and opportunities for simplification.

Thanks,
NeilBrown

 [PATCH 1/6] nfs_localio: use cmpxchg() to install new
 [PATCH 2/6] nfs_localio: always hold nfsd net ref with nfsd_file ref
 [PATCH 3/6] nfs_localio: simplify interface to nfsd for getting
 [PATCH 4/6] nfs_localio: duplicate nfs_close_local_fh()
 [PATCH 5/6] nfs_localio: protect race between nfs_uuid_put() and
 [PATCH 6/6] nfs_localio: change nfsd_file_put_local() to take a

