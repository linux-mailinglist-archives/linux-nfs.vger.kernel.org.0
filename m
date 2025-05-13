Return-Path: <linux-nfs+bounces-11686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2C6AB5681
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2867A6B55
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBC298CCF;
	Tue, 13 May 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvVyacIG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE028F936
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144230; cv=none; b=GIdOXxkOuIVtL04EQq30dfR8aUIIw1pMqolKEVq2lBW1Z/o1v+SD/p16H/E9c4Hx6FYJ9Ao5sF88oBwHOzkkYLLFSs4IZCD+Uiq9C+hgThY+2qb4SWoVES/EiEzig5VasWfxZcaNVsGAhh8YnYFiGKRZ/HWJ1RfpKgIS067kmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144230; c=relaxed/simple;
	bh=v317FDSyvUMqQa5W9LprttS4HdqXp+GUzxqytxP1hbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=prmSD6O2N46nTNQqYPa9I0OSbq5zv12Tr5yGR1DFgDCosOpXHNQ5ItCCU0HqIIG2UOAsedbEZuUd5psxp3CXh2PHSe7NLuyxxPhOzDJO1gOX8OGC1Wj3CPoy70jYg/e3l0MQrmrA74U0Q0ooevxO1CkWPqRHHjkADRg4R1USdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvVyacIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5395FC4CEE9;
	Tue, 13 May 2025 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747144229;
	bh=v317FDSyvUMqQa5W9LprttS4HdqXp+GUzxqytxP1hbw=;
	h=From:Date:Subject:To:Cc:From;
	b=AvVyacIGpSeqWcL3SuAcoFUFiFYmrz8QpBui+yYunQmIisEO/4PNlDnBrhdAcu93w
	 3OGeOo9Gl2XMhGMMiHBAiyaHFmIT9EED5BBkKjO9++JoVJmLxc6o4IG6nR+xDgOkez
	 jsSWs4ubEY09By/oh5et01pDOFqBFMLd1yeqlg0xe8OsusVQwdwuZ1Z5L/I0U9SdvE
	 2IPiSc0kz/I3YKgy3xmfiVzf0a9LfN8Cj7E6w5kNZsU8opdLjv1EX4HcuIsb3U6KLK
	 MBzTlRoTC12n329O8XIeGAlUjKPxqgV9xW+g45Xlcu6kva/sbClanQ+b2U3UDcI54b
	 RA0CKIPiBCNLQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 13 May 2025 08:50:22 -0500
Subject: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-master-v1-1-e845fe412715@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB1OI2gC/x3MTQqAIBBA4avErBPUkrSrRIt+xhooC6ciiO6et
 Pzg8R5gjIQMdfZAxIuYtpCg8gyGuQsTChqTQUttpFGFWDs+MArrXFVKW/W9LCHFe0RP9z9qIHg
 W50ELQ/u+H+A80aBjAAAA
X-Change-ID: 20250513-master-89974087bb04
To: Steve Dickson <steved@redhat.com>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=v317FDSyvUMqQa5W9LprttS4HdqXp+GUzxqytxP1hbw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoI04kjtNeEXuQUR42A/L7NCKE+5nW8jLhwplcz
 M+T0rHielqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaCNOJAAKCRAADmhBGVaC
 FdKtEADEkNK66iRvYNK+vHISKDZ3PXzhJOMhKeecSEuZcdiFoE24k7uEVSpCqDmHSm0rp0lkLJq
 Y+nOYWEvDlxUCNFSn+5QyAgj+aMHmeG9kbm80QaTeJROtdD7BEbPNxroMw6VdLcLXgenpAOwInU
 orEyJLTQ0SRHW5oWqg1tuM2BfWF/IsNi9wG8/aF0XSnLozb8coxwouhzk2u0fpQoDBhxXcpcido
 SSdp8rsi7FN8v2GoCykiTYn52cDuk+IhTnExuLgkt4+LK2W2kIsWO2nSBxXUHS1cAybLvgdyWLW
 MXU0T0mxg0yt/aONm0dDMh72q9rSymb06qjLFiE1OJlWzm57yBos1wB1pvrcR8uy1WBbLHcshUu
 b1T1atD2KgnI+X0QJNb0aF1N2UA2FtVzfxipYMIoWUdQsBmzbk99KsTpQia87k3lY9IY389owyZ
 e4qSYwiGWErz5UqMh/l5K4shD7ixRYClKffEXmqM0/xeWrbsZU3Sd4jIs4KAAMMdSKR4cA30eC7
 15rirk98jk110dTSnHP2UaCLNfcBRSqYZvjrYeZKw+Rz+8CD0u83kQIKMi7uKqPAY97/RqGZ77C
 8Z+MaqPOL1hITc75CLOptzqraE/0qTUD0jtzgtEEfb6aoZsrdmJAcYO/EpsTlwSP4pmmw2icSDo
 jKS57gcsF7cZIIA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Back in the 80's someone thought it was a good idea to carve out a set
of ports that only privileged users could use. When NFS was originally
conceived, Sun made its server require that clients use low ports.
Since Linux was following suit with Sun in those days, exportfs has
always defaulted to requiring connections from low ports.

These days, anyone can be root on their laptop, so limiting connections
to low source ports is of little value.

Make the default be "insecure" when creating exports.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
In discussion at the Bake-a-thon, we decided to just go for making
"insecure" the default for all exports.
---
 support/nfs/exports.c      | 7 +++++--
 utils/exportfs/exports.man | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -34,8 +34,11 @@
 #include "reexport.h"
 #include "nfsd_path.h"
 
-#define EXPORT_DEFAULT_FLAGS	\
-  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
+#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
+				 NFSEXP_ROOTSQUASH |	\
+				 NFSEXP_GATHERED_WRITES |\
+				 NFSEXP_NOSUBTREECHECK | \
+				 NFSEXP_INSECURE_PORT)
 
 struct flav_info flav_map[] = {
 	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -180,8 +180,8 @@ understands the following export options:
 .TP
 .IR secure
 This option requires that requests not using gss originate on an
-Internet port less than IPPORT_RESERVED (1024). This option is on by default.
-To turn it off, specify
+Internet port less than IPPORT_RESERVED (1024). This option is off by default
+but can be explicitly disabled by specifying
 .IR insecure .
 (NOTE: older kernels (before upstream kernel version 4.17) enforced this
 requirement on gss requests as well.)

---
base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
change-id: 20250513-master-89974087bb04

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


