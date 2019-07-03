Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118F45E76E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGCPJD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 11:09:03 -0400
Received: from mout.web.de ([212.227.17.12]:34107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCPJD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jul 2019 11:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562166536;
        bh=vSCyj17vPqCrs93GUhXfANwMFjV9zClv/Arpb5kh/vs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=hnKoBxnP/ec2XXPCtWjdjyr/b0uqmkYNu+Rp+m7FCcoMdcvIo2Wc2ifrz9YPGfUFe
         PX+yppuAChSFPNqAxikPUf9JH8HeNFAeTA25ZC8ChGz37f6WropkDgujgVeitCRZG9
         6hwAwZyWNZHLs2JzrsciyY6StNikKl7Jl1Fkw6J4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.108]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLgE-1iIIsP4AEM-00ZzIE; Wed, 03
 Jul 2019 17:08:56 +0200
Subject: [PATCH 1/3] NFS: Use seq_putc() in nfs_show_stats()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <cb79bcb1-0fd6-1b7f-c131-5883f09ad105@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c8837b8d-34ca-a8d0-acb6-6cad599df3e7@web.de>
Date:   Wed, 3 Jul 2019 17:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cb79bcb1-0fd6-1b7f-c131-5883f09ad105@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K3bK6HYYKiloBWgEBtHk2P1ec/jI3tNEQ8FrddgizmRtNGxILL3
 1DG5WtKL4tLUwNuD3k+lSgC+N1yYCjpAGeXB+/hehfjLG2NB2OE3bxGriDiD5lNtMFqmnYU
 XGluvszyMkmf9KKoNoEVwNXTEeLLT66am5DmHnjTZXJ7H6TAHQJTrZWOs0tzrczFe0wDVsL
 82MeAcpj79shxVwhQtVkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:idEQ55D6Huw=:WmVW0j1p1ROWzTXya5RL3h
 RlTOrRpbGXM4JpUaVszYJUDSrNpEqTwS+ejY8qovMV1YK26sv2pgsI84Vypr/Qk8IeehSkmr6
 v1xM2vGhDNEPBX1Y1tezkOEp35zEkJkTDqfAFrPy3HhqYfRonG+ApLdJvYrvZAzReD3Ez396B
 BVOpGh9BjcB1xQOFd15z+qyf4rZBmXfLi46d2IQy67arqWw1+BqygQdDCav3n4OTsvLWE9clL
 nKYlKwb6BFysDdHvQ6dw5fYlXbZqqGkFjHg0Ru+vCcYUZDwlZ9foqlqIP2ojFZoad4cG1cOLq
 OVFnTsDZvMHIFJwYD5kdPwEp5zXP+9zSXkneQafCrfzSpFQGuk0hgAqFI9nVepdauXFPezK00
 eheMBEslTQV/r2zYfxoypTwMc0paaf+0+e49DLglv0qkWTn9uhuuGGj/i1CBW5sAVaeNqiUvd
 Fa9BBKwZNU8r5ESKSaecg6hS0v2rjpu3j5QfBm51fHqahe2kORJvIPtE5rQUaVZ/T5KoCrUer
 cmfKWswKM6ZxPe2vd7soCxCVIFADkTwEflVObQcAdBFIhItCe2Y9B5vm1H6l9YwXUXt+YO0XN
 Xv3uI4E1tKgqgTf7lyXEqcd31wCdS1xcGidhD2U7+yPiPk7FRIvLPRQMWHalU/gZFxpSRuepj
 Q/FhsmrXQObiRklRSPc3gY0Zls4/NeCWoHLAfQWsQbA8kgasZdkEqlZ3VP3ZnQoW4LzaPTqQ9
 K39a0bSzmg5+VWDTGU2E6b3Hkt19nNIsE+5WiWewV5EzM4FtLMIwvDeMkAo2wxoe3Yzu/Qe0S
 74kHfva+2/fG4m8LsD+/acmR7YKEgReJNG55LhQozM2E6pXz6SPefaDCjfRIePtASqIAA0wQW
 RzHPBs26qU+OFYP5AP3rgY/81br/CS5uc/oA+to2vCpt62dguq2ijENrKFpPN+Ck74xhmE9LW
 2mN5vSqJ10prHxb3u+FWJ+cSLfH3vln39TX4ugr2gcwUSD2zMG6a29BCsH6/r+qO/4vRtEhvH
 gvkUBj3/LcNIlcqZwcChcUHz2ypFS0OUZfOd3V/u7ij80pbdfdpkOQp1BmRCzWr3cEYJz0w6A
 TF56pJPC8bR9qFiAVzpRq7YtWtTKqTdrwHs
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 3 Jul 2019 15:33:09 +0200

A single character (line break) should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index f88ddac2dcdf..0c229e877ba6 100644
=2D-- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -887,7 +887,7 @@ int nfs_show_stats(struct seq_file *m, struct dentry *=
root)
 			seq_printf(m, "%Lu ", totals.fscache[i]);
 	}
 #endif
-	seq_printf(m, "\n");
+	seq_putc(m, '\n');

 	rpc_clnt_show_stats(m, nfss->client);

=2D-
2.22.0

