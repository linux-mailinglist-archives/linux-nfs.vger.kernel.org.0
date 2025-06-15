Return-Path: <linux-nfs+bounces-12467-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69122ADA46E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 00:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7093D3AF77D
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Jun 2025 22:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A541DFD86;
	Sun, 15 Jun 2025 22:40:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267872E11D0
	for <linux-nfs@vger.kernel.org>; Sun, 15 Jun 2025 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750027218; cv=none; b=qnlg+uRosnYFh28zrm80+pGUBoZa6BM+/W0A67DBUE9S439HdeXNCi8Y8p352skzcHMQtQs6SdaBb3ZxlkUwYrlLP3bB+RgvAyx1m3qFGcZ1gjjr4K60Hz6+LhjVIoMe3floB0VLtf6a1OtBQVje1kfuUDuJCI5qgWUFrkJY2Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750027218; c=relaxed/simple;
	bh=Q6rbkxoLMNlOziRz6RhDSD92K25FfOTCKTALZ1bCPRo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Ns9buQNJX7qJOS8nvR+6yVXbrPGFzDyYWy2fJeBLAkkSoVOyylUOgO0o6jm+6oxBmxoLgJ3bFm6KLcy1RJw9lZmJUQ5RbMJVImG5bNrx8N1HWhkpxCvl+8j6DEdnvtbP+wxHGf4Ca+sSqbjS48stqZBxD1PV5raCxm7/BG/ImSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uQw0B-00FJdb-2e;
	Sun, 15 Jun 2025 22:38:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH v2 0/2] Make NFSD use the vfs_iocb_iter APIs
In-reply-to: <20250613200847.7155-1-cel@kernel.org>
References: <20250613200847.7155-1-cel@kernel.org>
Date: Mon, 16 Jun 2025 08:38:48 +1000
Message-id: <175002712868.608730.5719831983511634260@noble.neil.brown.name>

On Sat, 14 Jun 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Mike has expressed interest in making NFSD perform direct, uncached,
> or asynchronous I/O, independent of how the target file might have
> been opened by the file cache. To do that, the idea is to pass in
> RWF_ flags during each VFS read and write.
> 
> However, Christoph suggested APIs that already exist which
> streamline the I/O operation a bit and expose the per-I/O flag
> setting directly. The suggestion looks to me like a straightforward
> and sensible general clean up of these code paths.
> 
> This series refactors nfsd_iter_read() and nfsd_vfs_write() to use
> those APIs instead of vfs_iter_read() and vfs_iter_write(),
> respectively, as a first baby step down this path. No behavior
> change is expected.
> 
> Chuck Lever (2):
>   NFSD: Use vfs_iocb_iter_read()
>   NFSD: Use vfs_iocb_iter_write()

It important part of this change (as I see it) is that we no longer have
to go through kiocb_set_rw_flags() (which vfs_iter_read/vfs_iter_write
do) but can set the IOCB_ flags directly. Eminently sensible.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

> 
>  fs/nfsd/vfs.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> -- 
> 2.49.0
> 
> 


