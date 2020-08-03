Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74EF23AB1B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHCQ75 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHCQ75 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 12:59:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F7C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 09:59:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c16so19895519ils.8
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9Mt7Wlzvt+mnSi3sYuDuCN21HjAwMDD1xblEj+GM9I=;
        b=Ky8GeWhOcyU8a19b8bBcZR4O9c1tefiP3iArXAoJmqTViEF4TKWAyvOIV3lChdfA+B
         s52KGZezSJFOllwLfmVnlyZkyfwnxmnaupKwiXH3eDblX0ViB6Qu/HC0wICny5+L6qLE
         ksPUiZxl5cdCex2pbqu/826d82ACm1SNFm19PMOcM9+YeEpwtsuCuqe5XpA8bNe5fV7c
         GIUUx0t91c+v2EgGw6uBOiVoG9xyMu2DOOIu1EE2RrdI4X4MwXoAZKQ6ntJhMYABckbZ
         9JqiINokqccd2vB/k3ltk4m8rR+wnD7NVw0q5OTwSg+eYAwmpv/cGmZz5HntGr9McNGg
         NEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=J9Mt7Wlzvt+mnSi3sYuDuCN21HjAwMDD1xblEj+GM9I=;
        b=dLKM+17QlXAHbVIxuwdxdZ5bebsLWWcTXnr5pUuDKPtr6yZwWhhM9V/QT4QtEQvaKb
         ZrWkd6XgvNRfbMvBHhNGC5cL4j3uwE8ScWkoZmV6DMTG6A9db+c7qfohrImGKjHvZH0u
         kj+Kykhu2umVMsCChMfghulv1wHaQdUazWYZfIGhbjBAsvA9D7cnPBEFNn5AUHQH3dzb
         Gy362v283knyMsngy1g7shDEK2idmNdkJEm5J551aKE4a1Fkmn1xefnv815wD7SUVx93
         hOgbgQfA+R7V/5H/gwsf+n4QAER9G3EmtB9EPw3yP8Jbjhfywr3W/xy/OY8KM4uWZ4eG
         EA1g==
X-Gm-Message-State: AOAM5308coDGaX+U5+bOCiKbNkbinu3pC/a7GUtP23cNiV99HnRns4X+
        FKHmBMdCr7D+KJYOACtJx68=
X-Google-Smtp-Source: ABdhPJz8hPkS8Q783GwEKdTcvcIxrIBHBJai5OTKgCnaxARcB1qMm4UMGVsDZPJevFiUkr8eGUUnZg==
X-Received: by 2002:a92:b311:: with SMTP id p17mr332200ilh.232.1596473996680;
        Mon, 03 Aug 2020 09:59:56 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id f20sm10794639ilj.62.2020.08.03.09.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:59:55 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 0/6] NFSD: Add support for the v4.2 READ_PLUS operation
Date:   Mon,  3 Aug 2020 12:59:48 -0400
Message-Id: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches add server support for the READ_PLUS operation, which
breaks read requests into several "data" and "hole" segments when
replying to the client.

