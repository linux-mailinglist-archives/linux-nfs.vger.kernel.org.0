Return-Path: <linux-nfs+bounces-11016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E495A7CECA
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C8188CE79
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0233F204F94;
	Sun,  6 Apr 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAwrIv5O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DA13AD05
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743954358; cv=none; b=byvYEpsgA460XZFtTq6QEyISTDeWrH+Z82w80ZCKpgULGw+xFF12KBj7BhgdytQfvwRGpB6vTHhDaaERX3VG/njkOA3ECiDNHxlfmVCTEuFqnGU/vP67uIAvQZJJttsrGIydET9r+En4qvEDw9Gj+sasKjdeMxzZBpTBoRgAraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743954358; c=relaxed/simple;
	bh=zH3u2tFZKLshgwE9zvC1UxesBOqKPx68miv9r5pEDIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRtZLIsSMMpxUmEVKVQZ4tIm6TLunlLjGdRqk+iH47gMGeW9Zmkr4h8HeVjW2pUnxqo+l2N7xvkNve89gRzcwn8P+1zOWOiuC4vciR+S/kcs9aTGAfVsnvjwwpLkoi7grfmvjWnAtSXUcOXt9yzaZoxvOZZOizIO2QaeG76SsbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAwrIv5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF5C4CEE3;
	Sun,  6 Apr 2025 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743954358;
	bh=zH3u2tFZKLshgwE9zvC1UxesBOqKPx68miv9r5pEDIM=;
	h=From:To:Cc:Subject:Date:From;
	b=vAwrIv5OWxoAdBuTgrGCoxw8LsG0+fkCKCA7uHzxy5vA/99UzNoBOXMvoG4j5uVch
	 lLl1zXxa1+N4vWjBIc8jH7xrVx7AC+DmxjH134rL/3blRLYdc4oUay5+Lq/Trzi3Yl
	 wQCypTjel82ZVJt+5ZpvJavc3zfImaGkZTPam2kDe42lUu3XTpatriNr6lOT67WCj1
	 YiEQAB4OytMDJ8youMhBIOQmfG+A1CGz7kRwNl6ygUUlJcIUNc2t981wZC/IUrZ2WL
	 nJ4CMqIKEBR58FcM0nSUEH6kud4GsXk7sbPH4+ObRdyV5WMWTZ+HZEwI7yRaChi5fl
	 +ie2HLZ/+Z4wg==
From: trondmy@kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Two more places that need to handle ENETDOWN/ENETUNREACH
Date: Sun,  6 Apr 2025 17:45:51 +0200
Message-ID: <cover.1743954240.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Omar Sandoval reports seeing layouts that are leaked when a container is
shut down uncleanly.

---
v2:
 - Fix issues reported by Jeff Layton

Trond Myklebust (2):
  NFSv4: Handle fatal ENETDOWN and ENETUNREACH errors
  NFSv4/pnfs: Layoutreturn on close must handle fatal networking errors

 fs/nfs/nfs4proc.c |  9 +++++++++
 fs/nfs/pnfs.c     | 12 ++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.49.0


