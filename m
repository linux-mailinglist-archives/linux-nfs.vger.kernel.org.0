Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D403950E1
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfHSWh2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:37:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45136 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfHSWh2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:37:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id v12so2587191oic.12;
        Mon, 19 Aug 2019 15:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KGw+O8zhRdR6qOzf1+hFXDgB8d55DXqyorgudiaLglA=;
        b=Sn4TwetYV1xBZAep9BXXAFmwF7kGpp8l16LWM65wutSt1AceQdBSJmwzayzUwQ6vay
         Qvji3v0RFTt9PHNniGiETy7AsVGMHXa3mqnoWFsPGiqcL1aORVPMrGHo1Bd+j7Eb87aR
         7LMfud0rJ66jp1xdKoj5rvQZUmqzqJcxz09csJO6vTT8pB069BjgwfAXMb5MChRg+5u/
         rbkYatrun4C+8kKRlNE5zkDldDiDWUw/Ncte8jz5eRDhI3XuWn/hdIIoXnG7qF9KBFoE
         h4zbYVQcupqLiHkN97vWg/QUga63q9a4/i5Z43OZih1iQz9WZ2PVnAh3PK+p7MjQKAG2
         TVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KGw+O8zhRdR6qOzf1+hFXDgB8d55DXqyorgudiaLglA=;
        b=JxzcF5h50vWurRtJY/coxqqZOuYkWl4Nt4HSzR5XGiHHDWAVI0yredWHwyHrGeYOsL
         mo8Q1qS6Dhwsp9u17TgldBz4aT4yAAsn10QnmMuk0FPdLo8CiCe7xH++L9ijvGAB0/nu
         AUOSrac1v6FMnM9LUYYcnOR4dDWOZuz0e5mzoOAx8TDcDtyE7uns+50mT3BC1TGiCV6p
         q5QAWWX4bX3QUrUGVlAUPtvUI2AkM3SWlTAWOI0yP2NNQnhVZLRZ63j91QZsbAbpUft6
         YF5dgmlA99Yrc1oEYBwirw1gftLWEVW36vjuU12vkM0vS0PIfgmTjUR+VPm6l7P3HcIQ
         O3Mg==
X-Gm-Message-State: APjAAAWoXZAomIl9aYpT0Oue8KU20coS+V7nGQoVm9oNA/MUr/Ceg+8t
        2dXaGFzMgYszz0JQe5IMcQFfDX3G
X-Google-Smtp-Source: APXvYqx8rizhqOOm6eIIZGHJ1F5x0Tdwk1fM5A/EW+r4/16jx3mdyJtZ9QKxCeMMw1+gIK+F775nxw==
X-Received: by 2002:aca:3804:: with SMTP id f4mr14365915oia.144.1566254246924;
        Mon, 19 Aug 2019 15:37:26 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id 23sm1541199oiz.8.2019.08.19.15.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:37:26 -0700 (PDT)
Subject: [PATCH v2 02/21] SUNRPC: Inline xdr_commit_encode
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:37:05 -0400
Message-ID: <156625420544.8161.7549333388864452214.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: For xdr_commit_encode call sites in
net/sunrpc/xdr.c, eliminate the extra calling sequence.  On my
client, this change saves about a microsecond for every 30 calls
to xdr_reserve_space().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 48c93b9e525e..7ba0ede6b417 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -560,7 +560,7 @@ EXPORT_SYMBOL_GPL(xdr_init_encode);
  * required at the end of encoding, or any other time when the xdr_buf
  * data might be read.
  */
-void xdr_commit_encode(struct xdr_stream *xdr)
+inline void xdr_commit_encode(struct xdr_stream *xdr)
 {
 	int shift = xdr->scratch.iov_len;
 	void *page;

