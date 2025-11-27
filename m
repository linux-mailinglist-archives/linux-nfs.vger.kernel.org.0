Return-Path: <linux-nfs+bounces-16746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6BC8CA57
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 03:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 301CC35135D
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A184F24678F;
	Thu, 27 Nov 2025 02:14:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A51246333
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209683; cv=none; b=VjmuZFX+0WS5Qk2TfhejV1Fdsl24souXvHclTNUyXRYxLOYW0cseGaFPxA1DoRvRjg6dxxodEbc9Zr+w0vi22ggQd8TPZlbNVBdB6HcQ+FC8NtEnAM9d4j7utDhAaNtKhuM1MVe/KaM84x/klkN4/H6x9KCheVcG6Oz1qbMnzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209683; c=relaxed/simple;
	bh=mbqvl2nyp1qSwUNeV7LglHMLvPxJYIyRTBHAc64IJM4=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=bbl8/yrSnTXKypH6xOmMJl2CNVC+epM/raEwApJQxiXU6fjZVftv/G2dvUT+1axBmUnqnXis3MNUBrktQ5ZdlaFnBYAuSxYFmIdEp6GO6xzOWKlAkYF6uREfB6Ot3at37wjywwdyUHnTR0z8K+5t8hz4/aMpAlTYrgN19fQr3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
EX-QQ-RecipientCnt: 1
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSYbfq2fqToiE06OqpQR/8JocnLdZjgIrs=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: n5hMEETRXZCkz6kvpTodewb186b8GpqHfgVj9HM9TJ0=
X-QQ-STYLE: 
X-QQ-mid: v3gz7b-10t1764209672tf66bb30e
From: "=?utf-8?B?WmhvdSBKaWZlbmc=?=" <zhoujifeng@kylinsec.com.cn>
To: "=?utf-8?B?bGludXgtbmZz?=" <linux-nfs@vger.kernel.org>
Subject: Can the PNFS blocklayout of the Linux nfsd server be used in a production environment?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 27 Nov 2025 10:14:31 +0800
X-Priority: 3
Message-ID: <tencent_780E66F24A209F467917744D@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 2522757342811953134
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 27 Nov 2025 10:14:32 +0800 (CST)
Feedback-ID: v:kylinsec.com.cn:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvWD9bNzdSSuu4uqc3s2XGqbjwb+oTSLLQhKIfjMg8qPYDxeXCluPX0I
	tSaUVXYqaZRIZPHf1FfeOkd4DZivc98qYYGoPKAkXptK6bYaJVPT2toBwgP+ISACQvRbzLi
	uNN4dlZBrs+lsVtyqTI6yelE+144mEF6cgKx0xuaElJj/iSjk3Jxu9p3cy6t5NHOMNmSkwg
	q/AzGxrWZopcHYZM3QzF9DW5/d5rCDDeYuqric4WjcEVxrd2fGevVjFdoLmOUEk7fXBdcmG
	sPKVMiCj9PGak2BLdF8aa0LYMLrqfZRCWUEL7wEKU60OTpSyPKxPd9wURXnPzVHEDCOlltM
	o5QGd3RvWhCy5esJwC5L5lvE2r6zxTrLgeXuys03/+vi/GGGr+3MRizPUfOUVxEIqB8Bkz+
	o81Al/b2SLDNwcjoABWQTjJxaos262yrk8w46cN673jPZr9d+mlz4a64X0XJzktrzDtLvle
	9t9pihaBjb33Ocet7XrHsnN8GIjjQ816//U3rtmnoGMVXq5n559y/YWq7nTcRgagcDNnENG
	7D9vkahEKs5gaRnBZza+mW7ZRyH3cjJNh0s2rPyjGK8b7XJuhYiliebR8gi2IJnzydy1pcM
	/Z9Xvtw5pC2LdcGa8oBLPLSE2QZ62kEcFdfG1VSY+B10J5qoGTPfx9uxMZnO7zVrEQU/dPi
	tDo53C57D5CtFWTP8l8tpoVG4CRqg6FglXJITIeo8VrfxPMcaewfVA0FJDs9oBShyIzq7IT
	wA/ts59IaBwcXO8q75Vf1Uo2BjiCrLz3lCHbGNzeweMm4q/Ps1kKNhy1di5ADAhdED3SF6t
	XjqvV4cGMXmH/YrPEl/uWnflWIXEWyHDsTrK2N8mg0RgF9SawRk74jvJc5MOHIvOAjnKJF7
	/r6jqstIiKnRZJjMkK4Ab6a2rwxsFZcYzTwkVESvD3rwXXQUv7CEN3AFV2PXR2rnWYFIpI/
	8K/mJA1IKbua7HRnx0shMMgRE/OQbxfLpMUpQdP1HhZgphe+FFtuirYYG/kxfNPk2ym/VxS
	p+mqruzkBsTkxe/9h+H4puK6kzaWndcApqknewNNDgJ5KCwEy8wybeRwXVfdIA90nP8JUaG
	+7/HzSLrWXUeTfwxpD0JScQlz/ugAVpNA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

SGVsbG8gZXZlcnlvbmUsIEkgbGVhcm5lZCB0aHJvdWdoIENoYXRHUFQgdGhhdCB0aGUgUE5G
UyBibG9ja2xheW91dCBvZiBMaW51eCANCm5mc2QgY2Fubm90IGJlIHVzZWQgZm9yIHByb2R1
Y3Rpb24gZW52aXJvbm1lbnQgZGVwbG95bWVudC4gSG93ZXZlciwgSSBzYXcgDQphIHRlY2hu
aWNhbCBzaGFyaW5nIGNvbmZlcmVuY2UgdmlkZW8gb24gWW91VHViZSB0aXRsZWQgIlNOSUEg
U0RDIDIwMjQgLSBUaGUgDQpMaW51eCBORlMgU2VydmVyIGluIDIwMjQiIHdoZXJlIGl0IHdh
cyBtZW50aW9uZWQgdGhhdCB0aGUgUE5GUyBibG9ja2xheW91dCANCm9mIG5mc2QgaGFzIGJl
ZW4gZnVsbHkgbWFpbnRhaW5lZCwgd2hpY2ggaXMgY29udHJhcnkgdG8gdGhlIHJlc3VsdCBn
aXZlbiBieSANCkNoYXRHUFQuIE15IHF1ZXN0aW9uIGlzOiBDYW4gdGhlIFBORlMgYmxvY2ts
YXlvdXQgb2YgbmZzZCBiZSB1c2VkIGZvciANCnByb2R1Y3Rpb24gZW52aXJvbm1lbnQgZGVw
bG95bWVudD8gSWYgeWVzLCBmcm9tIHdoaWNoIGtlcm5lbCB2ZXJzaW9uIGNhbiBpdCANCmJl
IHVzZWQgaW4gdGhlIHByb2R1Y3Rpb24gZW52aXJvbm1lbnQ/IA0KDQpCZXN0IHJlZ2FyZHM=


