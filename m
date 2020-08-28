Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA00B2561B7
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Aug 2020 21:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgH1T6q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Aug 2020 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgH1T63 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Aug 2020 15:58:29 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4F9C061264
        for <linux-nfs@vger.kernel.org>; Fri, 28 Aug 2020 12:58:29 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m23so244557iol.8
        for <linux-nfs@vger.kernel.org>; Fri, 28 Aug 2020 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=igEhHjP8p0Ll7ZEsSweTl4iRmLMH9fF3vWzDp1dpBCc=;
        b=HuHv2U0wGVBMfOMEh9SYIeU9EBHrpGleoq9KYMNyISmC7X0LxKB+eXCgIQXqI+x7T1
         V4kWb/PCiaZ8kGi1zA19z3yyTj+2//s/s0bmM+63xZ+Jf2J6NtN3Z9UkE2DZiJ6IKz1/
         jbDMDZOfLU4g+4uF7sDk+bHOZsxJFGc44zxZDz6p4dQlEdJpuGeGGSdLjmoq4DviAnbd
         aKgjlG36+DWycng/Kn1AyapH8b31HPAtMKMzgY7OIRFLDhuHMeyAWvy31SRwDmSuqseF
         pH0tr7y6l6+jBmtnKcZHGoD3w/faKLXV+Ubf7jtUwx0hozaAiOhg4HuweJn9uO7QY1RH
         t0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=igEhHjP8p0Ll7ZEsSweTl4iRmLMH9fF3vWzDp1dpBCc=;
        b=JAZM+qv/U5HI+mH0M34tT9Zl5/Grbl3ubEk67PE0VtXEy77XdnKsvd5g7mt46RSH4M
         1+QApxsn8irBwDk7nTZMZF5NkSq3cWDp3PVFCcz8k+BhqtxN4wGaKbpKHzhb/sLx5gZb
         YKwIonP0Z34S2Vfu2+yaDDGgTwrv2yRtcQY3KTWLNEPYaQY/CETVQfS4KvAQ+cObnF21
         iQGi4KSQWcVUCe8BidganUj/qmIKirvQvxQxQaf80z/ee/xR89fZ93Jqt9cz7SxknbTT
         dngUg3mWcuw+6AUKImSSy5YQ5Y0qFmmL0JJnCgkt7i0jt0qn1mU8sbFcrCDKQ9i9xoRS
         VEQw==
X-Gm-Message-State: AOAM532FUD+d95UCPvWohc/XMTTQA0njKcdd0WkytJr+9pDSzFQtsmCG
        3OkdqNufp1ZxzBI8Qol0I+VzWV/fDfI=
X-Google-Smtp-Source: ABdhPJwC5066f8zChJgFduJB31EjoP0xEej/VSA0Jw70msKT3rEGqsZscaYCSdKClPa/7v1al+1RsA==
X-Received: by 2002:a02:950e:: with SMTP id y14mr2718166jah.106.1598644708465;
        Fri, 28 Aug 2020 12:58:28 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r2sm178894ila.22.2020.08.28.12.58.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 12:58:27 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07SJwPvw001930;
        Fri, 28 Aug 2020 19:58:25 GMT
Subject: [PATCH v1] NFS: Zero-stateid SETATTR should first return delegation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 28 Aug 2020 15:58:25 -0400
Message-ID: <159864470513.1031951.14868951913532221090.stgit@manet.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a write delegation isn't available, the Linux NFS client uses
a zero-stateid when performing a SETATTR.

If that client happens to hold a read delegation, the server will
recall it immediately, resulting in a short delay while the
CB_RECALL operation is done. Optimize out this delay by having the
client return any delegation it may hold on a file before issuing a
SETATTR(zero-stateid) on that file.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4proc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dbd01548335b..53a56250cf4b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3314,6 +3314,7 @@ static int _nfs4_do_setattr(struct inode *inode,
 			goto zero_stateid;
 	} else {
 zero_stateid:
+		nfs4_inode_return_delegation(inode);
 		nfs4_stateid_copy(&arg->stateid, &zero_stateid);
 	}
 	if (delegation_cred)


