Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F12835BD
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfHFPv6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:51:58 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40124 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbfHFPv6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:51:58 -0400
Received: by mail-ot1-f41.google.com with SMTP id l15so36426944oth.7
        for <linux-nfs@vger.kernel.org>; Tue, 06 Aug 2019 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vm2vUI8KogLXMrBIrSHGRrDFogz2ZF1RxqXC80yMH2k=;
        b=p7Ea1NyRtcix81PWAl1FmrcJvvJuFZeuoyD+9KNqgEF1m7Nz6DvG+DgiG9aFbGBPBF
         6+KC6fFsSh9tbUDV/bs1AWWUmD7p1oIDkCIgpdz2T7DWyafr1oA2EmGNnIKCxbi5FAzP
         W3CE86Yp2sNgFsJIg+DgAwqz1lVOHgwo4e+EMyuvr6kpKEDuq67ApYFxcaijiKxFBNY8
         3altfedwhON96KXBsRTQ7eeYqFeKXGi9sGzYAd0j69Xi44v+DHSW64ih1sayou+SvFPX
         h3VJhrBLO8LygsR9tXrkSMAVp4eESCBBMOsIo9jRH5glaEfdjRycZ4PwRiHQZrMJuvMW
         4pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vm2vUI8KogLXMrBIrSHGRrDFogz2ZF1RxqXC80yMH2k=;
        b=KYXIhBw9+PTPmOegfRaO3S+Sl/T65M35/jeSV12jrrLp0QOyM9k1G48rfkKPkI77AX
         jAkY9C6fMdKWWdoYbaMfOynEVBYyLeWeotGG37IPhZhFr2z0zZaA+jSBu4zghIJxBlri
         BlEh3YvP4XUgISyRxHrV/CICKf86DWtXPG/4gUlGl24asDo5GIHWcMHajhVOeCxc6lVK
         MgG6mM1o1V8DNEFKnxGPbLYrbxnQaCRhGLMTBS584JQoWpRty11dhTv9fw58HjxDwb3H
         4n8gGUUbWb/Mt8uQKWpDIoiLUItv90FQnm2EF79IPAsPjpxRmUgtgXYRJvSIz9yDevK7
         jp8w==
X-Gm-Message-State: APjAAAW6LEhsjuCgpWzuWf2yOLM2DC6O18bGoHMOrk3iwrTHL/LbCDKF
        tLu1rtUM70hMqITYu50hx8lynTdY
X-Google-Smtp-Source: APXvYqwt0RYMo2XLTgiZnFhZZ9ZBU8iV0z5bs0O96obMH82HqW2ODLtMqxyAsgPui57hXrvcCsRFrQ==
X-Received: by 2002:a5d:80c3:: with SMTP id h3mr4559420ior.167.1565106717525;
        Tue, 06 Aug 2019 08:51:57 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e84sm96615894iof.39.2019.08.06.08.51.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:51:56 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FptCW011502
        for <linux-nfs@vger.kernel.org>; Tue, 6 Aug 2019 15:51:55 GMT
Subject: [PATCH v1 0/2] Two short subjects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:51:55 -0400
Message-ID: <20190806155055.9332.19343.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For review: Two patches for v5.4.

---

Chuck Lever (2):
      SUNRPC: Remove rpc_wake_up_queued_task_on_wq()
      SUNRPC: Inline xdr_commit_encode


 include/linux/sunrpc/sched.h |    3 ---
 net/sunrpc/sched.c           |   27 ++++-----------------------
 net/sunrpc/xdr.c             |    2 +-
 3 files changed, 5 insertions(+), 27 deletions(-)

--
Chuck Lever
