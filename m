Return-Path: <linux-nfs+bounces-16683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB8FC7E305
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E6B3ABCBD
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092FD2D5C61;
	Sun, 23 Nov 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGltJtHU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91782D593D
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913388; cv=none; b=bVWQvhuxWcsbjNr5a7Gqn5VGfOTKoHd0sPc8BCH25M4ZFO/PSp3xP6ZRdzhiKmiTnaJBU/dqc/EAMHEu6L6l9ulJhXkZK32CnCXz61zCBsaaB/5hchfdgOw2ftokCNz6UG2266AIroYrfNA3me3gcD7ehQFbIWDsIE34NN0eNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913388; c=relaxed/simple;
	bh=6rs7TOJ3iQc/MATI3xheLE6VFuQLjMwGiSIx5Jr2yS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVx4luRMriOeyGVPqmiHuARodopG0l1CBCfAd9HxjUT2VgBIOGJk5W95allq3CdaDylJT71iu39Q51zeTFipwa6nLemgno8q/YB5qvjzFKvhSFVDxFwVquKB/RaaBlQpmTEem0ObDE0q2Ed0TJ8HWmtZumJZKZpXvqeR4ck+DSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGltJtHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742B3C113D0;
	Sun, 23 Nov 2025 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913388;
	bh=6rs7TOJ3iQc/MATI3xheLE6VFuQLjMwGiSIx5Jr2yS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGltJtHUP0JACM0UlKRBF5Fcoa0sU4qIGhDTaHZdDnVwrjWUOTpl+yKcDvhgUXH0Y
	 NXUOMX8MV/nYeYvcb7iSVJ3J+BttQShHRZ3UvnhTcc+VWamfaHxCP4eiiyPh0CRdhp
	 1QUOh23ASYw+NqHbM+uCHb2JmFBq9u/g2QmwVLIad/EjzG7k+noz606tI3LJhXco2m
	 NxYZspOKFf9/KqKtGDDsNrCs/m3DwDWjnRqDZ691/DTVoKcyTk8B9f4YFWpD2+SzcZ
	 3gPSPI8PJsxMNf31Q/vnoO8tkqEQYZ5H5XQGJTfoN6C1VL0Rn0GcOr7omcl49w7ne2
	 QSm3ZNWra9Fpg==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 03/10] Add helper to format attribute bitmaps
Date: Sun, 23 Nov 2025 10:56:11 -0500
Message-ID: <20251123155623.514129-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123155623.514129-1-cel@kernel.org>
References: <20251123155623.514129-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to add several new attribute-related tests. Introduce
attr_bitmap_to_str() in nfs4lib.py to convert attribute bitmaps to
human-readable symbolic strings.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.1/nfs4lib.py | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/nfs4.1/nfs4lib.py b/nfs4.1/nfs4lib.py
index d3a1550f1ce1..5c2149002a27 100644
--- a/nfs4.1/nfs4lib.py
+++ b/nfs4.1/nfs4lib.py
@@ -564,6 +564,75 @@ def attr_name(bitnum):
     """Returns string corresponding to attr bitnum"""
     return bitnum2attr.get(bitnum, "unknown_%r" % bitnum)
 
