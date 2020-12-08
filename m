Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75F72D341D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 21:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgLHUaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 15:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgLHUaI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 15:30:08 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F44C0613CF
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 12:29:27 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so17240993qkc.12
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 12:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZXC8/VPP9Pq/DZcBQVP+cXaIaJ5ZWC8Jybgc//VS4U=;
        b=ouhh7REWrH/gOLlaJ5txNZuW+Ps+36xRvPODyic2IV4wTm0arsQAVUONLVHs59wVdJ
         6TgdVU9/7sCWC5UnCx81l2xfvHkANjPWdCig0LohdT3GXE40gn4j2YvzqqtUjUyX3fjC
         BY+suz6gwwXT8drSIyGFJh+VwAsjvOrOPdFhItnTE8mhSkbHtsgCEVhMT6CUPyPvYRya
         1MPmjljilV1v+Xa8YLcVHR+b4yCswq0XOpvFuGdWBc7iMGKL+1l/LbpW3r6DgFITM/I3
         fshbvI78P8bwgH/64R/PsHtGoDv/OwnqCOq52C8emAS+q6IkRi1orL4PawVsLzqJODfQ
         Ahzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vZXC8/VPP9Pq/DZcBQVP+cXaIaJ5ZWC8Jybgc//VS4U=;
        b=sD6vJkRHGXLfJXIjRy4thd4mrv4OjApw+hyejsgW2AHKmLFsenmzEfihIEIMXnL/bN
         M9C/hlYEoLPIYsM9skeq/ygPud8As3qkKqxjZDj6gM6a5O67zyPn8FsBwYrVSa2ExDig
         2SFWEm8YSbFxYDxrai2nOsQiBDimqLqC50O8cBj/6Z0motAFeVo1MOOBXhP1UFCM5saB
         3YIcgcmT8YE7NAbw2RgJG28qSSfum2uaVgdXtNnVgCUuzdnUriDjE23RtIxe7kOdTGlp
         6LMvG/+nC5iGCM4HRfpTmRD0QtqDBYoYeikH4mN/n7RigW5xPCTC/bOlNHFz/eLSRjQ4
         Eb9Q==
X-Gm-Message-State: AOAM5317oCNfpXOrimOPC6gjIDM2q/4fnbQsNYVCkI7XolV44x9xVDTK
        6AZxHtBi1eX0Nz5R7PLvHe8i9bBp3o8=
X-Google-Smtp-Source: ABdhPJzTgL2PQVgRskgpzupoQRbCaW1nJJ5Xz20zqT5OBeLETRNKVjYLeLW7nE92c31By29RWHkbBA==
X-Received: by 2002:a37:a44e:: with SMTP id n75mr31882133qke.406.1607459366504;
        Tue, 08 Dec 2020 12:29:26 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q20sm5057278qkj.49.2020.12.08.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:29:25 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 0/2] Fixes for READ_PLUS
Date:   Tue,  8 Dec 2020 15:29:23 -0500
Message-Id: <20201208202925.597663-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches fix up hole and data segment decoding for READ_PLUS. It
turns out I wasn't handling data getting truncated off the end of the
message properly. These patches fix it up, and now xfstests generic/091
and generic/263 pass when run against servers exporting ext4 and btrfs.
These tests also pass against servers exporting xfs when the clone
operation is disabled, so it seems like there is something going on
inside the xfs filesystem causing these tests to still fail.

- Changes since v1:
  - Drop patch for allocating scratch page
  - Drop patch for disabling READ_PLUS behind a Kconfig option

Thanks,
Anna

Anna Schumaker (2):
  SUNRPC: Keep buf->len in sync with xdr->nwords when expanding holes
  SUNRPC: Check if the buffer has fewer bytes than requested

 net/sunrpc/xdr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.29.2

