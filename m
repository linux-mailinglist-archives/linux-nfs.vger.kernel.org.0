Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4910ED25
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2019 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfLBQ2i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Dec 2019 11:28:38 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37025 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfLBQ2i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Dec 2019 11:28:38 -0500
Received: by mail-yb1-f196.google.com with SMTP id q7so201412ybk.4;
        Mon, 02 Dec 2019 08:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZC6q5PpJ6oSFEW9OHKUUuEJBGKigyt0hHZFI10zE8SY=;
        b=Fmq/1qA1JvgI3UQtKps1LBbY+dxTntvmvL7Hj9FuYQUxrDIcPIEBBqfX1EVRJWCYDk
         C6JS/OC0XOQrTPLt8ZVlNvRHUrsg5LZM3lL7DHBZLCFxBSTUA6ndWXTXarC1KsjEA5/F
         ckx5eKqIsdnK/2WSB3Jk3UHVifXnuJBAitHomr0VsQAJmv50htQhHJPUfsZH8GzssjI6
         /T5Df+hRvCJq00m+BZviO2wn+apkKzzBLmtuOVt9Z9bl89/zl959RwRg1ncl66KG00a+
         5309ylhfmXDB84LcDHduX/zxNmqC5iPQY97XZ3PLu/tTpgTrs/8fuzUbTBuo/x6HuMLW
         0pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZC6q5PpJ6oSFEW9OHKUUuEJBGKigyt0hHZFI10zE8SY=;
        b=nU4P+5vaUgH0Rx2RDXazSkCXXYdQuQE3lNFOdyyUW0UhZmxQqVyXdNp4THOAV/Rb/F
         sIE149lXVNexB+z27FTo7S+qJnWENygIAxJvAdfpLXZYyZeX+MLUHq3vfQbCOPPSqcnb
         hkqstkHNNP5Ul0uy8As0M9OL0RgsQu0m+agTSyNIlGQdH9w3Dy/oKa6m9cEP7zHqw2rx
         jJOk1hMBIHyPxWwGeyqPQt2NBkrXHDCirBx+X3nImG6UUbYTs9WEwYLrRImbpRIq8CJl
         E6nJOXdKBdT4orSk/mHGP3Xd36Rx4s9Xi2H9PB99KwYsFNLDEJqfwrQk8EXcZ9iBvuYt
         3SDA==
X-Gm-Message-State: APjAAAVKjQsMaEqcJwrG469uQFLYwn3knRknFmQ6ixfAy0kvvSP6Ks8g
        GGFF2e2DM5XiaB/r4MfGm28=
X-Google-Smtp-Source: APXvYqwmj5NHxKjID7WYZMXnP9mxgel23eAbxA/6c1U5qXZESRK2f6I4MSWh9QqgC7HpKtEudSM2yQ==
X-Received: by 2002:a25:7752:: with SMTP id s79mr164725ybc.161.1575304116600;
        Mon, 02 Dec 2019 08:28:36 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u2sm35403ywi.61.2019.12.02.08.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:28:35 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xB2GSXwM014258;
        Mon, 2 Dec 2019 16:28:33 GMT
Subject: [PATCH 0/2] xprtrdma device removal bug fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Dec 2019 11:28:33 -0500
Message-ID: <20191202162242.4115.94732.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

Here are two bug fixes related to DEVICE_REMOVAL support in the
RPC/RDMA client. Can these go in 5.5-rc ?

Both of these deserve a stable tag, IMHO, as does 572c4b40a394
("xprtrdma: Fix MR list handling") which I've already sent as
part of for-5.5.

There's one remaining crasher that I hit when removing a device
while there are active NFS mounts. I should have a fix for that
one soon.

---

Chuck Lever (2):
      xprtrdma: Fix create_qp crash on device unload
      xprtrdma: Fix completion wait during device removal


 net/sunrpc/xprtrdma/verbs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--
Chuck Lever
