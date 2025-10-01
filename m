Return-Path: <linux-nfs+bounces-14836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA13BB07FC
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 15:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DD116D879
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874CC2ED871;
	Wed,  1 Oct 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZdWoQSy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F53A8F7
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325074; cv=none; b=VqQKOFnJ9nlf/hFgd67vWUXILbk7WEhnZtCIRFHPzEntg6WSMo6YqeEOxt15rLMtOsFAyKgYzIjrq9eD4BjefoDEpxBmBofP7DNX1Y2nFjw8A7kVC1ZxnqK33tFEEAJyZu/4IohhgQA+w8fvfSVKXffBbjignGgwj9GpkH0c+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325074; c=relaxed/simple;
	bh=Zu8GtvgmkghrBufghrrSl6h+FkegwtHaq5ry7bXNBWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0yp3sAenY2msDflOvmkJn86edXWKqi5ZHa0CwiQsFKPv8CiXNynI3+mgfwerzrzVQvMK9of0vI1MQIQjIBzZ6oFWLCva5d8fdT/k4SUIacBxdGuSRtiGZpT86d/Nyd3aqHeIcYe3oHzoE3ry93GXG1DXTxlcmd1fpna4eJYPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZdWoQSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48671C4CEF4;
	Wed,  1 Oct 2025 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759325073;
	bh=Zu8GtvgmkghrBufghrrSl6h+FkegwtHaq5ry7bXNBWg=;
	h=From:To:Cc:Subject:Date:From;
	b=JZdWoQSyqz7yE5hgPYb23I+96UfL5+++ZYKZngKJ6XDPQa7Uxoq7eu0BPhrwPL91S
	 f1nNemX/dvSmXLdJk+Jl0MhswjKJgAmKrRny3orDz2DfVophVngEkK5mvBGRBxvkNW
	 mF9SfKZ+oQB1GzO9Cx8Xp5nulnsvu+UEN1nFU7ZqqJ5pMDRq5ITv++9Wzjo2hrcbCd
	 uOSrYvXG10kENZy1epEI9np3UoS960Hb3fTqN8IdjQeGp9ojRfXxJuN9rzAa3ze18C
	 IWLCAoG/65JpDaERnNX5qHBxQdX7B4cSdBsjXWoVsSzqO4dCvwrBD/F+skHX3Ft2uF
	 a3d6Q5vofPT+g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Update comment documenting unsupported fattr4 attributes
Date: Wed,  1 Oct 2025 09:24:31 -0400
Message-ID: <20251001132431.9882-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

TIME_CREATE has been supported since commit e377a3e698fb ("nfsd: Add
support for the birth time attribute").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index bdb60ee1f1a4..6812cd231b1d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -395,14 +395,13 @@ enum {
 #define	NFSD_CB_GETATTR_TIMEOUT		NFSD_DELEGRETURN_TIMEOUT
 
 /*
- * The following attributes are currently not supported by the NFSv4 server:
+ * The following attributes are not implemented by NFSD:
  *    ARCHIVE       (deprecated anyway)
  *    HIDDEN        (unlikely to be supported any time soon)
  *    MIMETYPE      (unlikely to be supported any time soon)
  *    QUOTA_*       (will be supported in a forthcoming patch)
  *    SYSTEM        (unlikely to be supported any time soon)
  *    TIME_BACKUP   (unlikely to be supported any time soon)
- *    TIME_CREATE   (unlikely to be supported any time soon)
  */
 #define NFSD4_SUPPORTED_ATTRS_WORD0                                                         \
 (FATTR4_WORD0_SUPPORTED_ATTRS   | FATTR4_WORD0_TYPE         | FATTR4_WORD0_FH_EXPIRE_TYPE   \
-- 
2.51.0


