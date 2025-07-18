Return-Path: <linux-nfs+bounces-13139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D020B09922
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 03:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E1EA44D8B
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1317A2FC;
	Fri, 18 Jul 2025 01:28:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2346E1624E9
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802121; cv=none; b=Cb2jyjs5MyM7EWIUUvwlNeJyzOO6/BIaI7kCKIEpPN90pwGH82QM/0jjC543ARgeSV8YBGm+dTYnul01Zr7GIwgqYZ+xijOkOEpoFJKTjJMw0MwGvnXr6ttd5D5ZjTnuG7/bL8X4WZMh0kWngrBXvl9B0Jp6WhsEKyhN5BKTBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802121; c=relaxed/simple;
	bh=NDsQhfGk33QDlzBW1I71VXJbT34q1/+/NxYW19xpLf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRxCcDJj8bw2EfPTQrEWlDyfyVwOhuCtBSgTtjbK0mOY31GfIuIji762W2nm4s+632b8DhZJssgqTWOkOYYLo3xor3KvGZxXo8wQhY1AZpv1dGLsRiLilg4Fo/8BJL2+oDF/WjGcfh3Qkehb5SV65DeR8pM4Fp2jCTI7EIQ6skg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ucZtr-002QCD-Uj;
	Fri, 18 Jul 2025 01:28:37 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2 RFT] nfsd: fix another problem with recent localio changes
Date: Fri, 18 Jul 2025 11:26:13 +1000
Message-ID: <20250718012831.2187613-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mike reports ongoing problem with leakage of refcounts for the net in
nfsd when localio is used.  I believe the first patch fixes one possible
cause.  The second patch removes some related dead code.

Mike: thanks for your testing so far.  Hopefully you could find time to
test this one too?

Thanks,
NeilBrown

 [PATCH 1/2] nfsd: avoid ref leak in nfsd_open_local_fh()
 [PATCH 2/2] nfsd: discard nfsd_file_get_local()

