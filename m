Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB1139656
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2020 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAMQ3X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jan 2020 11:29:23 -0500
Received: from smtpcmd0756.aruba.it ([62.149.156.56]:48394 "EHLO
        smtpcmd0756.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgAMQ3W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jan 2020 11:29:22 -0500
Received: from ubuntu.localdomain ([212.103.203.10])
        by smtpcmd07.ad.aruba.it with bizsmtp
        id psVJ210130DySFo01sVKxh; Mon, 13 Jan 2020 17:29:19 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     linux-nfs@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 0/3] bump rpcgen version and silence some warning
Date:   Mon, 13 Jan 2020 17:29:15 +0100
Message-Id: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578932959; bh=ymeyTt7GMy4Q2qChP2SrYQM98mBOccpba8MWDIDczs8=;
        h=From:To:Subject:Date:MIME-Version;
        b=Br6S9D9DbBIvhlmwYu2IbvTyVQ+SQC/Xc1znolsO1fMjNAvTVsibRuzZ9ftHM+1P2
         ykI+FLkElqxtOzWU1h9uX8mZIZVfpb6t/dnEO5b6dRo6E3TJRp/r76ywW6XK/m71Su
         Tb96lkuRax4nwIuL3vQcWR1JW4WjGS85WHa1OuTNYySmeog6h5sDs3i8HZD1ldu+Av
         oRYBvXaj55JPmEnTr9XCQcrviW7tPcOreBs252PaVmaaCYNCbXIuUVnLj0qNrP6gco
         XZcMoeeFN1YjSh4gWOZw4ZXCwNXOoWeCDKQMqoV7TC555ro68mxYkqc3ezLx0wJLCc
         nOymtZR+LLiog==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Giulio Benetti (3):
  rpcgen: bump to latest version
  rpcgen: rpc_cout: silence format-nonliteral
  support: nfs: rpc_socket: silence unused parameter warning on salen

 support/nfs/rpc_socket.c   |    2 +
 tools/rpcgen/Makefile.am   |   24 +-
 tools/rpcgen/proto.h       |   65 ++
 tools/rpcgen/rpc_clntout.c |  458 +++++---
 tools/rpcgen/rpc_cout.c    | 1269 ++++++++++++----------
 tools/rpcgen/rpc_hout.c    |  915 +++++++++-------
 tools/rpcgen/rpc_main.c    | 2083 +++++++++++++++++++++---------------
 tools/rpcgen/rpc_parse.c   | 1055 +++++++++---------
 tools/rpcgen/rpc_parse.h   |  103 +-
 tools/rpcgen/rpc_sample.c  |  465 ++++----
 tools/rpcgen/rpc_scan.c    |  812 +++++++-------
 tools/rpcgen/rpc_scan.h    |   91 +-
 tools/rpcgen/rpc_svcout.c  | 1647 +++++++++++++++-------------
 tools/rpcgen/rpc_tblout.c  |  265 ++---
 tools/rpcgen/rpc_util.c    |  656 ++++++------
 tools/rpcgen/rpc_util.h    |  170 ++-
 tools/rpcgen/rpcgen.1      |  442 ++++++++
 17 files changed, 6123 insertions(+), 4399 deletions(-)
 create mode 100644 tools/rpcgen/proto.h
 create mode 100644 tools/rpcgen/rpcgen.1

-- 
2.20.1

