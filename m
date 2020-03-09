Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36E117E232
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCIOGR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 10:06:17 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:37789 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgCIOGQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 10:06:16 -0400
Received: by mail-yw1-f52.google.com with SMTP id i1so5955652ywf.4
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2020 07:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=elkKzWO8ZcsnDykwUWOaOSzIzbH0N1sqk6H+9QOCdac=;
        b=oKJ1phC/FCfbQOiAT5KprrSkbS8iRGEYG+dT3zk/zqbz6c+8O9a7Dpj+z9XAiSY2AN
         YFXesjRBFeVDs486vP4JqgZV2c8Kv2eYKsztVlAr+vKy0uX6La7pic72zgIjGD5CVwzl
         Zo9AMguNVlPTj8PLgQVG5MXn9UaeLaNPNP8KDkcxIvEgHjZ/uxjMBU8nf2dKKnwgtQbt
         ApfofazUEl1jTVbfMl67gzZI5gxzPjCMfAH9l1kcS581H/UF/4mnkXqS0zTKXvaMIulI
         ro2/JV15adXlwFFHweYxJeSXUtTpem0cre4KCrgkXDQ4EUyN3XB+wv7uPJucmdC2qBxb
         ZUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=elkKzWO8ZcsnDykwUWOaOSzIzbH0N1sqk6H+9QOCdac=;
        b=BVOCHoL5Zc9prsBMI6Znygh6RVYC+ThAEzy3o5JHjX536ZL4+Wz3ZxD3Ix265f31NZ
         6u7arCiMEsSehGN9+Ot1YEMQ1eV+NvTmdMv+T6RpLcx+2ihd8uiclxk2jBCOUyn2dhSe
         OgSdi0BEfwM9jUXMKrrdeRzfOvlVI5NgoAPPLX3fBz+1MFndfiw/DAZEVOZOoqdKL85z
         ugOfaoY/17LvDZIplwI22d/X0nqbyW4ZEp9Tdpf7WDLwacr+0+PlTC+rYBg1qGnaVxyP
         ufAn/UBZeSwYMMsoiJ/oZZ20bX16Z5AJkFKpac5NfvaE4KxYTmdn6F8cX3LsnQNdZoLO
         rdZw==
X-Gm-Message-State: ANhLgQ2/qsR2JwVrADYuwemzoOb5LFOkTEZlZfo1+2DC0x5GtVmHAm6B
        c+zxAbIhc39aLwS/zOorsAZ8XN42VKY=
X-Google-Smtp-Source: ADFU+vtsoUk1Kf0BpYtNTydG813xesGR8S4Mg5TNP+E2TswH6RkXl5NBvhuOa1wgwHBnSdCF36bXnA==
X-Received: by 2002:a81:ad27:: with SMTP id l39mr4203898ywh.194.1583762774903;
        Mon, 09 Mar 2020 07:06:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b125sm6975628ywh.77.2020.03.09.07.06.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 07:06:14 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 029E6Dhk007530
        for <linux-nfs@vger.kernel.org>; Mon, 9 Mar 2020 14:06:13 GMT
Subject: [PATCH v2 0/3] Fix gss_unwrap_resp_integ() again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 09 Mar 2020 10:06:13 -0400
Message-ID: <20200309140301.2637.9696.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Changes since v1:
- Reviewed-by: Ben Coddington <bcodding@redhat.com>
- Revised patch description of PATCH 1/3
- Split out stack diet change into a separate patch

Turns out the gss routines are pretty hefty stack users. More work
needs to be done throughout. PATCH 3/3 is kind of a down payment.

---

Chuck Lever (3):
      sunrpc: Fix gss_unwrap_resp_integ() again
      SUNRPC: Remove xdr_buf_read_mic()
      SUNRPC: Trim stack utilization in the wrap and unwrap paths


 include/linux/sunrpc/xdr.h     |    1 
 net/sunrpc/auth_gss/auth_gss.c |   93 +++++++++++++++++++++++++++++-----------
 net/sunrpc/xdr.c               |   55 ------------------------
 3 files changed, 68 insertions(+), 81 deletions(-)

--
Chuck Lever
