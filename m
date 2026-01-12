Return-Path: <linux-nfs+bounces-17738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F42D10A6B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 06:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36E1030118ED
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 05:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE31A9F91;
	Mon, 12 Jan 2026 05:49:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BA30DEA2
	for <linux-nfs@vger.kernel.org>; Mon, 12 Jan 2026 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768196985; cv=none; b=YyjdTKbYeanKdxobURppILs0qq2FJq5LlmdwwNtd01Ym/09O1rib6ufC42/B2XJDGunpiRHbPdc/KsUsdF2vMNbstfhpYA4/HS3GLiRa0OXXRt6nyhMrbtqtMzm8AKcwWUSMGZJKZqnOQPwbLQA5f0xSUK787zTyzTeCTW6dX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768196985; c=relaxed/simple;
	bh=oZPYipAFltat3w9GVP6wdn61Tts1u5W1+cfC/3y0wIw=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=gdRNWFTn4YItGF7VhFDRZaAtEiMhCuspCRrZDq2TqBjTJ1HJ+XMi4gF018L1spSy4pMLfIfjOke8tCVy6f0Oaoa9+9eZpRDM0ghSXgrRI6U27qWHbfFVgmazid6Lm8gzE3WF/tA5uDpjmo5l5JmBK8Ym0kp5xvUz708mOA6k4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
EX-QQ-RecipientCnt: 1
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-FEAT: D4aqtcRDiqSYbfq2fqToiGQ640EZkclUqGZucf6tfws=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: ZXGZMA5Oh9lLk7JbCCGWsSQlF73qgMW1R5t50Ryuqn8=
X-QQ-STYLE: 
X-QQ-mid: v3gz7b-10t1768196972t815b4552
From: "=?utf-8?B?WmhvdSBKaWZlbmc=?=" <zhoujifeng@kylinsec.com.cn>
To: "=?utf-8?B?bGludXgtbmZz?=" <linux-nfs@vger.kernel.org>
Subject: Questions regarding the usage of SCSI layout for NFSD PNFS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 12 Jan 2026 13:49:32 +0800
X-Priority: 3
Message-ID: <tencent_5BEC627E1710B43F5D8245FA@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 6879736198972346735
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 12 Jan 2026 13:49:33 +0800 (CST)
Feedback-ID: v:kylinsec.com.cn:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mutteg8H72qDcRdHVzsAyQTKKjWBjDHZdRqDp/qd92IWbwFOb1RtKB6c
	K3z4Ygw7rHmGoG/rU5K1DTbIDetOT0HjDKK1L+a58hgKztlbHMbDTeuhh3FaHoLSnqON+QD
	Uui5hQ08wOKuPnLU/6gjnlflBkemhmS7m5YywICCC0O5K/SOSUAEfS3XbqgoibTbPtwPRKC
	FdIy+8NnTDiu2Ek0I91cEmhBhkQ5aOl1+zfWmARjl46arEXTWzotgLaBJFti987JvPvbxDV
	QdZkJwHJbNMCCYUZc30sa7mdHY4MrNQ4LRKW5r00LaMwdHehRMmxh3h/xthId21WTkQi6g6
	kojVNZ5CWcIUEFUUCSV6Vn7e4xJT2ABvYKAxbSP7gvG6QVDOKyCWG5tXm6EPfCRsSfI6zV/
	MSWYKD6kO2qDBmcKAzUm3pjXcA6wV5ilxU8qHp/tWHuL6goFJOBiz7opjg+sfyoMw4Ztfqj
	bVsYGYtPuaRsUo6iaJ3u/mDTTSGq9u+uvP0szHkWSnEuAJLjpe0XBjNxBcgB+HFdo4/mQfc
	HVA2ryHqoWuQH7iPW9aSnVfO74pCxvvi32ZKhLVd1peHmobsBvOul2z6HmUpGJE51RIOapg
	A+39P+tuUe67CghZnf4jceKXAK9ilJ4NJ2Vu0qMGCXtSi1PrW3QmJF/vfoXBGkWpCLbOQlX
	3gsWcfmaeIjoFg5+LyKEA1OsOY6jNHKVBjUgpG5J8Co9qSA+SYl4tY/S+W1IKawv6Mawtux
	S2Y+a+T29oWtGFAGZG79sB1TSJlk+wxwk6a+Cy5ygrQndD+GPOOwVf9QiYG9DFo397rT0SH
	BAGr2Qy2ETF/sKBkmk1CUBR3JtQS/b/wZd6JsHw3UagQDNDzs9vttq90ANuKMFwkFfHyMPx
	8T/pCjjzlq8FMZFhXFlq4kVg61wk85Fe71jNlwgoPqxmUsIbNWavv7mS873PpKgiPXySCt0
	+ja+cpxA5RwLPqhzsmQ7+OtZL5wkkZrLsHjqhp/1hWvUD8iGQ+s2ZLMhhKPp9FRJkEZ+K4l
	VaBLUEzA==
X-QQ-RECHKSPAM: 0

UmVjZW50bHksIEkgcmVhZCB0aGUgTGludXggbmZzIGFuZCBuZnNkIGNvZGVzLiBUaGUgbmZz
IGNsaWVudCBzdXBwb3J0cyB2YXJpb3VzIA0KdHlwZXMgb2YgQmxvY2sgdHlwZSBzdWNoIGFz
IFBORlNfQkxPQ0tfVk9MVU1FX1NJTVBMRSwgDQpQTkZTX0JMT0NLX1ZPTFVNRV9TTElDRSwg
UE5GU19CTE9DS19WT0xVTUVfQ09OQ0FULCBhbmQgDQpQTkZTX0JMT0NLX1ZPTFVNRV9TVFJJ
UEUuIEhvd2V2ZXIsIHRoZSBuZnNkIGNvZGUgb25seSBzdXBwb3J0cyB0aGUgDQpTSU1QTEUv
U0NTSSB0eXBlcy4gRnJvbSB0aGUgcGVyc3BlY3RpdmUgb2YgdGhlIGNvZGUsIEkgdW5kZXJz
dGFuZCB0aGF0IHNpbmNlIA0KTGludXggbmZzZCBvbmx5IHN1cHBvcnRzIHRoZSBTSU1QTEUg
dHlwZSwgd2hlbiB1c2luZyBpdCwgYSBTQ1NJIExVTiBjYW4gb25seSANCmJlIG1vdW50ZWQg
aW4gb25lIGZvbGRlciBmb3IgdXNlLCBhbmQgaXQgaXMgaW1wb3NzaWJsZSB0byBhY2hpZXZl
IHRoZSBzY2VuYXJpbyANCndoZXJlIHRoZSBzYW1lIGZvbGRlciBjYW5ub3Qgc2ltdWx0YW5l
b3VzbHkgYmUgYXNzb2NpYXRlZCB3aXRoIG11bHRpcGxlIA0KcGh5c2ljYWwgTFVOIGRldmlj
ZXMuIEkgd29uZGVyIGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdD8NCg0KQmVzdCBy
ZWdhcmRz


