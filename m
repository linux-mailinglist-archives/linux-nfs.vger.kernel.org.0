Return-Path: <linux-nfs+bounces-13144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B3B09A06
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 05:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E9F178CB3
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8237143756;
	Fri, 18 Jul 2025 03:00:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF6198851
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807615; cv=none; b=OYePnA3fCLVHmF/FSplAEBusc5RxeWAX2V8qJaMIg0Sp+aA6AwoechECbYhaX59eyHZrUb2BGMPVBhA8xxljQAoGQZjUL2ftV1qdCRfSoTIoxK91pQSbn8nr+njQpEFZzv2je01Jne1lz2yEi45sQOlKA2U+VRRwB1CHWrU7L/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807615; c=relaxed/simple;
	bh=r3k5Gpg5iNp1lRPR1FVjaBmmUh7S3Xfcg3IuiBNYZwA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ad5mVGc6dNc9XD6+GiZxCfWWmJJoeizjMwBGAZMjfaeemrJHwURs/Q/PSrd418ko5NTr818CVepn4Ge1iWML9tqyI5SdhmaBxWfV2TTXMmDCm6ihIH7MtptmnljGvb2hEbaIpNUHDDEh5tSb/urwZFpSOMVzWWXADhwycZEBg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ucbKT-002Qrj-M4;
	Fri, 18 Jul 2025 03:00:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: avoid ref leak in nfsd_open_local_fh()
In-reply-to: <aHmzU6vqIg-y82oy@kernel.org>
References: <>, <aHmzU6vqIg-y82oy@kernel.org>
Date: Fri, 18 Jul 2025 13:00:11 +1000
Message-id: <175280761115.2234665.10301819687828257529@noble.neil.brown.name>

On Fri, 18 Jul 2025, Mike Snitzer wrote:
> On Fri, Jul 18, 2025 at 11:26:14AM +1000, NeilBrown wrote:
> > If two calls to nfsd_open_local_fh() race and both successfully call
> > nfsd_file_acquire_local(), they will both get an extra reference to the
> > net to accompany the file reference stored in *pnf.
> >=20
> > One of them will fail to store (using xchg()) the file reference in
> > *pnf and will drop that reference but WONT drop the accompanying
> > reference to the net.  This leak means that when the nfs server is shut
> > down it will hang in nfsd_shutdown_net() waiting for
> > &nn->nfsd_net_free_done.
> >=20
> > This patch adds the missing nfsd_net_put().
> >=20
> > Reported-by: Mike Snitzer <snitzer@kernel.org>
> > Fixes: e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for getting=
 nfsd_file")
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> Tested-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
>=20
> Looks really solid now, thanks!
>=20
> Mike
>=20

Thanks Mike - I appreciate the prompt testing!

NeilBrown

