Return-Path: <linux-nfs+bounces-13021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E5B0350F
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A427A6E3C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6119D88F;
	Mon, 14 Jul 2025 03:50:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F752BAF4
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752465054; cv=none; b=QMpqoxCHgh8LFKTYXVplbBbOPW7jXmMUDqGmyQNBMmYHVTjwehtqSzmaWd+izPjI34QX/plPXF051HlbUu+Qd1+4icS78weyWUwOWqwRHZeQo4l7nOpN4G7/UgL12f5TCi1l/KXkLYPhPFyc5pU0d/nGftdsXAt2dG7jSMCxPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752465054; c=relaxed/simple;
	bh=B/CbzKzVVE2EPVG2agTTnB9MddxV+gdZjlCfanUqKI4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=s1GfRViuGqtk8TMN6ZSNEIvMsclydhP51Li8IvUI/523kSu3FYuCYnF+itS2lLnyi7YiY4UY28w0VlG1CJxXmW+S1QNgup0wZ1hu2rEs3STRU8ri35XWI3lDqgeFxg4NU6zYtOyblnZjdexSJ9X27/35kTiWpm67pQTApp0LyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubADH-001way-BB;
	Mon, 14 Jul 2025 03:50:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH for 6.16-rcX] Revert "nfs_localio: change
 nfsd_file_put_local() to take a pointer to __rcu pointer"
In-reply-to: <aG0pJXVtApZ9C5vy@kernel.org>
References: <>, <aG0pJXVtApZ9C5vy@kernel.org>
Date: Mon, 14 Jul 2025 13:50:48 +1000
Message-id: <175246504876.2234665.13723785598314130070@noble.neil.brown.name>

On Wed, 09 Jul 2025, Mike Snitzer wrote:
> [Preface: this revert makes it much less likely to "lose the race",
> whereby causing nfsd_shutdown_net() to hang, so we'd do well to take
> the time/care to properly fix whatever is lacking in Neil's commit
> c25a89770d1f]

Was this the first time you posted on this issue?  If so it seem strange
to start a discussion with a revert with out a clear undertstanding of
the problem...

Maybe

--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -177,7 +177,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 			/* nfs_close_local_fh() is doing the
 			 * close and we must wait. until it unlinks
 			 */
-			wait_var_event_spinlock(nfl,
+			wait_var_event_spinlock(nfl->nfs_uuid,
 						list_first_entry_or_null(
 							&nfs_uuid->files,
 							struct nfs_file_localio,


will fix the problem - I'm waiting on the wrong address, which could
cause various things to hang.

NeilBrown

