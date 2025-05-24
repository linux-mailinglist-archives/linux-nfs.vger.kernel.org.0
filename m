Return-Path: <linux-nfs+bounces-11892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0824AC2F63
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 13:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE45E7AA39F
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF551DF994;
	Sat, 24 May 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Du2FA+p4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886533E4
	for <linux-nfs@vger.kernel.org>; Sat, 24 May 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748086803; cv=none; b=U3UNawuttJJcBhkcxrEGEOekFjipuM+uP2H3BaeFfNrFulpH3+eTNY6riTN7aTwNdcv1eH0AvkEOdyMXeHFMwZ4Xim2W+zrTTGDFIPmeZIi5hsx5KLUFkY5D1Kk3oli9lTLbgYz7IiVyB1UbCezsmDNSqeSQZ5JA+dwQvD+CETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748086803; c=relaxed/simple;
	bh=hIwHRX0j4D0eLM4anx1bxiTPrNCaQ2l4r7A1Kx4yznA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=ouP9I9TmPw/Oc97+DkkOVEgRcLs9x9wzEADWuV3rLM5OnySh7DSeIGpknXsRh1Z3tReYivJefO1N9L0ktKCvw2iDQz7w3aUuRHH//oif6oggTZ5h5UqvmyTdSdGFPzP1zn10cpaK45SqWEPPCBnDdK2ApoMealpa04OahCtg68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Du2FA+p4; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1DFF2240101
	for <linux-nfs@vger.kernel.org>; Sat, 24 May 2025 13:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1748086466; bh=hIwHRX0j4D0eLM4anx1bxiTPrNCaQ2l4r7A1Kx4yznA=;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Subject:From:To:From;
	b=Du2FA+p4T62NJkLenei4jJzdEr7y/edI1s3y8g+wAxFj3ALUCL6M785xscWkRI5hJ
	 XCBn5Aa/Djih4/RnTttqot9IjFzTQOyF1A7bbCivIL/b1ygIj6zCqhFX1qfkoGiJZz
	 g8S+CNXu8O5X6z+cS5iIbRPdY2pCqKuXiqH2lbBfnutFYiTDc/KARMN8c3/edTD+zX
	 ynaR9+WeiF6uB85PoyiduLBliMUgmou72PqOp4j69G3y1bdnXo3dvwz/GsA5Y05uPR
	 XYU8ejEaPbJHrEVAPrSP6mKIiX9XZYPkGeoIhymG/LMFVgrY9z5fIfJbpddsCFHqCX
	 AHSqUCZtH/y7g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4b4KgP5p3Qz9rxD
	for <linux-nfs@vger.kernel.org>; Sat, 24 May 2025 13:34:25 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 May 2025 11:34:25 +0000
Message-Id: <DA4CXNXDBZB8.9AQO25002X65@posteo.net>
Subject: [PATCH] autoconf: replace non-portable += syntax
From: "Sertonix" <sertonix@posteo.net>
To: <linux-nfs@vger.kernel.org>


Behaves exactly the same and also works in shells which don't support +=3D

Signed-off-by: Sertonix <sertonix@posteo.net>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index d8205e80..eb542581 100644
--- a/configure.ac
+++ b/configure.ac
@@ -678,7 +678,7 @@ AC_DEFUN([CHECK_CCSUPPORT], [
   AC_MSG_CHECKING([whether CC supports $1])
   AC_COMPILE_IFELSE([AC_LANG_PROGRAM([])],
     [AC_MSG_RESULT([yes])]
-    [$2+=3D$1],
+    [AS_VAR_APPEND([$2],["$1"])],
     [AC_MSG_RESULT([no])]
   )
   CFLAGS=3D"$my_save_cflags"
--=20
2.49.0


