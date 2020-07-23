Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2754122BA0E
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 01:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGWXOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 19:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgGWXOx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 19:14:53 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C829C0619D3
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jul 2020 16:14:53 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q3so5777883ilt.8
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jul 2020 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qBC4K3lFiw7pCf+56T+zHZWPPNMwFAjZMMqcE26CPqM=;
        b=XlKwHHipzniklC78JaGKGRtbmEgxCUmtbfisRarft+KN1V+EVFvt+iUWF7M2AVJmYq
         hGzL6P5Ez2crsjfhnMzooHcJ5qpLA3p/j+LFENE1BZu5EZgGOGaSZUDBJNx7BSiu3dM9
         AFrhQxgvSCWmwejZ2mnLMWX3B0RaDBtkNjf+/KhrnaE+H8rtKkVE/HkQ+LFO1mVagfl9
         tn88O8jNWTw6pJ/4tj9W2hFbmcwAVjNCqYE1iI0CJhiX2tXldISrsQyaVprqvIsgv66i
         ExMfcaGcZDJlMacECD/ZzX2z6EF8LxwNWx+8oxjaPSuuWVI/WrC/FXTqOQrokih+f5FK
         Ga4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qBC4K3lFiw7pCf+56T+zHZWPPNMwFAjZMMqcE26CPqM=;
        b=TyOfIouwr4afcmEbqVjEuqtIksmNExE7uXO1lGpo7U361wmJsPndoBOpe0g9V6vp4z
         b85P5Lo3cPS1a46b3vrQx34w9liiwhQ9uqrTgN6SakvyxI/ZqY9rm61AvxCAhsvJT+BJ
         d3397BLDg4lNNzv1nt4ArsJILihXTz500cge/LmMAKiRXRRorkjthduEmoJoKyf7NofV
         RDdGbF21thbFEomVpSlRhzJGrl644xkk4H6emF+YyzstI6hkb0sjT4c6iqTLCZJzlKoo
         e7UdY5A0D2vA2aYmswlmrVhd8j+c3PR4l/dPxJqTXx+7TuQIDIRrL/HzD32ZcH3tKiQt
         Qw+w==
X-Gm-Message-State: AOAM530WqPa400QHiGuR1zLTa9+eW6EVzkuhEWx/+oIOzY/akxI1JIFK
        n1I/SOlG9VNF1Q+bp0CQtVlnjJ1J
X-Google-Smtp-Source: ABdhPJxC9i8qhsn18oWKaBWEpOTkovmivT2NJtLJ4JHl3zGlNx7ypADvykB7w4+DjFp3h0Zv/BRBWw==
X-Received: by 2002:a92:9a17:: with SMTP id t23mr7577468ili.105.1595546092237;
        Thu, 23 Jul 2020 16:14:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g1sm2167091ilk.51.2020.07.23.16.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 16:14:51 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06NNEoZv003341;
        Thu, 23 Jul 2020 23:14:50 GMT
Subject: [PATCH RFC 2/2] SUNRPC: Fix buf->len calculation in
 unwrap_priv_data()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Jul 2020 19:14:50 -0400
Message-ID: <159554609056.6546.5370422049655090479.stgit@klimt.1015granger.net>
In-Reply-To: <159554528704.6546.6823326959131917327.stgit@klimt.1015granger.net>
References: <159554528704.6546.6823326959131917327.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pad adjustment logic in unwrap_priv_data() is unnecessary.
gss_unwrap() should already updates buf->len correctly; the
additional adjustment can drive buf->len negative. This causes the
nfsd_request_too_large check to fail during some NFSv3 operations.

Fixes: 31c9590ae468 ("SUNRPC: Add "@len" parameter to gss_unwrap()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 7d83f54aaaa6..9ac23d83f9a2 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -989,8 +989,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	fix_priv_head(buf, pad);
 
 	maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
-	pad = priv_len - buf->len;
-	buf->len -= pad;
 	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
 	 * In the krb5p case, at least, the data ends up offset, so we need to
 	 * move it around. */


