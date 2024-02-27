Return-Path: <linux-nfs+bounces-2093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD27E869147
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 14:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF431F22CE9
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F85213A88C;
	Tue, 27 Feb 2024 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CEykwdj6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74713AA41
	for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039101; cv=none; b=L2lrHhokrM4BEOkvJMUFnqm6DfY1+pF8fuAClPnE+Kxy7WIA7Bj4YmhbaRXksbCsUqbJquLKzAEWgL/RcOzdtPA6uB0/xTkCWuq07Fg82zukxPFsVYOCdLFge1/1BELUecwxhndgOOf4YCu7xA6lNPMyCels9bHhHxn0EDFy4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039101; c=relaxed/simple;
	bh=PUwg2lHtxbHYZO0RMkd6XVw/0E59O/XzqyG1zxFsAbc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PVVc4OZZ52pGL8v+4TuBh7ChfFRDGcrWL2pNzEjGdGaOmcSngrADcgTdVHUU2h8W57eDeq2aQWYUCF8MuRe6j5NIRVtJw9rR3xJn0ZoMyv6LpUKmaI+jRQf6N6BwPZoHRtwVlCajIjmSrTMu0nssNdl8pYNWsMplprNT4kflsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CEykwdj6; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709039100; x=1740575100;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=PUwg2lHtxbHYZO0RMkd6XVw/0E59O/XzqyG1zxFsAbc=;
  b=CEykwdj6QtY2qgoRm4BvS3bymUSL16LHR5YUrcc/9NLSAinBn7NT5S6G
   cxoQ5r2gnyQm12wbD+qADZAHOkOLAGWc2jUVr+pjbA2GAO6XKeDwUwPAG
   /t59POC67gol/Ms6UAg0+FDEVvgXSAwhcuRfe7gHx/ktUiZbchCHkwZP+
   U=;
X-IronPort-AV: E=Sophos;i="6.06,187,1705363200"; 
   d="scan'208";a="640759571"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:04:59 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:60442]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.2.218:2525] with esmtp (Farcaster)
 id c5661839-c8f7-4d86-b7b9-39dc845df7ad; Tue, 27 Feb 2024 13:04:58 +0000 (UTC)
X-Farcaster-Flow-ID: c5661839-c8f7-4d86-b7b9-39dc845df7ad
Received: from EX19D014UEA003.ant.amazon.com (10.252.134.168) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 13:04:57 +0000
Received: from EX19D014UEA003.ant.amazon.com (10.252.134.168) by
 EX19D014UEA003.ant.amazon.com (10.252.134.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 27 Feb 2024 13:04:57 +0000
Received: from EX19D014UEA003.ant.amazon.com ([fe80::e4e7:1c85:21fb:5422]) by
 EX19D014UEA003.ant.amazon.com ([fe80::e4e7:1c85:21fb:5422%3]) with mapi id
 15.02.1258.028; Tue, 27 Feb 2024 13:04:57 +0000
From: "Atkinson, Sam" <samatk@amazon.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Client support for 0-length virtual files
Thread-Topic: Client support for 0-length virtual files
Thread-Index: AQHaaX2Qh6NyIOxh9ka1o/OlALp7TQ==
Date: Tue, 27 Feb 2024 13:04:57 +0000
Message-ID: <A5FAB971-823E-4573-9C4B-C92BD41693E2@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0721F2889EA7D94DB3B7AFF201035087@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8sIEkgYW0gbG9va2luZyBmb3IgdGhvdWdodHMvZ3VpZGFuY2Ugb24gZXhwb3NpbmcgMC1i
eXRlIHZpcnR1YWwgZmlsZXMgKGltcGxlbWVudGVkIHdpdGggc2VxX2ZpbGUpIG92ZXIgTkZTLiAN
Cg0KSSBoYXZlIGhhZCBzdWNjZXNzIGV4cG9zaW5nIHRoZXNlIDAtYnl0ZSBmaWxlcyB3aXRoIG5m
c2QgYW5kIHJlYWRpbmcgdGhlIGZpbGVzIGZyb20gYSBjbGllbnQgd2l0aCB0aGlyZC1wYXJ0eSB1
c2Vyc3BhY2UgY2xpZW50cyAoaHR0cHM6Ly9naXRodWIuY29tL0NoYXJtaW5nWWFuZzAvTmZzQ2xp
ZW50IHNwZWNpZmljYWxseSksIGJ1dCBJIGFtIGhpdHRpbmcgYSByb2FkYmxvY2sgd2l0aCB0aGUg
TGludXggTkZTIGNsaWVudC4gV2hlbiB0aGUgZmlsZSBzaXplIGlzIDAsIHRoZSBjbGllbnQgc2Vl
bXMgdG8gZ2l2ZSB1cCBhbmQgcmV0dXJuIGZyb20gdGhlIHN5c2NhbGwgYmVmb3JlIG1ha2luZyBh
IHJlYWQgcmVxdWVzdCB0byB0aGUgc2VydmVyLCBldmVuIHdoZW4gYW4gYXBwbGljYXRpb24gZXhw
bGljaXRseSBpc3N1ZXMgYSBzeXNjYWxsIHdpdGggYSBub24temVybyBsZW5ndGggKGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQv
dHJlZS9mcy9uZnMvcmVhZC5jP2g9djUuMTAuMjEwI24xMjUpLiANCg0KQXMgZmFyIGFzIEkgY2Fu
IHNlZSwgdGhlcmUgaXMgbm90aGluZyBpbiB0aGUgTkZTIHNwZWMgaW5kaWNhdGluZyB0aGF0IGNs
aWVudHMgc2hvdWxkIGJlaGF2ZSBpbiB0aGlzIHdheS4gQnV0IEkgcmVhbGl6ZSB0aGF0IG1ha2lu
ZyBhbnkgY2hhbmdlIGluIHRoaXMgYmVoYXZpb3IgY291bGQgaW50cm9kdWNlIGFkZGl0aW9uYWwg
cm91bmQtdHJpcHMgd2hlbmV2ZXIgdGhlIGNsaWVudCB0aGlua3MgdGhlIGZpbGUgbGVuZ3RoIGlz
IHNob3J0ZXIgdGhhbiB0aGUgc2VydmVyLiBDb3VsZCBhbnlvbmUgc2hhcmUgY29udGV4dCBvciB0
aG91Z2h0cyBvbiB3aHkgdGhpcyBpcyB0aGUgYmVoYXZpb3IgaW4gdGhlIExpbnV4IE5GUyBjbGll
bnQgYW5kL29yIHRob3VnaHRzIG9uIHBhdGhzIGZvcndhcmQ/IFdvdWxkIGZvbGtzIGhlcmUgZW50
ZXJ0YWluIGEgcGF0Y2ggcHJvcG9zYWwgd2hpY2ggcmVtb3ZlcyBzYWlkIGJlaGF2aW9yLCBtYXli
ZSBjb25maWd1cmFibGUgd2l0aCBhIGNsaWVudC1zaWRlIG1vZHVsZSBwYXJhbSBvciBjb250cm9s
IGZpbGU/DQoNClRoYW5rcyB2ZXJ5IG11Y2gsDQpTYW0NCg0KDQo=

