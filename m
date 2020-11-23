Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D492C160D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbgKWUKt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732324AbgKWUKs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:48 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34112C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:47 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id 7so14389478qtp.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5nmiyjvYlkAqkvPs1LqcmGygRD8P6SMWptLydX8ja7M=;
        b=hVIyC7lQoaNShdG6SRmzodpzMZ8UU8fS+W4BaQ+mMwKbVSZZ3iu3Klh05AkZsr3VGI
         j9TewOs/2o41Wmnd0yCAQ/nfdCP94468FsPwSKt+ygNEPgc7VkT2vYZm3r+xfRqs5fjR
         P1IuESucH6+lamjfcFm3tYrpGMTh0FWX9gj/8FsphleHlr7lnmN6n7UlIjkKhkMXeV+z
         75wvwh9GBrbD7I79zCuOR7M6gQ4gUJdSZTYp1Dz7RXfmzWwtgp4HkHMnuGIufP49ykuj
         b7iIMCY3RXgf6PnqWNlQDO+eA8LVSw/ACRmNd/45JBIekwd8ZVhy4B30LEeVx7S3zrHo
         1F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5nmiyjvYlkAqkvPs1LqcmGygRD8P6SMWptLydX8ja7M=;
        b=JH9zRrSIhBejzvQkjDm6tW2CTtOkSrLsMemrq2IdaZr8lTVbzqvFBHmsyk4YZBJhVH
         1PRLaE+Vu+OK9c/3NtnfgN1O6chXO6iI2fGh0SHU0CwOT+zlBWaWWM9TfzF6G1MwpMFe
         V4ShEmz8U5bfud2dNxJgnWMuG1S120BU1iU82ZFCUsUSx7VmF7rodeCam0pnH/ftIcbT
         8puENJ4forNLRuhfwBYk1tGEoihiyLUPh+xve6WzPDfrF1ov2kIrBIz4jT8qMqhKhYWe
         yi7Z46QzNQU57ynUaLUPKK9ueHruBrUIzPGO6vROQoLHAEOX3PiVX6o71gExXQiM+qaU
         BrDQ==
X-Gm-Message-State: AOAM530iloGD3PvHxFikwaeiyvDiYk3lM7b4RlPv881Wo7YFEe9QY8Ix
        8fcC9cjqbuU5WfXjwMQh+tSBPCkj2Xw=
X-Google-Smtp-Source: ABdhPJxgh1MVck517hvSfkOmqQ/ZZII2cSNNsARofydPCcRK47hOE7/W/7MGhfba9THJPiEe8FbPZQ==
X-Received: by 2002:aed:2946:: with SMTP id s64mr876140qtd.73.1606162246131;
        Mon, 23 Nov 2020 12:10:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g18sm10218787qtv.79.2020.11.23.12.10.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:45 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKAieH010515
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:44 GMT
Subject: [PATCH v3 77/85] NFSD: Replace READ* macros in
 nfsd4_decode_offload_status()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:44 -0500
Message-ID: <160616224429.51996.7231216723680030078.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 196bb9bded3e..0c8c2a3f389d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2048,7 +2048,7 @@ static __be32
 nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_offload_status *os)
 {
-	return nfsd4_decode_stateid(argp, &os->stateid);
+	return nfsd4_decode_stateid4(argp, &os->stateid);
 }
 
 static __be32


