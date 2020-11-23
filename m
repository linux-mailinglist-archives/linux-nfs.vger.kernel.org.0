Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C42C1597
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgKWUEl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgKWUEk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:40 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4DC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:39 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id l2so18291883qkf.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=njLLBy7BWEKIoNPzBFWF/Rgwysmdmg4ZQTlLf7t+JPY=;
        b=HDNBfc7gxf4yxwPiGRDEcTdvhp0rcK/fVneVk5nCaIRQonqiHFVz1+bEJw4UCVCx26
         IC+6TiE2+iehS4Ut2EZdWZ1nTmRF+4E2ygtUcBp4RcS2I6vpTkxV0smSh0YbgqI5h002
         GE0AfylMr+11NsAgvG0MMAZ/4K7qeSYTgVG4XeG1izUlFsbQWLvf2tw/Cmv3VcDQwiHz
         ROAq1IUA6I8/juo4ONhP7qfwMIWOmLLd/KdQIHFkatHBtvbby2eI/ygL3wByYEkm7egY
         i/PWiyqAC9HEoMJmGaB0VcQ7f4Y9A3icujMvKhHGxG0v8ammQ9NjsOtTEvr/iGEUamHH
         MYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=njLLBy7BWEKIoNPzBFWF/Rgwysmdmg4ZQTlLf7t+JPY=;
        b=Vv9OcWvejoqb7T8FHRHqHBhUsbfaNj6pH1RN58+XN+yXoinMMOKoELOXUNmKQDnKHf
         jSHZ9Zp+CH/JX89kOwnwCcUEfr1MAsonDYVWsOqY3bvalZE/yqfMy0EvG0lbqF7gcx73
         qQNuYp7utqYyz1N0v5YaSIsVvrtJqBCnfssf10CYR1/TWOyrgg8z/w6MNUPrZ0ZYqThM
         uhjJq0fK30U5eIr3bm1Z2dQDw6fQSfFgnkWGnCWs62ZbpIth3dK9p+hvAdA9F31n0rcF
         1AwuD1wAwqtqDzQxzJ+pq+7d4zyZzRULlFzn1JlSm3fLWUvWBFYlgujYMhT6adDPrJQ/
         D/xA==
X-Gm-Message-State: AOAM533oGuvn6trwS4F8nhnTxAWTKK7FWvnPOVfWyeahyhP1jcyUzSEJ
        w71d5rpdZncirBbdneesDhz2jlu6n5U=
X-Google-Smtp-Source: ABdhPJw3YELwKIEHE1GPpZYq2lGdIj9VPT+sf6mFAmwPG7pz1J19/D21ug5NcTtIUm8+e3hp8l5LTw==
X-Received: by 2002:a37:9a94:: with SMTP id c142mr1195960qke.480.1606161878137;
        Mon, 23 Nov 2020 12:04:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i9sm10226383qtp.72.2020.11.23.12.04.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:37 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK4a6m010289
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:04:36 GMT
Subject: [PATCH v3 07/85] NFSD: Replace READ* macros in nfsd4_decode_access()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:04:36 -0500
Message-ID: <160616187607.51996.15759892839673887795.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 25eb6bba48ca..f490832a1a06 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -439,17 +439,6 @@ nfsd4_decode_stateid(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	DECODE_TAIL;
 }
 
-static __be32
-nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	access->ac_req_access = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 {
 	DECODE_HEAD;
@@ -531,6 +520,19 @@ static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_
 	DECODE_TAIL;
 }
 
+/*
+ * NFSv4 operation argument decoders
+ */
+
+static __be32
+nfsd4_decode_access(struct nfsd4_compoundargs *argp,
+		    struct nfsd4_access *access)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &access->ac_req_access) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
+}
+
 static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
 {
 	DECODE_HEAD;


