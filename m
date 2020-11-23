Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E849B2C15E8
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbgKWUJ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgKWUJ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:28 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24348C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:28 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so14309501qtq.12
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yFFiqdVem/MPdj2HWBmk9d9Vu0BBzkHLvrLzApWI0ZY=;
        b=YQoyacK8pGNqRImQpFL+oN4cWVzGqm7A8KzaMn/Yl5PfIRYZIAcgeo55Kxs1QMWGHK
         g5m9GICwnU+GPZCd47JTfvYx/tuftffEyaHopi1yOvvO+k9cVqAlIRCdMy8KMaF2uozp
         WP1cMcti0it3RoVdCmiYKMT2qLqYY1zp6sJ1w5Vwj8g0IQlpExITfdB3ErmHu5u4EOHV
         LUtd3SnKf7mZcxB3fvTfN20tAPvvU6ecCBok1ZCNeHqmdIYZiShHFXRBhFnq1h2ZctKX
         0tWXNzwax2iOYx8MNH4sUxtEue0xrBf5gecNslcDadV9VcAnbqG+If3HDGSDzLnu/FsF
         AzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yFFiqdVem/MPdj2HWBmk9d9Vu0BBzkHLvrLzApWI0ZY=;
        b=q8rAke7GkWym6gkxOncwJvBPrONr6Jaa4ENDytz6wtyFiPR+bxaSrYNewYUAqX3Z7W
         mKiOl8vW564ud6SB803Xk5AmJ609gw55onKy0DLHzmRQYV1+7/CHYFuvgqAYKltMxZjd
         h/te47VZG7UgZxpnQxjOYBFzcibNGHbyhADPp1ndub3vmqxHGPdps+Z5CDmaAjComuqj
         TMgvLTddY3U1VWnqZYFk9X3hMNp3Kx+kWqIX3ke/EcrbV4PMW9PGCIfCltwnpbfeXXOI
         VYv6bJX79jC1zAE+CTtyU3cFXVwbt76tst0MP/98QI6gMXNrq1zSBPYLAL2jYfnGjwDB
         Hhcw==
X-Gm-Message-State: AOAM532hR+zTyXwO3n0NwkZ+LS8twR4/2kqxm1ycuDcg+MkXcgG4h/LH
        Z5DsYNj+W4DCExpj8JKmO3HEe3f9FWI=
X-Google-Smtp-Source: ABdhPJxn3Q+hybhcmV1OLmFqQ+iZcBmJtDY0q6QAmtxzDtGgrslN4Ek/F6W5CEoGafxI6CE8cuhv2Q==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr917849qta.178.1606162167116;
        Mon, 23 Nov 2020 12:09:27 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b25sm10244632qto.17.2020.11.23.12.09.26
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:26 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9PHg010462
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:25 GMT
Subject: [PATCH v3 62/85] NFSD: Replace READ* macros in
 nfsd4_decode_destroy_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:25 -0500
Message-ID: <160616216545.51996.14350695803519628936.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3904ebe8077a..bde832994be4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1678,11 +1678,7 @@ static __be32
 nfsd4_decode_destroy_session(struct nfsd4_compoundargs *argp,
 			     struct nfsd4_destroy_session *destroy_session)
 {
-	DECODE_HEAD;
-	READ_BUF(NFS4_MAX_SESSIONID_LEN);
-	COPYMEM(destroy_session->sessionid.data, NFS4_MAX_SESSIONID_LEN);
-
-	DECODE_TAIL;
+	return nfsd4_decode_sessionid4(argp, &destroy_session->sessionid);
 }
 
 static __be32


