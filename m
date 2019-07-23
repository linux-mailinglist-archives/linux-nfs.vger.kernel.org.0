Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14D572002
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfGWTU1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 15:20:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40771 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732108AbfGWTU1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jul 2019 15:20:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id a186so28042598vsd.7;
        Tue, 23 Jul 2019 12:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PSOyLU99Qvriu6fd4r1ppjHclfYpOzpgO99xINeCfKI=;
        b=A51vcXjueHM1ZpPBT9gXODOed04QNtdYMKZl1f6ZWTKbFedM8+nffOg0ze4uPbfYtz
         9PnQrcVNmLmxemdgzfdaNXzkT7pwbwecT5ajIOk9PUkCMK9yuAQaaW6Y5xpoQdrrMMu/
         dap+g+RV3IPbcaweZq48bcbTk/sJFFbh3TvB76gZBw/gncCHrGnGSQUFCo9isDgeM0OK
         3UcIRkqYdQZcONawKIUJ3E8sqygSlNoy/0fo3GXa55rinwsi5FmvQC59JU3wLowKsiIu
         /m23Yazf86mpFAPY6UFCc8nkvseAvX9gIey3jFwEXumT3Fv37n2cFoz29cF1HAZTdF3+
         ZQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PSOyLU99Qvriu6fd4r1ppjHclfYpOzpgO99xINeCfKI=;
        b=HYWO/6+GSsJBNloZ4chmeF/MaqmETDH1OJ1ZPLZ+3b6fcJVDbB3VjFJGy+5eBn51PP
         EsiewIGVA5lFVgejfQs9huKk3yJ+jFC8MkNcoVzI1RymdKBzl+87umYqBmHNnAKY2yup
         7fGdG+Ek2fNP9wNHt/Lg/25VdrBhp21QJ5PKK1QnbHEZq9oRMw3tH2ZgIEbWEGJsITB2
         Kvi9tJQLAjjSgMuHR7uPTonc24OfjLvrpiGiFTK2obUiNnB7Oh0yz2vow5UQ4NbGadZH
         skjv5GiBVXOTo7FD7C2vkNJu20Ahp9g168mlGXRLQfg8jOTUPgX7Kg+Wc42d5eneu5dM
         dFaw==
X-Gm-Message-State: APjAAAW+IlgW+CY7qmPhIhLZKWJ0N+Qk0yHJ8MEAqM7Weqbpmmh2o+H8
        YHlBiMHejUDschWLazDfDYbjg+jLiZpDxQ==
X-Google-Smtp-Source: APXvYqwv4zsVjylE0zaFKPy5XFWkDSDEiwZTftUksKLuojtUB5cH5zNCX6t7oeauOJxXXqEDFj/YVA==
X-Received: by 2002:a05:6102:105a:: with SMTP id h26mr52778537vsq.185.1563909625619;
        Tue, 23 Jul 2019 12:20:25 -0700 (PDT)
Received: from seurat29.1015granger.net (dhcp-82c9.meeting.ietf.org. [31.133.130.201])
        by smtp.gmail.com with ESMTPSA id j11sm21498475vsd.0.2019.07.23.12.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 12:20:25 -0700 (PDT)
Subject: [PATCH v1 0/2] NFS/RDMA-related NFSD patches for -next
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 23 Jul 2019 15:20:03 -0400
Message-ID: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

Two server side patches for NFSD. Both are minor.

---

Chuck Lever (2):
      svcrdma: Remove svc_rdma_wq
      svcrdma: Use llist for managing cache of recv_ctxts


 include/linux/sunrpc/svc_rdma.h          |    6 +++---
 net/sunrpc/xprtrdma/svc_rdma.c           |    7 -------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   24 ++++++++++--------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 +++---
 4 files changed, 16 insertions(+), 27 deletions(-)

--
Chuck Lever
