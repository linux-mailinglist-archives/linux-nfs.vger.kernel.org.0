Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EED2E1D92
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406293AbfJWOBu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 10:01:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43236 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406291AbfJWOBu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 10:01:50 -0400
Received: by mail-io1-f68.google.com with SMTP id c11so15949670iom.10;
        Wed, 23 Oct 2019 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=i1onkp7tVbiousuoh/lKkPugrxCGZSa3fAT6ThfLs+M=;
        b=TwcQb8Uxlfoe1qDM8UjrLSAHW2xTmVWWrLMJxPalhcsldntJ41pwdWKRFNBfYfXprU
         V2v+cZOOCIs5hQs3qoLwFQd5Wx5h7uYacd+aqAIXQ34zoXR3b+A219tsZLZdfja3AxTJ
         YFXgrZYFq3vrpHJsma5c92ygvz12KxA/trGeZmzjIqryw9EUQVxjryzTEWMu3xfgku0l
         p0FKXuiUd6ROyJq9HapwiZcRL5wP+c4bji3uFhuHPnm/myQZhnivLMV8vXNW0NTzn53V
         FFOslrI8Bhki8DxNxMGZ2oIq/2l0zJ7NiYHJmxqWMXQXoBS1V3c3/ErFQMUhjwyttIVp
         1wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=i1onkp7tVbiousuoh/lKkPugrxCGZSa3fAT6ThfLs+M=;
        b=QLli1vtgc0ubeYFw7XCQxhlmhTtaCSTi1edb2ZoTuyPKtMVGwoQyazj9CdShEh0x51
         qsp6nhzPAN6VRS/YCNuSj69zjgxIX7GVmCYyqImdaIG9zoBx9NH5vgeF2u1l9b2f11tj
         HFRw0n6raYeY+uPocRb+XauoIufmmUfRHiD4fmZ08pHdb2R5U34kL6oJ1WgMmXsf9Pxd
         iF746K34IXgSl4aXaU8FJE5SA7xG0JV4A2yPb9MobtQWZAeQP+UaXmdQbAPjrGjIUHkU
         qJ7Xt1h3tVFZpVFSkJ3MFLzPmM3Y/DFG/ZUewRWyHBu6Nv/2JI6+xULS6VVuhR5pNxIU
         OG/Q==
X-Gm-Message-State: APjAAAUV/P8KxgvSnlaUWFjYcMAcuEJ7A4q+NP8forZG6pHET/Jftlsz
        gCzTtvUvAZ/YAiu9y9LG/VAJXqAJ
X-Google-Smtp-Source: APXvYqzUcoHsSLIlE3ex18X4hONq3ohOj6A/4Z9zQ+WGq9pT6j/xLH2YSEo3rHUy0gxbGEgPa8PSgQ==
X-Received: by 2002:a6b:37c6:: with SMTP id e189mr3195173ioa.61.1571839309248;
        Wed, 23 Oct 2019 07:01:49 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 133sm5421899ila.25.2019.10.23.07.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:01:48 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NE1kDO012538;
        Wed, 23 Oct 2019 14:01:47 GMT
Subject: [PATCH v1 0/5] RPC/RDMA client connect-related fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 10:01:46 -0400
Message-ID: <20191023135907.3992.69010.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

First patch fixes a problem with the logic that deals with failure
to establish a connection. The others are trace point clean-ups that
I found along the way to the fix.

This is the final set of client patches I currently have ready for
the v5.5 merge window.

---

Chuck Lever (5):
      xprtrdma: Wake tasks after connect worker fails
      xprtrdma: Report the computed connect delay
      xprtrdma: Refine trace_xprtrdma_fixup
      xprtrdma: Replace dprintk() in rpcrdma_update_connect_private()
      xprtrdma: Replace dprintk in xprt_rdma_set_port


 include/trace/events/rpcrdma.h  |  164 ++++++++++++++++++++++++---------------
 net/sunrpc/xprtrdma/rpc_rdma.c  |    9 --
 net/sunrpc/xprtrdma/transport.c |   27 ++----
 net/sunrpc/xprtrdma/verbs.c     |   34 +++-----
 4 files changed, 126 insertions(+), 108 deletions(-)

--
Chuck Lever