Here are the results of some performance tests I ran on my own virtual
machines, which does still have the slow SEEK_HOLE/SEEK_DATA behavior.
A recent minimum-compiler-version patch makes installing newer kernels
difficult on the lab machines I have access to, but I'll still try to
collect that data since it seemed promising during my last posting
(https://www.spinics.net/lists/linux-nfs/msg76487.html).

I tested by reading various 2G files from a few different underlying
filesystems and across several NFS versions. I used the `vmtouch` utility
to make sure files were only cached when we wanted them to be. In addition
to 100% data and 100% hole cases, I also tested with files that alternate
between data and hole segments. These files have either 4K, 8K, 16K, or 32K
segment sizes and start with either data or hole segments. So the file
mixed-4d has a 4K segment size beginning with a data segment, but mixed-32h
has 32K segments beginning with a hole. The units are in seconds, with the
first number for each NFS version being the uncached read time and the second
number is for when the file is cached on the server.


          |         v3        |        v4.0       |        v4.1       |        v4.2       |
ext4      | uncached:  cached | uncached:  cached | uncached:  cached | uncached:  cached |
----------|-------------------|-------------------|-------------------|-------------------|
data      |   2.697 :   1.365 |   2.539 :   1.482 |   2.246 :   1.595 |   2.516 :   1.716 |
hole      |   2.389 :   1.480 |   1.692 :   1.444 |   1.904 :   1.539 |   1.042 :   1.005 |
mixed-4d  |   2.426 :   1.448 |   2.468 :   1.480 |   2.258 :   1.731 |   2.408 :   1.674 |
mixed-8d  |   2.446 :   1.592 |   2.497 :   1.523 |   2.240 :   1.736 |   2.179 :   1.547 |
mixed-16d |   2.608 :   1.575 |   2.446 :   1.582 |   2.330 :   1.670 |   2.192 :   1.488 |
mixed-32d |   2.544 :   1.587 |   2.164 :   1.499 |   2.076 :   1.452 |   1.982 :   1.346 |
mixed-4h  |   2.591 :   1.486 |   2.233 :   1.503 |   2.190 :   1.520 |   3.679 :   1.815 |
mixed-8h  |   2.498 :   1.547 |   2.168 :   1.510 |   2.098 :   1.511 |   2.815 :   1.484 |
mixed-16h |   2.480 :   1.664 |   2.152 :   1.597 |   2.096 :   1.537 |   2.288 :   1.580 |
mixed-32h |   2.520 :   1.467 |   2.171 :   1.496 |   2.246 :   1.593 |   2.066 :   1.389 |

          |         v3        |        v4.0       |        v4.1       |        v4.2       |
xfs       | uncached:  cached | uncached:  cached | uncached:  cached | uncached:  cached |
----------|-------------------|-------------------|-------------------|-------------------|
data      |   2.074 :   1.353 |   2.129 :   1.489 |   2.198 :   1.564 |   2.579 :   1.719 |
hole      |   1.714 :   1.430 |   1.647 :   1.440 |   1.748 :   1.464 |   1.019 :   1.028 |
mixed-4d  |   2.699 :   1.561 |   2.782 :   1.657 |   2.800 :   1.619 |   2.848 :   2.166 |
mixed-8d  |   2.204 :   1.540 |   2.346 :   1.595 |   2.356 :   1.589 |   2.335 :   1.809 |
mixed-16d |   2.034 :   1.445 |   2.212 :   1.561 |   2.172 :   1.546 |   2.127 :   1.658 |
mixed-32d |   1.982 :   1.480 |   2.135 :   1.544 |   2.136 :   1.565 |   2.024 :   1.555 |
mixed-4h  |   2.600 :   1.549 |   2.790 :   1.660 |   2.745 :   1.634 |   8.949 :   2.529 |
mixed-8h  |   2.283 :   1.555 |   2.414 :   1.605 |   2.373 :   1.607 |   5.626 :   2.015 |
mixed-16h |   2.115 :   1.512 |   2.247 :   1.593 |   2.217 :   1.608 |   3.740 :   1.803 |
mixed-32h |   2.069 :   1.499 |   2.212 :   1.582 |   2.235 :   1.631 |   2.819 :   1.542 |

          |         v3        |        v4.0       |        v4.1       |        v4.2       |
btrfs     | uncached:  cached | uncached:  cached | uncached:  cached | uncached:  cached |
----------|-------------------|-------------------|-------------------|-------------------|
data      |   2.417 :   1.317 |   2.095 :   1.445 |   2.145 :   1.523 |   2.615 :   1.713 |
hole      |   2.107 :   1.483 |   2.121 :   1.496 |   2.106 :   1.461 |   1.011 :   1.061 |
mixed-4d  |   2.348 :   1.471 |   2.370 :   1.523 |   2.379 :   1.499 |   3.028 : 225.812 |
mixed-8d  |   2.227 :   1.476 |   2.231 :   1.467 |   2.272 :   1.529 |   2.723 :  36.179 |
mixed-16d |   2.175 :   1.460 |   2.208 :   1.457 |   2.200 :   1.464 |   2.526 :  10.371 |
mixed-32d |   2.148 :   1.501 |   2.191 :   1.468 |   2.167 :   1.471 |   2.455 :   3.367 |
mixed-4h  |   2.362 :   1.561 |   2.387 :   1.513 |   2.352 :   1.536 |   5.935 :  41.494 |
mixed-8h  |   2.241 :   1.477 |   2.251 :   1.503 |   2.256 :   1.496 |   3.672 :  10.261 |
mixed-16h |   2.238 :   1.477 |   2.188 :   1.496 |   2.183 :   1.503 |   2.955 :   3.809 |
mixed-32h |   2.146 :   1.490 |   2.135 :   1.523 |   2.157 :   1.557 |   2.327 :   2.088 |

Anna Schumaker (6):
  SUNRPC: Implement xdr_reserve_space_vec()
  NFSD: nfsd4_encode_readv() can use xdr_reserve_space_vec()
  NFSD: Add READ_PLUS data support
  NFSD: Add READ_PLUS hole segment encoding
  NFSD: Return both a hole and a data segment
  NFSD: Encode a full READ_PLUS reply

 fs/nfsd/nfs4proc.c         |  17 ++++
 fs/nfsd/nfs4xdr.c          | 169 +++++++++++++++++++++++++++++++------
 include/linux/sunrpc/xdr.h |   2 +
 net/sunrpc/xdr.c           |  45 ++++++++++
 4 files changed, 206 insertions(+), 27 deletions(-)

-- 
2.27.0