+def attr_bitmap_to_str(bitmap):
+    """Convert an attribute bitmap to a symbolic string representation"""
+    attrs = [
+        (xdrdef.nfs4_const.FATTR4_SUPPORTED_ATTRS, "SUPPORTED_ATTRS"),
+        (xdrdef.nfs4_const.FATTR4_TYPE, "TYPE"),
+        (xdrdef.nfs4_const.FATTR4_FH_EXPIRE_TYPE, "FH_EXPIRE_TYPE"),
+        (xdrdef.nfs4_const.FATTR4_CHANGE, "CHANGE"),
+        (xdrdef.nfs4_const.FATTR4_SIZE, "SIZE"),
+        (xdrdef.nfs4_const.FATTR4_LINK_SUPPORT, "LINK_SUPPORT"),
+        (xdrdef.nfs4_const.FATTR4_SYMLINK_SUPPORT, "SYMLINK_SUPPORT"),
+        (xdrdef.nfs4_const.FATTR4_NAMED_ATTR, "NAMED_ATTR"),
+        (xdrdef.nfs4_const.FATTR4_FSID, "FSID"),
+        (xdrdef.nfs4_const.FATTR4_UNIQUE_HANDLES, "UNIQUE_HANDLES"),
+        (xdrdef.nfs4_const.FATTR4_LEASE_TIME, "LEASE_TIME"),
+        (xdrdef.nfs4_const.FATTR4_RDATTR_ERROR, "RDATTR_ERROR"),
+        (xdrdef.nfs4_const.FATTR4_ACL, "ACL"),
+        (xdrdef.nfs4_const.FATTR4_ACLSUPPORT, "ACLSUPPORT"),
+        (xdrdef.nfs4_const.FATTR4_ARCHIVE, "ARCHIVE"),
+        (xdrdef.nfs4_const.FATTR4_CANSETTIME, "CANSETTIME"),
+        (xdrdef.nfs4_const.FATTR4_CASE_INSENSITIVE, "CASE_INSENSITIVE"),
+        (xdrdef.nfs4_const.FATTR4_CASE_PRESERVING, "CASE_PRESERVING"),
+        (xdrdef.nfs4_const.FATTR4_CHOWN_RESTRICTED, "CHOWN_RESTRICTED"),
+        (xdrdef.nfs4_const.FATTR4_FILEHANDLE, "FILEHANDLE"),
+        (xdrdef.nfs4_const.FATTR4_FILEID, "FILEID"),
+        (xdrdef.nfs4_const.FATTR4_FILES_AVAIL, "FILES_AVAIL"),
+        (xdrdef.nfs4_const.FATTR4_FILES_FREE, "FILES_FREE"),
+        (xdrdef.nfs4_const.FATTR4_FILES_TOTAL, "FILES_TOTAL"),
+        (xdrdef.nfs4_const.FATTR4_FS_LOCATIONS, "FS_LOCATIONS"),
+        (xdrdef.nfs4_const.FATTR4_HIDDEN, "HIDDEN"),
+        (xdrdef.nfs4_const.FATTR4_HOMOGENEOUS, "HOMOGENEOUS"),
+        (xdrdef.nfs4_const.FATTR4_MAXFILESIZE, "MAXFILESIZE"),
+        (xdrdef.nfs4_const.FATTR4_MAXLINK, "MAXLINK"),
+        (xdrdef.nfs4_const.FATTR4_MAXNAME, "MAXNAME"),
+        (xdrdef.nfs4_const.FATTR4_MAXREAD, "MAXREAD"),
+        (xdrdef.nfs4_const.FATTR4_MAXWRITE, "MAXWRITE"),
+        (xdrdef.nfs4_const.FATTR4_MIMETYPE, "MIMETYPE"),
+        (xdrdef.nfs4_const.FATTR4_MODE, "MODE"),
+        (xdrdef.nfs4_const.FATTR4_NO_TRUNC, "NO_TRUNC"),
+        (xdrdef.nfs4_const.FATTR4_NUMLINKS, "NUMLINKS"),
+        (xdrdef.nfs4_const.FATTR4_OWNER, "OWNER"),
+        (xdrdef.nfs4_const.FATTR4_OWNER_GROUP, "OWNER_GROUP"),
+        (xdrdef.nfs4_const.FATTR4_QUOTA_AVAIL_HARD, "QUOTA_AVAIL_HARD"),
+        (xdrdef.nfs4_const.FATTR4_QUOTA_AVAIL_SOFT, "QUOTA_AVAIL_SOFT"),
+        (xdrdef.nfs4_const.FATTR4_QUOTA_USED, "QUOTA_USED"),
+        (xdrdef.nfs4_const.FATTR4_RAWDEV, "RAWDEV"),
+        (xdrdef.nfs4_const.FATTR4_SPACE_AVAIL, "SPACE_AVAIL"),
+        (xdrdef.nfs4_const.FATTR4_SPACE_FREE, "SPACE_FREE"),
+        (xdrdef.nfs4_const.FATTR4_SPACE_TOTAL, "SPACE_TOTAL"),
+        (xdrdef.nfs4_const.FATTR4_SPACE_USED, "SPACE_USED"),
+        (xdrdef.nfs4_const.FATTR4_SYSTEM, "SYSTEM"),
+        (xdrdef.nfs4_const.FATTR4_TIME_ACCESS, "TIME_ACCESS"),
+        (xdrdef.nfs4_const.FATTR4_TIME_ACCESS_SET, "TIME_ACCESS_SET"),
+        (xdrdef.nfs4_const.FATTR4_TIME_BACKUP, "TIME_BACKUP"),
+        (xdrdef.nfs4_const.FATTR4_TIME_CREATE, "TIME_CREATE"),
+        (xdrdef.nfs4_const.FATTR4_TIME_DELTA, "TIME_DELTA"),
+        (xdrdef.nfs4_const.FATTR4_TIME_METADATA, "TIME_METADATA"),
+        (xdrdef.nfs4_const.FATTR4_TIME_MODIFY, "TIME_MODIFY"),
+        (xdrdef.nfs4_const.FATTR4_TIME_MODIFY_SET, "TIME_MODIFY_SET"),
+        (xdrdef.nfs4_const.FATTR4_MOUNTED_ON_FILEID, "MOUNTED_ON_FILEID"),
+        (xdrdef.nfs4_const.FATTR4_SUPPATTR_EXCLCREAT, "SUPPATTR_EXCLCREAT"),
+        (xdrdef.nfs4_const.FATTR4_SEC_LABEL, "SEC_LABEL"),
+        (xdrdef.nfs4_const.FATTR4_XATTR_SUPPORT, "XATTR_SUPPORT"),
+    ]
+    result = []
+    for bit, name in attrs:
+        if bitmap & (1 << bit):
+            result.append(name)
+    return ", ".join(result) if result else "(none)"
+
 class NFS4Error(Exception):
     def __init__(self, status, attrs=0, lock_denied=None, tag=None, check_msg=None):
         self.status = status
-- 
2.51.1


