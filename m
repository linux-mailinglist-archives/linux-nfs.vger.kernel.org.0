Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A00159E34
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 01:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgBLAmb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 19:42:31 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36186 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBLAmb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Feb 2020 19:42:31 -0500
Received: by mail-yw1-f67.google.com with SMTP id n184so291177ywc.3
        for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2020 16:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iMSjYhzXzueiRRiZRJ0/K7wWQ1ju/m8cEmLVXYoj/Iw=;
        b=cRGcB3oEfoOdkJ4MW9so9HIBislv/Vq8XT3VaQ4b1vOvjdNmY5XknL3vxxLN6KOEmj
         JOddMznRD9F0ItaeotAl2MwTreaH/6SS25BDDjLyGymtHGFWkEIhteSKt3GaEQNwVJxz
         NNyZ4bZRFM/gdRMJj2OymHwcq1Nk4q3of6BsSYTvH6OYQInKqChW3OhaAemoFCOp496w
         0G8epSpSBtCFlWiWJTkb9+zaV/rSXTQZ0Cr3cPNm2MdpY/7PZuIyOLQ+lhXRgP9Koncg
         WJIBeh82gzRjCPhRlm3hp3dxtCxF2FCylZdzB2csK/AmySvkbgnu/2RuVI5qSR8QufPL
         udGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iMSjYhzXzueiRRiZRJ0/K7wWQ1ju/m8cEmLVXYoj/Iw=;
        b=Uk6/VJ7JGk8OMUaOwW1bhMTZ/eyfXoRTxVNMCcmbdO4RJzHYmD+eeeCIR+L6Z4Wazj
         nHraGpM1p+JCexG53eUEFVFxDyUogXGkw8cavK/gGBFzI+OHsOsCrTrl7BpkEvsrhGR0
         NaI4HGi1oE0Gv0RmLrHroVdxTTpf79hzALTsOYjxvW46RRg6HSo4JVgtamQJrl+g3Woo
         vuVeL3qN67Y+iP7DdPRu9U+8P+M8lDQXb635RUAt6RQBnDzd6SIA1Hy/iF3IukvGWXB4
         6Pzc9iKmQX/9WFjERzckNf9PcK6qWPdi6KS5qzps9GD7PP8IOk5IT7mTJ7NIunOORK5J
         GOBw==
X-Gm-Message-State: APjAAAXKjGN8/vXHktBAGJafnCkKFCCEl8A4JzpJULe787OgG8xs1nnM
        dCRBJaDwkazYJGq2HLUe8zwDyoj4
X-Google-Smtp-Source: APXvYqzycxJOQ2WBIXSkJ1cC5Dt2Hf6xQ2C107sKKg8wyxMR1MkhavdknUx3x4i0Md32Qib+sbE2zQ==
X-Received: by 2002:a0d:caca:: with SMTP id m193mr7608677ywd.135.1581468150497;
        Tue, 11 Feb 2020 16:42:30 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g190sm2599708ywd.85.2020.02.11.16.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:42:29 -0800 (PST)
Subject: [PATCH RFC 0/3] Prepare NFS server for RPC-on-TLS
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 11 Feb 2020 19:42:28 -0500
Message-ID: <20200212003607.2305.38250.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following series implements changes to the Linux NFS server's
socket transport that are pre-requisite to supporting RPC on TLS.
The socket transport is made to use the iov_iter-based kernel
socket APIs. These changes are modeled after similar changes made
to the NFS client-side socket transport.

This is a draft patch series. I have tried it out and it is working,
but as it has changed only the Reply-send side, it is incomplete.
This posting is a request for comments -- show your work.

One additional change I might make in this series is moving the
xpt_mutex into the socket sendto methods. This is because the
RDMA sendto method doesn't appear to require serialization. That
is still down the road.


---

Chuck Lever (3):
      SUNRPC: Move xs_stream_record_marker
      SUNRPC: Refactor xs_sendpages()
      SUNRPC: Teach server to use xprt_sock_sendmsg for socket sends


 include/linux/sunrpc/msg_prot.h |   13 ++
 include/linux/sunrpc/svcauth.h  |    1 
 include/linux/sunrpc/xdr.h      |   14 ---
 net/sunrpc/socklib.c            |  136 ++++++++++++++++++++++++++
 net/sunrpc/socklib.h            |   15 +++
 net/sunrpc/sunrpc.h             |    4 -
 net/sunrpc/svc.c                |    4 -
 net/sunrpc/svcsock.c            |  203 +++++++++++++--------------------------
 net/sunrpc/xprtsock.c           |  203 ++++++---------------------------------
 9 files changed, 261 insertions(+), 332 deletions(-)
 create mode 100644 net/sunrpc/socklib.h

--
Chuck Lever
