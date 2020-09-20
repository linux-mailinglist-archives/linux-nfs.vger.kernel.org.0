Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B592717A9
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Sep 2020 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgITTve (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Sep 2020 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITTve (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Sep 2020 15:51:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60736C061755
        for <linux-nfs@vger.kernel.org>; Sun, 20 Sep 2020 12:51:34 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v8so6463423iom.6
        for <linux-nfs@vger.kernel.org>; Sun, 20 Sep 2020 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=y1QUHKUBwcHb+yMpLoR6NqhO3S0msVPWxArMrWPxqlo=;
        b=e2qoGWmXgXnbfwJB7LGSPyciAcQ2B8dKFmXhxAxDtYsJ9in6VsbFMbYJQ5dSyMr+t6
         MWTMO0pfmkQ4T405SgdaWTku3lswncn6nDzUAfNLHi9hHDDXBUUW1fPo4HXJyV9T2a2Z
         TdHdxu04eeJWsmfhWWDHKAl6z7OtsvQwunbi6SCVyRT0CE25M0c/2uwCc3ZyRYuPo64a
         jvfXFxDlW5/QHN3El4PL8HrOuW2RC5B/U7ZH9NlF4lCC05eyCV2OqKw9COVcNKqDVHYS
         E8Y+rS3/24ZPDEa/5w39NafKKkaPRf/xBvYCe0oOEj7TUqGzXfihCucXWRgk6i2Zseau
         SH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=y1QUHKUBwcHb+yMpLoR6NqhO3S0msVPWxArMrWPxqlo=;
        b=caVvMs7CBuaUi3MG4dU28/OcqLNymD42wfeff9mfO4myI/nelTA7h4c+P77Ho+NQMb
         yPLQ/zqBOCvxUqFFkp4WtjL4sw8erhxBdIXVvkO72le8crP44snLHJ4eC6pK31rGyAix
         EymVA7uXAvKR945KHd1de2ygh0pUZDhkSa+6txaXecQqQTDL/zjP5sf/5hwsAtagLPFY
         /WnPad78PJhgxUCwxdN/DJ/hgy1lh4sgnnCnYX14L+1VxV/veWDAvn83PhBKInlRyQhW
         FkQJawmbRVEX/jqCG6zlBkfSypNYmSorUkTDqCBPK6yFceUNmkVoK3YAe1OWjhg0TKkr
         1hdA==
X-Gm-Message-State: AOAM530+gWt5U3FGBNft6HLQNfZuIKD9mk7WS5eHOEYTKmydlcY8OcG/
        ejL0yW+xNHj3/a6VoPC+AKBRSQNs13o=
X-Google-Smtp-Source: ABdhPJx4JcqH9jb8MsJ4xem29F7OcnLd9YTv/ELxuqiWbLG7tB0QE+28c+UMji9ImrEEvohGa/RthQ==
X-Received: by 2002:a5d:8b88:: with SMTP id p8mr4908072iol.172.1600631493185;
        Sun, 20 Sep 2020 12:51:33 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k1sm5679217ilq.59.2020.09.20.12.51.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Sep 2020 12:51:32 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08KJpUS5001276;
        Sun, 20 Sep 2020 19:51:30 GMT
Subject: [PATCH] SUNRPC: Fix svc_flush_dcache()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     zhe.he@windriver.com
Cc:     linux-nfs@vger.kernel.org
Date:   Sun, 20 Sep 2020 15:51:30 -0400
Message-ID: <160063136387.1537.11599713172507546412.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On platforms that implement flush_dcache_page(), a large NFS WRITE
triggers the WARN_ONCE in bvec_iter_advance():

Sep 20 14:01:05 klimt.1015granger.net kernel: Attempted to advance past end of bvec iter
Sep 20 14:01:05 klimt.1015granger.net kernel: WARNING: CPU: 0 PID: 1032 at include/linux/bvec.h:101 bvec_iter_advance.isra.0+0xa7/0x158 [sunrpc]

Sep 20 14:01:05 klimt.1015granger.net kernel: Call Trace:
Sep 20 14:01:05 klimt.1015granger.net kernel:  svc_tcp_recvfrom+0x60c/0x12c7 [sunrpc]
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? bvec_iter_advance.isra.0+0x158/0x158 [sunrpc]
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? del_timer_sync+0x4b/0x55
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? test_bit+0x1d/0x27 [sunrpc]
Sep 20 14:01:05 klimt.1015granger.net kernel:  svc_recv+0x1193/0x15e4 [sunrpc]
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? try_to_freeze.isra.0+0x6f/0x6f [sunrpc]
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? refcount_sub_and_test.constprop.0+0x13/0x40 [sunrpc]
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? svc_xprt_put+0x1e/0x29f [sunrpc]
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? svc_send+0x39f/0x3c1 [sunrpc]
Sep 20 14:01:05 klimt.1015granger.net kernel:  nfsd+0x282/0x345 [nfsd]
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? __kthread_parkme+0x74/0xba
Sep 20 14:01:05 klimt.1015granger.net kernel:  kthread+0x2ad/0x2bc
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? nfsd_destroy+0x124/0x124 [nfsd]
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? test_bit+0x1d/0x27
Sep 20 14:01:05 klimt.1015granger.net kernel:  ? kthread_mod_delayed_work+0x115/0x115
Sep 20 14:01:05 klimt.1015granger.net kernel:  ret_from_fork+0x22/0x30

Reported-by: He Zhe <zhe.he@windriver.com>
Fixes: ca07eda33e01 ("SUNRPC: Refactor svc_recvfrom()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Zhe-

If you confirm this fixes your issue and there are no other
objections or regressions, I can submit this for v5.9-rc.


diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d5805fa1d066..c2752e2b9ce3 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -228,7 +228,7 @@ static int svc_one_sock_name(struct svc_sock *svsk, char *buf, int remaining)
 static void svc_flush_bvec(const struct bio_vec *bvec, size_t size, size_t seek)
 {
 	struct bvec_iter bi = {
-		.bi_size	= size,
+		.bi_size	= size + seek,
 	};
 	struct bio_vec bv;
 


