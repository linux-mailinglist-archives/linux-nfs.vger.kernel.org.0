Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC8C09E4
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2019 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfI0Q4r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Sep 2019 12:56:47 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41266 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfI0Q4r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Sep 2019 12:56:47 -0400
Received: by mail-ed1-f50.google.com with SMTP id f20so2940224edv.8
        for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2019 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5lng3MIO0IKc5J7cr3o5FEgCasMoleup+2/psHM1EB4=;
        b=ZJPx2zbMsVcX3OyAzH4lpnRPUVI5I8itYotWqfUd6MOKuy5PWCeIz8FhKt80oe/12C
         hpbHmiUIMAEA8M1p4O7OtHY2aXqIPEvDmxX+FVgLmX3jqYU3o1NmQVBW14Yob6qkPsnv
         3Uq0RIO7OY02jzltXUlpZOQWzjPrk1wfaxw+76w334ViFH6T3T1mktTslUuj6k7nvwvX
         WWttg84GSvvdxNoN9htEdsy+7iDu+gydZU2IohFMgr3VevqEgJCfU7M63elFpC9fBz4c
         s15x+MRTQW+ihE5VbWzv/bPOjefktGhIsrdVAqP1GsSCgQJTaXPK5RgIBmNq0JuQTcXS
         xC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5lng3MIO0IKc5J7cr3o5FEgCasMoleup+2/psHM1EB4=;
        b=oTOnqRRZUo0FrlR2kg7Gl9joyKV2ckYEtP9zJXA0oPURImu/pvkW2vp7PlzSZuFcWg
         VltYc/DgARrmaqGPnDRuzcfJaADRuKD1rXcTG0XHh1NqtxRUL0DaVop0Qg/mL4H27SA0
         GJeAf8Gb+wRLWdmF/+7Vw2VA/LjMKxKTHoIePQp917+lcMLJ625OSC/FkxVVBdKsWXZb
         WwfsYFt8MNZprz2vFYSMBZVHH8e55NAs/Om4GzkPgxbccZDfnntGbFkmHtilpE8nefDx
         dDa/EFy0Uo2t+dhQfuDQDgbeVTYAZ0Lr1xETgJE0VfGVAoZeUEE/Q5ybqILadKnGPS2i
         yvlg==
X-Gm-Message-State: APjAAAUwAM2mbLlxVdLnwb4E0jkUG4NQM+/Ob+cpQnaMAI9Lw0HMGWWj
        FW19t3qcVTTIV8XCeJXERvYMbPOvAziDEPZVSChU2ga2NR8=
X-Google-Smtp-Source: APXvYqwEy7cP5J9LpmUG+deng2gBtSpvkE0S6vFokCUJ42FD6Decx1hDPdMwdtchJGCgRm3bSmYVSIsUsEU3UY2Q2ww=
X-Received: by 2002:a50:9734:: with SMTP id c49mr5727022edb.93.1569603405734;
 Fri, 27 Sep 2019 09:56:45 -0700 (PDT)
MIME-Version: 1.0
From:   Gefei Li <gefeili.2013@gmail.com>
Date:   Sat, 28 Sep 2019 00:56:34 +0800
Message-ID: <CANidX5SdiM3fZ+A1N_Z4iNhMU8KSvSHqwRXciyX32ZqDzLH32w@mail.gmail.com>
Subject: Did NFS client hang all OPEN request after SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED
 flag is set?
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Kernel NFS devs,

From RFC 5661, I know that the flag
SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED may be a "time-consuming" flag
for client, when received this flag, client needs to check all
existing lock/state.

   SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED
      When set, indicates that some subset of the client's locks have
      been revoked due to expiration of the lease period followed by
      another client's conflicting LOCK operation.  This status bit
      remains set on all SEQUENCE replies until the loss of all such
      locks has been acknowledged by use of FREE_STATEID.

My question is: when client received this flag, did it hang all
incoming "open" syscall on NFS files before the lock/state check
finished?

The problem I met is that my linux VM(with kernel 5.2.11) gives me a
really slow response(sometimes after an hour) after my NFS
traffic(which is heavy) runs for a while, I want to know the root
cause for this slow syscall, and from some packet trace I can get this
flag in some response of SEQUENCE response.

Appreciate your help and thanks in advance.

Thanks,
Gefei
