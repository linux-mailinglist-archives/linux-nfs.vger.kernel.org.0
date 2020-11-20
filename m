Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4C2BB76A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgKTUjI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731622AbgKTUjI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:08 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A028C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:08 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so8101961qtp.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SrIez6Hwmwv/31o9/vG82aCR8FDLLWLxST6fDk9WhkM=;
        b=DQhqjWLfBT3R2Lq9CtSeS/G0WGuHV84G9DwlqVU9Wb1uoEKWkWHP4IfATVUTu9wTiq
         GTQXIrkSUdVSpcgwzJ9mQkvghQlH0BbZyL59XMPJWnLpP7aKnXvJmFBwdNlAeen2Y/1v
         4RaKaIBoEf4tttWRnOI4GZbAVSre/9hCthlcuhXgiWlgnLXNPAMGo+2P5xyRDibbt8Ct
         Hs6j0XVxdm+jND7xSE2ZKavrDazEock3jypnNolxWyluJf6EZvQx4f6NaGYM8KHMdfcb
         2x15Ve/S+iYltJEoJbi4qI3iDzBe93JkzKlsV+yG6tb7quvU5eTes42Bi/Oyi6T300yH
         3XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SrIez6Hwmwv/31o9/vG82aCR8FDLLWLxST6fDk9WhkM=;
        b=m5AdRmDOl5lvm4l7ySMqn/bG0YoCEMYgkTHqw4chmCBHUtMBgIcMjcPmBQMYHVbkK2
         6ZZuYROEW0Tn4qafFgZ6nwBx+4rEq7E6IYtsnHoxNigIL1AH48DOTyUsNSGmfYAAXgBP
         ZDGFzv3w+0K1XMOyV2/0ryZng+gr7O8QoVTW/f+DSMOhb/q4QMGflcaaQBCddPUqvFeQ
         kC/eNbxtJgNYyY+o26JMxx3vmtCSmJLsKHvL2K7NqL4tqyxSlYPhegQITpcGVtI2nxoc
         0b9QKACeuZoouD6/3mdEvkbCydSkqj5vbiF34oD+sCNr9GaLEFfzfP3bvriI+Yk1ec8R
         NGVQ==
X-Gm-Message-State: AOAM533n6PWCiHPbeRzJmCI8ikns1+qea6PtPJJ7i0fxJ5D2VR6KJZKx
        dPkuAtPkHGhNs17tCQmEaAnQhkZ2yYI=
X-Google-Smtp-Source: ABdhPJw4kAi2ERXrJJWgil0XTIvR0HPENDha3oWImpaFFWp3PA7UhS6A5AJtCc/0a8b4ThqSEEJDBQ==
X-Received: by 2002:ac8:7316:: with SMTP id x22mr18127296qto.386.1605904747020;
        Fri, 20 Nov 2020 12:39:07 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j124sm2874340qkf.113.2020.11.20.12.39.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:06 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKd5NO029383
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:05 GMT
Subject: [PATCH v2 060/118] NFSD: Replace READ* macros in
 nfsd4_decode_destroy_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:05 -0500
Message-ID: <160590474527.1340.14432355167883542373.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index 38a54bd9f1cb..9c17cf541e8c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1619,11 +1619,7 @@ static __be32
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


