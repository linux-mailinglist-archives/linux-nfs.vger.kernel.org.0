Return-Path: <linux-nfs+bounces-7531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9B89B3371
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F2B20DB0
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631C81DD55F;
	Mon, 28 Oct 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0kb3Fnc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382411DD54E;
	Mon, 28 Oct 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125596; cv=none; b=dYifys9kKaRbAaofb8qj7ayrSYrg/qKSPFgy++k6QJwkB9JnzAAArcEF2HTWt53jKKqt5ejUxlyQeNm9mT1csuVLA3ZRB3DleF4BlZoEEq3WA/7ETeO4UBV4nlwX8x/EhZDwgwBWvebtlWjChSSGoBNfjAMMaPVIffmso95RPwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125596; c=relaxed/simple;
	bh=aQgdnCTlshHk4fjpJOtdl5tKqwZEI/Fr3LqR7xtBxMY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VuaqE3Dbxu7TB7g2J9iUWuIHXoKGZozleKWm35EO2a2IyXzjOmou06IT5eHkcFnq+s5YFZM+B6ieOfjf9Ea5PcP81zbYwybQSfaF7Qmg7l+Zz13Z0Jb1Ji4XaL3HZvE/jAjx4/q5PCJacv7Gb1eziWQM8xDAQASv4PxcVPvsZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0kb3Fnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6C7C4CEC3;
	Mon, 28 Oct 2024 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125595;
	bh=aQgdnCTlshHk4fjpJOtdl5tKqwZEI/Fr3LqR7xtBxMY=;
	h=From:Subject:Date:To:Cc:From;
	b=c0kb3FncSC6eUa6cakoJ5gJUT6K5bSdBL+iBVUGvh0w6orJB6senX94jYYgXAMxjI
	 a0qORY9Xd5kYJTTnyT7uYrZlw94c0Cmzw99gVblAxRZpPAJKl14mVFg1/88gBGlrTm
	 TK60Gir/cMLsJHS7h/qbgtMB4vnEZtXSSvLIqRtsp/ynBnFyoWwYHDv8RhlbJw/ir1
	 5WswecqQ5P+6nWYSQcN9IiQVAterdTaElZG6e3MDuRCNoCE+T67bj2qVgl/DQdlAXg
	 qLrGtYmXwX6gOS6ayKylw7E0OfNcrWE1rJfr63EnrSklqJP162/VjJENMXp6kq3tsh
	 Y+JwLV7by0fxQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsd: allow the use of multiple backchannel slots
Date: Mon, 28 Oct 2024 10:26:25 -0400
Message-Id: <20241028-bcwide-v1-0-0e75a8219dc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABGfH2cC/2XMQQrCMBCF4auUWRuZpGkLrryHdNEkYzsoqUwkK
 iV3N3br8n88vg0SCVOCU7OBUObEa6yhDw34ZYozKQ61waCxGk2nnH9xINW7MJB1fRucgXp+CF3
 5vUOXsfbC6bnKZ3ez/q1/RNYKVTCI7UCdxcmfbySR7sdVZhhLKV8vkrDqnQAAAA==
X-Change-ID: 20241025-bcwide-6bd7e4b63db2
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aQgdnCTlshHk4fjpJOtdl5tKqwZEI/Fr3LqR7xtBxMY=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGcfnxagHnOdWGumOD7khYJvLF2HA3f5ulQXtLnzXV3fMZXtn
 IkCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJnH58WAAoJEAAOaEEZVoIVAlsQAMWs
 3KkdLDI4mvHCtGw9CAFpvu3bM6WyAx14HpHbMFPZs46G74bbIorq/xfg/fsOjBHnTYaDuBHdgrN
 /6dX+o32a9vMiFy7UtUzx9/ORfNFnPH2+tZ8g7TW00qLKYcWnBmusf1ILSbpzRPRK/gHHlrw4C9
 RazDpPXxw10gyCErbobjPIPISqtgQ9jGaxHU1+ui1Xea7YwADakNV6tPOYVdavuwkd6Nb+0zTg9
 moPwcHwRlzpTsZnF+WKLZETDScNAei82bY4p2018VDrNMJHauLaqS5x2AHF+DugoJAjkpzx6PWa
 KTHSuW1fQcoFkWX8UfaaM7ipO3I2iX8QbEGboJ2nd+rCrlWu8yBisMCddSfU6BYreDU3JJeK1ft
 frMlxthzBkz+2j5uH+xkIMD6KyhPOempOo36/c+xVV/xK6fXtxcw3iKRQAtau8knGBoWLxql32g
 BPT2jEZHXik6C60qgIDStEGMXtWk/bxzrE/yCUs/GD20bUZwWznDsz8nHKXpmsuX7kl9nuAQCrh
 osPGSbm98eGGrVnu2INrE0XHKDlnXZDlyv7rfDCHc+E3fJa7dzh43sN3kRWoTbbgjn62LfSPcQ2
 T0c+plrvfiVxmwX3B236Gm6Em2HluxX5KwkV/ZNlnLqpimggTLaa/sK00GM51EQ1NoR/HpiWyWh
 xASlY
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The NFSv4.1 server code has always only supported a single callback
slot. This has the effect of serializing all the callbacks on the
server, which can cause a bottleneck when there is a lot of callback
activity. This patchset allows the NFS server to use up to 32
backchannel slots when communicating with clients.

Note that so far, we don't have a great way to drive a lot of concurrent
backchannel activity with standard testsuites. I did set up a server
with two clients and had one client open a bunch of files, and a second
client fork off a bunch of processes that statx'ed those files
repeatedly. With that I was able to see the parallelization in action
via CB_GETATTR activity. I'm still thinking about how best to test this
with pynfs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsd: remove nfsd4_session->se_bchannel
      nfsd: allow for more callback session slots

 fs/nfsd/nfs4callback.c | 107 +++++++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfs4state.c    |   9 +++--
 fs/nfsd/state.h        |  13 +++---
 fs/nfsd/trace.h        |   2 +-
 4 files changed, 89 insertions(+), 42 deletions(-)
---
base-commit: c7b8826b41906db1c930cbb10abb94eb24247f20
change-id: 20241025-bcwide-6bd7e4b63db2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


