Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1222BB741
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgKTUgp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgKTUgo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:44 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF52C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:44 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 9so1116964qvk.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yr3xQ+T1If5emyg1xG1E2WLncMDKxXULlHsiN1ikQfs=;
        b=L6lYxTx98tiVz/GZZkzpAhojRgF1qV4rFCrBMBR+JnNyDUIfPIJV5TXy2aCXLl29Zg
         WzcC9a8b/BLNjyWYTyO8nx6kWFDbB07q0VU58QXw0TkokvKu4Z8Bg4Zxo/mDR5k6o6kY
         fjtOrvYHFcSBApmutSPQ6UKpx156SS/Bd72pC34YRo0UscaVo9Ji8p1RnpY0SE9egXAB
         ea/FJ+g87C7DaA+lZtKOdWn4U+NVspcr8JtfrLEjJuGGZZjDHaCZLQCwnGT0IdLeyrG4
         uOYpnjdvkg3Uzb3TPDORY2XT0xkOK/A3W8Qu3eMypEiT3oDoyCMNGfyX7zkRyFiufL2p
         5zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yr3xQ+T1If5emyg1xG1E2WLncMDKxXULlHsiN1ikQfs=;
        b=le08KTegCQ2WRg+6dS8PzyQOkWWJCVAd6BTSn/tLA5mzO3/MooZkLeLq0iivbrZVM6
         4sIL32GXxx9u209BgbK2IZpVQ47a0b3Ds92F2JNnictn/D/W/xGbpjubyRRRydwljPOL
         VZOMHwcGtfwAP9BEzJKO4RegZDCCVC78d0MlYguwxZb+/4d/weaMyZXNTPFk6YgApBD9
         QvbHoHlLIRRdFbWA11C4sswRwD2pquALwYYBdTAjCjithtLiKJzgUdG/CE2s7m1f/I7/
         toRUJ2c8CNlW6UoqDvqUuKae+73ap7srs82YRYuptnSEEoPBiWZNkEtfLPkJhuorGwjQ
         orUg==
X-Gm-Message-State: AOAM5301JLbMVVYRqz9VF5j9dj3H23zBhkNwnawCSKHRhL6OoNxJpWmo
        EsNZuEx9Ik6MTPESOegkA/1z2O87gVA=
X-Google-Smtp-Source: ABdhPJx3qjMHVXGk9NZ3YX9eZ41W+hrqF3R3Rfen7Vdr9LdFjkOfAPvrgc+edHrvoq0JY7IKBaYb/g==
X-Received: by 2002:a0c:b664:: with SMTP id q36mr17651127qvf.6.1605904603261;
        Fri, 20 Nov 2020 12:36:43 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k188sm2786723qkd.98.2020.11.20.12.36.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:42 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKaf9v029301
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:41 GMT
Subject: [PATCH v2 033/118] NFSD: Replace READ* macros in
 nfsd4_decode_share_access()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:41 -0500
Message-ID: <160590460156.1340.2852970917358844357.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 608cb5e38c63..29b7c096b5f8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -959,11 +959,10 @@ nfsd4_decode_openflag4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)
 {
-	__be32 *p;
 	u32 w;
 
-	READ_BUF(4);
-	w = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &w) < 0)
+		return nfserr_bad_xdr;
 	*share_access = w & NFS4_SHARE_ACCESS_MASK;
 	*deleg_want = w & NFS4_SHARE_WANT_MASK;
 	if (deleg_when)
@@ -1006,7 +1005,6 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 	      NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED):
 		return nfs_ok;
 	}
-xdr_error:
 	return nfserr_bad_xdr;
 }
 


