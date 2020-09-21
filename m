Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8E92731A0
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgIUSLw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgIUSLu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:11:50 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F88C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d190so16462572iof.3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bz731S6wZQA+1qpFznGE8eQlmK/fBClUt6HbiD7bfaQ=;
        b=Gtp+CzwWABSxW/m8b0ZgCz9qac4MkiGsuAfioDE42YHuDPv+Bzr0742gxVkb888Tu0
         mZ7SYm4jEyn6X8v6DbNXBb9eSLWF44kD2xag09Sm8JPB6TzT3f/TLemIGes6uW298mG8
         eB+o1mYXxIN8eMtyJhQyOjm3cOpCgu8F5SRn9K3Y6Dd3b61FECUJL++QVj4yY5G/zH2M
         nmbO8/slrwRZ8oK3ARNYMGxY/uJk+XSObJGCCJ1XIRV6ntfnANIR7R1kOgktJUcXx5Zd
         c87detxiAOzrWY/yvao6u7NiHbPIvDMWeyUzH9FxwuL4Wck3ikLQR+Ne2EISyGV7Mw40
         SExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bz731S6wZQA+1qpFznGE8eQlmK/fBClUt6HbiD7bfaQ=;
        b=cSGALnTy2eb35mOUfHYkUWUpr7k+PUvK6RRTL30AT6HOfzyyklanBkHsVCQeha2xje
         MAxV4jLamPjzWnhDKuRnfOyA+XLaRThQWnXTwzWGCXIRFd1M5FdlUHSwlly2EiHkkqGN
         PUeYF2bb9XT2Ma8+zJEU4kbN/BMezkaWt/PEcl0CADKa83mMlgKDvF+LkCkcMqm61u3W
         UC8grgs92p1qE3T/PHiVC3Nx/Mh+k1dep9Jo4Ykq0eoAfBr36tNeSdGZBv7JwkE1X/S6
         kY9Lf7uUkBGpBmnsOLVIJ7MUSl/2++9LcQIXEU9ZlUshE1CrjvK0/+Tl4AGny1vRJvhn
         MxNA==
X-Gm-Message-State: AOAM530J9fug/WTeE2GvgtFlBjTrG19qKLwx3C5/Ha2QCpw1a4QacWy2
        RoYvSazXInx9osyx0j8owiM=
X-Google-Smtp-Source: ABdhPJySlu5d4avJuOnkxaKi/R3URW0oqhS7JGxNxEA+52wQi9nKDhAa1EKt+X6FzXtywXrLlYY1bQ==
X-Received: by 2002:a05:6638:16c5:: with SMTP id g5mr1073688jat.112.1600711909606;
        Mon, 21 Sep 2020 11:11:49 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d8sm7748299ilu.2.2020.09.21.11.11.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:48 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIBlvP003875;
        Mon, 21 Sep 2020 18:11:47 GMT
Subject: [PATCH v2 11/27] NFSD: Constify @fh argument of knfsd_fh_hash()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:47 -0400
Message-ID: <160071190796.1468.14661699780965024213.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Enable knfsd_fh_hash() to be invoked in functions where
the FH is const.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 56cfbc361561..1a2e28369d04 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -219,15 +219,12 @@ static inline bool fh_fsid_match(struct knfsd_fh *fh1, struct knfsd_fh *fh2)
  * returns a crc32 hash for the filehandle that is compatible with
  * the one displayed by "wireshark".
  */
-
-static inline u32
-knfsd_fh_hash(struct knfsd_fh *fh)
+static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_base, fh->fh_size);
 }
 #else
-static inline u32
-knfsd_fh_hash(struct knfsd_fh *fh)
+static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return 0;
 }


