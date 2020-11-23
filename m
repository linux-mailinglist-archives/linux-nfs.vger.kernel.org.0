Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E622C159B
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgKWUFA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgKWUE7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:59 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BACC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:59 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b144so3716046qkc.13
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sKctRiTsI4+gWPapXa/R8VDyO1YNtMROkytZLiJISrY=;
        b=FTXIfYiTydkGGhQb92rtu0JCIqF1jEcSfG+G7G0UsXWdRdCcvhzS/O9vAey04KMXX2
         oRlJkESeqUwzeAcGhpxO04r6CwWGz5OIPaFk1LKzbOhkDF4WJI/bbaKmBhaapGbw4vTc
         IV9kf27umXGB9/sUVCW4m5j0KhRA7A8kiz4rj3nAtGVN3tJuxwcPPRUlRVDrwQC3hJeE
         eUNHA/yBUzxBYYSCFwnnf0GWevjJDRGAc5viWHvYVFUG9a9B6NnR3MBg91r45DQqvk0x
         VAdewnxYARy1hpS0BI77vhg3yRqsGwhdGPPSg3zYrkWvjK2alkzak6UIfmMYKuJFExzF
         wnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sKctRiTsI4+gWPapXa/R8VDyO1YNtMROkytZLiJISrY=;
        b=PkqqsmUMblwI7vfO8ImbLwI4JG4espX4acL3DgWIUG3hAh7CqSupJ7h6kG1Lb21FPw
         DVU8SiGxrMZYMvRfTvmPAlpx2sqqGQfTCdlK8K4MZmou5/sIstB7vsufH6E6/H4pUXzb
         +PKKMZPynaGOWEQZKUpNDAuvZt1oDl0LBhNxc9dcqME8MBXJSaqRwVmZfqKWdpBaQZNt
         Legm4Hn0Cbj9sgVjoWTWK6hwkHMD1CDm5Bej61XigCzD/VBWkNTgp74Xyq2AcfCG2NNt
         obBIwtNqETouZWYnIJnK3svs/OY22fURi8D7drcQ1WUJRUfW+KzppiXJEC9U3mXrZADV
         HUcA==
X-Gm-Message-State: AOAM533HrCpE0j5BCmUECigQo6/IMwNXuwQbDMiHZR44LKuQhdMwcaER
        0WcfEeqyKcVA9fmf9dI+tF3w/LA5wyE=
X-Google-Smtp-Source: ABdhPJx3vI/YY8sIEJ/I/koY8LRb5eH2kzB1gEopp/72y0Upc294XvGrSmghtKPHEHm2L15SQjypfw==
X-Received: by 2002:a05:620a:11a4:: with SMTP id c4mr1291196qkk.8.1606161898686;
        Mon, 23 Nov 2020 12:04:58 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 72sm10099441qkn.44.2020.11.23.12.04.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK4vqN010301
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:04:57 GMT
Subject: [PATCH v3 11/85] NFSD: Replace READ* macros that decode the fattr4
 size attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:04:57 -0500
Message-ID: <160616189727.51996.3163424533928322558.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6dae8b0a5f0f..ec47efd68c72 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -273,8 +273,11 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	starting_pos = xdr_stream_pos(argp->xdr);
 
 	if (bmval[0] & FATTR4_WORD0_SIZE) {
-		READ_BUF(8);
-		p = xdr_decode_hyper(p, &iattr->ia_size);
+		u64 size;
+
+		if (xdr_stream_decode_u64(argp->xdr, &size) < 0)
+			return nfserr_bad_xdr;
+		iattr->ia_size = size;
 		iattr->ia_valid |= ATTR_SIZE;
 	}
 	if (bmval[0] & FATTR4_WORD0_ACL) {


