Return-Path: <linux-nfs+bounces-4879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E61930722
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 21:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215AF1C2159D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BAA13F43C;
	Sat, 13 Jul 2024 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lOAKR95T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F251BC37;
	Sat, 13 Jul 2024 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720898221; cv=none; b=qKmOOs0uIc/1IKNio8bNFhhuJo3e1kLB6FqPxE82DYGvbGQgMKVCyfs4MldJK9208nZHDzw4C0KG4uHbL15aeXI6FPr2HgyzJ3zRyQu2sChAgPMTBsdKiXtnlwIoGCUUr13VkxXl3L4uRsisop5p56X2n2oeqthXsMEbIgxlNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720898221; c=relaxed/simple;
	bh=fIllpoDxxfPmzGlVdFqG2Dd8k9qDQSm8a4VANbMlw/8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=c42yW6EAM1sMwHEhKs1e8m9FtIKFqiZm8AArGRPZ/Oo2jM6F91ZRUIz/1+GBKjjPS3ZUAy7lM4qKdWgFJlgxRJAGKz8wRpXIgYGdQtNjMPRUprl+1oADsIYH7wMRUB1JuZ3uOiRpOR0BqwnEdFgd24cHn+xnXKztUkS7gCrKn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lOAKR95T; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720898176; x=1721502976; i=markus.elfring@web.de;
	bh=58QnkHd6/w55w5TERgZr8FgykSb/+JmRwMIOmIkhJT0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lOAKR95TuMkoPKhSE5sTdhKKXaSqfyy/diHSsgIriaTZT6+f1EMUgjXe0rNRCrOl
	 PqN3RJh55W5lX+phsUjxM4qwSCBhkr1yxNHLP/vaDUIYj06FWYTxNAH9xDuiADwjB
	 yIDG0ODLIZ/FSKGVSituzJ56HwBUgY8gQnV5lgtsw/3OO/K7x6X5TLkq56yNTxqEG
	 Jt0iS8ojFxvgcjTFZZedsvUz9rv8LhHAO1V7EqSZnc3fSi8NJtanGzY5WSsh87Wn8
	 G6PfLCOA9Zu2mQ7C30fAyI87Mgmr/afvOK5hGkk8G6ZxJJI1K9dQQ9e/3lFaM0mos
	 jrFfjIlxO5BYDTUU5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXocY-1sryIV3qma-00VNUQ; Sat, 13
 Jul 2024 21:16:15 +0200
Message-ID: <ab25204c-5a53-42e1-ab3a-c4f704ebc929@web.de>
Date: Sat, 13 Jul 2024 21:16:14 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] nfsd: Use seq_putc() in seq_quote_mem()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4U1i3VGg2hW2biQjqwkau4fUlaA5QrRWSFAddPSaI4TxmZ4QO76
 coIgIqYor+kRQck6xu6QazchcZJ29e2lrXW9kjLsnIYqVmoCSMJkgAywYa4Bjf9uh8u07Up
 U6/kWxYIgA/FBZ3mEVRPPZ/7mXfsd+CMyVxFivIsaTJqyM5Wwd0Q83FxCKjdT2dcfUFNu6i
 WJifVuZhz0ky4EXPtMRcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S09+jYoUjpE=;61J+iwp2722nWrtNBlXdKcjngN5
 mzrumDrpaVgh7cQCjVk2unTYR7BmNMNg6urfqDXdCWw4dpA8ryHryzfawZOuKDbmCN0Qvz1n5
 Hvxmy+ags+EppEnlazERupHDvS9IH4rVxW6rZFqDCuDMYnccMNhPtp6AAV2TTGczH3OO58iaC
 I3FnGOqfgVZgKqpP++t3WKCl2pi7106T0QXvVanXZLR+cU2Jd7Po+i9gvuTvqi3r7zqoUHOhy
 9LUQZmYolt0EOapVAusjIE5GX6vNRXRVTXmgkvEZq64SXQaV5+9Ja/vJsvXJeCaNCW+VmD1ej
 NAeuJtNzLoMe2WLKnDg2tRKQVE1lFZhLnPqlrX59VdF/P8EfZJmNXTy22UJ8USUfMxmCVt/I0
 V+licQVZbl2K5Y84VzkJqkVsa68sfX2BLV6zIAnYzJPSMV3pvr1KnMNI69/UjMvwULZudX2CW
 m9JGO3kaTTJGCAUab2vBEdyVl141SmhE/jLvbwobMJJuJE5F8PH5ugHdIu8g2UG1fqF5+DnKv
 dLHhcGmMa2SEOE8M+s+1wqTg6pLJBQtTNfpuMUgJwvdQJOZsgUtkjq2TFINA8BlFhJHY60GTA
 AIFJS0/AEGq71YpZGkiTE5i0CoOVR6Yj3kzVYud1vWn31ZlyK3wwI+QrXm1Nak+lP1Ki4NyzS
 XZ5M9VBmi99kAPHM/QJU8v1uDoHzveI6uA1tq5qIy6RxSUoskTiQmEUPnHqlncOHYY7tXNiEd
 bJuFPhqHIzNbUgg0t7aHAap0uRTRoWjRD4jzmAFpnKGIjL+JMXOFeJuQkmFH25YPZGy9E2QW7
 yrWa1DB/qsEr23uHrGu2o/ow==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 21:07:09 +0200

Double quotation characters should be put into a sequence
around other data.
Thus use the function =E2=80=9Cseq_putc=E2=80=9D accordingly.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..1d15165a15cf 100644
=2D-- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2636,9 +2636,9 @@ static struct nfs4_client *get_nfsdfs_clp(struct ino=
de *inode)

 static void seq_quote_mem(struct seq_file *m, char *data, int len)
 {
-	seq_puts(m, "\"");
+	seq_putc(m, '"');
 	seq_escape_mem(m, data, len, ESCAPE_HEX | ESCAPE_NAP | ESCAPE_APPEND, "\=
"\\");
-	seq_puts(m, "\"");
+	seq_putc(m, '"');
 }

 static const char *cb_state2str(int state)
=2D-
2.45.2


