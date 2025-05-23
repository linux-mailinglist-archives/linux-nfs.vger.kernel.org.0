Return-Path: <linux-nfs+bounces-11883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33258AC29B9
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479643A9C6D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2B1F09B0;
	Fri, 23 May 2025 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeNjYwc1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A41125B2
	for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024960; cv=none; b=eYfGMT32/LxStU52Mii3UFsxasCMIwh6491zF48PD2tQmZoGtG3nn7nu5oxUmug6R8XNXgW+VQKGJUjroJU2PmcxqOiNdc9wt1zFTfOloVlLLV/uUYEuLGtnr4EjisY5D9rC9xOTWhtLS0lEeArq+xHRnqE7FdrPKYNA1pwq/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024960; c=relaxed/simple;
	bh=/b3f6yXBwCtgF3Qy+X8R298+cdTXxwUnlYJqQy/UCYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uluduUqD78StZaGiuiJnYm+ToR6F84HA5NbwaLOR2s3+HolTdMeJlI1SOR3sNlqT1NtB2QVVz6SHbinTq7JWwxrGjEjTcXsgyIA+ICXNQiMmi/yARcbrAFRBSlWvuGThKMl9fuDfW4aF/rt04jlFcmNRnOBL6x671EcQ2BiBMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeNjYwc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39D8C4CEE9;
	Fri, 23 May 2025 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748024959;
	bh=/b3f6yXBwCtgF3Qy+X8R298+cdTXxwUnlYJqQy/UCYk=;
	h=Date:From:To:Cc:Subject:From;
	b=SeNjYwc1sFf+DjnpY4RPxlHkalO7czUNQiuBT/VCm/vIaLbp5Sp5pGAZ64t+1RiGV
	 7RzuCzWkH/OCanvrFp25Fg1xYSvxTIgkllDB+RYtSAEbqXzfEyWIrlQaw9/jIH19I9
	 iYW0QcGKpgUXPYEoBZVQF74Ah9kkP5utBg10yURq+FApJsVQKSXHXIo5Prz3W10LVn
	 DnaFY98SK+Q/foe7h9XNqyWo2gnjWaudvL/cn1nZTcZHNandttdb3aJJ9I0n8FA7J9
	 gJ7/ufjTAPUcIEw1OHR71X0ljSrezksOcDJ+rARQIfwy67zqU1BmOi3B1/KVAKE0oB
	 8kT+Z2jiFCIiA==
Date: Fri, 23 May 2025 14:29:18 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: unable to run NFSD in container if "options sunrpc pool_mode=pernode"
Message-ID: <aDC-ftnzhJAlwqwh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't know if $SUBJECT ever worked... but with latest 6.15 or
nfsd-testing if I just use pool_mode=global then all is fine.

If pool_mode=pernode then mounting the container's NFSv3 export fails.

I haven't started to dig into code yet but pool_mode=pernode works
perfectly fine if NFSD isn't running in a container.

Mike

ps. yet another reason why pool_mode=pernode should be the default if
more than 1 NUMA node ;)

