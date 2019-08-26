Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898679D4AE
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfHZRMn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 13:12:43 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:43742 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbfHZRMn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 13:12:43 -0400
Received: by mail-io1-f48.google.com with SMTP id 18so39027883ioe.10;
        Mon, 26 Aug 2019 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=a9o68lNKeR/dniyPZ+d1leVrk9R7ElGuOnCWSSVCoZE=;
        b=pPJGCmDMXHyMB8cdfNf9ChBfOTFHiSBWfcUbaLOcFh8cYBfQsSBmT/E07BWwcnf4g4
         uu1/QQEiVIRX/6Ozb3bej3wHYWxwGukqIPQV9vtaWsDtqLlWtq4quG+w8xsnLGdZxqIi
         Byc1zNfISaChWUreRXWReZeIH7OwBBmnjCLaCE3QVuU1Vn+eEirsx9vwgvVgZ7f5Gubg
         /yUMhYP5cwbDgG1PqwuuXmfvzLDXRFSiWkDBRqHxm3Ni1BRFGQQohaEib5/rHkM6iCqr
         Hz5TqhLFkA6x+966TLjyibYK36KWRSjUwCCd4lD8NQKFcMJubu43HgoItOZLEB1avw3l
         l3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=a9o68lNKeR/dniyPZ+d1leVrk9R7ElGuOnCWSSVCoZE=;
        b=UpdSIKr3CwhA4h80fDXPuqq3GjclDir0WTYx5X9vA1zKzYjKXPu5oQI6XjV6u145/u
         IE0ixzdNRJSxdbSoObymRyni1X1fXyZB9HWpXWxKzFzLLGeog7w4+U4SHoA6Xck3VF5J
         EZDMqwtG/mA1Kdvv20WcqX3Rnb59I8m4vAzEahfaq3dzt2Lx1W2F5K9/d2QExVlg+ctL
         phn6FY6308gafxbu55nC95+1O4gL7179LV4pKaVmCltkfhzBpnn1hH14DAHdnoe/Rr6C
         M7apeRnindFyLQ+yFjaZx6OVW7jbWx3ccdx97IG94qsj1T/FvgC0MVTPNu1tiYEdNmhR
         nwtw==
X-Gm-Message-State: APjAAAWfKwiKDIpHt0O598Tb3S4lJYblqLpCMr6F3sJIhxHqTxiQNqHt
        RZLgH+BxR9qLawDdNjss6HNWZO2r
X-Google-Smtp-Source: APXvYqwtHk7+P2SFG/Nw+WeqjmPS+U+FFFiksDJV/Hq/qP2MbqBhilHffHjc/5gcgalFGafTQ+Rw6A==
X-Received: by 2002:a05:6638:a12:: with SMTP id 18mr13438478jan.123.1566839562532;
        Mon, 26 Aug 2019 10:12:42 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n22sm13122404iob.37.2019.08.26.10.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 10:12:42 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x7QHCeNn031317;
        Mon, 26 Aug 2019 17:12:40 GMT
Subject: [PATCH 0/3] Three additional fixes for v5.4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 26 Aug 2019 13:12:40 -0400
Message-ID: <20190826171107.4841.41733.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

Please review these, and if they are acceptable, include them in
your v5.4 NFS/RDMA linux-next branch. Thanks!

---

Chuck Lever (3):
      xprtrdma: Recycle MRs after disconnect
      xprtrdma: Clear xprt->reestablish_timeout on close
      xprtrdma: Send Queue size grows after a reconnect


 net/sunrpc/xprtrdma/frwr_ops.c  |   35 +++++++++++++++++++++++++++--------
 net/sunrpc/xprtrdma/rpc_rdma.c  |   10 +++++++---
 net/sunrpc/xprtrdma/transport.c |    3 +--
 net/sunrpc/xprtrdma/verbs.c     |   28 ++++++++++++++++------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 5 files changed, 52 insertions(+), 25 deletions(-)

--
Chuck Lever
