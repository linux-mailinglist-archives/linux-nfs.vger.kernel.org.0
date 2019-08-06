Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18421835C2
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfHFPwI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:52:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45561 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfHFPwI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:52:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so368474otq.12
        for <linux-nfs@vger.kernel.org>; Tue, 06 Aug 2019 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=87SehoA5EwY2SnPVlR72+/0gW5Igk27BU3+1G14MjNY=;
        b=tzw/xgKQXVjh/ZnVkgZcFpnJMc2yiypfnMHw4hB/kc7tixoMhH7JSi143g3W+7TfHe
         zQ8rgqdm0eC2c3UjP4PSvf1Y8lErS6j0NwNrAxEFVp6P2fzwwkGhIBi7xIBsIMdtINC9
         dTDsjkVw6SRAtwOUHXzApt6rjVJrcm41KBVXCFXyK2FT1baR5sPhkyW3o/kcCy4kEcn4
         ZUe1MDzpTsdRb8LqcCRY6/LEa0/MGtnAnPKoaHlOidDeTzxGIHGYpJ1H1pPGwh+aS21q
         QcTpV/bQd5/DR+5JrMM4P5XMA2sjOtlD77szRxAmXvs/jTzsupjNX1SdfiAMrUkK1g2Y
         vgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=87SehoA5EwY2SnPVlR72+/0gW5Igk27BU3+1G14MjNY=;
        b=q6eIlOD8Rpuobr4J91ztSzPAL6fATkCixNIoRm+7n4OAxDAjb9cNoKT42ibzLGiEmJ
         sjvxKlUIENCUjMyxw78UC2lJc47F7UKTDjn2LIFA6WcLkEgeBlvPyCOxaHMhRwbWqAUU
         +c9+vs0UDqxHwDofUhwt0p6sbxl7UIPXvnMTzr2EfNu21MkBa1VaYp+v04rzhE857mOF
         x1yoWGgHgoMX5/0/UDXKph6AEFUWzbRL9HRELbVoUe1n6I9l22pL7w9vh7I0d4NraXwm
         vB424zlBS7e7RQB8W+NUwCAZ3b5N+SATL8EKutFZoqNbJmQ7aROwZAoppcVmZe9eMWpn
         18+w==
X-Gm-Message-State: APjAAAVfBrJq9hqrHzA2YQ1dpIXLgozfnaTmqqvyBIcqqYzjiCyuTXbH
        sQ3fLKf9hrQVIOrTKdctDto2c+HU
X-Google-Smtp-Source: APXvYqyqW4aiaUXJ0sTabE4JDSAVPsa4ahF4RHUGkgEerDRi23QZDyKSJnE18b/eEvP0depW9eYF7w==
X-Received: by 2002:a5e:9e42:: with SMTP id j2mr4479594ioq.133.1565106727344;
        Tue, 06 Aug 2019 08:52:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z19sm96294673ioh.12.2019.08.06.08.52.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:52:06 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Fq63P011508
        for <linux-nfs@vger.kernel.org>; Tue, 6 Aug 2019 15:52:06 GMT
Subject: [PATCH v1 2/2] SUNRPC: Inline xdr_commit_encode
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:52:06 -0400
Message-ID: <20190806155206.9332.51158.stgit@manet.1015granger.net>
In-Reply-To: <20190806155055.9332.19343.stgit@manet.1015granger.net>
References: <20190806155055.9332.19343.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: For xdr_commit_encode call sites in
net/sunrpc/xdr.c, eliminate the extra calling sequence.  On my
client, this change saves about a microsecond for every 30 calls
to xdr_reserve_space().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 48c93b9..7ba0ede 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -560,7 +560,7 @@ void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
  * required at the end of encoding, or any other time when the xdr_buf
  * data might be read.
  */
-void xdr_commit_encode(struct xdr_stream *xdr)
+inline void xdr_commit_encode(struct xdr_stream *xdr)
 {
 	int shift = xdr->scratch.iov_len;
 	void *page;

