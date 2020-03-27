Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEBB195A1F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 16:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0Pon (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 11:44:43 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:38371 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0Pom (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 11:44:42 -0400
Received: by mail-il1-f174.google.com with SMTP id n13so1815231ilm.5;
        Fri, 27 Mar 2020 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=2ykPEOgSq0wavRzazX4tMFg+Ejah2L4TJdy5WsFJqoE=;
        b=ZtiQqMEVUOYnpBfmeFamFP5oTnv52BpsMtztqk0PgOAcQ8mqHLTea3sDABawgsY+JR
         B/nKBv93hPGt1VR9ZYw1bjcJQro11uSEEM2uzW3wg5UWccmTomhEg57mkDyXjkmkW9C2
         /z2eXnv6TXBmYIKWG0NNWxNAx5Vx+VlqvvN7EvcsCcF7mi//Fg17odOixCw2UK/BcTig
         J1/N0AoMKRpJB7zSsJD7buGsfKoUhj/4fVj8br3JW8G+16Vjm/iEZrai97KBStyMZgMA
         zqKMKJG/vUCVft8iEVUJKmaEzNw00h2dyfY+eLQs/JmuNDTw/ZT67h5fYhLXJa3UHH2E
         9zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=2ykPEOgSq0wavRzazX4tMFg+Ejah2L4TJdy5WsFJqoE=;
        b=V1hbepaEzA5Mg6dN5lgch4tbiEb3SYkNOdEtbBGEZLzTt7UKJvg45xP38tJcfg1mlO
         Ks53tJVag7bmoF99diIUF1FQbYR9JOBmgGWnMxBY6NEJ+D5ViEWkVYyDZxxNGk/Y/jtI
         E419YyjMNRdD113vqEmaNgC1pk3Bxi0IF0UNT/6/j6URI/aJk0rg14B5rbDo3Z2pA4bw
         q75IuMIror5IWL6rU4b9t/ug0Y3OwfkBI8B5RRxSQj/gfuh4XnbsV997yVVXZiL7/GPI
         Yp+spj8iwIDibB+VgdXVCO3hFlU6wCkrfMI+sJaFWoiI50WWGiiKwdRzmFfs2r1sC8+j
         ph7A==
X-Gm-Message-State: ANhLgQ0gAEWdCqDfA7LFTIspR9+iOEOowxbg/G14Vl7mMAG0sL8Y3eqx
        oRSbwoCyNekPliX7d0tAFeHWxHlT
X-Google-Smtp-Source: ADFU+vsBNrx3qZGgKUul2SAgXNQL/V5EDeYBgCogrXc+QD75aVEy7rkiUVNdIGUoFVJ0tMXQDis9zQ==
X-Received: by 2002:a92:3b9c:: with SMTP id n28mr14405007ilh.53.1585323881480;
        Fri, 27 Mar 2020 08:44:41 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.googlemail.com with ESMTPSA id h70sm2021930ilf.8.2020.03.27.08.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:44:40 -0700 (PDT)
Message-ID: <4efff0ad2ddd1db5a5c067ce1d450edd1da46bbc.camel@gmail.com>
Subject: [GIT PULL] Please pull NFSoRDMA Client Updates for 5.7
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Fri, 27 Mar 2020 11:44:40 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

The following changes since commit fb33c6510d5595144d585aa194d377cf74d31911:

  Linux 5.6-rc6 (2020-03-15 15:01:23 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-rdma-for-5.7-1

for you to fetch changes up to e28ce90083f032ca0e8ea03478f5b6a38f5930f7:

  xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt (2020-03-27 10:47:25
-0400)

----------------------------------------------------------------
New Features:
- Allow one active connection and several zombie connections to prevent
  blocking if the remote server is unresponsive.

Bugfixes and Cleanups:
- Enhance MR-related trace points 
- Refactor connection set-up and disconnect functions
- Make Protection Domains per-connection instead of per-transport
- Merge struct rpcrdma_ia into rpcrdma_ep

Thanks,
Anna
----------------------------------------------------------------

Chuck Lever (12):
      xprtrdma: Enhance MR-related trace points
      xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
      xprtrdma: Refactor frwr_init_mr()
      xprtrdma: Clean up the post_send path
      xprtrdma: Refactor rpcrdma_ep_connect() and rpcrdma_ep_disconnect()
      xprtrdma: Allocate Protection Domain in rpcrdma_ep_create()
      xprtrdma: Invoke rpcrdma_ia_open in the connect worker
      xprtrdma: Remove rpcrdma_ia::ri_flags
      xprtrdma: Disconnect on flushed completion
      xprtrdma: Merge struct rpcrdma_ia into struct rpcrdma_ep
      xprtrdma: Extract sockaddr from struct rdma_cm_id
      xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt

 include/trace/events/rpcrdma.h    | 153 ++++++++++------------
 net/sunrpc/xprtrdma/backchannel.c |   8 +-
 net/sunrpc/xprtrdma/frwr_ops.c    | 152 +++++++++++-----------
 net/sunrpc/xprtrdma/rpc_rdma.c    |  32 ++---
 net/sunrpc/xprtrdma/transport.c   |  72 ++++-------
 net/sunrpc/xprtrdma/verbs.c       | 679 +++++++++++++++++++++++++++++++++++++
-------------------------------------------------------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |  89 +++++--------
 7 files changed, 473 insertions(+), 712 deletions(-)

