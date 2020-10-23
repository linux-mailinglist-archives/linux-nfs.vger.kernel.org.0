Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E8297181
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Oct 2020 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750720AbgJWOlF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Oct 2020 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbgJWOlF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Oct 2020 10:41:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43FEC0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 07:41:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z33so1075808qth.8
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xt+DhrS+T4Xip98A7ck1syIL9xhn4/YWXjmKrR8nXcg=;
        b=kln6vg0gV3qQY8n5qGlr0tvQFBO0FN/aTfucyEwaEKOlScAZdjeij2DmY87UmYNsSJ
         Qde92ofo+B/difo6IpW0wSr/Sorw75Fa3y7SkuVgi/Jqhdhb0eUo9QlXnpcsUVIULj5V
         2GcL14fNbR3vdp7EqAvNr6F1Cp9iOLlGy8A7/dfxQqqSj8GyNYcAnALmWcViCgqOYTMZ
         ZNxJDhjTsgN/6shdSNsNSKGJ6rq3v2aF7R2ZeR/yqRc0E0jjsC1Zi9bsmc3CPjVC7lkO
         tosdNzNkXUEp5xlCJLCi1FR/ngGW4eSzeswPLrFmadq10m14sJSioM6oNhFEoMgkN+a0
         gI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xt+DhrS+T4Xip98A7ck1syIL9xhn4/YWXjmKrR8nXcg=;
        b=ZE90MIoIpTxLJGeD+hfUevXOEa5qD025hGRaLM8XMkgiEHxt6TpweI+e/0SPqjE2kC
         nSp9L4WT77R6JNXU2rEJlg2wX/hz9Fbx0fzT9xqJr9uob8Fs6pzoBWu5ShPqRSTw0ZBw
         g7BQQtioCJgP3St0DNt7QhoXR9OWWemvAzMyPv5dd4fvzwiuDC2d5slZzylaw5H4hcGZ
         KD7SspxBFRYznGVlKFQjClO/GdlH+t86GubObSDnojXPb4ZA9SLR/AL1HSRjqA8hlZWa
         ZPIy4OZRcQLlqBCivEonWsHsAWNvvh+HJVLOLgsewUY7XhD+sjetEHI2MqCjemM/TX+O
         UlGg==
X-Gm-Message-State: AOAM5322BQaqQFI2G7prv5F+yBdfw4KoiP/r8AJoiLwlKqazKobZgTB0
        xJpOagp+94ZlQSVozubZk1kx2cnxXgg=
X-Google-Smtp-Source: ABdhPJy1Cnbs+MO31P38WKKwNF+Mo0czqpUBUafbL46+j9taVCfwO8NX2Bo3BdFPQ37jHJRRhwm54A==
X-Received: by 2002:ac8:4f03:: with SMTP id b3mr2420388qte.8.1603464064121;
        Fri, 23 Oct 2020 07:41:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t9sm853734qkt.49.2020.10.23.07.41.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 07:41:03 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09NEf12W004140;
        Fri, 23 Oct 2020 14:41:02 GMT
Subject: [PATCH] NFSD: NFSv3 PATHCONF Reply is improperly formed
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Oct 2020 10:41:01 -0400
Message-ID: <160346406185.79082.5918603581435378646.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit cc028a10a48c ("NFSD: Hoist status code encoding into XDR
encoder functions") missed a spot.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 9c23b6acf234..2277f83da250 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1114,6 +1114,7 @@ nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	*p++ = xdr_zero;	/* no post_op_attr */
 
 	if (resp->status == 0) {


