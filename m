Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2305D2B1E26
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKMPGH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPGG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:06 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92CAC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:06 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id j31so6829940qtb.8
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1fHRW/UEEiR6jvLD5WddzqDt9MFE3LP4Xz6L/Jag234=;
        b=emyvwGAb6FjPo+J7jzYlkAVcnNhtwn4duuFC70YqR7quOkg/2QfzClUkkUaQ1s//0S
         B0XlKaPjBy1x0W288SBUYnhhT+XkQzBTFMMJWStp0kCSmHWyX1Q9EmuzdaJ0M++I5J4Y
         w1XUIg7g5sKS638EOIgho70QjSDupXySRkqh9CdOU6LsQ3QIdfs8YZm+7wIgx/0A/uCn
         dV9svzoo44gw71ly1w6R/S/BQvIWogtxvb8KuRF9mYmq9AoOq8MFqnnosJWLgrrNfaWs
         /fZcC+d9qc2GF8INwpwZ2TvYsbjin3SsauM6AIqHJVgUwd2cR/hOwGqllI/lAiVrTqGF
         tOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1fHRW/UEEiR6jvLD5WddzqDt9MFE3LP4Xz6L/Jag234=;
        b=Dewqao93iVDitqqnbGr4M8aksRQHXHJqGEaowlAJP2hQvJTIw4Ux5uk6HQALzxk8/D
         FKMfOjse6ufVXfbl4MHbKVFXb8QI5KVqzlR3DoGC+sId25RHRlsl1eb52df0NqdHzAbr
         RtF13EKKvJ8jd/DDDfapteJY55ltsKmDZ/dnwv/A+OF4nR5ndw6Kqh+xHf+OATaCLiUi
         QgrZuIpXS+du0IP083jIE97EpcRSAJBKG3JcY4FgO1CyQE1Ko4wm/HBK3LejxnpE8zoX
         Tce3R7Szlm8IfovYfuuIAbKRYrW6jed+SSC8kCDX8+OAdwHT4n2QfRjDQ8IEycJqvFhv
         AtmA==
X-Gm-Message-State: AOAM5320OWEb4DSZ7vWpZ+1YJno/9Vvtc0q6UDr5zhQESFhfg2XsAS61
        +oOqK+08uXUotgqbKoBSEU/RWoCUKVE=
X-Google-Smtp-Source: ABdhPJwsutinTLIhYoDjX25lX6zTLZN5DeyMsaBgx1ngAq5kAt1JOzxVNmnJqFCH3wxpAnPrsUWX/g==
X-Received: by 2002:ac8:6f1c:: with SMTP id g28mr2341700qtv.65.1605279965604;
        Fri, 13 Nov 2020 07:06:05 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w192sm7013083qka.68.2020.11.13.07.06.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:05 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6388032763
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:03 GMT
Subject: [PATCH v1 42/61] NFSD: Replace READ* macros in
 nfsd4_decode_destroy_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:03 -0500
Message-ID: <160527996396.6186.7996684191771574559.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index dfd2008db299..a6b7533947dc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1682,11 +1682,7 @@ static __be32
 nfsd4_decode_destroy_session(struct nfsd4_compoundargs *argp,
 			     struct nfsd4_destroy_session *destroy_session)
 {
-	DECODE_HEAD;
-	READ_BUF(NFS4_MAX_SESSIONID_LEN);
-	COPYMEM(destroy_session->sessionid.data, NFS4_MAX_SESSIONID_LEN);
-
-	DECODE_TAIL;
+	return nfsd4_decode_sessionid(argp, &destroy_session->sessionid);
 }
 
 static __be32


