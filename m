Return-Path: <linux-nfs+bounces-4880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC8E93072D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 21:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C01F21FFA
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78986381D5;
	Sat, 13 Jul 2024 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FRZEC/ag"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251641B7F7;
	Sat, 13 Jul 2024 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720899988; cv=none; b=f8Vy1unMN8mhypQpjP6ADtIDojAb7u264s0WhxDh47MoFkym0pQv2xLqbhhR7sSp2Cb/0BohlcdyIYmyUXpb6YHh6y7WKYsL2LSRQPXawtNKbi4MqZWv44FZj/P0BIla1wWoTppdIisa4CErezhfxcF1+7ucnrkiqoy3H8YUmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720899988; c=relaxed/simple;
	bh=BDr8r1aRINaMyd7uhCEuBNNCT90+wpbt7PExvizV4SI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jS5zfYjrO6iY+Yqd6QJSThnA8oEZPAxAwPl9Cf+ly1J+yCEX0P4bAthVLkYQH9lnnUSY3INCNLKRsNvG7hpBaF4z73hlUwt7iiDHbcVaqqthmmozA1FZHbJkChpTAuvjd4rwureRWOuC6tEfDTon6L5RV4S7y4g0cDGD296Rvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FRZEC/ag; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720899966; x=1721504766; i=markus.elfring@web.de;
	bh=3tBJhjM6eFblAsrUfksAZ4Js6i0KWeliNKRgPH6K5hE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FRZEC/agZLua5gA3+r2SWAmJVrou3sNXbHoIVM7cNZig+UwxJm9JgylGZaqNOw2M
	 8xcihUXVnnNCT9wcFrZ0kYdoC7I3dv8VS1MsZdCTMQyrEp8NvepPZBMZbogmOyJlO
	 tJRW818NL64AEcZxfdN9XD+IF8YLE4UzBvb7jRZKAWJO8mIQH9698rwrhzH6I4SF+
	 iM+MTsV/P99dbK3EPikYLNp0rnelJLnDfDRKiqm4A5gkNXttlkNkPI74sdUEkqC+w
	 pbiKChtf1nJHhow7vXm9PVjxZmyzgZhRP4E1xi17utiKg86bz10cs28LVdG5VjFOT
	 +LsrUKtM2bT1tCHCjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgANG-1rriRX3RcM-00daM5; Sat, 13
 Jul 2024 21:46:05 +0200
Message-ID: <553b5dad-6b84-4415-86ab-a44a1182d3f9@web.de>
Date: Sat, 13 Jul 2024 21:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] NFS: Use seq_putc() in nfs_show_path()
To: linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ibDaFNA5hp+rfw9RUb/9iufCsgWAqICVCpODfxJR0BtMRw8uTD+
 ikBY3nndU2mraFSldE9BlFvD9ZRx6tP/PJLu4nfGISmnpIX/QqcA1w/VEbEdPQBt9osF5CF
 VBq7q8gqBUm4rFMp4OGWAodv+9Bsq84DNlsxN8G4cawDj8rdxn/HE1prEhvqZPNl/fLdCCx
 QLd+uIoFUi/Iu1D0fTTYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TTC7OHr1d4Q=;RcXOwpd/G+61VKEDRclqDST/LJk
 pEeAitKXyTe/6CO6HpagPP9yyEsd3Mv7zazDggn4kfR9uHPX3AvSADtcml4ynk1Se+tzp59bk
 hJPtMsjd3TU19nxyjzfJloZsguq29O4bBfh0rey5AvyxmO28w3maPGIXBug3pXC4faHND5pGD
 PL9DOG9VW7RIB61khzPa4W5EnPD935IY/t5R9fTV5DnXAoQ42A85UsmB0tpGouTHMybNYgVnJ
 nxtf8IGYH/nSlNBIljJ8HoPWG90c25Gq6TOqqdaRrdWY+xUrrUqS2V0bKY3gwb7ilZ2uQ5ILJ
 LiWINr3z9lXyZ9NIf5PktkCd+8mmpTmPIV2GgXGtAk8+Y2d7uFW2wbMeBPegpWlW6dsUv7DvC
 4IO2qMLxW3kv/ySNYC4ETeUzyk07TGicvSr05h0LfajgAOUb4u3aUR2YZsR3hUvgNW+SH1O7+
 A22jChkEfaNGaxVTPl/6OjTxck51UV5RZxUv0tE7ky2Q5g/BaxkAI85vxDmkIJwFLwUAahJMk
 wDCSOQOg5qV0Lpw6Vx0B3Xxehb7zDl55I5n1dxZvlqQS5ZDtggEEZPHbeeIS1X45y+61+5wfj
 Nz+MgT2Lf04OxzYPxjdECxvvhwzK+oS47oWRwgfn1LfmHsD+27c9jcYXGEzxZ9L854/i1B2j1
 l+0QV92WrzJVYF9WFahmBXFq7foI40B6MWmB40gfD6HSqizceBdcXHfY6DVdLncnwyB8Ot62e
 ZqBfQ1on5scaawr4y1XEzM7FH/9oT7uPo1/9eXEkukK92kpImv12+J0cXPtGKvj6KrTAAVKEb
 Hz+uz+ai8DkcbIkRj8R8GMgg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 21:35:37 +0200

A single slash should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index cbbd4866b0b7..b087720d7811 100644
=2D-- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -648,7 +648,7 @@ EXPORT_SYMBOL_GPL(nfs_show_devname);

 int nfs_show_path(struct seq_file *m, struct dentry *dentry)
 {
-	seq_puts(m, "/");
+	seq_putc(m, '/');
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_show_path);
=2D-
2.45.2


